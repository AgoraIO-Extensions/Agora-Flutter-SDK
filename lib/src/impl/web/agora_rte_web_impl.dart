import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/agora_rte_canvas_config.dart';
import 'package:agora_rtc_engine/src/agora_rte_config.dart';
import 'package:agora_rtc_engine/src/agora_rte_player_config.dart';
import 'agora_rte_core_web_impl.dart';

/// Web entry point — same function name as the native stub.
AgoraRte createAgoraRteImpl() => AgoraRteWebImpl.create();

class AgoraRteWebImpl implements AgoraRte {
  static final AgoraRteWebImpl _instance = AgoraRteWebImpl._internal();
  static AgoraRteWebImpl create() => _instance;

  factory AgoraRteWebImpl() => _instance;

  final AgoraRteCoreWebImpl _core = AgoraRteCoreWebImpl.instance;

  AgoraRteWebImpl._internal();


  @override
  Future<void> createWithConfig(AgoraRteConfig config) =>
      _core.createWithConfig(config);

  @override
  Future<void> initMediaEngine() => _core.initMediaEngine();

  @override
  Future<void> destroy() => _core.destroy();

  @override
  Future<void> setConfigs(AgoraRteConfig config) => _core.setConfigs(config);

  @override
  Future<AgoraRteConfig> getConfigs() => _core.getConfigs();

  @override
  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) =>
      _core.createPlayer(config);

  @override
  Future<void> destroyPlayer(String playerId) => _core.destroyPlayer(playerId);

  @override
  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config) =>
      _core.createCanvas(config);

  @override
  Future<void> destroyCanvas(String canvasId) => _core.destroyCanvas(canvasId);
}
