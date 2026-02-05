import 'dart:async';
import 'dart:convert';
import 'package:agora_rtc_engine/agora_rte_engine.dart';
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
  // Maintain canvas -> player mapping for automatic re-association after config changes
  final Map<String, String> _canvasToPlayer = {};

  /// Get player instance
  AgoraRtePlayerImpl? getPlayer(String playerId) => _players[playerId];

  /// Get canvas instance
  AgoraRteCanvasImpl? getCanvas(String canvasId) => _canvases[canvasId];

  /// Get player ID associated with a canvas
  String? getPlayerIdForCanvas(String canvasId) => _canvasToPlayer[canvasId];

  /// Associate a canvas with a player
  /// Internal method used by player.setCanvas to register the association
  void associateCanvasWithPlayer(String canvasId, String? playerId) {
    if (playerId != null) {
      _canvasToPlayer[canvasId] = playerId;
    } else {
      _canvasToPlayer.remove(canvasId);
    }
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    final args = call.arguments != null
        ? Map<String, dynamic>.from(call.arguments)
        : null;
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
    // Merge SDK protected parameters into config
    final protectedConfig = _mergeProtectedParams(config);
    await _channel.invokeMethod(
        'rteCreateWithConfig', protectedConfig.toJson());
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
    _canvasToPlayer.clear();
  }

  /// Set configurations in batch
  Future<void> setConfigs(AgoraRteConfig config) async {
    // Merge SDK protected parameters into config
    final protectedConfig = _mergeProtectedParams(config);
    await _channel.invokeMethod('rteSetConfigs', protectedConfig.toJson());
  }

  /// Merge SDK protected parameters with user's config
  /// Ensures rtc.set_app_type is always set to 4 and cannot be overridden
  AgoraRteConfig _mergeProtectedParams(AgoraRteConfig config) {
    const sdkProtectedParams = '{"rtc.set_app_type": 4}';

    String mergedJson;
    if (config.jsonParameter == null || config.jsonParameter!.isEmpty) {
      // No client params, use SDK params only
      mergedJson = sdkProtectedParams;
    } else {
      // Merge client params with SDK protected params
      try {
        final clientParams =
            Map<String, dynamic>.from(jsonDecode(config.jsonParameter!));
        // Force SDK protected parameter (cannot be overridden)
        clientParams['rtc.set_app_type'] = 4;
        mergedJson = jsonEncode(clientParams);
      } catch (e) {
        // If client JSON is invalid, fallback to SDK params only
        debugPrint('Invalid jsonParameter, using SDK defaults: $e');
        mergedJson = sdkProtectedParams;
      }
    }

    // Return new config with merged jsonParameter
    return AgoraRteConfig(
      appId: config.appId,
      logFolder: config.logFolder,
      logFileSize: config.logFileSize,
      areaCode: config.areaCode,
      cloudProxy: config.cloudProxy,
      jsonParameter: mergedJson,
      useStringUid: config.useStringUid,
    );
  }

  /// Get all configurations
  Future<AgoraRteConfig> getConfigs() async {
    final result = await _channel.invokeMethod('rteGetConfigs');
    return AgoraRteConfig.fromJson(Map<String, dynamic>.from(result));
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
    final canvas = AgoraRteCanvasImpl(canvasId, _channel, this);
    _canvases[canvasId] = canvas;
    return canvas;
  }

  /// Destroy canvas
  Future<void> destroyCanvas(String canvasId) async {
    await _channel.invokeMethod('rteCanvasDestroy', {'canvasId': canvasId});
    _canvases.remove(canvasId);
    _canvasToPlayer.remove(canvasId);
  }

  /// Set canvas for a player (unified method for rtePlayerSetCanvas)
  /// This is the single point of calling rtePlayerSetCanvas
  /// [registerAssociation] indicates whether to register the association for future re-association
  Future<void> setPlayerCanvas(String playerId, String canvasId,
      {bool registerAssociation = false}) async {
    await _channel.invokeMethod('rtePlayerSetCanvas', {
      'playerId': playerId,
      'canvasId': canvasId,
    });
    // Register canvas-player association if requested (for first-time setup)
    if (registerAssociation) {
      associateCanvasWithPlayer(canvasId, playerId);
    }
  }

  /// Re-associate canvas with player after config change
  /// This is called internally by canvas.setConfigs when needed
  Future<void> reassociateCanvasWithPlayer(String canvasId) async {
    final playerId = _canvasToPlayer[canvasId];
    if (playerId != null) {
      // Re-associate without registering (association already exists)
      await setPlayerCanvas(playerId, canvasId, registerAssociation: false);
    }
  }

  /// Preload URL
  static Future<void> preloadWithUrl(String url) async {
    await _channel.invokeMethod('rtePlayerPreloadWithUrl', {'url': url});
  }
}
