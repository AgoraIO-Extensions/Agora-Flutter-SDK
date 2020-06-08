//
//  RtcEngineEventHandler.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/13.
//  Copyright (c) 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

class RtcEngineEventHandler: NSObject {
    static let PREFIX = "io.agora.rtc."
    static let EVENTS = [
        "Warning": "Warning",
        "Error": "Error",
        "ApiCallExecuted": "ApiCallExecuted",
        "JoinChannelSuccess": "JoinChannelSuccess",
        "RejoinChannelSuccess": "RejoinChannelSuccess",
        "LeaveChannel": "LeaveChannel",
        "LocalUserRegistered": "LocalUserRegistered",
        "UserInfoUpdated": "UserInfoUpdated",
        "ClientRoleChanged": "ClientRoleChanged",
        "UserJoined": "UserJoined",
        "UserOffline": "UserOffline",
        "ConnectionStateChanged": "ConnectionStateChanged",
        "NetworkTypeChanged": "NetworkTypeChanged",
        "ConnectionLost": "ConnectionLost",
        "TokenPrivilegeWillExpire": "TokenPrivilegeWillExpire",
        "RequestToken": "RequestToken",
        "AudioVolumeIndication": "AudioVolumeIndication",
        "ActiveSpeaker": "ActiveSpeaker",
        "FirstLocalAudioFrame": "FirstLocalAudioFrame",
        "FirstLocalVideoFrame": "FirstLocalVideoFrame",
        "UserMuteVideo": "UserMuteVideo",
        "VideoSizeChanged": "VideoSizeChanged",
        "RemoteVideoStateChanged": "RemoteVideoStateChanged",
        "LocalVideoStateChanged": "LocalVideoStateChanged",
        "RemoteAudioStateChanged": "RemoteAudioStateChanged",
        "LocalAudioStateChanged": "LocalAudioStateChanged",
        "LocalPublishFallbackToAudioOnly": "LocalPublishFallbackToAudioOnly",
        "RemoteSubscribeFallbackToAudioOnly": "RemoteSubscribeFallbackToAudioOnly",
        "AudioRouteChanged": "AudioRouteChanged",
        "CameraFocusAreaChanged": "CameraFocusAreaChanged",
        "CameraExposureAreaChanged": "CameraExposureAreaChanged",
        "RtcStats": "RtcStats",
        "LastmileQuality": "LastmileQuality",
        "NetworkQuality": "NetworkQuality",
        "LastmileProbeResult": "LastmileProbeResult",
        "LocalVideoStats": "LocalVideoStats",
        "LocalAudioStats": "LocalAudioStats",
        "RemoteVideoStats": "RemoteVideoStats",
        "RemoteAudioStats": "RemoteAudioStats",
        "AudioMixingFinished": "AudioMixingFinished",
        "AudioMixingStateChanged": "AudioMixingStateChanged",
        "AudioEffectFinished": "AudioEffectFinished",
        "RtmpStreamingStateChanged": "RtmpStreamingStateChanged",
        "TranscodingUpdated": "TranscodingUpdated",
        "StreamInjectedStatus": "StreamInjectedStatus",
        "StreamMessage": "StreamMessage",
        "StreamMessageError": "StreamMessageError",
        "MediaEngineLoadSuccess": "MediaEngineLoadSuccess",
        "MediaEngineStartCallSuccess": "MediaEngineStartCallSuccess",
        "ChannelMediaRelayStateChanged": "ChannelMediaRelayStateChanged",
        "ChannelMediaRelayEvent": "ChannelMediaRelayEvent",
        "FirstRemoteVideoFrame": "FirstRemoteVideoFrame",
        "FirstRemoteAudioFrame": "FirstRemoteAudioFrame",
        "FirstRemoteAudioDecoded": "FirstRemoteAudioDecoded",
        "UserMuteAudio": "UserMuteAudio",
        "StreamPublished": "StreamPublished",
        "StreamUnpublished": "StreamUnpublished",
        "RemoteAudioTransportStats": "RemoteAudioTransportStats",
        "RemoteVideoTransportStats": "RemoteVideoTransportStats",
        "UserEnableVideo": "UserEnableVideo",
        "UserEnableLocalVideo": "UserEnableLocalVideo",
        "FirstRemoteVideoDecoded": "FirstRemoteVideoDecoded",
        "MicrophoneEnabled": "MicrophoneEnabled",
        "ConnectionInterrupted": "ConnectionInterrupted",
        "ConnectionBanned": "ConnectionBanned",
        "AudioQuality": "AudioQuality",
        "CameraReady": "CameraReady",
        "VideoStopped": "VideoStopped",
        "MetadataReceived": "MetadataReceived",
    ]

    var emitter: (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void

    init(emitter: @escaping (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void) {
        self.emitter = emitter
    }

    private func callback(_ methodName: String, _ data: Any?...) {
        emitter(methodName, ["data": data])
    }
}

extension RtcEngineEventHandler: AgoraRtcEngineDelegate {
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurWarning warningCode: AgoraWarningCode) {
        callback("Warning", warningCode.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurError errorCode: AgoraErrorCode) {
        callback("Error", errorCode.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didApiCallExecute error: Int, api: String, result: String) {
        callback("ApiCallExecuted", error, api, result)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        callback("JoinChannelSuccess", channel, uid, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didRejoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        callback("RejoinChannelSuccess", uid, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didLeaveChannelWith stats: AgoraChannelStats) {
        callback("LeaveChannel", stats.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didRegisteredLocalUser userAccount: String, withUid uid: UInt) {
        callback("LocalUserRegistered", uid, userAccount)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didUpdatedUserInfo userInfo: AgoraUserInfo, withUid uid: UInt) {
        callback("UserInfoUpdated", uid, userInfo.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didClientRoleChanged oldRole: AgoraClientRole, newRole: AgoraClientRole) {
        callback("ClientRoleChanged", oldRole.rawValue, newRole.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        callback("UserJoined", uid, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid: UInt, reason: AgoraUserOfflineReason) {
        callback("UserOffline", uid, reason.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, connectionChangedTo state: AgoraConnectionStateType, reason: AgoraConnectionChangedReason) {
        callback("ConnectionStateChanged", state.rawValue, reason.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, networkTypeChangedTo type: AgoraNetworkType) {
        callback("NetworkTypeChanged", type.rawValue)
    }

    public func rtcEngineConnectionDidLost(_ engine: AgoraRtcEngineKit) {
        callback("ConnectionLost")
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, tokenPrivilegeWillExpire token: String) {
        callback("TokenPrivilegeWillExpire", token)
    }

    public func rtcEngineRequestToken(_ engine: AgoraRtcEngineKit) {
        callback("RequestToken")
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, reportAudioVolumeIndicationOfSpeakers speakers: [AgoraRtcAudioVolumeInfo], totalVolume: Int) {
        callback("AudioVolumeIndication", speakers.toMapList(), totalVolume)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, activeSpeaker speakerUid: UInt) {
        callback("ActiveSpeaker", speakerUid)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, firstLocalAudioFrame elapsed: Int) {
        callback("FirstLocalAudioFrame", elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, firstLocalVideoFrameWith size: CGSize, elapsed: Int) {
        callback("FirstLocalVideoFrame", size.width, size.height, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didVideoMuted muted: Bool, byUid uid: UInt) {
        callback("UserMuteVideo", uid, muted)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, videoSizeChangedOfUid uid: UInt, size: CGSize, rotation: Int) {
        callback("VideoSizeChanged", uid, size.width, size.height, rotation)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, remoteVideoStateChangedOfUid uid: UInt, state: AgoraVideoRemoteState, reason: AgoraVideoRemoteStateReason, elapsed: Int) {
        callback("RemoteVideoStateChanged", uid, state.rawValue, reason.rawValue, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, localVideoStateChange state: AgoraLocalVideoStreamState, error: AgoraLocalVideoStreamError) {
        callback("LocalVideoStateChanged", state.rawValue, error.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, remoteAudioStateChangedOfUid uid: UInt, state: AgoraAudioRemoteState, reason: AgoraAudioRemoteStateReason, elapsed: Int) {
        callback("RemoteAudioStateChanged", uid, state.rawValue, reason.rawValue, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, localAudioStateChange state: AgoraAudioLocalState, error: AgoraAudioLocalError) {
        callback("LocalAudioStateChanged", state.rawValue, error.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didLocalPublishFallbackToAudioOnly isFallbackOrRecover: Bool) {
        callback("LocalPublishFallbackToAudioOnly", isFallbackOrRecover)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didRemoteSubscribeFallbackToAudioOnly isFallbackOrRecover: Bool, byUid uid: UInt) {
        callback("RemoteSubscribeFallbackToAudioOnly", uid, isFallbackOrRecover)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didAudioRouteChanged routing: AgoraAudioOutputRouting) {
        callback("AudioRouteChanged", routing.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, cameraFocusDidChangedTo rect: CGRect) {
        callback("CameraFocusAreaChanged", rect.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, cameraExposureDidChangedTo rect: CGRect) {
        callback("CameraExposureAreaChanged", rect.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, reportRtcStats stats: AgoraChannelStats) {
        callback("RtcStats", stats.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileQuality quality: AgoraNetworkQuality) {
        callback("LastmileQuality", quality.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, networkQuality uid: UInt, txQuality: AgoraNetworkQuality, rxQuality: AgoraNetworkQuality) {
        callback("NetworkQuality", uid, txQuality.rawValue, rxQuality.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileProbeTest result: AgoraLastmileProbeResult) {
        callback("LastmileProbeResult", result.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, localVideoStats stats: AgoraRtcLocalVideoStats) {
        callback("LocalVideoStats", stats.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, localAudioStats stats: AgoraRtcLocalAudioStats) {
        callback("LocalAudioStats", stats.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, remoteVideoStats stats: AgoraRtcRemoteVideoStats) {
        callback("RemoteVideoStats", stats.toMap())
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, remoteAudioStats stats: AgoraRtcRemoteAudioStats) {
        callback("RemoteAudioStats", stats.toMap())
    }

    public func rtcEngineLocalAudioMixingDidFinish(_ engine: AgoraRtcEngineKit) {
        callback("AudioMixingFinished")
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, localAudioMixingStateDidChanged state: AgoraAudioMixingStateCode, errorCode: AgoraAudioMixingErrorCode) {
        callback("AudioMixingStateChanged", state.rawValue, errorCode.rawValue)
    }

    public func rtcEngineRemoteAudioMixingDidStart(_ engine: AgoraRtcEngineKit) {
        // TODO Not in Android
    }

    public func rtcEngineRemoteAudioMixingDidFinish(_ engine: AgoraRtcEngineKit) {
        // TODO Not in Android
    }

    public func rtcEngineDidAudioEffectFinish(_ engine: AgoraRtcEngineKit, soundId: Int) {
        callback("AudioEffectFinished", soundId)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, rtmpStreamingChangedToState url: String, state: AgoraRtmpStreamingState, errorCode: AgoraRtmpStreamingErrorCode) {
        callback("RtmpStreamingStateChanged", url, state.rawValue, errorCode.rawValue)
    }

    public func rtcEngineTranscodingUpdated(_ engine: AgoraRtcEngineKit) {
        callback("TranscodingUpdated")
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, streamInjectedStatusOfUrl url: String, uid: UInt, status: AgoraInjectStreamStatus) {
        callback("StreamInjectedStatus", url, uid, status.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, receiveStreamMessageFromUid uid: UInt, streamId: Int, data: Data) {
        callback("StreamMessage", uid, streamId, String(data: data, encoding: .utf8))
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurStreamMessageErrorFromUid uid: UInt, streamId: Int, error: Int, missed: Int, cached: Int) {
        callback("StreamMessageError", uid, streamId, error, missed, cached)
    }

    public func rtcEngineMediaEngineDidLoaded(_ engine: AgoraRtcEngineKit) {
        callback("MediaEngineLoadSuccess")
    }

    public func rtcEngineMediaEngineDidStartCall(_ engine: AgoraRtcEngineKit) {
        callback("MediaEngineStartCallSuccess")
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, channelMediaRelayStateDidChange state: AgoraChannelMediaRelayState, error: AgoraChannelMediaRelayError) {
        callback("ChannelMediaRelayStateChanged", state.rawValue, error.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didReceive event: AgoraChannelMediaRelayEvent) {
        callback("ChannelMediaRelayEvent", event.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoFrameOfUid uid: UInt, size: CGSize, elapsed: Int) {
        callback("FirstRemoteVideoFrame", uid, size.width, size.height, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteAudioFrameOfUid uid: UInt, elapsed: Int) {
        callback("FirstRemoteAudioFrame", uid, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteAudioFrameDecodedOfUid uid: UInt, elapsed: Int) {
        callback("FirstRemoteAudioDecoded", uid, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didAudioMuted muted: Bool, byUid uid: UInt) {
        callback("UserMuteAudio", uid, muted)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, streamPublishedWithUrl url: String, errorCode: AgoraErrorCode) {
        callback("StreamPublished", url, errorCode.rawValue)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, streamUnpublishedWithUrl url: String) {
        callback("StreamUnpublished", url)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, audioTransportStatsOfUid uid: UInt, delay: UInt, lost: UInt, rxKBitRate: UInt) {
        callback("RemoteAudioTransportStats", uid, delay, lost, rxKBitRate)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, videoTransportStatsOfUid uid: UInt, delay: UInt, lost: UInt, rxKBitRate: UInt) {
        callback("RemoteVideoTransportStats", uid, delay, lost, rxKBitRate)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didVideoEnabled enabled: Bool, byUid uid: UInt) {
        callback("UserEnableVideo", uid, enabled)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didLocalVideoEnabled enabled: Bool, byUid uid: UInt) {
        callback("UserEnableLocalVideo", uid, enabled)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
        callback("FirstRemoteVideoDecoded", uid, size.width, size.height, elapsed)
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, didMicrophoneEnabled enabled: Bool) {
        callback("MicrophoneEnabled", enabled)
    }

    public func rtcEngineConnectionDidInterrupted(_ engine: AgoraRtcEngineKit) {
        callback("ConnectionInterrupted")
    }

    public func rtcEngineConnectionDidBanned(_ engine: AgoraRtcEngineKit) {
        callback("ConnectionBanned")
    }

    public func rtcEngine(_ engine: AgoraRtcEngineKit, audioQualityOfUid uid: UInt, quality: AgoraNetworkQuality, delay: UInt, lost: UInt) {
        callback("AudioQuality", uid, quality.rawValue, delay, lost)
    }

    public func rtcEngineCameraDidReady(_ engine: AgoraRtcEngineKit) {
        callback("CameraReady")
    }

    public func rtcEngineVideoDidStop(_ engine: AgoraRtcEngineKit) {
        callback("VideoStopped")
    }
}
