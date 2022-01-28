import BanubaEffectPlayer
import AVKit

@objc public enum EffectPlayerRenderMode: Int {
    case photo
    case video
}

@objc public class EffectPlayerConfiguration: NSObject {
    @objc public class Defaults: NSObject {
        @objc public static let videoSessionPreset: AVCaptureSession.Preset = .hd1280x720
        @objc public static let photoSessionPreset: AVCaptureSession.Preset = .photo
        @objc public static let photoRenderSize: CGSize = CGSize(width: 720, height: 1280)
        @objc public static let videoRenderSize: CGSize = CGSize(width: 720, height: 1280)
        @objc public static let defaultFrameRate: Int = 60
    }
    
    @objc public let cameraMode: CameraSessionType
    @objc public var renderSize: CGSize
    /// Preset for quality of photo or video and audio output.
    @objc public var captureSessionPreset: AVCaptureSession.Preset
    @objc public var preferredRenderFrameRate: Int
    @objc public var shouldAutoStartOnEnterForeground: Bool
    @objc public var isMirrored: Bool
    @objc public var flipVertically: Bool
    @objc public var delayedCameraInitialization: Bool
    @objc public var orientation: BNBCameraOrientation
    @objc public var notificationCenter: NotificationCenter
    @objc public var useARKitWhenAvailable: Bool
    @objc public var fpsLimit: Double
    
    @objc public override convenience init() {
        self.init(renderMode: .video)
    }
    
    @objc public convenience init(
        renderMode: EffectPlayerRenderMode,
        orientation: BNBCameraOrientation = .deg90,
        preferredRenderFrameRate: Int = EffectPlayerConfiguration.Defaults.defaultFrameRate,
        shouldAutoStartOnEnterForeground: Bool = true,
        isMirrored: Bool = false,
        useARKitWhenAvailable: Bool = false,
        fpsLimit: Double = 60,
        delayedCameraInitialization: Bool = false,
        notificationCenter: NotificationCenter = NotificationCenter.default
    ) {
        let isVideo = renderMode == .video
        let renderSize = isVideo ? Defaults.videoRenderSize : Defaults.photoRenderSize
        let cameraMode: CameraSessionType = isVideo ? .FrontCameraVideoSession : .FrontCameraPhotoSession
        let sessionPreset: AVCaptureSession.Preset = isVideo ? Defaults.videoSessionPreset : Defaults.photoSessionPreset
        self.init(
            cameraMode: cameraMode,
            renderSize: renderSize,
            captureSessionPreset: sessionPreset,
            orientation: orientation,
            preferredRenderFrameRate: preferredRenderFrameRate,
            shouldAutoStartOnEnterForeground: shouldAutoStartOnEnterForeground,
            isMirrored: isMirrored,
            flipVertically: false,
            useARKitWhenAvailable: useARKitWhenAvailable,
            fpsLimit: fpsLimit,
            delayedCameraInitialization: delayedCameraInitialization,
            notificationCenter: notificationCenter
        )
    }
    
    @objc public init(
        cameraMode: CameraSessionType,
        renderSize: CGSize,
        captureSessionPreset: AVCaptureSession.Preset,
        orientation: BNBCameraOrientation = .deg90,
        preferredRenderFrameRate: Int = EffectPlayerConfiguration.Defaults.defaultFrameRate,
        shouldAutoStartOnEnterForeground: Bool = true,
        isMirrored: Bool = false,
        flipVertically: Bool = true,
        useARKitWhenAvailable: Bool = false,
        fpsLimit: Double = 60,
        delayedCameraInitialization: Bool = false,
        notificationCenter: NotificationCenter = NotificationCenter.default
    ) {
        self.cameraMode = cameraMode
        self.captureSessionPreset = captureSessionPreset
        
        // Render size - specifies in which resolution effect player will render input data, and provide it back for further usage.
        // As described below, input size and render size should have same aspect ratio.
        // Also, surfaceCreated method should use the same value (renderSize) for width and height, to correctly display render on layer.
        // Layer itself could have any size, render will be scaled properly (Of course, layer should have same aspect ratio to prevent scaling distortions).
        self.renderSize = renderSize
        
        // Render loop triggers draw method with 60 fps by default, but in editing mode, when we render the same frame,
        // it's not needed, so we can make it lower with this parameter.
        self.preferredRenderFrameRate = preferredRenderFrameRate
        self.shouldAutoStartOnEnterForeground = shouldAutoStartOnEnterForeground
        self.orientation = orientation
        self.isMirrored = isMirrored
        self.flipVertically = flipVertically
        self.useARKitWhenAvailable = useARKitWhenAvailable
        self.fpsLimit = fpsLimit
        self.delayedCameraInitialization = delayedCameraInitialization
        self.notificationCenter = notificationCenter
    }
}

