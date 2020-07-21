package io.agora.agora_rtc_engine

import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformViewRegistry
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

/** AgoraRtcEnginePlugin */
class AgoraRtcEnginePlugin : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler,
        RtcEngineInterface<Map<*, *>, Result> {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var applicationContext: Context
    private var eventSink: EventChannel.EventSink? = null
    private val manager = RtcEngineManager()
    private val handler = Handler(Looper.getMainLooper())
    private val rtcChannelPlugin = AgoraRtcChannelPlugin(this)

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            AgoraRtcEnginePlugin().apply {
                initPlugin(registrar.context(), registrar.messenger(), registrar.platformViewRegistry())
                rtcChannelPlugin.initPlugin(registrar.messenger())
            }
        }
    }

    private fun initPlugin(context: Context, binaryMessenger: BinaryMessenger, platformViewRegistry: PlatformViewRegistry) {
        applicationContext = context.applicationContext
        methodChannel = MethodChannel(binaryMessenger, "agora_rtc_engine")
        methodChannel.setMethodCallHandler(this)
        eventChannel = EventChannel(binaryMessenger, "agora_rtc_engine/events")
        eventChannel.setStreamHandler(this)

        platformViewRegistry.registerViewFactory("AgoraSurfaceView", AgoraSurfaceViewFactory(binaryMessenger, this, rtcChannelPlugin))
        platformViewRegistry.registerViewFactory("AgoraTextureView", AgoraTextureViewFactory(binaryMessenger, this, rtcChannelPlugin))
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        rtcChannelPlugin.onAttachedToEngine(binding)
        initPlugin(binding.applicationContext, binding.binaryMessenger, binding.platformViewRegistry)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        rtcChannelPlugin.onDetachedFromEngine(binding)
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

    fun engine(): RtcEngine? {
        return manager.engine()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        this::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                val parameters = mutableListOf<Any?>()
                function.parameters.forEach { parameter ->
                    call.arguments<Map<*, *>>()?.let {
                        if (it.containsKey(parameter.name)) {
                            parameters.add(it[parameter.name])
                        }
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

    override fun create(appId: String, areaCode: Int, callback: Result?) {
        manager.create(applicationContext, appId, areaCode, Annotations.AgoraRtcAppType.FLUTTER) { methodName, data ->
            emit(methodName, data)
        }
        ResultCallback(callback).resolve(engine()) {}
    }

    override fun destroy(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { manager.destroy() }
    }

    override fun setChannelProfile(profile: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setChannelProfile(profile))
    }

    override fun setClientRole(role: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setClientRole(role))
    }

    override fun joinChannel(token: String?, channelName: String, optionalInfo: String?, optionalUid: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.joinChannel(token, channelName, optionalInfo, optionalUid))
    }

    override fun switchChannel(token: String?, channelName: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.switchChannel(token, channelName))
    }

    override fun leaveChannel(callback: Result?) {
        ResultCallback(callback).code(engine()?.leaveChannel())
    }

    override fun renewToken(token: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.renewToken(token))
    }

    override fun getConnectionState(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.connectionState }
    }

    override fun getCallId(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.callId }
    }

    override fun rate(callId: String, rating: Int, description: String?, callback: Result?) {
        ResultCallback(callback).code(engine()?.rate(callId, rating, description))
    }

    override fun complain(callId: String, description: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.complain(callId, description))
    }

    override fun setLogFile(filePath: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLogFile(filePath))
    }

    override fun setLogFilter(filter: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLogFilter(filter))
    }

    override fun setLogFileSize(fileSizeInKBytes: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLogFileSize(fileSizeInKBytes))
    }

    override fun setParameters(parameters: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.setParameters(parameters))
    }

    override fun enableWebSdkInteroperability(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableWebSdkInteroperability(enabled))
    }

    override fun registerLocalUserAccount(appId: String, userAccount: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.registerLocalUserAccount(appId, userAccount))
    }

    override fun joinChannelWithUserAccount(token: String?, channelName: String, userAccount: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.joinChannelWithUserAccount(token, channelName, userAccount))
    }

    override fun getUserInfoByUserAccount(userAccount: String, callback: Result?) {
        ResultCallback(callback).resolve(engine()) { manager.getUserInfoByUserAccount(userAccount) }
    }

    override fun getUserInfoByUid(uid: Int, callback: Result?) {
        ResultCallback(callback).resolve(engine()) { manager.getUserInfoByUid(uid) }
    }

    override fun enableAudio(callback: Result?) {
        ResultCallback(callback).code(engine()?.enableAudio())
    }

    override fun disableAudio(callback: Result?) {
        ResultCallback(callback).code(engine()?.disableAudio())
    }

    override fun setAudioProfile(profile: Int, scenario: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setAudioProfile(profile, scenario))
    }

    override fun adjustRecordingSignalVolume(volume: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.adjustRecordingSignalVolume(volume))
    }

    override fun adjustUserPlaybackSignalVolume(uid: Int, volume: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.adjustUserPlaybackSignalVolume(uid, volume))
    }

    override fun adjustPlaybackSignalVolume(volume: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.adjustPlaybackSignalVolume(volume))
    }

    override fun enableLocalAudio(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableLocalAudio(enabled))
    }

    override fun muteLocalAudioStream(muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.muteLocalAudioStream(muted))
    }

    override fun muteRemoteAudioStream(uid: Int, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.muteRemoteAudioStream(uid, muted))
    }

    override fun muteAllRemoteAudioStreams(muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.muteAllRemoteAudioStreams(muted))
    }

    override fun setDefaultMuteAllRemoteAudioStreams(muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.setDefaultMuteAllRemoteAudioStreams(muted))
    }

    override fun enableAudioVolumeIndication(interval: Int, smooth: Int, report_vad: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableAudioVolumeIndication(interval, smooth, report_vad))
    }

    override fun enableVideo(callback: Result?) {
        ResultCallback(callback).code(engine()?.enableVideo())
    }

    override fun disableVideo(callback: Result?) {
        ResultCallback(callback).code(engine()?.disableVideo())
    }

    override fun setVideoEncoderConfiguration(config: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.setVideoEncoderConfiguration(mapToVideoEncoderConfiguration(config)))
    }

    override fun startPreview(callback: Result?) {
        ResultCallback(callback).code(engine()?.startPreview())
    }

    override fun stopPreview(callback: Result?) {
        ResultCallback(callback).code(engine()?.stopPreview())
    }

    override fun enableLocalVideo(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableLocalVideo(enabled))
    }

    override fun muteLocalVideoStream(muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.muteLocalVideoStream(muted))
    }

    override fun muteRemoteVideoStream(uid: Int, muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.muteRemoteVideoStream(uid, muted))
    }

    override fun muteAllRemoteVideoStreams(muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.muteAllRemoteVideoStreams(muted))
    }

    override fun setDefaultMuteAllRemoteVideoStreams(muted: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.setDefaultMuteAllRemoteVideoStreams(muted))
    }

    override fun setBeautyEffectOptions(enabled: Boolean, options: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.setBeautyEffectOptions(enabled, mapToBeautyOptions(options)))
    }

    override fun startAudioMixing(filePath: String, loopback: Boolean, replace: Boolean, cycle: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.startAudioMixing(filePath, loopback, replace, cycle))
    }

    override fun stopAudioMixing(callback: Result?) {
        ResultCallback(callback).code(engine()?.stopAudioMixing())
    }

    override fun pauseAudioMixing(callback: Result?) {
        ResultCallback(callback).code(engine()?.pauseAudioMixing())
    }

    override fun resumeAudioMixing(callback: Result?) {
        ResultCallback(callback).code(engine()?.resumeAudioMixing())
    }

    override fun adjustAudioMixingVolume(volume: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.adjustAudioMixingVolume(volume))
    }

    override fun adjustAudioMixingPlayoutVolume(volume: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.adjustAudioMixingPlayoutVolume(volume))
    }

    override fun adjustAudioMixingPublishVolume(volume: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.adjustAudioMixingPublishVolume(volume))
    }

    override fun getAudioMixingPlayoutVolume(callback: Result?) {
        ResultCallback(callback).code(engine()?.audioMixingPlayoutVolume) { it }
    }

    override fun getAudioMixingPublishVolume(callback: Result?) {
        ResultCallback(callback).code(engine()?.audioMixingPublishVolume) { it }
    }

    override fun getAudioMixingDuration(callback: Result?) {
        ResultCallback(callback).code(engine()?.audioMixingDuration) { it }
    }

    override fun getAudioMixingCurrentPosition(callback: Result?) {
        ResultCallback(callback).code(engine()?.audioMixingCurrentPosition) { it }
    }

    override fun setAudioMixingPosition(pos: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setAudioMixingPosition(pos))
    }

    override fun setAudioMixingPitch(pitch: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setAudioMixingPitch(pitch))
    }

    override fun getEffectsVolume(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.audioEffectManager.effectsVolume }
    }

    override fun setEffectsVolume(volume: Double, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.setEffectsVolume(volume))
    }

    override fun setVolumeOfEffect(soundId: Int, volume: Double, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.setVolumeOfEffect(soundId, volume))
    }

    override fun playEffect(soundId: Int, filePath: String, loopCount: Int, pitch: Double, pan: Double, gain: Double, publish: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.playEffect(soundId, filePath, loopCount, pitch, pan, gain, publish))
    }

    override fun stopEffect(soundId: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.stopEffect(soundId))
    }

    override fun stopAllEffects(callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.stopAllEffects())
    }

    override fun preloadEffect(soundId: Int, filePath: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.preloadEffect(soundId, filePath))
    }

    override fun unloadEffect(soundId: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.unloadEffect(soundId))
    }

    override fun pauseEffect(soundId: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.pauseEffect(soundId))
    }

    override fun pauseAllEffects(callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.pauseAllEffects())
    }

    override fun resumeEffect(soundId: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.resumeEffect(soundId))
    }

    override fun resumeAllEffects(callback: Result?) {
        ResultCallback(callback).code(engine()?.audioEffectManager?.resumeAllEffects())
    }

    override fun setLocalVoiceChanger(voiceChanger: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLocalVoiceChanger(voiceChanger))
    }

    override fun setLocalVoiceReverbPreset(preset: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLocalVoiceReverbPreset(preset))
    }

    override fun setLocalVoicePitch(pitch: Double, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLocalVoicePitch(pitch))
    }

    override fun setLocalVoiceEqualization(bandFrequency: Int, bandGain: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLocalVoiceEqualization(bandFrequency, bandGain))
    }

    override fun setLocalVoiceReverb(reverbKey: Int, value: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLocalVoiceReverb(reverbKey, value))
    }

    override fun enableSoundPositionIndication(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableSoundPositionIndication(enabled))
    }

    override fun setRemoteVoicePosition(uid: Int, pan: Double, gain: Double, callback: Result?) {
        ResultCallback(callback).code(engine()?.setRemoteVoicePosition(uid, pan, gain))
    }

    override fun setLiveTranscoding(transcoding: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLiveTranscoding(mapToLiveTranscoding(transcoding)))
    }

    override fun addPublishStreamUrl(url: String, transcodingEnabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.addPublishStreamUrl(url, transcodingEnabled))
    }

    override fun removePublishStreamUrl(url: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.removePublishStreamUrl(url))
    }

    override fun startChannelMediaRelay(channelMediaRelayConfiguration: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.startChannelMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration)))
    }

    override fun updateChannelMediaRelay(channelMediaRelayConfiguration: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.updateChannelMediaRelay(mapToChannelMediaRelayConfiguration(channelMediaRelayConfiguration)))
    }

    override fun stopChannelMediaRelay(callback: Result?) {
        ResultCallback(callback).code(engine()?.stopChannelMediaRelay())
    }

    override fun setDefaultAudioRoutetoSpeakerphone(defaultToSpeaker: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.setDefaultAudioRoutetoSpeakerphone(defaultToSpeaker))
    }

    override fun setEnableSpeakerphone(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.setEnableSpeakerphone(enabled))
    }

    override fun isSpeakerphoneEnabled(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.isSpeakerphoneEnabled }
    }

    override fun enableInEarMonitoring(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableInEarMonitoring(enabled))
    }

    override fun setInEarMonitoringVolume(volume: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setInEarMonitoringVolume(volume))
    }

    override fun enableDualStreamMode(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableDualStreamMode(enabled))
    }

    override fun setRemoteVideoStreamType(uid: Int, streamType: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setRemoteVideoStreamType(uid, streamType))
    }

    override fun setRemoteDefaultVideoStreamType(streamType: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setRemoteDefaultVideoStreamType(streamType))
    }

    override fun setLocalPublishFallbackOption(option: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setLocalPublishFallbackOption(option))
    }

    override fun setRemoteSubscribeFallbackOption(option: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setRemoteSubscribeFallbackOption(option))
    }

    override fun setRemoteUserPriority(uid: Int, userPriority: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.setRemoteUserPriority(uid, userPriority))
    }

    override fun startEchoTest(intervalInSeconds: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.startEchoTest(intervalInSeconds))
    }

    override fun stopEchoTest(callback: Result?) {
        ResultCallback(callback).code(engine()?.stopEchoTest())
    }

    override fun enableLastmileTest(callback: Result?) {
        ResultCallback(callback).code(engine()?.enableLastmileTest())
    }

    override fun disableLastmileTest(callback: Result?) {
        ResultCallback(callback).code(engine()?.disableLastmileTest())
    }

    override fun startLastmileProbeTest(config: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.startLastmileProbeTest(mapToLastmileProbeConfig(config)))
    }

    override fun stopLastmileProbeTest(callback: Result?) {
        ResultCallback(callback).code(engine()?.stopLastmileProbeTest())
    }

    override fun registerMediaMetadataObserver(callback: Result?) {
        ResultCallback(callback).code(manager.registerMediaMetadataObserver { methodName, data -> emit(methodName, data) })
    }

    override fun unregisterMediaMetadataObserver(callback: Result?) {
        ResultCallback(callback).code(manager.unregisterMediaMetadataObserver())
    }

    override fun setMaxMetadataSize(size: Int, callback: Result?) {
        ResultCallback(callback).code(manager.setMaxMetadataSize(size))
    }

    override fun sendMetadata(metadata: String, callback: Result?) {
        ResultCallback(callback).code(manager.addMetadata(metadata))
    }

    override fun addVideoWatermark(watermarkUrl: String, options: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.addVideoWatermark(watermarkUrl, mapToWatermarkOptions(options)))
    }

    override fun clearVideoWatermarks(callback: Result?) {
        ResultCallback(callback).code(engine()?.clearVideoWatermarks())
    }

    override fun setEncryptionSecret(secret: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.setEncryptionSecret(secret))
    }

    override fun setEncryptionMode(encryptionMode: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.setEncryptionMode(encryptionMode))
    }

    override fun startAudioRecording(filePath: String, sampleRate: Int, quality: Int, callback: Result?) {
        ResultCallback(callback).code(engine()?.startAudioRecording(filePath, sampleRate, quality))
    }

    override fun stopAudioRecording(callback: Result?) {
        ResultCallback(callback).code(engine()?.stopAudioRecording())
    }

    override fun addInjectStreamUrl(url: String, config: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.addInjectStreamUrl(url, mapToLiveInjectStreamConfig(config)))
    }

    override fun removeInjectStreamUrl(url: String, callback: Result?) {
        ResultCallback(callback).code(engine()?.removeInjectStreamUrl(url))
    }

    override fun switchCamera(callback: Result?) {
        ResultCallback(callback).code(engine()?.switchCamera())
    }

    override fun isCameraZoomSupported(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.isCameraZoomSupported }
    }

    override fun isCameraTorchSupported(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.isCameraTorchSupported }
    }

    override fun isCameraFocusSupported(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.isCameraFocusSupported }
    }

    override fun isCameraExposurePositionSupported(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.isCameraExposurePositionSupported }
    }

    override fun isCameraAutoFocusFaceModeSupported(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.isCameraAutoFocusFaceModeSupported }
    }

    override fun setCameraZoomFactor(factor: Float, callback: Result?) {
        ResultCallback(callback).code(engine()?.setCameraZoomFactor(factor))
    }

    override fun getCameraMaxZoomFactor(callback: Result?) {
        ResultCallback(callback).resolve(engine()) { it.cameraMaxZoomFactor }
    }

    override fun setCameraFocusPositionInPreview(positionX: Float, positionY: Float, callback: Result?) {
        ResultCallback(callback).code(engine()?.setCameraFocusPositionInPreview(positionX, positionY))
    }

    override fun setCameraExposurePosition(positionXinView: Float, positionYinView: Float, callback: Result?) {
        ResultCallback(callback).code(engine()?.setCameraExposurePosition(positionXinView, positionYinView))
    }

    override fun enableFaceDetection(enable: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.enableFaceDetection(enable))
    }

    override fun setCameraTorchOn(isOn: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.setCameraTorchOn(isOn))
    }

    override fun setCameraAutoFocusFaceModeEnabled(enabled: Boolean, callback: Result?) {
        ResultCallback(callback).code(engine()?.setCameraAutoFocusFaceModeEnabled(enabled))
    }

    override fun setCameraCapturerConfiguration(config: Map<*, *>, callback: Result?) {
        ResultCallback(callback).code(engine()?.setCameraCapturerConfiguration(mapToCameraCapturerConfiguration(config)))
    }

    override fun createDataStream(reliable: Boolean, ordered: Boolean, callback: Result?) {
        ResultCallback(callback).code(manager.createDataStream(reliable, ordered)) { it }
    }

    override fun sendStreamMessage(streamId: Int, message: String, callback: Result?) {
        ResultCallback(callback).code(manager.sendStreamMessage(streamId, message))
    }
}
