package io.agora.rtc.base

import android.graphics.Rect
import androidx.annotation.IntRange
import io.agora.rtc.IRtcEngineEventHandler
import io.agora.rtc.models.UserInfo

class RtcEngineEventHandler(
        private val emitter: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcEngineEventHandler() {
    companion object {
        const val PREFIX = "io.agora.rtc."
        val EVENTS = hashMapOf(
                "Warning" to "Warning",
                "Error" to "Error",
                "ApiCallExecuted" to "ApiCallExecuted",
                "JoinChannelSuccess" to "JoinChannelSuccess",
                "RejoinChannelSuccess" to "RejoinChannelSuccess",
                "LeaveChannel" to "LeaveChannel",
                "LocalUserRegistered" to "LocalUserRegistered",
                "UserInfoUpdated" to "UserInfoUpdated",
                "ClientRoleChanged" to "ClientRoleChanged",
                "UserJoined" to "UserJoined",
                "UserOffline" to "UserOffline",
                "ConnectionStateChanged" to "ConnectionStateChanged",
                "NetworkTypeChanged" to "NetworkTypeChanged",
                "ConnectionLost" to "ConnectionLost",
                "TokenPrivilegeWillExpire" to "TokenPrivilegeWillExpire",
                "RequestToken" to "RequestToken",
                "AudioVolumeIndication" to "AudioVolumeIndication",
                "ActiveSpeaker" to "ActiveSpeaker",
                "FirstLocalAudioFrame" to "FirstLocalAudioFrame",
                "FirstLocalVideoFrame" to "FirstLocalVideoFrame",
                "UserMuteVideo" to "UserMuteVideo",
                "VideoSizeChanged" to "VideoSizeChanged",
                "RemoteVideoStateChanged" to "RemoteVideoStateChanged",
                "LocalVideoStateChanged" to "LocalVideoStateChanged",
                "RemoteAudioStateChanged" to "RemoteAudioStateChanged",
                "LocalAudioStateChanged" to "LocalAudioStateChanged",
                "LocalPublishFallbackToAudioOnly" to "LocalPublishFallbackToAudioOnly",
                "RemoteSubscribeFallbackToAudioOnly" to "RemoteSubscribeFallbackToAudioOnly",
                "AudioRouteChanged" to "AudioRouteChanged",
                "CameraFocusAreaChanged" to "CameraFocusAreaChanged",
                "CameraExposureAreaChanged" to "CameraExposureAreaChanged",
                "RtcStats" to "RtcStats",
                "LastmileQuality" to "LastmileQuality",
                "NetworkQuality" to "NetworkQuality",
                "LastmileProbeResult" to "LastmileProbeResult",
                "LocalVideoStats" to "LocalVideoStats",
                "LocalAudioStats" to "LocalAudioStats",
                "RemoteVideoStats" to "RemoteVideoStats",
                "RemoteAudioStats" to "RemoteAudioStats",
                "AudioMixingFinished" to "AudioMixingFinished",
                "AudioMixingStateChanged" to "AudioMixingStateChanged",
                "AudioEffectFinished" to "AudioEffectFinished",
                "RtmpStreamingStateChanged" to "RtmpStreamingStateChanged",
                "TranscodingUpdated" to "TranscodingUpdated",
                "StreamInjectedStatus" to "StreamInjectedStatus",
                "StreamMessage" to "StreamMessage",
                "StreamMessageError" to "StreamMessageError",
                "MediaEngineLoadSuccess" to "MediaEngineLoadSuccess",
                "MediaEngineStartCallSuccess" to "MediaEngineStartCallSuccess",
                "ChannelMediaRelayStateChanged" to "ChannelMediaRelayStateChanged",
                "ChannelMediaRelayEvent" to "ChannelMediaRelayEvent",
                "FirstRemoteVideoFrame" to "FirstRemoteVideoFrame",
                "FirstRemoteAudioFrame" to "FirstRemoteAudioFrame",
                "FirstRemoteAudioDecoded" to "FirstRemoteAudioDecoded",
                "UserMuteAudio" to "UserMuteAudio",
                "StreamPublished" to "StreamPublished",
                "StreamUnpublished" to "StreamUnpublished",
                "RemoteAudioTransportStats" to "RemoteAudioTransportStats",
                "RemoteVideoTransportStats" to "RemoteVideoTransportStats",
                "UserEnableVideo" to "UserEnableVideo",
                "UserEnableLocalVideo" to "UserEnableLocalVideo",
                "FirstRemoteVideoDecoded" to "FirstRemoteVideoDecoded",
                "MicrophoneEnabled" to "MicrophoneEnabled",
                "ConnectionInterrupted" to "ConnectionInterrupted",
                "ConnectionBanned" to "ConnectionBanned",
                "AudioQuality" to "AudioQuality",
                "CameraReady" to "CameraReady",
                "VideoStopped" to "VideoStopped",
                "MetadataReceived" to "MetadataReceived"
        )
    }

    private fun callback(methodName: String, vararg data: Any?) {
        emitter(methodName, hashMapOf("data" to data.toList()))
    }

    override fun onWarning(@Annotations.AgoraWarningCode warn: Int) {
        super.onWarning(warn)
        callback("Warning", warn)
    }

    override fun onError(@Annotations.AgoraErrorCode err: Int) {
        super.onError(err)
        callback("Error", err)
    }

    override fun onApiCallExecuted(@Annotations.AgoraErrorCode error: Int, api: String?, result: String?) {
        super.onApiCallExecuted(error, api, result)
        callback("ApiCallExecuted", error, api, result)
    }

    override fun onJoinChannelSuccess(channel: String?, uid: Int, elapsed: Int) {
        super.onJoinChannelSuccess(channel, uid, elapsed)
        callback("JoinChannelSuccess", channel, uid, elapsed)
    }

    override fun onRejoinChannelSuccess(channel: String?, uid: Int, elapsed: Int) {
        super.onRejoinChannelSuccess(channel, uid, elapsed)
        callback("RejoinChannelSuccess", uid, elapsed)
    }

    override fun onLeaveChannel(stats: RtcStats?) {
        super.onLeaveChannel(stats)
        callback("LeaveChannel", stats?.toMap())
    }

    override fun onLocalUserRegistered(uid: Int, userAccount: String?) {
        super.onLocalUserRegistered(uid, userAccount)
        callback("LocalUserRegistered", uid, userAccount)
    }

    override fun onUserInfoUpdated(uid: Int, userInfo: UserInfo?) {
        super.onUserInfoUpdated(uid, userInfo)
        callback("UserInfoUpdated", uid, userInfo?.toMap())
    }

    override fun onClientRoleChanged(@Annotations.AgoraClientRole oldRole: Int, @Annotations.AgoraClientRole newRole: Int) {
        super.onClientRoleChanged(oldRole, newRole)
        callback("ClientRoleChanged", oldRole, newRole)
    }

    override fun onUserJoined(uid: Int, elapsed: Int) {
        super.onUserJoined(uid, elapsed)
        callback("UserJoined", uid, elapsed)
    }

    override fun onUserOffline(uid: Int, @Annotations.AgoraUserOfflineReason reason: Int) {
        super.onUserOffline(uid, reason)
        callback("UserOffline", uid, reason)
    }

    override fun onConnectionStateChanged(@Annotations.AgoraConnectionStateType state: Int, @Annotations.AgoraConnectionChangedReason reason: Int) {
        super.onConnectionStateChanged(state, reason)
        callback("ConnectionStateChanged", state, reason)
    }

    override fun onNetworkTypeChanged(@Annotations.AgoraNetworkType type: Int) {
        super.onNetworkTypeChanged(type)
        callback("NetworkTypeChanged", type)
    }

    override fun onConnectionLost() {
        super.onConnectionLost()
        callback("ConnectionLost")
    }

    override fun onTokenPrivilegeWillExpire(token: String?) {
        super.onTokenPrivilegeWillExpire(token)
        callback("TokenPrivilegeWillExpire", token)
    }

    override fun onRequestToken() {
        super.onRequestToken()
        callback("RequestToken")
    }

    override fun onAudioVolumeIndication(speakers: Array<out AudioVolumeInfo>?, @IntRange(from = 0, to = 255) totalVolume: Int) {
        super.onAudioVolumeIndication(speakers, totalVolume)
        callback("AudioVolumeIndication", speakers?.toMapList(), totalVolume)
    }

    override fun onActiveSpeaker(uid: Int) {
        super.onActiveSpeaker(uid)
        callback("ActiveSpeaker", uid)
    }

    override fun onFirstLocalAudioFrame(elapsed: Int) {
        super.onFirstLocalAudioFrame(elapsed)
        callback("FirstLocalAudioFrame", elapsed)
    }

    override fun onFirstLocalVideoFrame(width: Int, height: Int, elapsed: Int) {
        super.onFirstLocalVideoFrame(width, height, elapsed)
        callback("FirstLocalVideoFrame", width, height, elapsed)
    }

    @Deprecated("", ReplaceWith("onRemoteVideoStateChanged"))
    override fun onUserMuteVideo(uid: Int, muted: Boolean) {
        super.onUserMuteVideo(uid, muted)
        callback("UserMuteVideo", uid, muted)
    }

    override fun onVideoSizeChanged(uid: Int, width: Int, height: Int, @IntRange(from = 0, to = 360) rotation: Int) {
        super.onVideoSizeChanged(uid, width, height, rotation)
        callback("VideoSizeChanged", uid, width, height, rotation)
    }

    override fun onRemoteVideoStateChanged(uid: Int, @Annotations.AgoraVideoRemoteState state: Int, @Annotations.AgoraVideoRemoteStateReason reason: Int, elapsed: Int) {
        super.onRemoteVideoStateChanged(uid, state, reason, elapsed)
        callback("RemoteVideoStateChanged", uid, state, reason, elapsed)
    }

    override fun onLocalVideoStateChanged(@Annotations.AgoraLocalVideoStreamState localVideoState: Int, @Annotations.AgoraLocalVideoStreamError error: Int) {
        super.onLocalVideoStateChanged(localVideoState, error)
        callback("LocalVideoStateChanged", localVideoState, error)
    }

    override fun onRemoteAudioStateChanged(uid: Int, @Annotations.AgoraAudioRemoteState state: Int, @Annotations.AgoraAudioRemoteStateReason reason: Int, elapsed: Int) {
        super.onRemoteAudioStateChanged(uid, state, reason, elapsed)
        callback("RemoteAudioStateChanged", uid, state, reason, elapsed)
    }

    override fun onLocalAudioStateChanged(@Annotations.AgoraAudioLocalState state: Int, @Annotations.AgoraAudioLocalError error: Int) {
        super.onLocalAudioStateChanged(state, error)
        callback("LocalAudioStateChanged", state, error)
    }

    override fun onLocalPublishFallbackToAudioOnly(isFallbackOrRecover: Boolean) {
        super.onLocalPublishFallbackToAudioOnly(isFallbackOrRecover)
        callback("LocalPublishFallbackToAudioOnly", isFallbackOrRecover)
    }

    override fun onRemoteSubscribeFallbackToAudioOnly(uid: Int, isFallbackOrRecover: Boolean) {
        super.onRemoteSubscribeFallbackToAudioOnly(uid, isFallbackOrRecover)
        callback("RemoteSubscribeFallbackToAudioOnly", uid, isFallbackOrRecover)
    }

    override fun onAudioRouteChanged(@Annotations.AgoraAudioOutputRouting routing: Int) {
        super.onAudioRouteChanged(routing)
        callback("AudioRouteChanged", routing)
    }

    override fun onCameraFocusAreaChanged(rect: Rect?) {
        super.onCameraFocusAreaChanged(rect)
        callback("CameraFocusAreaChanged", rect?.toMap())
    }

    override fun onCameraExposureAreaChanged(rect: Rect?) {
        super.onCameraExposureAreaChanged(rect)
        callback("CameraExposureAreaChanged", rect?.toMap())
    }

    override fun onRtcStats(stats: RtcStats?) {
        super.onRtcStats(stats)
        callback("RtcStats", stats?.toMap())
    }

    override fun onLastmileQuality(@Annotations.AgoraNetworkQuality quality: Int) {
        super.onLastmileQuality(quality)
        callback("LastmileQuality", quality)
    }

    override fun onNetworkQuality(uid: Int, @Annotations.AgoraNetworkQuality txQuality: Int, @Annotations.AgoraNetworkQuality rxQuality: Int) {
        super.onNetworkQuality(uid, txQuality, rxQuality)
        callback("NetworkQuality", uid, txQuality, rxQuality)
    }

    override fun onLastmileProbeResult(result: LastmileProbeResult?) {
        super.onLastmileProbeResult(result)
        callback("LastmileProbeResult", result?.toMap())
    }

    @Deprecated("", ReplaceWith("onLocalVideoStats"))
    override fun onLocalVideoStat(sentBitrate: Int, sentFrameRate: Int) {
        super.onLocalVideoStat(sentBitrate, sentFrameRate)
        // TODO Not in iOS
    }

    override fun onLocalVideoStats(stats: LocalVideoStats?) {
        super.onLocalVideoStats(stats)
        callback("LocalVideoStats", stats?.toMap())
    }

    override fun onLocalAudioStats(stats: LocalAudioStats?) {
        super.onLocalAudioStats(stats)
        callback("LocalAudioStats", stats?.toMap())
    }

    @Deprecated("", ReplaceWith("onRemoteVideoStats"))
    override fun onRemoteVideoStat(uid: Int, delay: Int, receivedBitrate: Int, receivedFrameRate: Int) {
        super.onRemoteVideoStat(uid, delay, receivedBitrate, receivedFrameRate)
        // TODO Not in iOS
    }

    override fun onRemoteVideoStats(stats: RemoteVideoStats?) {
        super.onRemoteVideoStats(stats)
        callback("RemoteVideoStats", stats?.toMap())
    }

    override fun onRemoteAudioStats(stats: RemoteAudioStats?) {
        super.onRemoteAudioStats(stats)
        callback("RemoteAudioStats", stats?.toMap())
    }

    @Deprecated("", ReplaceWith("onAudioMixingStateChanged"))
    override fun onAudioMixingFinished() {
        super.onAudioMixingFinished()
        callback("AudioMixingFinished")
    }

    override fun onAudioMixingStateChanged(@Annotations.AgoraAudioMixingStateCode state: Int, @Annotations.AgoraAudioMixingErrorCode errorCode: Int) {
        super.onAudioMixingStateChanged(state, errorCode)
        callback("AudioMixingStateChanged", state, errorCode)
    }

    override fun onAudioEffectFinished(soundId: Int) {
        super.onAudioEffectFinished(soundId)
        callback("AudioEffectFinished", soundId)
    }

    override fun onRtmpStreamingStateChanged(url: String?, @Annotations.AgoraRtmpStreamingState state: Int, @Annotations.AgoraRtmpStreamingErrorCode errCode: Int) {
        super.onRtmpStreamingStateChanged(url, state, errCode)
        callback("RtmpStreamingStateChanged", url, state, errCode)
    }

    override fun onTranscodingUpdated() {
        super.onTranscodingUpdated()
        callback("TranscodingUpdated")
    }

    override fun onStreamInjectedStatus(url: String?, uid: Int, @Annotations.AgoraInjectStreamStatus status: Int) {
        super.onStreamInjectedStatus(url, uid, status)
        callback("StreamInjectedStatus", url, uid, status)
    }

    override fun onStreamMessage(uid: Int, streamId: Int, data: ByteArray?) {
        super.onStreamMessage(uid, streamId, data)
        callback("StreamMessage", uid, streamId, data?.let { String(it, Charsets.UTF_8) })
    }

    override fun onStreamMessageError(uid: Int, streamId: Int, @Annotations.AgoraErrorCode error: Int, missed: Int, cached: Int) {
        super.onStreamMessageError(uid, streamId, error, missed, cached)
        callback("StreamMessageError", uid, streamId, error, missed, cached)
    }

    override fun onMediaEngineLoadSuccess() {
        super.onMediaEngineLoadSuccess()
        callback("MediaEngineLoadSuccess")
    }

    override fun onMediaEngineStartCallSuccess() {
        super.onMediaEngineStartCallSuccess()
        callback("MediaEngineStartCallSuccess")
    }

    override fun onChannelMediaRelayStateChanged(@Annotations.AgoraChannelMediaRelayState state: Int, @Annotations.AgoraChannelMediaRelayError code: Int) {
        super.onChannelMediaRelayStateChanged(state, code)
        callback("ChannelMediaRelayStateChanged", state, code)
    }

    override fun onChannelMediaRelayEvent(@Annotations.AgoraChannelMediaRelayEvent code: Int) {
        super.onChannelMediaRelayEvent(code)
        callback("ChannelMediaRelayEvent", code)
    }

    @Deprecated("", ReplaceWith("onRemoteVideoStateChanged"))
    override fun onFirstRemoteVideoFrame(uid: Int, width: Int, height: Int, elapsed: Int) {
        super.onFirstRemoteVideoFrame(uid, width, height, elapsed)
        callback("FirstRemoteVideoFrame", uid, width, height, elapsed)
    }

    @Deprecated("", ReplaceWith("onRemoteAudioStateChanged"))
    override fun onFirstRemoteAudioFrame(uid: Int, elapsed: Int) {
        super.onFirstRemoteAudioFrame(uid, elapsed)
        callback("FirstRemoteAudioFrame", uid, elapsed)
    }

    @Deprecated("", ReplaceWith("onRemoteAudioStateChanged"))
    override fun onFirstRemoteAudioDecoded(uid: Int, elapsed: Int) {
        super.onFirstRemoteAudioDecoded(uid, elapsed)
        callback("FirstRemoteAudioDecoded", uid, elapsed)
    }

    @Deprecated("", ReplaceWith("onRemoteAudioStateChanged"))
    override fun onUserMuteAudio(uid: Int, muted: Boolean) {
        super.onUserMuteAudio(uid, muted)
        callback("UserMuteAudio", uid, muted)
    }

    @Deprecated("", ReplaceWith("onRtmpStreamingStateChanged"))
    override fun onStreamPublished(url: String?, @Annotations.AgoraErrorCode error: Int) {
        super.onStreamPublished(url, error)
        callback("StreamPublished", url, error)
    }

    @Deprecated("", ReplaceWith("onRtmpStreamingStateChanged"))
    override fun onStreamUnpublished(url: String?) {
        super.onStreamUnpublished(url)
        callback("StreamUnpublished", url)
    }

    @Deprecated("", ReplaceWith("onRemoteAudioStats"))
    override fun onRemoteAudioTransportStats(uid: Int, delay: Int, lost: Int, rxKBitRate: Int) {
        super.onRemoteAudioTransportStats(uid, delay, lost, rxKBitRate)
        callback("RemoteAudioTransportStats", uid, delay, lost, rxKBitRate)
    }

    @Deprecated("", ReplaceWith("onRemoteVideoStats"))
    override fun onRemoteVideoTransportStats(uid: Int, delay: Int, lost: Int, rxKBitRate: Int) {
        super.onRemoteVideoTransportStats(uid, delay, lost, rxKBitRate)
        callback("RemoteVideoTransportStats", uid, delay, lost, rxKBitRate)
    }

    @Deprecated("", ReplaceWith("onRemoteVideoStateChanged"))
    override fun onUserEnableVideo(uid: Int, enabled: Boolean) {
        super.onUserEnableVideo(uid, enabled)
        callback("UserEnableVideo", uid, enabled)
    }

    @Deprecated("", ReplaceWith("onRemoteVideoStateChanged"))
    override fun onUserEnableLocalVideo(uid: Int, enabled: Boolean) {
        super.onUserEnableLocalVideo(uid, enabled)
        callback("UserEnableLocalVideo", uid, enabled)
    }

    @Deprecated("", ReplaceWith("onRemoteVideoStateChanged"))
    override fun onFirstRemoteVideoDecoded(uid: Int, width: Int, height: Int, elapsed: Int) {
        super.onFirstRemoteVideoDecoded(uid, width, height, elapsed)
        callback("FirstRemoteVideoDecoded", uid, width, height, elapsed)
    }

    @Deprecated("", ReplaceWith("onLocalAudioStateChanged"))
    override fun onMicrophoneEnabled(enabled: Boolean) {
        super.onMicrophoneEnabled(enabled)
        callback("MicrophoneEnabled", enabled)
    }

    @Deprecated("", ReplaceWith("onConnectionStateChanged"))
    override fun onConnectionInterrupted() {
        super.onConnectionInterrupted()
        callback("ConnectionInterrupted")
    }

    @Deprecated("", ReplaceWith("onConnectionStateChanged"))
    override fun onConnectionBanned() {
        super.onConnectionBanned()
        callback("ConnectionBanned")
    }

    @Deprecated("", ReplaceWith("onRemoteAudioStats"))
    override fun onAudioQuality(uid: Int, @Annotations.AgoraNetworkQuality quality: Int, delay: Short, lost: Short) {
        super.onAudioQuality(uid, quality, delay, lost)
        callback("AudioQuality", uid, quality, delay, lost)
    }

    @Deprecated("", ReplaceWith("onLocalVideoStateChanged"))
    override fun onCameraReady() {
        super.onCameraReady()
        callback("CameraReady")
    }

    @Deprecated("", ReplaceWith("onLocalVideoStateChanged"))
    override fun onVideoStopped() {
        super.onVideoStopped()
        callback("VideoStopped")
    }
}
