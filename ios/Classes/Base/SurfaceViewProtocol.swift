import AgoraRtcKit
import Foundation

protocol SurfaceViewProtocol {
    func setData(_ engine: AgoraRtcEngineKit, _ channel: AgoraRtcChannel?, _ uid: UInt)

    func setRenderMode(_ engine: AgoraRtcEngineKit, _ renderMode: UInt)

    func setMirrorMode(_ engine: AgoraRtcEngineKit, _ mirrorMode: UInt)
}
