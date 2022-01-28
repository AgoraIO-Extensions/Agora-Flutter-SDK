import AgoraRtcKit
import Foundation
import UIKit

class BanubaRtcSurfaceView: UIView {
    // private var canvas: AgoraRtcVideoCanvas
    private weak var channel: AgoraRtcChannel?
    private var effectView: EffectPlayerView
    private var sdkManager = BanubaSdkManager()
    private var agoraKit: AgoraRtcEngineKit?
    private var canvas: AgoraRtcVideoCanvas

    override init(frame: CGRect) {
        effectView = EffectPlayerView(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: frame.size.width > 0 ? frame.size : CGSize(
                    width: UIScreen.main.bounds.size.width,
                    height: UIScreen.main.bounds.size.height
                )
            )
        )
        effectView.layoutIfNeeded()
        canvas = AgoraRtcVideoCanvas()
        canvas.view = effectView

        super.init(frame: CGRect(
            origin: CGPoint.zero,
            size: CGSize(
                width: UIScreen.main.bounds.size.width,
                height: UIScreen.main.bounds.size.height
            )
        ))

        addSubview(effectView)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        if (newSuperview != nil) {
            initializeBanuba()

            effectView.effectPlayer = sdkManager.effectPlayer
            sdkManager.setup(configuration: EffectPlayerConfiguration(renderMode: .video))
            sdkManager.setRenderTarget(layer: effectView.layer as! CAMetalLayer, playerConfiguration: nil)
            sdkManager.input.startCamera()

            // Disable effect audio
            let em = sdkManager.effectPlayer?.effectManager()
            em?.setEffectVolume(0)

            _ = sdkManager.loadEffect("Afro")

            sdkManager.startEffectPlayer()
            sdkManager.output?.startForwardingFrames(handler: { (pixelBuffer) -> Void in
                self.pushPixelBufferIntoAgoraKit(pixelBuffer: pixelBuffer)
            })
        }
        else {
            canvas.view = nil

            sdkManager.input.stopCamera()
            sdkManager.destroyEffectPlayer()
            BanubaSdkManager.deinitialize()
        }
    }

    private func initializeBanuba() {
        BanubaSdkManager.initialize(
            resourcePath: [Bundle.main.bundlePath + "/effects"],
            clientTokenString: <#SET_BANUBA_SDK_TOKEN#>
        )
    }

    private func pushPixelBufferIntoAgoraKit(pixelBuffer: CVPixelBuffer) {
        let videoFrame = AgoraVideoFrame()
        //Video format = 12 means iOS texture (CVPixelBufferRef)
        videoFrame.format = 12
        videoFrame.time = CMTimeMakeWithSeconds(NSDate().timeIntervalSince1970, preferredTimescale: 1000)
        videoFrame.textureBuf = pixelBuffer
        if let engine = self.agoraKit {
          engine.pushExternalVideoFrame(videoFrame)
        }
    }

    private func setupRenderMode(_ engine: AgoraRtcEngineKit) {
        if let engine = self.agoraKit {
            engine.setLocalRenderMode(canvas.renderMode, mirrorMode: canvas.mirrorMode)
        }
    }
}

extension BanubaRtcSurfaceView: SurfaceViewProtocol {
    func setData(_ engine: AgoraRtcEngineKit, _ channel: AgoraRtcChannel?, _ uid: UInt) {
        self.channel = channel
        canvas.channelId = channel?.getId()
        canvas.uid = uid
        self.agoraKit = engine;

        // setupVideo
        engine.setExternalVideoSource(true, useTexture: false, pushMode: true)
        engine.enableVideo()
        engine.setupLocalVideo(canvas)
    }

    func setRenderMode(_ engine: AgoraRtcEngineKit, _ renderMode: UInt) {
        canvas.renderMode = AgoraVideoRenderMode(rawValue: renderMode)!
        setupRenderMode(engine)
    }

    func setMirrorMode(_ engine: AgoraRtcEngineKit, _ mirrorMode: UInt) {
        canvas.mirrorMode = AgoraVideoMirrorMode(rawValue: mirrorMode)!
        setupRenderMode(engine)
    }
}
