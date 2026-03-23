import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/services.dart';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/agora_rte_canvas_config.dart';
import 'package:agora_rtc_engine/src/agora_rte_config.dart';
import 'package:agora_rtc_engine/src/agora_rte_player_config.dart';
import 'agora_rte_js_interop.dart';
import 'agora_rte_canvas_web_impl.dart';
import 'agora_rte_player_web_impl.dart';

/// Web core: creates JS Rte/Player/Canvas instances.
/// Requires rte.js to be loaded via <script> tag in index.html before use.
class AgoraRteCoreWebImpl {
  static final AgoraRteCoreWebImpl instance = AgoraRteCoreWebImpl._();
  AgoraRteCoreWebImpl._();

  JsRte? _jsRte;
  AgoraRteConfig _config = AgoraRteConfig();
  int _playerCounter = 0;
  int _canvasCounter = 0;

  final Map<String, AgoraRtePlayerWebImpl> _players = {};
  final Map<String, AgoraRteCanvasWebImpl> _canvases = {};

  AgoraRtePlayerWebImpl? getPlayer(String playerId) => _players[playerId];
  AgoraRteCanvasWebImpl? getCanvas(String canvasId) => _canvases[canvasId];

  Future<void> createWithConfig(AgoraRteConfig config) async {
    if (_jsRte != null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine already initialized');
    }
    // Check that rte.js has been loaded via <script> tag in index.html
    if (!isRteSdkLoaded()) {
      throw PlatformException(
          code: 'RTE_ERROR',
          message: 'RteSdk not found on window. '
              'Add <script src="rte.js"></script> to your index.html before Flutter initialization.');
    }
    _config = AgoraRteConfig(
      appId: config.appId,
      logFolder: config.logFolder,
      logFileSize: config.logFileSize,
      areaCode: config.areaCode,
      cloudProxy: config.cloudProxy,
      jsonParameter: _mergeJsonParameter(config.jsonParameter),
      useStringUid: config.useStringUid,
    );
    _jsRte = JsRte(_buildJsRteConfig(_config));
  }

  /// Build [JsRteConfig] from [AgoraRteConfig].
  ///
  /// JS SDK's RteConfig only has: appId, logFolder?, cloudProxy?, jsonParameter?.
  /// Fields like areaCode/logFileSize/useStringUid are stored locally in [_config]
  /// for round-trip and are not passed to the JS SDK.
  JsRteConfig _buildJsRteConfig(AgoraRteConfig config) {
    return JsRteConfig(
      appId: (config.appId ?? '').toJS,
      logFolder: config.logFolder?.toJS,
      cloudProxy: config.cloudProxy?.toJS,
      jsonParameter: config.jsonParameter?.toJS,
    );
  }

  Future<void> initMediaEngine() async {
    if (_jsRte == null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine not initialized');
    }
    // No separate init step on web — Rte constructor handles it
  }

  Future<void> destroy() async {
    for (final player in _players.values) {
      await player.jsPlayer.destroy().toDart;
    }
    _players.clear();

    for (final canvas in _canvases.values) {
      await canvas.jsCanvas.destroy().toDart;
    }
    _canvases.clear();

    await _jsRte?.destroy().toDart;
    _jsRte = null;
  }

  Future<void> setConfigs(AgoraRteConfig config) async {
    _config = AgoraRteConfig(
      appId: config.appId ?? _config.appId,
      logFolder: config.logFolder ?? _config.logFolder,
      logFileSize: config.logFileSize ?? _config.logFileSize,
      areaCode: config.areaCode ?? _config.areaCode,
      cloudProxy: config.cloudProxy ?? _config.cloudProxy,
      jsonParameter: _mergeJsonParameter(
          config.jsonParameter ?? _config.jsonParameter),
      useStringUid: config.useStringUid ?? _config.useStringUid,
    );
    final rConfig = _buildJsRteConfig(_config);
    _jsRte?.setConfigs(rConfig);
  }

  /// Merge user jsonParameter with protected SDK parameters.
  /// Ensures rtc.set_app_type=4 is always present, matching native behavior.
  /// Throws PlatformException on invalid JSON to match native SDK behavior.
  String? _mergeJsonParameter(String? jsonParam) {
    final Map<String, dynamic> paramMap = {};
    if (jsonParam != null && jsonParam.isNotEmpty) {
      try {
        paramMap.addAll(Map<String, dynamic>.from(jsonDecode(jsonParam)));
      } catch (e) {
        throw PlatformException(
            code: 'RTE_ERROR',
            message: 'Invalid jsonParameter: $e');
      }
    }
    paramMap['rtc.set_app_type'] = 4;
    return jsonEncode(paramMap);
  }

  Future<AgoraRteConfig> getConfigs() async {
    if (_jsRte == null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine not initialized');
    }
    final jsConfig = _jsRte!.getConfigs();
    return AgoraRteConfig(
      appId: jsConfig.appId.toDart,
      logFolder: jsConfig.logFolder?.toDart ?? _config.logFolder,
      cloudProxy: jsConfig.cloudProxy?.toDart ?? _config.cloudProxy,
      jsonParameter: jsConfig.jsonParameter?.toDart ?? _config.jsonParameter,
      // Fields not in JS SDK's RteConfig — stored locally
      areaCode: _config.areaCode,
      logFileSize: _config.logFileSize,
      useStringUid: _config.useStringUid,
    );
  }

  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) async {
    if (_jsRte == null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine not initialized');
    }
    final jsPlayer = JsPlayer(_jsRte!);
    final id = 'web_player_${++_playerCounter}';
    final player = AgoraRtePlayerWebImpl(id, jsPlayer);
    await player.setConfigs(config);
    _players[id] = player;
    return player;
  }

  Future<void> destroyPlayer(String playerId) async {
    final player = _players.remove(playerId);
    if (player != null) {
      await player.dispose();
    }
  }

  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config) async {
    if (_jsRte == null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine not initialized');
    }
    final jsCanvas = JsCanvas(_jsRte!);
    final id = 'web_canvas_${++_canvasCounter}';
    final canvas = AgoraRteCanvasWebImpl(id, jsCanvas);
    await canvas.setConfigs(config);
    _canvases[id] = canvas;
    return canvas;
  }

  Future<void> destroyCanvas(String canvasId) async {
    final canvas = _canvases.remove(canvasId);
    if (canvas != null) {
      await canvas.jsCanvas.destroy().toDart;
    }
  }

  Future<void> setPlayerConfigs(
      String playerId, AgoraRtePlayerConfig config) async {
    final player = _players[playerId];
    if (player != null) {
      await player.setConfigs(config);
    }
  }
}
