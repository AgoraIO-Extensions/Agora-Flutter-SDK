import 'dart:async';
import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'agora_rte_core_impl.dart';

/// RTE main implementation - delegates to separated classes
class AgoraRteImpl implements AgoraRte {
  static final AgoraRteImpl _instance = AgoraRteImpl._internal();

  /// Creates and returns the singleton instance of [AgoraRteImpl].
  ///
  /// This is the recommended way to get an instance of the RTE engine.
  static AgoraRteImpl create() => _instance;

  factory AgoraRteImpl() => _instance;

  final AgoraRteCoreImpl _core = AgoraRteCoreImpl.instance;

  AgoraRteImpl._internal();

  /// Create player
  @override
  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) async {
    return await _core.createPlayer(config);
  }

  /// Destroy player
  @override
  Future<void> destroyPlayer(String playerId) async {
    return await _core.destroyPlayer(playerId);
  }

  /// Create canvas
  @override
  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config) async {
    return await _core.createCanvas(config);
  }

  /// Destroy canvas
  @override
  Future<void> destroyCanvas(String canvasId) async {
    return await _core.destroyCanvas(canvasId);
  }

  // /// Preload URL
  // static Future<void> preloadWithUrl(String url) async {
  //   return await AgoraRteCoreImpl.preloadWithUrl(url);
  // }

  // @override
  // Future<void> createFromBridge() async {
  //   return await _core.createFromBridge();
  // }

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

  // @override
  // Future<String> appId() async {
  //   return await _config.appId();
  // }

  // @override
  // Future<String> logFolder() async {
  //   return await _config.logFolder();
  // }

  // @override
  // Future<int> logFileSize() async {
  //   return await _config.logFileSize();
  // }

  // @override
  // Future<int> areaCode() async {
  //   return await _config.areaCode();
  // }

  // @override
  // Future<String> cloudProxy() async {
  //   return await _config.cloudProxy();
  // }

  // @override
  // Future<String> jsonParameter() async {
  //   return await _config.jsonParameter();
  // }

  // @override
  // Future<bool> useStringUid() async {
  //   return await _config.useStringUid();
  // }
}

/// Native stub — same function name used by conditional import in agora_rte_ext.dart.
// ignore: non_constant_identifier_names
AgoraRte createAgoraRteImpl() => AgoraRteImpl.create();
