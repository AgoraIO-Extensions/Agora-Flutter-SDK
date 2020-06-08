package io.agora.rtc.base

import androidx.annotation.IntRange
import io.agora.rtc.IRtcChannelEventHandler
import io.agora.rtc.IRtcEngineEventHandler
import io.agora.rtc.RtcChannel

class RtcChannelEventHandler(
        private val emitter: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcChannelEventHandler() {
    companion object {
        const val PREFIX = "io.agora.rtc."
        val EVENTS = hashMapOf(
                "Warning" to "Warning",
                "Error" to "Error",
                "JoinChannelSuccess" to "JoinChannelSuccess",
                "RejoinChannelSuccess" to "RejoinChannelSuccess",
                "LeaveChannel" to "LeaveChannel",
                "ClientRoleChanged" to "ClientRoleChanged",
                "UserJoined" to "UserJoined",
                "UserOffline" to "UserOffline",
                "ConnectionStateChanged" to "ConnectionStateChanged",
                "ConnectionLost" to "ConnectionLost",
                "TokenPrivilegeWillExpire" to "TokenPrivilegeWillExpire",
                "RequestToken" to "RequestToken",
                "ActiveSpeaker" to "ActiveSpeaker",
                "VideoSizeChanged" to "VideoSizeChanged",
                "RemoteVideoStateChanged" to "RemoteVideoStateChanged",
                "RemoteAudioStateChanged" to "RemoteAudioStateChanged",
                "LocalPublishFallbackToAudioOnly" to "LocalPublishFallbackToAudioOnly",
                "RemoteSubscribeFallbackToAudioOnly" to "RemoteSubscribeFallbackToAudioOnly",
                "RtcStats" to "RtcStats",
                "NetworkQuality" to "NetworkQuality",
                "RemoteVideoStats" to "RemoteVideoStats",
                "RemoteAudioStats" to "RemoteAudioStats",
                "RtmpStreamingStateChanged" to "RtmpStreamingStateChanged",
                "TranscodingUpdated" to "TranscodingUpdated",
                "StreamInjectedStatus" to "StreamInjectedStatus",
                "StreamMessage" to "StreamMessage",
                "StreamMessageError" to "StreamMessageError",
                "ChannelMediaRelayStateChanged" to "ChannelMediaRelayStateChanged",
                "ChannelMediaRelayEvent" to "ChannelMediaRelayEvent",
                "MetadataReceived" to "MetadataReceived"
        )
    }

    private fun callback(methodName: String, channel: RtcChannel, vararg data: Any?) {
        emitter(methodName, hashMapOf(
                "channelId" to channel.channelId(),
                "data" to data.toList()
        ))
    }

    override fun onChannelWarning(rtcChannel: RtcChannel, @Annotations.AgoraWarningCode warn: Int) {
        super.onChannelWarning(rtcChannel, warn)
        callback("Warning", rtcChannel, warn)
    }

    override fun onChannelError(rtcChannel: RtcChannel, @Annotations.AgoraErrorCode err: Int) {
        super.onChannelError(rtcChannel, err)
        callback("Error", rtcChannel, err)
    }

    override fun onJoinChannelSuccess(rtcChannel: RtcChannel, uid: Int, elapsed: Int) {
        super.onJoinChannelSuccess(rtcChannel, uid, elapsed)
        callback("JoinChannelSuccess", rtcChannel, uid, elapsed)
    }

    override fun onRejoinChannelSuccess(rtcChannel: RtcChannel, uid: Int, elapsed: Int) {
        super.onRejoinChannelSuccess(rtcChannel, uid, elapsed)
        callback("RejoinChannelSuccess", rtcChannel, uid, elapsed)
    }

    override fun onLeaveChannel(rtcChannel: RtcChannel, stats: IRtcEngineEventHandler.RtcStats?) {
        super.onLeaveChannel(rtcChannel, stats)
        callback("LeaveChannel", rtcChannel, stats?.toMap())
    }

    override fun onClientRoleChanged(rtcChannel: RtcChannel, @Annotations.AgoraClientRole oldRole: Int, @Annotations.AgoraClientRole newRole: Int) {
        super.onClientRoleChanged(rtcChannel, oldRole, newRole)
        callback("ClientRoleChanged", rtcChannel, oldRole, newRole)
    }

    override fun onUserJoined(rtcChannel: RtcChannel, uid: Int, elapsed: Int) {
        super.onUserJoined(rtcChannel, uid, elapsed)
        callback("UserJoined", rtcChannel, uid, elapsed)
    }

    override fun onUserOffline(rtcChannel: RtcChannel, uid: Int, @Annotations.AgoraUserOfflineReason reason: Int) {
        super.onUserOffline(rtcChannel, uid, reason)
        callback("UserOffline", rtcChannel, uid, reason)
    }

    override fun onConnectionStateChanged(rtcChannel: RtcChannel, @Annotations.AgoraConnectionStateType state: Int, @Annotations.AgoraConnectionChangedReason reason: Int) {
        super.onConnectionStateChanged(rtcChannel, state, reason)
        callback("ConnectionStateChanged", rtcChannel, state, reason)
    }

    override fun onConnectionLost(rtcChannel: RtcChannel) {
        super.onConnectionLost(rtcChannel)
        callback("ConnectionLost", rtcChannel)
    }

    override fun onTokenPrivilegeWillExpire(rtcChannel: RtcChannel, token: String?) {
        super.onTokenPrivilegeWillExpire(rtcChannel, token)
        callback("TokenPrivilegeWillExpire", rtcChannel, token)
    }

    override fun onRequestToken(rtcChannel: RtcChannel) {
        super.onRequestToken(rtcChannel)
        callback("RequestToken", rtcChannel)
    }

    override fun onActiveSpeaker(rtcChannel: RtcChannel, uid: Int) {
        super.onActiveSpeaker(rtcChannel, uid)
        callback("ActiveSpeaker", rtcChannel, uid)
    }

    override fun onVideoSizeChanged(rtcChannel: RtcChannel, uid: Int, width: Int, height: Int, @IntRange(from = 0, to = 360) rotation: Int) {
        super.onVideoSizeChanged(rtcChannel, uid, width, height, rotation)
        callback("VideoSizeChanged", rtcChannel, uid, width, height, rotation)
    }

    override fun onRemoteVideoStateChanged(rtcChannel: RtcChannel, uid: Int, @Annotations.AgoraVideoRemoteState state: Int, @Annotations.AgoraVideoRemoteStateReason reason: Int, elapsed: Int) {
        super.onRemoteVideoStateChanged(rtcChannel, uid, state, reason, elapsed)
        callback("RemoteVideoStateChanged", rtcChannel, uid, state, reason, elapsed)
    }

    override fun onRemoteAudioStateChanged(rtcChannel: RtcChannel, uid: Int, @Annotations.AgoraAudioRemoteState state: Int, @Annotations.AgoraAudioRemoteStateReason reason: Int, elapsed: Int) {
        super.onRemoteAudioStateChanged(rtcChannel, uid, state, reason, elapsed)
        callback("RemoteAudioStateChanged", rtcChannel, uid, state, reason, elapsed)
    }

    override fun onRemoteSubscribeFallbackToAudioOnly(rtcChannel: RtcChannel, uid: Int, isFallbackOrRecover: Boolean) {
        super.onRemoteSubscribeFallbackToAudioOnly(rtcChannel, uid, isFallbackOrRecover)
        callback("RemoteSubscribeFallbackToAudioOnly", rtcChannel, uid, isFallbackOrRecover)
    }

    override fun onRtcStats(rtcChannel: RtcChannel, stats: IRtcEngineEventHandler.RtcStats?) {
        super.onRtcStats(rtcChannel, stats)
        callback("RtcStats", rtcChannel, stats?.toMap())
    }

    override fun onNetworkQuality(rtcChannel: RtcChannel, uid: Int, @Annotations.AgoraNetworkQuality txQuality: Int, @Annotations.AgoraNetworkQuality rxQuality: Int) {
        super.onNetworkQuality(rtcChannel, uid, txQuality, rxQuality)
        callback("NetworkQuality", rtcChannel, uid, txQuality, rxQuality)
    }

    override fun onRemoteVideoStats(rtcChannel: RtcChannel, stats: IRtcEngineEventHandler.RemoteVideoStats?) {
        super.onRemoteVideoStats(rtcChannel, stats)
        callback("RemoteVideoStats", rtcChannel, stats?.toMap())
    }

    override fun onRemoteAudioStats(rtcChannel: RtcChannel, stats: IRtcEngineEventHandler.RemoteAudioStats?) {
        super.onRemoteAudioStats(rtcChannel, stats)
        callback("RemoteAudioStats", rtcChannel, stats?.toMap())
    }

    override fun onRtmpStreamingStateChanged(rtcChannel: RtcChannel, url: String?, @Annotations.AgoraRtmpStreamingState state: Int, @Annotations.AgoraRtmpStreamingErrorCode errCode: Int) {
        super.onRtmpStreamingStateChanged(rtcChannel, url, state, errCode)
        callback("RtmpStreamingStateChanged", rtcChannel, url, state, errCode)
    }

    override fun onTranscodingUpdated(rtcChannel: RtcChannel) {
        super.onTranscodingUpdated(rtcChannel)
        callback("TranscodingUpdated", rtcChannel)
    }

    override fun onStreamInjectedStatus(rtcChannel: RtcChannel, url: String?, uid: Int, @Annotations.AgoraInjectStreamStatus status: Int) {
        super.onStreamInjectedStatus(rtcChannel, url, uid, status)
        callback("StreamInjectedStatus", rtcChannel, url, uid, status)
    }

    override fun onStreamMessage(rtcChannel: RtcChannel, uid: Int, streamId: Int, data: ByteArray?) {
        super.onStreamMessage(rtcChannel, uid, streamId, data)
        callback("StreamMessage", rtcChannel, uid, streamId, data?.let { String(it, Charsets.UTF_8) })
    }

    override fun onStreamMessageError(rtcChannel: RtcChannel, uid: Int, streamId: Int, @Annotations.AgoraErrorCode error: Int, missed: Int, cached: Int) {
        super.onStreamMessageError(rtcChannel, uid, streamId, error, missed, cached)
        callback("StreamMessageError", rtcChannel, uid, streamId, error, missed, cached)
    }

    override fun onChannelMediaRelayStateChanged(rtcChannel: RtcChannel, @Annotations.AgoraChannelMediaRelayState state: Int, @Annotations.AgoraChannelMediaRelayError code: Int) {
        super.onChannelMediaRelayStateChanged(rtcChannel, state, code)
        callback("ChannelMediaRelayStateChanged", rtcChannel, state, code)
    }

    override fun onChannelMediaRelayEvent(rtcChannel: RtcChannel, @Annotations.AgoraChannelMediaRelayEvent code: Int) {
        super.onChannelMediaRelayEvent(rtcChannel, code)
        callback("ChannelMediaRelayEvent", rtcChannel, code)
    }
}
