import Foundation
import agora_rtc_engine

class CustomCaptureAudioPlugin : NSObject, RtcEnginePlugin, CustomCaptureAudioApi {

    private var agoraRtcEngineKit: AgoraRtcEngineKit? = nil

    private var exAudio: ExternalAudio? = nil

    func onRtcEngineCreated(_ rtcEngine: AgoraRtcEngineKit?) {
        agoraRtcEngineKit = rtcEngine
    }

    func onRtcEngineDestroyed() {
        agoraRtcEngineKit = nil
    }

    func setExternalAudioSourceEnabled(_ enabled: NSNumber, sampleRate: NSNumber, channels: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        agoraRtcEngineKit?.enableExternalAudioSource(
            withSampleRate: UInt(truncating: sampleRate),
            channelsPerFrame: UInt(truncating: channels))
    }

    func setExternalAudioSourceVolumeSourcePos(_ sourcePos: NSNumber, volume: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let pos = AgoraAudioExternalSourcePos(
            rawValue: UInt(truncating: sourcePos))!
        agoraRtcEngineKit?.setExternalAudioSourceVolume(
            pos,
            volume: UInt(truncating: volume))
    }

    func startAudioRecordSampleRate(_ sampleRate: NSNumber, channels: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        exAudio = ExternalAudio.shared()
        
        exAudio?.setupExternalAudio(
            withAgoraKit: agoraRtcEngineKit!,
            sampleRate: UInt32(truncating: sampleRate),
            channels: UInt32(truncating: channels),
            audioCRMode: .exterCaptureSDKRender,
            ioType: .remoteIO)
        
        exAudio?.startWork()
    }

    func stopAudioRecordWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        exAudio?.stopWork()
        exAudio = nil
        agoraRtcEngineKit?.disableExternalAudioSource()
    }
}
