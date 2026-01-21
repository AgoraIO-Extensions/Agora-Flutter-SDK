import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class RtePlaybackTab extends StatefulWidget {
  final AgoraRtePlayerImpl? player;
  final AgoraRteCanvasImpl? canvas;
  final bool isReady;
  final String infoText;
  final int width;
  final int height;
  final int currentPosition;
  final int duration;
  final int playbackSpeed;
  final int volume;
  final int audioVolume;
  final Function(String) onLog;
  final Function(int) onVolumeChanged;
  final Function(int) onPlaybackSpeedChanged;

  const RtePlaybackTab({
    Key? key,
    this.player,
    this.canvas,
    required this.isReady,
    required this.infoText,
    required this.width,
    required this.height,
    required this.currentPosition,
    required this.duration,
    required this.playbackSpeed,
    required this.volume,
    required this.audioVolume,
    required this.onLog,
    required this.onVolumeChanged,
    required this.onPlaybackSpeedChanged,
  }) : super(key: key);

  @override
  State<RtePlaybackTab> createState() => _RtePlaybackTabState();
}

class _RtePlaybackTabState extends State<RtePlaybackTab> {
  final TextEditingController _urlController = TextEditingController(
      text:
          'https://rtc-fallback-test.agoramdn.com/857c6564e7db469387eb44205f287b9a/zzytest.m3u8?token=857c6564e7db469387eb44205f287b9a&userUid=7788');
  final TextEditingController _switchUrlController =
      TextEditingController(text: 'rte://your_channel_id_2?token=xxx&uid=xxx');
  final TextEditingController _preloadUrlController =
      TextEditingController(text: 'rte://your_channel_id?token=xxx&uid=xxx');

  bool _isAudioMuted = false;
  bool _isVideoMuted = false;

  @override
  void dispose() {
    _urlController.dispose();
    _switchUrlController.dispose();
    _preloadUrlController.dispose();
    super.dispose();
  }

  Future<void> _onOpen() async {
    if (widget.player == null) return;

    final url = _urlController.text.trim();
    if (url.isEmpty) {
      widget.onLog('Error: URL is empty');
      return;
    }

    try {
      widget.onLog('Opening URL: $url');
      await widget.player!.openWithUrl(url, 0);
    } catch (e) {
      widget.onLog('Open error: $e');
    }
  }

  Future<void> _onPreloadUrl() async {
    final url = _preloadUrlController.text.trim();
    if (url.isEmpty || !url.startsWith('rte://')) {
      widget.onLog('Error: Invalid preload URL');
      return;
    }
    try {
      await AgoraRteImpl.preloadWithUrl(url);
      widget.onLog('Preload URL: $url');
    } catch (e) {
      widget.onLog('Preload URL error: $e');
    }
  }

  Future<void> _onSwitchUrl() async {
    if (widget.player == null) return;
    try {
      await widget.player!.switchWithUrl(_switchUrlController.text, true);
      widget.onLog('Switch URL to ${_switchUrlController.text}');
    } catch (e) {
      widget.onLog('Switch URL error: $e');
    }
  }

  Future<void> _onSeek(double value) async {
    if (widget.player == null) return;
    try {
      await widget.player!.seek(value.toInt());
      widget.onLog('Seek to ${value.toInt()}ms');
    } catch (e) {
      widget.onLog('Seek error: $e');
    }
  }

  Future<void> _onMuteAudio() async {
    if (widget.player == null) return;
    try {
      await widget.player!.muteAudio(!_isAudioMuted);
      setState(() {
        _isAudioMuted = !_isAudioMuted;
      });
      widget.onLog('Audio ${_isAudioMuted ? 'muted' : 'unmuted'}');
    } catch (e) {
      widget.onLog('Mute audio error: $e');
    }
  }

  Future<void> _onMuteVideo() async {
    if (widget.player == null) return;
    try {
      await widget.player!.muteVideo(!_isVideoMuted);
      setState(() {
        _isVideoMuted = !_isVideoMuted;
      });
      widget.onLog('Video ${_isVideoMuted ? 'muted' : 'unmuted'}');
    } catch (e) {
      widget.onLog('Mute video error: $e');
    }
  }

  Future<void> _setPlayerPlaybackSpeed(int speed) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setPlaybackSpeed(speed);
      widget.onPlaybackSpeedChanged(speed);
      widget.onLog('Set PlaybackSpeed: ${speed / 100.0}x');
    } catch (e) {
      widget.onLog('Set PlaybackSpeed error: $e');
    }
  }

  Future<void> _setPlayerPlayoutVolume(int volume) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setPlayoutVolume(volume);
      widget.onVolumeChanged(volume);
      widget.onLog('Set PlayoutVolume: $volume');
    } catch (e) {
      widget.onLog('Set PlayoutVolume error: $e');
    }
  }

  String _formatTime(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // URL input
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
                      helperText: 'Only rte:// protocol is supported',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Note: RTE Player currently only supports URLs with rte:// protocol.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: widget.isReady ? _onOpen : null,
              child: const Text('Open & Play'),
            ),

            // Video display area - using AgoraRteVideoView from SDK
            Container(
              height: 200,
              color: Colors.black,
              child: Stack(
                children: [
                  if (widget.isReady && widget.canvas != null)
                    AgoraRteVideoView(
                      canvas: widget.canvas,
                      player: widget.player,
                      onLog: widget.onLog,
                      onViewCreated: () {
                        widget.onLog('AgoraRteVideoView created');
                      },
                    )
                  else
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "infoText:${widget.infoText}, width:${widget.width}, height:${widget.height}",
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          if (widget.width > 0 && widget.height > 0)
                            Text(
                              '${widget.width}x${widget.height}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Playback progress
            if (widget.duration > 0) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Slider(
                      value: widget.currentPosition.toDouble(),
                      min: 0,
                      max: widget.duration.toDouble(),
                      onChanged: _onSeek,
                      label: _formatTime(widget.currentPosition),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatTime(widget.currentPosition)),
                        Text(_formatTime(widget.duration)),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Basic control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    widget.player?.play();
                    widget.onLog('Play');
                  },
                  icon: const Icon(Icons.play_arrow),
                  tooltip: 'Play',
                ),
                IconButton(
                  onPressed: () {
                    widget.player?.pause();
                    widget.onLog('Pause');
                  },
                  icon: const Icon(Icons.pause),
                  tooltip: 'Pause',
                ),
                IconButton(
                  onPressed: () {
                    widget.player?.stop();
                    widget.onLog('Stop');
                  },
                  icon: const Icon(Icons.stop),
                  tooltip: 'Stop',
                ),
                IconButton(
                  onPressed: _onMuteAudio,
                  icon:
                      Icon(_isAudioMuted ? Icons.volume_off : Icons.volume_up),
                  tooltip: _isAudioMuted ? 'Unmute Audio' : 'Mute Audio',
                ),
                IconButton(
                  onPressed: _onMuteVideo,
                  icon:
                      Icon(_isVideoMuted ? Icons.videocam_off : Icons.videocam),
                  tooltip: _isVideoMuted ? 'Unmute Video' : 'Mute Video',
                ),
              ],
            ),

            // Playback speed control
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Playback Speed: ${widget.playbackSpeed / 100.0}x'),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      TextButton(
                        onPressed: () => _setPlayerPlaybackSpeed(50),
                        child: const Text('0.5x'),
                      ),
                      TextButton(
                        onPressed: () => _setPlayerPlaybackSpeed(100),
                        child: const Text('1.0x'),
                      ),
                      TextButton(
                        onPressed: () => _setPlayerPlaybackSpeed(250),
                        child: const Text('2.5x'),
                      ),
                      TextButton(
                        onPressed: () => _setPlayerPlaybackSpeed(400),
                        child: const Text('4.0x'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Volume control
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Volume: ${widget.volume}'),
                  Slider(
                    value: widget.volume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: '${widget.volume}',
                    onChanged: (value) =>
                        _setPlayerPlayoutVolume(value.toInt()),
                  ),
                  if (widget.audioVolume > 0)
                    Text('Audio Volume Indication: ${widget.audioVolume}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),

            // Preload URL
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _preloadUrlController,
                          decoration: const InputDecoration(
                            labelText: 'Preload URL',
                            hintText: 'rte://channel_id?token=xxx&uid=xxx',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onPreloadUrl,
                        child: const Text('Preload'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Switch URL
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
