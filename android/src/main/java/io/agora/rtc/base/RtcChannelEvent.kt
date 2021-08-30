package io.agora.rtc.base

import androidx.annotation.IntRange
import io.agora.rtc.IRtcChannelEventHandler
import io.agora.rtc.IRtcEngineEventHandler
import io.agora.rtc.RtcChannel

class RtcChannelEvents {
  companion object {
    const val Warning = "Warning"
    const val Error = "Error"
    const val JoinChannelSuccess = "JoinChannelSuccess"
    const val RejoinChannelSuccess = "RejoinChannelSuccess"
    const val LeaveChannel = "LeaveChannel"
    const val ClientRoleChanged = "ClientRoleChanged"
    const val UserJoined = "UserJoined"
    const val UserOffline = "UserOffline"
    const val ConnectionStateChanged = "ConnectionStateChanged"
    const val ConnectionLost = "ConnectionLost"
    const val TokenPrivilegeWillExpire = "TokenPrivilegeWillExpire"
    const val RequestToken = "RequestToken"
    const val ActiveSpeaker = "ActiveSpeaker"
    const val VideoSizeChanged = "VideoSizeChanged"
    const val RemoteVideoStateChanged = "RemoteVideoStateChanged"
    const val RemoteAudioStateChanged = "RemoteAudioStateChanged"
    const val LocalPublishFallbackToAudioOnly = "LocalPublishFallbackToAudioOnly"
    const val RemoteSubscribeFallbackToAudioOnly = "RemoteSubscribeFallbackToAudioOnly"
    const val RtcStats = "RtcStats"
    const val NetworkQuality = "NetworkQuality"
    const val RemoteVideoStats = "RemoteVideoStats"
    const val RemoteAudioStats = "RemoteAudioStats"
    const val RtmpStreamingStateChanged = "RtmpStreamingStateChanged"
    const val TranscodingUpdated = "TranscodingUpdated"
    const val StreamInjectedStatus = "StreamInjectedStatus"
    const val StreamMessage = "StreamMessage"
    const val StreamMessageError = "StreamMessageError"
    const val ChannelMediaRelayStateChanged = "ChannelMediaRelayStateChanged"
    const val ChannelMediaRelayEvent = "ChannelMediaRelayEvent"
    const val MetadataReceived = "MetadataReceived"
    const val AudioPublishStateChanged = "AudioPublishStateChanged"
    const val VideoPublishStateChanged = "VideoPublishStateChanged"
    const val AudioSubscribeStateChanged = "AudioSubscribeStateChanged"
    const val VideoSubscribeStateChanged = "VideoSubscribeStateChanged"
    const val RtmpStreamingEvent = "RtmpStreamingEvent"

    fun toMap(): Map<String, String> {
      return hashMapOf(
        "Warning" to Warning,
        "Error" to Error,
        "JoinChannelSuccess" to JoinChannelSuccess,
        "RejoinChannelSuccess" to RejoinChannelSuccess,
        "LeaveChannel" to LeaveChannel,
        "ClientRoleChanged" to ClientRoleChanged,
        "UserJoined" to UserJoined,
        "UserOffline" to UserOffline,
        "ConnectionStateChanged" to ConnectionStateChanged,
        "ConnectionLost" to ConnectionLost,
        "TokenPrivilegeWillExpire" to TokenPrivilegeWillExpire,
        "RequestToken" to RequestToken,
        "ActiveSpeaker" to ActiveSpeaker,
        "VideoSizeChanged" to VideoSizeChanged,
        "RemoteVideoStateChanged" to RemoteVideoStateChanged,
        "RemoteAudioStateChanged" to RemoteAudioStateChanged,
        "LocalPublishFallbackToAudioOnly" to LocalPublishFallbackToAudioOnly,
        "RemoteSubscribeFallbackToAudioOnly" to RemoteSubscribeFallbackToAudioOnly,
        "RtcStats" to RtcStats,
        "NetworkQuality" to NetworkQuality,
        "RemoteVideoStats" to RemoteVideoStats,
        "RemoteAudioStats" to RemoteAudioStats,
        "RtmpStreamingStateChanged" to RtmpStreamingStateChanged,
        "TranscodingUpdated" to TranscodingUpdated,
        "StreamInjectedStatus" to StreamInjectedStatus,
        "StreamMessage" to StreamMessage,
        "StreamMessageError" to StreamMessageError,
        "ChannelMediaRelayStateChanged" to ChannelMediaRelayStateChanged,
        "ChannelMediaRelayEvent" to ChannelMediaRelayEvent,
        "MetadataReceived" to MetadataReceived,
        "AudioPublishStateChanged" to AudioPublishStateChanged,
        "VideoPublishStateChanged" to VideoPublishStateChanged,
        "AudioSubscribeStateChanged" to AudioSubscribeStateChanged,
        "VideoSubscribeStateChanged" to VideoSubscribeStateChanged,
        "RtmpStreamingEvent" to RtmpStreamingEvent
      )
    }
  }
}

class RtcChannelEventHandler(
  private val emitter: (methodName: String, data: Map<String, Any?>?) -> Unit
) : IRtcChannelEventHandler() {
  companion object {
    const val PREFIX = "io.agora.rtc."
  }

  private fun callback(methodName: String, channel: RtcChannel?, vararg data: Any?) {
    channel?.let {
      emitter(methodName, hashMapOf(
        "channelId" to it.channelId(),
        "data" to data.toList()
      ))
    }
  }

  override fun onChannelWarning(rtcChannel: RtcChannel?, @Annotations.AgoraWarningCode warn: Int) {
    callback(RtcChannelEvents.Warning, rtcChannel, warn)
  }

  override fun onChannelError(rtcChannel: RtcChannel?, @Annotations.AgoraErrorCode err: Int) {
    callback(RtcChannelEvents.Error, rtcChannel, err)
  }

  override fun onJoinChannelSuccess(rtcChannel: RtcChannel?, uid: Int, elapsed: Int) {
    callback(RtcChannelEvents.JoinChannelSuccess, rtcChannel, rtcChannel?.channelId(), uid, elapsed)
  }

  override fun onRejoinChannelSuccess(rtcChannel: RtcChannel?, uid: Int, elapsed: Int) {
    callback(RtcChannelEvents.RejoinChannelSuccess, rtcChannel, rtcChannel?.channelId(), uid, elapsed)
  }

  override fun onLeaveChannel(rtcChannel: RtcChannel?, stats: IRtcEngineEventHandler.RtcStats?) {
    callback(RtcChannelEvents.LeaveChannel, rtcChannel, stats?.toMap())
  }

  override fun onClientRoleChanged(rtcChannel: RtcChannel?, @Annotations.AgoraClientRole oldRole: Int, @Annotations.AgoraClientRole newRole: Int) {
    callback(RtcChannelEvents.ClientRoleChanged, rtcChannel, oldRole, newRole)
  }

  override fun onUserJoined(rtcChannel: RtcChannel?, uid: Int, elapsed: Int) {
    callback(RtcChannelEvents.UserJoined, rtcChannel, uid, elapsed)
  }

  override fun onUserOffline(rtcChannel: RtcChannel?, uid: Int, @Annotations.AgoraUserOfflineReason reason: Int) {
    callback(RtcChannelEvents.UserOffline, rtcChannel, uid, reason)
  }

  override fun onConnectionStateChanged(rtcChannel: RtcChannel?, @Annotations.AgoraConnectionStateType state: Int, @Annotations.AgoraConnectionChangedReason reason: Int) {
    callback(RtcChannelEvents.ConnectionStateChanged, rtcChannel, state, reason)
  }

  override fun onConnectionLost(rtcChannel: RtcChannel?) {
    callback(RtcChannelEvents.ConnectionLost, rtcChannel)
  }

  override fun onTokenPrivilegeWillExpire(rtcChannel: RtcChannel?, token: String?) {
    callback(RtcChannelEvents.TokenPrivilegeWillExpire, rtcChannel, token)
  }

  override fun onRequestToken(rtcChannel: RtcChannel?) {
    callback(RtcChannelEvents.RequestToken, rtcChannel)
  }

  override fun onActiveSpeaker(rtcChannel: RtcChannel?, uid: Int) {
    callback(RtcChannelEvents.ActiveSpeaker, rtcChannel, uid)
  }

  override fun onVideoSizeChanged(rtcChannel: RtcChannel?, uid: Int, width: Int, height: Int, @IntRange(from = 0, to = 360) rotation: Int) {
    callback(RtcChannelEvents.VideoSizeChanged, rtcChannel, uid, width, height, rotation)
  }

  override fun onRemoteVideoStateChanged(rtcChannel: RtcChannel?, uid: Int, @Annotations.AgoraVideoRemoteState state: Int, @Annotations.AgoraVideoRemoteStateReason reason: Int, elapsed: Int) {
    callback(RtcChannelEvents.RemoteVideoStateChanged, rtcChannel, uid, state, reason, elapsed)
  }

  override fun onRemoteAudioStateChanged(rtcChannel: RtcChannel?, uid: Int, @Annotations.AgoraAudioRemoteState state: Int, @Annotations.AgoraAudioRemoteStateReason reason: Int, elapsed: Int) {
    callback(RtcChannelEvents.RemoteAudioStateChanged, rtcChannel, uid, state, reason, elapsed)
  }

  override fun onLocalPublishFallbackToAudioOnly(rtcChannel: RtcChannel?, isFallbackOrRecover: Boolean) {
    callback(RtcChannelEvents.LocalPublishFallbackToAudioOnly, rtcChannel, isFallbackOrRecover)
  }

  override fun onRemoteSubscribeFallbackToAudioOnly(rtcChannel: RtcChannel?, uid: Int, isFallbackOrRecover: Boolean) {
    callback(RtcChannelEvents.RemoteSubscribeFallbackToAudioOnly, rtcChannel, uid, isFallbackOrRecover)
  }

  override fun onRtcStats(rtcChannel: RtcChannel?, stats: IRtcEngineEventHandler.RtcStats?) {
    callback(RtcChannelEvents.RtcStats, rtcChannel, stats?.toMap())
  }

  override fun onNetworkQuality(rtcChannel: RtcChannel?, uid: Int, @Annotations.AgoraNetworkQuality txQuality: Int, @Annotations.AgoraNetworkQuality rxQuality: Int) {
    callback(RtcChannelEvents.NetworkQuality, rtcChannel, uid, txQuality, rxQuality)
  }

  override fun onRemoteVideoStats(rtcChannel: RtcChannel?, stats: IRtcEngineEventHandler.RemoteVideoStats?) {
    callback(RtcChannelEvents.RemoteVideoStats, rtcChannel, stats?.toMap())
  }

  override fun onRemoteAudioStats(rtcChannel: RtcChannel?, stats: IRtcEngineEventHandler.RemoteAudioStats?) {
    callback(RtcChannelEvents.RemoteAudioStats, rtcChannel, stats?.toMap())
  }

  override fun onRtmpStreamingStateChanged(rtcChannel: RtcChannel?, url: String?, @Annotations.AgoraRtmpStreamingState state: Int, @Annotations.AgoraRtmpStreamingErrorCode errCode: Int) {
    callback(RtcChannelEvents.RtmpStreamingStateChanged, rtcChannel, url, state, errCode)
  }

  override fun onTranscodingUpdated(rtcChannel: RtcChannel?) {
    callback(RtcChannelEvents.TranscodingUpdated, rtcChannel)
  }

  override fun onStreamInjectedStatus(rtcChannel: RtcChannel?, url: String?, uid: Int, @Annotations.AgoraInjectStreamStatus status: Int) {
    callback(RtcChannelEvents.StreamInjectedStatus, rtcChannel, url, uid, status)
  }

  override fun onStreamMessage(rtcChannel: RtcChannel?, uid: Int, streamId: Int, data: ByteArray?) {
    callback(RtcChannelEvents.StreamMessage, rtcChannel, uid, streamId, data?.let { String(it, Charsets.UTF_8) })
  }

  override fun onStreamMessageError(rtcChannel: RtcChannel?, uid: Int, streamId: Int, @Annotations.AgoraErrorCode error: Int, missed: Int, cached: Int) {
    callback(RtcChannelEvents.StreamMessageError, rtcChannel, uid, streamId, error, missed, cached)
  }

  override fun onChannelMediaRelayStateChanged(rtcChannel: RtcChannel?, @Annotations.AgoraChannelMediaRelayState state: Int, @Annotations.AgoraChannelMediaRelayError code: Int) {
    callback(RtcChannelEvents.ChannelMediaRelayStateChanged, rtcChannel, state, code)
  }

  override fun onChannelMediaRelayEvent(rtcChannel: RtcChannel?, @Annotations.AgoraChannelMediaRelayEvent code: Int) {
    callback(RtcChannelEvents.ChannelMediaRelayEvent, rtcChannel, code)
  }

  override fun onAudioPublishStateChanged(rtcChannel: RtcChannel?, @Annotations.AgoraStreamPublishState oldState: Int, @Annotations.AgoraStreamPublishState newState: Int, elapseSinceLastState: Int) {
    callback(RtcChannelEvents.AudioPublishStateChanged, rtcChannel, rtcChannel?.channelId(), oldState, newState, elapseSinceLastState)
  }

  override fun onVideoPublishStateChanged(rtcChannel: RtcChannel?, @Annotations.AgoraStreamPublishState oldState: Int, @Annotations.AgoraStreamPublishState newState: Int, elapseSinceLastState: Int) {
    callback(RtcChannelEvents.VideoPublishStateChanged, rtcChannel, rtcChannel?.channelId(), oldState, newState, elapseSinceLastState)
  }

  override fun onAudioSubscribeStateChanged(rtcChannel: RtcChannel?, uid: Int, @Annotations.AgoraStreamSubscribeState oldState: Int, @Annotations.AgoraStreamSubscribeState newState: Int, elapseSinceLastState: Int) {
    callback(RtcChannelEvents.AudioSubscribeStateChanged, rtcChannel, rtcChannel?.channelId(), uid, oldState, newState, elapseSinceLastState)
  }

  override fun onVideoSubscribeStateChanged(rtcChannel: RtcChannel?, uid: Int, @Annotations.AgoraStreamSubscribeState oldState: Int, @Annotations.AgoraStreamSubscribeState newState: Int, elapseSinceLastState: Int) {
    callback(RtcChannelEvents.VideoSubscribeStateChanged, rtcChannel, rtcChannel?.channelId(), uid, oldState, newState, elapseSinceLastState)
  }

  override fun onRtmpStreamingEvent(rtcChannel: RtcChannel?, url: String?, @Annotations.AgoraRtmpStreamingEvent errCode: Int) {
    callback(RtcChannelEvents.RtmpStreamingEvent, rtcChannel, url, errCode)
  }
}
