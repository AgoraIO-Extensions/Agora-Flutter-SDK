import Flutter
import UIKit

public class SwiftAgoraRtcEnginePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink? = nil
    private let manager = RtcEngineManager()
    private lazy var rtcChannelPlugin: AgoraRtcChannelPlugin = {
        return AgoraRtcChannelPlugin(self)
    }()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let rtcEnginePlugin = SwiftAgoraRtcEnginePlugin()
        rtcEnginePlugin.rtcChannelPlugin.initPlugin(registrar)
        rtcEnginePlugin.initPlugin(registrar)
    }
    
    private func initPlugin(_ registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "agora_rtc_engine", binaryMessenger: registrar.messenger())
        eventChannel = FlutterEventChannel(name: "agora_rtc_engine/events", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: methodChannel!)
        eventChannel?.setStreamHandler(self)
        
        registrar.register(AgoraSurfaceViewFactory(registrar.messenger(), self, rtcChannelPlugin), withId: "AgoraSurfaceView")
    }

    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        rtcChannelPlugin.detachFromEngine(for: registrar)
        methodChannel?.setMethodCallHandler(nil)
        eventChannel?.setStreamHandler(nil)
        manager.release()
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    private func emit(_ methodName: String, _ data: Dictionary<String, Any?>?) {
        var event: Dictionary<String, Any?> = ["methodName": methodName]
        if let `data` = data {
            event.merge(data) { (current, _) in current }
        }
        eventSink?(event)
    }

    weak var engine: AgoraRtcEngineKit? {
        return manager.engine
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var args = [String: Any?]()
        if let arguments = call.arguments {
            args = arguments as! Dictionary<String, Any?>
        }
        switch call.method {
        case "create":
            self.create(args["appId"] as! String, args["areaCode"] as! Int, result)
        case "destroy":
            destroy(result)
        case "setChannelProfile":
            setChannelProfile(args["profile"] as! Int, result)
        case "setClientRole":
            setClientRole(args["role"] as! Int, result)
        case "joinChannel":
            joinChannel(args["token"] as? String, args["channelName"] as! String, args["optionalInfo"] as? String, args["optionalUid"] as! Int, result)
        case "switchChannel":
            switchChannel(args["token"] as? String, args["channelName"] as! String, result)
        case "leaveChannel":
            leaveChannel(result)
        case "renewToken":
            renewToken(args["token"] as! String, result)
        case "enableWebSdkInteroperability":
            enableWebSdkInteroperability(args["enabled"] as! Bool, result)
        case "getConnectionState":
            getConnectionState(result)
        case "getCallId":
            getCallId(result)
        case "rate":
            rate(args["callId"] as! String, args["rating"] as! Int, args["description"] as? String, result)
        case "complain":
            complain(args["callId"] as! String, description, result)
        case "setLogFile":
            setLogFile(args["filePath"] as! String, result)
        case "setLogFilter":
            setLogFilter(args["filter"] as! Int, result)
        case "setLogFileSize":
            setLogFileSize(args["fileSizeInKBytes"] as! Int, result)
        case "setParameters":
            setParameters(args["parameters"] as! String, result)
        case "registerLocalUserAccount":
            registerLocalUserAccount(args["appId"] as! String, args["userAccount"] as! String, result)
        case "joinChannelWithUserAccount":
            joinChannelWithUserAccount(args["token"] as? String, args["channelName"] as! String, args["userAccount"] as! String, result)
        case "getUserInfoByUserAccount":
            getUserInfoByUserAccount(args["userAccount"] as! String, result)
        case "getUserInfoByUid":
            getUserInfoByUid(args["uid"] as! Int, result)
        case "enableAudio":
            enableAudio(result)
        case "disableAudio":
            disableAudio(result)
        case "setAudioProfile":
            setAudioProfile(args["profile"] as! Int, args["scenario"] as! Int, result)
        case "adjustRecordingSignalVolume":
            adjustRecordingSignalVolume(args["volume"] as! Int, result)
        case "adjustUserPlaybackSignalVolume":
            adjustUserPlaybackSignalVolume(args["uid"] as! Int, args["volume"] as! Int, result)
        case "adjustPlaybackSignalVolume":
            adjustPlaybackSignalVolume(args["volume"] as! Int, result)
        case "enableLocalAudio":
            enableLocalAudio(args["enabled"] as! Bool, result)
        case "muteLocalAudioStream":
            muteLocalAudioStream(args["muted"] as! Bool, result)
        case "muteRemoteAudioStream":
            muteRemoteAudioStream(args["uid"] as! Int, args["muted"] as! Bool, result)
        case "muteAllRemoteAudioStreams":
            muteAllRemoteAudioStreams(args["muted"] as! Bool, result)
        case "setDefaultMuteAllRemoteAudioStreams":
            setDefaultMuteAllRemoteAudioStreams(args["muted"] as! Bool, result)
        case "enableAudioVolumeIndication":
            enableAudioVolumeIndication(args["interval"] as! Int, args["smooth"] as! Int, args["report_vad"] as! Bool, result)
        case "enableVideo":
            enableVideo(result)
        case "disableVideo":
            disableVideo(result)
        case "setVideoEncoderConfiguration":
            setVideoEncoderConfiguration(args["config"] as! NSDictionary, result)
        case "enableLocalVideo":
            enableLocalVideo(args["enabled"] as! Bool, result)
        case "muteLocalVideoStream":
            muteLocalVideoStream(args["muted"] as! Bool, result)
        case "muteRemoteVideoStream":
            muteRemoteVideoStream(args["uid"] as! Int, args["muted"] as! Bool, result)
        case "muteAllRemoteVideoStreams":
            muteAllRemoteVideoStreams(args["muted"] as! Bool, result)
        case "setDefaultMuteAllRemoteVideoStreams":
            setDefaultMuteAllRemoteVideoStreams(args["muted"] as! Bool, result)
        case "setBeautyEffectOptions":
            setBeautyEffectOptions(args["enabled"] as! Bool, args["options"] as! NSDictionary, result)
        case "startAudioMixing":
            startAudioMixing(args["filePath"] as! String, args["loopback"] as! Bool, args["replace"] as! Bool, args["cycle"] as! Int, result)
        case "stopAudioMixing":
            stopAudioMixing(result)
        case "pauseAudioMixing":
            pauseAudioMixing(result)
        case "resumeAudioMixing":
            resumeAudioMixing(result)
        case "adjustAudioMixingVolume":
            adjustAudioMixingVolume(args["volume"] as! Int, result)
        case "adjustAudioMixingPlayoutVolume":
            adjustAudioMixingPlayoutVolume(args["volume"] as! Int, result)
        case "adjustAudioMixingPublishVolume":
            adjustAudioMixingPublishVolume(args["volume"] as! Int, result)
        case "getAudioMixingPlayoutVolume":
            getAudioMixingPlayoutVolume(result)
        case "getAudioMixingPublishVolume":
            getAudioMixingPublishVolume(result)
        case "getAudioMixingDuration":
            getAudioMixingDuration(result)
        case "getAudioMixingCurrentPosition":
            getAudioMixingCurrentPosition(result)
        case "setAudioMixingPosition":
            setAudioMixingPosition(args["pos"] as! Int, result)
        case "setAudioMixingPitch":
            setAudioMixingPitch(args["pitch"] as! Int, result)
        case "getEffectsVolume":
            getEffectsVolume(result)
        case "setEffectsVolume":
            setEffectsVolume(args["volume"] as! Double, result)
        case "setVolumeOfEffect":
            setVolumeOfEffect(args["soundId"] as! Int, args["volume"] as! Double, result)
        case "playEffect":
            playEffect(args["soundId"] as! Int, args["filePath"] as! String, args["loopCount"] as! Int, args["pitch"] as! Double, args["pan"] as! Double, args["gain"] as! Double, args["publish"] as! Bool, result)
        case "stopEffect":
            stopEffect(args["soundId"] as! Int, result)
        case "stopAllEffects":
            stopAllEffects(result)
        case "preloadEffect":
            preloadEffect(args["soundId"] as! Int, args["filePath"] as! String, result)
        case "unloadEffect":
            unloadEffect(args["soundId"] as! Int, result)
        case "pauseEffect":
            pauseEffect(args["soundId"] as! Int, result)
        case "pauseAllEffects":
            pauseAllEffects(result)
        case "resumeEffect":
            resumeEffect(args["soundId"] as! Int, result)
        case "resumeAllEffects":
            resumeAllEffects(result)
        case "setLocalVoiceChanger":
            setLocalVoiceChanger(args["voiceChanger"] as! Int, result)
        case "setLocalVoiceReverbPreset":
            setLocalVoiceReverbPreset(args["preset"] as! Int, result)
        case "setLocalVoicePitch":
            setLocalVoicePitch(args["pitch"] as! Double, result)
        case "setLocalVoiceEqualization":
            setLocalVoiceEqualization(args["bandFrequency"] as! Int, args["bandGain"] as! Int, result)
        case "setLocalVoiceReverb":
            setLocalVoiceReverb(args["reverbKey"] as! Int, args["value"] as! Int, result)
        case "enableSoundPositionIndication":
            enableSoundPositionIndication(args["enabled"] as! Bool, result)
        case "setRemoteVoicePosition":
            setRemoteVoicePosition(args["uid"] as! Int, args["pan"] as! Double, args["gain"] as! Double, result)
        case "setLiveTranscoding":
            setLiveTranscoding(args["transcoding"] as! NSDictionary, result)
        case "addPublishStreamUrl":
            addPublishStreamUrl(args["url"] as! String, args["transcodingEnabled"] as! Bool, result)
        case "removePublishStreamUrl":
            removePublishStreamUrl(args["url"] as! String, result)
        case "startChannelMediaRelay":
            startChannelMediaRelay(args["channelMediaRelayConfiguration"] as! NSDictionary, result)
        case "updateChannelMediaRelay":
            updateChannelMediaRelay(args["channelMediaRelayConfiguration"] as! NSDictionary, result)
        case "stopChannelMediaRelay":
            stopChannelMediaRelay(result)
        case "setDefaultAudioRoutetoSpeakerphone":
            setDefaultAudioRoutetoSpeakerphone(args["defaultToSpeaker"] as! Bool, result)
        case "setEnableSpeakerphone":
            setEnableSpeakerphone(args["enabled"] as! Bool, result)
        case "isSpeakerphoneEnabled":
            isSpeakerphoneEnabled(result)
        case "enableInEarMonitoring":
            enableInEarMonitoring(args["enabled"] as! Bool, result)
        case "setInEarMonitoringVolume":
            setInEarMonitoringVolume(args["volume"] as! Int, result)
        case "enableDualStreamMode":
            enableDualStreamMode(args["enabled"] as! Bool, result)
        case "setRemoteVideoStreamType":
            setRemoteVideoStreamType(args["uid"] as! Int, args["streamType"] as! Int, result)
        case "setRemoteDefaultVideoStreamType":
            setRemoteDefaultVideoStreamType(args["streamType"] as! Int, result)
        case "setLocalPublishFallbackOption":
            setLocalPublishFallbackOption(args["option"] as! Int, result)
        case "setRemoteSubscribeFallbackOption":
            setRemoteSubscribeFallbackOption(args["option"] as! Int, result)
        case "setRemoteUserPriority":
            setRemoteUserPriority(args["uid"] as! Int, args["userPriority"] as! Int, result)
        case "startEchoTest":
            startEchoTest(args["intervalInSeconds"] as! Int, result)
        case "stopEchoTest":
            stopEchoTest(result)
        case "enableLastmileTest":
            enableLastmileTest(result)
        case "disableLastmileTest":
            disableLastmileTest(result)
        case "startLastmileProbeTest":
            startLastmileProbeTest(args["config"] as! NSDictionary, result)
        case "stopLastmileProbeTest":
            stopLastmileProbeTest(result)
        case "registerMediaMetadataObserver":
            registerMediaMetadataObserver(result)
        case "unregisterMediaMetadataObserver":
            unregisterMediaMetadataObserver(result)
        case "setMaxMetadataSize":
            setMaxMetadataSize(args["size"] as! Int, result)
        case "sendMetadata":
            sendMetadata(args["metadata"] as! String, result)
        case "addVideoWatermark":
            addVideoWatermark(args["watermarkUrl"] as! String, args["options"] as! NSDictionary, result)
        case "clearVideoWatermarks":
            clearVideoWatermarks(result)
        case "setEncryptionSecret":
            setEncryptionSecret(args["secret"] as! String, result)
        case "setEncryptionMode":
            setEncryptionMode(args["encryptionMode"] as! String, result)
        case "startAudioRecording":
            startAudioRecording(args["filePath"] as! String, args["sampleRate"] as! Int, args["quality"] as! Int, result)
        case "stopAudioRecording":
            stopAudioRecording(result)
        case "addInjectStreamUrl":
            addInjectStreamUrl(args["url"] as! String, args["config"] as! NSDictionary, result)
        case "removeInjectStreamUrl":
            removeInjectStreamUrl(args["url"] as! String, result)
        case "switchCamera":
            switchCamera(result)
        case "isCameraZoomSupported":
            isCameraZoomSupported(result)
        case "isCameraTorchSupported":
            isCameraTorchSupported(result)
        case "isCameraFocusSupported":
            // TODO Not in iOS
            break
        case "isCameraExposurePositionSupported":
            isCameraExposurePositionSupported(result)
        case "isCameraAutoFocusFaceModeSupported":
            isCameraAutoFocusFaceModeSupported(result)
        case "setCameraZoomFactor":
            setCameraZoomFactor(args["factor"] as! Float, result)
        case "getCameraMaxZoomFactor":
            // TODO Not in iOS
            break
        case "setCameraFocusPositionInPreview":
            setCameraFocusPositionInPreview(args["positionX"] as! Float, args["positionY"] as! Float, result)
        case "setCameraExposurePosition":
            setCameraExposurePosition(args["positionXinView"] as! Float, args["positionYinView"] as! Float, result)
        case "enableFaceDetection":
            enableFaceDetection(args["enable"] as! Bool, result)
        case "setCameraTorchOn":
            setCameraTorchOn(args["isOn"] as! Bool, result)
        case "setCameraAutoFocusFaceModeEnabled":
            setCameraAutoFocusFaceModeEnabled(args["enabled"] as! Bool, result)
        case "setCameraCapturerConfiguration":
            setCameraCapturerConfiguration(args["config"] as! NSDictionary, result)
        case "createDataStream":
            createDataStream(args["reliable"] as! Bool, args["ordered"] as! Bool, result)
        case "sendStreamMessage":
            sendStreamMessage(args["streamId"] as! Int, args["message"] as! String, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension SwiftAgoraRtcEnginePlugin: RtcEngineInterface {
    typealias Map = NSDictionary
    typealias Callback = FlutterResult

    func create(_ appId: String, _ areaCode: Int, _ callback: FlutterResult?) {
        manager.create(appId, Int32(areaCode), .APP_TYPE_FLUTTER) { [weak self] (methodName, data) in
            self?.emit(methodName, data)
        }
        ResultCallback(callback).resolve(engine, { e in nil })
    }

    func destroy(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine, { e in manager.destroy() })
    }

    func setChannelProfile(_ profile: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setChannelProfile(AgoraChannelProfile(rawValue: profile)!))
    }

    func setClientRole(_ role: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setClientRole(AgoraClientRole(rawValue: role)!))
    }

    func joinChannel(_ token: String?, _ channelName: String, _ optionalInfo: String?, _ optionalUid: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.joinChannel(byToken: token, channelId: channelName, info: optionalInfo, uid: UInt(optionalUid)))
    }

    func switchChannel(_ token: String?, _ channelName: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.switchChannel(byToken: token, channelId: channelName))
    }

    func leaveChannel(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.leaveChannel())
    }

    func renewToken(_ token: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.renewToken(token))
    }

    func enableWebSdkInteroperability(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableWebSdkInteroperability(enabled))
    }

    func getConnectionState(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getConnectionState()
        }
    }

    func getCallId(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getCallId()
        }
    }

    func rate(_ callId: String, _ rating: Int, _ description: String?, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.rate(callId, rating: rating, description: description))
    }

    func complain(_ callId: String, _ description: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.complain(callId, description: description))
    }

    func setLogFile(_ filePath: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLogFile(filePath))
    }

    func setLogFilter(_ filter: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLogFilter(UInt(filter)))
    }

    func setLogFileSize(_ fileSizeInKBytes: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLogFileSize(UInt(fileSizeInKBytes)))
    }

    func setParameters(_ parameters: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setParameters(parameters))
    }

    func registerLocalUserAccount(_ appId: String, _ userAccount: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.registerLocalUserAccount(userAccount, appId: appId))
    }

    func joinChannelWithUserAccount(_ token: String?, _ channelName: String, _ userAccount: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.joinChannel(byUserAccount: userAccount, token: token, channelId: channelName, joinSuccess: nil))
    }

    func getUserInfoByUserAccount(_ userAccount: String, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            manager.getUserInfoByUserAccount(userAccount)
        }
    }

    func getUserInfoByUid(_ uid: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            manager.getUserInfoByUid(uid)
        }
    }

    func enableAudio(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableAudio())
    }

    func disableAudio(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.disableAudio())
    }

    func setAudioProfile(_ profile: Int, _ scenario: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setAudioProfile(AgoraAudioProfile(rawValue: profile)!, scenario: AgoraAudioScenario(rawValue: scenario)!))
    }

    func adjustRecordingSignalVolume(_ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.adjustRecordingSignalVolume(volume))
    }

    func adjustUserPlaybackSignalVolume(_ uid: Int, _ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.adjustUserPlaybackSignalVolume(UInt(uid), volume: Int32(volume)))
    }

    func adjustPlaybackSignalVolume(_ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.adjustPlaybackSignalVolume(volume))
    }

    func enableLocalAudio(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableLocalAudio(enabled))
    }

    func muteLocalAudioStream(_ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.muteLocalAudioStream(muted))
    }

    func muteRemoteAudioStream(_ uid: Int, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.muteRemoteAudioStream(UInt(uid), mute: muted))
    }

    func muteAllRemoteAudioStreams(_ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.muteAllRemoteAudioStreams(muted))
    }

    func setDefaultMuteAllRemoteAudioStreams(_ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setDefaultMuteAllRemoteAudioStreams(muted))
    }

    func enableAudioVolumeIndication(_ interval: Int, _ smooth: Int, _ report_vad: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableAudioVolumeIndication(interval, smooth: smooth, report_vad: report_vad))
    }

    func enableVideo(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableVideo())
    }

    func disableVideo(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.disableVideo())
    }

    func setVideoEncoderConfiguration(_ config: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setVideoEncoderConfiguration(mapToVideoEncoderConfiguration(config as! Dictionary<String, Any>)))
    }

    func enableLocalVideo(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableLocalVideo(enabled))
    }

    func muteLocalVideoStream(_ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.muteLocalVideoStream(muted))
    }

    func muteRemoteVideoStream(_ uid: Int, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.muteRemoteVideoStream(UInt(uid), mute: muted))
    }

    func muteAllRemoteVideoStreams(_ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.muteAllRemoteVideoStreams(muted))
    }

    func setDefaultMuteAllRemoteVideoStreams(_ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setDefaultMuteAllRemoteVideoStreams(muted))
    }

    func setBeautyEffectOptions(_ enabled: Bool, _ options: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setBeautyEffectOptions(enabled, options: mapToBeautyOptions(options as! Dictionary<String, Any>)))
    }

    func startAudioMixing(_ filePath: String, _ loopback: Bool, _ replace: Bool, _ cycle: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.startAudioMixing(filePath, loopback: loopback, replace: replace, cycle: cycle))
    }

    func stopAudioMixing(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.stopAudioMixing())
    }

    func pauseAudioMixing(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.pauseAudioMixing())
    }

    func resumeAudioMixing(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.resumeAudioMixing())
    }

    func adjustAudioMixingVolume(_ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.adjustAudioMixingVolume(volume))
    }

    func adjustAudioMixingPlayoutVolume(_ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.adjustAudioMixingPlayoutVolume(volume))
    }

    func adjustAudioMixingPublishVolume(_ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.adjustAudioMixingPublishVolume(volume))
    }

    func getAudioMixingPlayoutVolume(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.getAudioMixingPlayoutVolume()){ it in it}
    }

    func getAudioMixingPublishVolume(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.getAudioMixingPublishVolume()) { it in it}
    }

    func getAudioMixingDuration(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.getAudioMixingDuration()) { it in it }
    }

    func getAudioMixingCurrentPosition(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.getAudioMixingCurrentPosition()) { it in it }
    }

    func setAudioMixingPosition(_ pos: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setAudioMixingPosition(pos))
    }

    func setAudioMixingPitch(_ pitch: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setAudioMixingPitch(pitch))
    }

    func getEffectsVolume(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.getEffectsVolume()
        }
    }

    func setEffectsVolume(_ volume: Double, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setEffectsVolume(volume))
    }

    func setVolumeOfEffect(_ soundId: Int, _ volume: Double, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setVolumeOfEffect(Int32(soundId), withVolume: volume))
    }

    func playEffect(_ soundId: Int, _ filePath: String, _ loopCount: Int, _ pitch: Double, _ pan: Double, _ gain: Double, _ publish: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.playEffect(Int32(soundId), filePath: filePath, loopCount: Int32(loopCount), pitch: pitch, pan: pan, gain: gain, publish: publish))
    }

    func stopEffect(_ soundId: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.stopEffect(Int32(soundId)))
    }

    func stopAllEffects(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.stopAllEffects())
    }

    func preloadEffect(_ soundId: Int, _ filePath: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.preloadEffect(Int32(soundId), filePath: filePath))
    }

    func unloadEffect(_ soundId: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.unloadEffect(Int32(soundId)))
    }

    func pauseEffect(_ soundId: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.pauseEffect(Int32(soundId)))
    }

    func pauseAllEffects(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.pauseAllEffects())
    }

    func resumeEffect(_ soundId: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.resumeEffect(Int32(soundId)))
    }

    func resumeAllEffects(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.resumeAllEffects())
    }

    func setLocalVoiceChanger(_ voiceChanger: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLocalVoiceChanger(AgoraAudioVoiceChanger(rawValue: voiceChanger)!))
    }

    func setLocalVoiceReverbPreset(_ preset: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLocalVoiceReverbPreset(AgoraAudioReverbPreset(rawValue: preset)!))
    }

    func setLocalVoicePitch(_ pitch: Double, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLocalVoicePitch(pitch))
    }

    func setLocalVoiceEqualization(_ bandFrequency: Int, _ bandGain: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLocalVoiceEqualizationOf(AgoraAudioEqualizationBandFrequency(rawValue: bandFrequency)!, withGain: bandGain))
    }

    func setLocalVoiceReverb(_ reverbKey: Int, _ value: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLocalVoiceReverbOf(AgoraAudioReverbType(rawValue: reverbKey)!, withValue: value))
    }

    func enableSoundPositionIndication(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableSoundPositionIndication(enabled))
    }

    func setRemoteVoicePosition(_ uid: Int, _ pan: Double, _ gain: Double, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setRemoteVoicePosition(UInt(uid), pan: pan, gain: gain))
    }

    func setLiveTranscoding(_ transcoding: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLiveTranscoding(mapToLiveTranscoding(transcoding as! Dictionary<String, Any>)))
    }

    func addPublishStreamUrl(_ url: String, _ transcodingEnabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.addPublishStreamUrl(url, transcodingEnabled: transcodingEnabled))
    }

    func removePublishStreamUrl(_ url: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.removePublishStreamUrl(url))
    }

    func startChannelMediaRelay(_ channelMediaRelayConfiguration: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.startChannelMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration as! Dictionary<String, Any>)))
    }

    func updateChannelMediaRelay(_ channelMediaRelayConfiguration: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.updateChannelMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration as! Dictionary<String, Any>)))
    }

    func stopChannelMediaRelay(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.stopChannelMediaRelay())
    }

    func setDefaultAudioRoutetoSpeakerphone(_ defaultToSpeaker: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setDefaultAudioRouteToSpeakerphone(defaultToSpeaker))
    }

    func setEnableSpeakerphone(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setEnableSpeakerphone(enabled))
    }

    func isSpeakerphoneEnabled(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isSpeakerphoneEnabled()
        }
    }

    func enableInEarMonitoring(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enable(inEarMonitoring: enabled))
    }

    func setInEarMonitoringVolume(_ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setInEarMonitoringVolume(volume))
    }

    func enableDualStreamMode(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableDualStreamMode(enabled))
    }

    func setRemoteVideoStreamType(_ uid: Int, _ streamType: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setRemoteVideoStream(UInt(uid), type: AgoraVideoStreamType(rawValue: streamType)!))
    }

    func setRemoteDefaultVideoStreamType(_ streamType: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setRemoteDefaultVideoStreamType(AgoraVideoStreamType(rawValue: streamType)!))
    }

    func setLocalPublishFallbackOption(_ option: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setLocalPublishFallbackOption(AgoraStreamFallbackOptions(rawValue: option)!))
    }

    func setRemoteSubscribeFallbackOption(_ option: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setRemoteSubscribeFallbackOption(AgoraStreamFallbackOptions(rawValue: option)!))
    }

    func setRemoteUserPriority(_ uid: Int, _ userPriority: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setRemoteUserPriority(UInt(uid), type: AgoraUserPriority(rawValue: userPriority)!))
    }

    func startEchoTest(_ intervalInSeconds: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.startEchoTest(withInterval: intervalInSeconds))
    }

    func stopEchoTest(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.stopEchoTest())
    }

    func enableLastmileTest(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.enableLastmileTest())
    }

    func disableLastmileTest(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.disableLastmileTest())
    }

    func startLastmileProbeTest(_ config: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.startLastmileProbeTest(mapToLastmileProbeConfig(config as! Dictionary<String, Any>)))
    }

    func stopLastmileProbeTest(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.stopLastmileProbeTest())
    }

    func registerMediaMetadataObserver(_ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.registerMediaMetadataObserver() { [weak self] (methodName, data) in
            self?.emit(methodName, data)
        })
    }

    func unregisterMediaMetadataObserver(_ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.unregisterMediaMetadataObserver())
    }

    func setMaxMetadataSize(_ size: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.setMaxMetadataSize(size))
    }

    func sendMetadata(_ metadata: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.addMetadata(metadata))
    }

    func addVideoWatermark(_ watermarkUrl: String, _ options: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.addVideoWatermark(URL(string: watermarkUrl)!, options: mapToWatermarkOptions(options as! Dictionary<String, Any>)))
    }

    func clearVideoWatermarks(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.clearVideoWatermarks())
    }

    func setEncryptionSecret(_ secret: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setEncryptionSecret(secret))
    }

    func setEncryptionMode(_ encryptionMode: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setEncryptionMode(encryptionMode))
    }

    func startAudioRecording(_ filePath: String, _ sampleRate: Int, _ quality: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.startAudioRecording(filePath, sampleRate: sampleRate, quality: AgoraAudioRecordingQuality(rawValue: quality)!))
    }

    func stopAudioRecording(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.stopAudioRecording())
    }

    func addInjectStreamUrl(_ url: String, _ config: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.addInjectStreamUrl(url, config: mapToLiveInjectStreamConfig(config as! Dictionary<String, Any>)))
    }

    func removeInjectStreamUrl(_ url: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.removeInjectStreamUrl(url))
    }

    func switchCamera(_ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.switchCamera())
    }

    func isCameraZoomSupported(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraZoomSupported()
        }
    }

    func isCameraTorchSupported(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraTorchSupported()
        }
    }

    func isCameraFocusSupported(_ callback: FlutterResult?) {
        // TODO Not in iOS
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in nil }
    }

    func isCameraExposurePositionSupported(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraExposurePositionSupported()
        }
    }

    func isCameraAutoFocusFaceModeSupported(_ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.isCameraAutoFocusFaceModeSupported()
        }
    }

    func setCameraZoomFactor(_ factor: Float, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraZoomFactor(CGFloat(factor))
            return nil
        }
    }

    func getCameraMaxZoomFactor(_ callback: FlutterResult?) {
        // TODO Not in iOS
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in nil }
    }

    func setCameraFocusPositionInPreview(_ positionX: Float, _ positionY: Float, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraFocusPositionInPreview(CGPoint(x: CGFloat(positionX), y: CGFloat(positionY)))
            return nil
        }
    }

    func setCameraExposurePosition(_ positionXinView: Float, _ positionYinView: Float, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraExposurePosition(CGPoint(x: CGFloat(positionXinView), y: CGFloat(positionYinView)))
            return nil
        }
    }

    func enableFaceDetection(_ enable: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.enableFaceDetection(enable)
            return nil
        }
    }

    func setCameraTorchOn(_ isOn: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraTorchOn(isOn)
            return nil
        }
    }

    func setCameraAutoFocusFaceModeEnabled(_ enabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            engine.setCameraAutoFocusFaceModeEnabled(enabled)
            return nil
        }
    }

    func setCameraCapturerConfiguration(_ config: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(engine?.setCameraCapturerConfiguration(mapToCameraCapturerConfiguration(config as! Dictionary<String, Any>)))
    }

    func createDataStream(_ reliable: Bool, _ ordered: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.createDataStream(reliable, ordered)) { it in it }
    }

    func sendStreamMessage(_ streamId: Int, _ message: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.sendStreamMessage(streamId, message))
    }
}
