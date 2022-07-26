import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/advanced/voice_changer/voice_changer.config.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// VoiceChanger Example
class VoiceChanger extends StatefulWidget {
  /// Construct the [VoiceChanger]
  const VoiceChanger({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<VoiceChanger> {
  late final RtcEngine _engine;
  bool isJoined = false;
  List<int> remoteUids = [];
  int? uidMySelf;
  int? selectedVoiceToolBtn;
  AudioEffectPreset currentAudioEffectPreset = AudioEffectPreset.audioEffectOff;

  bool isEnableSlider1 = false, isEnableSlider2 = false;
  String sliderTitle1 = '', sliderTitle2 = '';
  double minimumValue1 = 0,
      maximumValue1 = 0,
      minimumValue2 = 0,
      maximumValue2 = 0;
  double? sliderValue1, sliderValue2;
  Map selectedFreq = FreqOptions[0];
  Map selectedReverbKey = ReverbKeyOptions[0];

  double _voicePitchValue = 0.5;
  double bandGainValue = 0;
  double reverbValue = 1;

  late final TextEditingController _channelId;
  VoiceBeautifierPreset _selectedVoiceBeautifierPreset =
      VoiceBeautifierPreset.voiceBeautifierOff;

  AudioEffectPreset _selectedAudioEffectPreset =
      AudioEffectPreset.audioEffectOff;

  AudioReverbType _selectedAudioReverbType =
      AudioReverbType.audioReverbDryLevel;

  final List<VoiceBeautifierPreset> _voiceBeautifierPresets = [
    VoiceBeautifierPreset.voiceBeautifierOff,
    VoiceBeautifierPreset.chatBeautifierMagnetic,
    VoiceBeautifierPreset.chatBeautifierFresh,
  ];

  final List<AudioEffectPreset> _audioEffectPresets = [
    AudioEffectPreset.audioEffectOff,
    AudioEffectPreset.roomAcousticsKtv,
    AudioEffectPreset.roomAcousticsVocalConcert,
  ];

  final List<AudioReverbType> _audioReverbTypes = [
    AudioReverbType.audioReverbDryLevel,
    AudioReverbType.audioReverbWetLevel,
    AudioReverbType.audioReverbRoomSize,
  ];

  final Map<AudioReverbType, List<double>> _audioReverbTypeRanges = {
    AudioReverbType.audioReverbDryLevel: [-20.0, 10.0, 0.0],
    AudioReverbType.audioReverbWetLevel: [-20.0, 10.0, 0.0],
    AudioReverbType.audioReverbRoomSize: [0.0, 100.0, 0.0],
  };

  late double _selectedAudioReverbTypeValue;

  final List<AudioEqualizationBandFrequency> _audioEqualizationBandFrequencys =
      [
    AudioEqualizationBandFrequency.audioEqualizationBand31,
    AudioEqualizationBandFrequency.audioEqualizationBand62,
    AudioEqualizationBandFrequency.audioEqualizationBand125,
  ];

  late AudioEqualizationBandFrequency _selectedAudioEqualizationBandFrequencys;

  late double _selectedAudioEqualizationBandFrequencyValue;

  bool _setVoiceBeautifierPresetOnly = false;

  @override
  void initState() {
    super.initState();
    _channelId = TextEditingController(text: config.channelId);

    _selectedVoiceBeautifierPreset = _voiceBeautifierPresets[0];
    _selectedAudioEffectPreset = _audioEffectPresets[0];
    _selectedAudioReverbType = _audioReverbTypes[0];
    _selectedAudioReverbTypeValue =
        _audioReverbTypeRanges[_selectedAudioReverbType]![2];
    _selectedAudioEqualizationBandFrequencys =
        _audioEqualizationBandFrequencys[0];
    _selectedAudioEqualizationBandFrequencyValue = 0.0;
  }

  @override
  void dispose() {
    super.dispose();
    _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {});
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {});
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.joinChannel(
        token: config.token,
        channelId: _channelId.text,
        uid: 0,
        options: const ChannelMediaOptions(autoSubscribeAudio: true));
  }

  DropdownButton _createDropdownButton<T>(
      List<T> enums, ValueGetter value, ValueChanged<T?> onChanged) {
    return DropdownButton<T>(
        items: enums.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text('$e'),
          );
        }).toList(),
        value: value(),
        onChanged: onChanged);
  }

  Widget _presets() {
    if (_setVoiceBeautifierPresetOnly) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select VoiceBeautifierPreset: '),
          _createDropdownButton<VoiceBeautifierPreset>(
            _voiceBeautifierPresets,
            () => _selectedVoiceBeautifierPreset,
            (v) async {
              setState(() {
                _selectedVoiceBeautifierPreset = v!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              await _engine
                  .setVoiceBeautifierPreset(_selectedVoiceBeautifierPreset);
            },
            child: const Text('setVoiceBeautifierPreset'),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select AudioEffectPreset: '),
            _createDropdownButton<AudioEffectPreset>(
              _audioEffectPresets,
              () => _selectedAudioEffectPreset,
              (v) async {
                setState(() {
                  _selectedAudioEffectPreset = v!;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            await _engine.setAudioEffectPreset(_selectedAudioEffectPreset);
          },
          child: const Text('setAudioEffectPreset'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select AudioReverbType: '),
            _createDropdownButton<AudioReverbType>(
              _audioReverbTypes,
              () => _selectedAudioReverbType,
              (v) {
                setState(() {
                  _selectedAudioReverbType = v!;
                  _selectedAudioReverbTypeValue =
                      _audioReverbTypeRanges[_selectedAudioReverbType]![2];
                });
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Local Voice Reverb Value: '),
            Slider(
              value: _selectedAudioReverbTypeValue,
              min: _audioReverbTypeRanges[_selectedAudioReverbType]![0],
              max: _audioReverbTypeRanges[_selectedAudioReverbType]![1],
              divisions: 10,
              label: 'AudioReverbType Value $_selectedAudioReverbTypeValue',
              onChanged: (double value) {
                setState(() {
                  _selectedAudioReverbTypeValue = value;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () async {
              await _engine.setLocalVoiceReverb(
                  reverbKey: _selectedAudioReverbType,
                  value: _selectedAudioReverbTypeValue.toInt());
            },
            child: const Text('setLocalVoiceReverb')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select AudioEqualizationBandFrequency: '),
            _createDropdownButton<AudioEqualizationBandFrequency>(
              _audioEqualizationBandFrequencys,
              () => _selectedAudioEqualizationBandFrequencys,
              (v) async {
                setState(() {
                  _selectedAudioEqualizationBandFrequencys = v!;
                });
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select AudioEqualizationBandFrequency Value:'),
            Slider(
              value: _selectedAudioEqualizationBandFrequencyValue,
              min: -15.0,
              max: 15.0,
              divisions: 10,
              label:
                  'AudioEqualizationBandFrequency Value: $_selectedAudioEqualizationBandFrequencyValue',
              onChanged: (double value) {
                setState(() {
                  _selectedAudioEqualizationBandFrequencyValue = value;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () async {
              await _engine.setLocalVoiceEqualization(
                  bandFrequency: _selectedAudioEqualizationBandFrequencys,
                  bandGain:
                      _selectedAudioEqualizationBandFrequencyValue.toInt());
            },
            child: const Text('setLocalVoiceEqualization')),
        Row(
          children: [
            const Text('Pitch:'),
            Slider(
              value: _voicePitchValue,
              min: 0.5,
              max: 2,
              divisions: 10,
              label: 'Pitch $_voicePitchValue',
              onChanged: (double value) {
                setState(() {
                  _voicePitchValue = value;
                });
              },
            )
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            await _engine.setLocalVoicePitch(_voicePitchValue);
          },
          child: const Text('setLocalVoicePitch'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (!isJoined)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _channelId,
                  ),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const Text('setVoiceBeautifierPreset Only'),
                    Switch(
                      value: _setVoiceBeautifierPresetOnly,
                      onChanged: !isJoined
                          ? (v) {
                              setState(() {
                                _setVoiceBeautifierPresetOnly = v;
                              });
                            }
                          : null,
                    )
                  ]),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: _initEngine,
                          child: const Text('Join channel'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            if (isJoined)
              Expanded(
                  child: SingleChildScrollView(
                child: _presets(),
              )),
          ],
        ),
      ],
    );
  }
}
