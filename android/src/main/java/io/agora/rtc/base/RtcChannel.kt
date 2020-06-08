package io.agora.rtc.base

import androidx.annotation.FloatRange
import androidx.annotation.IntRange
import io.agora.rtc.Constants
import io.agora.rtc.IMetadataObserver
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import java.util.*

interface RtcChannelInterface<Map, Callback> :
        RtcChannelManager.RtcAudioInterface<Callback>,
        RtcChannelManager.RtcVideoInterface<Callback>,
        RtcChannelManager.RtcVoicePositionInterface<Callback>,
        RtcChannelManager.RtcPublishStreamInterface<Map, Callback>,
        RtcChannelManager.RtcMediaRelayInterface<Map, Callback>,
        RtcChannelManager.RtcDualStreamInterface<Callback>,
        RtcChannelManager.RtcFallbackInterface<Callback>,
        RtcChannelManager.RtcMediaMetadataInterface<Callback>,
        RtcChannelManager.RtcEncryptionInterface<Callback>,
        RtcChannelManager.RtcInjectStreamInterface<Map, Callback>,
        RtcChannelManager.RtcStreamMessageInterface<Callback> {
    fun create(channelId: String, callback: Callback?)

    fun destroy(channelId: String, callback: Callback?)

    fun setClientRole(channelId: String, @Annotations.AgoraClientRole role: Int, callback: Callback?)

    fun joinChannel(channelId: String, token: String?, optionalInfo: String?, optionalUid: Int, options: Map, callback: Callback?)

    fun joinChannelWithUserAccount(channelId: String, token: String?, userAccount: String, options: Map, callback: Callback?)

    fun leaveChannel(channelId: String, callback: Callback?)

    fun renewToken(channelId: String, token: String, callback: Callback?)

    fun getConnectionState(channelId: String, callback: Callback?)

    fun publish(channelId: String, callback: Callback?)

    fun unpublish(channelId: String, callback: Callback?)

    fun getCallId(channelId: String, callback: Callback?)
}

class RtcChannelManager {
    private val rtcChannelMap = Collections.synchronizedMap(mutableMapOf<String, RtcChannel>())
    private val mediaObserverMap = Collections.synchronizedMap(mutableMapOf<String, MediaObserver>())

    fun create(engine: RtcEngine, channelId: String, emit: (methodName: String, data: Map<String, Any?>?) -> Unit) {
        engine.createRtcChannel(channelId)?.let {
            it.setRtcChannelEventHandler(RtcChannelEventHandler { methodName, data -> emit(methodName, data) })
            rtcChannelMap[channelId] = it
        }
    }

    fun destroy(channelId: String): Int {
        this[channelId]?.let {
            val res = it.destroy()
            if (res == 0) rtcChannelMap.remove(channelId)
            return@destroy res
        }
        return Constants.ERR_NOT_INITIALIZED
    }

    fun release() {
        rtcChannelMap.forEach { it.value.destroy() }
        rtcChannelMap.clear()
        mediaObserverMap.clear()
    }

    operator fun get(channelId: String): RtcChannel? {
        return rtcChannelMap[channelId]
    }

    fun registerMediaMetadataObserver(channelId: String, emit: (methodName: String, data: Map<String, Any?>?) -> Unit): Int {
        this[channelId]?.let {
            val mediaObserver = MediaObserver { methodName, data ->
                emit(methodName, data?.toMutableMap()?.apply { put("channelId", channelId) })
            }
            val res = it.registerMediaMetadataObserver(mediaObserver, IMetadataObserver.VIDEO_METADATA)
            if (res == 0) mediaObserverMap[channelId] = mediaObserver
            return@registerMediaMetadataObserver res
        }
        return Constants.ERR_NOT_INITIALIZED
    }

    fun unregisterMediaMetadataObserver(channelId: String): Int {
        this[channelId]?.let {
            val res = it.registerMediaMetadataObserver(null, IMetadataObserver.VIDEO_METADATA)
            if (res == 0) mediaObserverMap.remove(channelId)
            return@unregisterMediaMetadataObserver res
        }
        return Constants.ERR_NOT_INITIALIZED
    }

    fun setMaxMetadataSize(channelId: String, @IntRange(from = 0, to = 1024) size: Int): Int {
        mediaObserverMap[channelId]?.let {
            it.maxMetadataSize = size
            return@setMaxMetadataSize 0
        }
        return Constants.ERR_NOT_INITIALIZED
    }

    fun addMetadata(channelId: String, metadata: String): Int {
        mediaObserverMap[channelId]?.let {
            it.addMetadata(metadata)
            return@addMetadata 0
        }
        return Constants.ERR_NOT_INITIALIZED
    }

    interface RtcAudioInterface<Callback> {
        fun adjustUserPlaybackSignalVolume(channelId: String, uid: Int, @IntRange(from = 0, to = 100) volume: Int, callback: Callback?)

        fun muteRemoteAudioStream(channelId: String, uid: Int, muted: Boolean, callback: Callback?)

        fun muteAllRemoteAudioStreams(channelId: String, muted: Boolean, callback: Callback?)

        fun setDefaultMuteAllRemoteAudioStreams(channelId: String, muted: Boolean, callback: Callback?)
    }

    interface RtcVideoInterface<Callback> {
        fun muteRemoteVideoStream(channelId: String, uid: Int, muted: Boolean, callback: Callback?)

        fun muteAllRemoteVideoStreams(channelId: String, muted: Boolean, callback: Callback?)

        fun setDefaultMuteAllRemoteVideoStreams(channelId: String, muted: Boolean, callback: Callback?)
    }

    interface RtcVoicePositionInterface<Callback> {
        fun setRemoteVoicePosition(channelId: String, uid: Int, @FloatRange(from = -1.0, to = 1.0) pan: Double, @FloatRange(from = 0.0, to = 100.0) gain: Double, callback: Callback?)
    }

    interface RtcPublishStreamInterface<Map, Callback> {
        fun setLiveTranscoding(channelId: String, transcoding: Map, callback: Callback?)

        fun addPublishStreamUrl(channelId: String, url: String, transcodingEnabled: Boolean, callback: Callback?)

        fun removePublishStreamUrl(channelId: String, url: String, callback: Callback?)
    }

    interface RtcMediaRelayInterface<Map, Callback> {
        fun startChannelMediaRelay(channelId: String, channelMediaRelayConfiguration: Map, callback: Callback?)

        fun updateChannelMediaRelay(channelId: String, channelMediaRelayConfiguration: Map, callback: Callback?)

        fun stopChannelMediaRelay(channelId: String, callback: Callback?)
    }

    interface RtcDualStreamInterface<Callback> {
        fun setRemoteVideoStreamType(channelId: String, uid: Int, @Annotations.AgoraVideoStreamType streamType: Int, callback: Callback?)

        fun setRemoteDefaultVideoStreamType(channelId: String, @Annotations.AgoraVideoStreamType streamType: Int, callback: Callback?)
    }

    interface RtcFallbackInterface<Callback> {
        fun setRemoteUserPriority(channelId: String, uid: Int, @Annotations.AgoraUserPriority userPriority: Int, callback: Callback?)
    }

    interface RtcMediaMetadataInterface<Callback> {
        fun registerMediaMetadataObserver(channelId: String, callback: Callback?)

        fun unregisterMediaMetadataObserver(channelId: String, callback: Callback?)

        fun setMaxMetadataSize(channelId: String, @IntRange(from = 0, to = 1024) size: Int, callback: Callback?)

        fun sendMetadata(channelId: String, metadata: String, callback: Callback?)
    }

    interface RtcEncryptionInterface<Callback> {
        fun setEncryptionSecret(channelId: String, secret: String, callback: Callback?)

        fun setEncryptionMode(channelId: String, @Annotations.AgoraEncryptionMode encryptionMode: String, callback: Callback?)
    }

    interface RtcInjectStreamInterface<Map, Callback> {
        fun addInjectStreamUrl(channelId: String, url: String, config: Map, callback: Callback?)

        fun removeInjectStreamUrl(channelId: String, url: String, callback: Callback?)
    }

    interface RtcStreamMessageInterface<Callback> {
        fun createDataStream(channelId: String, reliable: Boolean, ordered: Boolean, callback: Callback?)

        fun sendStreamMessage(channelId: String, streamId: Int, message: String, callback: Callback?)
    }
}
