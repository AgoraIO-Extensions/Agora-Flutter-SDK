import 'dart:async';
import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'agora_rte_player_impl.dart';
import 'agora_rte_canvas_impl.dart';

/// RTE core implementation - manages RTE lifecycle and configuration
class AgoraRteCoreImpl {
  static const MethodChannel _channel = MethodChannel('agora_rtc_ng');
  static final AgoraRteCoreImpl _instance = AgoraRteCoreImpl._internal();

  factory AgoraRteCoreImpl() => _instance;
  
  /// Get singleton instance
  static AgoraRteCoreImpl get instance => _instance;

  AgoraRteCoreImpl._internal() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }
  final Map<String, AgoraRtePlayerImpl> _players = {};
  final Map<String, AgoraRteCanvasImpl> _canvases = {};

  /// Get player instance
  AgoraRtePlayerImpl? getPlayer(String playerId) => _players[playerId];

  /// Get canvas instance
  AgoraRteCanvasImpl? getCanvas(String canvasId) => _canvases[canvasId];

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    final args = call.arguments as Map?;
    final playerId = args?['playerId'] as String?;
    final canvasId = args?['canvasId'] as String?;

    // Dispatch Player callback
    if (playerId != null && _players.containsKey(playerId)) {
      final player = _players[playerId]!;
      // Player callback method names start with rtePlayer
      if (call.method.startsWith('rtePlayer')) {
        player.handleCallback(call.method, args ?? {});
      }
    }

    // Dispatch Canvas callback
    if (canvasId != null && _canvases.containsKey(canvasId)) {
      final canvas = _canvases[canvasId]!;
      // Canvas callback method names start with rteCanvas
      if (call.method.startsWith('rteCanvas')) {
        canvas.handleCallback(call.method, args ?? {});
      }
    }

    // Handle global callbacks
    if (call.method == 'rteInitMediaEngineCallback') {
      // Handle global callbacks if any
    }
  }

  /// Create RTE instance from Bridge
  Future<void> createFromBridge() async {
    await _channel.invokeMethod('rteCreateFromBridge');
  }

  /// Create RTE instance with config
  Future<void> createWithConfig(AgoraRteConfig config) async {
    await _channel.invokeMethod('rteCreateWithConfig', config.toJson());
  }

  /// Initialize media engine
  Future<void> initMediaEngine() async {
    await _channel.invokeMethod('rteInitMediaEngine');
  }

  /// Destroy RTE instance
  Future<void> destroy() async {
    // Stop all players before destroying engine to ensure audio/video stops
    if (_players.isNotEmpty) {
      await Future.wait(_players.values.map((player) async {
        try {
          await player.stop();
        } catch (e) {
          // Ignore errors during destroy
          debugPrint('Error stopping player during destroy: $e');
        }
      }));
    }

    await _channel.invokeMethod('rteDestroy');
    _players.clear();
    _canvases.clear();
  }

  /// Set configurations in batch
  Future<void> setConfigs(AgoraRteConfig config) async {
    await _channel.invokeMethod('rteSetConfigs', config.toJson());
  }

  /// Get all configurations
  Future<AgoraRteConfig> getConfigs() async {
    Map<String, dynamic> result = await _channel.invokeMethod('rteGetConfigs');
    return AgoraRteConfig.fromJson(result);
  }

  /// Create player
  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) async {
    final String playerId =
        await _channel.invokeMethod('rtePlayerCreate', config.toJson());
    final player = AgoraRtePlayerImpl(playerId, _channel);
    _players[playerId] = player;
    return player;
  }

  /// Destroy player
  Future<void> destroyPlayer(String playerId) async {
    await _channel.invokeMethod('rtePlayerDestroy', {'playerId': playerId});
    _players.remove(playerId);
  }

  /// Create canvas
  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config) async {
    final String canvasId =
        await _channel.invokeMethod('rteCanvasCreate', config.toJson());
    final canvas = AgoraRteCanvasImpl(canvasId, _channel);
    _canvases[canvasId] = canvas;
    return canvas;
  }

  /// Destroy canvas
  Future<void> destroyCanvas(String canvasId) async {
    await _channel.invokeMethod('rteCanvasDestroy', {'canvasId': canvasId});
    _canvases.remove(canvasId);
  }

  /// Preload URL
  static Future<void> preloadWithUrl(String url) async {
    await _channel.invokeMethod('rtePlayerPreloadWithUrl', {'url': url});
  }
}
