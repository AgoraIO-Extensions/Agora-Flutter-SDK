import Accelerate
import MediaPlayer
import BanubaEffectPlayer
#if BNB_ENABLE_ARKIT
import ARKit
#endif

@objc public protocol InputServicing: CameraServicing, AudioCapturing, CameraZoomable {
}

internal typealias AVCaptureDataDelegate = AVCaptureVideoDataOutputSampleBufferDelegate & AVCaptureAudioDataOutputSampleBufferDelegate & AVCapturePhotoCaptureDelegate
public typealias RotateCameraCallBack = () -> ()

@objc public protocol CameraServicing: AnyObject {
    var delegate: InputServiceDelegate? { get set }
    var isFrontCamera: Bool { get }
    var isPhotoCameraSession: Bool { get }
    var isCameraCapturing: Bool { get }
    var currentCameraSessionType: CameraSessionType { get }
    var exposurePointOfInterest: CGPoint { get }
    var useARKit: Bool { get }
    var flipCamera: Bool { get set }
    func startCamera()
    func stopCamera()
    func initializeCameraInput()
    func releaseAudioCaptureSession()
    func setCameraSessionType(_ type: CameraSessionType)
    func setCameraSessionType(_ type: CameraSessionType, completion: @escaping RotateCameraCallBack)
    func setCameraSessionType(_ type: CameraSessionType, zoomFactor: Float, completion: @escaping RotateCameraCallBack)
    func configureExposureSettings(_ point: CGPoint, useContinuousDetection: Bool)
    func configureFocusSettings(_ point: CGPoint, useContinuousDetection: Bool)
    func setTorch(mode: AVCaptureDevice.TorchMode) -> AVCaptureDevice.TorchMode
    func toggleTorch() -> AVCaptureDevice.TorchMode
    func initiatePhotoCapture(
        cameraSettings: CameraPhotoSettings,
        completion: @escaping (CVImageBuffer?, BNBFrameData?) -> Void
    )
    func switchCamera(to type: CameraSessionType, completion: @escaping RotateCameraCallBack)
    func restoreCurrentCameraSessionSettings(completion: (() -> Void)?)
    func setMaxFaces(_ maxFaces: Int)
}

@objc public protocol AudioCapturing: AnyObject {
    func startAudioCapturing()
    func stopAudioCapturing()
}

@objc public protocol CameraZoomable: AnyObject {
    var currentFieldOfView: Float { get }
    var isZoomFactorAdjustable: Bool { get }
    var minZoomFactor: Float { get }
    var maxZoomFactor: Float { get }
    var zoomFactor: Float { get }
    func setZoomFactor(_ zoomFactor:Float) -> Float
}

@objc public protocol InputServiceDelegate: AnyObject {
    func push(cvBuffer: CVPixelBuffer)
    func push(cmBuffer: CMSampleBuffer)
#if BNB_ENABLE_ARKIT
    @available(iOS 11.0, *)
    func push(frame: ARFrame, useBackCamera: Bool)
#endif
}

@objc public enum CameraSessionType: Int {
    case FrontCameraVideoSession
    case BackCameraVideoSession
    case FrontCameraPhotoSession
    case BackCameraPhotoSession
}

@objc public class CameraPhotoSettings: NSObject {
    @objc public let useStabilization: Bool
    @objc public let flashMode: AVCaptureDevice.FlashMode
    
    @objc public init(
        useStabilization: Bool,
        flashMode: AVCaptureDevice.FlashMode
    ) {
        self.useStabilization = useStabilization
        self.flashMode = flashMode
    }
}

internal class InputService: NSObject {
    public enum InputServiceError: Error {
        case CameraDeviceInitializationFailed
        case CameraInputInitializationFailed
        case AudioDeviceInitializationFailed
        case AudioInputInitializationFailed
    }
    
    struct Defaults {
        static let cameraDeviceInitFailedMessage = "Camera device initialization was failed!"
        static let cameraInputInitFailedMessage = "Camera input initialization was failed!"
        static let audioDeviceInitFailedMessage = "Audio device initialization was failed!"
        static let audioInputInitFailedMessage = "Audio input initialization was failed!"
        static let changeExposureSettingsFailedMessage = "Configuring of camera exposure settings has failed!"
        static let changeFocusSettingsFailedMessage = "Configuring of camera focus settings has failed!"
        static let configureAudioSessionFailedMessage = "Audio session configuration was failed!"
        static let audioSessionQueueLabel = "com.banubaSdk.audioSessionQueue"
        static let cameraSessionQueueLabel = "com.banubaSdk.cameraSessionQueue"
        static let availablePixelFormatRemapping: [OSType: [UInt8]] = [
            kCVPixelFormatType_32BGRA: [2, 1, 0, 3],
            kCVPixelFormatType_32ARGB: [1, 2, 3, 0],
            kCVPixelFormatType_32RGBA: [0, 1, 2, 3],
            kCVPixelFormatType_32ABGR: [3, 2, 1, 0]
        ]
    }
    
#if BNB_ENABLE_ARKIT
    @available(iOS 11.0, *)
    private var arConfiguration: ARConfiguration? {
        arConfigurationImpl as? ARConfiguration
    }
    
    @available(iOS 11.0, *)
    private var arSession: ARSession? {
        self.arSessionImpl as? ARSession
    }
#endif
    
    private var arSessionImpl: AnyObject?
    private var arConfigurationImpl: AnyObject?
    private let fpsLimit: Double
    private var timeOfReceivingLastFrame: TimeInterval = 0
    private var cameraCaptureSession: AVCaptureSession?
    private var cameraDevice: AVCaptureDevice?
    private var cameraInput: AVCaptureDeviceInput?
    private let cameraSessionQueue = DispatchQueue(label: Defaults.cameraSessionQueueLabel, qos: .userInitiated)
    private var cameraPhotoOutput: AVCapturePhotoOutput?
    private var cameraVideoOutput: AVCaptureVideoDataOutput?
    private var audioSession: AVCaptureSession?
    private var audioDevice: AVCaptureDevice?
    private var audioSessionQueue = DispatchQueue(label: Defaults.audioSessionQueueLabel, qos: .userInitiated)
    private var cameraSessionType: CameraSessionType
    private var captureSessionPreset: AVCaptureSession.Preset
    public let useARKit: Bool
    public var flipCamera = false
    private var maxFacesCount = 1
    private var photoCompletionHandler: ((CVImageBuffer?, BNBFrameData?) -> Void)?
    private var cameraPhotoSettings: CameraPhotoSettings?
    private var useBackCamera = false
    private var lastValue: CMTimeValue = 0
    private var duplicatesSampleBuffer = false
    private var avSessionErrorToken : Any?
    public weak var delegate: InputServiceDelegate?
    
    public init(
        cameraMode: CameraSessionType,
        captureSessionPreset: AVCaptureSession.Preset,
        useARKitWhenAvailable: Bool,
        fpsLimit: Double = 60,
        delayedCameraInitialization: Bool
    ) {
        cameraSessionType = cameraMode
        self.captureSessionPreset = captureSessionPreset
#if BNB_ENABLE_ARKIT
        if #available(iOS 11.0, *), ARFaceTrackingConfiguration.isSupported {
            self.useARKit = useARKitWhenAvailable
        }
        else {
            self.useARKit = false
        }
#else
        self.useARKit = false
#endif
        
        self.fpsLimit = fpsLimit
        avSessionErrorToken = NotificationCenter.default.addObserver(
            forName: .AVCaptureSessionRuntimeError,
            object: nil,
            queue: nil
        ) { note in
            let error = note.userInfo?[AVCaptureSessionErrorKey]
            print("AVCaptureSessionRuntimeError: \(error ?? "unknown")")
        }
        
        super.init()
        
        if !delayedCameraInitialization {
            setupCamera()
        }
    }
    
    private func setupCamera() {
        let isArkit = useARKit
        let sessionType = cameraSessionType
        
        cameraSessionQueue.async { [weak self] in
#if BNB_ENABLE_ARKIT
            if #available(iOS 11.0, *), isArkit {
                self?.setupARKitSession()
            } else {
                self?.configureCameraSession(type: sessionType)
            }
#else
            self?.configureCameraSession(type: sessionType)
#endif
        }
    }
    
    deinit {
        if let session = cameraCaptureSession {
            session.stopRunning()
            
            session.inputs.forEach { (input) in
                session.removeInput(input)
            }
            session.outputs.forEach { (output) in
                session.removeOutput(output)
            }
            cameraCaptureSession = nil
        }
        
        arSessionImpl = nil
        if let avObserver = avSessionErrorToken {
            NotificationCenter.default.removeObserver(avObserver)
        }
    }
    
#if BNB_ENABLE_ARKIT
    @available(iOS 11.0, * )
    private func setupARKitSession() {
        if arSessionImpl == nil {
            arSessionImpl = ARSession()
        }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arSession?.delegate = self
        arSession?.run(configuration, options: .default)
        arConfigurationImpl = configuration
        cameraSessionType = .FrontCameraPhotoSession
    }
#endif
    
    public func initializeCameraInput() {
        var isAlreadyInitialized = false
#if BNB_ENABLE_ARKIT
        if #available(iOS 11.0, *), useARKit {
            isAlreadyInitialized = arSession != nil
        } else {
            isAlreadyInitialized = cameraCaptureSession != nil
        }
#else
        isAlreadyInitialized = cameraCaptureSession != nil
#endif
        
        if !isAlreadyInitialized {
            setupCamera()
        }
    }
    
    public func setupCameraSession(withType type: CameraSessionType, zoomFactor: Float? = nil, completion: @escaping RotateCameraCallBack = {}) {
        cameraSessionQueue.async { [weak self] in
            guard let self = self else { return }
            if let zoomFactor = zoomFactor {
                let _ = self.setZoomFactor(zoomFactor)
            }
            self.switchCamera(to: type, completion: completion)
        }
    }
    
    public func switchCamera(to type: CameraSessionType, completion: @escaping RotateCameraCallBack = {}) {
#if BNB_ENABLE_ARKIT
        if #available(iOS 11.0, *), useARKit {
            guard let arSession = arSession else {
                completion()
                return
            }
            
            useBackCamera = (type == .BackCameraPhotoSession || type == .BackCameraVideoSession)
            
            if useBackCamera {
                let configuration = ARWorldTrackingConfiguration()
                configuration.isLightEstimationEnabled = true
                arSession.run(configuration, options: .default)
                arConfigurationImpl = configuration
            } else {
                let configuration = ARFaceTrackingConfiguration()
                if #available(iOS 13.0, *) {
                    configuration.maximumNumberOfTrackedFaces = min(ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces, maxFacesCount)
                }
                configuration.isLightEstimationEnabled = true
                arSession.run(configuration, options: .default)
                arConfigurationImpl = configuration
            }
            completion()
        } else {
            defer { completion() }
            
            guard cameraCaptureSession != nil else { return }
            
            configureCameraSession(type: type)
        }
#else
        defer { completion() }
        
        guard cameraCaptureSession != nil else { return }
        
        configureCameraSession(type: type)
#endif
    }
    
    public func restoreCurrentCameraSessionSettings(completion: (() -> Void)? = nil) {
        cameraSessionQueue.async { [weak self] in
            guard let self = self else { return }
            self.configureCameraSession(type: self.cameraSessionType)
            completion?()
        }
    }
    
    private func configureCameraSession(type: CameraSessionType) {
#if !TARGET_IPHONE_SIMULATOR
        if cameraCaptureSession == nil {
            cameraCaptureSession = AVCaptureSession()
        }
        guard let session = cameraCaptureSession else { return }
        let isSessionRunning = session.isRunning
        session.beginConfiguration()
        cameraSessionType = type
        if !useARKit {
            session.sessionPreset = captureSessionPreset
        }
        let deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInWideAngleCamera]
        let devicePosition:AVCaptureDevice.Position = isFrontCamera ? .front : .back
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: deviceTypes,
            mediaType: .video,
            position: devicePosition
        )
        cameraDevice = discoverySession.devices.first
        guard let camera = cameraDevice else {
            session.commitConfiguration()
            print(Defaults.cameraDeviceInitFailedMessage)
            return
        }
        if let input = cameraInput {
            session.removeInput(input)
        }
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            session.addInput(input)
            cameraInput = input
        } catch {
            print(Defaults.cameraInputInitFailedMessage)
        }
        let photoOutput = defaultPhotoSessionOutput()
        if session.canAddOutput(photoOutput) {
            if let previousPhotoOutput = cameraPhotoOutput {
                session.removeOutput(previousPhotoOutput)
            }
            session.addOutput(photoOutput)
            cameraPhotoOutput = photoOutput
        }
        
        let videoOutput = defaultVideoSessionOutput()
        if let previousVideoOutput = cameraVideoOutput {
            session.removeOutput(previousVideoOutput)
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            if let captureConnection = videoOutput.connection(with: .video) {
                // It appears that portrait CVPixelBuffer will have paddings.
                // This will consume perfomance a bit because of line-by-line
                // copying inside SDK. Landscape frames don't have paddings.
                // See EffectPlayerConfiguration.orientation.
                captureConnection.videoOrientation = .landscapeRight
                captureConnection.isVideoMirrored = isFrontCamera
            }
            cameraVideoOutput = videoOutput
        }
        session.commitConfiguration()
        
        // If capture session was running before, we should ensure that it still running after reconfiguration,
        // because sometimes device could stop session after applying new settings (very unstable and rare issue).
        if isSessionRunning {
            startCamera()
        }
        #endif // !TARGET_IPHONE_SIMULATOR
    }
    
    private func setupAudioCaptureSessionIfNeeded() {
        guard audioSession == nil else { return }
        let session = AVCaptureSession()
        session.usesApplicationAudioSession = false
        audioSession = session
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        let deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInMicrophone]
        let discoverySession = AVCaptureDevice.DiscoverySession.init(
            deviceTypes: deviceTypes,
            mediaType: .audio,
            position: .unspecified
        )
        audioDevice = discoverySession.devices.first
        guard let audio = audioDevice else {
            print(Defaults.audioDeviceInitFailedMessage)
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: audio)
            session.addInput(input)
        } catch {
            print(Defaults.audioInputInitFailedMessage)
        }
        let output = AVCaptureAudioDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        if session.canAddOutput(output) {
            session.addOutput(output)
        } else {
            print(Defaults.audioInputInitFailedMessage)
        }
    }
    
    private func defaultPhotoSessionOutput() -> AVCapturePhotoOutput {
        let photoOutput = AVCapturePhotoOutput()
        photoOutput.isHighResolutionCaptureEnabled = true
        return photoOutput
    }
    
    private func defaultVideoSessionOutput() -> AVCaptureVideoDataOutput {
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [String(kCVPixelBufferPixelFormatTypeKey) : kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .default))
        return videoOutput
    }
}

extension InputService: AVCaptureDataDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if output is AVCaptureAudioDataOutput {
            let currentValue = CMSampleBufferGetPresentationTimeStamp(sampleBuffer).value
            if lastValue != currentValue {
                lastValue = currentValue
                if !duplicatesSampleBuffer {
                    delegate?.push(cmBuffer: sampleBuffer)
                }
            } else {
                duplicatesSampleBuffer = true
                delegate?.push(cmBuffer: sampleBuffer)
            }
        } else if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            delegate?.push(cvBuffer: pixelBuffer)
        }
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // handle sampleBuffer drops ?
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingRawPhoto rawSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        handlePhotoCapturing(sampleBuffer: rawSampleBuffer, error: error)
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        handlePhotoCapturing(sampleBuffer: photoSampleBuffer, error: error)
    }
    
    private func handlePhotoCapturing(sampleBuffer: CMSampleBuffer?, error: Error?) {
        var isMirrored = false
        if flipCamera && isFrontCamera {
            isMirrored = true
        }
        
        defer { photoCompletionHandler = nil }
        
        guard error == nil,
              let imageSample = sampleBuffer,
              let imageBuffer = BanubaSdkManager.scaleBeforeProcessing(
                CMSampleBufferGetImageBuffer(imageSample)) else {
            photoCompletionHandler?(nil, nil)
            return
        }
        let angle = BanubaSdkManager.currentDeviceOrientation.effectsPlayerAngle ?? 0
        photoCompletionHandler?(
            imageBuffer,
            BNBFrameData.create(
                cvBuffer: imageBuffer,
                faceOrientation: angle,
                cameraOrientation: .deg90,
                requireMirroring: isMirrored
            )
        )
    }
}

#if BNB_ENABLE_ARKIT
@available(iOS 11.0, *)
extension InputService: ARSessionDelegate {
    public func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if shouldSkipFrameAtTime(time: frame.timestamp) {
            return
        }
        
        if let photoCompletionHandler = self.photoCompletionHandler {
            let angle = BanubaSdkManager.currentDeviceOrientation.effectsPlayerAngle ?? 0
            let frameData = BNBFrameData.create(
                arFrame: frame,
                useBanubaTracking: !isFrontCamera,
                faceOrientation: angle,
                cameraOrientation: .deg90,
                requireMirroring: false
            )
            photoCompletionHandler(
                frame.capturedImage,
                frameData
            )
            self.photoCompletionHandler = nil
        }
        
        self.cameraSessionType = session.configuration is ARFaceTrackingConfiguration ?
            .FrontCameraPhotoSession : .BackCameraPhotoSession
        delegate?.push(frame: frame, useBackCamera: !self.isFrontCamera)
    }
    
    private func shouldSkipFrameAtTime(time: TimeInterval) -> Bool {
        if self.timeOfReceivingLastFrame != 0 && (self.timeOfReceivingLastFrame + Double(1 / fpsLimit)) > time {
            return true
        }
        self.timeOfReceivingLastFrame = time
        return false
    }
    
    public func session(_ session: ARSession, didFailWithError error: Error) {
        guard let arError = error as? ARError else { return }
        let errorWithInfo = arError as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        print("AR session failed: \(errorMessage)")
        switch arError.code {
        case .sensorFailed:
            setupARKitSession()
        default:
            break
        }
    }
}
#endif

extension InputService: InputServicing {
    public func configureExposureSettings(_ point: CGPoint, useContinuousDetection: Bool) {
        guard let camera = cameraDevice else { return }
        var convertedPoint: CGPoint? = nil
        if point != .zero {
            convertedPoint = convertToPoint(point, isFrontCamera: isFrontCamera)
        }
        do {
            try camera.lockForConfiguration()
            let exposureMode: AVCaptureDevice.ExposureMode = useContinuousDetection ? .continuousAutoExposure : .autoExpose
            if camera.isExposurePointOfInterestSupported && camera.isExposureModeSupported(exposureMode) {
                camera.exposurePointOfInterest = convertedPoint ?? camera.exposurePointOfInterest
                camera.exposureMode = exposureMode
            }
            camera.unlockForConfiguration()
        } catch {
            print(Defaults.changeExposureSettingsFailedMessage)
        }
    }
    
    public func configureFocusSettings(_ point: CGPoint, useContinuousDetection: Bool) {
        guard let camera = cameraDevice, camera.isFocusPointOfInterestSupported else { return }
        
        var convertedPoint: CGPoint? = nil
        if point != .zero {
            convertedPoint = convertToPoint(point, isFrontCamera: isFrontCamera)
        }
        
        do {
            try camera.lockForConfiguration()
            
            let focusMode: AVCaptureDevice.FocusMode = useContinuousDetection ? .continuousAutoFocus: .autoFocus
            
            camera.focusPointOfInterest = convertedPoint ?? camera.focusPointOfInterest
            camera.focusMode = focusMode
            
            camera.unlockForConfiguration()
        } catch {
            print(Defaults.changeFocusSettingsFailedMessage)
        }
    }
    
    /// Initial value uses a coordinate system where {0,0} is the top left of the picture area and {1,1} is the bottom right.
    /// Device exposure point coordinate system is always relative to a landscape device orientation
    /// with the home button on the right, regardless of the actual device orientation.
    /// So, correct translation will be - (x = y, y = 1 - x)
    /// Also, on front camera we should flip x component again, because we're processing mirrored image - (x = y, y = x)
    private func convertToPoint(_ point: CGPoint, isFrontCamera: Bool) -> CGPoint {
        let convertedY = isFrontCamera ? point.x : 1.0 - point.x
        return CGPoint(x: point.y, y: convertedY)
    }
    
    public var exposurePointOfInterest: CGPoint {
        guard let camera = cameraDevice else { return CGPoint.zero }
        return camera.exposurePointOfInterest
    }
    
    public func setTorch(mode: AVCaptureDevice.TorchMode) -> AVCaptureDevice.TorchMode {
        guard let device = cameraDevice, device.hasTorch, device.isTorchAvailable else {
            return .off
        }
        
        var newMode: AVCaptureDevice.TorchMode = device.isTorchActive ? .on : .off
        
        do {
            try device.lockForConfiguration()
            
            device.torchMode = mode
            device.unlockForConfiguration()
            newMode = mode
        } catch {
            device.torchMode = .off
            device.unlockForConfiguration()
        }
        
        return newMode
    }
    
    public func toggleTorch() -> AVCaptureDevice.TorchMode {
        guard let device = cameraDevice else {
            return .off
        }
        
        let isTorchActive = device.isTorchActive
        
        return setTorch(mode: isTorchActive ? .off: .on)
    }
    
    public var currentFieldOfView: Float {
#if BNB_ENABLE_ARKIT
        if #available(iOS 11.0, *), useARKit, let arSession = arSession, let curFrame = arSession.currentFrame {
            let projection = curFrame.camera.projectionMatrix
            let yScale = projection[1,1]
            let yFov = 2 * atan(1/yScale) // in radians
            let yFovDegrees = yFov * 180/Float.pi
            let imageResolution = curFrame.camera.imageResolution
            let xFov = yFov * Float(imageResolution.width / imageResolution.height)
            let xFovDegrees = xFov * 180/Float.pi
            return max(yFovDegrees, xFovDegrees)
        }
#endif
        guard let camera = cameraDevice else { return 0.0 }
        return Float(camera.activeFormat.videoFieldOfView)
    }
    
    public var isZoomFactorAdjustable: Bool {
        return abs(maxZoomFactor - minZoomFactor) > .ulpOfOne
    }
    
    public var minZoomFactor: Float {
        return 1.0
    }
    
    public var maxZoomFactor: Float {
        guard let camera = cameraDevice else { return minZoomFactor }
        return Float(camera.activeFormat.videoMaxZoomFactor)
    }
    
    public var zoomFactor: Float {
        guard let camera = cameraDevice else { return minZoomFactor }
        return Float(camera.videoZoomFactor)
    }
    
    public func setZoomFactor(_ zoomFactor: Float) -> Float {
        guard let camera = cameraDevice else { return minZoomFactor }
        if isZoomFactorAdjustable {
            let correctedZoomFactor = max(minZoomFactor, min(zoomFactor, maxZoomFactor))
            do {
                try camera.lockForConfiguration()
                camera.videoZoomFactor = CGFloat(correctedZoomFactor)
                camera.unlockForConfiguration()
                return correctedZoomFactor
            } catch {
                return minZoomFactor
            }
        } else {
            return minZoomFactor
        }
    }
    
    public func startCamera() {
        configureAudioSessionWithCategory(.ambient)
#if BNB_ENABLE_ARKIT
        if #available(iOS 11.0, *), useARKit,
           let arSession = arSession,
           let arConfiguration = arConfiguration {
            arSession.run(arConfiguration, options: .default)
            return
        }
#endif
        cameraSessionQueue.async { [weak self] in
            guard let self = self, let session = self.cameraCaptureSession else { return }
            session.startRunning()
        }
    }
    
    public func stopCamera() {
#if BNB_ENABLE_ARKIT
        if #available(iOS 11.0, *), useARKit,
           let arSession = arSession {
            arSession.pause()
            return
        }
#endif
        cameraSessionQueue.async { [weak self] in
            guard let self = self, let session = self.cameraCaptureSession else { return }
            session.stopRunning()
        }
    }
    
    public func releaseAudioCaptureSession() {
        audioSessionQueue.async { [weak self] in
            guard let audioSession = self?.audioSession else { return }
            self?.audioSession = nil
            self?.audioDevice = nil
            audioSession.beginConfiguration()
            audioSession.inputs.forEach { input in
                audioSession.removeInput(input)
            }
            audioSession.outputs.forEach { output in
                audioSession.removeOutput(output)
            }
            audioSession.commitConfiguration()
        }
    }
    
    public func initiatePhotoCapture(
        cameraSettings: CameraPhotoSettings,
        completion: @escaping (CVImageBuffer?, BNBFrameData?) -> Void
    ) {
        guard isPhotoCameraSession else {
            completion(nil, nil)
            return
        }
        cameraPhotoSettings = cameraSettings
        photoCompletionHandler = completion
        if !useARKit {
            guard let device = cameraDevice else {
                completion(nil, nil)
                return
            }
            if device.isReadyToMakePhoto {
                makePhoto(cameraPhotoSettings: cameraSettings)
            } else {
                startObservingCameraAdjusting()
            }
        }
    }
    
    private func makePhoto(cameraPhotoSettings: CameraPhotoSettings) {
        guard isPhotoCameraSession, let photoOutput = cameraPhotoOutput else {
            photoCompletionHandler?(nil, nil)
            return
        }
        let supportedPixelFormats = Defaults.availablePixelFormatRemapping.keys.filter { photoOutput.availablePhotoPixelFormatTypes.contains($0) }
        guard let pixelFormat = supportedPixelFormats.first else {
            // We can't find any suitable pixel format for further processing
            photoCompletionHandler?(nil, nil)
            return
        }
        let settings = AVCapturePhotoSettings(
            pixelFormat: pixelFormat,
            cameraPhotoSettings: cameraPhotoSettings
        )
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    public var isPhotoCameraSession: Bool {
        return cameraSessionType == .BackCameraPhotoSession ||
            cameraSessionType == .FrontCameraPhotoSession
    }
    
    public var isFrontCamera: Bool {
        return cameraSessionType == .FrontCameraPhotoSession ||
            cameraSessionType == .FrontCameraVideoSession
    }
    
    public var isCameraCapturing: Bool {
        guard let session = cameraCaptureSession else { return false }
        return session.isRunning
    }
    
    public var currentCameraSessionType: CameraSessionType {
        return cameraSessionType
    }
    
    public func setCameraSessionType(_ type: CameraSessionType, completion: @escaping RotateCameraCallBack) {
        guard cameraSessionType != type else { return }
        setupCameraSession(withType: type) {
            completion()
        }
    }
    
    public func setCameraSessionType(_ type: CameraSessionType) {
        guard cameraSessionType != type else { return }
        setupCameraSession(withType: type)
    }
    
    public func setCameraSessionType(_ type: CameraSessionType, zoomFactor: Float, completion: @escaping RotateCameraCallBack) {
        guard cameraSessionType != type else { return }
        setupCameraSession(withType: type, zoomFactor: zoomFactor) {
            completion()
        }
    }
    
    public func startAudioCapturing() {
        audioSessionQueue.async { [weak self] in
            self?.setupAudioCaptureSessionIfNeeded()
            guard let session = self?.audioSession else { return }
            session.startRunning()
        }
    }
    
    public func stopAudioCapturing() {
        audioSessionQueue.async { [weak self] in
            guard let session = self?.audioSession else { return }
            session.stopRunning()
            self?.duplicatesSampleBuffer = false
        }
    }
    
    private func configureAudioSessionWithCategory(_ category: AVAudioSession.Category) {
        let audioSharedSession = AVAudioSession.sharedInstance()
        do {
            try audioSharedSession.setCategory(category, mode: .default, options: .mixWithOthers)
            try audioSharedSession.setActive(true)
        } catch {
            print(Defaults.configureAudioSessionFailedMessage)
        }
    }
    
    func setMaxFaces(_ maxFaces: Int) {
#if BNB_ENABLE_ARKIT
        if #available(iOS 13.0, *),
           useARKit,
           let arConfiguration = arConfiguration as? ARFaceTrackingConfiguration {
            let supremum = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
            maxFacesCount = maxFaces
            arConfiguration.maximumNumberOfTrackedFaces = min(supremum, maxFaces)
            arSession?.run(arConfiguration, options: .default)
        }
#endif
    }
}

private extension AVCapturePhotoSettings {
    convenience init(pixelFormat: OSType, cameraPhotoSettings: CameraPhotoSettings) {
        self.init(format: [String(kCVPixelBufferPixelFormatTypeKey) : pixelFormat])
        flashMode = cameraPhotoSettings.flashMode
        isAutoStillImageStabilizationEnabled = cameraPhotoSettings.useStabilization
        isHighResolutionPhotoEnabled = true
    }
}

// Camera adjusting before making photo (using KVO)
extension InputService {
    private static var observingContext = 0
    struct ObservingKeys {
        static let adjustingWhiteBalanceKeyPath = "adjustingWhiteBalance"
        static let adjustingFocusKeyPath = "adjustingFocus"
        static let adjustingExposureKeyPath = "adjustingExposure"
    }
    
    func startObservingCameraAdjusting() {
        guard let device = cameraDevice else { return }
        device.addObserver(
            self,
            forKeyPath: ObservingKeys.adjustingWhiteBalanceKeyPath,
            options: [.old, .new],
            context: &InputService.observingContext
        )
        device.addObserver(
            self,
            forKeyPath: ObservingKeys.adjustingFocusKeyPath,
            options: [.old, .new],
            context: &InputService.observingContext
        )
        device.addObserver(
            self,
            forKeyPath: ObservingKeys.adjustingExposureKeyPath,
            options: [.old, .new],
            context: &InputService.observingContext
        )
    }
    
    func stopObservingCameraAdjusting() {
        guard let device = cameraDevice else { return }
        device.removeObserver(self, forKeyPath: ObservingKeys.adjustingWhiteBalanceKeyPath)
        device.removeObserver(self, forKeyPath: ObservingKeys.adjustingFocusKeyPath)
        device.removeObserver(self, forKeyPath: ObservingKeys.adjustingExposureKeyPath)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context != &InputService.observingContext {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        guard isPhotoCameraSession,
              let device = cameraDevice,
              let settings = cameraPhotoSettings else { return }
        if device.isReadyToMakePhoto {
            stopObservingCameraAdjusting()
            DispatchQueue.main.async { [weak self] in
                self?.makePhoto(cameraPhotoSettings: settings)
            }
        }
    }
}

extension CameraSessionType {
    public var isFrontCamera: Bool {
        return self == .FrontCameraPhotoSession || self == .FrontCameraVideoSession
    }
    
    public var isPhotoMode: Bool {
        return self == .BackCameraPhotoSession || self == .FrontCameraPhotoSession
    }
}

fileprivate extension AVCaptureDevice {
    var isReadyToMakePhoto: Bool {
        return !isAdjusting
    }
    
    private var isAdjusting: Bool {
        return adjustingProperties.isContainsTrue
    }
    
    private var adjustingProperties: [Bool] {
        return [isAdjustingFocus, isAdjustingExposure, isAdjustingWhiteBalance]
    }
}

fileprivate extension Array where Element == Bool {
    var isContainsTrue: Bool {
        let firstTrue = first(where: { $0 == true })
        return firstTrue != nil
    }
}

#if BNB_ENABLE_ARKIT
@available(iOS 11.0, *)
fileprivate extension ARSession.RunOptions {
    static var `default`: Self = [.resetTracking, .removeExistingAnchors]
}
#endif

