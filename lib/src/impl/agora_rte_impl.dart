import 'dart:async';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/services.dart';
import 'agora_rte_core_impl.dart';
import 'agora_rte_config_impl.dart';

/// RTE 主实现类 - 委托给分离的类
class AgoraRteImpl implements AgoraRte {
  static final AgoraRteImpl _instance = AgoraRteImpl._internal();
  factory AgoraRteImpl() => _instance;

  final AgoraRteCoreImpl _core = AgoraRteCoreImpl.instance;
  final AgoraRteConfigImpl _config = AgoraRteConfigImpl();

  AgoraRteImpl._internal();

  /// 获取配置管理器
  AgoraRteConfigImpl get config => _config;

  /// 创建播放器
  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) async {
    return await _core.createPlayer(config);
  }

  /// 销毁播放器
  Future<void> destroyPlayer(String playerId) async {
    return await _core.destroyPlayer(playerId);
  }

  /// 创建画布
  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config) async {
    return await _core.createCanvas(config);
  }

  /// 销毁画布
  Future<void> destroyCanvas(String canvasId) async {
    return await _core.destroyCanvas(canvasId);
  }

  /// 预加载 URL
  static Future<void> preloadWithUrl(String url) async {
    return await AgoraRteCoreImpl.preloadWithUrl(url);
  }

  @override
  Future<void> createFromBridge() async {
    return await _core.createFromBridge();
  }

  @override
  Future<void> createWithConfig(AgoraRteConfig config) async {
    return await _core.createWithConfig(config);
  }

  @override
  Future<void> initMediaEngine() async {
    return await _core.initMediaEngine();
  }

  @override
  Future<void> destroy() async {
    return await _core.destroy();
  }

  @override
  Future<void> setConfigs(AgoraRteConfig config) async {
    return await _core.setConfigs(config);
  }

  @override
  Future<AgoraRteConfig> getConfigs() async {
    return await _core.getConfigs();
  }

  @override
  Future<String> appId() async {
    return await _config.appId();
  }

  @override
  Future<String> logFolder() async {
    return await _config.logFolder();
  }

  @override
  Future<int> logFileSize() async {
    return await _config.logFileSize();
  }

  @override
  Future<int> areaCode() async {
    return await _config.areaCode();
  }

  @override
  Future<String> cloudProxy() async {
    return await _config.cloudProxy();
  }

  @override
  Future<String> jsonParameter() async {
    return await _config.jsonParameter();
  }

  @override
  Future<void> registerObserver(AgoraRteObserver observer) async {
    // TODO: Implement when RTE observer is available
    const channel = MethodChannel('agora_rtc_ng');
    await channel.invokeMethod('rteRegisterObserver');
  }

  @override
  Future<void> unregisterObserver(AgoraRteObserver observer) async {
    // TODO: Implement when RTE observer is available
    const channel = MethodChannel('agora_rtc_ng');
    await channel.invokeMethod('rteUnregisterObserver');
  }
}
