import 'dart:js_interop';

/// JS interop bindings for @rtejs/rte SDK (window.AgoraRte).
/// Matches the exports from web/src/src/index.js bundled via webpack.

// ─── SDK Load Check ─────────────────────────────────────────────────────────

@JS('window.AgoraRte')
external JSAny? get windowAgoraRte;

/// Check if window.AgoraRte is available (rte.js loaded via <script> tag).
bool isRteSdkLoaded() => windowAgoraRte != null;

// ─── Constants ──────────────────────────────────────────────────────────────

class JsPlayerState {
  static const int idle = 0;
  static const int opening = 1;
  static const int openCompleted = 2;
  static const int playing = 3;
  static const int paused = 4;
  static const int playbackCompleted = 5;
  static const int stopped = 6;
  static const int failed = 7;
}

class JsPlayerEvent {
  static const int seekBegin = 0;
  static const int seekComplete = 1;
  static const int seekError = 2;
  static const int bufferLow = 3;
  static const int bufferRecover = 4;
  static const int freezeStart = 5;
  static const int freezeStop = 6;
  static const int oneLoopPlaybackCompleted = 7;
  static const int authenticationWillExpire = 8;
  static const int abrFallbackToAudioOnlyLayer = 9;
  static const int abrRecoverFromAudioOnlyLayer = 10;
  static const int switchBegin = 11;
  static const int switchComplete = 12;
  static const int switchError = 13;
  static const int firstDisplayed = 14;
  static const int reachCacheFileMaxCount = 15;
  static const int reachCacheFileMaxSize = 16;
  static const int tryOpenStart = 17;
  static const int tryOpenSucceed = 18;
  static const int tryOpenFailed = 19;
  static const int audioTrackChanged = 20;
}

class JsVideoMirrorMode {
  static const int auto = 0;
  static const int enabled = 1;
  static const int disabled = 2;
}

class JsVideoRenderMode {
  static const int hidden = 0;
  static const int fit = 1;
}

class JsRteErrorCode {
  static const int ok = 0;
  static const int defaultError = 1;
  static const int invalidArgument = 2;
  static const int invalidOperation = 3;
  static const int networkError = 4;
  static const int authenticationFailed = 5;
  static const int streamNotFound = 6;
}

/// Mirrors `enum PlayerMetadataType { kRtePlayerMetadataTypeSei = 0 }`
class JsPlayerMetadataType {
  static const int sei = 0;
}

// ─── AgoraRte.Rte ──────────────────────────────────────────────────────────────

@JS('AgoraRte.Rte')
@staticInterop
class JsRte {
  external factory JsRte(JsRteConfig config);
}

extension JsRteExt on JsRte {
  external void setConfigs(JsRteConfig config);
  external JsRteConfig getConfigs();
  external JSPromise destroy();
  external void on(JSString event, JSFunction listener);
  external void once(JSString event, JSFunction listener);
  external void off(JSString event, [JSFunction? listener]);
  external void registerObserver(JSString event, JSFunction listener);
  external void unregisterObserver(JSString event, JSFunction listener);
  external void removeAllListeners([JSString? event]);
}

@JS()
@anonymous
@staticInterop
class JsRteConfig {
  external factory JsRteConfig({
    required JSString appId,
    JSString? logFolder,
    JSString? cloudProxy,
    JSString? jsonParameter,
  });
}

extension JsRteConfigExt on JsRteConfig {
  external JSString get appId;
  external JSString? get logFolder;
  external JSString? get cloudProxy;
  external JSString? get jsonParameter;
}

// ─── AgoraRte.Player ───────────────────────────────────────────────────────────

@JS('AgoraRte.Player')
@staticInterop
class JsPlayer {
  external factory JsPlayer(JsRte rte, [JsPlayerInitialConfig? config]);
}

extension JsPlayerExt on JsPlayer {
  external JSPromise openWithUrl(JSString url, [JSNumber startTime]);
  external JSPromise switchWithUrl(JSString url, [JSNumber startTime]);
  external JSPromise openWithCustomSourceProvider(
      JSObject sourceProvider, JSNumber startTime);
  external JSPromise openWithStream(JSObject stream);
  external void play();
  external void stop();
  external void pause();
  external void resume();
  external void seek(JSNumber newTime);
  external void muteAudio(JSBoolean mute);
  external void muteVideo(JSBoolean mute);
  external JSNumber getPosition();
  external JsPlayerInfo getInfo();
  external JSObject getMediaTrackInfo();
  external JSPromise getStats();
  external JSPromise setConfigs(JsPlayerConfig config);
  external JsPlayerConfig getConfigs();
  external JSPromise setCanvas(JsCanvas canvas);
  external JSPromise takeScreenshot();
  external JSPromise destroy();

  external void on(JSString event, JSFunction listener);
  external void off(JSString event, [JSFunction? listener]);
  external void once(JSString event, JSFunction listener);
  external void registerObserver(JSString event, JSFunction listener);
  external void unregisterObserver(JSString event, JSFunction listener);
  external void removeAllListeners([JSString? event]);
}

@JS()
@anonymous
@staticInterop
class JsPlayerInitialConfig {
  external factory JsPlayerInitialConfig();
}

@JS()
@anonymous
@staticInterop
class JsPlayerConfig {
  external factory JsPlayerConfig({
    JSBoolean? autoPlay,
    JSNumber? playbackSpeed,
    JSNumber? playoutVolume,
    JSNumber? loopCount,
    JSNumber? abrFallbackLayer,
    JSNumber? abrSubscriptionLayer,
  });
}

extension JsPlayerConfigExt on JsPlayerConfig {
  external JSBoolean? get autoPlay;
  external JSNumber? get playbackSpeed;
  external JSNumber? get playoutVolume;
  external JSNumber? get loopCount;
  external JSNumber? get abrFallbackLayer;
  external JSNumber? get abrSubscriptionLayer;
}

@JS()
@anonymous
@staticInterop
class JsPlayerInfo {}

extension JsPlayerInfoExt on JsPlayerInfo {
  external JSNumber? get state;
  external JSNumber? get videoWidth;
  external JSNumber? get videoHeight;
  external JSNumber? get duration;
  external JSNumber? get audioSampleRate;
  external JSNumber? get audioChannels;
  external JSNumber? get audioBitsPerSample;
  external JSBoolean? get hasAudio;
  external JSBoolean? get hasVideo;
  external JSBoolean? get isAudioMuted;
  external JSBoolean? get isVideoMuted;
  external JSString? get currentUrl;
  external JSNumber? get streamCount;
  external JSNumber? get abrSubscriptionLayer;
}

@JS()
@anonymous
@staticInterop
class JsPlayerStats {}

extension JsPlayerStatsExt on JsPlayerStats {
  external JSNumber? get videoDecodeFrameRate;
  external JSNumber? get videoRenderFrameRate;
  external JSNumber? get videoBitrate;
  external JSNumber? get audioBitrate;
}

// ─── AgoraRte.Canvas ───────────────────────────────────────────────────────────

@JS('AgoraRte.Canvas')
@staticInterop
class JsCanvas {
  external factory JsCanvas(JsRte rte, [JsCanvasConfig? config]);
}

extension JsCanvasExt on JsCanvas {
  external JSPromise addView(JSAny view);
  external JSPromise removeView(JSAny view);
  external JSPromise setConfigs(JsCanvasConfig config);
  external JsCanvasConfig getConfigs();
  external JSAny? getFirstView();
  external JSPromise destroy();
}

@JS()
@anonymous
@staticInterop
class JsCanvasConfig {
  external factory JsCanvasConfig({
    JSNumber? mirrorMode,
    JSNumber? renderMode,
  });
}

extension JsCanvasConfigExt on JsCanvasConfig {
  external JSNumber? get mirrorMode;
  external JSNumber? get renderMode;
}

// ─── AgoraRte.RteError ─────────────────────────────────────────────────────────

@JS('AgoraRte.RteError')
@staticInterop
class JsRteError {}

extension JsRteErrorExt on JsRteError {
  external JSNumber get code;
  external JSString get fix;
  external JSString get message;
}
