import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RtePlayerConfigTab extends StatefulWidget {
  final bool initialEnableAudioVolumeLog;
  final AgoraRtePlayer? player;
  final Function(String) onLog;
  final Function(int)? onPlaybackSpeedChanged;
  final Function(int)? onVolumeChanged;
  final Function(bool)? onEnableAudioVolumeLogChanged;

  const RtePlayerConfigTab({
    Key? key,
    this.player,
    required this.onLog,
    this.onPlaybackSpeedChanged,
    this.onVolumeChanged,
    this.onEnableAudioVolumeLogChanged,
    this.initialEnableAudioVolumeLog = false,
  }) : super(key: key);

  @override
  State<RtePlayerConfigTab> createState() => _RtePlayerConfigTabState();
}

class _RtePlayerConfigTabState extends State<RtePlayerConfigTab>
    with AutomaticKeepAliveClientMixin {
  bool _autoPlay = false;
  int _playbackSpeed = 100;
  int _volume = 100;
  int _loopCount = 0;
  int _playoutAudioTrackIdx = 0;
  int _publishAudioTrackIdx = 0;
  int _audioTrackIdx = 0;
  int _subtitleTrackIdx = 0;
  int _externalSubtitleTrackIdx = 0;
  int _audioPitch = 0;
  int _audioPlaybackDelay = 0;
  int _audioDualMonoMode = 0;
  int _publishVolume = 100;
  String _playerJsonParameter = '';
  AgoraRteAbrSubscriptionLayer _abrSubscriptionLayer =
      AgoraRteAbrSubscriptionLayer.high;
  AgoraRteAbrFallbackLayer _abrFallbackLayer =
      AgoraRteAbrFallbackLayer.disabled;
  bool _enableAudioVolumeLog = false;

  @override
  void initState() {
    super.initState();
    _enableAudioVolumeLog = widget.initialEnableAudioVolumeLog;
    _loadPlayerConfig();
  }

  @override
  void didUpdateWidget(covariant RtePlayerConfigTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.player != widget.player) {
      _loadPlayerConfig();
    }
  }

  Future<AgoraRtePlayerConfig> _loadPlayerConfig() async {
    if (widget.player == null) return const AgoraRtePlayerConfig();
    try {
      final rtePlayerConfig = await widget.player!.getConfigs();
      if (mounted) {
        setState(() {
          _autoPlay = rtePlayerConfig.autoPlay ?? false;
          _playbackSpeed = rtePlayerConfig.playbackSpeed ?? 100;
          _volume = rtePlayerConfig.playoutVolume ?? 100;
          _loopCount = rtePlayerConfig.loopCount ?? 0;
          _playoutAudioTrackIdx = rtePlayerConfig.playoutAudioTrackIdx ?? 0;
          _publishAudioTrackIdx = rtePlayerConfig.publishAudioTrackIdx ?? 0;
          _audioTrackIdx = rtePlayerConfig.audioTrackIdx ?? 0;
          _subtitleTrackIdx = rtePlayerConfig.subtitleTrackIdx ?? 0;
          _externalSubtitleTrackIdx =
              rtePlayerConfig.externalSubtitleTrackIdx ?? 0;
          _audioPitch = rtePlayerConfig.audioPitch ?? 0;
          _audioPlaybackDelay = rtePlayerConfig.audioPlaybackDelay ?? 0;
          _audioDualMonoMode = rtePlayerConfig.audioDualMonoMode ?? 0;
          _publishVolume = rtePlayerConfig.publishVolume ?? 100;
          _playerJsonParameter = rtePlayerConfig.jsonParameter ?? '';
          _abrSubscriptionLayer = rtePlayerConfig.abrSubscriptionLayer ??
              AgoraRteAbrSubscriptionLayer.high;
          _abrFallbackLayer = rtePlayerConfig.abrFallbackLayer ??
              AgoraRteAbrFallbackLayer.disabled;
        });

        widget.onPlaybackSpeedChanged?.call(_playbackSpeed);
        widget.onVolumeChanged?.call(_volume);
      }
      return rtePlayerConfig;
    } catch (e) {
      widget.onLog('Load Player config error: $e');
      return const AgoraRtePlayerConfig();
    }
  }

  Future<void> _setPlayerAutoPlay(bool value) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setConfigs(AgoraRtePlayerConfig(autoPlay: value));
      await _loadPlayerConfig();
      widget.onLog('Set AutoPlay: $value');
    } catch (e) {
      widget.onLog('Set AutoPlay error: $e');
    }
  }

  Future<void> _setPlayerPlaybackSpeed(int speed) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(playbackSpeed: speed));
      setState(() {
        _playbackSpeed = speed;
      });
      widget.onPlaybackSpeedChanged?.call(speed);
      await _loadPlayerConfig();
      widget.onLog('Set PlaybackSpeed: ${speed / 100.0}x');
    } catch (e) {
      widget.onLog('Set PlaybackSpeed error: $e');
    }
  }

  Future<void> _setPlayerPlayoutVolume(int volume) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(playoutVolume: volume));
      setState(() {
        _volume = volume;
      });
      widget.onVolumeChanged?.call(volume);
      await _loadPlayerConfig();
      widget.onLog('Set PlayoutVolume: $volume');
    } catch (e) {
      widget.onLog('Set PlayoutVolume error: $e');
    }
  }

  Future<void> _setPlayerLoopCount(int count) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setConfigs(AgoraRtePlayerConfig(loopCount: count));
      setState(() {
        _loopCount = count;
      });
      await _loadPlayerConfig();
      widget.onLog('Set LoopCount: $count');
    } catch (e) {
      widget.onLog('Set LoopCount error: $e');
    }
  }

  Future<void> _setPlayerPlayoutAudioTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(playoutAudioTrackIdx: idx));
      await _loadPlayerConfig();
      widget.onLog('Set PlayoutAudioTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set PlayoutAudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerPublishAudioTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(publishAudioTrackIdx: idx));
      await _loadPlayerConfig();
      widget.onLog('Set PublishAudioTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set PublishAudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerAudioTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setConfigs(AgoraRtePlayerConfig(audioTrackIdx: idx));
      await _loadPlayerConfig();
      widget.onLog('Set AudioTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set AudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerSubtitleTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(subtitleTrackIdx: idx));
      await _loadPlayerConfig();
      widget.onLog('Set SubtitleTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set SubtitleTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerExternalSubtitleTrackIdx(int idx) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(externalSubtitleTrackIdx: idx));
      await _loadPlayerConfig();
      widget.onLog('Set ExternalSubtitleTrackIdx: $idx');
    } catch (e) {
      widget.onLog('Set ExternalSubtitleTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerAudioPitch(int pitch) async {
    if (widget.player == null) return;
    try {
      await widget.player!.setConfigs(AgoraRtePlayerConfig(audioPitch: pitch));
      await _loadPlayerConfig();
      widget.onLog('Set AudioPitch: $pitch');
    } catch (e) {
      widget.onLog('Set AudioPitch error: $e');
    }
  }

  Future<void> _setPlayerAudioPlaybackDelay(int delay) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(audioPlaybackDelay: delay));
      await _loadPlayerConfig();
      widget.onLog('Set AudioPlaybackDelay: $delay');
    } catch (e) {
      widget.onLog('Set AudioPlaybackDelay error: $e');
    }
  }

  Future<void> _setPlayerAudioDualMonoMode(int mode) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(audioDualMonoMode: mode));
      await _loadPlayerConfig();
      widget.onLog('Set AudioDualMonoMode: $mode');
    } catch (e) {
      widget.onLog('Set AudioDualMonoMode error: $e');
    }
  }

  Future<void> _setPlayerPublishVolume(int volume) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(publishVolume: volume));
      await _loadPlayerConfig();
      widget.onLog('Set PublishVolume: $volume');
    } catch (e) {
      widget.onLog('Set PublishVolume error: $e');
    }
  }

  Future<void> _setPlayerJsonParameter(String param) async {
    if (widget.player == null) return;
    try {
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(jsonParameter: param));
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
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(abrSubscriptionLayer: layer));
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
      await widget.player!
          .setConfigs(AgoraRtePlayerConfig(abrFallbackLayer: layer));
      await _loadPlayerConfig();
      widget.onLog('Set AbrFallbackLayer: ${layer.name}');
    } catch (e) {
      widget.onLog('Set AbrFallbackLayer error: $e');
    }
  }

  Future<void> _setPlayerConfigsBatch() async {
    if (widget.player == null) return;
    try {
      await widget.player!.setConfigs(AgoraRtePlayerConfig(
        autoPlay: _autoPlay,
        playbackSpeed: _playbackSpeed,
        playoutVolume: _volume,
        loopCount: _loopCount,
        playoutAudioTrackIdx: _playoutAudioTrackIdx,
        publishAudioTrackIdx: _publishAudioTrackIdx,
        audioTrackIdx: _audioTrackIdx,
        subtitleTrackIdx: _subtitleTrackIdx,
        externalSubtitleTrackIdx: _externalSubtitleTrackIdx,
        audioPitch: _audioPitch,
        audioPlaybackDelay: _audioPlaybackDelay,
        audioDualMonoMode: _audioDualMonoMode,
        publishVolume: _publishVolume,
        jsonParameter:
            _playerJsonParameter.isEmpty ? null : _playerJsonParameter,
        abrSubscriptionLayer: _abrSubscriptionLayer,
        abrFallbackLayer: _abrFallbackLayer,
      ));
      await _loadPlayerConfig();
      widget.onLog('Set Player configs using setConfigs() batch method');
    } catch (e) {
      widget.onLog('Set Player configs (batch) error: $e');
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              SwitchListTile(
                title: const Text('Enable Audio Volume Log'),
                subtitle: const Text('Enable onAudioVolumeIndication log'),
                value: _enableAudioVolumeLog,
                onChanged: (value) {
                  setState(() {
                    _enableAudioVolumeLog = value;
                  });
                  widget.onEnableAudioVolumeLogChanged?.call(value);
                  widget.onLog('Set EnableAudioVolumeLog: $value');
                },
              ),
              _buildConfigItem(
                  'Playback Speed',
                  '$_playbackSpeed',
                  (value) => _playbackSpeed = int.tryParse(value) ?? 100,
                  (value) =>
                      _setPlayerPlaybackSpeed(int.tryParse(value) ?? 100)),
              _buildConfigItem(
                  'Playout Volume',
                  '$_volume',
                  (value) => _volume = int.tryParse(value) ?? 100,
                  (value) =>
                      _setPlayerPlayoutVolume(int.tryParse(value) ?? 100)),
              _buildConfigItem(
                  'Loop Count',
                  '$_loopCount',
                  (value) => _loopCount = int.tryParse(value) ?? 0,
                  (value) => _setPlayerLoopCount(int.tryParse(value) ?? 0)),
              _buildConfigItem(
                  'Playout Audio Track Idx',
                  '$_playoutAudioTrackIdx',
                  (value) => _playoutAudioTrackIdx = int.tryParse(value) ?? 0,
                  (value) =>
                      _setPlayerPlayoutAudioTrackIdx(int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'Publish Audio Track Idx',
                  '$_publishAudioTrackIdx',
                  (value) => _publishAudioTrackIdx = int.tryParse(value) ?? 0,
                  (value) =>
                      _setPlayerPublishAudioTrackIdx(int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'Audio Track Idx',
                  '$_audioTrackIdx',
                  (value) => _audioTrackIdx = int.tryParse(value) ?? 0,
                  (value) =>
                      _setPlayerAudioTrackIdx(int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'Subtitle Track Idx',
                  '$_subtitleTrackIdx',
                  (value) => _subtitleTrackIdx = int.tryParse(value) ?? 0,
                  (value) =>
                      _setPlayerSubtitleTrackIdx(int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'External Subtitle Track Idx',
                  '$_externalSubtitleTrackIdx',
                  (value) => _externalSubtitleTrackIdx = int.tryParse(value) ?? 0,
                  (value) => _setPlayerExternalSubtitleTrackIdx(
                      int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'Audio Pitch',
                  '$_audioPitch',
                  (value) => _audioPitch = int.tryParse(value) ?? 0,
                  (value) =>
                      _setPlayerAudioPitch(int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'Audio Playback Delay',
                  '$_audioPlaybackDelay',
                  (value) => _audioPlaybackDelay = int.tryParse(value) ?? 0,
                  (value) =>
                      _setPlayerAudioPlaybackDelay(int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'Audio Dual Mono Mode',
                  '$_audioDualMonoMode',
                  (value) => _audioDualMonoMode = int.tryParse(value) ?? 0,
                  (value) =>
                      _setPlayerAudioDualMonoMode(int.tryParse(value) ?? 0),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'Publish Volume',
                  '$_publishVolume',
                  (value) => _publishVolume = int.tryParse(value) ?? 100,
                  (value) =>
                      _setPlayerPublishVolume(int.tryParse(value) ?? 100),
                  enabled: !kIsWeb),
              _buildConfigItem(
                  'JSON Parameter',
                  _playerJsonParameter,
                  (value) => _playerJsonParameter = value,
                  (value) => _setPlayerJsonParameter(value),
                  enabled: !kIsWeb),
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
                onPressed: () async {
                  final rtePlayerConfig = await _loadPlayerConfig();
                  widget.onLog('getConfigs result: ${rtePlayerConfig.toJson()}');
                },
                child: const Text('Refresh Config (getConfigs)'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _setPlayerConfigsBatch,
                child: const Text('Set All Configs (setConfigs)'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigItem(String label, String value, Function(String) onChanged, Function(String) onSave,
      {bool enabled = true}) {
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
              enabled: enabled,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                isDense: true,
                helperText: enabled ? null : 'Web is not supported',
              ),
              onChanged: enabled ? onChanged : null,
              onSubmitted: enabled ? onSave : null,
            ),
          ),
        ],
      ),
    );
  }
}
