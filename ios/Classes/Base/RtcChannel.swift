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
    associatedtype Map
    associatedtype Callback

    func create(_ channelId: String, _ callback: Callback?)

    func destroy(_ channelId: String, _ callback: Callback?)

    func setClientRole(_ channelId: String, _ role: Int, _ callback: Callback?)

    func joinChannel(_ channelId: String, _ token: String?, _ optionalInfo: String?, _ optionalUid: Int, _ options: Map, _ callback: Callback?)

    func joinChannelWithUserAccount(_ channelId: String, _ token: String?, _ userAccount: String, _ options: Map, _ callback: Callback?)

    func leaveChannel(_ channelId: String, _ callback: Callback?)

    func renewToken(_ channelId: String, _ token: String, _ callback: Callback?)

    func getConnectionState(_ channelId: String, _ callback: Callback?)

    func publish(_ channelId: String, _ callback: Callback?)

    func unpublish(_ channelId: String, _ callback: Callback?)

    func getCallId(_ channelId: String, _ callback: Callback?)
}

class RtcChannelManager {
    private var rtcChannelMap = [String: AgoraRtcChannel]()
    private var rtcChannelDelegateMap = [String: RtcChannelEventHandler]()
    private var mediaObserverMap = [String: MediaObserver]()

    func create(_ engine: AgoraRtcEngineKit, _ channelId: String, _ emit: @escaping (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void) {
        if let rtcChannel = engine.createRtcChannel(channelId) {
            let delegate = RtcChannelEventHandler() { methodName, data in
                emit(methodName, data)
            }
            rtcChannel.setRtcChannelDelegate(delegate)
            rtcChannelMap[channelId] = rtcChannel
            rtcChannelDelegateMap[channelId] = delegate
        }
    }

    func destroy(_ channelId: String) -> Int32 {
        if let rtcChannel = self[channelId] {
            let res = rtcChannel.destroy()
            if (res == 0) {
                rtcChannelMap.removeValue(forKey: channelId)
                rtcChannelDelegateMap.removeValue(forKey: channelId)
            }
            return res
        }
        return Int32(AgoraErrorCode.notInitialized.rawValue)
    }

    func release() {
        rtcChannelMap.forEach { key, value in
            value.destroy()
        }
        rtcChannelMap.removeAll()
        rtcChannelDelegateMap.removeAll()
        mediaObserverMap.removeAll()
    }

    subscript(channelId: String) -> AgoraRtcChannel? {
        get {
            rtcChannelMap[channelId]
        }
    }

    func registerMediaMetadataObserver(_ channelId: String, _ emit: @escaping (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void) -> Int32 {
        if let rtcChannel = self[channelId] {
            let mediaObserver = MediaObserver() { data in
                if var `data` = data {
                    data["channelId"] = channelId
                    emit(RtcChannelEvents.MetadataReceived, data)
                }
            }
            let res = rtcChannel.setMediaMetadataDelegate(mediaObserver, with: .video)
            if res {
                mediaObserverMap[channelId] = mediaObserver
                return 0
            }
        }
        return Int32(AgoraErrorCode.notInitialized.rawValue)
    }

    func unregisterMediaMetadataObserver(_ channelId: String) -> Int32 {
        if let rtcChannel = self[channelId] {
            let res = rtcChannel.setMediaMetadataDelegate(nil, with: .video)
            if res {
                mediaObserverMap.removeValue(forKey: channelId)
                return 0
            }
        }
        return Int32(AgoraErrorCode.notInitialized.rawValue)
    }

    func setMaxMetadataSize(_ channelId: String, _ size: Int) -> Int32 {
        if let observer = mediaObserverMap[channelId] {
            observer.setMaxMetadataSize(size)
            return 0
        }
        return Int32(AgoraErrorCode.notInitialized.rawValue)
    }

    func addMetadata(_ channelId: String, _ metadata: String) -> Int32 {
        if let observer = mediaObserverMap[channelId] {
            observer.addMetadata(metadata)
            return 0
        }
        return Int32(AgoraErrorCode.notInitialized.rawValue)
    }

    func createDataStream(_ channelId: String, _ reliable: Bool, _ ordered: Bool) -> Int32 {
        if let rtcChannel = self[channelId] {
            var streamId = 0
            let res = rtcChannel.createDataStream(&streamId, reliable: reliable, ordered: ordered)
            if res == 0 {
                return Int32(streamId)
            }
            return res
        }
        return Int32(AgoraErrorCode.notInitialized.rawValue)
    }

    func sendStreamMessage(_ channelId: String, _ streamId: Int, _ message: String) -> Int32 {
        if let rtcChannel = self[channelId] {
            if let data = message.data(using: .utf8) {
                return rtcChannel.sendStreamMessage(streamId, data: data)
            }
            return Int32(AgoraErrorCode.invalidArgument.rawValue)
        }
        return Int32(AgoraErrorCode.notInitialized.rawValue)
    }
}

protocol RtcChannelAudioInterface {
    associatedtype Callback

    func adjustUserPlaybackSignalVolume(_ channelId: String, _ uid: Int, _ volume: Int, _ callback: Callback?)

    func muteRemoteAudioStream(_ channelId: String, _ uid: Int, _ muted: Bool, _ callback: Callback?)

    func muteAllRemoteAudioStreams(_ channelId: String, _ muted: Bool, _ callback: Callback?)

    func setDefaultMuteAllRemoteAudioStreams(_ channelId: String, _ muted: Bool, _ callback: Callback?)
}

protocol RtcChannelVideoInterface {
    associatedtype Callback

    func muteRemoteVideoStream(_ channelId: String, _ uid: Int, _ muted: Bool, _ callback: Callback?)

    func muteAllRemoteVideoStreams(_ channelId: String, _ muted: Bool, _ callback: Callback?)

    func setDefaultMuteAllRemoteVideoStreams(_ channelId: String, _ muted: Bool, _ callback: Callback?)
}

protocol RtcChannelVoicePositionInterface {
    associatedtype Callback

    func setRemoteVoicePosition(_ channelId: String, _ uid: Int, _ pan: Double, _ gain: Double, _ callback: Callback?)
}

protocol RtcChannelPublishStreamInterface {
    associatedtype Map
    associatedtype Callback

    func setLiveTranscoding(_ channelId: String, _ transcoding: Map, _ callback: Callback?)

    func addPublishStreamUrl(_ channelId: String, _ url: String, _ transcodingEnabled: Bool, _ callback: Callback?)

    func removePublishStreamUrl(_ channelId: String, _ url: String, _ callback: Callback?)
}

protocol RtcChannelMediaRelayInterface {
    associatedtype Map
    associatedtype Callback

    func startChannelMediaRelay(_ channelId: String, _ channelMediaRelayConfiguration: Map, _ callback: Callback?)

    func updateChannelMediaRelay(_ channelId: String, _ channelMediaRelayConfiguration: Map, _ callback: Callback?)

    func stopChannelMediaRelay(_ channelId: String, _ callback: Callback?)
}

protocol RtcChannelDualStreamInterface {
    associatedtype Callback

    func setRemoteVideoStreamType(_ channelId: String, _ uid: Int, _ streamType: Int, _ callback: Callback?)

    func setRemoteDefaultVideoStreamType(_ channelId: String, _ streamType: Int, _ callback: Callback?)
}

protocol RtcChannelFallbackInterface {
    associatedtype Callback

    func setRemoteUserPriority(_ channelId: String, _ uid: Int, _ userPriority: Int, _ callback: Callback?)
}

protocol RtcChannelMediaMetadataInterface {
    associatedtype Callback

    func registerMediaMetadataObserver(_ channelId: String, _ callback: Callback?)

    func unregisterMediaMetadataObserver(_ channelId: String, _ callback: Callback?)

    func setMaxMetadataSize(_ channelId: String, _ size: Int, _ callback: Callback?)

    func sendMetadata(_ channelId: String, _ metadata: String, _ callback: Callback?)
}

protocol RtcChannelEncryptionInterface {
    associatedtype Callback

    func setEncryptionSecret(_ channelId: String, _ secret: String, _ callback: Callback?)

    func setEncryptionMode(_ channelId: String, _ encryptionMode: String, _ callback: Callback?)
}

protocol RtcChannelInjectStreamInterface {
    associatedtype Map
    associatedtype Callback

    func addInjectStreamUrl(_ channelId: String, _ url: String, _ config: Map, _ callback: Callback?)

    func removeInjectStreamUrl(_ channelId: String, _ url: String, _ callback: Callback?)
}

protocol RtcChannelStreamMessageInterface {
    associatedtype Callback

    func createDataStream(_ channelId: String, _ reliable: Bool, _ ordered: Bool, _ callback: Callback?)

    func sendStreamMessage(_ channelId: String, _ streamId: Int, _ message: String, _ callback: Callback?)
}
