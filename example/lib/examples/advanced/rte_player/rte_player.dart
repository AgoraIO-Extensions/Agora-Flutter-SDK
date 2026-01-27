import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/material.dart';

import 'rte_canvas_config_tab.dart';
import 'rte_config_tab.dart';
import 'rte_info_log_view.dart';
import 'rte_playback_tab.dart';
import 'rte_player_config_tab.dart';

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
    _rte.destroy();
    logSink.log('[RTE] Disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit || _controllers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: _controllers.length,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: _controllers.map((c) => Tab(text: c.id)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: _controllers
                  .map((ctrl) => _PlayerView(
                        controller: ctrl,
                        rte: _rte,
                      ))
                  .toList(),
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
                  onLog: activeCtrl.addLog,
                  onVolumeChanged: (v) => activeCtrl.setVolume(v),
                  onPlaybackSpeedChanged: (s) => activeCtrl.setPlaybackSpeed(s),
                ),
                RteConfigTab(
                  rte: widget.rte, // Shared engine
                  onLog: (msg) => activeCtrl.addLog('[Config] $msg'),
                ),
                RtePlayerConfigTab(
                  key: ValueKey('pconfig_${activeCtrl.id}'),
                  player: activeCtrl.player,
                  onLog: activeCtrl.addLog,
                  onPlaybackSpeedChanged: (s) => activeCtrl.setPlaybackSpeed(s),
                  onVolumeChanged: (v) => activeCtrl.setVolume(v),
                ),
                RteCanvasConfigTab(
                  key: ValueKey('cconfig_${activeCtrl.id}'),
                  canvas: activeCtrl.canvas,
                  onLog: activeCtrl.addLog,
                ),
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
      volume = rtePlayerConfig.playoutVolume ?? 100;

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
    if (player != null) {
      try {
        final stats = await player!.getStats();
        final info = await player!.getInfo();

        statsNotifier.value = stats;
        playerInfoNotifier.value = info;

        final newDuration = info.duration ?? 0;
        if (duration != newDuration) {
          duration = newDuration;
          onUpdate();
        }
      } catch (e) {
        // debugPrint('Get stats error: $e');
      }
    }
  }

  void addLog(String message) {
    logSink.log('[$id] $message');
    final newLogs = List<String>.from(eventLogsNotifier.value);
    newLogs.insert(
        0, '${DateTime.now().toString().substring(11, 19)}: $message');
    // if (newLogs.length > 100) newLogs.removeLast();
    eventLogsNotifier.value = newLogs;
  }

  void setVolume(int v) {
    volume = v;
    onUpdate();
  }

  void setPlaybackSpeed(int s) {
    playbackSpeed = s;
    onUpdate();
  }

  void dispose() {
    player?.unregisterObserver(this);
    playerInfoNotifier.dispose();
    statsNotifier.dispose();
    eventLogsNotifier.dispose();
  }

  @override
  void onStateChanged(AgoraRtePlayerState oldState,
      AgoraRtePlayerState newState, AgoraRteErrorCode? error) {
    addLog(
        '[$id] State changed: ${oldState.name} -> ${newState.name}${error != null ? ' (Error: ${error.name})' : ''}');
    infoText =
        'State: ${newState.name}${error != null ? ' (Error: ${error.name})' : ''}';
    onUpdate();
  }

  @override
  void onPositionChanged(int currentTime, int utcTime) {
    currentPosition = currentTime;
    onUpdate();
  }

  @override
  void onResolutionChanged(int newWidth, int newHeight) {
    addLog('Resolution changed: ${newWidth}x$newHeight');
    width = newWidth;
    height = newHeight;
    onUpdate();
  }

  @override
  void onEvent(AgoraRtePlayerEvent event) {
    addLog('Event: ${event.name}');
  }

  @override
  void onMetadata(AgoraRtePlayerMetadataType type, Uint8List data) {
    addLog('Metadata: ${type.name}');
  }

  @override
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info) {
    addLog('Info updated: ${info.currentUrl}');
    playerInfoNotifier.value = info;
    final newDuration = info.duration ?? 0;
    if (duration != newDuration) {
      duration = newDuration;
      onUpdate();
    }
  }

  @override
  void onAudioVolumeIndication(int vol) {
    audioVolume = vol;
    onUpdate();
  }
}
