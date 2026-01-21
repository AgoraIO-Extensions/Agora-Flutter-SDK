import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
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

class _RtePlayerExampleState extends State<RtePlayerExample>
    with SingleTickerProviderStateMixin
    implements AgoraRtePlayerObserver {
  late final AgoraRteImpl _rte;
  AgoraRtePlayerImpl? _player;
  AgoraRteCanvasImpl? _canvas;
  bool _isReady = false;
  String _infoText = 'Initializing...';
  late TabController _tabController;

  // Playback state shared with tabs
  int _currentPosition = 0;
  int _duration = 0;
  int _playbackSpeed = 100;
  int _volume = 100;
  
  // Local refresh notifiers
  final ValueNotifier<AgoraRtePlayerInfo?> _playerInfoNotifier =
      ValueNotifier(null);
  final ValueNotifier<AgoraRtePlayerStats?> _statsNotifier =
      ValueNotifier(null);
  final ValueNotifier<List<String>> _eventLogsNotifier = ValueNotifier([]);

  int _width = 0;
  int _height = 0;
  int _audioVolume = 0;

  Timer? _statsTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initRte();
  }

  Future<void> _initRte() async {
    _rte = AgoraRteImpl();
    try {
      await _rte.createWithConfig(AgoraRteConfig(appId: config.appId));
      await _rte.initMediaEngine();

      final player = await _rte.createPlayer(
          const AgoraRtePlayerConfig(autoPlay: true));
      _player = player as AgoraRtePlayerImpl;
      await _player!.registerObserver(this);
      
      // Update initial values
      final speed = await _player!.getPlaybackSpeed();
      final volume = await _player!.getPlayoutVolume();

      final canvas = await _rte.createCanvas(
          const AgoraRteCanvasConfig(videoRenderMode: AgoraRteVideoRenderMode.fit));
      _canvas = canvas as AgoraRteCanvasImpl;

      await _player!.setCanvas(_canvas!);
      logSink.log('Player canvas set: ${_canvas!.canvasId}');

      setState(() {
        _isReady = true;
        _infoText = 'RTE Ready';
        _playbackSpeed = speed;
        _volume = volume;
      });
      
      _startStatsTimer();

    } catch (e) {
      logSink.log('Error: $e');
      setState(() {
        _infoText = 'Error: $e';
      });
    }
  }

  void _startStatsTimer() {
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_player != null) {
        try {
          final stats = await _player!.getStats();
          final info = await _player!.getInfo();

          // Update notifiers for local refresh
          _statsNotifier.value = stats;
          _playerInfoNotifier.value = info;

          // Only setState if duration changed (to update slider)
          if (_duration != info.duration) {
            setState(() {
              _duration = info.duration;
            });
          }
        } catch (e) {
          debugPrint('Get stats/info error: $e');
        }
      }
    });
  }

  void _addLog(String message) {
    // Also log to logSink for consistency
    logSink.log(message);

    // Update notifier list efficiently
    final newLogs = List<String>.from(_eventLogsNotifier.value);
    newLogs.insert(
          0, '${DateTime.now().toString().substring(11, 19)}: $message');
    // if (newLogs.length > 50) {
    //   newLogs.removeLast();
    // }
    _eventLogsNotifier.value = newLogs;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _statsTimer?.cancel();
    _player?.unregisterObserver(this);
    _rte.destroy();
    
    // Dispose notifiers
    _playerInfoNotifier.dispose();
    _statsNotifier.dispose();
    _eventLogsNotifier.dispose();
    
    super.dispose();
  }

  // ========== Observer Callbacks ==========
  @override
  void onStateChanged(AgoraRtePlayerState oldState,
      AgoraRtePlayerState newState, AgoraRteErrorCode? error) {
    debugPrint('RTE State: $oldState -> $newState, error: $error');
    _addLog('State: $oldState -> $newState${error != null ? ' (Error: $error)' : ''}');
    setState(() {
      _infoText =
          'State: ${newState.name}${error != null ? ' (Error: $error)' : ''}';
    });
  }

  @override
  void onPositionChanged(int currentTime, int utcTime) {
    setState(() {
      _currentPosition = currentTime;
    });
  }

  @override
  void onResolutionChanged(int width, int height) {
    debugPrint('RTE Resolution: $width x $height');
    _addLog('Resolution changed: ${width}x$height');
    setState(() {
      _width = width;
      _height = height;
    });
  }

  @override
  void onEvent(AgoraRtePlayerEvent event) {
    debugPrint('RTE Event: $event');
    _addLog('Event: ${event.name}');
  }

  @override
  void onMetadata(AgoraRtePlayerMetadataType type, dynamic data) {
    debugPrint('RTE Metadata: $type');
    _addLog('Metadata: ${type.name}');
  }

  @override
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info) {
    debugPrint('RTE Info Updated: ${info.currentUrl}');
    _addLog('Info updated: ${info.currentUrl}');
    
    // Update notifier
    _playerInfoNotifier.value = info;

    // Check if duration changed
    if (_duration != info.duration) {
      setState(() {
        _duration = info.duration;
      });
    }
  }

  @override
  void onAudioVolumeIndication(int volume) {
    setState(() {
      _audioVolume = volume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showInfoLogDialog(context),
        child: const Icon(Icons.info_outline),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
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
                  player: _player,
                  canvas: _canvas,
                  isReady: _isReady,
                  infoText: _infoText,
                  width: _width,
                  height: _height,
                  currentPosition: _currentPosition,
                  duration: _duration,
                  playbackSpeed: _playbackSpeed,
                  volume: _volume,
                  audioVolume: _audioVolume,
                  onLog: _addLog,
                  onVolumeChanged: (v) {
                    setState(() {
                      _volume = v;
                    });
                  },
                  onPlaybackSpeedChanged: (s) {
                    setState(() {
                      _playbackSpeed = s;
                    });
                  },
                ),
                RteConfigTab(
                  rte: _rte,
                  onLog: _addLog,
                ),
                RtePlayerConfigTab(
                  player: _player,
                  onLog: _addLog,
                  onPlaybackSpeedChanged: (s) {
                    setState(() {
                      _playbackSpeed = s;
                    });
                  },
                  onVolumeChanged: (v) {
                    setState(() {
                      _volume = v;
                    });
                  },
                ),
                RteCanvasConfigTab(
                  canvas: _canvas,
                  onLog: _addLog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoLogDialog(BuildContext context) {
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
              // Title bar
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
                    const Text(
                      'Info Logs',
                      style: TextStyle(
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
              // Content area
              Expanded(
                child: RteInfoLogView(
                  statsNotifier: _statsNotifier,
                  playerInfoNotifier: _playerInfoNotifier,
                  eventLogsNotifier: _eventLogsNotifier,
                  onClearLogs: () {
                    _eventLogsNotifier.value = [];
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
