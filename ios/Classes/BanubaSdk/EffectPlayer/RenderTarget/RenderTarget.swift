import BanubaEffectPlayer

@objc public class RenderedFrame: NSObject {
    public var bytes: Data
    public var size: CGSize
    public init(bytes: Data, size: CGSize) {
        self.bytes = bytes
        self.size = size
    }
}

internal protocol RenderedFrameProvider {
    func makeRenderedFrame() -> RenderedFrame?
}

@objc public class RenderTarget: NSObject, RenderedFrameProvider {
    private var layer: CAMetalLayer?
    private var device: MTLDevice?
    private var effectPlayer: BNBEffectPlayer?
    private(set) var renderSize: CGSize

    @objc init(
        device: MTLDevice?,
        effectPlayer: BNBEffectPlayer?,
        renderSize: CGSize
    ) {
        self.device = device
        self.effectPlayer = effectPlayer
        self.renderSize = renderSize
        super.init()
    }
    
    @objc public func makeRenderedFrame() -> RenderedFrame? {
        guard let readResult = effectPlayer?.readPixels() else { return nil }
        return RenderedFrame(bytes: readResult.data, size: renderSize)
    }
    
    @objc public func activate(layer: CAMetalLayer) {
        self.layer = layer
        effectPlayer?.effectManager()?.setRenderSurface(
            Int64(Int(bitPattern: Unmanaged.passUnretained(layer).toOpaque()))
        )
    }
}
