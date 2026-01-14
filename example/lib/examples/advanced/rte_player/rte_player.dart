import 'dart:async';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/impl/agora_rte_impl.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/material.dart';

class RtePlayerExample extends StatefulWidget {
  const RtePlayerExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RtePlayerExampleState();
}

class _RtePlayerExampleState extends State<RtePlayerExample>
    implements AgoraRtePlayerObserver {
  late final AgoraRte _rte;
  AgoraRtePlayer? _player;
  AgoraRteCanvas? _canvas;
  bool _isReady = false;
  String _infoText = 'Initializing...';
  // 注意：RTE Player 仅支持 rte:// 协议的 URL
  // URL 格式示例：rte://your_channel_id?token=your_token&uid=your_uid
  // 不支持 HTTP/HTTPS/RTMP/RTSP 等协议
  final TextEditingController _urlController =
      TextEditingController(text: 'rte://your_channel_id?token=xxx&uid=xxx');
  final TextEditingController _switchUrlController =
      TextEditingController(text: 'rte://your_channel_id_2?token=xxx&uid=xxx');
  
  // 播放状态
  int _currentPosition = 0;
  int _duration = 0;
  int _playbackSpeed = 100; // 100 = 1.0x
  int _volume = 100;
  bool _isAudioMuted = false;
  bool _isVideoMuted = false;
  
  // 播放器信息
  AgoraRtePlayerInfo? _playerInfo;
  AgoraRtePlayerStats? _stats;
  int _width = 0;
  int _height = 0;
  int _audioVolume = 0;
  
  // 事件日志
  final List<String> _eventLogs = [];
  Timer? _positionTimer;
  Timer? _statsTimer;

  @override
  void initState() {
    super.initState();
    _initRte();
  }

  Future<void> _initRte() async {
    _rte = AgoraRteImpl();
    try {
      await _rte.createWithConfig(AgoraRteConfig(appId: config.appId));
      await _rte.initMediaEngine();

      final player = await (_rte as AgoraRteImpl)
          .createPlayer(const AgoraRtePlayerConfig(autoPlay: true));
      _player = player;
      await _player!.registerObserver(this);

      final canvas =
          await (_rte as AgoraRteImpl).createCanvas(const AgoraRteCanvasConfig(
        videoRenderMode: AgoraRteVideoRenderMode.fit,
      ));
      _canvas = canvas;

      await _player!.setCanvas(_canvas!);

      setState(() {
        _isReady = true;
        _infoText = 'RTE Ready';
      });
    } catch (e) {
      setState(() {
        _infoText = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    _statsTimer?.cancel();
    _player?.unregisterObserver(this);
    _rte.destroy();
    super.dispose();
  }

  Future<void> _onOpen() async {
    if (_player == null) return;
    
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() {
        _infoText = 'Error: URL 不能为空';
      });
      _addLog('Error: URL is empty');
      return;
    }
    
    // 验证 URL 格式（简单检查）
    if (!url.startsWith('rte://')) {
      setState(() {
        _infoText = 'Error: URL 必须以 rte:// 开头';
      });
      _addLog('Error: URL must start with rte://');
      return;
    }
    
    try {
      setState(() {
        _infoText = 'Opening...';
        _eventLogs.clear();
      });
      _addLog('Opening URL: $url');
      await _player!.openWithUrl(url, 0);
      _startPositionTimer();
      _startStatsTimer();
    } catch (e) {
      setState(() {
        _infoText = 'Open Error: $e';
      });
      _addLog('Open error: $e');
    }
  }
  
  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_player != null) {
        try {
          final position = await _player!.getPosition();
          setState(() {
            _currentPosition = position;
          });
        } catch (e) {
          debugPrint('Get position error: $e');
        }
      }
    });
  }
  
  void _startStatsTimer() {
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_player != null) {
        try {
          final stats = await _player!.getStats();
          final info = await _player!.getInfo();
          setState(() {
            _stats = stats;
            _playerInfo = info;
            _duration = info.duration;
          });
        } catch (e) {
          debugPrint('Get stats/info error: $e');
        }
      }
    });
  }
  
  void _addLog(String message) {
    setState(() {
      _eventLogs.insert(0, '${DateTime.now().toString().substring(11, 19)}: $message');
      if (_eventLogs.length > 50) {
        _eventLogs.removeLast();
      }
    });
  }
  
  Future<void> _onSeek(double value) async {
    if (_player == null) return;
    try {
      await _player!.seek(value.toInt());
      _addLog('Seek to ${value.toInt()}ms');
    } catch (e) {
      _addLog('Seek error: $e');
    }
  }
  
  Future<void> _onSetPlaybackSpeed(int speed) async {
    if (_player == null) return;
    try {
      await _player!.setConfigs(AgoraRtePlayerConfig(playbackSpeed: speed));
      setState(() {
        _playbackSpeed = speed;
      });
      _addLog('Set playback speed to ${speed / 100.0}x');
    } catch (e) {
      _addLog('Set playback speed error: $e');
    }
  }
  
  Future<void> _onSetVolume(int volume) async {
    if (_player == null) return;
    try {
      await _player!.setConfigs(AgoraRtePlayerConfig(playoutVolume: volume));
      setState(() {
        _volume = volume;
      });
      _addLog('Set volume to $volume');
    } catch (e) {
      _addLog('Set volume error: $e');
    }
  }
  
  Future<void> _onSetLoopCount(int count) async {
    if (_player == null) return;
    try {
      await _player!.setConfigs(AgoraRtePlayerConfig(loopCount: count));
      _addLog('Set loop count to $count');
    } catch (e) {
      _addLog('Set loop count error: $e');
    }
  }
  
  Future<void> _onSwitchUrl() async {
    if (_player == null) return;
    try {
      await _player!.switchWithUrl(_switchUrlController.text, true);
      _addLog('Switch URL to ${_switchUrlController.text}');
    } catch (e) {
      _addLog('Switch URL error: $e');
    }
  }
  
  Future<void> _onMuteAudio() async {
    if (_player == null) return;
    try {
      await _player!.muteAudio(!_isAudioMuted);
      setState(() {
        _isAudioMuted = !_isAudioMuted;
      });
      _addLog('Audio ${_isAudioMuted ? 'muted' : 'unmuted'}');
    } catch (e) {
      _addLog('Mute audio error: $e');
    }
  }
  
  Future<void> _onMuteVideo() async {
    if (_player == null) return;
    try {
      await _player!.muteVideo(!_isVideoMuted);
      setState(() {
        _isVideoMuted = !_isVideoMuted;
      });
      _addLog('Video ${_isVideoMuted ? 'muted' : 'unmuted'}');
    } catch (e) {
      _addLog('Mute video error: $e');
    }
  }
  
  String _formatTime(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

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
    setState(() {
      _playerInfo = info;
      _duration = info.duration;
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // URL 输入
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      labelText: 'RTE URL',
                      hintText: 'rte://your_channel_id?token=xxx&uid=xxx',
                      border: OutlineInputBorder(),
                      helperText: '仅支持 rte:// 协议，不支持 HTTP/HTTPS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '注意：RTE Player 目前仅支持 rte:// 协议的 URL。\n'
                      'URL 格式：rte://channel_id?token=xxx&uid=xxx\n'
                      '请使用有效的 RTE URL，不能使用普通的 HTTP/HTTPS URL。',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _isReady ? _onOpen : null,
              child: const Text('Open & Play'),
            ),
            
            // 视频显示区域
            Container(
              height: 200,
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _infoText,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    if (_width > 0 && _height > 0)
                      Text(
                        '${_width}x$_height',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
            
            // 播放进度
            if (_duration > 0) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Slider(
                      value: _currentPosition.toDouble(),
                      min: 0,
                      max: _duration.toDouble(),
                      onChanged: _onSeek,
                      label: _formatTime(_currentPosition),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatTime(_currentPosition)),
                        Text(_formatTime(_duration)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            
            // 基本控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    _player?.play();
                    _addLog('Play');
                  },
                  icon: const Icon(Icons.play_arrow),
                  tooltip: 'Play',
                ),
                IconButton(
                  onPressed: () {
                    _player?.pause();
                    _addLog('Pause');
                  },
                  icon: const Icon(Icons.pause),
                  tooltip: 'Pause',
                ),
                IconButton(
                  onPressed: () {
                    _player?.stop();
                    _addLog('Stop');
                    _positionTimer?.cancel();
                    _statsTimer?.cancel();
                  },
                  icon: const Icon(Icons.stop),
                  tooltip: 'Stop',
                ),
                IconButton(
                  onPressed: _onMuteAudio,
                  icon: Icon(_isAudioMuted ? Icons.volume_off : Icons.volume_up),
                  tooltip: _isAudioMuted ? 'Unmute Audio' : 'Mute Audio',
                ),
                IconButton(
                  onPressed: _onMuteVideo,
                  icon: Icon(_isVideoMuted ? Icons.videocam_off : Icons.videocam),
                  tooltip: _isVideoMuted ? 'Unmute Video' : 'Mute Video',
                ),
              ],
            ),
            
            // 播放速度控制
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Playback Speed: ${_playbackSpeed / 100.0}x'),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => _onSetPlaybackSpeed(50),
                        child: const Text('0.5x'),
                      ),
                      TextButton(
                        onPressed: () => _onSetPlaybackSpeed(100),
                        child: const Text('1.0x'),
                      ),
                      TextButton(
                        onPressed: () => _onSetPlaybackSpeed(150),
                        child: const Text('1.5x'),
                      ),
                      TextButton(
                        onPressed: () => _onSetPlaybackSpeed(200),
                        child: const Text('2.0x'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 音量控制
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Volume: $_volume'),
                  Slider(
                    value: _volume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: '$_volume',
                    onChanged: (value) => _onSetVolume(value.toInt()),
                  ),
                  if (_audioVolume > 0)
                    Text('Audio Volume Indication: $_audioVolume',
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            
            // 循环播放
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Loop Count: '),
                  TextButton(
                    onPressed: () => _onSetLoopCount(0),
                    child: const Text('0 (No Loop)'),
                  ),
                  TextButton(
                    onPressed: () => _onSetLoopCount(1),
                    child: const Text('1'),
                  ),
                  TextButton(
                    onPressed: () => _onSetLoopCount(-1),
                    child: const Text('-1 (Infinite)'),
                  ),
                ],
              ),
            ),
            
            // 切换 URL
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _switchUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Switch URL',
                            hintText: 'rte://channel_id?token=xxx&uid=xxx',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onSwitchUrl,
                        child: const Text('Switch'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      '切换到新的 RTE URL（仅支持 rte:// 协议）',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            
            // 统计信息
            if (_stats != null)
              Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Statistics:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Video Decode FPS: ${_stats!.videoDecodeFrameRate}'),
                      Text('Video Render FPS: ${_stats!.videoRenderFrameRate}'),
                      Text('Video Bitrate: ${_stats!.videoBitrate} bps'),
                      Text('Audio Bitrate: ${_stats!.audioBitrate} bps'),
                    ],
                  ),
                ),
              ),
            
            // 播放器信息
            if (_playerInfo != null)
              Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Player Info:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('State: ${AgoraRtePlayerState.values[_playerInfo!.state].name}'),
                      Text('Duration: ${_formatTime(_playerInfo!.duration)}'),
                      Text('Stream Count: ${_playerInfo!.streamCount}'),
                      Text('Has Audio: ${_playerInfo!.hasAudio}'),
                      Text('Has Video: ${_playerInfo!.hasVideo}'),
                      Text('Audio Muted: ${_playerInfo!.isAudioMuted}'),
                      Text('Video Muted: ${_playerInfo!.isVideoMuted}'),
                      if (_playerInfo!.videoWidth > 0 && _playerInfo!.videoHeight > 0)
                        Text('Video Size: ${_playerInfo!.videoWidth}x${_playerInfo!.videoHeight}'),
                      if (_playerInfo!.currentUrl.isNotEmpty)
                        Text('Current URL: ${_playerInfo!.currentUrl}'),
                    ],
                  ),
                ),
              ),
            
            // 事件日志
            Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Event Logs:', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _eventLogs.clear();
                            });
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: _eventLogs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            _eventLogs[index],
                            style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('RTE Player Info'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Player ID: ${_player?.playerId ?? "N/A"}'),
              Text('Canvas ID: ${_canvas?.canvasId ?? "N/A"}'),
              Text('Ready: $_isReady'),
              if (_playerInfo != null) ...[
                const SizedBox(height: 8),
                const Text('Player Info:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('State: ${AgoraRtePlayerState.values[_playerInfo!.state].name}'),
                Text('Duration: ${_formatTime(_playerInfo!.duration)}'),
                Text('Current URL: ${_playerInfo!.currentUrl}'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
