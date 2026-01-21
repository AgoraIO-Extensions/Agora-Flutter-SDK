import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class RtePlayerConfigTab extends StatefulWidget {
  final AgoraRtePlayerImpl? player;
  final Function(String) onLog;
  final Function(int)? onPlaybackSpeedChanged;
  final Function(int)? onVolumeChanged;

  const RtePlayerConfigTab({
    Key? key,
    this.player,
    required this.onLog,
    this.onPlaybackSpeedChanged,
    this.onVolumeChanged,
  }) : super(key: key);

  @override
  State<RtePlayerConfigTab> createState() => _RtePlayerConfigTabState();
}

class _RtePlayerConfigTabState extends State<RtePlayerConfigTab> {
  bool _autoPlay = false;
  int _playbackSpeed = 100;
  int _volume = 100;
  int _loopCount = 0;
  int _playoutAudioTrackIdx = 0;
  int _publishAudioTrackIdx = 0;
  int _audioTrackIdx = 0; // Defines which audio track to play
  int _subtitleTrackIdx = 0; // Defines which subtitle track to play
  int _externalSubtitleTrackIdx = 0;
  int _audioPitch = 0;
  int _audioPlaybackDelay = 0;
  int _audioDualMonoMode = 0; // 0: L, 1: R, 2: Mix
  int _publishVolume = 100;
  String _playerJsonParameter = '';
  AgoraRteAbrSubscriptionLayer _abrSubscriptionLayer =
      AgoraRteAbrSubscriptionLayer.high;
  AgoraRteAbrFallbackLayer _abrFallbackLayer =
      AgoraRteAbrFallbackLayer.disabled;

  @override
  void initState() {
    super.initState();
    _loadPlayerConfig();
  }

  @override
  void didUpdateWidget(covariant RtePlayerConfigTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.player != widget.player) {
      _loadPlayerConfig();
    }
  }

  Future<void> _loadPlayerConfig() async {
    if (widget.player == null) return;
    try {
      final autoPlay = await widget.player!.getAutoPlay();
      final playbackSpeed = await widget.player!.getPlaybackSpeed();
      final playoutVolume = await widget.player!.getPlayoutVolume();
      final loopCount = await widget.player!.getLoopCount();
      final playoutAudioTrackIdx = await widget.player!.getPlayoutAudioTrackIdx();
      final publishAudioTrackIdx = await widget.player!.getPublishAudioTrackIdx();
      final audioTrackIdx = await widget.player!.getAudioTrackIdx();
      final subtitleTrackIdx = await widget.player!.getSubtitleTrackIdx();
      final externalSubtitleTrackIdx =
          await widget.player!.getExternalSubtitleTrackIdx();
      final audioPitch = await widget.player!.getAudioPitch();
      final audioPlaybackDelay = await widget.player!.getAudioPlaybackDelay();
      final audioDualMonoMode = await widget.player!.getAudioDualMonoMode();
      final publishVolume = await widget.player!.getPublishVolume();
      final jsonParameter = await widget.player!.getJsonParameter();
      final abrSubscriptionLayer =
          await widget.player!.getAbrSubscriptionLayer();
      final abrFallbackLayer = await widget.player!.getAbrFallbackLayer();
      
      if (mounted) {
        setState(() {
          _autoPlay = autoPlay;
          _playbackSpeed = playbackSpeed;
          _volume = playoutVolume;
          _loopCount = loopCount;
          _playoutAudioTrackIdx = playoutAudioTrackIdx;
          _publishAudioTrackIdx = publishAudioTrackIdx;
          _audioTrackIdx = audioTrackIdx;
          _subtitleTrackIdx = subtitleTrackIdx;
          _externalSubtitleTrackIdx = externalSubtitleTrackIdx;
          _audioPitch = audioPitch;
          _audioPlaybackDelay = audioPlaybackDelay;
          _audioDualMonoMode = audioDualMonoMode;
          _publishVolume = publishVolume;
          _playerJsonParameter = jsonParameter;
          _abrSubscriptionLayer = abrSubscriptionLayer;
          _abrFallbackLayer = abrFallbackLayer;
        });
        
        // Notify parent about initial values if needed
        widget.onPlaybackSpeedChanged?.call(playbackSpeed);
        widget.onVolumeChanged?.call(playoutVolume);
      }
    } catch (e) {
      widget.onLog('Load Player config error: $e');
    }
  }

  Future<void> _setPlayerAutoPlay(bool value) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setAutoPlay(value);
      await _loadPlayerConfig();
      widget.onLog('Set AutoPlay: $value');
    } catch (e) {
      widget.onLog('Set AutoPlay error: $e');
    }
  }

  Future<void> _setPlayerPlaybackSpeed(int speed) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setPlaybackSpeed(speed);
      setState(() {
        _playbackSpeed = speed;
      });
      widget.onPlaybackSpeedChanged?.call(speed);
      widget.onLog('Set PlaybackSpeed: ${speed / 100.0}x');
    } catch (e) {
      widget.onLog('Set PlaybackSpeed error: $e');
    }
  }

  Future<void> _setPlayerPlayoutVolume(int volume) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setPlayoutVolume(volume);
      setState(() {
        _volume = volume;
      });
      widget.onVolumeChanged?.call(volume);
      widget.onLog('Set PlayoutVolume: $volume');
    } catch (e) {
      widget.onLog('Set PlayoutVolume error: $e');
    }
  }

  Future<void> _setPlayerLoopCount(int count) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setLoopCount(count);
      setState(() {
        _loopCount = count;
      });
      widget.onLog('Set LoopCount: $count');
    } catch (e) {
      widget.onLog('Set LoopCount error: $e');
    }
  }

  Future<void> _setPlayerPlayoutAudioTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setPlayoutAudioTrackIdx(idx);
      await _loadPlayerConfig();
      widget.onLog('Set PlayoutAudioTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set PlayoutAudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerPublishAudioTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setPublishAudioTrackIdx(idx);
      await _loadPlayerConfig();
      widget.onLog('Set PublishAudioTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set PublishAudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerAudioTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setAudioTrackIdx(idx);
      await _loadPlayerConfig();
      widget.onLog('Set AudioTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set AudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerSubtitleTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setSubtitleTrackIdx(idx);
      await _loadPlayerConfig();
      widget.onLog('Set SubtitleTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set SubtitleTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerExternalSubtitleTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setExternalSubtitleTrackIdx(idx);
      await _loadPlayerConfig();
      widget.onLog('Set ExternalSubtitleTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set ExternalSubtitleTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerAudioPitch(int pitch) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setAudioPitch(pitch);
      await _loadPlayerConfig();
      widget.onLog('Set AudioPitch: $pitch');
    } catch (e) {
      widget.onLog('Set AudioPitch error: $e');
    }
  }

  Future<void> _setPlayerAudioPlaybackDelay(int delay) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setAudioPlaybackDelay(delay);
      await _loadPlayerConfig();
      widget.onLog('Set AudioPlaybackDelay: $delay');
    } catch (e) {
      widget.onLog('Set AudioPlaybackDelay error: $e');
    }
  }

  Future<void> _setPlayerAudioDualMonoMode(int mode) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setAudioDualMonoMode(mode);
      await _loadPlayerConfig();
      widget.onLog('Set AudioDualMonoMode: $mode');
    } catch (e) {
      widget.onLog('Set AudioDualMonoMode error: $e');
    }
  }

  Future<void> _setPlayerPublishVolume(int volume) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setPublishVolume(volume);
      await _loadPlayerConfig();
      widget.onLog('Set PublishVolume: $volume');
    } catch (e) {
      widget.onLog('Set PublishVolume error: $e');
    }
  }

  Future<void> _setPlayerJsonParameter(String param) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setJsonParameter(param);
      await _loadPlayerConfig();
      widget.onLog('Set Player JsonParameter: $param');
    } catch (e) {
      widget.onLog('Set Player JsonParameter error: $e');
    }
  }

  Future<void> _setPlayerAbrSubscriptionLayer(
      AgoraRteAbrSubscriptionLayer layer) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setAbrSubscriptionLayer(layer);
      await _loadPlayerConfig();
      widget.onLog('Set AbrSubscriptionLayer: ${layer.name}');
    } catch (e) {
      widget.onLog('Set AbrSubscriptionLayer error: $e');
    }
  }

  Future<void> _setPlayerAbrFallbackLayer(
      AgoraRteAbrFallbackLayer layer) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setAbrFallbackLayer(layer);
      await _loadPlayerConfig();
      widget.onLog('Set AbrFallbackLayer: ${layer.name}');
    } catch (e) {
      widget.onLog('Set AbrFallbackLayer error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.player == null) {
      return const Center(child: Text('Player not initialized'));
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Auto Play'),
                value: _autoPlay,
                onChanged: _setPlayerAutoPlay,
              ),
              _buildConfigItem(
                  'Playback Speed',
                  '$_playbackSpeed',
                  (value) =>
                      _setPlayerPlaybackSpeed(int.tryParse(value) ?? 100)),
              _buildConfigItem(
                  'Playout Volume',
                  '$_volume',
                  (value) =>
                      _setPlayerPlayoutVolume(int.tryParse(value) ?? 100)),
              _buildConfigItem('Loop Count', '$_loopCount',
                  (value) => _setPlayerLoopCount(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'Playout Audio Track Idx',
                  '$_playoutAudioTrackIdx',
                  (value) =>
                      _setPlayerPlayoutAudioTrackIdx(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'Publish Audio Track Idx',
                  '$_publishAudioTrackIdx',
                  (value) =>
                      _setPlayerPublishAudioTrackIdx(int.tryParse(value) ?? 0)),
              _buildConfigItem('Audio Track Idx', '$_audioTrackIdx',
                  (value) => _setPlayerAudioTrackIdx(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'Subtitle Track Idx',
                  '$_subtitleTrackIdx',
                  (value) =>
                      _setPlayerSubtitleTrackIdx(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'External Subtitle Track Idx',
                  '$_externalSubtitleTrackIdx',
                  (value) => _setPlayerExternalSubtitleTrackIdx(
                      int.tryParse(value) ?? 0)),
              _buildConfigItem('Audio Pitch', '$_audioPitch',
                  (value) => _setPlayerAudioPitch(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'Audio Playback Delay',
                  '$_audioPlaybackDelay',
                  (value) =>
                      _setPlayerAudioPlaybackDelay(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'Audio Dual Mono Mode',
                  '$_audioDualMonoMode',
                  (value) =>
                      _setPlayerAudioDualMonoMode(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'Publish Volume',
                  '$_publishVolume',
                  (value) =>
                      _setPlayerPublishVolume(int.tryParse(value) ?? 100)),
              _buildConfigItem('JSON Parameter', _playerJsonParameter,
                  (value) => _setPlayerJsonParameter(value)),
              const SizedBox(height: 8),
              const Text('ABR Subscription Layer:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: AgoraRteAbrSubscriptionLayer.values.map((layer) {
                  return ChoiceChip(
                    label: Text(layer.name),
                    selected: _abrSubscriptionLayer == layer,
                    onSelected: (selected) {
                      if (selected) _setPlayerAbrSubscriptionLayer(layer);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              const Text('ABR Fallback Layer:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: AgoraRteAbrFallbackLayer.values.map((layer) {
                  return ChoiceChip(
                    label: Text(layer.name),
                    selected: _abrFallbackLayer == layer,
                    onSelected: (selected) {
                      if (selected) _setPlayerAbrFallbackLayer(layer);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadPlayerConfig,
                child: const Text('Refresh Config'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigItem(String label, String value, Function(String) onSave) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: onSave,
            ),
          ),
        ],
      ),
    );
  }
}
