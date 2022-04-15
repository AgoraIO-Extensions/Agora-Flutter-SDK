import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/advanced/voice_changer/voice_changer.config.dart';
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
  AudioEffectPreset currentAudioEffectPreset = AudioEffectPreset.AudioEffectOff;

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
      VoiceBeautifierPreset.VoiceBeautifierOff;

  AudioEffectPreset _selectedAudioEffectPreset =
      AudioEffectPreset.AudioEffectOff;

  AudioReverbType _selectedAudioReverbType = AudioReverbType.DryLevel;

  double _audioEffectPresetParam1 = 0;
  double _audioEffectPresetParam2 = 0;

  final List<VoiceBeautifierPreset> _voiceBeautifierPresets = [
    VoiceBeautifierPreset.VoiceBeautifierOff,
    VoiceBeautifierPreset.ChatBeautifierMagnetic,
    VoiceBeautifierPreset.ChatBeautifierFresh,
  ];

  final List<AudioEffectPreset> _audioEffectPresets = [
    AudioEffectPreset.AudioEffectOff,
    AudioEffectPreset.RoomAcousticsKTV,
    AudioEffectPreset.RoomAcousticsVocalConcert,
  ];

  final List<AudioReverbType> _audioReverbTypes = [
    AudioReverbType.DryLevel,
    AudioReverbType.WetLevel,
    AudioReverbType.RoomSize,
  ];

  final Map<AudioReverbType, List<double>> _audioReverbTypeRanges = {
    AudioReverbType.DryLevel: [-20.0, 10.0, 0.0],
    AudioReverbType.WetLevel: [-20.0, 10.0, 0.0],
    AudioReverbType.RoomSize: [0.0, 100.0, 0.0],
  };

  late double _selectedAudioReverbTypeValue;

  final List<AudioEqualizationBandFrequency> _audioEqualizationBandFrequencys =
      [
    AudioEqualizationBandFrequency.Band31,
    AudioEqualizationBandFrequency.Band62,
    AudioEqualizationBandFrequency.Band125,
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
    _engine.destroy();
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListener();

    // make this room live broadcasting room
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await _engine.joinChannel(config.token, _channelId.text, null, 0, null);
  }

  _addListener() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
          uidMySelf = uid;
        });
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined $uid $elapsed');
        setState(() {
          remoteUids.add(uid);
        });
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline $uid $reason');
        setState(() {
          remoteUids.remove(uid);
        });
      },
    ));
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
        Row(
          children: [
            const Text('param1'),
            Slider(
              value: _audioEffectPresetParam1,
              min: 0.0,
              max: 10.0,
              divisions: 10,
              label: 'param1 $_audioEffectPresetParam1',
              onChanged: (double value) {
                setState(() {
                  _audioEffectPresetParam1 = value;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text('param2'),
            Slider(
              value: _audioEffectPresetParam2,
              min: 0.0,
              max: 10.0,
              divisions: 10,
              label: 'param2 $_audioEffectPresetParam2',
              onChanged: (double value) {
                setState(() {
                  _audioEffectPresetParam2 = value;
                });
              },
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            await _engine.setAudioEffectParameters(
              _selectedAudioEffectPreset,
              _audioEffectPresetParam1.toInt(),
              _audioEffectPresetParam2.toInt(),
            );
          },
          child: const Text('setAudioEffectParameters'),
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
              await _engine.setLocalVoiceReverb(_selectedAudioReverbType,
                  _selectedAudioReverbTypeValue.toInt());
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
                  _selectedAudioEqualizationBandFrequencys,
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
            _engine.setLocalVoicePitch(_voicePitchValue);
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
