import Flutter
import UIKit

public class SwiftAgoraRtcEnginePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var methodChannel: FlutterMethodChannel
    private var eventChannel: FlutterEventChannel
    private var eventSink: FlutterEventSink? = nil
    private let manager: RtcEngineManager = RtcEngineManager()

    init(_ registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "agora_rtc_engine", binaryMessenger: registrar.messenger())
        eventChannel = FlutterEventChannel(name: "agora_rtc_engine/events", binaryMessenger: registrar.messenger())
        super.init()
        registrar.addMethodCallDelegate(self, channel: methodChannel)
        eventChannel.setStreamHandler(self)
        
        registrar.register(AgoraSurfaceViewFactory(registrar.messenger(), self), withId: "AgoraSurfaceView")
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        SwiftAgoraRtcEnginePlugin(registrar)
    }

    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        eventChannel.setStreamHandler(nil)
        manager.release()
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }

    private func emit(_ methodName: String, _ data: Dictionary<String, Any?>?) {
        var event: Dictionary<String, Any?> = ["methodName": methodName]
        if let `data` = data {
            event.merge(data) { (current, _) in current }
        }
        eventSink?(event)
    }

    var engine: AgoraRtcEngineKit? {
        return manager.engine
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var args = [String: Any?]()
        if let arguments = call.arguments {
            args = arguments as! Dictionary<String, Any?>
        }
        let callback = ResultCallback(result)
        switch call.method {
        case "create":
            self.create(args["appId"] as! String, args["areaCode"] as! Int, callback)
        case "destroy":
            destroy(callback)
        case "setChannelProfile":
            setChannelProfile(args["profile"] as! Int, callback)
        case "setClientRole":
            setClientRole(args["role"] as! Int, callback)
        case "joinChannel":
            joinChannel(args["token"] as? String, args["channelName"] as! String, args["optionalInfo"] as? String, args["optionalUid"] as! Int, callback)
        case "switchChannel":
            switchChannel(args["token"] as? String, args["channelName"] as! String, callback)
        case "leaveChannel":
            leaveChannel(callback)
        case "renewToken":
            renewToken(args["token"] as! String, callback)
        case "enableWebSdkInteroperability":
            enableWebSdkInteroperability(args["enabled"] as! Bool, callback)
        case "getConnectionState":
            getConnectionState(callback)
        case "getCallId":
            getCallId(callback)
        case "rate":
            rate(args["callId"] as! String, args["rating"] as! Int, args["description"] as? String, callback)
        case "complain":
            complain(args["callId"] as! String, description, callback)
        case "setLogFile":
            setLogFile(args["filePath"] as! String, callback)
        case "setLogFilter":
            setLogFilter(args["filter"] as! Int, callback)
        case "setLogFileSize":
            setLogFileSize(args["fileSizeInKBytes"] as! Int, callback)
        case "setParameters":
            setParameters(args["parameters"] as! String, callback)
        case "registerLocalUserAccount":
            registerLocalUserAccount(args["appId"] as! String, args["userAccount"] as! String, callback)
        case "joinChannelWithUserAccount":
            joinChannelWithUserAccount(args["token"] as? String, args["channelName"] as! String, args["userAccount"] as! String, callback)
        case "getUserInfoByUserAccount":
            getUserInfoByUserAccount(args["userAccount"] as! String, callback)
        case "getUserInfoByUid":
            getUserInfoByUid(args["uid"] as! Int, callback)
        case "enableAudio":
            enableAudio(callback)
        case "disableAudio":
            disableAudio(callback)
        case "setAudioProfile":
            setAudioProfile(args["profile"] as! Int, args["scenario"] as! Int, callback)
        case "adjustRecordingSignalVolume":
            adjustRecordingSignalVolume(args["volume"] as! Int, callback)
        case "adjustUserPlaybackSignalVolume":
            adjustUserPlaybackSignalVolume(args["uid"] as! Int, args["volume"] as! Int, callback)
        case "adjustPlaybackSignalVolume":
            adjustPlaybackSignalVolume(args["volume"] as! Int, callback)
        case "enableLocalAudio":
            enableLocalAudio(args["enabled"] as! Bool, callback)
        case "muteLocalAudioStream":
            muteLocalAudioStream(args["muted"] as! Bool, callback)
        case "muteRemoteAudioStream":
            muteRemoteAudioStream(args["uid"] as! Int, args["muted"] as! Bool, callback)
        case "muteAllRemoteAudioStreams":
            muteAllRemoteAudioStreams(args["muted"] as! Bool, callback)
        case "setDefaultMuteAllRemoteAudioStreams":
            setDefaultMuteAllRemoteAudioStreams(args["muted"] as! Bool, callback)
        case "enableAudioVolumeIndication":
            enableAudioVolumeIndication(args["interval"] as! Int, args["smooth"] as! Int, args["report_vad"] as! Bool, callback)
        case "enableVideo":
            enableVideo(callback)
        case "disableVideo":
            disableVideo(callback)
        case "setVideoEncoderConfiguration":
            setVideoEncoderConfiguration(args["config"] as! NSDictionary, callback)
        case "enableLocalVideo":
            enableLocalVideo(args["enabled"] as! Bool, callback)
        case "muteLocalVideoStream":
            muteLocalVideoStream(args["muted"] as! Bool, callback)
        case "muteRemoteVideoStream":
            muteRemoteVideoStream(args["uid"] as! Int, args["muted"] as! Bool, callback)
        case "muteAllRemoteVideoStreams":
            muteAllRemoteVideoStreams(args["muted"] as! Bool, callback)
        case "setDefaultMuteAllRemoteVideoStreams":
            setDefaultMuteAllRemoteVideoStreams(args["muted"] as! Bool, callback)
        case "setBeautyEffectOptions":
            setBeautyEffectOptions(args["enabled"] as! Bool, args["options"] as! NSDictionary, callback)
        case "startAudioMixing":
            startAudioMixing(args["filePath"] as! String, args["loopback"] as! Bool, args["replace"] as! Bool, args["cycle"] as! Int, callback)
        case "stopAudioMixing":
            stopAudioMixing(callback)
        case "pauseAudioMixing":
            pauseAudioMixing(callback)
        case "resumeAudioMixing":
            resumeAudioMixing(callback)
        case "adjustAudioMixingVolume":
            adjustAudioMixingVolume(args["volume"] as! Int, callback)
        case "adjustAudioMixingPlayoutVolume":
            adjustAudioMixingPlayoutVolume(args["volume"] as! Int, callback)
        case "adjustAudioMixingPublishVolume":
            adjustAudioMixingPublishVolume(args["volume"] as! Int, callback)
        case "getAudioMixingPlayoutVolume":
            getAudioMixingPlayoutVolume(callback)
        case "getAudioMixingPublishVolume":
            getAudioMixingPublishVolume(callback)
        case "getAudioMixingDuration":
            getAudioMixingDuration(callback)
        case "getAudioMixingCurrentPosition":
            getAudioMixingCurrentPosition(callback)
        case "setAudioMixingPosition":
            setAudioMixingPosition(args["pos"] as! Int, callback)
        case "setAudioMixingPitch":
            setAudioMixingPitch(args["pitch"] as! Int, callback)
        case "getEffectsVolume":
            getEffectsVolume(callback)
        case "setEffectsVolume":
            setEffectsVolume(args["volume"] as! Double, callback)
        case "setVolumeOfEffect":
            setVolumeOfEffect(args["soundId"] as! Int, args["volume"] as! Double, callback)
        case "playEffect":
            playEffect(args["soundId"] as! Int, args["filePath"] as! String, args["loopCount"] as! Int, args["pitch"] as! Double, args["pan"] as! Double, args["gain"] as! Double, args["publish"] as! Bool, callback)
        case "stopEffect":
            stopEffect(args["soundId"] as! Int, callback)
        case "stopAllEffects":
            stopAllEffects(callback)
        case "preloadEffect":
            preloadEffect(args["soundId"] as! Int, args["filePath"] as! String, callback)
        case "unloadEffect":
            unloadEffect(args["soundId"] as! Int, callback)
        case "pauseEffect":
            pauseEffect(args["soundId"] as! Int, callback)
        case "pauseAllEffects":
            pauseAllEffects(callback)
        case "resumeEffect":
            resumeEffect(args["soundId"] as! Int, callback)
        case "resumeAllEffects":
            resumeAllEffects(callback)
        case "setLocalVoiceChanger":
            setLocalVoiceChanger(args["voiceChanger"] as! Int, callback)
        case "setLocalVoiceReverbPreset":
            setLocalVoiceReverbPreset(args["preset"] as! Int, callback)
        case "setLocalVoicePitch":
            setLocalVoicePitch(args["pitch"] as! Double, callback)
        case "setLocalVoiceEqualization":
            setLocalVoiceEqualization(args["bandFrequency"] as! Int, args["bandGain"] as! Int, callback)
        case "setLocalVoiceReverb":
            setLocalVoiceReverb(args["reverbKey"] as! Int, args["value"] as! Int, callback)
        case "enableSoundPositionIndication":
            enableSoundPositionIndication(args["enabled"] as! Bool, callback)
        case "setRemoteVoicePosition":
            setRemoteVoicePosition(args["uid"] as! Int, args["pan"] as! Double, args["gain"] as! Double, callback)
        case "setLiveTranscoding":
            setLiveTranscoding(args["transcoding"] as! NSDictionary, callback)
        case "addPublishStreamUrl":
            addPublishStreamUrl(args["url"] as! String, args["transcodingEnabled"] as! Bool, callback)
        case "removePublishStreamUrl":
            removePublishStreamUrl(args["url"] as! String, callback)
        case "startChannelMediaRelay":
            startChannelMediaRelay(args["channelMediaRelayConfiguration"] as! NSDictionary, callback)
        case "updateChannelMediaRelay":
            updateChannelMediaRelay(args["channelMediaRelayConfiguration"] as! NSDictionary, callback)
        case "stopChannelMediaRelay":
            stopChannelMediaRelay(callback)
        case "setDefaultAudioRoutetoSpeakerphone":
            setDefaultAudioRoutetoSpeakerphone(args["defaultToSpeaker"] as! Bool, callback)
        case "setEnableSpeakerphone":
            setEnableSpeakerphone(args["enabled"] as! Bool, callback)
        case "isSpeakerphoneEnabled":
            isSpeakerphoneEnabled(callback)
        case "enableInEarMonitoring":
            enableInEarMonitoring(args["enabled"] as! Bool, callback)
        case "setInEarMonitoringVolume":
            setInEarMonitoringVolume(args["volume"] as! Int, callback)
        case "enableDualStreamMode":
            enableDualStreamMode(args["enabled"] as! Bool, callback)
        case "setRemoteVideoStreamType":
            setRemoteVideoStreamType(args["uid"] as! Int, args["streamType"] as! Int, callback)
        case "setRemoteDefaultVideoStreamType":
            setRemoteDefaultVideoStreamType(args["streamType"] as! Int, callback)
        case "setLocalPublishFallbackOption":
            setLocalPublishFallbackOption(args["option"] as! Int, callback)
        case "setRemoteSubscribeFallbackOption":
            setRemoteSubscribeFallbackOption(args["option"] as! Int, callback)
        case "setRemoteUserPriority":
            setRemoteUserPriority(args["uid"] as! Int, args["userPriority"] as! Int, callback)
        case "startEchoTest":
            startEchoTest(args["intervalInSeconds"] as! Int, callback)
        case "stopEchoTest":
            stopEchoTest(callback)
        case "enableLastmileTest":
            enableLastmileTest(callback)
        case "disableLastmileTest":
            disableLastmileTest(callback)
        case "startLastmileProbeTest":
            startLastmileProbeTest(args["config"] as! NSDictionary, callback)
        case "stopLastmileProbeTest":
            stopLastmileProbeTest(callback)
        case "registerMediaMetadataObserver":
            registerMediaMetadataObserver(callback)
        case "unregisterMediaMetadataObserver":
            unregisterMediaMetadataObserver(callback)
        case "setMaxMetadataSize":
            setMaxMetadataSize(args["size"] as! Int, callback)
        case "sendMetadata":
            sendMetadata(args["metadata"] as! String, callback)
        case "addVideoWatermark":
            addVideoWatermark(args["watermarkUrl"] as! String, args["options"] as! NSDictionary, callback)
        case "clearVideoWatermarks":
            clearVideoWatermarks(callback)
        case "setEncryptionSecret":
            setEncryptionSecret(args["secret"] as! String, callback)
        case "setEncryptionMode":
            setEncryptionMode(args["encryptionMode"] as! String, callback)
        case "startAudioRecording":
            startAudioRecording(args["filePath"] as! String, args["sampleRate"] as! Int, args["quality"] as! Int, callback)
        case "stopAudioRecording":
            stopAudioRecording(callback)
        case "addInjectStreamUrl":
            addInjectStreamUrl(args["url"] as! String, args["config"] as! NSDictionary, callback)
        case "removeInjectStreamUrl":
            removeInjectStreamUrl(args["url"] as! String, callback)
        case "switchCamera":
            switchCamera(callback)
        case "isCameraZoomSupported":
            isCameraZoomSupported(callback)
        case "isCameraTorchSupported":
            isCameraTorchSupported(callback)
        case "isCameraFocusSupported":
            // TODO Not in iOS
            break
        case "isCameraExposurePositionSupported":
            isCameraExposurePositionSupported(callback)
        case "isCameraAutoFocusFaceModeSupported":
            isCameraAutoFocusFaceModeSupported(callback)
        case "setCameraZoomFactor":
            setCameraZoomFactor(args["factor"] as! Float, callback)
        case "getCameraMaxZoomFactor":
            // TODO Not in iOS
            break
        case "setCameraFocusPositionInPreview":
            setCameraFocusPositionInPreview(args["positionX"] as! Float, args["positionY"] as! Float, callback)
        case "setCameraExposurePosition":
            setCameraExposurePosition(args["positionXinView"] as! Float, args["positionYinView"] as! Float, callback)
        case "enableFaceDetection":
            enableFaceDetection(args["enable"] as! Bool, callback)
        case "setCameraTorchOn":
            setCameraTorchOn(args["isOn"] as! Bool, callback)
        case "setCameraAutoFocusFaceModeEnabled":
            setCameraAutoFocusFaceModeEnabled(args["enabled"] as! Bool, callback)
        case "setCameraCapturerConfiguration":
            setCameraCapturerConfiguration(args["config"] as! NSDictionary, callback)
        case "createDataStream":
            createDataStream(args["reliable"] as! Bool, args["ordered"] as! Bool, callback)
        case "sendStreamMessage":
            sendStreamMessage(args["streamId"] as! Int, args["message"] as! String, callback)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension SwiftAgoraRtcEnginePlugin: RtcEngineInterface {
    typealias Map = NSDictionary
    typealias Callback = ResultCallback

    func create(_ appId: String, _ areaCode: Int, _ callback: ResultCallback?) {
        manager.create(appId, Int32(areaCode), .APP_TYPE_FLUTTER) { [weak self] (methodName, data) in
            self?.emit(methodName, data)
        }
        callback?.resolve(engine, { e in nil })
    }

    func destroy(_ callback: ResultCallback?) {
        callback?.resolve(engine, { e in manager.destroy() })
    }

    func setChannelProfile(_ profile: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setChannelProfile(AgoraChannelProfile(rawValue: profile)!))
    }

    func setClientRole(_ role: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setClientRole(AgoraClientRole(rawValue: role)!))
    }

    func joinChannel(_ token: String?, _ channelName: String, _ optionalInfo: String?, _ optionalUid: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.joinChannel(byToken: token, channelId: channelName, info: optionalInfo, uid: UInt(optionalUid)))
    }

    func switchChannel(_ token: String?, _ channelName: String, _ callback: ResultCallback?) {
        callback?.code(engine?.switchChannel(byToken: token, channelId: channelName))
    }

    func leaveChannel(_ callback: ResultCallback?) {
        callback?.code(engine?.leaveChannel())
    }

    func renewToken(_ token: String, _ callback: ResultCallback?) {
        callback?.code(engine?.renewToken(token))
    }

    func enableWebSdkInteroperability(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.enableWebSdkInteroperability(enabled))
    }

    func getConnectionState(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getConnectionState()
        }
    }

    func getCallId(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getCallId()
        }
    }

    func rate(_ callId: String, _ rating: Int, _ description: String?, _ callback: ResultCallback?) {
        callback?.code(engine?.rate(callId, rating: rating, description: description))
    }

    func complain(_ callId: String, _ description: String, _ callback: ResultCallback?) {
        callback?.code(engine?.complain(callId, description: description))
    }

    func setLogFile(_ filePath: String, _ callback: ResultCallback?) {
        callback?.code(engine?.setLogFile(filePath))
    }

    func setLogFilter(_ filter: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setLogFilter(UInt(filter)))
    }

    func setLogFileSize(_ fileSizeInKBytes: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setLogFileSize(UInt(fileSizeInKBytes)))
    }

    func setParameters(_ parameters: String, _ callback: ResultCallback?) {
        callback?.code(engine?.setParameters(parameters))
    }

    func registerLocalUserAccount(_ appId: String, _ userAccount: String, _ callback: ResultCallback?) {
        callback?.code(engine?.registerLocalUserAccount(userAccount, appId: appId))
    }

    func joinChannelWithUserAccount(_ token: String?, _ channelName: String, _ userAccount: String, _ callback: ResultCallback?) {
        callback?.code(engine?.joinChannel(byUserAccount: userAccount, token: token, channelId: channelName, joinSuccess: nil))
    }

    func getUserInfoByUserAccount(_ userAccount: String, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            manager.getUserInfoByUserAccount(userAccount)
        }
    }

    func getUserInfoByUid(_ uid: Int, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            manager.getUserInfoByUid(uid)
        }
    }

    func enableAudio(_ callback: ResultCallback?) {
        callback?.code(engine?.enableAudio())
    }

    func disableAudio(_ callback: ResultCallback?) {
        callback?.code(engine?.disableAudio())
    }

    func setAudioProfile(_ profile: Int, _ scenario: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setAudioProfile(AgoraAudioProfile(rawValue: profile)!, scenario: AgoraAudioScenario(rawValue: scenario)!))
    }

    func adjustRecordingSignalVolume(_ volume: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.adjustRecordingSignalVolume(volume))
    }

    func adjustUserPlaybackSignalVolume(_ uid: Int, _ volume: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.adjustUserPlaybackSignalVolume(UInt(uid), volume: Int32(volume)))
    }

    func adjustPlaybackSignalVolume(_ volume: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.adjustPlaybackSignalVolume(volume))
    }

    func enableLocalAudio(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.enableLocalAudio(enabled))
    }

    func muteLocalAudioStream(_ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.muteLocalAudioStream(muted))
    }

    func muteRemoteAudioStream(_ uid: Int, _ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.muteRemoteAudioStream(UInt(uid), mute: muted))
    }

    func muteAllRemoteAudioStreams(_ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.muteAllRemoteAudioStreams(muted))
    }

    func setDefaultMuteAllRemoteAudioStreams(_ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.setDefaultMuteAllRemoteAudioStreams(muted))
    }

    func enableAudioVolumeIndication(_ interval: Int, _ smooth: Int, _ report_vad: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.enableAudioVolumeIndication(interval, smooth: smooth, report_vad: report_vad))
    }

    func enableVideo(_ callback: ResultCallback?) {
        callback?.code(engine?.enableVideo())
    }

    func disableVideo(_ callback: ResultCallback?) {
        callback?.code(engine?.disableVideo())
    }

    func setVideoEncoderConfiguration(_ config: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.setVideoEncoderConfiguration(mapToVideoEncoderConfiguration(map: config as! Dictionary<String, Any>)))
    }

    func enableLocalVideo(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.enableLocalVideo(enabled))
    }

    func muteLocalVideoStream(_ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.muteLocalVideoStream(muted))
    }

    func muteRemoteVideoStream(_ uid: Int, _ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.muteRemoteVideoStream(UInt(uid), mute: muted))
    }

    func muteAllRemoteVideoStreams(_ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.muteAllRemoteVideoStreams(muted))
    }

    func setDefaultMuteAllRemoteVideoStreams(_ muted: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.setDefaultMuteAllRemoteVideoStreams(muted))
    }

    func setBeautyEffectOptions(_ enabled: Bool, _ options: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.setBeautyEffectOptions(enabled, options: mapToBeautyOptions(map: options as! Dictionary<String, Any>)))
    }

    func startAudioMixing(_ filePath: String, _ loopback: Bool, _ replace: Bool, _ cycle: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.startAudioMixing(filePath, loopback: loopback, replace: replace, cycle: cycle))
    }

    func stopAudioMixing(_ callback: ResultCallback?) {
        callback?.code(engine?.stopAudioMixing())
    }

    func pauseAudioMixing(_ callback: ResultCallback?) {
        callback?.code(engine?.pauseAudioMixing())
    }

    func resumeAudioMixing(_ callback: ResultCallback?) {
        callback?.code(engine?.resumeAudioMixing())
    }

    func adjustAudioMixingVolume(_ volume: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.adjustAudioMixingVolume(volume))
    }

    func adjustAudioMixingPlayoutVolume(_ volume: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.adjustAudioMixingPlayoutVolume(volume))
    }

    func adjustAudioMixingPublishVolume(_ volume: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.adjustAudioMixingPublishVolume(volume))
    }

    func getAudioMixingPlayoutVolume(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getAudioMixingPlayoutVolume()
        }
    }

    func getAudioMixingPublishVolume(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getAudioMixingPublishVolume()
        }
    }

    func getAudioMixingDuration(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getAudioMixingDuration()
        }
    }

    func getAudioMixingCurrentPosition(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getAudioMixingCurrentPosition()
        }
    }

    func setAudioMixingPosition(_ pos: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setAudioMixingPosition(pos))
    }

    func setAudioMixingPitch(_ pitch: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setAudioMixingPitch(pitch))
    }

    func getEffectsVolume(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getEffectsVolume()
        }
    }

    func setEffectsVolume(_ volume: Double, _ callback: ResultCallback?) {
        callback?.code(engine?.setEffectsVolume(volume))
    }

    func setVolumeOfEffect(_ soundId: Int, _ volume: Double, _ callback: ResultCallback?) {
        callback?.code(engine?.setVolumeOfEffect(Int32(soundId), withVolume: volume))
    }

    func playEffect(_ soundId: Int, _ filePath: String, _ loopCount: Int, _ pitch: Double, _ pan: Double, _ gain: Double, _ publish: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.playEffect(Int32(soundId), filePath: filePath, loopCount: Int32(loopCount), pitch: pitch, pan: pan, gain: gain, publish: publish))
    }

    func stopEffect(_ soundId: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.stopEffect(Int32(soundId)))
    }

    func stopAllEffects(_ callback: ResultCallback?) {
        callback?.code(engine?.stopAllEffects())
    }

    func preloadEffect(_ soundId: Int, _ filePath: String, _ callback: ResultCallback?) {
        callback?.code(engine?.preloadEffect(Int32(soundId), filePath: filePath))
    }

    func unloadEffect(_ soundId: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.unloadEffect(Int32(soundId)))
    }

    func pauseEffect(_ soundId: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.pauseEffect(Int32(soundId)))
    }

    func pauseAllEffects(_ callback: ResultCallback?) {
        callback?.code(engine?.pauseAllEffects())
    }

    func resumeEffect(_ soundId: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.resumeEffect(Int32(soundId)))
    }

    func resumeAllEffects(_ callback: ResultCallback?) {
        callback?.code(engine?.resumeAllEffects())
    }

    func setLocalVoiceChanger(_ voiceChanger: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setLocalVoiceChanger(AgoraAudioVoiceChanger(rawValue: voiceChanger)!))
    }

    func setLocalVoiceReverbPreset(_ preset: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setLocalVoiceReverbPreset(AgoraAudioReverbPreset(rawValue: preset)!))
    }

    func setLocalVoicePitch(_ pitch: Double, _ callback: ResultCallback?) {
        callback?.code(engine?.setLocalVoicePitch(pitch))
    }

    func setLocalVoiceEqualization(_ bandFrequency: Int, _ bandGain: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setLocalVoiceEqualizationOf(AgoraAudioEqualizationBandFrequency(rawValue: bandFrequency)!, withGain: bandGain))
    }

    func setLocalVoiceReverb(_ reverbKey: Int, _ value: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setLocalVoiceReverbOf(AgoraAudioReverbType(rawValue: reverbKey)!, withValue: value))
    }

    func enableSoundPositionIndication(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.enableSoundPositionIndication(enabled))
    }

    func setRemoteVoicePosition(_ uid: Int, _ pan: Double, _ gain: Double, _ callback: ResultCallback?) {
        callback?.code(engine?.setRemoteVoicePosition(UInt(uid), pan: pan, gain: gain))
    }

    func setLiveTranscoding(_ transcoding: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.setLiveTranscoding(mapToLiveTranscoding(map: transcoding as! Dictionary<String, Any>)))
    }

    func addPublishStreamUrl(_ url: String, _ transcodingEnabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.addPublishStreamUrl(url, transcodingEnabled: transcodingEnabled))
    }

    func removePublishStreamUrl(_ url: String, _ callback: ResultCallback?) {
        callback?.code(engine?.removePublishStreamUrl(url))
    }

    func startChannelMediaRelay(_ channelMediaRelayConfiguration: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.startChannelMediaRelay(mapToChannelMediaRelayConfiguration(map: channelMediaRelayConfiguration as! Dictionary<String, Any>)))
    }

    func updateChannelMediaRelay(_ channelMediaRelayConfiguration: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.updateChannelMediaRelay(mapToChannelMediaRelayConfiguration(map: channelMediaRelayConfiguration as! Dictionary<String, Any>)))
    }

    func stopChannelMediaRelay(_ callback: ResultCallback?) {
        callback?.code(engine?.stopChannelMediaRelay())
    }

    func setDefaultAudioRoutetoSpeakerphone(_ defaultToSpeaker: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.setDefaultAudioRouteToSpeakerphone(defaultToSpeaker))
    }

    func setEnableSpeakerphone(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.setEnableSpeakerphone(enabled))
    }

    func isSpeakerphoneEnabled(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isSpeakerphoneEnabled()
        }
    }

    func enableInEarMonitoring(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.enable(inEarMonitoring: enabled))
    }

    func setInEarMonitoringVolume(_ volume: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setInEarMonitoringVolume(volume))
    }

    func enableDualStreamMode(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.code(engine?.enableDualStreamMode(enabled))
    }

    func setRemoteVideoStreamType(_ uid: Int, _ streamType: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setRemoteVideoStream(UInt(uid), type: AgoraVideoStreamType(rawValue: streamType)!))
    }

    func setRemoteDefaultVideoStreamType(_ streamType: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setRemoteDefaultVideoStreamType(AgoraVideoStreamType(rawValue: streamType)!))
    }

    func setLocalPublishFallbackOption(_ option: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setLocalPublishFallbackOption(AgoraStreamFallbackOptions(rawValue: option)!))
    }

    func setRemoteSubscribeFallbackOption(_ option: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setRemoteSubscribeFallbackOption(AgoraStreamFallbackOptions(rawValue: option)!))
    }

    func setRemoteUserPriority(_ uid: Int, _ userPriority: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.setRemoteUserPriority(UInt(uid), type: AgoraUserPriority(rawValue: userPriority)!))
    }

    func startEchoTest(_ intervalInSeconds: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.startEchoTest(withInterval: intervalInSeconds))
    }

    func stopEchoTest(_ callback: ResultCallback?) {
        callback?.code(engine?.stopEchoTest())
    }

    func enableLastmileTest(_ callback: ResultCallback?) {
        callback?.code(engine?.enableLastmileTest())
    }

    func disableLastmileTest(_ callback: ResultCallback?) {
        callback?.code(engine?.disableLastmileTest())
    }

    func startLastmileProbeTest(_ config: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.startLastmileProbeTest(mapToLastmileProbeConfig(map: config as! Dictionary<String, Any>)))
    }

    func stopLastmileProbeTest(_ callback: ResultCallback?) {
        callback?.code(engine?.stopLastmileProbeTest())
    }

    func registerMediaMetadataObserver(_ callback: ResultCallback?) {
        callback?.code(manager.registerMediaMetadataObserver() { [weak self] (methodName, data) in
            self?.emit(methodName, data)
        })
    }

    func unregisterMediaMetadataObserver(_ callback: ResultCallback?) {
        callback?.code(manager.unregisterMediaMetadataObserver())
    }

    func setMaxMetadataSize(_ size: Int, _ callback: ResultCallback?) {
        callback?.code(manager.setMaxMetadataSize(size))
    }

    func sendMetadata(_ metadata: String, _ callback: ResultCallback?) {
        callback?.code(manager.addMetadata(metadata))
    }

    func addVideoWatermark(_ watermarkUrl: String, _ options: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.addVideoWatermark(URL(string: watermarkUrl)!, options: mapToWatermarkOptions(map: options as! Dictionary<String, Any>)))
    }

    func clearVideoWatermarks(_ callback: ResultCallback?) {
        callback?.code(engine?.clearVideoWatermarks())
    }

    func setEncryptionSecret(_ secret: String, _ callback: ResultCallback?) {
        callback?.code(engine?.setEncryptionSecret(secret))
    }

    func setEncryptionMode(_ encryptionMode: String, _ callback: ResultCallback?) {
        callback?.code(engine?.setEncryptionMode(encryptionMode))
    }

    func startAudioRecording(_ filePath: String, _ sampleRate: Int, _ quality: Int, _ callback: ResultCallback?) {
        callback?.code(engine?.startAudioRecording(filePath, sampleRate: sampleRate, quality: AgoraAudioRecordingQuality(rawValue: quality)!))
    }

    func stopAudioRecording(_ callback: ResultCallback?) {
        callback?.code(engine?.stopAudioRecording())
    }

    func addInjectStreamUrl(_ url: String, _ config: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.addInjectStreamUrl(url, config: mapToLiveInjectStreamConfig(map: config as! Dictionary<String, Any>)))
    }

    func removeInjectStreamUrl(_ url: String, _ callback: ResultCallback?) {
        callback?.code(engine?.removeInjectStreamUrl(url))
    }

    func switchCamera(_ callback: ResultCallback?) {
        callback?.code(engine?.switchCamera())
    }

    func isCameraZoomSupported(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraZoomSupported()
        }
    }

    func isCameraTorchSupported(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraTorchSupported()
        }
    }

    func isCameraFocusSupported(_ callback: ResultCallback?) {
        // TODO Not in iOS
    }

    func isCameraExposurePositionSupported(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraExposurePositionSupported()
        }
    }

    func isCameraAutoFocusFaceModeSupported(_ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraAutoFocusFaceModeSupported()
        }
    }

    func setCameraZoomFactor(_ factor: Float, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraZoomFactor(CGFloat(factor))
        }
    }

    func getCameraMaxZoomFactor(_ callback: ResultCallback?) {
        // TODO Not in iOS
    }

    func setCameraFocusPositionInPreview(_ positionX: Float, _ positionY: Float, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraFocusPositionInPreview(CGPoint(x: CGFloat(positionX), y: CGFloat(positionY)))
        }
    }

    func setCameraExposurePosition(_ positionXinView: Float, _ positionYinView: Float, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraExposurePosition(CGPoint(x: CGFloat(positionXinView), y: CGFloat(positionYinView)))
        }
    }

    func enableFaceDetection(_ enable: Bool, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.enableFaceDetection(enable)
        }
    }

    func setCameraTorchOn(_ isOn: Bool, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraTorchOn(isOn)
        }
    }

    func setCameraAutoFocusFaceModeEnabled(_ enabled: Bool, _ callback: ResultCallback?) {
        callback?.resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraAutoFocusFaceModeEnabled(enabled)
        }
    }

    func setCameraCapturerConfiguration(_ config: NSDictionary, _ callback: ResultCallback?) {
        callback?.code(engine?.setCameraCapturerConfiguration(mapToCameraCapturerConfiguration(map: config as! Dictionary<String, Any>)))
    }

    func createDataStream(_ reliable: Bool, _ ordered: Bool, _ callback: ResultCallback?) {
        let streamId = manager.createDataStream(reliable, ordered)
        if streamId <= 0 {
            callback?.code(streamId)
        } else {
            callback?.resolve(engine, { e in streamId})
        }
    }

    func sendStreamMessage(_ streamId: Int, _ message: String, _ callback: ResultCallback?) {
        callback?.code(manager.sendStreamMessage(streamId, message))
    }
}
