#import "TextureRenderer.h"
#import "AgoraRenderPerformanceMonitor.h"
#if defined(TARGET_OS_OSX) && TARGET_OS_OSX
#import "AgoraCVPixelBufferUtils.h"
#endif

#import <AgoraRtcKit/AgoraMediaBase.h>
#import <AgoraRtcKit/IAgoraMediaEngine.h>
#import <AgoraRtcWrapper/iris_rtc_rendering_cxx.h>
#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

#import <memory.h>
#import <stdio.h>

using namespace agora::iris;

static const float g_color601_full[9] = {
    1.0f, 1.0f, 1.0f,
    0.000000f, -0.344136f, 1.772000f,
    1.402000f, -0.714136f, 0.00000f
};

static const float g_color601_limit[9] = {
    1.164384f, 1.164384f, 1.164384f,
    0.000000f, -0.391762f, 2.017232f,
    1.596027f, -0.812968f, 0.000000f
};

static const float g_color709_full[9] = {
    1.0f, 1.0f, 1.0f,
    0.000000f, -0.187324f, 1.855600f,
    1.574800f, -0.468124f, 0.00000f
};

static const float g_color709_limit[9] = {
    1.164384f, 1.164384f, 1.164384f,
    0.000000f, -0.213249f, 2.112402f,
    1.792741f, -0.532909f, 0.000000f
};

static const float g_color2020_full[9] = {
    1.0f, 1.0f, 1.0f,
    0.000000f, -0.164553f, 1.881400f,
    1.474600f, -0.571353f, 0.00000f
};

static const float g_color2020_limit[9] = {
    1.167808f, 1.167808f, 1.167808f,
    0.000000f, -0.187877f, 2.148072f,
    1.683611f, -0.652337f, 0.000000f
};

static const char* kColorSpaceShaderSrc = R"(
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;

kernel void processYUVColorSpace(texture2d<float, access::read> yTexture [[texture(0)]],
                                texture2d<float, access::read> uvTexture [[texture(1)]],
                                texture2d<float, access::write> outputTexture [[texture(2)]],
                                constant float* colorMatrix [[buffer(0)]],
                                constant int& isFullRange [[buffer(1)]],
                                uint2 gid [[thread_position_in_grid]]) {
    
    if (gid.x >= yTexture.get_width() || gid.y >= yTexture.get_height()) {
        return;
    }
    
    // Read YUV data
    float y = yTexture.read(gid).r;
    float2 uv = uvTexture.read(gid / 2).rg;
    
    // Process YUV values according to GlGenericDrawer.java logic
    float3 yuv;
    if (isFullRange == 0) {
        yuv.x = clamp(y, 0.0, 1.0) - 0.0627; // 0.0627 = 16.0/255.0
        yuv.y = clamp(uv.x - 0.5, -0.5, 0.5);
        yuv.z = clamp(uv.y - 0.5, -0.5, 0.5);
    } else { // Full Range
        yuv.x = clamp(y, 0.0, 1.0);
        yuv.y = clamp(uv.x - 0.5, -0.5, 0.5);
        yuv.z = clamp(uv.y - 0.5, -0.5, 0.5);
    }
    
    // Use color matrix for YUV to RGB conversion
    float3x3 matrix = float3x3(
        float3(colorMatrix[0], colorMatrix[1], colorMatrix[2]),
        float3(colorMatrix[3], colorMatrix[4], colorMatrix[5]),
        float3(colorMatrix[6], colorMatrix[7], colorMatrix[8])
    );
    
    float3 rgb = matrix * yuv;
    rgb = clamp(rgb, 0.0, 1.0);
    
    // Output RGB directly (Metal handles format conversion to BGRA)
    outputTexture.write(float4(rgb.r, rgb.g, rgb.b, 1.0), gid);
}
)";

@interface TextureRender () <AgoraRenderPerformanceDelegate>

@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, strong) FlutterMethodChannel *channel;
@property(nonatomic, strong) FlutterMethodChannel *sharedMethodChannel;
@property(nonatomic) agora::iris::IrisRtcRendering *irisRtcRendering;
@property(nonatomic, assign) int delegateId;
@property(nonatomic, assign) unsigned int uid;  // Store uid for performance reporting
@property(nonatomic, assign) BOOL isDisposed;  // Flag to prevent duplicate cleanup

/// Tracks the latest pixel buffer sent from AVFoundation's sample buffer
/// delegate callback. Used to deliver the latest pixel buffer to the flutter
/// engine via the `copyPixelBuffer` API.
@property(readwrite, nonatomic) CVPixelBufferRef latestPixelBuffer;
/// The queue on which `latestPixelBuffer` property is accessed.
@property(strong, nonatomic) dispatch_queue_t pixelBufferSynchronizationQueue;

// Metal related properties
@property(nonatomic, strong) id<MTLDevice> metalDevice;
@property(nonatomic, strong) id<MTLCommandQueue> commandQueue;
@property(nonatomic, strong) id<MTLComputePipelineState> colorSpacePipelineState;
@property(nonatomic, strong) id<MTLBuffer> colorMatrixBuffer;
@property(nonatomic) CVMetalTextureCacheRef textureCache;

// Store current color space information
@property(nonatomic, assign) agora::media::base::ColorSpace currentColorSpace;
@property(nonatomic, assign) BOOL hasValidColorSpace;

// Cache for processed RGBA pixel buffer
@property(nonatomic) CVPixelBufferRef processedPixelBuffer;

// ColorSpace processing methods
- (void)setupColorSpaceProcessing;
- (const float*)getColorMatrixForColorSpace:(const agora::media::base::ColorSpace&)colorSpace;
- (CVPixelBufferRef _Nullable)processColorSpace:(CVPixelBufferRef)pixelBuffer 
                                      colorSpace:(const agora::media::base::ColorSpace&)colorSpace;
/// Performance monitor (optional, created only when enabled)
@property(nonatomic, strong) AgoraRenderPerformanceMonitor *performanceMonitor;

// Cleanup helper methods
- (void)_cleanupIrisRtcRendering;
- (void)_cleanupPixelBuffer;
- (void)_cleanupMetalResources;

@end

namespace {

class RendererDelegate : public std::enable_shared_from_this<RendererDelegate>,
                         public agora::iris::VideoFrameObserverDelegate {
public:
  RendererDelegate(void *renderer)
      : renderer_(((__bridge TextureRender *)renderer)), pre_width_(0),
        pre_height_(0) {}

  void OnVideoFrameReceived(const void *videoFrame,
                            const IrisRtcVideoFrameConfig &config,
                            bool resize) override {
    TextureRender *strongRenderer = renderer_;
    if (!strongRenderer) {
      return;
    }

    // Record frame received (timestamp captured internally)
    [strongRenderer.performanceMonitor recordFrameReceived];

    std::weak_ptr<RendererDelegate> self_weak = shared_from_this();

    agora::media::base::VideoFrame *vf =
        (agora::media::base::VideoFrame *)videoFrame;

    if (vf->width == 0 || vf->height == 0) {
      return;
    }

    CVPixelBufferRef _Nullable pixelBuffer =
        reinterpret_cast<CVPixelBufferRef>(vf->pixelBuffer);
    if (!pixelBuffer) {
      return;
    }

    // Apply color space to pixel buffer if provided
    // NSLog(@"OnVideoFrameReceived: frame=%dx%d, format=%u, colorSpace.validate=%d", 
        //   vf->width, vf->height, CVPixelBufferGetPixelFormatType(pixelBuffer), vf->colorSpace.validate());
    
    // Store color space information, process when Flutter retrieves it
    if (vf->colorSpace.validate()) {
        strongRenderer.currentColorSpace = vf->colorSpace;
        strongRenderer.hasValidColorSpace = YES;
        // NSLog(@"Stored color space for deferred processing: Matrix:%d, Range:%d", 
            //   vf->colorSpace.matrix, vf->colorSpace.range);
    } else {
        strongRenderer.hasValidColorSpace = NO;
        // NSLog(@"No valid color space received");
    }
   
    if (pre_width_ != vf->width || pre_height_ != vf->height) {
      pre_width_ = vf->width;
      pre_height_ = vf->height;

      // notify size changed on main thread, to avoid data race, we need to
      // copy the width and height to local variables.
      int temp_width = vf->width;
      int temp_height = vf->height;

      dispatch_async(dispatch_get_main_queue(), ^{
        std::shared_ptr<RendererDelegate> self_strong = self_weak.lock();
        if (!self_strong) {
          return;
        }

        TextureRender *strongRenderer = self_strong->renderer_;
        if (!strongRenderer) {
          return;
        }
        [strongRenderer.channel invokeMethod:@"onSizeChanged"
                                   arguments:@{
                                     @"width" : @(temp_width),
                                     @"height" : @(temp_height)
                                   }];
      });
    }

    __block CVPixelBufferRef previousPixelBuffer = nil;
    dispatch_sync(strongRenderer.pixelBufferSynchronizationQueue, ^{
      previousPixelBuffer = strongRenderer.latestPixelBuffer;
#if defined(TARGET_OS_OSX) && TARGET_OS_OSX
    //   NSLog(@"macOS: Copying CVPixelBuffer with attachments...");
      strongRenderer.latestPixelBuffer =
          [AgoraCVPixelBufferUtils copyCVPixelBuffer:pixelBuffer];
#else
    //   NSLog(@"iOS: Retaining original CVPixelBuffer...");
      strongRenderer.latestPixelBuffer = CVPixelBufferRetain(pixelBuffer);
#endif
    });
    
    if (previousPixelBuffer) {
      CVPixelBufferRelease(previousPixelBuffer);
    }

    // notify new frame available on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
      std::shared_ptr<RendererDelegate> self_strong = self_weak.lock();
      if (!self_strong) {
        return;
      }

      TextureRender *strongRenderer = self_strong->renderer_;
      if (!strongRenderer) {
        return;
      }
      [strongRenderer.performanceMonitor recordFrameRenderedInterval];
      [strongRenderer.textureRegistry
          textureFrameAvailable:strongRenderer.textureId];
    });
  }

public:
  __weak TextureRender *renderer_;
  int pre_width_;
  int pre_height_;
};
} // namespace

@interface TextureRender ()

@property(nonatomic) std::shared_ptr<RendererDelegate> delegate;

@end

@implementation TextureRender

- (instancetype)initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                              messenger:(NSObject<FlutterBinaryMessenger> *)messenger
                          methodChannel:(FlutterMethodChannel *)methodChannel
                 irisRtcRenderingHandle:(void *)irisRtcRenderingHandle
                    enableArgusCounters:(BOOL)enableArgusCounters{
    self = [super init];
    if (self) {
        self.textureRegistry = textureRegistry;
        self.sharedMethodChannel = methodChannel;
        self.irisRtcRendering =
        (agora::iris::IrisRtcRendering *)irisRtcRenderingHandle;
        self.textureId = [self.textureRegistry registerTexture:self];
        self.channel = [FlutterMethodChannel
        methodChannelWithName:
            [NSString stringWithFormat:@"agora_rtc_engine/texture_render_%lld",
                                       self.textureId]
              binaryMessenger:messenger];

    self.delegate = std::make_shared< ::RendererDelegate>((__bridge void *)self);
    self.latestPixelBuffer = nil;
    self.pixelBufferSynchronizationQueue = dispatch_queue_create(
        [[NSString stringWithFormat:@"io.agora.flutter.render_%lld", _textureId]
            UTF8String],
        nil);
    
    // Initialize color space state
    self.hasValidColorSpace = NO;
    memset(&_currentColorSpace, 0, sizeof(_currentColorSpace));
    [self setupColorSpaceProcessing];
    // Initialize performance monitor (only if enabled to save resources)
    if (enableArgusCounters) {
        self.performanceMonitor = [[AgoraRenderPerformanceMonitor alloc] init];
        self.performanceMonitor.enabled = YES;
        self.performanceMonitor.delegate = self;
    }
    // Initialize dispose flag
    self.isDisposed = NO;
  }
  return self;
}

- (void)updateData:(NSNumber *)uid
            channelId:(NSString *)channelId
      videoSourceType:(NSNumber *)videoSourceType
   videoViewSetupMode:(NSNumber *)videoViewSetupMode {
  
  // Store uid for performance reporting
  self.uid = [uid unsignedIntValue];
  
  IrisRtcVideoFrameConfig config;
  config.video_frame_format =
      agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_CVPIXEL_NV12;
  config.uid = self.uid;
  config.video_source_type = [videoSourceType intValue];
  if (channelId && (NSNull *)channelId != [NSNull null]) {
    strcpy(config.channelId, [channelId UTF8String]);
  } else {
    strcpy(config.channelId, "");
  }
  config.video_view_setup_mode = [videoViewSetupMode intValue];
  config.observed_frame_position =
      agora::media::base::VIDEO_MODULE_POSITION::POSITION_POST_CAPTURER |
      agora::media::base::VIDEO_MODULE_POSITION::POSITION_PRE_RENDERER;

  self.delegateId = self.irisRtcRendering->AddVideoFrameObserverDelegate(
      config, self.delegate.get());
}

- (CVPixelBufferRef _Nullable)copyPixelBuffer {
  __block CVPixelBufferRef pixelBuffer = nil;
  
  // Use `dispatch_sync` because `copyPixelBuffer` API requires synchronous
  // return.
  dispatch_sync(self.pixelBufferSynchronizationQueue, ^{
    // No need weak self because it's dispatch_sync.
    pixelBuffer = self.latestPixelBuffer;
    self.latestPixelBuffer = nil;
  });
  
  if (!pixelBuffer) {
    return nil;
  }
  
  // Apply color space as CVPixelBuffer attachment
  if (self.hasValidColorSpace) {
    CFStringRef colorPrimaries = NULL;
    CFStringRef transferFunction = NULL;
    CFStringRef ycbcrMatrix = NULL;
    
    // Set color primaries and transfer function based on matrix
    switch (self.currentColorSpace.matrix) {
      case agora::media::base::ColorSpace::MATRIXID_BT709:
        colorPrimaries = kCVImageBufferColorPrimaries_ITU_R_709_2;
        transferFunction = kCVImageBufferTransferFunction_ITU_R_709_2;
        ycbcrMatrix = kCVImageBufferYCbCrMatrix_ITU_R_709_2;
        break;
      case agora::media::base::ColorSpace::MATRIXID_BT2020_NCL:
      case agora::media::base::ColorSpace::MATRIXID_BT2020_CL:
        colorPrimaries = kCVImageBufferColorPrimaries_ITU_R_2020;
        transferFunction = kCVImageBufferTransferFunction_ITU_R_2020;
        ycbcrMatrix = kCVImageBufferYCbCrMatrix_ITU_R_2020;
        break;
      case agora::media::base::ColorSpace::MATRIXID_SMPTE170M:
      case agora::media::base::ColorSpace::MATRIXID_BT470BG:
      default:
        colorPrimaries = kCVImageBufferColorPrimaries_SMPTE_C;
        transferFunction = kCVImageBufferTransferFunction_ITU_R_709_2;
        ycbcrMatrix = kCVImageBufferYCbCrMatrix_ITU_R_601_4;
        break;
    }
    
    // Attach color space metadata
    CVBufferSetAttachment(pixelBuffer, kCVImageBufferColorPrimariesKey, colorPrimaries, kCVAttachmentMode_ShouldPropagate);
    CVBufferSetAttachment(pixelBuffer, kCVImageBufferTransferFunctionKey, transferFunction, kCVAttachmentMode_ShouldPropagate);
    CVBufferSetAttachment(pixelBuffer, kCVImageBufferYCbCrMatrixKey, ycbcrMatrix, kCVAttachmentMode_ShouldPropagate);
  }
  
  // Record render draw cost
  if (pixelBuffer) {
    [self.performanceMonitor recordRenderDrawCost];
  }
  
  return pixelBuffer;
}

- (void)dispose {
  // Prevent duplicate cleanup
  if (self.isDisposed) {
    return;
  }
  self.isDisposed = YES;
  
  // Clean up irisRtcRendering and delegate
  [self _cleanupIrisRtcRendering];
  
  if (self.textureRegistry) {
    [self.textureRegistry unregisterTexture:self.textureId];
    self.textureRegistry = nil;
  }
  
  // Clean up performance monitor
  self.performanceMonitor.delegate = nil;
  self.performanceMonitor = nil;
}

#pragma mark - AgoraRenderPerformanceDelegate
//
//- (void)onPerformanceStatsUpdated:(AgoraRenderPerformanceStats *)stats {
//  if (!self.sharedMethodChannel) {
//    return;
//  }
//  
//  // Send performance stats to Flutter layer via shared channel
//  NSMutableDictionary *statsDict = [[stats toDictionary] mutableCopy];
//  statsDict[@"textureId"] = @(self.textureId);
//  statsDict[@"uid"] = @(self.uid);  // Add uid to distinguish local/remote
//  [self.sharedMethodChannel invokeMethod:@"onVideoRenderingPerformance"
//                         arguments:statsDict];
//}

- (void)onRawFrameStats:(NSDictionary *)rawStats {
    if (!self.sharedMethodChannel) {
        return;
    }
    
    NSMutableDictionary *statsDict = [rawStats mutableCopy];
    statsDict[@"textureId"] = @(self.textureId);
    statsDict[@"uid"] = @(self.uid);  // Add uid to distinguish local/remote
    [self.sharedMethodChannel invokeMethod:@"onVideoRenderingPerformance"
                                 arguments:statsDict];
}

#pragma mark - ColorSpace Processing

- (void)setupColorSpaceProcessing {
    // Initialize Metal device
    self.metalDevice = MTLCreateSystemDefaultDevice();
    if (!self.metalDevice) {
        // NSLog(@"Metal is not supported on this device");
        return;
    }

    self.commandQueue = [self.metalDevice newCommandQueue];
    
    // Create texture cache
    CVReturn result = CVMetalTextureCacheCreate(
        kCFAllocatorDefault, NULL, self.metalDevice, NULL, &_textureCache);
    if (result != kCVReturnSuccess) {
        // NSLog(@"Failed to create Metal texture cache: %d", result);
        return;
    }
    
    // Compile Metal Compute Shader
    NSError *error = nil;
    id<MTLLibrary> library = [self.metalDevice newLibraryWithSource:
        [NSString stringWithUTF8String:kColorSpaceShaderSrc]
        options:nil
        error:&error];
    if (!library) {
        // NSLog(@"Failed to create shader library: %@", error);
        return;
    }
    
    id<MTLFunction> function = [library newFunctionWithName:@"processYUVColorSpace"];
    if (!function) {
        // NSLog(@"Failed to create shader function");
        return;
    }
    
    self.colorSpacePipelineState = [self.metalDevice 
        newComputePipelineStateWithFunction:function error:&error];
    if (!self.colorSpacePipelineState) {
        // NSLog(@"Failed to create pipeline state: %@", error);
        return;
    }
    
    // Create color matrix buffer
    self.colorMatrixBuffer = [self.metalDevice newBufferWithLength:sizeof(float) * 9 
                                                          options:MTLResourceStorageModeShared];
    
    // NSLog(@"Metal ColorSpace shader setup completed");
}

- (const float*)getColorMatrixForColorSpace:(const agora::media::base::ColorSpace&)colorSpace {
    // Fully reference GlGenericDrawer.java matrix selection logic
    BOOL isFullRange = (colorSpace.range == agora::media::base::ColorSpace::RANGEID_FULL);
    
    switch (colorSpace.matrix) {
        case agora::media::base::ColorSpace::MATRIXID_BT709:
            // NSLog(@"Using BT.709 matrix");
            return isFullRange ? g_color709_full : g_color709_limit;
            
        case agora::media::base::ColorSpace::MATRIXID_BT2020_NCL:
        case agora::media::base::ColorSpace::MATRIXID_BT2020_CL:
            // NSLog(@"Using BT.2020 matrix - Full range as per Android");
            return g_color2020_full;
            
        case agora::media::base::ColorSpace::MATRIXID_SMPTE170M:
        case agora::media::base::ColorSpace::MATRIXID_BT470BG:
        default:
            // NSLog(@"Using BT.601/SMPTE170M matrix");
            return isFullRange ? g_color601_full : g_color601_limit;
    }
}

- (CVPixelBufferRef _Nullable)processColorSpace:(CVPixelBufferRef)pixelBuffer 
                                      colorSpace:(const agora::media::base::ColorSpace&)colorSpace {
    
    if (!pixelBuffer || !self.metalDevice || !self.colorSpacePipelineState) {
        return CVPixelBufferRetain(pixelBuffer); // Retain and return original
    }
    
    OSType pixelFormat = CVPixelBufferGetPixelFormatType(pixelBuffer);
    
    // Only process YUV format
    if (pixelFormat != kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange &&
        pixelFormat != kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
        // NSLog(@"Unsupported pixel format for color space processing: %u", pixelFormat);
        return CVPixelBufferRetain(pixelBuffer); // Retain and return original
    }
    
    // Get appropriate color matrix
    const float* matrix = [self getColorMatrixForColorSpace:colorSpace];
    
    // Copy matrix to Metal buffer
    memcpy([self.colorMatrixBuffer contents], matrix, sizeof(float) * 9);
    
    @autoreleasepool {
        size_t width = CVPixelBufferGetWidth(pixelBuffer);
        size_t height = CVPixelBufferGetHeight(pixelBuffer);
        
        // Create Metal textures from source YUV buffer
        CVMetalTextureRef yTextureRef = NULL;
        CVMetalTextureRef uvTextureRef = NULL;
        
        CVReturn result = CVMetalTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault, self.textureCache, pixelBuffer, NULL,
            MTLPixelFormatR8Unorm, width, height, 0, &yTextureRef);
        
        if (result != kCVReturnSuccess || !yTextureRef) {
            // NSLog(@"Failed to create Y texture: %d", result);
            return CVPixelBufferRetain(pixelBuffer);
        }
        
        result = CVMetalTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault, self.textureCache, pixelBuffer, NULL,
            MTLPixelFormatRG8Unorm, width/2, height/2, 1, &uvTextureRef);
        
        if (result != kCVReturnSuccess || !uvTextureRef) {
            // NSLog(@"Failed to create UV texture: %d", result);
            CFRelease(yTextureRef);
            return CVPixelBufferRetain(pixelBuffer);
        }
        
        id<MTLTexture> yTexture = CVMetalTextureGetTexture(yTextureRef);
        id<MTLTexture> uvTexture = CVMetalTextureGetTexture(uvTextureRef);
        
        // Create RGBA CVPixelBuffer as output (NOT converting back to YUV!)
        CVPixelBufferRef rgbaPixelBuffer = NULL;
        NSDictionary *pixelBufferAttributes = @{
            (id)kCVPixelBufferIOSurfacePropertiesKey: @{},
            (id)kCVPixelBufferMetalCompatibilityKey: @YES
        };
        
        result = CVPixelBufferCreate(kCFAllocatorDefault, width, height,
                                    kCVPixelFormatType_32BGRA,
                                    (__bridge CFDictionaryRef)pixelBufferAttributes,
                                    &rgbaPixelBuffer);
        
        if (result != kCVReturnSuccess || !rgbaPixelBuffer) {
            // NSLog(@"Failed to create RGBA pixel buffer: %d", result);
            CFRelease(yTextureRef);
            CFRelease(uvTextureRef);
            return CVPixelBufferRetain(pixelBuffer);
        }
        
        // Create Metal texture from RGBA pixel buffer
        CVMetalTextureRef rgbaTextureRef = NULL;
        result = CVMetalTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault, self.textureCache, rgbaPixelBuffer, NULL,
            MTLPixelFormatBGRA8Unorm, width, height, 0, &rgbaTextureRef);
        
        if (result != kCVReturnSuccess || !rgbaTextureRef) {
            // NSLog(@"Failed to create RGBA texture: %d", result);
            CFRelease(yTextureRef);
            CFRelease(uvTextureRef);
            CVPixelBufferRelease(rgbaPixelBuffer);
            return CVPixelBufferRetain(pixelBuffer);
        }
        
        id<MTLTexture> rgbaTexture = CVMetalTextureGetTexture(rgbaTextureRef);
        
        // Prepare range parameter
        int isFullRange = (colorSpace.range == agora::media::base::ColorSpace::RANGEID_FULL) ? 1 : 0;
        id<MTLBuffer> rangeBuffer = [self.metalDevice newBufferWithBytes:&isFullRange 
                                                                 length:sizeof(int)
                                                                options:MTLResourceStorageModeShared];
        
        // Execute compute shader: YUV -> RGBA with correct color space
        id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
        id<MTLComputeCommandEncoder> computeEncoder = [commandBuffer computeCommandEncoder];
        
        [computeEncoder setComputePipelineState:self.colorSpacePipelineState];
        [computeEncoder setTexture:yTexture atIndex:0];
        [computeEncoder setTexture:uvTexture atIndex:1];
        [computeEncoder setTexture:rgbaTexture atIndex:2];
        [computeEncoder setBuffer:self.colorMatrixBuffer offset:0 atIndex:0];
        [computeEncoder setBuffer:rangeBuffer offset:0 atIndex:1];
        
        MTLSize threadgroupSize = MTLSizeMake(16, 16, 1);
        MTLSize threadgroups = MTLSizeMake(
            (width + threadgroupSize.width - 1) / threadgroupSize.width,
            (height + threadgroupSize.height - 1) / threadgroupSize.height, 1);
        
        [computeEncoder dispatchThreadgroups:threadgroups threadsPerThreadgroup:threadgroupSize];
        [computeEncoder endEncoding];
        
        [commandBuffer commit];
        [commandBuffer waitUntilCompleted];
        
        // Cleanup Metal textures
        CFRelease(yTextureRef);
        CFRelease(uvTextureRef);
        CFRelease(rgbaTextureRef);
        
        // NSLog(@"Applied ColorSpace transform - Matrix:%d, Range:%d (%s), returning RGBA buffer", 
            //   colorSpace.matrix, colorSpace.range, 
            //   (colorSpace.range == agora::media::base::ColorSpace::RANGEID_FULL) ? "Full" : "Limited");
        
        // Return the RGBA buffer directly (already retained by CVPixelBufferCreate)
        return rgbaPixelBuffer;
    }
}

// This method is no longer needed - we return RGBA buffer directly

- (void)dealloc {
    // If dispose was already called, only clean up resources that weren't handled in dispose
    if (!self.isDisposed) {
        // Clean up irisRtcRendering and delegate if dispose wasn't called
        [self _cleanupIrisRtcRendering];
    }
    
    // Always clean up pixel buffer and Metal resources
    [self _cleanupPixelBuffer];
    [self _cleanupMetalResources];
}

#pragma mark - Cleanup Helpers

- (void)_cleanupIrisRtcRendering {
    // First, clear delegate to prevent new callbacks
    if (self.delegate) {
        self.delegate.reset();
        self.delegate = nullptr;
    }
    
    // Use local variables to avoid race conditions
    // Save pointer and ID before clearing the property
    agora::iris::IrisRtcRendering *rendering = self.irisRtcRendering;
    int delegateId = self.delegateId;
    
    // Immediately clear the property to prevent other threads from accessing it
    self.irisRtcRendering = nil;
    
    // Now use local variables - even if object was freed, at least we won't call twice
    if (rendering != nullptr && delegateId >= 0) {
        @try {
            // the delegateId is garenteed to be auto incremented, so we can just remove
            // the delegate by the id, no need to check if the delegate is still valid
            // or is belong to this TextureRender
            rendering->RemoveVideoFrameObserverDelegate(delegateId);
        } @catch (NSException *exception) {
            //  NSLog(@"Error removing video frame observer delegate: %@", exception);
        } @catch (...) {
            //  NSLog(@"Unknown C++ exception when removing video frame observer delegate");
        }
    }
}

- (void)_cleanupPixelBuffer {
    dispatch_sync(self.pixelBufferSynchronizationQueue, ^{
        if (self.latestPixelBuffer) {
            CVPixelBufferRelease(self.latestPixelBuffer);
            self.latestPixelBuffer = nil;
        }
    });
}

- (void)_cleanupMetalResources {
    // Clean up Metal texture cache
    if (self.textureCache) {
        CVMetalTextureCacheFlush(self.textureCache, 0);
        CFRelease(self.textureCache);
        self.textureCache = NULL;
    }
    
    // Metal objects are automatically released (ARC)
    self.metalDevice = nil;
    self.commandQueue = nil;
    self.colorSpacePipelineState = nil;
    self.colorMatrixBuffer = nil;
}

@end
