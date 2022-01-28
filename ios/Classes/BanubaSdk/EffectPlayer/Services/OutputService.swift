import UIKit
import Accelerate
import BanubaEffectPlayer
import Metal

@objc public protocol OutputServicing: AnyObject {
    func configureWatermark(_ watermarkInfo: WatermarkInfo)
    func takeSnapshot(handler:@escaping (UIImage?)->Void)
    func takeSnapshot(configuration: OutputConfiguration, handler:@escaping (UIImage?)->Void)
    func removeWatermark()
    func startVideoCapturing(
        fileURL: URL?,
        completion: @escaping (Bool, Error?) -> Void
    )
    func startVideoCapturing(
        fileURL: URL?,
        configuration: OutputConfiguration,
        completion: @escaping (Bool, Error?) -> Void
    )
    func startVideoCapturing(
        fileURL: URL?,
        progress: ((CMTime) -> Void)?,
        periodicProgressTimeInterval: TimeInterval,
        boundaryTimes: [NSValue]?,
        boundaryHandler: ((CMTime) -> Void)?,
        totalDuration: TimeInterval,
        completion: @escaping (Bool, Error?) -> Void
    )
    func startVideoCapturing(
        fileURL: URL?,
        progress: ((CMTime) -> Void)?,
        periodicProgressTimeInterval: TimeInterval,
        boundaryTimes: [NSValue]?,
        boundaryHandler: ((CMTime) -> Void)?,
        totalDuration: TimeInterval,
        configuration: OutputConfiguration,
        completion: @escaping (Bool, Error?) -> Void
    )
    func stopVideoCapturing(cancel:Bool)
    func startForwardingFrames(
        configuration: OutputConfiguration,
        handler: @escaping (CVPixelBuffer) -> Void
    )
    func startForwardingFrames(
        handler: @escaping (CVPixelBuffer) -> Void
    )
    func stopForwardingFrames()
    func reset()
    func hasDiskCapacityForRecording() -> Bool
    func startMuteEffectSoundIfNeeded()
    func stopMuteEffectSound()
    var isRecording: Bool { get }
    var videoSize: CGSize { get set }
}

@objc public class OutputConfiguration: NSObject {
    @objc public let applyWatermark: Bool
    @objc public let adjustDeviceOrientation: Bool
    @objc public let mirrorFrontCamera: Bool
    
    @objc public init(
        applyWatermark: Bool,
        adjustDeviceOrientation: Bool,
        mirrorFrontCamera: Bool
    ) {
        self.applyWatermark = applyWatermark
        self.adjustDeviceOrientation = adjustDeviceOrientation
        self.mirrorFrontCamera = mirrorFrontCamera
    }
    
    @objc public static var defaultConfiguration: OutputConfiguration {
        return OutputConfiguration(
            applyWatermark: true,
            adjustDeviceOrientation: false,
            mirrorFrontCamera: true
        )
    }
}

internal class OutputService: NSObject {
    private struct Defaults {
        static let pixelBufferWriterLimit = 30
        static let pixelBufferPoolInitialSize = 3
        static let targetPixelFormat = kCVPixelFormatType_32BGRA
        static let availablePixelFormatRemapping: [OSType: [UInt8]] = [
            kCVPixelFormatType_32BGRA: [2, 1, 0, 3],
            kCVPixelFormatType_32ARGB: [1, 2, 3, 0],
            kCVPixelFormatType_32RGBA: [0, 1, 2, 3],
            kCVPixelFormatType_32ABGR: [3, 2, 1, 0]
        ]
    }
    public var videoSize: CGSize {
        didSet {
            if oldValue != videoSize {
                videoWriter = nil
                pixelBufferPool = nil
                guard let watermarkInfo = watermarkInfo,
                    let _ = watermarkPixelBuffer else { return }
                configureWatermark(watermarkInfo)
            }
        }
    }
    private var watermarkInfo: WatermarkInfo?
    private var watermarkOutputSettings: OutputSettings?
    internal var snapshotHandler: ((UIImage?)->Void)?
    internal var frameHandler: ((CVPixelBuffer)->Void)?
    public var synchronousVideoCapturing = false
    public private (set) var isRecording = false
    private var snapshotOutputSettings: OutputSettings? = nil
    private var videoOutputSettings: OutputSettings? = nil
    private var videoWriter: SBVideoWriter?
    private var pixelBufferPool: CVPixelBufferPool?
    private let queue: OperationQueue
    private let fileManager = FileManager.default
    private let effectPlayer: BNBEffectPlayer
    private let input: InputServicing
    private var watermarkPixelBuffer: CVPixelBuffer?
    
    public init(
        effectPlayer: BNBEffectPlayer,
        input: InputServicing,
        queue:OperationQueue,
        videoSize: CGSize
    ) {
        self.queue = queue
        self.videoSize = videoSize
        self.effectPlayer = effectPlayer
        self.input = input
    }
    
    internal func removeFile(fileURL:URL) {
        if fileManager.fileExists(atPath: fileURL.path) {
            try? fileManager.removeItem(at: fileURL)
        }
    }
}

extension OutputService: OutputServicing {
    public func startForwardingFrames(
        configuration: OutputConfiguration,
        handler: @escaping (CVPixelBuffer) -> Void
    ) {
        self.frameHandler = handler
        self.videoOutputSettings = makeOutputSettings(configuration)
    }
    
    func startForwardingFrames(handler: @escaping (CVPixelBuffer) -> Void) {
        startForwardingFrames(configuration: .defaultConfiguration, handler: handler)
    }
    
    public func stopForwardingFrames() {
        self.frameHandler = nil
        self.videoOutputSettings = nil
    }
    
    public func reset() {
        videoWriter = nil
        isRecording = false
    }
    
    public func configureWatermark(_ watermarkInfo: WatermarkInfo) {
        configureWatermark(watermarkInfo, configuration: OutputConfiguration.defaultConfiguration)
    }
    
    private func configureWatermark(_ watermarkInfo: WatermarkInfo, configuration: OutputConfiguration) {
        self.watermarkInfo = watermarkInfo
        let watermarkSettings = makeOutputSettings(configuration)
        watermarkOutputSettings = watermarkSettings
        watermarkPixelBuffer = createWatermarkPixelBuffer(
            watermarkInfo: watermarkInfo,
            targetSize: self.videoSize,
            targetPixelFormat: Defaults.targetPixelFormat,
            outputSettings: watermarkSettings
        )
    }
    
    public func removeWatermark() {
        watermarkPixelBuffer = nil
        watermarkInfo = nil
    }
    
    public func takeSnapshot(handler:@escaping (UIImage?)->Void) {
        takeSnapshot(configuration: OutputConfiguration.defaultConfiguration, handler: handler)
    }
    
    public func takeSnapshot(configuration: OutputConfiguration, handler: @escaping (UIImage?) -> Void) {
        snapshotOutputSettings = makeOutputSettings(configuration)
        adjustWatermarkIfNeeded(newConfiguration: configuration)
        snapshotHandler = { (snapshot) in
            DispatchQueue.main.async {
                handler(snapshot)
            }
        }
    }
    
    public func startVideoCapturing(
        fileURL: URL?,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        startVideoCapturing(
            fileURL: fileURL,
            configuration: OutputConfiguration.defaultConfiguration,
            completion: completion
        )
    }
    
    public func startVideoCapturing(
        fileURL: URL?,
        configuration: OutputConfiguration,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        startVideoCapturing(
            fileURL: fileURL,
            progress: nil,
            periodicProgressTimeInterval: 0,
            boundaryTimes: nil,
            boundaryHandler: nil,
            totalDuration: 0,
            configuration: configuration,
            completion: completion
        )
    }
    
    public func startVideoCapturing(
        fileURL: URL?,
        progress: ((CMTime) -> Void)?,
        periodicProgressTimeInterval: TimeInterval,
        boundaryTimes: [NSValue]?,
        boundaryHandler: ((CMTime) -> Void)?,
        totalDuration: TimeInterval,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        startVideoCapturing(
            fileURL: fileURL,
            progress: progress,
            periodicProgressTimeInterval: periodicProgressTimeInterval,
            boundaryTimes: boundaryTimes,
            boundaryHandler: boundaryHandler,
            totalDuration: totalDuration,
            configuration: OutputConfiguration.defaultConfiguration,
            completion: completion
        )
    }
    
    public func startVideoCapturing(
        fileURL: URL?,
        progress: ((CMTime) -> Void)?,
        periodicProgressTimeInterval: TimeInterval,
        boundaryTimes: [NSValue]?,
        boundaryHandler: ((CMTime) -> Void)?,
        totalDuration: TimeInterval,
        configuration: OutputConfiguration,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        queue.addOperation { [weak self] in
            guard let self = self else { return }
            if let url = fileURL, self.videoWriter == nil {
                self.removeFile(fileURL: url)
                self.adjustWatermarkIfNeeded(newConfiguration: configuration)
                let settings = self.makeOutputSettings(configuration)
                self.videoOutputSettings = settings
                self.videoWriter = SBVideoWriter(size: self.videoSize, outputSettings: settings)
                self.videoWriter?.prepareInputs(url)
            }
            guard !self.isRecording, let writer = self.videoWriter else { return }
            self.isRecording = true
            writer.startCapturingScreen(
                progress: progress,
                periodicProgressTimeInterval: periodicProgressTimeInterval,
                boundaryTimes: boundaryTimes,
                boundaryHandler: boundaryHandler,
                totalDuration: totalDuration,
                limitReachedHandler: { [weak self] in
                    self?.stopVideoCapturing(cancel: false)    
                }
            ) { [weak self] (success, error) in
                self?.videoWriter = nil
                DispatchQueue.main.async {
                    completion(success, error)
                }
            }
        }
    }
    
    public func stopVideoCapturing(cancel:Bool) {
        queue.addOperation { [weak self] in
            guard let self = self else { return }
            defer { self.isRecording = false }
            guard let writer = self.videoWriter, self.isRecording else { return }
            if cancel {
                writer.discardCapturing()
                self.videoWriter = nil
            } else {
                writer.stopCapturing()
            }
        }
    }
    
    public func startMuteEffectSoundIfNeeded() {
        effectPlayer.onVideoRecordStart()
    }
    
    public func stopMuteEffectSound() {
        effectPlayer.onVideoRecordEnd()
    }
    
    public func hasDiskCapacityForRecording() -> Bool {
        return SBVideoWriter.isEnoughDiskSpaceForRecording()
    }
    
}

//MARK: - Handlers
internal extension OutputService {
    func handle(frameProvider: RenderedFrameProvider) {
        if let frameHandler = self.frameHandler {
            guard let frame = frameProvider.makeRenderedFrame() else { return }
            guard let bufferPool = self.preparePixelBufferPool(sourceFrame: frame),
                let processedBuffer = prepareVideoPixelBuffer(
                    sourceFrame: frame,
                    pixelBufferPool: bufferPool
                ) else { return }
            frameHandler(processedBuffer)
        } else {
            guard let writer = self.videoWriter, isRecording else { return }
            guard let frame = frameProvider.makeRenderedFrame() else { return }
            guard let bufferPool = self.preparePixelBufferPool(sourceFrame: frame),
                let processedBuffer = prepareVideoPixelBuffer(
                    sourceFrame: frame,
                    pixelBufferPool: bufferPool
                ) else { return }
            if queue.operationCount < Defaults.pixelBufferWriterLimit {
                queue.addOperation {
                    writer.pushVideoSampleBuffer(processedBuffer)
                }
            }
        }
        
        // TODO for snapshot:
        /*
        guard let handler = snapshotHandler, let settings = snapshotOutputSettings else { return }
        defer {
            snapshotHandler = nil
            snapshotOutputSettings = nil
        }
        let watermarkBuffer = settings.applyWatermark ? watermarkPixelBuffer : nil
        let image = provider.makeSnapshotWithSettings(
            settings,
            watermarkPixelBuffer: watermarkBuffer
        )
        handler(image)
        */
    }
    
    private func makeOutputSettings(_ configuration: OutputConfiguration) -> OutputSettings {
        let orientation = configuration.adjustDeviceOrientation ?
            BanubaSdkManager.currentDeviceOrientation : .portrait
        let isMirrored = configuration.mirrorFrontCamera && input.isFrontCamera
        return OutputSettings(
            orientation: orientation,
            isMirrored: isMirrored,
            applyWatermark: configuration.applyWatermark
        )
    }
    
    private func preparePixelBufferPool(sourceFrame: RenderedFrame) -> CVPixelBufferPool? {
        guard pixelBufferPool == nil else { return pixelBufferPool }
        let width = self.videoSize.width
        let height = self.videoSize.height
        let pixelBufferPoolOptions: NSDictionary = [
            kCVPixelBufferPoolMinimumBufferCountKey: Defaults.pixelBufferPoolInitialSize
        ]
        
        let sourcePixelBufferOptions: NSDictionary = [
            kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey: width,
            kCVPixelBufferHeightKey: height,
            kCVPixelBufferIOSurfacePropertiesKey: NSDictionary()
        ]
        let ret = CVPixelBufferPoolCreate(
            kCFAllocatorDefault,
            pixelBufferPoolOptions,
            sourcePixelBufferOptions,
            &pixelBufferPool
        )
        if ret != kCVReturnSuccess {
            print("Failed to create CVPixelBufferPool: \(ret)")
        }
        return pixelBufferPool
    }
    
    private func prepareVideoPixelBuffer(
        sourceFrame: RenderedFrame,
        pixelBufferPool: CVPixelBufferPool
    ) -> CVPixelBuffer? {
        
        func applyFlipTransformations(bufferInfo: inout vImage_Buffer, settings: OutputSettings) {
            if settings.shouldApplyVerticalFlip {
                vImageVerticalReflect_ARGB8888(&bufferInfo, &bufferInfo, UInt32(kvImageNoFlags))
            }
            if settings.shouldApplyHorizontalFlip {
                vImageHorizontalReflect_ARGB8888(&bufferInfo, &bufferInfo, UInt32(kvImageNoFlags))
            }
        }
        
        var buffer: CVPixelBuffer?
        CVPixelBufferPoolCreatePixelBuffer(nil, pixelBufferPool, &buffer)
        guard let resultBuffer = buffer, let outputSettings = videoOutputSettings else { return nil }
        CVPixelBufferLockBaseAddress(resultBuffer, [])
        defer {
            CVPixelBufferUnlockBaseAddress(resultBuffer, [])
        }
        let dst = CVPixelBufferGetBaseAddress(resultBuffer)
        let width = UInt(videoSize.width)
        let height = UInt(videoSize.height)
        let bytesPerRow = Int(width * 4)
        
        // If user configured watermark previously, we should apply it right now.
        // vImagePremultipliedAlphaBlend_BGRA8888 leaves bottom and top data unchanged, and places result into destination
        if let watermark = watermarkPixelBuffer, outputSettings.applyWatermark {
            let watermarkWidth = UInt(CVPixelBufferGetWidth(watermark))
            let watermarkHeight = UInt(CVPixelBufferGetHeight(watermark))
            if watermarkWidth == width && watermarkHeight == height {
                CVPixelBufferLockBaseAddress(watermark, [])
                defer { CVPixelBufferUnlockBaseAddress(watermark, []) }
                let watermarkAddress = CVPixelBufferGetBaseAddress(watermark)
                let watermarkBytesPerRow = CVPixelBufferGetBytesPerRow(watermark)
                
                var srcBufferInfo = vImage_Buffer()
                srcBufferInfo.width = width
                srcBufferInfo.height = height
                srcBufferInfo.rowBytes = bytesPerRow

                sourceFrame.bytes.copyBytes(
                    to: srcBufferInfo.data.assumingMemoryBound(to: UInt8.self),
                    count: bytesPerRow * Int(height)
                )
                
                var dstBufferInfo = vImage_Buffer(
                    data: dst,
                    height: height,
                    width: width,
                    rowBytes: bytesPerRow
                )
                var watermarkBufferInfo = vImage_Buffer(
                    data: watermarkAddress,
                    height: watermarkHeight,
                    width: watermarkWidth,
                    rowBytes: watermarkBytesPerRow
                )
                applyFlipTransformations(bufferInfo: &srcBufferInfo, settings: outputSettings)
                vImagePremultipliedAlphaBlend_BGRA8888(
                    &watermarkBufferInfo,
                    &srcBufferInfo,
                    &dstBufferInfo,
                    UInt32(kvImageNoFlags)
                )
                
                guard let pixelFormatRemapper = Defaults.availablePixelFormatRemapping[kCVPixelFormatType_32BGRA] else {
                    CVPixelBufferUnlockBaseAddress(watermark, [])
                    return resultBuffer
                }
                
                vImagePermuteChannels_ARGB8888(
                    &srcBufferInfo,
                    &dstBufferInfo,
                    pixelFormatRemapper,
                    UInt32(kvImageNoFlags))
                
                return resultBuffer
            }
        }

        sourceFrame.bytes.copyBytes(
            to: dst!.assumingMemoryBound(to: UInt8.self),
            count: bytesPerRow * Int(height)
        )
  
        var bufferInfo = vImage_Buffer(
            data: dst,
            height: height,
            width: width,
            rowBytes: bytesPerRow
        )
        
        guard let pixelFormatRemapper = Defaults.availablePixelFormatRemapping[kCVPixelFormatType_32BGRA] else {
            applyFlipTransformations(bufferInfo: &bufferInfo, settings: outputSettings)
            return resultBuffer
        }
        
        vImagePermuteChannels_ARGB8888(
            &bufferInfo,
            &bufferInfo,
            pixelFormatRemapper,
            UInt32(kvImageNoFlags))
        
        applyFlipTransformations(bufferInfo: &bufferInfo, settings: outputSettings)
        
        return resultBuffer
    }
    
    func handle(audioBuffer buffer:CMSampleBuffer) {
        queue.addOperation { [weak self] in
            guard let self = self, let writer = self.videoWriter, self.isRecording else { return }
            writer.pushAudioSampleBuffer(buffer)
        }
    }
    
    private func adjustWatermarkIfNeeded(newConfiguration: OutputConfiguration) {
        guard newConfiguration.applyWatermark, let watermarkInfo = watermarkInfo else { return }
        let newSettings = makeOutputSettings(newConfiguration)
        var shouldRecreate = true
        if let settings = watermarkOutputSettings,
            settings.deviceOrientation == newSettings.deviceOrientation {
            
            shouldRecreate = false
        }
        if shouldRecreate {
            removeWatermark()
            configureWatermark(watermarkInfo, configuration: newConfiguration)
        }
    }
    
    private func createWatermarkPixelBuffer(
        watermarkInfo: WatermarkInfo,
        targetSize: CGSize,
        targetPixelFormat: OSType,
        outputSettings: OutputSettings
    ) -> CVPixelBuffer? {
        guard let cgImage = watermarkInfo.image.cgImage,
            Defaults.availablePixelFormatRemapping.keys.contains(targetPixelFormat) else { return nil }
        let bufferWidth = Int(targetSize.width)
        let bufferHeight = Int(targetSize.height)
        var pixelBuffer:CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            bufferWidth,
            bufferHeight,
            targetPixelFormat,
            nil,
            &pixelBuffer
        )
        guard status == kCVReturnSuccess, let buffer = pixelBuffer else { return nil }
        
        //----------draw from image to pixelbuffer (image source has RGBA channels)
        CVPixelBufferLockBaseAddress(buffer, [])
        let bufferData = CVPixelBufferGetBaseAddress(buffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(buffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: cgImage.alphaInfo.rawValue)
        let graphicContext = CGContext(
            data: bufferData,
            width: bufferWidth,
            height: bufferHeight,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )
        guard let context = graphicContext else { return nil }
        let drawSettings = watermarkInfo.drawSettingsWithBoundsSize(targetSize, outputSettings: outputSettings)
        context.translateBy(x: drawSettings.translatePos.x, y: drawSettings.translatePos.y)
        context.rotate(by: drawSettings.rotationAngle)
        UIGraphicsPushContext(context)
        context.draw(cgImage, in: drawSettings.drawRect)
        CVPixelBufferUnlockBaseAddress(buffer, [])
        
        //----------permute channels in result pixelbuffer, if targetPixelFormat differs from RGBA (image source)
        guard targetPixelFormat != kCVPixelFormatType_32RGBA,
            let pixelFormatRemapper = Defaults.availablePixelFormatRemapping[targetPixelFormat]
        else { return buffer }
        CVPixelBufferLockBaseAddress(buffer, [])
        let resultData = CVPixelBufferGetBaseAddress(buffer)
        var bufferInfo = vImage_Buffer(
            data: resultData,
            height: UInt(bufferHeight),
            width: UInt(bufferWidth),
            rowBytes: bytesPerRow
        )
        vImagePermuteChannels_ARGB8888(
            &bufferInfo, &bufferInfo,
            pixelFormatRemapper,
            UInt32(kvImageNoFlags)
        )
        CVPixelBufferUnlockBaseAddress(buffer, [])
        UIGraphicsPopContext()
        return buffer
    }
}

private extension DispatchQueue {
    func execute(_ workItem: DispatchWorkItem, sync: Bool) {
        if sync {
            self.sync(execute: workItem)
        } else {
            self.async(execute: workItem)
        }
    }
}
