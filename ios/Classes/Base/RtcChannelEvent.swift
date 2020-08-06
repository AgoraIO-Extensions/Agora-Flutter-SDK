//
//  RtcChannelEvent.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/10.
//  Copyright © 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

class RtcChannelEvents {
    static let Warning = "Warning"
    static let Error = "Error"
    static let JoinChannelSuccess = "JoinChannelSuccess"
    static let RejoinChannelSuccess = "RejoinChannelSuccess"
    static let LeaveChannel = "LeaveChannel"
    static let ClientRoleChanged = "ClientRoleChanged"
    static let UserJoined = "UserJoined"
    static let UserOffline = "UserOffline"
    static let ConnectionStateChanged = "ConnectionStateChanged"
    static let ConnectionLost = "ConnectionLost"
    static let TokenPrivilegeWillExpire = "TokenPrivilegeWillExpire"
    static let RequestToken = "RequestToken"
    static let ActiveSpeaker = "ActiveSpeaker"
    static let VideoSizeChanged = "VideoSizeChanged"
    static let RemoteVideoStateChanged = "RemoteVideoStateChanged"
    static let RemoteAudioStateChanged = "RemoteAudioStateChanged"
    static let LocalPublishFallbackToAudioOnly = "LocalPublishFallbackToAudioOnly"
    static let RemoteSubscribeFallbackToAudioOnly = "RemoteSubscribeFallbackToAudioOnly"
    static let RtcStats = "RtcStats"
    static let NetworkQuality = "NetworkQuality"
    static let RemoteVideoStats = "RemoteVideoStats"
    static let RemoteAudioStats = "RemoteAudioStats"
    static let RtmpStreamingStateChanged = "RtmpStreamingStateChanged"
    static let TranscodingUpdated = "TranscodingUpdated"
    static let StreamInjectedStatus = "StreamInjectedStatus"
    static let StreamMessage = "StreamMessage"
    static let StreamMessageError = "StreamMessageError"
    static let ChannelMediaRelayStateChanged = "ChannelMediaRelayStateChanged"
    static let ChannelMediaRelayEvent = "ChannelMediaRelayEvent"
    static let MetadataReceived = "MetadataReceived"

    static func toMap() -> Dictionary<String, String> {
        return [
            "Warning": Warning,
            "Error": Error,
            "JoinChannelSuccess": JoinChannelSuccess,
            "RejoinChannelSuccess": RejoinChannelSuccess,
            "LeaveChannel": LeaveChannel,
            "ClientRoleChanged": ClientRoleChanged,
            "UserJoined": UserJoined,
            "UserOffline": UserOffline,
            "ConnectionStateChanged": ConnectionStateChanged,
            "ConnectionLost": ConnectionLost,
            "TokenPrivilegeWillExpire": TokenPrivilegeWillExpire,
            "RequestToken": RequestToken,
            "ActiveSpeaker": ActiveSpeaker,
            "VideoSizeChanged": VideoSizeChanged,
            "RemoteVideoStateChanged": RemoteVideoStateChanged,
            "RemoteAudioStateChanged": RemoteAudioStateChanged,
            "LocalPublishFallbackToAudioOnly": LocalPublishFallbackToAudioOnly,
            "RemoteSubscribeFallbackToAudioOnly": RemoteSubscribeFallbackToAudioOnly,
            "RtcStats": RtcStats,
            "NetworkQuality": NetworkQuality,
            "RemoteVideoStats": RemoteVideoStats,
            "RemoteAudioStats": RemoteAudioStats,
            "RtmpStreamingStateChanged": RtmpStreamingStateChanged,
            "TranscodingUpdated": TranscodingUpdated,
            "StreamInjectedStatus": StreamInjectedStatus,
            "StreamMessage": StreamMessage,
            "StreamMessageError": StreamMessageError,
            "ChannelMediaRelayStateChanged": ChannelMediaRelayStateChanged,
            "ChannelMediaRelayEvent": ChannelMediaRelayEvent,
            "MetadataReceived": MetadataReceived,
        ]
    }
}

class RtcChannelEventHandler: NSObject {
    static let PREFIX = "io.agora.rtc."

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
        callback(RtcChannelEvents.Warning, rtcChannel, warningCode.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didOccurError errorCode: AgoraErrorCode) {
        callback(RtcChannelEvents.Error, rtcChannel, errorCode.rawValue)
    }

    public func rtcChannelDidJoin(_ rtcChannel: AgoraRtcChannel, withUid uid: UInt, elapsed: Int) {
        callback(RtcChannelEvents.JoinChannelSuccess, rtcChannel, uid, elapsed)
    }

    public func rtcChannelDidRejoin(_ rtcChannel: AgoraRtcChannel, withUid uid: UInt, elapsed: Int) {
        callback(RtcChannelEvents.RejoinChannelSuccess, rtcChannel, uid, elapsed)
    }

    public func rtcChannelDidLeave(_ rtcChannel: AgoraRtcChannel, with stats: AgoraChannelStats) {
        callback(RtcChannelEvents.LeaveChannel, rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didClientRoleChanged oldRole: AgoraClientRole, newRole: AgoraClientRole) {
        callback(RtcChannelEvents.ClientRoleChanged, rtcChannel, oldRole.rawValue, newRole.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didJoinedOfUid uid: UInt, elapsed: Int) {
        callback(RtcChannelEvents.UserJoined, rtcChannel, uid, elapsed)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        callback(RtcChannelEvents.UserOffline, rtcChannel, uid, reason.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, connectionChangedTo state: AgoraConnectionStateType, reason: AgoraConnectionChangedReason) {
        callback(RtcChannelEvents.ConnectionStateChanged, rtcChannel, state.rawValue, reason.rawValue)
    }

    public func rtcChannelDidLost(_ rtcChannel: AgoraRtcChannel) {
        callback(RtcChannelEvents.ConnectionLost, rtcChannel)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, tokenPrivilegeWillExpire token: String) {
        callback(RtcChannelEvents.TokenPrivilegeWillExpire, rtcChannel, token)
    }

    public func rtcChannelRequestToken(_ rtcChannel: AgoraRtcChannel) {
        callback(RtcChannelEvents.RequestToken, rtcChannel)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, activeSpeaker speakerUid: UInt) {
        callback(RtcChannelEvents.ActiveSpeaker, rtcChannel, speakerUid)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, videoSizeChangedOfUid uid: UInt, size: CGSize, rotation: Int) {
        callback(RtcChannelEvents.VideoSizeChanged, rtcChannel, uid, Int(size.width), Int(size.height), rotation)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteVideoStateChangedOfUid uid: UInt, state: AgoraVideoRemoteState, reason: AgoraVideoRemoteStateReason, elapsed: Int) {
        callback(RtcChannelEvents.RemoteVideoStateChanged, rtcChannel, uid, state.rawValue, reason.rawValue, elapsed)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteAudioStateChangedOfUid uid: UInt, state: AgoraAudioRemoteState, reason: AgoraAudioRemoteStateReason, elapsed: Int) {
        callback(RtcChannelEvents.RemoteAudioStateChanged, rtcChannel, uid, state.rawValue, reason.rawValue, elapsed)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didLocalPublishFallbackToAudioOnly isFallbackOrRecover: Bool) {
        callback(RtcChannelEvents.LocalPublishFallbackToAudioOnly, rtcChannel, isFallbackOrRecover)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didRemoteSubscribeFallbackToAudioOnly isFallbackOrRecover: Bool, byUid uid: UInt) {
        callback(RtcChannelEvents.RemoteSubscribeFallbackToAudioOnly, rtcChannel, uid, isFallbackOrRecover)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, reportRtcStats stats: AgoraChannelStats) {
        callback(RtcChannelEvents.RtcStats, rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, networkQuality uid: UInt, txQuality: AgoraNetworkQuality, rxQuality: AgoraNetworkQuality) {
        callback(RtcChannelEvents.NetworkQuality, rtcChannel, uid, txQuality.rawValue, rxQuality.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteVideoStats stats: AgoraRtcRemoteVideoStats) {
        callback(RtcChannelEvents.RemoteVideoStats, rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, remoteAudioStats stats: AgoraRtcRemoteAudioStats) {
        callback(RtcChannelEvents.RemoteAudioStats, rtcChannel, stats.toMap())
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, rtmpStreamingChangedToState url: String, state: AgoraRtmpStreamingState, errorCode: AgoraRtmpStreamingErrorCode) {
        callback(RtcChannelEvents.RtmpStreamingStateChanged, rtcChannel, url, state.rawValue, errorCode.rawValue)
    }

    public func rtcChannelTranscodingUpdated(_ rtcChannel: AgoraRtcChannel) {
        callback(RtcChannelEvents.TranscodingUpdated, rtcChannel)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, streamInjectedStatusOfUrl url: String, uid: UInt, status: AgoraInjectStreamStatus) {
        callback(RtcChannelEvents.StreamInjectedStatus, rtcChannel, url, uid, status.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, receiveStreamMessageFromUid uid: UInt, streamId: Int, data: Data) {
        callback(RtcChannelEvents.StreamMessage, rtcChannel, uid, streamId, String(data: data, encoding: .utf8))
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didOccurStreamMessageErrorFromUid uid: UInt, streamId: Int, error: Int, missed: Int, cached: Int) {
        callback(RtcChannelEvents.StreamMessageError, rtcChannel, uid, streamId, error, missed, cached)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, channelMediaRelayStateDidChange state: AgoraChannelMediaRelayState, error: AgoraChannelMediaRelayError) {
        callback(RtcChannelEvents.ChannelMediaRelayStateChanged, rtcChannel, state.rawValue, error.rawValue)
    }

    public func rtcChannel(_ rtcChannel: AgoraRtcChannel, didReceive event: AgoraChannelMediaRelayEvent) {
        callback(RtcChannelEvents.ChannelMediaRelayEvent, rtcChannel, event.rawValue)
    }
}
