#import "TextureRenderer.h"
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
    
    // Output as RGBA
    outputTexture.write(float4(rgb, 1.0), gid);
}
)";

@interface TextureRender ()

@property(nonatomic, weak) NSObject<FlutterTextureRegistry> *textureRegistry;
@property(nonatomic, strong) FlutterMethodChannel *channel;
@property(nonatomic) agora::iris::IrisRtcRendering *irisRtcRendering;
@property(nonatomic, assign) int delegateId;

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

// ColorSpace processing methods
- (void)setupColorSpaceProcessing;
- (const float*)getColorMatrixForColorSpace:(const agora::media::base::ColorSpace&)colorSpace;
- (void)processColorSpace:(CVPixelBufferRef)pixelBuffer 
                colorSpace:(const agora::media::base::ColorSpace&)colorSpace;

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
    NSLog(@"OnVideoFrameReceived: frame=%dx%d, format=%u, colorSpace.validate=%d", 
          vf->width, vf->height, CVPixelBufferGetPixelFormatType(pixelBuffer), vf->colorSpace.validate());
    
    // Store color space information, process when Flutter retrieves it
    if (vf->colorSpace.validate()) {
        strongRenderer.currentColorSpace = vf->colorSpace;
        strongRenderer.hasValidColorSpace = YES;
        NSLog(@"Stored color space for deferred processing: Matrix:%d, Range:%d", 
              vf->colorSpace.matrix, vf->colorSpace.range);
    } else {
        strongRenderer.hasValidColorSpace = NO;
        NSLog(@"No valid color space received");
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
      NSLog(@"macOS: Copying CVPixelBuffer with attachments...");
      strongRenderer.latestPixelBuffer =
          [AgoraCVPixelBufferUtils copyCVPixelBuffer:pixelBuffer];
#else
      NSLog(@"iOS: Retaining original CVPixelBuffer...");
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

- (instancetype)
    initWithTextureRegistry:(NSObject<FlutterTextureRegistry> *)textureRegistry
                  messenger:(NSObject<FlutterBinaryMessenger> *)messenger
     irisRtcRenderingHandle:(void *)irisRtcRenderingHandle {
  self = [super init];
  if (self) {
    self.textureRegistry = textureRegistry;
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
  }
  return self;
}

- (void)updateData:(NSNumber *)uid
             channelId:(NSString *)channelId
       videoSourceType:(NSNumber *)videoSourceType
    videoViewSetupMode:(NSNumber *)videoViewSetupMode {
  IrisRtcVideoFrameConfig config;
  config.video_frame_format =
      agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_CVPIXEL_NV12;
  config.uid = [uid unsignedIntValue];
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
  
  // Key: Apply color space processing before returning to Flutter
  if (pixelBuffer && self.hasValidColorSpace) {
    NSLog(@"Applying Metal ColorSpace transform - Matrix:%d, Range:%d", 
          self.currentColorSpace.matrix, self.currentColorSpace.range);
    
    [self processColorSpace:pixelBuffer colorSpace:self.currentColorSpace];
  } else if (pixelBuffer) {
    NSLog(@"Flutter requesting pixelBuffer but no valid color space");
  } else {
    NSLog(@"No pixelBuffer available for Flutter Engine");
  }
  
  NSLog(@"Returning pixelBuffer to Flutter Engine");
  
  return pixelBuffer;
}

- (void)dispose {
  if (self.irisRtcRendering) {
    self.irisRtcRendering->RemoveVideoFrameObserverDelegate(self.delegateId);
    self.irisRtcRendering = nil;
  }
  if (self.delegate) {
    self.delegate.reset();
  }
  if (self.textureRegistry) {
    [self.textureRegistry unregisterTexture:self.textureId];
    self.textureRegistry = nil;
  }
}

#pragma mark - ColorSpace Processing

- (void)setupColorSpaceProcessing {
    // Initialize Metal device
    self.metalDevice = MTLCreateSystemDefaultDevice();
    if (!self.metalDevice) {
        NSLog(@"Metal is not supported on this device");
        return;
    }

    self.commandQueue = [self.metalDevice newCommandQueue];
    
    // Create texture cache
    CVReturn result = CVMetalTextureCacheCreate(
        kCFAllocatorDefault, NULL, self.metalDevice, NULL, &_textureCache);
    if (result != kCVReturnSuccess) {
        NSLog(@"Failed to create Metal texture cache: %d", result);
        return;
    }
    
    // Compile Metal Compute Shader
    NSError *error = nil;
    id<MTLLibrary> library = [self.metalDevice newLibraryWithSource:
        [NSString stringWithUTF8String:kColorSpaceShaderSrc]
        options:nil
        error:&error];
    if (!library) {
        NSLog(@"Failed to create shader library: %@", error);
        return;
    }
    
    id<MTLFunction> function = [library newFunctionWithName:@"processYUVColorSpace"];
    if (!function) {
        NSLog(@"Failed to create shader function");
        return;
    }
    
    self.colorSpacePipelineState = [self.metalDevice 
        newComputePipelineStateWithFunction:function error:&error];
    if (!self.colorSpacePipelineState) {
        NSLog(@"Failed to create pipeline state: %@", error);
        return;
    }
    
    // Create color matrix buffer
    self.colorMatrixBuffer = [self.metalDevice newBufferWithLength:sizeof(float) * 9 
                                                          options:MTLResourceStorageModeShared];
    
    NSLog(@"Metal ColorSpace shader setup completed");
}

- (const float*)getColorMatrixForColorSpace:(const agora::media::base::ColorSpace&)colorSpace {
    // Fully reference GlGenericDrawer.java matrix selection logic
    BOOL isFullRange = (colorSpace.range == agora::media::base::ColorSpace::RANGEID_FULL);
    
    switch (colorSpace.matrix) {
        case agora::media::base::ColorSpace::MATRIXID_BT709:
            NSLog(@"Using BT.709 matrix (%s range)", isFullRange ? "Full" : "Limited");
            return isFullRange ? g_color709_full : g_color709_limit;
            
        case agora::media::base::ColorSpace::MATRIXID_BT2020_NCL:
        case agora::media::base::ColorSpace::MATRIXID_BT2020_CL:
            NSLog(@"Using BT.2020 matrix (Full range - as per Android)");
            return g_color2020_full;
            
        case agora::media::base::ColorSpace::MATRIXID_SMPTE170M:
        case agora::media::base::ColorSpace::MATRIXID_BT470BG:
        default:
            NSLog(@"Using BT.601/SMPTE170M matrix (%s range)", isFullRange ? "Full" : "Limited");
            return isFullRange ? g_color601_full : g_color601_limit;
    }
}

- (void)processColorSpace:(CVPixelBufferRef)pixelBuffer 
                colorSpace:(const agora::media::base::ColorSpace&)colorSpace {
    
    if (!pixelBuffer || !self.metalDevice || !self.colorSpacePipelineState) {
        return;
    }
    
    OSType pixelFormat = CVPixelBufferGetPixelFormatType(pixelBuffer);
    
    // Only process YUV format
    if (pixelFormat != kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange &&
        pixelFormat != kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
        NSLog(@"Unsupported pixel format for color space processing: %u", pixelFormat);
        return;
    }
    
    // Get appropriate color matrix
    const float* matrix = [self getColorMatrixForColorSpace:colorSpace];
    
    // Copy matrix to Metal buffer
    memcpy([self.colorMatrixBuffer contents], matrix, sizeof(float) * 9);
    
    @autoreleasepool {
        size_t width = CVPixelBufferGetWidth(pixelBuffer);
        size_t height = CVPixelBufferGetHeight(pixelBuffer);
        
        // Create Metal textures
        CVMetalTextureRef yTextureRef = NULL;
        CVMetalTextureRef uvTextureRef = NULL;
        
        CVReturn result = CVMetalTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault, self.textureCache, pixelBuffer, NULL,
            MTLPixelFormatR8Unorm, width, height, 0, &yTextureRef);
        
        if (result != kCVReturnSuccess || !yTextureRef) {
            NSLog(@"Failed to create Y texture: %d", result);
            return;
        }
        
        result = CVMetalTextureCacheCreateTextureFromImage(
            kCFAllocatorDefault, self.textureCache, pixelBuffer, NULL,
            MTLPixelFormatRG8Unorm, width/2, height/2, 1, &uvTextureRef);
        
        if (result != kCVReturnSuccess || !uvTextureRef) {
            NSLog(@"Failed to create UV texture: %d", result);
            CFRelease(yTextureRef);
            return;
        }
        
        id<MTLTexture> yTexture = CVMetalTextureGetTexture(yTextureRef);
        id<MTLTexture> uvTexture = CVMetalTextureGetTexture(uvTextureRef);
        
        // Create output texture descriptor
        MTLTextureDescriptor *outputDesc = [[MTLTextureDescriptor alloc] init];
        outputDesc.pixelFormat = MTLPixelFormatRGBA8Unorm;
        outputDesc.width = width;
        outputDesc.height = height;
        outputDesc.usage = MTLTextureUsageShaderWrite | MTLTextureUsageShaderRead;
        
        id<MTLTexture> outputTexture = [self.metalDevice newTextureWithDescriptor:outputDesc];
        
        // Prepare range parameter (reference GlGenericDrawer.java)
        int isFullRange = (colorSpace.range == agora::media::base::ColorSpace::RANGEID_FULL) ? 1 : 0;
        id<MTLBuffer> rangeBuffer = [self.metalDevice newBufferWithBytes:&isFullRange 
                                                                 length:sizeof(int)
                                                                options:MTLResourceStorageModeShared];
        
        // Execute compute shader
        id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
        id<MTLComputeCommandEncoder> computeEncoder = [commandBuffer computeCommandEncoder];
        
        [computeEncoder setComputePipelineState:self.colorSpacePipelineState];
        [computeEncoder setTexture:yTexture atIndex:0];
        [computeEncoder setTexture:uvTexture atIndex:1];
        [computeEncoder setTexture:outputTexture atIndex:2];
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
        
        // Key: Need to convert processed RGB data back to YUV format and write to original CVPixelBuffer
        [self copyProcessedRGBABackToYUVPixelBuffer:outputTexture pixelBuffer:pixelBuffer];
        
        // Cleanup
        CFRelease(yTextureRef);
        CFRelease(uvTextureRef);
        
        NSLog(@"Applied ColorSpace transform - Matrix:%d, Range:%d (%s)", 
              colorSpace.matrix, colorSpace.range, 
              (colorSpace.range == agora::media::base::ColorSpace::RANGEID_FULL) ? "Full" : "Limited");
    }
}

- (void)copyProcessedRGBABackToYUVPixelBuffer:(id<MTLTexture>)rgbaTexture
                                 pixelBuffer:(CVPixelBufferRef)pixelBuffer {

    // Lock CVPixelBuffer for writing
    CVReturn result = CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    if (result != kCVReturnSuccess) {
        NSLog(@"Failed to lock pixel buffer: %d", result);
        return;
    }
    
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    // For simplicity, create a temporary RGB data buffer here
    size_t rgbaDataSize = width * height * 4;
    uint8_t* rgbaData = (uint8_t*)malloc(rgbaDataSize);
    
    // Read RGBA data from Metal texture
    [rgbaTexture getBytes:rgbaData
              bytesPerRow:width * 4
               fromRegion:MTLRegionMake2D(0, 0, width, height)
              mipmapLevel:0];
    
    // Get YUV plane pointers
    uint8_t* yPlane = (uint8_t*)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    uint8_t* uvPlane = (uint8_t*)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 1);
    size_t yBytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, 0);
    size_t uvBytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, 1);
    
    // Convert RGBA back to YUV (simplified conversion - using BT.709 matrix)
    for (size_t y = 0; y < height; y++) {
        for (size_t x = 0; x < width; x++) {
            size_t rgbaIdx = (y * width + x) * 4;
            uint8_t r = rgbaData[rgbaIdx];
            uint8_t g = rgbaData[rgbaIdx + 1];
            uint8_t b = rgbaData[rgbaIdx + 2];
            
            // RGB to YUV conversion (BT.709)
            int yVal = (int)(0.2126 * r + 0.7152 * g + 0.0722 * b);
            int uVal = (int)(-0.1146 * r - 0.3854 * g + 0.5 * b + 128);
            int vVal = (int)(0.5 * r - 0.4542 * g - 0.0458 * b + 128);
            
            // Clamp values
            yVal = MAX(0, MIN(255, yVal));
            uVal = MAX(0, MIN(255, uVal));
            vVal = MAX(0, MIN(255, vVal));
            
            // Write Y value
            yPlane[y * yBytesPerRow + x] = (uint8_t)yVal;
            
            // Write UV values (subsampled)
            if (y % 2 == 0 && x % 2 == 0) {
                size_t uvY = y / 2;
                size_t uvX = x / 2;
                uvPlane[uvY * uvBytesPerRow + uvX * 2] = (uint8_t)uVal;
                uvPlane[uvY * uvBytesPerRow + uvX * 2 + 1] = (uint8_t)vVal;
            }
        }
    }
    
    free(rgbaData);
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    NSLog(@"Copied processed RGBA back to YUV CVPixelBuffer");
}

- (void)dealloc {
  if (self.irisRtcRendering) {
    // the delegateId is garenteed to be auto incremented, so we can just remove
    // the delegate by the id, no need to check if the delegate is still valid
    // or is belong to this TextureRender
    self.irisRtcRendering->RemoveVideoFrameObserverDelegate(self.delegateId);
    self.irisRtcRendering = nil;
  }

  dispatch_sync(self.pixelBufferSynchronizationQueue, ^{
    if (self.latestPixelBuffer) {
      CVPixelBufferRelease(self.latestPixelBuffer);
      self.latestPixelBuffer = nil;
    }
  });
  
  // Clean up Metal resources
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
