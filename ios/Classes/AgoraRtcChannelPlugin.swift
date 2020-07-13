//
//  AgoraRtcChannelPlugin.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/29.
//

import Foundation

public class AgoraRtcChannelPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private final weak var rtcEnginePlugin: SwiftAgoraRtcEnginePlugin?
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink? = nil
    private let manager = RtcChannelManager()
    
    init(_ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin) {
        self.rtcEnginePlugin = rtcEnginePlugin
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
    }
    
    public func initPlugin(_ registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "agora_rtc_channel", binaryMessenger: registrar.messenger())
        eventChannel = FlutterEventChannel(name: "agora_rtc_channel/events", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(self, channel: methodChannel!)
        eventChannel?.setStreamHandler(self)
    }
    
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
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
    
    private var engine: AgoraRtcEngineKit? {
        return rtcEnginePlugin?.engine
    }
    
    public func channel(_ channelId: String) -> AgoraRtcChannel? {
        return manager[channelId]
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var args = [String: Any?]()
        if let arguments = call.arguments {
            args = arguments as! Dictionary<String, Any?>
        }
        switch call.method {
        case "create":
            create(args["channelId"] as! String, result)
        case "destroy":
            destroy(args["channelId"] as! String, result)
        case "setClientRole":
            setClientRole(args["channelId"] as! String, args["role"] as! Int, result)
        case "joinChannel":
            joinChannel(args["channelId"] as! String, args["token"] as? String, args["optionalInfo"] as? String, args["optionalUid"] as! Int, args["options"] as! NSDictionary, result)
        case "joinChannelWithUserAccount":
            joinChannelWithUserAccount(args["channelId"] as! String, args["token"] as? String, args["userAccount"] as! String, args["options"] as! NSDictionary, result)
        case "leaveChannel":
            leaveChannel(args["channelId"] as! String, result)
        case "renewToken":
            renewToken(args["channelId"] as! String, args["token"] as! String, result)
        case "getConnectionState":
            getConnectionState(args["channelId"] as! String, result)
        case "publish":
            publish(args["channelId"] as! String, result)
        case "unpublish":
            unpublish(args["channelId"] as! String, result)
        case "getCallId":
            getCallId(args["channelId"] as! String, result)
        case "adjustUserPlaybackSignalVolume":
            adjustUserPlaybackSignalVolume(args["channelId"] as! String, args["uid"] as! Int, args["volume"] as! Int, result)
        case "muteRemoteAudioStream":
            muteRemoteAudioStream(args["channelId"] as! String, args["uid"] as! Int, args["muted"] as! Bool, result)
        case "muteAllRemoteAudioStreams":
            muteAllRemoteAudioStreams(args["channelId"] as! String, args["muted"] as! Bool, result)
        case "setDefaultMuteAllRemoteAudioStreams":
            setDefaultMuteAllRemoteAudioStreams(args["channelId"] as! String, args["muted"] as! Bool, result)
        case "muteRemoteVideoStream":
            muteRemoteVideoStream(args["channelId"] as! String, args["uid"] as! Int, args["muted"] as! Bool, result)
        case "muteAllRemoteVideoStreams":
            muteAllRemoteVideoStreams(args["channelId"] as! String, args["muted"] as! Bool, result)
        case "setDefaultMuteAllRemoteVideoStreams":
            setDefaultMuteAllRemoteVideoStreams(args["channelId"] as! String, args["muted"] as! Bool, result)
        case "setRemoteVoicePosition":
            setRemoteVoicePosition(args["channelId"] as! String, args["uid"] as! Int, args["pan"] as! Double, args["gain"] as! Double, result)
        case "setLiveTranscoding":
            setLiveTranscoding(args["channelId"] as! String, args["transcoding"] as! NSDictionary, result)
        case "addPublishStreamUrl":
            addPublishStreamUrl(args["channelId"] as! String, args["url"] as! String, args["transcodingEnabled"] as! Bool, result)
        case "removePublishStreamUrl":
            removePublishStreamUrl(args["channelId"] as! String, args["url"] as! String, result)
        case "startChannelMediaRelay":
            startChannelMediaRelay(args["channelId"] as! String, args["channelMediaRelayConfiguration"] as! NSDictionary, result)
        case "updateChannelMediaRelay":
            updateChannelMediaRelay(args["channelId"] as! String, args["channelMediaRelayConfiguration"] as! NSDictionary, result)
        case "stopChannelMediaRelay":
            stopChannelMediaRelay(args["channelId"] as! String, result)
        case "setRemoteVideoStreamType":
            setRemoteVideoStreamType(args["channelId"] as! String, args["uid"] as! Int, args["streamType"] as! Int, result)
        case "setRemoteDefaultVideoStreamType":
            setRemoteDefaultVideoStreamType(args["channelId"] as! String, args["streamType"] as! Int, result)
        case "setRemoteUserPriority":
            setRemoteUserPriority(args["channelId"] as! String, args["uid"] as! Int, args["userPriority"] as! Int, result)
        case "registerMediaMetadataObserver":
            registerMediaMetadataObserver(args["channelId"] as! String, result)
        case "unregisterMediaMetadataObserver":
            unregisterMediaMetadataObserver(args["channelId"] as! String, result)
        case "setMaxMetadataSize":
            setMaxMetadataSize(args["channelId"] as! String, args["size"] as! Int, result)
        case "sendMetadata":
            sendMetadata(args["channelId"] as! String, args["metadata"] as! String, result)
        case "setEncryptionSecret":
            setEncryptionSecret(args["channelId"] as! String, args["secret"] as! String, result)
        case "setEncryptionMode":
            setEncryptionMode(args["channelId"] as! String, args["encryptionMode"] as! String, result)
        case "addInjectStreamUrl":
            addInjectStreamUrl(args["channelId"] as! String, args["url"] as! String, args["config"] as! NSDictionary, result)
        case "removeInjectStreamUrl":
            removePublishStreamUrl(args["channelId"] as! String, args["url"] as! String, result)
        case "createDataStream":
            createDataStream(args["channelId"] as! String, args["reliable"] as! Bool, args["ordered"] as! Bool, result)
        case "sendStreamMessage":
            sendStreamMessage(args["channelId"] as! String, args["streamId"] as! Int, args["message"] as! String, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension AgoraRtcChannelPlugin: RtcChannelInterface {
    typealias Map = NSDictionary
    typealias Callback = FlutterResult
    
    func create(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(engine) { (engine: AgoraRtcEngineKit) in
            manager.create(engine, channelId) { [weak self] (methodName, data) in
                self?.emit(methodName, data)
            }
        }
    }

    func destroy(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.destroy(channelId))
    }

    func setClientRole(_ channelId: String, _ role: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setClientRole(AgoraClientRole(rawValue: role)!))
    }

    func joinChannel(_ channelId: String, _ token: String?, _ optionalInfo: String?, _ optionalUid: Int, _ options: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.join(byToken: token, info: optionalInfo, uid: UInt(optionalUid), options: mapToChannelMediaOptions(options as! Dictionary<String, Any>)))
    }

    func joinChannelWithUserAccount(_ channelId: String, _ token: String?, _ userAccount: String, _ options: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.join(byUserAccount: userAccount, token: token, options: mapToChannelMediaOptions(options as! Dictionary<String, Any>)))
    }

    func leaveChannel(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.leave())
    }

    func renewToken(_ channelId: String, _ token: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.renewToken(token))
    }

    func getConnectionState(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(channel(channelId)) { (channel: AgoraRtcChannel) in
            channel.getConnectionState()
        }
    }

    func publish(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.publish())
    }

    func unpublish(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.unpublish())
    }

    func getCallId(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).resolve(channel(channelId)) { (channel: AgoraRtcChannel) in
            channel.getCallId()
        }
    }

    func adjustUserPlaybackSignalVolume(_ channelId: String, _ uid: Int, _ volume: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.adjustUserPlaybackSignalVolume(UInt(uid), volume: Int32(volume)))
    }

    func muteRemoteAudioStream(_ channelId: String, _ uid: Int, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.muteRemoteAudioStream(UInt(uid), mute: muted))
    }

    func muteAllRemoteAudioStreams(_ channelId: String, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.muteAllRemoteAudioStreams(muted))
    }

    func setDefaultMuteAllRemoteAudioStreams(_ channelId: String, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setDefaultMuteAllRemoteAudioStreams(muted))
    }

    func muteRemoteVideoStream(_ channelId: String, _ uid: Int, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.muteRemoteVideoStream(UInt(uid), mute: muted))
    }

    func muteAllRemoteVideoStreams(_ channelId: String, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.muteAllRemoteVideoStreams(muted))
    }

    func setDefaultMuteAllRemoteVideoStreams(_ channelId: String, _ muted: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setDefaultMuteAllRemoteVideoStreams(muted))
    }

    func setRemoteVoicePosition(_ channelId: String, _ uid: Int, _ pan: Double, _ gain: Double, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteVoicePosition(UInt(uid), pan: pan, gain: gain))
    }

    func setLiveTranscoding(_ channelId: String, _ transcoding: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setLiveTranscoding(mapToLiveTranscoding(transcoding as! Dictionary<String, Any>)))
    }

    func addPublishStreamUrl(_ channelId: String, _ url: String, _ transcodingEnabled: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.addPublishStreamUrl(url, transcodingEnabled: transcodingEnabled))
    }

    func removePublishStreamUrl(_ channelId: String, _ url: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.removePublishStreamUrl(url))
    }

    func startChannelMediaRelay(_ channelId: String, _ channelMediaRelayConfiguration: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.startMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration as! Dictionary<String, Any>)))
    }

    func updateChannelMediaRelay(_ channelId: String, _ channelMediaRelayConfiguration: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.updateMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration as! Dictionary<String, Any>)))
    }

    func stopChannelMediaRelay(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.stopMediaRelay())
    }

    func setRemoteVideoStreamType(_ channelId: String, _ uid: Int, _ streamType: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteVideoStream(UInt(uid), type: AgoraVideoStreamType(rawValue: streamType)!))
    }

    func setRemoteDefaultVideoStreamType(_ channelId: String, _ streamType: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteDefaultVideoStreamType(AgoraVideoStreamType(rawValue: streamType)!))
    }

    func setRemoteUserPriority(_ channelId: String, _ uid: Int, _ userPriority: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteUserPriority(UInt(uid), type: AgoraUserPriority(rawValue: userPriority)!))
    }

    func registerMediaMetadataObserver(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.registerMediaMetadataObserver(channelId) { [weak self] (methodName, data) in
            self?.emit(methodName, data)
        })
    }

    func unregisterMediaMetadataObserver(_ channelId: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.unregisterMediaMetadataObserver(channelId))
    }

    func setMaxMetadataSize(_ channelId: String, _ size: Int, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.setMaxMetadataSize(channelId, size))
    }

    func sendMetadata(_ channelId: String, _ metadata: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.addMetadata(channelId, metadata))
    }

    func setEncryptionSecret(_ channelId: String, _ secret: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setEncryptionSecret(secret))
    }

    func setEncryptionMode(_ channelId: String, _ encryptionMode: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.setEncryptionMode(encryptionMode))
    }

    func addInjectStreamUrl(_ channelId: String, _ url: String, _ config: NSDictionary, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.addInjectStreamUrl(url, config: mapToLiveInjectStreamConfig(config as! Dictionary<String, Any>)))
    }

    func removeInjectStreamUrl(_ channelId: String, _ url: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(channel(channelId)?.removeInjectStreamUrl(url))
    }

    func createDataStream(_ channelId: String, _ reliable: Bool, _ ordered: Bool, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.createDataStream(channelId, reliable, ordered)) { it in it }
    }

    func sendStreamMessage(_ channelId: String, _ streamId: Int, _ message: String, _ callback: FlutterResult?) {
        ResultCallback(callback).code(manager.sendStreamMessage(channelId, streamId, message))
    }
}
