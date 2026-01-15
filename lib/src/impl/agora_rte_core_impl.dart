import 'dart:async';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/services.dart';
import 'agora_rte_config_impl.dart';
import 'agora_rte_player_impl.dart';
import 'agora_rte_canvas_impl.dart';

/// RTE 核心实现类 - 管理 RTE 生命周期和配置
class AgoraRteCoreImpl {
  static const MethodChannel _channel = MethodChannel('agora_rtc_ng');
  static final AgoraRteCoreImpl _instance = AgoraRteCoreImpl._internal();

  factory AgoraRteCoreImpl() => _instance;
  
  /// 获取单例实例
  static AgoraRteCoreImpl get instance => _instance;

  AgoraRteCoreImpl._internal() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  final AgoraRteConfigImpl _config = AgoraRteConfigImpl();
  final Map<String, AgoraRtePlayerImpl> _players = {};
  final Map<String, AgoraRteCanvasImpl> _canvases = {};

  /// 获取配置管理器
  AgoraRteConfigImpl get config => _config;

  /// 获取播放器实例
  AgoraRtePlayerImpl? getPlayer(String playerId) => _players[playerId];

  /// 获取画布实例
  AgoraRteCanvasImpl? getCanvas(String canvasId) => _canvases[canvasId];

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    final args = call.arguments as Map?;
    final playerId = args?['playerId'] as String?;
    final canvasId = args?['canvasId'] as String?;

    // 分发 Player 回调
    if (playerId != null && _players.containsKey(playerId)) {
      final player = _players[playerId]!;
      // Player 回调方法名以 rtePlayer 开头
      if (call.method.startsWith('rtePlayer')) {
        player.handleCallback(call.method, args ?? {});
      }
    }

    // 分发 Canvas 回调
    if (canvasId != null && _canvases.containsKey(canvasId)) {
      final canvas = _canvases[canvasId]!;
      // Canvas 回调方法名以 rteCanvas 开头
      if (call.method.startsWith('rteCanvas')) {
        canvas.handleCallback(call.method, args ?? {});
      }
    }

    // 处理全局回调
    if (call.method == 'rteInitMediaEngineCallback') {
      // Handle global callbacks if any
    }
  }

  /// 从 Bridge 创建 RTE 实例
  Future<void> createFromBridge() async {
    await _channel.invokeMethod('rteCreateFromBridge');
  }

  /// 使用配置创建 RTE 实例
  Future<void> createWithConfig(AgoraRteConfig config) async {
    await _channel.invokeMethod('rteCreateWithConfig', config.toJson());
  }

  /// 初始化媒体引擎
  Future<void> initMediaEngine() async {
    await _channel.invokeMethod('rteInitMediaEngine');
  }

  /// 销毁 RTE 实例
  Future<void> destroy() async {
    await _channel.invokeMethod('rteDestroy');
    _players.clear();
    _canvases.clear();
  }

  /// 批量设置配置
  Future<void> setConfigs(AgoraRteConfig config) async {
    await _channel.invokeMethod('rteSetConfigs', config.toJson());
  }

  /// 获取所有配置
  Future<AgoraRteConfig> getConfigs() async {
    final Map result = await _channel.invokeMethod('rteGetConfigs');
    return AgoraRteConfig(
      appId: result['appId'],
      logFolder: result['logFolder'],
      logFileSize: result['logFileSize'],
      areaCode: result['areaCode'],
      cloudProxy: result['cloudProxy'],
      jsonParameter: result['jsonParameter'],
    );
  }

  /// 创建播放器
  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) async {
    final String playerId =
        await _channel.invokeMethod('rtePlayerCreate', config.toJson());
    final player = AgoraRtePlayerImpl(playerId, _channel);
    _players[playerId] = player;
    return player;
  }

  /// 销毁播放器
  Future<void> destroyPlayer(String playerId) async {
    await _channel.invokeMethod('rtePlayerDestroy', {'playerId': playerId});
    _players.remove(playerId);
  }

  /// 创建画布
  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config) async {
    final String canvasId =
        await _channel.invokeMethod('rteCanvasCreate', config.toJson());
    final canvas = AgoraRteCanvasImpl(canvasId, _channel);
    _canvases[canvasId] = canvas;
    return canvas;
  }

  /// 销毁画布
  Future<void> destroyCanvas(String canvasId) async {
    await _channel.invokeMethod('rteCanvasDestroy', {'canvasId': canvasId});
    _canvases.remove(canvasId);
  }

  /// 预加载 URL
  static Future<void> preloadWithUrl(String url) async {
    const channel = MethodChannel('agora_rtc_ng');
    await channel.invokeMethod('rtePlayerPreloadWithUrl', {'url': url});
  }
}
