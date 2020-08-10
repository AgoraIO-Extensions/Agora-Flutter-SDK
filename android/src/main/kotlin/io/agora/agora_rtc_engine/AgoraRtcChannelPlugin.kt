package io.agora.agora_rtc_engine

import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

/** AgoraRtcChannelPlugin */
class AgoraRtcChannelPlugin(
        private val rtcEnginePlugin: AgoraRtcEnginePlugin
) : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler,
        RtcChannelInterface<Map<*, *>, Result> {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var eventSink: EventChannel.EventSink? = null
    private val manager = RtcChannelManager()
    private val handler = Handler(Looper.getMainLooper())

    fun initPlugin(binaryMessenger: BinaryMessenger) {
        methodChannel = MethodChannel(binaryMessenger, "agora_rtc_channel")
        methodChannel.setMethodCallHandler(this)
        eventChannel = EventChannel(binaryMessenger, "agora_rtc_channel/events")
        eventChannel.setStreamHandler(this)
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        initPlugin(binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        manager.release()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    private fun emit(methodName: String, data: Map<String, Any?>?) {
        handler.post {
            val event: MutableMap<String, Any?> = mutableMapOf("methodName" to methodName)
            data?.let { event.putAll(it) }
            eventSink?.success(event)
        }
    }

    private fun engine(): RtcEngine? {
        return rtcEnginePlugin.engine()
    }

    fun channel(channelId: String): RtcChannel? {
        return manager[channelId]
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        this::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                val parameters = mutableListOf<Any?>()
                function.parameters.forEach { parameter ->
                    val map = call.arguments<Map<*, *>>()
                    if (map.containsKey(parameter.name)) {
                        parameters.add(map[parameter.name])
                    }
                }
                try {
                    method.invoke(this, *parameters.toTypedArray(), result)
                    return@onMethodCall
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        result.notImplemented()
    }

    override fun create(channelId: String, callback: Result?) {
        ResultCallback(callback).resolve(engine()) {
            manager.create(it, channelId) { methodName, data ->
                emit(methodName, data)
            }
        }
    }

    override fun destroy(channelId: String, callback: Result?) {
        ResultCallback(callback).code(manager.destroy(channelId))
    }

    override fun setClientRole(channelId: String, role: Int, callback: Result?) {
        ResultCallback(callback).code(manager[channelId]?.setClientRole(role))
    }

    override fun joinChannel(channelId: String, token: String?, optionalInfo: String?, optionalUid: Int, options: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.joinChannel(token, optionalInfo, optionalUid, mapToChannelMediaOptions(options)))
    }

    override fun joinChannelWithUserAccount(channelId: String, token: String?, userAccount: String, options: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.joinChannelWithUserAccount(token, userAccount, mapToChannelMediaOptions(options)))
    }

    override fun leaveChannel(channelId: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.leaveChannel())
    }

    override fun renewToken(channelId: String, token: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.renewToken(token))
    }

    override fun getConnectionState(channelId: String, callback: Result?) {
        ResultCallback(callback).resolve(channel(channelId)) { it.connectionState }
    }

    override fun publish(channelId: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.publish())
    }

    override fun unpublish(channelId: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.unpublish())
    }

    override fun getCallId(channelId: String, callback: Result?) {
        ResultCallback(callback).resolve(channel(channelId)) { it.callId }
    }

    override fun setLiveTranscoding(channelId: String, transcoding: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setLiveTranscoding(mapToLiveTranscoding(transcoding)))
    }

    override fun addPublishStreamUrl(channelId: String, url: String, transcodingEnabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.addPublishStreamUrl(url, transcodingEnabled))
    }

    override fun removePublishStreamUrl(channelId: String, url: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.removePublishStreamUrl(url))
    }

    override fun startChannelMediaRelay(channelId: String, channelMediaRelayConfiguration: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.startChannelMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration)))
    }

    override fun updateChannelMediaRelay(channelId: String, channelMediaRelayConfiguration: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.updateChannelMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration)))
    }

    override fun stopChannelMediaRelay(channelId: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.stopChannelMediaRelay())
    }

    override fun registerMediaMetadataObserver(channelId: String, callback: Result?) {
        ResultCallback(callback).code(manager.registerMediaMetadataObserver(channelId) { methodName, data -> emit(methodName, data) })
    }

    override fun unregisterMediaMetadataObserver(channelId: String, callback: Result?) {
        ResultCallback(callback).code(manager.unregisterMediaMetadataObserver(channelId))
    }

    override fun setMaxMetadataSize(channelId: String, size: Int, callback: Result?) {
        ResultCallback(callback).code(manager.setMaxMetadataSize(channelId, size))
    }

    override fun sendMetadata(channelId: String, metadata: String, callback: Result?) {
        ResultCallback(callback).code(manager.addMetadata(channelId, metadata))
    }

    override fun setEncryptionSecret(channelId: String, secret: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setEncryptionSecret(secret))
    }

    override fun setEncryptionMode(channelId: String, encryptionMode: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setEncryptionMode(encryptionMode))
    }

    override fun addInjectStreamUrl(channelId: String, url: String, config: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.addInjectStreamUrl(url, mapToLiveInjectStreamConfig(config)))
    }

    override fun removeInjectStreamUrl(channelId: String, url: String, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.removeInjectStreamUrl(url))
    }

    override fun createDataStream(channelId: String, reliable: Boolean, ordered: Boolean, callback: Result?) {
        ResultCallback(callback).code(manager.createDataStream(channelId, reliable, ordered)) { it }
    }

    override fun sendStreamMessage(channelId: String, streamId: Int, message: String, callback: Result?) {
        ResultCallback(callback).code(manager.sendStreamMessage(channelId, streamId, message))
    }

    override fun adjustUserPlaybackSignalVolume(channelId: String, uid: Int, volume: Int, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.adjustUserPlaybackSignalVolume(uid, volume))
    }

    override fun muteRemoteAudioStream(channelId: String, uid: Int, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.muteRemoteAudioStream(uid, muted))
    }

    override fun muteAllRemoteAudioStreams(channelId: String, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.muteAllRemoteAudioStreams(muted))
    }

    override fun setDefaultMuteAllRemoteAudioStreams(channelId: String, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setDefaultMuteAllRemoteAudioStreams(muted))
    }

    override fun muteRemoteVideoStream(channelId: String, uid: Int, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.muteRemoteVideoStream(uid, muted))
    }

    override fun muteAllRemoteVideoStreams(channelId: String, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.muteAllRemoteVideoStreams(muted))
    }

    override fun setDefaultMuteAllRemoteVideoStreams(channelId: String, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setDefaultMuteAllRemoteVideoStreams(muted))
    }

    override fun setRemoteVoicePosition(channelId: String, uid: Int, pan: Double, gain: Double, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteVoicePosition(uid, pan, gain))
    }

    override fun setRemoteVideoStreamType(channelId: String, uid: Int, streamType: Int, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteVideoStreamType(uid, streamType))
    }

    override fun setRemoteDefaultVideoStreamType(channelId: String, streamType: Int, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteDefaultVideoStreamType(streamType))
    }

    override fun setRemoteUserPriority(channelId: String, uid: Int, userPriority: Int, callback: Result?) {
        ResultCallback(callback).code(channel(channelId)?.setRemoteUserPriority(uid, userPriority))
    }
}
