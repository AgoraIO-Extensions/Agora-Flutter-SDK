//
//  RtcChannelEventHandler.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/10.
//  Copyright © 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

class RtcChannelEventHandler: NSObject {
    static let PREFIX = "io.agora.rtc."
    static let EVENTS = [
        "Warning": "Warning",
        "Error": "Error",
        "JoinChannelSuccess": "JoinChannelSuccess",
        "RejoinChannelSuccess": "RejoinChannelSuccess",
        "LeaveChannel": "LeaveChannel",
        "ClientRoleChanged": "ClientRoleChanged",
        "UserJoined": "UserJoined",
        "UserOffline": "UserOffline",
        "ConnectionStateChanged": "ConnectionStateChanged",
        "ConnectionLost": "ConnectionLost",
        "TokenPrivilegeWillExpire": "TokenPrivilegeWillExpire",
        "RequestToken": "RequestToken",
        "ActiveSpeaker": "ActiveSpeaker",
        "VideoSizeChanged": "VideoSizeChanged",
        "RemoteVideoStateChanged": "RemoteVideoStateChanged",
        "RemoteAudioStateChanged": "RemoteAudioStateChanged",
        "LocalPublishFallbackToAudioOnly": "LocalPublishFallbackToAudioOnly",
        "RemoteSubscribeFallbackToAudioOnly": "RemoteSubscribeFallbackToAudioOnly",
        "RtcStats": "RtcStats",
        "NetworkQuality": "NetworkQuality",
        "RemoteVideoStats": "RemoteVideoStats",
        "RemoteAudioStats": "RemoteAudioStats",
        "RtmpStreamingStateChanged": "RtmpStreamingStateChanged",
        "TranscodingUpdated": "TranscodingUpdated",
        "StreamInjectedStatus": "StreamInjectedStatus",
        "StreamMessage": "StreamMessage",
        "StreamMessageError": "StreamMessageError",
        "ChannelMediaRelayStateChanged": "ChannelMediaRelayStateChanged",
        "ChannelMediaRelayEvent": "ChannelMediaRelayEvent",
        "MetadataReceived": "MetadataReceived",
    ]

    var emitter: (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void

    init(_ emitter: @escaping (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void) {
        self.emitter = emitter
    }

    private func callback(_ methodName: String, _ channel: AgoraRtcChannel, _ data: Any?...) {
        emitter(methodName, [
            "channelId": channel.getId(),
            "data": data
        ])
    }
}

extension RtcChannelEventHandler: AgoraRtcChannelDelegate {
    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didOccurWarning warningCode: AgoraWarningCode) {
        callback("Warning", rtcChannel, warningCode.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didOccurError errorCode: AgoraErrorCode) {
        callback("Error", rtcChannel, errorCode.rawValue)
    }

    public func rtcChannelDidJoin(_ rtcChannel: AgoraRtcChannel, withUid uid: UInt, elapsed: Int) {
        callback("JoinChannelSuccess", rtcChannel, uid, elapsed)
    }

    public func rtcChannelDidRejoin(_ rtcChannel: AgoraRtcChannel, withUid uid: UInt, elapsed: Int) {
        callback("RejoinChannelSuccess", rtcChannel, uid, elapsed)
    }

    public func rtcChannelDidLeave(_ rtcChannel: AgoraRtcChannel, with stats: AgoraChannelStats) {
        callback("LeaveChannel", rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didClientRoleChanged oldRole: AgoraClientRole, newRole: AgoraClientRole) {
        callback("ClientRoleChanged", rtcChannel, oldRole.rawValue, newRole.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didJoinedOfUid uid: UInt, elapsed: Int) {
        callback("UserJoined", rtcChannel, uid, elapsed)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        callback("UserOffline", rtcChannel, uid, reason.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, connectionChangedTo state: AgoraConnectionStateType, reason: AgoraConnectionChangedReason) {
        callback("ConnectionStateChanged", rtcChannel, state.rawValue, reason.rawValue)
    }

    public func rtcChannelDidLost(_ rtcChannel: AgoraRtcChannel) {
        callback("ConnectionLost", rtcChannel)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, tokenPrivilegeWillExpire token: String) {
        callback("TokenPrivilegeWillExpire", rtcChannel, token)
    }

    public func rtcChannelRequestToken(_ rtcChannel: AgoraRtcChannel) {
        callback("RequestToken", rtcChannel)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, activeSpeaker speakerUid: UInt) {
        callback("ActiveSpeaker", rtcChannel, speakerUid)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, videoSizeChangedOfUid uid: UInt, size: CGSize, rotation: Int) {
        callback("VideoSizeChanged", rtcChannel, uid, size.width, size.height, rotation)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteVideoStateChangedOfUid uid: UInt, state: AgoraVideoRemoteState, reason: AgoraVideoRemoteStateReason, elapsed: Int) {
        callback("RemoteVideoStateChanged", rtcChannel, uid, state.rawValue, reason.rawValue, elapsed)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteAudioStateChangedOfUid uid: UInt, state: AgoraAudioRemoteState, reason: AgoraAudioRemoteStateReason, elapsed: Int) {
        callback("RemoteAudioStateChanged", rtcChannel, uid, state.rawValue, reason.rawValue, elapsed)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didLocalPublishFallbackToAudioOnly isFallbackOrRecover: Bool) {
        callback("LocalPublishFallbackToAudioOnly", rtcChannel, isFallbackOrRecover)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didRemoteSubscribeFallbackToAudioOnly isFallbackOrRecover: Bool, byUid uid: UInt) {
        callback("RemoteSubscribeFallbackToAudioOnly", rtcChannel, uid, isFallbackOrRecover)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, reportRtcStats stats: AgoraChannelStats) {
        callback("RtcStats", rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, networkQuality uid: UInt, txQuality: AgoraNetworkQuality, rxQuality: AgoraNetworkQuality) {
        callback("NetworkQuality", rtcChannel, uid, txQuality, rxQuality)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteVideoStats stats: AgoraRtcRemoteVideoStats) {
        callback("RemoteVideoStats", rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteAudioStats stats: AgoraRtcRemoteAudioStats) {
        callback("RemoteAudioStats", rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, rtmpStreamingChangedToState url: String, state: AgoraRtmpStreamingState, errorCode: AgoraRtmpStreamingErrorCode) {
        callback("RtmpStreamingStateChanged", rtcChannel, url, state.rawValue, errorCode.rawValue)
    }

    public func rtcChannelTranscodingUpdated(_ rtcChannel: AgoraRtcChannel) {
        callback("TranscodingUpdated", rtcChannel)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, streamInjectedStatusOfUrl url: String, uid: UInt, status: AgoraInjectStreamStatus) {
        callback("StreamInjectedStatus", rtcChannel, url, uid, status.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, receiveStreamMessageFromUid uid: UInt, streamId: Int, data: Data) {
        callback("StreamMessage", rtcChannel, uid, streamId, String(data: data, encoding: .utf8))
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didOccurStreamMessageErrorFromUid uid: UInt, streamId: Int, error: Int, missed: Int, cached: Int) {
        callback("StreamMessageError", rtcChannel, uid, streamId, error, missed, cached)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, channelMediaRelayStateDidChange state: AgoraChannelMediaRelayState, error: AgoraChannelMediaRelayError) {
        callback("ChannelMediaRelayStateChanged", rtcChannel, state.rawValue, error.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didReceive event: AgoraChannelMediaRelayEvent) {
        callback("ChannelMediaRelayEvent", rtcChannel, event.rawValue)
    }
}
