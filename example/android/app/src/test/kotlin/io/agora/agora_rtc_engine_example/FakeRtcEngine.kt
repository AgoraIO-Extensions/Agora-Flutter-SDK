package io.agora.agora_rtc_engine_example

import io.agora.rtc.*
import io.agora.rtc.audio.AgoraRhythmPlayerConfig
import io.agora.rtc.audio.AudioRecordingConfiguration
import io.agora.rtc.internal.EncryptionConfig
import io.agora.rtc.internal.LastmileProbeConfig
import io.agora.rtc.live.LiveInjectStreamConfig
import io.agora.rtc.live.LiveTranscoding
import io.agora.rtc.mediaio.IVideoSink
import io.agora.rtc.mediaio.IVideoSource
import io.agora.rtc.models.*
import io.agora.rtc.video.*
import java.util.*
import javax.microedition.khronos.egl.EGLContext

class FakeRtcEngine : RtcEngineEx(), IAudioEffectManager {
  override fun setChannelProfile(profile: Int): Int {
    return 0
  }

  override fun setClientRole(role: Int): Int {
    return 0
  }

  override fun setClientRole(role: Int, options: ClientRoleOptions?): Int {
    return 0
  }

  override fun sendCustomReportMessage(id: String?, category: String?, event: String?, label: String?, value: Int): Int {
    return 0
  }

  override fun joinChannel(token: String?, channelName: String?, optionalInfo: String?, optionalUid: Int): Int {
    return 0
  }

  override fun joinChannel(token: String?, channelName: String?, optionalInfo: String?, optionalUid: Int, options: ChannelMediaOptions?): Int {
    return 0
  }

  override fun switchChannel(token: String?, channelName: String?): Int {
    return 0
  }

  override fun switchChannel(token: String?, channelName: String?, options: ChannelMediaOptions?): Int {
    return 0
  }

  override fun leaveChannel(): Int {
    return 0
  }

  override fun renewToken(token: String?): Int {
    return 0
  }

  override fun registerLocalUserAccount(appId: String?, userAccount: String?): Int {
    return 0
  }

  override fun joinChannelWithUserAccount(token: String?, channelName: String?, userAccount: String?): Int {
    return 0
  }

  override fun joinChannelWithUserAccount(token: String?, channelName: String?, userAccount: String?, options: ChannelMediaOptions?): Int {
    return 0
  }

  override fun setCloudProxy(proxyType: Int): Int {
    return 0
  }

  override fun getUserInfoByUserAccount(userAccount: String?, userInfo: UserInfo?): Int {
    return 0
  }

  override fun getUserInfoByUid(uid: Int, userInfo: UserInfo?): Int {
    return 0
  }

  override fun enableWebSdkInteroperability(enabled: Boolean): Int {
    return 0
  }

  override fun getConnectionState(): Int {
    return 0
  }

  override fun enableRemoteSuperResolution(uid: Int, enable: Boolean): Int {
    return 0
  }

  override fun enableAudio(): Int {
    return 0
  }

  override fun disableAudio(): Int {
    return 0
  }

  override fun pauseAudio(): Int {
    return 0
  }

  override fun resumeAudio(): Int {
    return 0
  }

  override fun setAudioProfile(profile: Int, scenario: Int): Int {
    return 0
  }

  override fun setHighQualityAudioParameters(fullband: Boolean, stereo: Boolean, fullBitrate: Boolean): Int {
    return 0
  }

  override fun adjustRecordingSignalVolume(volume: Int): Int {
    return 0
  }

  override fun adjustPlaybackSignalVolume(volume: Int): Int {
    return 0
  }

  override fun enableAudioVolumeIndication(interval: Int, smooth: Int, report_vad: Boolean): Int {
    return 0
  }

  override fun enableAudioQualityIndication(enabled: Boolean): Int {
    return 0
  }

  override fun enableLocalAudio(enabled: Boolean): Int {
    return 0
  }

  override fun muteLocalAudioStream(muted: Boolean): Int {
    return 0
  }

  override fun muteRemoteAudioStream(uid: Int, muted: Boolean): Int {
    return 0
  }

  override fun adjustUserPlaybackSignalVolume(uid: Int, volume: Int): Int {
    return 0
  }

  override fun muteAllRemoteAudioStreams(muted: Boolean): Int {
    return 0
  }

  override fun setDefaultMuteAllRemoteAudioStreams(muted: Boolean): Int {
    return 0
  }

  override fun enableVideo(): Int {
    return 0
  }

  override fun disableVideo(): Int {
    return 0
  }

  override fun setVideoProfile(profile: Int, swapWidthAndHeight: Boolean): Int {
    return 0
  }

  override fun setVideoProfile(width: Int, height: Int, frameRate: Int, bitrate: Int): Int {
    return 0
  }

  override fun setVideoEncoderConfiguration(config: VideoEncoderConfiguration?): Int {
    return 0
  }

  override fun setCameraCapturerConfiguration(config: CameraCapturerConfiguration?): Int {
    return 0
  }

  override fun setupLocalVideo(local: VideoCanvas?): Int {
    return 0
  }

  override fun setupRemoteVideo(remote: VideoCanvas?): Int {
    return 0
  }

  override fun setLocalRenderMode(renderMode: Int): Int {
    return 0
  }

  override fun setLocalRenderMode(renderMode: Int, mirrorMode: Int): Int {
    return 0
  }

  override fun setRemoteRenderMode(uid: Int, renderMode: Int): Int {
    return 0
  }

  override fun setRemoteRenderMode(uid: Int, renderMode: Int, mirrorMode: Int): Int {
    return 0
  }

  override fun startPreview(): Int {
    return 0
  }

  override fun stopPreview(): Int {
    return 0
  }

  override fun enableLocalVideo(enabled: Boolean): Int {
    return 0
  }

  override fun muteLocalVideoStream(muted: Boolean): Int {
    return 0
  }

  override fun muteRemoteVideoStream(uid: Int, muted: Boolean): Int {
    return 0
  }

  override fun muteAllRemoteVideoStreams(muted: Boolean): Int {
    return 0
  }

  override fun setDefaultMuteAllRemoteVideoStreams(muted: Boolean): Int {
    return 0
  }

  override fun setBeautyEffectOptions(enabled: Boolean, options: BeautyOptions?): Int {
    return 0
  }

  override fun enableVirtualBackground(enabled: Boolean, backgroundSource: VirtualBackgroundSource?): Int {
    return 0
  }

  override fun setDefaultAudioRoutetoSpeakerphone(defaultToSpeaker: Boolean): Int {
    return 0
  }

  override fun setEnableSpeakerphone(enabled: Boolean): Int {
    return 0
  }

  override fun isSpeakerphoneEnabled(): Boolean {
    return true
  }

  override fun enableInEarMonitoring(enabled: Boolean): Int {
    return 0
  }

  override fun setInEarMonitoringVolume(volume: Int): Int {
    return 0
  }

  override fun useExternalAudioDevice(): Int {
    return 0
  }

  override fun setLocalVoicePitch(pitch: Double): Int {
    return 0
  }

  override fun setLocalVoiceEqualization(bandFrequency: Int, bandGain: Int): Int {
    return 0
  }

  override fun setLocalVoiceReverb(reverbKey: Int, value: Int): Int {
    return 0
  }

  override fun setLocalVoiceChanger(voiceChanger: Int): Int {
    return 0
  }

  override fun setLocalVoiceReverbPreset(preset: Int): Int {
    return 0
  }

  override fun setAudioEffectPreset(preset: Int): Int {
    return 0
  }

  override fun setVoiceBeautifierPreset(preset: Int): Int {
    return 0
  }

  override fun setVoiceConversionPreset(preset: Int): Int {
    return 0
  }

  override fun setAudioEffectParameters(preset: Int, param1: Int, param2: Int): Int {
    return 0
  }

  override fun setVoiceBeautifierParameters(preset: Int, param1: Int, param2: Int): Int {
    return 0
  }

  override fun enableDeepLearningDenoise(enabled: Boolean): Int {
    return 0
  }

  override fun enableSoundPositionIndication(enabled: Boolean): Int {
    return 0
  }

  override fun setRemoteVoicePosition(uid: Int, pan: Double, gain: Double): Int {
    return 0
  }

  override fun startAudioMixing(filePath: String?, loopback: Boolean, replace: Boolean, cycle: Int): Int {
    return 0
  }

  override fun startAudioMixing(filePath: String?, loopback: Boolean, replace: Boolean, cycle: Int, startPos: Int): Int {
    return 0
  }

  override fun selectAudioTrack(audioIndex: Int): Int {
    return 0
  }

  override fun getAudioTrackCount(): Int {
    return 0
  }

  override fun setAudioMixingDualMonoMode(mode: Int): Int {
    return 0
  }

  override fun setAudioMixingPlaybackSpeed(speed: Int): Int {
    return 0
  }

  override fun stopAudioMixing(): Int {
    return 0
  }

  override fun pauseAudioMixing(): Int {
    return 0
  }

  override fun resumeAudioMixing(): Int {
    return 0
  }

  override fun adjustAudioMixingVolume(volume: Int): Int {
    return 0
  }

  override fun adjustAudioMixingPlayoutVolume(volume: Int): Int {
    return 0
  }

  override fun adjustAudioMixingPublishVolume(volume: Int): Int {
    return 0
  }

  override fun getAudioMixingPlayoutVolume(): Int {
    return 0
  }

  override fun getAudioMixingPublishVolume(): Int {
    return 0
  }

  override fun getAudioMixingDuration(): Int {
    return 0
  }

  override fun getAudioMixingCurrentPosition(): Int {
    return 0
  }

  override fun setAudioMixingPosition(pos: Int): Int {
    return 0
  }

  override fun setAudioMixingPitch(pitch: Int): Int {
    return 0
  }

  override fun getAudioEffectManager(): IAudioEffectManager {
    return this
  }

  override fun getAudioFileInfo(filePath: String?): Int {
    return 0
  }

  override fun startAudioRecording(filePath: String?, quality: Int): Int {
    return 0
  }

  override fun startAudioRecording(filePath: String?, sampleRate: Int, quality: Int): Int {
    return 0
  }

  override fun startAudioRecording(config: AudioRecordingConfiguration?): Int {
    return 0
  }

  override fun stopAudioRecording(): Int {
    return 0
  }

  override fun startEchoTest(): Int {
    return 0
  }

  override fun startEchoTest(intervalInSeconds: Int): Int {
    return 0
  }

  override fun startEchoTest(config: EchoTestConfiguration?): Int {
    return 0
  }

  override fun stopEchoTest(): Int {
    return 0
  }

  override fun enableLastmileTest(): Int {
    return 0
  }

  override fun disableLastmileTest(): Int {
    return 0
  }

  override fun startLastmileProbeTest(config: LastmileProbeConfig?): Int {
    return 0
  }

  override fun stopLastmileProbeTest(): Int {
    return 0
  }

  override fun setVideoSource(source: IVideoSource?): Int {
    return 0
  }

  override fun setLocalVideoRenderer(render: IVideoSink?): Int {
    return 0
  }

  override fun setRemoteVideoRenderer(uid: Int, render: IVideoSink?): Int {
    return 0
  }

  override fun setExternalAudioSink(enabled: Boolean, sampleRate: Int, channels: Int): Int {
    return 0
  }

  override fun pullPlaybackAudioFrame(data: ByteArray?, lengthInByte: Int): Int {
    return 0
  }

  override fun setExternalAudioSource(enabled: Boolean, sampleRate: Int, channels: Int): Int {
    return 0
  }

  override fun pushExternalAudioFrame(data: ByteArray?, timestamp: Long): Int {
    return 0
  }

  override fun pushExternalAudioFrame(data: ByteArray?, timestamp: Long, sampleRate: Int, channels: Int, bytesPerSample: Int, sourcePos: Int): Int {
    return 0
  }

  override fun setExternalAudioSourceVolume(sourcePos: Int, volume: Int): Int {
    return 0
  }

  override fun setExternalVideoSource(enable: Boolean, useTexture: Boolean, pushMode: Boolean) {
  }

  override fun pushExternalVideoFrame(frame: AgoraVideoFrame?): Boolean {
    return false
  }

  override fun isTextureEncodeSupported(): Boolean {
    return true
  }

  override fun registerAudioFrameObserver(observer: IAudioFrameObserver?): Int {
    return 0
  }

  override fun registerVideoEncodedFrameObserver(observer: IVideoEncodedFrameObserver?): Int {
    return 0
  }

  override fun registerVideoFrameObserver(observer: IVideoFrameObserver?): Int {
    return 0
  }

  override fun setRecordingAudioFrameParameters(sampleRate: Int, channel: Int, mode: Int, samplesPerCall: Int): Int {
    return 0
  }

  override fun setPlaybackAudioFrameParameters(sampleRate: Int, channel: Int, mode: Int, samplesPerCall: Int): Int {
    return 0
  }

  override fun setMixedAudioFrameParameters(sampleRate: Int, samplesPerCall: Int): Int {
    return 0
  }

  override fun addVideoWatermark(watermark: AgoraImage?): Int {
    return 0
  }

  override fun addVideoWatermark(watermarkUrl: String?, options: WatermarkOptions?): Int {
    return 0
  }

  override fun clearVideoWatermarks(): Int {
    return 0
  }

  override fun setRemoteUserPriority(uid: Int, userPriority: Int): Int {
    return 0
  }

  override fun setLocalPublishFallbackOption(option: Int): Int {
    return 0
  }

  override fun setRemoteSubscribeFallbackOption(option: Int): Int {
    return 0
  }

  override fun enableDualStreamMode(enabled: Boolean): Int {
    return 0
  }

  override fun setRemoteVideoStreamType(uid: Int, streamType: Int): Int {
    return 0
  }

  override fun setRemoteDefaultVideoStreamType(streamType: Int): Int {
    return 0
  }

  override fun setEncryptionSecret(secret: String?): Int {
    return 0
  }

  override fun setEncryptionMode(encryptionMode: String?): Int {
    return 0
  }

  override fun enableEncryption(enabled: Boolean, config: EncryptionConfig?): Int {
    return 0
  }

  override fun addInjectStreamUrl(url: String?, config: LiveInjectStreamConfig?): Int {
    return 0
  }

  override fun removeInjectStreamUrl(url: String?): Int {
    return 0
  }

  override fun addPublishStreamUrl(url: String?, transcodingEnabled: Boolean): Int {
    return 0
  }

  override fun removePublishStreamUrl(url: String?): Int {
    return 0
  }

  override fun setLiveTranscoding(transcoding: LiveTranscoding?): Int {
    return 0
  }

  override fun createDataStream(reliable: Boolean, ordered: Boolean): Int {
    return 0
  }

  override fun createDataStream(config: DataStreamConfig?): Int {
    return 0
  }

  override fun sendStreamMessage(streamId: Int, message: ByteArray?): Int {
    return 0
  }

  override fun setVideoQualityParameters(preferFrameRateOverImageQuality: Boolean): Int {
    return 0
  }

  override fun setLocalVideoMirrorMode(mode: Int): Int {
    return 0
  }

  override fun switchCamera(): Int {
    return 0
  }

  override fun isCameraZoomSupported(): Boolean {
    return true
  }

  override fun isCameraTorchSupported(): Boolean {
    return true
  }

  override fun isCameraFocusSupported(): Boolean {
    return true
  }

  override fun isCameraExposurePositionSupported(): Boolean {
    return true
  }

  override fun isCameraAutoFocusFaceModeSupported(): Boolean {
    return true
  }

  override fun setCameraZoomFactor(factor: Float): Int {
    return 0
  }

  override fun getCameraMaxZoomFactor(): Float {
    return 1.0f
  }

  override fun setCameraFocusPositionInPreview(positionX: Float, positionY: Float): Int {
    return 0
  }

  override fun setCameraExposurePosition(positionXinView: Float, positionYinView: Float): Int {
    return 0
  }

  override fun enableFaceDetection(enable: Boolean): Int {
    return 0
  }

  override fun setCameraTorchOn(isOn: Boolean): Int {
    return 0
  }

  override fun setCameraAutoFocusFaceModeEnabled(enabled: Boolean): Int {
    return 0
  }

  override fun getCallId(): String {
    return ""
  }

  override fun rate(callId: String?, rating: Int, description: String?): Int {
    return 0
  }

  override fun complain(callId: String?, description: String?): Int {
    return 0
  }

  override fun setLogFile(filePath: String?): Int {
    return 0
  }

  override fun setLogFilter(filter: Int): Int {
    return 0
  }

  override fun setLogFileSize(fileSizeInKBytes: Int): Int {
    return 0
  }

  override fun uploadLogFile(): String {
    return ""
  }

  override fun getNativeHandle(): Long {
    return 0
  }

  override fun enableHighPerfWifiMode(enable: Boolean): Boolean {
    return true
  }

  override fun monitorHeadsetEvent(monitor: Boolean) {
  }

  override fun monitorBluetoothHeadsetEvent(monitor: Boolean) {
  }

  override fun setPreferHeadset(enabled: Boolean) {
  }

  override fun setParameters(parameters: String?): Int {
    return 0
  }

  override fun getParameter(parameter: String?, args: String?): String {
    return ""
  }

  override fun registerMediaMetadataObserver(observer: IMetadataObserver?, type: Int): Int {
    return 0
  }

  override fun setLogWriter(logWriter: ILogWriter?): Int {
    return 0
  }

  override fun releaseLogWriter(): Int {
    return 0
  }

  override fun startChannelMediaRelay(channelMediaRelayConfiguration: ChannelMediaRelayConfiguration?): Int {
    return 0
  }

  override fun stopChannelMediaRelay(): Int {
    return 0
  }

  override fun updateChannelMediaRelay(channelMediaRelayConfiguration: ChannelMediaRelayConfiguration?): Int {
    return 0
  }

  override fun pauseAllChannelMediaRelay(): Int {
    return 0
  }

  override fun resumeAllChannelMediaRelay(): Int {
    return 0
  }

  override fun startDumpVideoReceiveTrack(uid: Int, dumpFile: String?): Int {
    return 0
  }

  override fun stopDumpVideoReceiveTrack(): Int {
    return 0
  }

  override fun createRtcChannel(channelId: String?): RtcChannel {
    return FakeRtcChannel()
  }

  override fun setLocalAccessPoint(ips: ArrayList<String>?, domain: String?): Int {
    return 0
  }

  override fun takeSnapshot(channel: String?, uid: Int, filePath: String?): Int {
    return 0
  }

  override fun enableContentInspect(enabled: Boolean, config: ContentInspectConfig?): Int {
    return 0
  }

  override fun setProfile(profile: String?, merge: Boolean): Int {
    return 0
  }

  override fun setAppType(appType: Int): Int {
    return 0
  }

  override fun enableTransportQualityIndication(enabled: Boolean): Int {
    return 0
  }

  override fun playRecap(): Int {
    return 0
  }

  override fun enableRecap(interval: Int): Int {
    return 0
  }

  override fun getParameters(parameters: String?): String {
    return ""
  }

  override fun makeQualityReportUrl(channel: String?, listenerUid: Int, speakerUid: Int, format: Int): String {
    return ""
  }

  override fun updateSharedContext(sharedContext: EGLContext?): Int {
    return 0
  }

  override fun updateSharedContext(sharedContext: android.opengl.EGLContext?): Int {
    return 0
  }

  override fun setTextureId(id: Int, eglContext: EGLContext?, width: Int, height: Int, ts: Long): Int {
    return 0
  }

  override fun setTextureId(id: Int, eglContext: android.opengl.EGLContext?, width: Int, height: Int, ts: Long): Int {
    return 0
  }

  override fun monitorAudioRouteChange(isMonitoring: Boolean): Int {
    return 0
  }

  override fun setApiCallMode(syncCallTimeout: Int): Int {
    return 0
  }

  override fun getEffectsVolume(): Double {
    return 1.0
  }

  override fun setEffectsVolume(volume: Double): Int {
    return 0
  }

  override fun setVolumeOfEffect(soundId: Int, volume: Double): Int {
    return 0
  }

  override fun playEffect(soundId: Int, filePath: String?, loop: Int, pitch: Double, pan: Double, gain: Double): Int {
    return 0
  }

  override fun playEffect(soundId: Int, filePath: String?, loopCount: Int, pitch: Double, pan: Double, gain: Double, publish: Boolean): Int {
    return 0
  }

  override fun playEffect(soundId: Int, filePath: String?, loopCount: Int, pitch: Double, pan: Double, gain: Double, publish: Boolean, startPos: Int): Int {
    return 0
  }

  override fun stopEffect(soundId: Int): Int {
    return 0
  }

  override fun stopAllEffects(): Int {
    return 0
  }

  override fun preloadEffect(soundId: Int, filePath: String?): Int {
    return 0
  }

  override fun unloadEffect(soundId: Int): Int {
    return 0
  }

  override fun pauseEffect(soundId: Int): Int {
    return 0
  }

  override fun pauseAllEffects(): Int {
    return 0
  }

  override fun resumeEffect(soundId: Int): Int {
    return 0
  }

  override fun resumeAllEffects(): Int {
    return 0
  }

  override fun getEffectCurrentPosition(soundId: Int): Int {
    return 0
  }

  override fun setEffectPosition(soundId: Int, pos: Int): Int {
    return 0
  }

  override fun getEffectDuration(filePath: String?): Int {
    return 0
  }

  override fun startRhythmPlayer(sound1: String?, sound2: String?, config: AgoraRhythmPlayerConfig?): Int {
    return 0
  }

  override fun stopRhythmPlayer(): Int {
    return 0
  }

  override fun configRhythmPlayer(config: AgoraRhythmPlayerConfig?): Int {
    return 0
  }
}

class FakeRtcChannel : RtcChannel() {
  override fun destroy(): Int {
    return 0
  }

  override fun channelId(): String {
    return ""
  }

  override fun getCallId(): String {
    return ""
  }

  override fun getConnectionState(): Int {
    return 0
  }

  override fun enableRemoteSuperResolution(uid: Int, enable: Boolean): Int {
    return 0
  }

  override fun joinChannel(token: String?, optionalInfo: String?, optionalUid: Int, options: ChannelMediaOptions?): Int {
    return 0
  }

  override fun joinChannelWithUserAccount(token: String?, userAccount: String?, options: ChannelMediaOptions?): Int {
    return 0
  }

  override fun leaveChannel(): Int {
    return 0
  }

  override fun muteLocalAudioStream(muted: Boolean): Int {
    return 0
  }

  override fun muteLocalVideoStream(muted: Boolean): Int {
    return 0
  }

  override fun publish(): Int {
    return 0
  }

  override fun unpublish(): Int {
    return 0
  }

  override fun renewToken(token: String?): Int {
    return 0
  }

  override fun setEncryptionSecret(secret: String?): Int {
    return 0
  }

  override fun setEncryptionMode(encryptionMode: String?): Int {
    return 0
  }

  override fun enableEncryption(enabled: Boolean, config: EncryptionConfig?): Int {
    return 0
  }

  override fun registerMediaMetadataObserver(observer: IMetadataObserver?, type: Int): Int {
    return 0
  }

  override fun setClientRole(role: Int): Int {
    return 0
  }

  override fun setClientRole(role: Int, options: ClientRoleOptions?): Int {
    return 0
  }

  override fun setRemoteUserPriority(uid: Int, userPriority: Int): Int {
    return 0
  }

  override fun setRemoteVoicePosition(uid: Int, pan: Double, gain: Double): Int {
    return 0
  }

  override fun setRemoteRenderMode(uid: Int, renderMode: Int, mirrorMode: Int): Int {
    return 0
  }

  override fun setDefaultMuteAllRemoteAudioStreams(muted: Boolean): Int {
    return 0
  }

  override fun setDefaultMuteAllRemoteVideoStreams(muted: Boolean): Int {
    return 0
  }

  override fun muteAllRemoteAudioStreams(muted: Boolean): Int {
    return 0
  }

  override fun adjustUserPlaybackSignalVolume(uid: Int, volume: Int): Int {
    return 0
  }

  override fun muteRemoteAudioStream(uid: Int, muted: Boolean): Int {
    return 0
  }

  override fun muteAllRemoteVideoStreams(muted: Boolean): Int {
    return 0
  }

  override fun muteRemoteVideoStream(uid: Int, muted: Boolean): Int {
    return 0
  }

  override fun setRemoteVideoStreamType(uid: Int, streamType: Int): Int {
    return 0
  }

  override fun setRemoteDefaultVideoStreamType(streamType: Int): Int {
    return 0
  }

  override fun createDataStream(reliable: Boolean, ordered: Boolean): Int {
    return 0
  }

  override fun createDataStream(config: DataStreamConfig?): Int {
    return 0
  }

  override fun sendStreamMessage(streamId: Int, message: ByteArray?): Int {
    return 0
  }

  override fun addPublishStreamUrl(url: String?, transcodingEnabled: Boolean): Int {
    return 0
  }

  override fun removePublishStreamUrl(url: String?): Int {
    return 0
  }

  override fun setLiveTranscoding(transcoding: LiveTranscoding?): Int {
    return 0
  }

  override fun addInjectStreamUrl(url: String?, config: LiveInjectStreamConfig?): Int {
    return 0
  }

  override fun removeInjectStreamUrl(url: String?): Int {
    return 0
  }

  override fun startChannelMediaRelay(channelMediaRelayConfiguration: ChannelMediaRelayConfiguration?): Int {
    return 0
  }

  override fun stopChannelMediaRelay(): Int {
    return 0
  }

  override fun updateChannelMediaRelay(channelMediaRelayConfiguration: ChannelMediaRelayConfiguration?): Int {
    return 0
  }

  override fun pauseAllChannelMediaRelay(): Int {
    return 0
  }

  override fun resumeAllChannelMediaRelay(): Int {
    return 0
  }

  override fun setRemoteVideoRenderer(uid: Int, render: IVideoSink?): Int {
    return 0
  }
}
