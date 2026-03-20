import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/agora_rte_enums.dart';
import 'package:agora_rtc_engine/src/agora_rte_player_config.dart';
import 'agora_rte_js_interop.dart';
import 'agora_rte_canvas_web_impl.dart';

/// Web implementation of [AgoraRtePlayer].
class AgoraRtePlayerWebImpl implements AgoraRtePlayer {
  @override
  final String playerId;

  final JsPlayer jsPlayer;
  AgoraRtePlayerObserver? _observer;

  // Store JS callbacks so we can unregister them
  final Map<String, JSFunction> _jsCallbacks = {};

  AgoraRtePlayerConfig _config = const AgoraRtePlayerConfig();

  AgoraRtePlayerWebImpl(this.playerId, this.jsPlayer);

  void _bindJsEvents() {
    _registerJsCallback('stateChanged',
        (JSNumber oldState, JSNumber newState) {
      _observer?.onStateChanged(
        AgoraRtePlayerState.values[oldState.toDartInt],
        AgoraRtePlayerState.values[newState.toDartInt],
        null,
      );
    }.toJS);

    _registerJsCallback('positionChanged', (JSNumber position) {
      // JS SDK sends seconds (double), convert to milliseconds
      _observer?.onPositionChanged(
          (position.toDartDouble * 1000).round(), 0);
    }.toJS);

    _registerJsCallback('resolutionChanged',
        (JSNumber width, JSNumber height) {
      _observer?.onResolutionChanged(width.toDartInt, height.toDartInt);
    }.toJS);

    _registerJsCallback('event', (JSNumber eventType) {
      _observer?.onEvent(AgoraRtePlayerEvent.values[eventType.toDartInt]);
    }.toJS);

    _registerJsCallback('playerInfoUpdated', (JsPlayerInfo info) {
      _observer?.onPlayerInfoUpdated(_mapPlayerInfo(info));
    }.toJS);

    _registerJsCallback('audioVolumeIndication', (JSNumber volume) {
      _observer?.onAudioVolumeIndication(volume.toDartInt);
    }.toJS);

    _registerJsCallback('metadata',
        (JSNumber type, JSAny data, JSNumber length) {
      final dartData = data.dartify();
      Uint8List bytes;
      if (dartData is List) {
        bytes = Uint8List.fromList(dartData.cast<int>());
      } else {
        bytes = Uint8List(0);
      }
      _observer?.onMetadata(AgoraRtePlayerMetadataType.sei, bytes);
    }.toJS);
  }

  void _registerJsCallback(String event, JSFunction callback) {
    _jsCallbacks[event] = callback;
    jsPlayer.on(event.toJS, callback);
  }

  void _unbindJsEvents() {
    for (final entry in _jsCallbacks.entries) {
      jsPlayer.off(entry.key.toJS, entry.value);
    }
    _jsCallbacks.clear();
  }

  @override
  Future<void> openWithUrl(String url, int startTime) async {
    if (url.isEmpty) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'url is empty');
    }
    // Native API uses milliseconds, JS SDK uses seconds
    final startTimeSec = (startTime / 1000.0);
    await jsPlayer.openWithUrl(url.toJS, startTimeSec.toJS).toDart;
  }

  @override
  Future<void> openWithCustomSourceProvider(
      dynamic provider, int startTime) async {
    final startTimeSec = (startTime / 1000.0);
    await jsPlayer.openWithCustomSourceProvider(provider as JSObject, startTimeSec.toJS).toDart;
  }

  @override
  Future<void> openWithStream(dynamic stream) async {
    await jsPlayer.openWithStream(stream as JSObject).toDart;
  }

  @override
  Future<void> switchWithUrl(String url, bool syncPts) async {
    // JS SDK: switchWithUrl(url, startTime) — syncPts not applicable on web
    if (url.isEmpty) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'url is empty');
    }
    try {
      await jsPlayer.switchWithUrl(url.toJS, 0.toJS).toDart;
    } catch (e) {
      debugPrint('switchWithUrl failed: $e');
    }
   
  }

  @override
  Future<void> play() async {
    jsPlayer.play();
  }

  @override
  Future<void> stop() async {
    jsPlayer.stop();
  }

  @override
  Future<void> pause() async {
    jsPlayer.pause();
  }

  @override
  Future<void> seek(int newTime) async {
    // Native API uses milliseconds, JS SDK uses seconds
    final newTimeSec = (newTime / 1000.0);
    jsPlayer.seek(newTimeSec.toJS);
  }

  @override
  Future<void> muteAudio(bool mute) async {
    jsPlayer.muteAudio(mute.toJS);
  }

  @override
  Future<void> muteVideo(bool mute) async {
    jsPlayer.muteVideo(mute.toJS);
  }

  @override
  Future<void> setCanvas(AgoraRteCanvas canvas) async {
    if (canvas is AgoraRteCanvasWebImpl) {
      jsPlayer.setCanvas(canvas.jsCanvas);
    }
  }

  @override
  Future<AgoraRtePlayerStats> getStats() async {
    final jsStats = await jsPlayer.getStats().toDart;
    final stats = jsStats as JsPlayerStats;
    return AgoraRtePlayerStats(
      videoDecodeFrameRate: stats.videoDecodeFrameRate?.toDartInt,
      videoRenderFrameRate: stats.videoRenderFrameRate?.toDartInt,
      videoBitrate: stats.videoBitrate?.toDartInt,
      audioBitrate: stats.audioBitrate?.toDartInt,
    );
  }

  @override
  Future<int> getPosition() async {
    // JS SDK returns seconds (double), convert to milliseconds
    final secJs = jsPlayer.getPosition();
    return (secJs.toDartDouble * 1000).round();
  }

  @override
  Future<AgoraRtePlayerInfo> getInfo() async {
    final jsInfo = jsPlayer.getInfo();
    return _mapPlayerInfo(jsInfo);
  }

  @override
  Future<void> setConfigs(AgoraRtePlayerConfig config) async {
    _config = AgoraRtePlayerConfig(
      autoPlay: config.autoPlay ?? _config.autoPlay,
      playbackSpeed: config.playbackSpeed ?? _config.playbackSpeed,
      playoutVolume: config.playoutVolume ?? _config.playoutVolume,
      loopCount: config.loopCount ?? _config.loopCount,
      abrFallbackLayer: config.abrFallbackLayer ?? _config.abrFallbackLayer,
      abrSubscriptionLayer:
          config.abrSubscriptionLayer ?? _config.abrSubscriptionLayer,
      jsonParameter: config.jsonParameter ?? _config.jsonParameter,
    );
    final jsConfig = JsPlayerConfig(
      autoPlay: _config.autoPlay?.toJS,
      // Native playbackSpeed is percentage (100=1x), JS SDK expects multiplier (1.0)
      playbackSpeed: _config.playbackSpeed != null
          ? (_config.playbackSpeed!).toJS
          : null,
      playoutVolume: _config.playoutVolume?.toJS,
      loopCount: _config.loopCount?.toJS,
      abrFallbackLayer: _config.abrFallbackLayer?.index.toJS,
      abrSubscriptionLayer: _config.abrSubscriptionLayer?.index.toJS,
    );
    await jsPlayer.setConfigs(jsConfig).toDart;
  }

  @override
  Future<AgoraRtePlayerConfig> getConfigs() async {
    final jsConfig = jsPlayer.getConfigs();
    // JS SDK playbackSpeed is multiplier (1.0=1x), convert back to percentage (100)
    final jsSpeed = jsConfig.playbackSpeed?.toDartDouble;
    return AgoraRtePlayerConfig(
      autoPlay: jsConfig.autoPlay?.toDart,
      playbackSpeed: jsSpeed != null ? (jsSpeed).round() : null,
      playoutVolume: jsConfig.playoutVolume?.toDartInt,
      loopCount: jsConfig.loopCount?.toDartInt,
      abrSubscriptionLayer:
          _mapAbrSubscriptionLayer(jsConfig.abrSubscriptionLayer?.toDartInt),
      abrFallbackLayer:
          _mapAbrFallbackLayer(jsConfig.abrFallbackLayer?.toDartInt),
      jsonParameter: _config.jsonParameter,
    );
  }

  AgoraRteAbrSubscriptionLayer? _mapAbrSubscriptionLayer(int? value) {
    if (value == null) return null;
    if (value >= 0 && value < AgoraRteAbrSubscriptionLayer.values.length) {
      return AgoraRteAbrSubscriptionLayer.values[value];
    }
    return null;
  }

  AgoraRteAbrFallbackLayer? _mapAbrFallbackLayer(int? value) {
    if (value == null) return null;
    if (value >= 0 && value < AgoraRteAbrFallbackLayer.values.length) {
      return AgoraRteAbrFallbackLayer.values[value];
    }
    return null;
  }


  
  /// Convert JS PlayerInfo → Dart AgoraRtePlayerInfo with full field mapping.
  /// JS SDK duration is in seconds, convert to milliseconds.
  AgoraRtePlayerInfo _mapPlayerInfo(JsPlayerInfo info) {
    final durationSec = info.duration?.toDartDouble;
    return AgoraRtePlayerInfo(
      state: info.state?.toDartInt,
      videoWidth: info.videoWidth?.toDartInt,
      videoHeight: info.videoHeight?.toDartInt,
      duration: durationSec != null ? (durationSec * 1000).round() : null,
      audioSampleRate: info.audioSampleRate?.toDartInt,
      audioChannels: info.audioChannels?.toDartInt,
      audioBitsPerSample: info.audioBitsPerSample?.toDartInt,
      hasAudio: info.hasAudio?.toDart,
      hasVideo: info.hasVideo?.toDart,
      isAudioMuted: info.isAudioMuted?.toDart,
      isVideoMuted: info.isVideoMuted?.toDart,
      currentUrl: info.currentUrl?.toDart,
      streamCount: info.streamCount?.toDartInt,
      abrSubscriptionLayer:
          _mapAbrSubscriptionLayer(info.abrSubscriptionLayer?.toDartInt),
    );
  }

  Future<void> dispose() async {
    _unbindJsEvents();
    await jsPlayer.destroy().toDart;
  }

  @override
  Future<void> registerObserver(AgoraRtePlayerObserver observer) async {
    _observer = observer;
    _bindJsEvents();
  }

  @override
  Future<void> unregisterObserver(AgoraRtePlayerObserver observer) async {
    _unbindJsEvents();
    _observer = null;
  }
}
