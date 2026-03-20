import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/agora_rte_canvas_config.dart';
import 'package:agora_rtc_engine/src/agora_rte_config.dart';
import 'package:agora_rtc_engine/src/agora_rte_player_config.dart';
import 'package:web/web.dart' as web;
import 'agora_rte_js_interop.dart';
import 'agora_rte_canvas_web_impl.dart';
import 'agora_rte_player_web_impl.dart';

/// Web core: loads rte.js, creates JS Rte/Player/Canvas instances.
class AgoraRteCoreWebImpl {
  static final AgoraRteCoreWebImpl instance = AgoraRteCoreWebImpl._();
  AgoraRteCoreWebImpl._();

  JsRte? _jsRte;
  AgoraRteConfig _config = AgoraRteConfig();
  bool _scriptLoaded = false;
  int _playerCounter = 0;
  int _canvasCounter = 0;

  final Map<String, AgoraRtePlayerWebImpl> _players = {};
  final Map<String, AgoraRteCanvasWebImpl> _canvases = {};

  AgoraRtePlayerWebImpl? getPlayer(String playerId) => _players[playerId];
  AgoraRteCanvasWebImpl? getCanvas(String canvasId) => _canvases[canvasId];

  Future<void> _loadScript() async {
    if (_scriptLoaded) return;
    final scriptId = 'agora-rte-sdk';
    if (web.document.getElementById(scriptId) != null) {
      _scriptLoaded = true;
      return;
    }

    // Flutter bundles plugin assets at this path in both debug and release mode.
    const assetPath = 'assets/packages/agora_rtc_engine/web/rte.js';
    try {
      await _tryLoadScript(scriptId, assetPath);
      _scriptLoaded = true;
    } catch (_) {
      throw Exception(
          'Failed to load rte.js. '
          'Ensure you have run "npm run build" in the plugin web/src/ directory.');
    }
  }

  Future<void> _tryLoadScript(String id, String src) async {
    final c = Completer<void>();
    final script =
        web.document.createElement('script') as web.HTMLScriptElement;
    script.id = id;
    script.src = src;
    script.onload = (web.Event _) {
      c.complete();
    }.toJS;
    script.onerror = (web.Event _) {
      // Remove failed script element so next attempt can use the same id
      script.remove();
      c.completeError('Failed to load $src');
    }.toJS;
    web.document.head!.appendChild(script);
    await c.future;
  }

  Future<void> createWithConfig(AgoraRteConfig config) async {
    if (_jsRte != null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine already initialized');
    }
    await _loadScript();
    _config = config;
    _jsRte = JsRte(_buildJsRteConfig(config));
  }

  /// Build a [JsRteConfig] from [AgoraRteConfig], mapping only the fields
  /// that the JS SDK supports: appId, areaCode, cloudProxy.
  ///
  /// JS SDK areaCode is a string ("cn","na","eu","as","jp","in","glob"),
  /// while native uses bitmask integers. We map the most common values.
  JsRteConfig _buildJsRteConfig(AgoraRteConfig config) {
    // Build sdkParameters as Array<SdkParameter> per JS SDK definition.
    // Native side passes jsonParameter as a JSON string of key-value pairs,
    // e.g. '{"rtc.set_app_type": 4}'. We parse it and convert to
    // [{key, value}, ...] format that JS SDK expects.
    final Map<String, dynamic> paramMap = {};

    if (config.jsonParameter != null && config.jsonParameter!.isNotEmpty) {
      try {
        paramMap.addAll(
            Map<String, dynamic>.from(jsonDecode(config.jsonParameter!)));
      } catch (e) {
        debugPrint('Invalid jsonParameter, ignoring: $e');
      }
    }
    // Force SDK protected parameter
    paramMap['rtc.set_app_type'] = 4;

    final jsSdkParams = <JSAny>[];
    for (final e in paramMap.entries) {
      jsSdkParams.add(JsSdkParameter(
        key: e.key.toJS,
        value: (e.value is String)
            ? (e.value as String).toJS
            : (e.value is num)
                ? (e.value as num).toJS
                : e.value.toString().toJS,
      ) as JSAny);
    }

    return JsRteConfig(
      appId: (config.appId ?? '').toJS,
      areaCode: _mapAreaCode(config.areaCode)?.toJS,
      cloudProxy: config.cloudProxy?.toJS,
      sdkParameters: jsSdkParams.toJS,
    );
  }

  static String? _mapAreaCode(int? code) {
    if (code == null) return null;
    // Native bitmask → JS RteAreaCode string
    switch (code) {
      case 0x00000001:
        return JsRteAreaCode.cn;
      case 0x00000002:
        return JsRteAreaCode.na;
      case 0x00000004:
        return JsRteAreaCode.eu;
      case 0x00000008:
        return JsRteAreaCode.as_;
      case 0x00000010:
        return JsRteAreaCode.jp;
      case 0x00000020:
        return JsRteAreaCode.in_;
      case 0xFFFFFFFF:
      default:
        return JsRteAreaCode.glob;
    }
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
      jsonParameter: config.jsonParameter ?? _config.jsonParameter,
      useStringUid: config.useStringUid ?? _config.useStringUid,
    );
    final rConfig = _buildJsRteConfig(_config);
    _jsRte?.setConfigs(rConfig);
  }

  Future<AgoraRteConfig> getConfigs() async {
    if (_jsRte == null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine not initialized');
    }
    final jsConfig = _jsRte!.getConfigs();
    return AgoraRteConfig(
      appId: jsConfig.appId.toDart,
      areaCode: _reverseMapAreaCode(jsConfig.areaCode?.toDart),
      cloudProxy: jsConfig.cloudProxy?.toDart,
      // Fields only stored locally (JS SDK doesn't return these)
      logFolder: _config.logFolder,
      logFileSize: _config.logFileSize,
      jsonParameter: _config.jsonParameter,
      useStringUid: _config.useStringUid,
    );
  }

  /// JS areaCode string → native bitmask int
  static int? _reverseMapAreaCode(String? code) {
    if (code == null) return null;
    switch (code) {
      case JsRteAreaCode.cn:
        return 0x00000001;
      case JsRteAreaCode.na:
        return 0x00000002;
      case JsRteAreaCode.eu:
        return 0x00000004;
      case JsRteAreaCode.as_:
        return 0x00000008;
      case JsRteAreaCode.jp:
        return 0x00000010;
      case JsRteAreaCode.in_:
        return 0x00000020;
      case JsRteAreaCode.glob:
        return 0xFFFFFFFF;
      default:
        return null;
    }
  }

  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) async {
    if (_jsRte == null) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'RTE engine not initialized');
    }
    final jsPlayer = JsPlayer(_jsRte!);
    final id = 'web_player_${++_playerCounter}';
    final player = AgoraRtePlayerWebImpl(id, jsPlayer);
    player.setConfigs(config);
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
    canvas.setConfigs(config);
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
