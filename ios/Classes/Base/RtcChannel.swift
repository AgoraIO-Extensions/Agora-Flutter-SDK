//
//  RtcChannel.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/13.
//  Copyright (c) 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

protocol RtcChannelInterface:
        RtcChannelAudioInterface,
        RtcChannelVideoInterface,
        RtcChannelVoicePositionInterface,
        RtcChannelPublishStreamInterface,
        RtcChannelMediaRelayInterface,
        RtcChannelDualStreamInterface,
        RtcChannelFallbackInterface,
        RtcChannelMediaMetadataInterface,
        RtcChannelEncryptionInterface,
        RtcChannelInjectStreamInterface,
        RtcChannelStreamMessageInterface {
    func create(_ params: NSDictionary, _ callback: Callback)

    func destroy(_ params: NSDictionary, _ callback: Callback)

    func setClientRole(_ params: NSDictionary, _ callback: Callback)

    func joinChannel(_ params: NSDictionary, _ callback: Callback)

    func joinChannelWithUserAccount(_ params: NSDictionary, _ callback: Callback)

    func leaveChannel(_ params: NSDictionary, _ callback: Callback)

    func renewToken(_ params: NSDictionary, _ callback: Callback)

    func getConnectionState(_ params: NSDictionary, _ callback: Callback)

    func publish(_ params: NSDictionary, _ callback: Callback)

    func unpublish(_ params: NSDictionary, _ callback: Callback)

    func getCallId(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelAudioInterface {
    func adjustUserPlaybackSignalVolume(_ params: NSDictionary, _ callback: Callback)

    func muteRemoteAudioStream(_ params: NSDictionary, _ callback: Callback)

    func muteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setDefaultMuteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelVideoInterface {
    func muteRemoteVideoStream(_ params: NSDictionary, _ callback: Callback)

    func muteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setDefaultMuteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback)

    func enableRemoteSuperResolution(_ params: NSDictionary, callback: Callback)
}

protocol RtcChannelVoicePositionInterface {
    func setRemoteVoicePosition(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelPublishStreamInterface {
    func setLiveTranscoding(_ params: NSDictionary, _ callback: Callback)

    func addPublishStreamUrl(_ params: NSDictionary, _ callback: Callback)

    func removePublishStreamUrl(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelMediaRelayInterface {
    func startChannelMediaRelay(_ params: NSDictionary, _ callback: Callback)

    func updateChannelMediaRelay(_ params: NSDictionary, _ callback: Callback)

    func stopChannelMediaRelay(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelDualStreamInterface {
    func setRemoteVideoStreamType(_ params: NSDictionary, _ callback: Callback)

    func setRemoteDefaultVideoStreamType(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelFallbackInterface {
    func setRemoteUserPriority(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelMediaMetadataInterface {
    func registerMediaMetadataObserver(_ params: NSDictionary, _ callback: Callback)

    func unregisterMediaMetadataObserver(_ params: NSDictionary, _ callback: Callback)

    func setMaxMetadataSize(_ params: NSDictionary, _ callback: Callback)

    func sendMetadata(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelEncryptionInterface {
    @available(*, deprecated)
    func setEncryptionSecret(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setEncryptionMode(_ params: NSDictionary, _ callback: Callback)

    func enableEncryption(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelInjectStreamInterface {
    func addInjectStreamUrl(_ params: NSDictionary, _ callback: Callback)

    func removeInjectStreamUrl(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcChannelStreamMessageInterface {
    func createDataStream(_ params: NSDictionary, _ callback: Callback)

    func sendStreamMessage(_ params: NSDictionary, _ callback: Callback)
}

@objc
class RtcChannelManager: NSObject, RtcChannelInterface {
    private var emitter: (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void
    private var rtcChannelMap = [String: AgoraRtcChannel]()
    private var rtcChannelDelegateMap = [String: RtcChannelEventHandler]()
    private var mediaObserverMap = [String: MediaObserver]()

    init(_ emitter: @escaping (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void) {
        self.emitter = emitter
    }

    func Release() {
        rtcChannelMap.forEach {
            $1.destroy()
        }
        rtcChannelMap.removeAll()
        rtcChannelDelegateMap.removeAll()
        mediaObserverMap.removeAll()
    }

    subscript(channelId: String) -> AgoraRtcChannel? {
        get {
            return rtcChannelMap[channelId]
        }
    }

    @objc func create(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(params["engine"] as? AgoraRtcEngineKit) { [weak self] in
            if let rtcChannel = $0.createRtcChannel(params["channelId"] as! String) {
                let delegate = RtcChannelEventHandler() { [weak self] in
                    self?.emitter($0, $1)
                }
                rtcChannel.setRtcChannelDelegate(delegate)
                self?.rtcChannelMap[rtcChannel.getId()!] = rtcChannel
                self?.rtcChannelDelegateMap[rtcChannel.getId()!] = delegate
            }
            return nil
        }
    }

    @objc func destroy(_ params: NSDictionary, _ callback: Callback) {
        callback.code(rtcChannelMap.removeValue(forKey:params["channelId"] as! String)?.destroy())
    }

    @objc func setClientRole(_ params: NSDictionary, _ callback: Callback) {
        let role = AgoraClientRole(rawValue: params["role"] as! Int)!
        if let options = params["options"] as? Dictionary<String, Any> {
            callback.code(self[params["channelId"] as! String]?.setClientRole(role, options: mapToClientRoleOptions(options)))
            return
        }
        callback.code(self[params["channelId"] as! String]?.setClientRole(role))
    }

    @objc func joinChannel(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.join(byToken: params["token"] as? String, info: params["optionalInfo"] as? String, uid: params["optionalUid"] as! UInt, options: mapToChannelMediaOptions(params["options"] as! Dictionary)))
    }

    @objc func joinChannelWithUserAccount(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.join(byUserAccount: params["userAccount"] as! String, token: params["token"] as? String, options: mapToChannelMediaOptions(params["options"] as! Dictionary)))
    }

    @objc func leaveChannel(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.leave())
    }

    @objc func renewToken(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.renewToken(params["token"] as! String))
    }

    @objc func getConnectionState(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["channelId"] as! String]) {
            $0.getConnectionState().rawValue
        }
    }

    @objc func publish(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.publish())
    }

    @objc func unpublish(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.unpublish())
    }

    @objc func getCallId(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(self[params["channelId"] as! String]) {
            $0.getCallId()
        }
    }

    @objc func adjustUserPlaybackSignalVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.adjustUserPlaybackSignalVolume(params["uid"] as! UInt, volume: params["volume"] as! Int32))
    }

    @objc func muteRemoteAudioStream(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.muteRemoteAudioStream(params["uid"] as! UInt, mute: params["muted"] as! Bool))
    }

    @objc func muteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.muteAllRemoteAudioStreams(params["muted"] as! Bool))
    }

    @objc func setDefaultMuteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setDefaultMuteAllRemoteAudioStreams(params["muted"] as! Bool))
    }

    @objc func muteRemoteVideoStream(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.muteRemoteVideoStream(params["uid"] as! UInt, mute: params["muted"] as! Bool))
    }

    @objc func muteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.muteAllRemoteVideoStreams(params["muted"] as! Bool))
    }

    @objc func setDefaultMuteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setDefaultMuteAllRemoteVideoStreams(params["muted"] as! Bool))
    }

    @objc func setRemoteVoicePosition(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setRemoteVoicePosition(params["uid"] as! UInt, pan: params["pan"] as! Double, gain: params["gain"] as! Double))
    }

    @objc func setLiveTranscoding(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setLiveTranscoding(mapToLiveTranscoding(params["transcoding"] as! Dictionary)))
    }

    @objc func addPublishStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.addPublishStreamUrl(params["url"] as! String, transcodingEnabled: params["transcodingEnabled"] as! Bool))
    }

    @objc func removePublishStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.removePublishStreamUrl(params["url"] as! String))
    }

    @objc func startChannelMediaRelay(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.startMediaRelay(mapToChannelMediaRelayConfiguration(params["channelMediaRelayConfiguration"] as! Dictionary)))
    }

    @objc func updateChannelMediaRelay(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.updateMediaRelay(mapToChannelMediaRelayConfiguration(params["channelMediaRelayConfiguration"] as! Dictionary)))
    }

    @objc func stopChannelMediaRelay(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.stopMediaRelay())
    }

    @objc func setRemoteVideoStreamType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setRemoteVideoStream(params["uid"] as! UInt, type: AgoraVideoStreamType(rawValue: params["streamType"] as! Int)!))
    }

    @objc func setRemoteDefaultVideoStreamType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setRemoteDefaultVideoStreamType(AgoraVideoStreamType(rawValue: params["streamType"] as! Int)!))
    }

    @objc func setRemoteUserPriority(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setRemoteUserPriority(params["uid"] as! UInt, type: AgoraUserPriority(rawValue: params["userPriority"] as! Int)!))
    }

    @objc func registerMediaMetadataObserver(_ params: NSDictionary, _ callback: Callback) {
        let channelId = params["channelId"] as! String
        let mediaObserver = MediaObserver { [weak self] in
            if var data = $0 {
                data["channelId"] = channelId;
                self?.emitter(RtcEngineEvents.MetadataReceived, data)
            }
        }
        callback.resolve(self[channelId]) {
            if $0.setMediaMetadataDelegate(mediaObserver, with: .video) {
                mediaObserverMap[channelId] = mediaObserver
            }
            return nil
        }
    }

    @objc func unregisterMediaMetadataObserver(_ params: NSDictionary, _ callback: Callback) {
        let channelId = params["channelId"] as! String
        callback.resolve(self[channelId]) {
            if $0.setMediaMetadataDelegate(nil, with: .video) {
                mediaObserverMap.removeValue(forKey: channelId)
            }
            return nil
        }
    }

    @objc func setMaxMetadataSize(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(mediaObserverMap[params["channelId"] as! String]) {
            $0.setMaxMetadataSize(params["size"] as! Int)
        }
    }

    @objc func sendMetadata(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(mediaObserverMap[params["channelId"] as! String]) {
            $0.addMetadata(params["metadata"] as! String)
        }
    }

    @objc func setEncryptionSecret(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.setEncryptionSecret(params["secret"] as? String))
    }

    @objc func setEncryptionMode(_ params: NSDictionary, _ callback: Callback) {
        var encryptionMode = ""
        switch params["encryptionMode"] as! Int {
        case AgoraEncryptionMode.AES128XTS.rawValue:
            encryptionMode = "aes-128-xts"
        case AgoraEncryptionMode.AES128ECB.rawValue:
            encryptionMode = "aes-128-ecb"
        case AgoraEncryptionMode.AES256XTS.rawValue:
            encryptionMode = "aes-256-xts"
        default: encryptionMode = ""
        }
        callback.code(self[params["channelId"] as! String]?.setEncryptionMode(encryptionMode))
    }

    @objc func enableEncryption(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.enableEncryption(params["enabled"] as! Bool, encryptionConfig: mapToEncryptionConfig(params["config"] as! Dictionary)))
    }

    @objc func addInjectStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.addInjectStreamUrl(params["url"] as! String, config: mapToLiveInjectStreamConfig(params["config"] as! Dictionary)))
    }

    @objc func removeInjectStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.removeInjectStreamUrl(params["url"] as! String))
    }

    @objc func createDataStream(_ params: NSDictionary, _ callback: Callback) {
        let channel = self[params["channelId"] as! String]
        var streamId = 0
        if let config = params["config"] as? Dictionary<String, Any> {
            callback.code(channel?.createDataStream(&streamId, config: mapToDataStreamConfig(config))) { _ in streamId }
            return
        }
        callback.code(channel?.createDataStream(&streamId, reliable: params["reliable"] as! Bool, ordered: params["ordered"] as! Bool)) { _ in streamId }
    }

    @objc func sendStreamMessage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.sendStreamMessage(params["streamId"] as! Int, data: (params["message"] as! String).data(using: .utf8)!))
    }
    
    @objc func enableRemoteSuperResolution(_ params: NSDictionary, callback: Callback) {
        callback.code(self[params["channelId"] as! String]?.enableRemoteSuperResolution(params["uid"] as! UInt, enabled: params["enable"] as! Bool))
    }
}
