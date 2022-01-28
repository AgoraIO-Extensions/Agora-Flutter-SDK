import Foundation
import BanubaEffectPlayer
import UIKit
#if BNB_ENABLE_ARKIT
import ARKit
#endif

@objc public protocol BanubaSdkManagerDelegate: AnyObject {
    func willPresentFramebuffer(renderSize: CGSize)
    func willOutput(pixelBuffer: CVPixelBuffer)
#if BNB_ENABLE_ARKIT
    @available(iOS 11.0, *)
    func willOutput(arFrame: ARFrame)
#endif
}

@objc public class BanubaSdkManager: NSObject {
    
    private let context = EAGLContext(api: .openGLES3)
    
    @objc public weak var delegate: BanubaSdkManagerDelegate?
    
    /**
     * Access to current instance of BNBEffectPlayer
     */
    @objc public private(set) var effectPlayer: BNBEffectPlayer?
    
    /**
     * Face orintation in frame (degrees).
     */
    @objc public var faceOrientation = 0
    @objc public func effectManager() -> BNBEffectManager? {
        return effectPlayer?.effectManager()
    }
    
    /**
     * Enable autorotation mode. Camera orientation and render size should change along with UI orientation
     */
    @objc public var autoRotationEnabled = false {
        didSet {
            guard autoRotationEnabled else { return }
            faceOrientation = 0
        }
    }
    
    /**
     * - parameter effectUrl: path to effect relative to resource paths passed to `initialize`.
     * - parameter synchronous: block the call until effect is loaded.
     */
    @objc public func loadEffect(_ effectUrl: String, synchronous: Bool = false) -> BNBEffect? {
        var effect: BNBEffect?
        if synchronous {
            let shouldRestart = !renderRunLoop.isStoped
            stopRenderLoop()
            performSync(onThread: renderThread) {
                self.activateMetalLayer()
                effect = self.effectPlayer?.effectManager()?.load(effectUrl)
            }
            if shouldRestart {
                startRenderLoop()
            }
        } else {
            effect = effectPlayer?.effectManager()?.loadAsync(effectUrl)
        }
        return effect
    }
    
    /** Extra parameters to be passed during on-CPU processing */
    @objc public var featureParameters: [BNBFeatureParameter]? = nil
    
    @objc public func currentEffect() -> BNBEffect? {
        return effectManager()?.current()
    }
    
    /**
     * Maximum number of faces to trace simultaneously
     */
    @objc public func setMaxFaces(_ maxFaces: Int) {
        effectPlayer?.setMaxFaces(Int32(maxFaces))
        inputService.setMaxFaces(maxFaces)
    }
    
    private struct Defaults {
        static let NothingToDraw = Int64(-1)
        
        // Delay in ms after switching camera session preset, before starting to adjust camera settings.
        // (Otherwise camera device won't recognize that all needed properties needs to be adjusted).
        static let CameraDeviceInitializationDelay = 10
        static let standardVideoSize = CGSize(width: 720, height: 1280)
        static let startPhotoJSCall = "onTakePhotoStart"
        static let endPhotoJSCall = "onTakePhotoEnd"
    }
    
    private var isUsingARKit: Bool {
        return inputService.useARKit
    }
    
    private lazy var inputService: InputServicing = {
        if let configuration = currentEffectPlayerConfiguration {
            return InputService(
                cameraMode: configuration.cameraMode,
                captureSessionPreset: configuration.captureSessionPreset,
                useARKitWhenAvailable: configuration.useARKitWhenAvailable,
                fpsLimit: configuration.fpsLimit,
                delayedCameraInitialization: configuration.delayedCameraInitialization
            )
        }
        // Front video camera mode by default, if we have no configuration at the moment
        return InputService(
            cameraMode: .FrontCameraVideoSession,
            captureSessionPreset: .hd1280x720,
            useARKitWhenAvailable: true,
            delayedCameraInitialization: false
        )
    }()
    
    @objc public var input: InputServicing  {
        get {
            return inputService
        }
        set {
            inputService = newValue
            inputService.delegate = self
        }
    }
    
    private var outputService: OutputService?
    
    @objc public var output: OutputServicing?  {
        return outputService
    }
    private lazy var synchronizationQueue = DispatchQueue(
        label: "com.banuba.sdk.synchronization-queue",
        qos: .userInitiated
    )
    
    //MARK: - Metal
    private var currentEffectPlayerConfiguration: EffectPlayerConfiguration?
    private var layer: CAMetalLayer?
    @objc public var renderTarget: RenderTarget?
    
    internal class var currentDeviceOrientation: UIDeviceOrientation {
        return deviceOrientationHandler.deviceOrientation
    }
    
    @objc public var playerConfiguration: EffectPlayerConfiguration? {
        return currentEffectPlayerConfiguration
    }
    
    @objc public func setRenderTarget(
        view: EffectPlayerView,
        renderMode: EffectPlayerRenderMode
    ) {
        // During reconfiguration on setRenderTarget videoSize and paths params aren't used, so we can leave them non-initialized.
        setRenderTarget(
            view: view,
            playerConfiguration: .init(renderMode: renderMode)
        )
    }
    
    @objc public func setRenderTarget(
        view: EffectPlayerView,
        playerConfiguration: EffectPlayerConfiguration?
    ) {
        view.effectPlayer = self.effectPlayer
        setRenderTarget(layer: view.layer as! CAMetalLayer, playerConfiguration: playerConfiguration)
    }
    
    /**
     * Use this method for offscreen rendering only. For onscreen rendering use version
     * wich accepts `EffectPlayerView`.
     */
    @objc public func setRenderTarget(
        layer: CAMetalLayer,
        playerConfiguration: EffectPlayerConfiguration?
    ) {
        // If we didn't provided new configuration, let's use current one as source for renderSize value.
        currentEffectPlayerConfiguration = playerConfiguration ?? currentEffectPlayerConfiguration
        self.layer = layer
        if let configuration = currentEffectPlayerConfiguration {
            renderTarget = RenderTarget(
                device: layer.device,
                effectPlayer: effectPlayer,
                renderSize: configuration.renderSize
            )
            activateMetalLayer()
            performAsync(onThread: renderThread) { [weak self] in
                self?.surfaceCreated(
                    width: Int32(configuration.renderSize.width),
                    height: Int32(configuration.renderSize.height)
                )
                self?.outputService?.videoSize = configuration.renderSize
                self?.effectPlayer?.effectManager()?.setEffectSize(
                    /* fxWidth: */ Int32(ceil(configuration.renderSize.width)),
                    fxHeight: Int32(ceil(configuration.renderSize.height))
                )
            }
        }
    }
    
    @objc public func removeRenderTarget() {
        stopRenderLoop()
        performSync(onThread: renderThread) {
            self.surfaceDestroyed()
            self.renderTarget = nil
        }
    }
    
    //MARK: - Device Orientation
    private static let deviceOrientationHandler = OrientationHandler()
    private var deviceOrientation = UIDeviceOrientation.portrait
    
    //MARK: - Render RunLoop
    private var renderRunLoop: DisplayLinkRunLoop!
    public private(set) var editingImageFrameData: BNBFrameData?
    private var editingImageSize: CGSize?
    private var pushSize: CGSize?
    private var surfaceSize: CGSize?
    
    private func setupRenderRunLoop() {
        renderRunLoop = DisplayLinkRunLoop(
            label: "com.banubaSdk.renderThread",
            framerate: playerConfiguration?.preferredRenderFrameRate ?? 60
        ) { [weak self] in
            guard let `self` = self else { return false }
            EAGLContext.setCurrent(self.context)
            return self.draw()
        }
    }
    
    @objc public var renderThread: Thread? {
        return renderRunLoop.renderThread
    }
    
    private func startRenderLoop() {
        synchronizationQueue.sync {
            renderRunLoop.isStoped = false
        }
    }
    
    private func stopRenderLoop() {
        synchronizationQueue.sync {
            renderRunLoop.isStoped = true
        }
    }
    
    //MARK: - App State Handling
    @objc public var shouldAutoStartOnEnterForeground = false
    private var appStateHandler: AppStateHandler!
    private func setupAppStateHandler() {
        self.appStateHandler.add(name: UIApplication.didEnterBackgroundNotification) { [weak self] (_) in
            guard let self = self, self.isLoaded else { return }
            self.stopEffectPlayer()
        }
        self.appStateHandler.add(name: UIApplication.willEnterForegroundNotification) { [weak self] (_) in
            guard let self = self, self.isLoaded, self.shouldAutoStartOnEnterForeground else { return }
            self.startEffectPlayer()
        }
        self.appStateHandler.add(name: UIApplication.willTerminateNotification) { [weak self] (_) in
            self?.input.stopCamera()
            self?.destroyEffectPlayer()
            BanubaSdkManager.deinitialize()
        }
    }
    
    //MARK: - Effect Player life circle
    @objc public private(set) var isLoaded = false
    @objc public override init() {
        super.init()
        setupRenderRunLoop()
    }
    
    /**
     * Intialize common banuba SDK resources. This must be called before `BanubaSdkManger` instance
     * creation. Counterpart `deinitialize` exists.
     *
     * - parameter resourcePath: paths to cutom resources folders
     * - parameter clientTokenString: client token
     * - parameter logLevel: log level
     */
    @objc public class func initialize(
        resourcePath: [String] = [],
        clientTokenString: String,
        logLevel: BNBSeverityLevel = .info
    ) {
        let bundleRoot = Bundle.init(for: BNBEffectPlayer.self).bundlePath
        let dirs = [bundleRoot + "/bnb-resources", bundleRoot + "/bnb-res-ios"] + resourcePath
        BNBUtilityManager.initialize(
            dirs,
            clientToken: clientTokenString.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        BNBUtilityManager.setLogLevel(logLevel)
    }
    
    /** Release common Banuba SDK resources */
    @objc public class func deinitialize() {
        BNBUtilityManager.release()
    }
    
    @objc deinit {
        inputService.stopCamera()
        if isLoaded {
            stopEffectPlayer()
            destroyEffectPlayer()
        }
    }
    
    internal func setupOutputService() {
        addRenderedFrameHandler { [weak self] (provider) in
            self?.outputService?.handle(frameProvider: provider)
        }
    }
    
    @objc public func setup(configuration: EffectPlayerConfiguration) {
        renderRunLoop.removeAllHandlers()
        appStateHandler = AppStateHandler(notificationCenter: configuration.notificationCenter)
        setupAppStateHandler()
        setupOutputService()
        shouldAutoStartOnEnterForeground = configuration.shouldAutoStartOnEnterForeground
        currentEffectPlayerConfiguration = configuration
        inputService.delegate = self
        performSync(onThread: renderThread) {
            self.initPlayer(configuration: configuration)
            self.isLoaded = true
        }
    }
    
    @objc public func destroy() {
        renderRunLoop.removeAllHandlers()
        stopOrientationDetection()
        synchronizationQueue.sync {
            isLoaded = false
        }
        inputService.delegate = nil
        
        //ALL listeners must be removed to avoid reference cycle
        effectPlayer?.remove(self as BNBCameraPoiListener)
        effectPlayer?.remove(self as BNBFaceNumberListener)
        if BanubaSdkManager.dumpFps {
            effectPlayer?.remove(self as BNBFrameDurationListener)
        }
        effectPlayer?.playbackStop()
        guard surfaceSize != nil else {
            effectPlayer = nil
            return
        }
        surfaceDestroyed()
    }
    
    private static let maxInputSize = Float(1024 * 768)
    
    /**
     * BNBEffectPlayer may crash on certain devices. So, we downscale the input image before processing.
     */
    @objc public static func scaleBeforeProcessing(_ buffer: CVPixelBuffer?) -> CVPixelBuffer? {
        guard let buffer = buffer else { return nil }
        if BNBUtilityManager.getHardwareClass() == .low {
            let width = Float(CVPixelBufferGetWidth(buffer))
            let height = Float(CVPixelBufferGetHeight(buffer))
            if width * height > BanubaSdkManager.maxInputSize {
                let scaleFactor = sqrt(BanubaSdkManager.maxInputSize / (width * height))
                return BNBCVPixelBufferCreateScaled(
                    buffer,
                    CGSize(
                        width: Int(width * scaleFactor),
                        height: Int(height * scaleFactor)
                    )
                )
            }
        }
        return buffer
    }
}

//MARK: - Orientation Helper
private extension BanubaSdkManager {
    func startOrientationDetection() {
        BanubaSdkManager.deviceOrientationHandler.start()
    }
    
    func stopOrientationDetection() {
        BanubaSdkManager.deviceOrientationHandler.stop()
    }
}

@objc extension BanubaSdkManager: InputServiceDelegate {
    public func push(cmBuffer: CMSampleBuffer) {
        guard isLoaded else { return }
        self.outputService?.handle(audioBuffer: cmBuffer)
    }
    
    public func push(cvBuffer: CVPixelBuffer) {
        guard isLoaded else { return }
        updateOrientation()
        pushFrame(frameBuffer: cvBuffer)
    }
    
#if BNB_ENABLE_ARKIT
    @available(iOS 11.0, *)
    public func push(frame: ARFrame, useBackCamera: Bool) {
        guard isLoaded else { return }
        updateOrientation()
        pushFrame(frame: frame, useBackCamera: useBackCamera)
    }
#endif
}

//MARK: Frame data capture
@objc public extension BanubaSdkManager {
    func setFrameDataRecord(_ isRecord: Bool) {
        if isRecord {
            let datetimeFmt = DateFormatter()
            datetimeFmt.dateFormat = "yyyy-MM-dd_hh-mm-ss"
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let filename = "frames_capture_ios_" + datetimeFmt.string(from: Date()) + ".bin"
            effectPlayer?.startFramedataCapture(documentsPath, filename: filename)
        }
        else {
            effectPlayer?.stopFramedataCapture()
        }
        
    }
}

//MARK: - Drawing And Capturing
internal extension BanubaSdkManager {
    func updateOrientation() {
        // TODO: Check performace here.
        // self.deviceOrientationHelper.deviceOrientation get value Sync from other queue
        //
        let isChanged = deviceOrientation != BanubaSdkManager.deviceOrientationHandler.deviceOrientation
        if isChanged, let angle = BanubaSdkManager.currentDeviceOrientation.effectsPlayerAngle {
            deviceOrientation = BanubaSdkManager.currentDeviceOrientation
            faceOrientation = autoRotationEnabled ? 0 : angle
        }
    }
    
    func addRenderedFrameHandler(handler: @escaping ((RenderedFrameProvider)->Void)) {
        renderRunLoop.addPostRender { [weak self] in
            guard let renderTarget = self?.renderTarget else { return }
            handler((renderTarget))
        }
    }
    
    private func draw() -> Bool {
        guard !renderRunLoop.isStoped, let renderTarget = self.renderTarget else {
            return false
        }
        var needToPresentBuffer: Int64?
        if let customFrameData = editingImageFrameData {
            needToPresentBuffer = effectPlayer?.draw(withExternalFrameData: customFrameData)
        } else {
            needToPresentBuffer = effectPlayer?.draw()
        }
        if needToPresentBuffer == Defaults.NothingToDraw {
            return false
        }
        delegate?.willPresentFramebuffer(renderSize: renderTarget.renderSize)
        return true
    }
}

//MARK: - Effect Player Management

@objc extension BanubaSdkManager {
    public func startEffectPlayer() {
        if !self.renderRunLoop.isStoped {
            return
        }
        startOrientationDetection()
        performSync(onThread: renderThread) {
            self.effectPlayer?.playbackPlay()
            self.startRenderLoop()
        }
    }
    
    public func stopEffectPlayer() {
        stopOrientationDetection()
        stopRenderLoop()
        performSync(onThread: renderThread) {
            self.effectPlayer?.playbackPause()
            // Stop render loop explicitly from queue, because previous task on render queue could start it,
            // and we can get mismatch in logic state (player is stopped, but render loop is not)
            self.stopRenderLoop()
        }
    }
    
    public func destroyEffectPlayer() {
        stopRenderLoop()
        removeRenderTarget()
        performSync(onThread: renderThread) {
            self.effectPlayer?.playbackPause()
            self.destroy()
        }
    }
    
    /// Image editing mode - renders effect on single frame prepared from image, applies effect on image in full resolution.
    ///
    /// Workflow to use editing:
    ///  - Configure effect player with correct render target and render size to match aspect ratio of edited image (could be done with setRenderTarget call), load needed effect.
    /// Pay attention that render size could be less than original image size (moreover, bigger resolution could cause performance issues), the only restriction is to preserve aspect ratio.
    ///  - Call startEditingImage. Completion block returns is any face found or not. From that moment image with applied effect is rendered on provided render target.
    ///  - Call captureEditedImage to get edited image with applied effect in fullsize resolution.
    ///  - Call stopEditingImage. After that moment user can switch to other render target and restore previous logic (push frames from camera), if needed.
    public func startEditingImage(
        _ image: UIImage,
        recognizerIterations: NSNumber? = nil,
        imageOrientation: BNBCameraOrientation = .deg0,
        requireMirroring: Bool = false,
        faceOrientation: Int = 0,
        fieldOfView: Float = 60,
        resetEffect: Bool = false,
        processParams: BNBProcessImageParams = BNBProcessImageParams(
            acneProcessing: false,
            acneUserAreas: nil,
            faceDataJsonPath: nil),
        completion: ((Int, CGRect) -> Void)? = nil
    ) {
        guard isLoaded, let frameBuffer = image.makeBgraPixelBuffer() else {
            completion?(0, .zero)
            return
        }
        stopRenderLoop()
        inputService.stopCamera()
        performAsync(onThread: renderThread) { [weak self] in
            autoreleasepool {
                guard let self = self else { return }
                self.editingImageSize = image.size
                self.activateMetalLayer()
                self.effectPlayer?.startVideoProcessing(
                    Int64(image.size.width),
                    screenHeight: Int64(image.size.height),
                    orientation: imageOrientation,
                    resetEffect: resetEffect,
                    offlineMode: true
                )
                let fullImageData = BNBFullImageData(
                    frameBuffer,
                    cameraOrientation: imageOrientation,
                    requireMirroring: requireMirroring,
                    faceOrientation: faceOrientation,
                    fieldOfView: fieldOfView
                )
                self.editingImageFrameData = self.effectPlayer?.processVideoFrame(
                    fullImageData,
                    params: processParams,
                    recognizerIterations: recognizerIterations
                )
                self.effectPlayer?.stopVideoProcessing(resetEffect)
                self.startRenderLoop()
                guard let frxResult = self.editingImageFrameData?.getFrxRecognitionResult() else {
                    completion?(0, .zero)
                    return
                }
                var faceRect: CGRect = .zero
                let faces = frxResult.getFaces()
                let facesCount = faces.filter { $0.hasFace() }.count
                if let faceInfo = faces.first {
                    guard let t = BNBTransformation.makeData(frxResult.getTransform().basisTransform),
                          let tInverse = t.inverseJ() else { return }
                    let facePixelRect = tInverse.transform(faceInfo.getFaceRect())
                    faceRect = CGRect(
                        x: Double(facePixelRect.x),
                        y: Double(facePixelRect.y),
                        width: Double(facePixelRect.w),
                        height: Double(facePixelRect.h)
                    )
                }
                completion?(facesCount, faceRect)
            }
        }
    }
    
    public func captureEditedImage(
        imageOrientation: BNBCameraOrientation = .deg0,
        resetEffect: Bool = false,
        completion: @escaping (UIImage?) -> Void) {
        guard isLoaded, let frameData = editingImageFrameData, let imageSize = editingImageSize else {
            completion(nil)
            return
        }
        stopRenderLoop()
        performAsync(onThread: renderThread) { [weak self] in
            autoreleasepool {
                guard let self = self else { return }
                self.activateMetalLayer()
                self.effectPlayer?.startVideoProcessing(
                    Int64(imageSize.width),
                    screenHeight: Int64(imageSize.height),
                    orientation: imageOrientation,
                    resetEffect: resetEffect,
                    offlineMode: true
                )
                var image: UIImage? = nil
                if let imageData = self.effectPlayer?.drawVideoFrame(frameData, timeNs: 0, outputPixelFormat: .bgra) {
                    image = UIImage(
                        bgraDataNoCopy: imageData as NSData,
                        width: Int(imageSize.width),
                        height: Int(imageSize.height)
                    )
                }
                self.effectPlayer?.stopVideoProcessing(resetEffect)
                self.startRenderLoop()
                completion(image)
            }
        }
    }
    
    public func stopEditingImage(startCameraInput: Bool = false) {
        guard isLoaded else { return }
        stopRenderLoop()
        performAsync(onThread: renderThread) { [weak self] in
            guard let self = self else { return }
            self.editingImageSize = nil
            self.editingImageFrameData = nil
            self.startRenderLoop()
        }
        if startCameraInput {
            inputService.startCamera()
        }
    }
    
    public func makeCameraPhoto(cameraSettings: CameraPhotoSettings, flipFrontCamera: Bool = false, srcImageHandler: ((CVPixelBuffer) -> Void)? = nil, completion: @escaping (UIImage?) -> Void) {
        guard inputService.isPhotoCameraSession else {
            completion(nil)
            return
        }
        
        if flipFrontCamera {
            self.input.flipCamera = true
        }
        
        let cameraInitDelay: DispatchTime = DispatchTime.now() + DispatchTimeInterval.milliseconds(Defaults.CameraDeviceInitializationDelay)
        DispatchQueue.main.asyncAfter(deadline: cameraInitDelay, execute: { [weak self] in
            self?.inputService.initiatePhotoCapture(
                cameraSettings: cameraSettings,
                completion: { cvImageBuffer, frameData in
                    guard let self = self,
                          let imageBuffer = cvImageBuffer else {
                        completion(nil)
                        return
                    }
                    srcImageHandler?(imageBuffer)
                    let width = UInt(CVPixelBufferGetWidth(imageBuffer))
                    let height = UInt(CVPixelBufferGetHeight(imageBuffer))
                    
                    // TODO:
                    // Frontal camera already makes mirrored photo, so if user wants non-mirrored photo (flipFrontCamera is set to false),
                    // we should mirror it again. For other cases we shouldn't do anything.
                    //let isMirrored = self.inputService.isFrontCamera && !flipFrontCamera
                    self.addFeatureParameters(frameData: frameData)
                    self.processImageFrameData(
                        frameData,
                        width: width,
                        height: height,
                        orientation: .deg90, // camera frames are rotated by default on iOS
                        completion: { (image) in
                            CVPixelBufferUnlockBaseAddress(imageBuffer, [])
                            completion(image)
                        }
                    )
                })
        })
    }
    
    public func processImageData(
        _ inputData: CVImageBuffer,
        orientation: BNBCameraOrientation = .deg0,
        faceOrientation: Int = 0,
        fieldOfView: Float = 60,
        isMirrored: Bool = false,
        completion: @escaping (UIImage?) -> Void
    ) {
        guard let input = BanubaSdkManager.scaleBeforeProcessing(inputData) else {
            completion(nil)
            return
        }
        let img =  BNBFullImageData(
            input,
            cameraOrientation: orientation,
            requireMirroring: isMirrored,
            faceOrientation: faceOrientation,
            fieldOfView: fieldOfView
        )
        let frameData = BNBFrameData.create()
        frameData?.addFullImg(img)
        processImageFrameData(
            frameData,
            width: UInt(CVPixelBufferGetWidth(input)),
            height: UInt(CVPixelBufferGetHeight(input)),
            orientation: orientation,
            completion: completion
        )
    }
    
    private func processImageFrameData(
        _ inputFrameData: BNBFrameData?,
        width: UInt,
        height: UInt,
        orientation: BNBCameraOrientation,
        params: BNBProcessImageParams = BNBProcessImageParams(acneProcessing: false, acneUserAreas:nil, faceDataJsonPath:nil),
        outputPixelFormat: BNBPixelFormat = .bgra,
        completion: @escaping (UIImage?) -> Void
    ) {
        guard let inputFrameData = inputFrameData else {
            completion(nil)
            return
        }
        stopRenderLoop()
        performAsync(onThread: renderThread) { [weak self] in
            EAGLContext.setCurrent(self?.context)
            //self?.currentEffect()?.callJsMethod(Defaults.startPhotoJSCall, params: "")
            defer {
                //self?.currentEffect()?.callJsMethod(Defaults.endPhotoJSCall, params: "")
                self?.startRenderLoop()
            }
            self?.activateMetalLayer()
            self?.addFeatureParameters(frameData: inputFrameData)
            guard let outputData = self?.effectPlayer?.processImageFrameData(
                    inputFrameData,
                    outputPixelFormat: outputPixelFormat,
                    params: params) else { return }
            let swapSizes = orientation == .deg90 || orientation == .deg270
            let targetWidth = swapSizes ? height : width
            let targetHeight = swapSizes ? width : height
            let processedImage = UIImage(
                bgraDataNoCopy: outputData as NSData,
                width: Int(targetWidth),
                height: Int(targetHeight)
            )
            completion(processedImage)
        }
    }
    
    public func processImageData(
        _ imputImage: UIImage,
        orientation: BNBCameraOrientation = .deg0,
        fieldOfView: Float = 60,
        isMirrored: Bool = false,
        params: BNBProcessImageParams = BNBProcessImageParams(acneProcessing: false, acneUserAreas:nil, faceDataJsonPath: nil),
        completion: @escaping (UIImage?) -> Void
    ) {
        stopRenderLoop()
        performAsync(onThread: renderThread) { [weak self] in
            autoreleasepool {
                //self?.currentEffect()?.callJsMethod(Defaults.startPhotoJSCall, params: "")
                defer {
                    //self?.currentEffect()?.callJsMethod(Defaults.endPhotoJSCall, params: "")
                }
                self?.activateMetalLayer()
                let imgProcessStart = DispatchTime.now()
                guard let data =  BanubaSdkManager.scaleBeforeProcessing(imputImage.makeBgraPixelBuffer()) else {
                    completion(nil)
                    return
                }
                let width = CVPixelBufferGetWidth(data)
                let height = CVPixelBufferGetHeight(data)
                let fd = BNBFrameData.create()
                fd?.addFullImg(BNBFullImageData(
                    data,
                    cameraOrientation: orientation,
                    requireMirroring: isMirrored,
                    faceOrientation: 0,
                    fieldOfView: fieldOfView
                ))
                self?.addFeatureParameters(frameData: fd)
                guard let processed = self?.effectPlayer?.processImageFrameData(
                        fd,
                        outputPixelFormat: .bgra,
                        params: params)
                else {
                    completion(nil)
                    return
                }
                let procImage = UIImage(
                    bgraDataNoCopy: processed as NSData,
                    width: width,
                    height: height
                )
                let processTime = (DispatchTime.now().uptimeNanoseconds -
                                    imgProcessStart.uptimeNanoseconds) / UInt64(1E6)
                print("Process image took \(processTime) ms")
                completion(procImage)
            }
        }
    }
    
    public func configureWatermark(_ watermarkInfo: WatermarkInfo) {
        outputService?.configureWatermark(watermarkInfo)
    }
    
    public func removeWatermark() {
        outputService?.removeWatermark()
    }
    
    public func startVideoProcessing(
        width: UInt,
        height: UInt,
        orientation: BNBCameraOrientation = .deg0,
        resetEffect: Bool = false
    ) {
        stopRenderLoop()
        performAsync(onThread: renderThread) { [weak self] in
            self?.effectPlayer?.playbackPlay()
            self?.effectPlayer?.startVideoProcessing(
                Int64(width),
                screenHeight: Int64(height),
                orientation: orientation,
                resetEffect: resetEffect,
                offlineMode: true)
        }
    }
    
    public func stopVideoProcessing(resetEffect: Bool = false) {
        stopRenderLoop()
        performAsync(onThread: renderThread) { [weak self] in
            self?.effectPlayer?.stopVideoProcessing(resetEffect)
        }
    }
    
    public func processVideoFrame(
        from: CVPixelBuffer,
        to: CVPixelBuffer,
        timeNs: Int64,
        iterations: NSNumber? = nil,
        cameraOrientation: BNBCameraOrientation = .deg0,
        requireMirroring: Bool = false,
        faceOrientation: Int = 0,
        fieldOfView: Float = 60,
        processImageParams: BNBProcessImageParams = BNBProcessImageParams(
            acneProcessing: false,
            acneUserAreas: nil,
            faceDataJsonPath: nil
        )
    ) {
        performSync(onThread: renderThread) {
            guard let effectPlayer = self.effectPlayer else { return }
            let image = BNBFullImageData(
                from,
                cameraOrientation: cameraOrientation,
                requireMirroring: requireMirroring,
                faceOrientation: faceOrientation,
                fieldOfView: fieldOfView
            )
            
            // TODO ep.processVideoFrameAllocated
            let fd = effectPlayer.processVideoFrame(
                image,
                params: processImageParams,
                recognizerIterations: iterations
            )
            
            autoreleasepool {
                let processed = effectPlayer.drawVideoFrame(
                    fd,
                    timeNs: timeNs,
                    outputPixelFormat: .bgra
                )
                
                // For debug:
                // let uiImage = UIImage(rgbaDataNoCopy: processed as NSData, width: outW, height: outH)
                let lockRwFlag = CVPixelBufferLockFlags(rawValue: 0)
                CVPixelBufferLockBaseAddress(to,  lockRwFlag)
                defer { CVPixelBufferUnlockBaseAddress(to, lockRwFlag) }
                guard let rwAddress = CVPixelBufferGetBaseAddress(to) else {
                    fatalError("CVPixelBufferGetBaseAddress resturned zero")
                }
                let outW = CVPixelBufferGetWidth(to)
                let outH = CVPixelBufferGetHeight(to)
                let outCount = CVPixelBufferGetBytesPerRow(to) * outH
                if processed.count == outCount {
                    // no strides in CVPixelBuffer
                    processed.copyBytes(
                        to: rwAddress.assumingMemoryBound(to: UInt8.self),
                        count: outCount
                    )
                } else {
                    let rowSize = CVPixelBufferGetBytesPerRow(to)
                    for r in 0 ..< outH {
                        let advance = rowSize * r
                        let range =  r * (outW * 4) ..< (r + 1) * (outW * 4)
                        processed.copyBytes(
                            to: rwAddress.advanced(by: advance).assumingMemoryBound(to: UInt8.self),
                            from: range
                        )
                    }
                }
            }
        }
    }
    
    // After making photo iOs camera produces image rotated CCW by 90 degrees,
    // so we should map device orientation onto image orientation for processing
    // Add ARKit orientation check in landcapeLeft and landscapeRight cases: ARKit camera produces flipped by horizontal image instead of standart camera. So we need to swap degrees for ARKit camera to correct UIImage.orientation.up and UIImage.orientation.down cases
    public var imageOrientationForCameraPhoto: BNBCameraOrientation {
        switch deviceOrientation {
        case .portrait:
            return .deg90
        case .portraitUpsideDown:
            return .deg270
        case .landscapeLeft:
            if isUsingARKit {
                return inputService.isFrontCamera ? .deg180 : .deg0
            } else {
                return inputService.isFrontCamera ? .deg0 : .deg180
            }
        case .landscapeRight:
            if isUsingARKit {
                return inputService.isFrontCamera ? .deg0 : .deg180
            } else {
                return inputService.isFrontCamera ? .deg180 : .deg0
            }
        default:
            return .deg90
        }
    }
    
    private func activateMetalLayer() {
        guard let renderTarget = renderTarget, let layer = layer else {
            return
        }
        renderTarget.activate(layer: layer)
    }
}

//MARK: - Wrapper Wrapping Private
private extension BanubaSdkManager {
    func initPlayer(configuration: EffectPlayerConfiguration) {
        let faceSearchMode = BNBUtilityManager.getHardwareClass() == .low ?
            BNBFaceSearchMode.medium : BNBFaceSearchMode.good
        effectPlayer = BNBEffectPlayer.create(
            BNBEffectPlayerConfiguration(
                fxWidth: Int32(configuration.renderSize.width),
                fxHeight: Int32(configuration.renderSize.height),
                nnEnable: BNBNnMode.automatically,
                faceSearch: faceSearchMode,
                jsDebuggerEnable: false,
                manualAudio: false
            )
        )
        guard let effectPlayer = effectPlayer else { return }

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        let videoSize = renderTarget?.renderSize ?? Defaults.standardVideoSize
        outputService = OutputService(
            effectPlayer: effectPlayer,
            input: input,
            queue: queue,
            videoSize: videoSize
        )
        effectPlayer.add(self as BNBCameraPoiListener)
        effectPlayer.add(self as BNBFaceNumberListener)
        if BanubaSdkManager.dumpFps {
            effectPlayer.add(self as BNBFrameDurationListener)
        }
    }
    
    func pushFrame(frameBuffer buffer:CVPixelBuffer) {
        delegate?.willOutput(pixelBuffer: buffer)
        
        synchronizationQueue.sync {
            guard !renderRunLoop.isStoped, isLoaded else { return }
            //TODO account pushSize for rotation
            pushSize = CVImageBufferGetDisplaySize(buffer)
            let img = BNBFullImageData(
                buffer,
                cameraOrientation: currentEffectPlayerConfiguration?.orientation ?? .deg0,
                requireMirroring: currentEffectPlayerConfiguration?.isMirrored ?? false,
                faceOrientation: faceOrientation,
                fieldOfView: inputService.currentFieldOfView
            )
            let fd = BNBFrameData.create()
            fd?.addFullImg(img)
            addFeatureParameters(frameData: fd)
            effectPlayer?.push(fd)
        }
    }
    
#if BNB_ENABLE_ARKIT
    @available(iOS 11.0, *)
    func pushFrame(frame: ARFrame, useBackCamera: Bool) {
        delegate?.willOutput(arFrame: frame)
        
        synchronizationQueue.sync {
            guard !renderRunLoop.isStoped, isLoaded else { return }
            let fd = BNBFrameData.create(
                arFrame: frame,
                useBanubaTracking: useBackCamera,
                faceOrientation: faceOrientation,
                fieldOfView: inputService.currentFieldOfView
            )
            addFeatureParameters(frameData: fd)
            effectPlayer?.push(fd)
        }
    }
#endif
    
    func surfaceCreated(width: Int32, height: Int32) {
        surfaceSize = CGSize(width: Int(width), height: Int(height))
        effectPlayer?.surfaceCreated(width, height: height)
    }
    
    func surfaceDestroyed() {
        surfaceSize = nil
        effectPlayer?.surfaceDestroyed()
    }
    
    func addFeatureParameters(frameData: BNBFrameData?) {
        if let params = self.featureParameters {
            frameData?.add(params)
        }
    }
}

extension UIDeviceOrientation {
    var effectsPlayerAngle: Int? {
        switch self {
        case .portrait:
            return 0
        case .portraitUpsideDown:
            return 180
        case .landscapeLeft:
            return -90
        case .landscapeRight:
            return 90
        default:
            return nil
        }
    }
}


//MARK: - Effect Player callbacks
extension BanubaSdkManager: BNBCameraPoiListener {
    public func onCameraPoiChanged(_ x: Float, y: Float) {
        //        TODO: Fix exposure for camera roi tracking!
        //        let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
        //        inputService.configureExposureSettings(point, useContinuousDetection: true)
    }
}

extension BanubaSdkManager: BNBFaceNumberListener {
    public func onFaceNumberChanged(_ faceNumber: Int32) {
        if faceNumber == 0 {
            // set exposure POI to screen center when no face
            let point = CGPoint(x: 0.5, y: 0.5)
            inputService.configureExposureSettings(point, useContinuousDetection: true)
        }
    }
}

extension BanubaSdkManager: BNBFrameDurationListener {
    private static var lastPrintTime: [Date] = [Date(), Date(), Date()]
    private static let interval = 3.0
    fileprivate static let dumpFps = false
    private static let startTime = Date()
    
    public func onRecognizerFrameDurationChanged(
        _ instant: Float,
        averaged: Float
    ) {
        if -BanubaSdkManager.lastPrintTime[0].timeIntervalSinceNow >=
            BanubaSdkManager.interval {
            print("Recogniser FPS:\t\(1 / instant);\tavg: \( 1 / averaged)." +
                    "\tRunning \(BanubaSdkManager.duration)")
            BanubaSdkManager.lastPrintTime[0] = Date()
        }
    }
    
    public func onCameraFrameDurationChanged(_ instant: Float, averaged: Float) {
        if -BanubaSdkManager.lastPrintTime[1].timeIntervalSinceNow >=
            BanubaSdkManager.interval {
            print("Camera FPS:\t\t\(1 / instant); avg:\t\(1 / averaged)." +
                    "\tRunning \(BanubaSdkManager.duration)")
            BanubaSdkManager.lastPrintTime[1] = Date()
        }
    }
    
    public func onRenderFrameDurationChanged(_ instant: Float, averaged: Float) {
        if -BanubaSdkManager.lastPrintTime[2].timeIntervalSinceNow >=
            BanubaSdkManager.interval {
            print("Rendering FPS:\t\t\(1 / instant); avg:\t\(1 / averaged)." +
                    "\tRunning \(BanubaSdkManager.duration)")
            BanubaSdkManager.lastPrintTime[2] = Date()
        }
    }
    
    private static var duration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 2
        return formatter.string(
            from: -BanubaSdkManager.startTime.timeIntervalSinceNow
        ) ?? ""
    }
}
