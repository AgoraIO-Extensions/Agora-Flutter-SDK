import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_player.dart';
import 'package:agora_rtc_engine/src/agora_media_player_types.dart';
import 'package:agora_rtc_engine/src/agora_media_player_source.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/media_player_impl.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_engine/src/render/media_player_controller.dart';
import 'package:flutter/foundation.dart';

class MediaPlayerControllerImpl
    with VideoViewControllerBaseMixin
    implements MediaPlayerController, MediaPlayer {
  MediaPlayerControllerImpl(this._rtcEngine, this._canvas, this._connection,
      this._useFlutterTexture, this._useAndroidSurfaceView);

  MediaPlayer? _mediaPlayer;

  final RtcEngine _rtcEngine;

  final InitializationState _initState = InitializationState();
  @override
  bool get isInitialzed => _initState.isInitialzed;

  @override
  RtcEngine get rtcEngine => _rtcEngine;

  final VideoCanvas _canvas;

  @override
  VideoCanvas get canvas => _canvas;

  final RtcConnection? _connection;

  @override
  RtcConnection? get connection => _connection;

  final bool _useFlutterTexture;

  @override
  bool get useFlutterTexture => _useFlutterTexture;

  final bool _useAndroidSurfaceView;

  @override
  bool get useAndroidSurfaceView => _useAndroidSurfaceView;

  /// MediaPlayer does not support render mode and always Fit the video by default
  @override
  bool get shouldHandlerRenderMode => false;

  @override
  Future<void> adjustPlayoutVolume(int volume) {
    return _mediaPlayer!.adjustPlayoutVolume(volume);
  }

  @override
  Future<void> adjustPublishSignalVolume(int volume) {
    return _mediaPlayer!.adjustPublishSignalVolume(volume);
  }

  @override
  Future<void> enableAutoSwitchAgoraCDN(bool enable) {
    return _mediaPlayer!.enableAutoSwitchAgoraCDN(enable);
  }

  @override
  Future<int> getAgoraCDNLineCount() {
    return _mediaPlayer!.getAgoraCDNLineCount();
  }

  @override
  Future<int> getCurrentAgoraCDNIndex() {
    return _mediaPlayer!.getCurrentAgoraCDNIndex();
  }

  @override
  Future<int> getDuration() {
    return _mediaPlayer!.getDuration();
  }

  @override
  int getMediaPlayerId() {
    return _mediaPlayer!.getMediaPlayerId();
  }

  @override
  Future<bool> getMute() {
    return _mediaPlayer!.getMute();
  }

  @override
  Future<int> getPlayPosition() {
    return _mediaPlayer!.getPlayPosition();
  }

  @override
  Future<String> getPlaySrc() {
    return _mediaPlayer!.getPlaySrc();
  }

  @override
  Future<String> getPlayerSdkVersion() {
    return _mediaPlayer!.getPlayerSdkVersion();
  }

  @override
  Future<int> getPlayoutVolume() {
    return _mediaPlayer!.getPlayoutVolume();
  }

  @override
  Future<int> getPublishSignalVolume() {
    return _mediaPlayer!.getPublishSignalVolume();
  }

  @override
  Future<MediaPlayerState> getState() {
    return _mediaPlayer!.getState();
  }

  @override
  Future<int> getStreamCount() {
    return _mediaPlayer!.getStreamCount();
  }

  @override
  Future<PlayerStreamInfo> getStreamInfo(int index) {
    return _mediaPlayer!.getStreamInfo(index);
  }

  @override
  Future<void> mute(bool muted) {
    return _mediaPlayer!.mute(muted);
  }

  @override
  Future<void> open({required String url, required int startPos}) {
    return _mediaPlayer!.open(url: url, startPos: startPos);
  }

  @override
  Future<void> openWithAgoraCDNSrc(
      {required String src, required int startPos}) {
    return _mediaPlayer!.openWithAgoraCDNSrc(src: src, startPos: startPos);
  }

  @override
  Future<void> openWithMediaSource(MediaSource source) {
    return _mediaPlayer!.openWithMediaSource(source);
  }

  @override
  Future<void> pause() {
    return _mediaPlayer!.pause();
  }

  @override
  Future<void> play() {
    return _mediaPlayer!.play();
  }

  @override
  Future<void> playPreloadedSrc(String src) {
    return _mediaPlayer!.playPreloadedSrc(src);
  }

  @override
  Future<void> preloadSrc({required String src, required int startPos}) {
    return _mediaPlayer!.preloadSrc(src: src, startPos: startPos);
  }

  @override
  void registerAudioFrameObserver(MediaPlayerAudioFrameObserver observer) {
    _mediaPlayer?.registerAudioFrameObserver(observer);
  }

  @override
  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer, required int intervalInMS}) {
    _mediaPlayer?.registerMediaPlayerAudioSpectrumObserver(
        observer: observer, intervalInMS: intervalInMS);
  }

  @override
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    _mediaPlayer?.registerPlayerSourceObserver(observer);
  }

  @override
  void registerVideoFrameObserver(MediaPlayerVideoFrameObserver observer) {
    _mediaPlayer?.registerVideoFrameObserver(observer);
  }

  @override
  Future<void> renewAgoraCDNSrcToken({required String token, required int ts}) {
    return _mediaPlayer!.renewAgoraCDNSrcToken(token: token, ts: ts);
  }

  @override
  Future<void> resume() {
    return _mediaPlayer!.resume();
  }

  @override
  Future<void> seek(int newPos) {
    return _mediaPlayer!.seek(newPos);
  }

  @override
  Future<void> selectAudioTrack(int index) {
    return _mediaPlayer!.selectAudioTrack(index);
  }

  @override
  Future<void> selectInternalSubtitle(int index) {
    return _mediaPlayer!.selectInternalSubtitle(index);
  }

  @override
  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode) {
    return _mediaPlayer!.setAudioDualMonoMode(mode);
  }

  @override
  Future<void> setAudioPitch(int pitch) {
    return _mediaPlayer!.setAudioPitch(pitch);
  }

  @override
  Future<void> setExternalSubtitle(String url) {
    return _mediaPlayer!.setExternalSubtitle(url);
  }

  @override
  Future<void> setLoopCount(int loopCount) {
    return _mediaPlayer!.setLoopCount(loopCount);
  }

  @override
  Future<void> setPlaybackSpeed(int speed) {
    return _mediaPlayer!.setPlaybackSpeed(speed);
  }

  @override
  Future<void> setPlayerOptionInInt({required String key, required int value}) {
    return _mediaPlayer!.setPlayerOptionInInt(key: key, value: value);
  }

  @override
  Future<void> setPlayerOptionInString(
      {required String key, required String value}) {
    return _mediaPlayer!.setPlayerOptionInString(key: key, value: value);
  }

  @override
  Future<void> setRenderMode(RenderModeType renderMode) {
    return _mediaPlayer!.setRenderMode(renderMode);
  }

  @override
  Future<void> setSoundPositionParams(
      {required double pan, required double gain}) {
    return _mediaPlayer!.setSoundPositionParams(pan: pan, gain: gain);
  }

  @override
  Future<void> setSpatialAudioParams(SpatialAudioParams params) {
    return _mediaPlayer!.setSpatialAudioParams(params);
  }

  @override
  Future<void> setView(int view) {
    return _mediaPlayer!.setView(view);
  }

  @override
  Future<void> stop() {
    return _mediaPlayer!.stop();
  }

  @override
  Future<void> switchAgoraCDNLineByIndex(int index) {
    return _mediaPlayer!.switchAgoraCDNLineByIndex(index);
  }

  @override
  Future<void> switchAgoraCDNSrc({required String src, bool syncPts = false}) {
    return _mediaPlayer!.switchAgoraCDNSrc(src: src, syncPts: syncPts);
  }

  @override
  Future<void> switchSrc({required String src, bool syncPts = true}) {
    return _mediaPlayer!.switchSrc(src: src, syncPts: syncPts);
  }

  @override
  Future<void> takeScreenshot(String filename) {
    return _mediaPlayer!.takeScreenshot(filename);
  }

  @override
  Future<void> unloadSrc(String src) {
    return _mediaPlayer!.unloadSrc(src);
  }

  @override
  void unregisterAudioFrameObserver(MediaPlayerAudioFrameObserver observer) {
    _mediaPlayer?.unregisterAudioFrameObserver(observer);
  }

  @override
  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer) {
    _mediaPlayer?.unregisterMediaPlayerAudioSpectrumObserver(observer);
  }

  @override
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    _mediaPlayer?.unregisterPlayerSourceObserver(observer);
  }

  @override
  void unregisterVideoFrameObserver(MediaPlayerVideoFrameObserver observer) {
    _mediaPlayer?.unregisterVideoFrameObserver(observer);
  }

  @override
  int getVideoSourceType() => VideoSourceType.videoSourceMediaPlayer.value();

  @override
  Future<void> initialize() async {
    _mediaPlayer = await rtcEngine.createMediaPlayer();
    _initState.isInitialzed = true;
  }

  @override
  void addInitializedCompletedListener(VoidCallback listener) {
    _initState.addListener(listener);
  }

  @override
  void removeInitializedCompletedListener(VoidCallback listener) {
    _initState.removeListener(listener);
  }

  @override
  Future<int> createTextureRender(
      int uid, String channelId, int videoSourceType) {
    return super.createTextureRender(
      getMediaPlayerId(),
      channelId,
      videoSourceType,
    );
  }

  @override
  Future<void> setupNativeViewInternal(int nativeViewPtr) async {
    return setView(nativeViewPtr);
  }

  @override
  Future<void> dispose() async {
    _initState.dispose();
    await (_mediaPlayer as MediaPlayerImpl).destroy();
    await super.dispose();
    await rtcEngine.destroyMediaPlayer(this);
  }

  @override
  Future<void> disposeRenderInternal() async {
    if (shouldUseFlutterTexture) {
      await super.disposeRenderInternal();
    }
  }
}
