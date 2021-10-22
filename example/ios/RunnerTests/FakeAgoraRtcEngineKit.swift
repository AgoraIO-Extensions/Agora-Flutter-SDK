import Foundation
import AgoraRtcKit
import agora_rtc_engine

class FakeAgoraRtcEngineKit : AgoraRtcEngineKit {
    override func setAppType(_ appType: AgoraRtcAppType) -> Int32 {
        return 0
    }
}
