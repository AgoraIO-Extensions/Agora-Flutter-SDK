import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_canvas_config_tab.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_config_tab.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_info_log_view.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_playback_tab.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_player_config_tab.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_test_tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_web_customizers.dart'
    if (dart.library.io) 'package:agora_rtc_engine_example/examples/advanced/rte_player/rte_web_customizers_stub.dart'
    as web_customizers;

class RtePlayerExample extends StatefulWidget {
  const RtePlayerExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RtePlayerExampleState();
}

class _RtePlayerExampleState extends State<RtePlayerExample> {
  late final AgoraRte _rte;
  Timer? _statsTimer;

  final List<_PlayerController> _controllers = [];
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _initRte();
  }

  Future<void> _initRte() async {
    _rte = createAgoraRte();
    try {
      try {
        await _rte.destroy();
      } catch (_) {}
      await _rte.createWithConfig(AgoraRteConfig(appId: config.appId));
      await _rte.initMediaEngine();

      final c1 = _PlayerController('Player 1', _onControllerUpdate);
      final c2 = _PlayerController('Player 2', _onControllerUpdate);
      _controllers.addAll([c1, c2]);

      // Initialize sequentially
      await c1.init(_rte);
      await c2.init(_rte);

      _startStatsTimer();

      setState(() {
        _isInit = true;
      });
      logSink.log('[RTE] Initialization completed successfully');
    } catch (e, stackTrace) {
      logSink.log('[RTE] Init Error: $e');
      logSink.log('[RTE] Stack trace: $stackTrace');
    }
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  void _startStatsTimer() {
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      for (final ctrl in _controllers) {
        ctrl.updateStats();
      }
    });
  }

  @override
  void dispose() {
    _statsTimer?.cancel();
    for (final ctrl in _controllers) {
      ctrl.dispose();
    }
    _rte.destroy(); // Fire-and-forget; re-entry uses destroy-before-create in _initRte
    logSink.log('[RTE] Disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit || _controllers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: _controllers.length + 1,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                ..._controllers.map((c) => Tab(text: c.id)),
                const Tab(text: 'Test'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ..._controllers.map((ctrl) => _PlayerView(
                      controller: ctrl,
                      rte: _rte,
                    )),
                const RteTestTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerView extends StatefulWidget {
  final _PlayerController controller;
  final AgoraRte rte;

  const _PlayerView({
    Key? key,
    required this.controller,
    required this.rte,
  }) : super(key: key);

  @override
  State<_PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<_PlayerView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Widget? _cachedRteConfigTab;
  Widget? _cachedPlayerConfigTab;
  Widget? _cachedCanvasConfigTab;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _buildCachedConfigTabs();
  }

  void _buildCachedConfigTabs() {
    final activeCtrl = widget.controller;
    _cachedRteConfigTab = RteConfigTab(
      key: ValueKey('rteconfig_${activeCtrl.id}'),
      rte: widget.rte, // Shared engine
      onLog: (msg) => activeCtrl.addLog('[Config] $msg'),
    );
    _cachedPlayerConfigTab = RtePlayerConfigTab(
      key: ValueKey('pconfig_${activeCtrl.id}'),
      player: activeCtrl.player,
      onLog: activeCtrl.addLog,
      onPlaybackSpeedChanged: (s) => activeCtrl.setPlaybackSpeed(s),
      onVolumeChanged: (v) => activeCtrl.setVolume(v),
      onEnableAudioVolumeLogChanged: (enable) =>
          activeCtrl.setEnableAudioVolumeLog(enable),
    );
    _cachedCanvasConfigTab = RteCanvasConfigTab(
      key: ValueKey('cconfig_${activeCtrl.id}'),
      canvas: activeCtrl.canvas,
      onLog: activeCtrl.addLog,
    );
  }

  @override
  void didUpdateWidget(covariant _PlayerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only rebuild cached config tabs if controller changed
    if (oldWidget.controller != widget.controller) {
      _buildCachedConfigTabs();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeCtrl = widget.controller;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_${activeCtrl.id}',
        onPressed: () => _showInfoLogDialog(context, activeCtrl),
        child: const Icon(Icons.info_outline),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black54,
            tabs: const [
              Tab(text: 'Playback Control'),
              Tab(text: 'RTE Config'),
              Tab(text: 'Player Config'),
              Tab(text: 'Canvas Config'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RtePlaybackTab(
                  key: ValueKey('playback_${activeCtrl.id}'),
                  player: activeCtrl.player,
                  canvas: activeCtrl.canvas,
                  isReady: activeCtrl.isReady,
                  infoText: activeCtrl.infoText,
                  width: activeCtrl.width,
                  height: activeCtrl.height,
                  currentPosition: activeCtrl.currentPosition,
                  duration: activeCtrl.duration,
                  playbackSpeed: activeCtrl.playbackSpeed,
                  volume: activeCtrl.volume,
                  audioVolume: activeCtrl.audioVolume,
                  isPlaying: AgoraRtePlayerState.values[
                          activeCtrl.playerInfoNotifier.value?.state ?? 0] ==
                      AgoraRtePlayerState.playing,
                  onLog: activeCtrl.addLog,
                  onVolumeChanged: (v) => activeCtrl.setVolume(v),
                  onPlaybackSpeedChanged: (s) => activeCtrl.setPlaybackSpeed(s),
                  wrapperCustomizer:
                      kIsWeb ? web_customizers.RteWebCustomizers.wrapper : null,
                  styleCustomizer:
                      kIsWeb ? web_customizers.RteWebCustomizers.style : null,
                  videoCustomizer:
                      kIsWeb ? web_customizers.RteWebCustomizers.video : null,
                ),
                _cachedRteConfigTab!,
                _cachedPlayerConfigTab!,
                _cachedCanvasConfigTab!,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoLogDialog(BuildContext context, _PlayerController ctrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${ctrl.id} Info Logs',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RteInfoLogView(
                  statsNotifier: ctrl.statsNotifier,
                  playerInfoNotifier: ctrl.playerInfoNotifier,
                  eventLogsNotifier: ctrl.eventLogsNotifier,
                  onClearLogs: () {
                    ctrl.eventLogsNotifier.value = [];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerController implements AgoraRtePlayerObserver {
  final String id;
  final VoidCallback onUpdate;

  AgoraRtePlayer? player;
  AgoraRteCanvas? canvas;

  String infoText = 'Initializing...';
  bool isReady = false;
  int currentPosition = 0;
  int duration = 0;
  int width = 0;
  int height = 0;
  int audioVolume = 0;

  int? playbackSpeed = 100;
  int? volume = 100;

  bool _enableAudioVolumeLog = false;
  bool _disposed = false;

  final ValueNotifier<AgoraRtePlayerInfo?> playerInfoNotifier =
      ValueNotifier(null);
  final ValueNotifier<AgoraRtePlayerStats?> statsNotifier = ValueNotifier(null);
  final ValueNotifier<List<String>> eventLogsNotifier = ValueNotifier([]);

  _PlayerController(this.id, this.onUpdate);

  Future<void> init(AgoraRte rte) async {
    try {
      player =
          await rte.createPlayer(const AgoraRtePlayerConfig(autoPlay: true));
      await player!.registerObserver(this);

      final rtePlayerConfig = await player!.getConfigs();
      playbackSpeed = rtePlayerConfig.playbackSpeed ?? 100;
      final configVolume = rtePlayerConfig.playoutVolume ?? 100;
      volume = configVolume.clamp(0, 400);

      canvas = await rte.createCanvas(const AgoraRteCanvasConfig(
          videoRenderMode: AgoraRteVideoRenderMode.fit));

      await player!.setCanvas(canvas!);
      addLog('Canvas set: ${canvas!.canvasId}');

      isReady = true;
      infoText = 'RTE Ready';
      addLog('[$id] Ready');
      onUpdate();
    } catch (e, stackTrace) {
      infoText = 'Init Error: $e';
      addLog('[$id] Init Error: $e');
      addLog('[$id] Stack: $stackTrace');
      onUpdate();
    }
  }

  void updateStats() async {
    if (_disposed || player == null) return;
    try {
      final stats = await player!.getStats();
      final info = await player!.getInfo();

      statsNotifier.value = stats;
      playerInfoNotifier.value = info;

      final newDuration = info.duration ?? 0;
      if (duration != newDuration) {
        duration = newDuration;
        _controllerUpdateFromObserver();
      }
    } catch (e) {
      // debugPrint('Get stats error: $e');
    }
  }

  void addLog(String message) {
    if (_disposed) return;
    logSink.log('[$id] $message');
    final newLogs = List<String>.from(eventLogsNotifier.value);
    newLogs.insert(
        0, '${DateTime.now().toString().substring(11, 19)}: $message');
    // if (newLogs.length > 100) newLogs.removeLast();
    eventLogsNotifier.value = newLogs;
  }

  void setVolume(int v) {
    volume = v.clamp(0, 400);
    onUpdate();
  }

  void setPlaybackSpeed(int s) {
    playbackSpeed = s;
    onUpdate();
  }

  void setEnableAudioVolumeLog(bool enable) {
    _enableAudioVolumeLog = enable;
  }

  void _controllerUpdateFromObserver() {
    if (_disposed) return;
    onUpdate();
  }

  void dispose() {
    _disposed = true;
    player?.unregisterObserver(this);
    playerInfoNotifier.dispose();
    statsNotifier.dispose();
    eventLogsNotifier.dispose();
  }

  @override
  void onStateChanged(AgoraRtePlayerState oldState,
      AgoraRtePlayerState newState, AgoraRteErrorCode? error) {
    addLog(
        'playerObserver [$id] onStateChanged: ${oldState.name} -> ${newState.name}${error != null ? ' (Error: ${error.name})' : ''}');
    infoText =
        'State: ${newState.name}${error != null ? ' (Error: ${error.name})' : ''}';
    _controllerUpdateFromObserver();
  }

  @override
  void onPositionChanged(int currentTime, int utcTime) {
    addLog('playerObserver onPositionChanged: $currentTime');
    currentPosition = currentTime;
    _controllerUpdateFromObserver();
  }

  @override
  void onResolutionChanged(int newWidth, int newHeight) {
    addLog('playerObserver onResolutionChanged: ${newWidth}x$newHeight');
    width = newWidth;
    height = newHeight;
    _controllerUpdateFromObserver();
  }

  @override
  void onEvent(AgoraRtePlayerEvent event) {
    addLog('playerObserver onEvent: ${event.name}');
  }

  @override
  void onMetadata(AgoraRtePlayerMetadataType type, Uint8List data) {
    // Decode metadata content for better visibility
    String decodedContent = '';
    String hexContent = '';

    if (data.isNotEmpty) {
      // Try to decode as UTF-8 string
      try {
        decodedContent = utf8.decode(data, allowMalformed: true);
        // Check if it's valid printable text
        final isPrintable = decodedContent.codeUnits.every((code) =>
            (code >= 32 && code <= 126) ||
            code == 9 ||
            code == 10 ||
            code == 13);
        if (!isPrintable || decodedContent.trim().isEmpty) {
          decodedContent = '';
        }
      } catch (e) {
        decodedContent = '';
      }

      // Convert to hex string for binary data
      final maxHexBytes = data.length > 64 ? 64 : data.length;
      final hexBuffer = StringBuffer();
      for (int i = 0; i < maxHexBytes; i++) {
        hexBuffer
            .write(data[i].toRadixString(16).padLeft(2, '0').toUpperCase());
        hexBuffer.write(' ');
        if ((i + 1) % 16 == 0) {
          hexBuffer.writeln();
        }
      }
      if (data.length > maxHexBytes) {
        hexBuffer.write('... (${data.length} bytes total)');
      }
      hexContent = hexBuffer.toString();
    }

    // Log decoded content
    final logMessage = StringBuffer();
    logMessage.write(
        'playerObserver onMetadata: ${type.name}, length: ${data.length}');
    if (decodedContent.isNotEmpty) {
      logMessage.write('\n  Decoded (UTF-8): $decodedContent');
    }
    if (hexContent.isNotEmpty) {
      logMessage.write('\n  Hex: $hexContent');
    }
    addLog(logMessage.toString());
  }

  @override
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info) {
    if (_disposed) return;
    addLog('playerObserver onPlayerInfoUpdated: ${info.toJson()}');
    playerInfoNotifier.value = info;
    final newDuration = info.duration ?? 0;
    if (duration != newDuration) {
      duration = newDuration;
      _controllerUpdateFromObserver();
    }
  }

  @override
  void onAudioVolumeIndication(int vol) {
    if (_enableAudioVolumeLog) {
      addLog('playerObserver onAudioVolumeIndication: $vol');
    }
    audioVolume = vol;
    _controllerUpdateFromObserver();
  }
}
