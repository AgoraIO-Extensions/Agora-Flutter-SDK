import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// AudioEffectMixing Example
class AudioEffectMixing extends StatefulWidget {
  /// Construct the [AudioEffectMixing]
  const AudioEffectMixing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AudioEffectMixingState();
}

class _AudioEffectMixingState extends State<AudioEffectMixing> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  int _effectsVolume = 100;
  late final TextEditingController _controller;

  bool _isStartedAudioMixing = false;
  bool _loopback = false;
  double _cycle = 1.0;
  double _startPos = 1000;
  double _setAudioMixingPosition = 1000;
  int _audioMixingPublishVolume = 100;
  int _audioMixingPlayoutVolume = 100;
  int _audioMixingVolume = 100;

  final String _effectUrl = 'https://webdemo.agora.io/ding.mp3';
  final int _effectSoundId = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
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
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      onAudioMixingFinished: () {
        logSink.log('[onAudioMixingFinished]');
      },
      onAudioMixingStateChanged:
          (AudioMixingStateType state, AudioMixingReasonType errorCode) {
        logSink.log(
            '[onAudioMixingStateChanged] state:${state.toString()}, errorCode: ${errorCode.toString()}}');
      },
      onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid,
          RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
        logSink.log(
            '[onRemoteAudioStateChanged] uid: ${connection.toJson()}, state: $state, reason: $reason, elapsed: $elapsed');
      },
    ));

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  void _dispose() async {
    await _engine.stopAudioMixing();
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _joinChannel() async {
    _engine.joinChannel(
        token: '',
        channelId: _controller.text,
        uid: 0,
        options: const ChannelMediaOptions());
  }

  Future<void> _leaveChannel() async {
    _stopAudioMixing();
    _isStartedAudioMixing = false;
    _loopback = false;
    _cycle = 1.0;
    _startPos = 1000;
    await _engine.leaveChannel();
  }

  Future<void> _startAudioMixing() async {
    ByteData data =
        await rootBundle.load("assets/audio_mixing/Agora.io-Interactions.mp3");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String p = path.join(appDocDir.path, 'Agora.io-Interactions.mp3');
    final file = File(p);
    if (!(await file.exists())) {
      await file.create();
      await file.writeAsBytes(bytes);
    }

    await _engine.startAudioMixing(
      filePath: p,
      loopback: _loopback,
      cycle: _cycle.toInt(),
      startPos: _startPos.toInt(),
    );
    setState(() {
      _isStartedAudioMixing = true;
    });
  }

  Future<void> _stopAudioMixing() async {
    await _engine.stopAudioMixing();
    setState(() {
      _isStartedAudioMixing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Channel ID'),
          onChanged: (text) {
            setState(() {
              channelId = text;
            });
          },
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: isJoined ? _leaveChannel : _joinChannel,
                child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
              ),
            )
          ],
        ),
        if (isJoined)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                child: const Text('Audio Effect'),
                color: Colors.grey[400],
              ),
              Text('Effect Url: $_effectUrl'),
              ElevatedButton(
                onPressed: () {
                  _engine.preloadEffect(
                      soundId: _effectSoundId, filePath: _effectUrl);
                },
                child: const Text('Preload Audio Effect'),
              ),
              ElevatedButton(
                onPressed: _playEffect,
                child: Text('${!playEffect ? 'play' : 'stop'}Effect'),
              ),
              ElevatedButton(
                onPressed: playEffect
                    ? () {
                        _engine.resumeEffect(_effectSoundId);
                      }
                    : null,
                child: const Text('resumeEffect'),
              ),
              ElevatedButton(
                onPressed: playEffect
                    ? () {
                        _engine.pauseEffect(_effectSoundId);
                      }
                    : null,
                child: const Text('pauseEffect'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('EffectsVolume:'),
                  Slider(
                    value: _effectsVolume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: 'EffectsVolume $_effectsVolume',
                    onChanged: playEffect
                        ? (double value) {
                            setState(() {
                              _effectsVolume = value.toInt();
                            });
                            _engine.setEffectsVolume(_effectsVolume);
                          }
                        : null,
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                child: const Text('Audio Mixing'),
                color: Colors.grey[400],
              ),
              const Text(
                  'asset: assets/audio_mixing/Agora.io-Interactions.mp3'),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text('loopback: '),
                Switch(
                  value: _loopback,
                  onChanged: _isStartedAudioMixing
                      ? null
                      : (changed) {
                          setState(() {
                            _loopback = changed;
                          });
                        },
                  activeTrackColor: Colors.grey[350],
                  activeColor: Colors.white,
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('cycle:'),
                  Slider(
                    value: _cycle,
                    min: 0.0,
                    max: 10.0,
                    divisions: 10,
                    label: 'cycle value ${_cycle.toInt()}',
                    onChanged: _isStartedAudioMixing
                        ? null
                        : (double value) {
                            setState(() {
                              _cycle = value;
                            });
                          },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('startPos:'),
                  Slider(
                    value: _startPos,
                    min: 1000,
                    max: 5000,
                    divisions: 100,
                    label: 'startPos value ${_startPos / 1000.0}s',
                    onChanged: _isStartedAudioMixing
                        ? null
                        : (double value) async {
                            setState(() {
                              _startPos = value;
                            });
                          },
                  )
                ],
              ),
              ElevatedButton(
                onPressed: !_isStartedAudioMixing
                    ? _startAudioMixing
                    : _stopAudioMixing,
                child: Text(
                    '${_isStartedAudioMixing ? 'Stop' : 'Start'} Audio Mixing'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('setAudioMixingPosition:'),
                  Slider(
                    value: _setAudioMixingPosition,
                    min: 1000,
                    max: 5000,
                    divisions: 100,
                    label:
                        'startPos value ${_setAudioMixingPosition / 1000.0}s',
                    onChanged: _isStartedAudioMixing
                        ? (double value) async {
                            setState(() {
                              _setAudioMixingPosition = value;
                            });

                            await _engine.setAudioMixingPosition(
                                _setAudioMixingPosition.toInt());
                          }
                        : null,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('adjustAudioMixingPublishVolume:'),
                  Slider(
                    value: _audioMixingPublishVolume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label:
                        'AudioMixingPublishVolume $_audioMixingPublishVolume',
                    onChanged: _isStartedAudioMixing
                        ? (double value) async {
                            setState(() {
                              _audioMixingPublishVolume = value.toInt();
                            });

                            await _engine.adjustAudioMixingPublishVolume(
                                _audioMixingPublishVolume);
                          }
                        : null,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('adjustAudioMixingPlayoutVolume:'),
                  Slider(
                    value: _audioMixingPlayoutVolume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label:
                        'AudioMixingPlayoutVolume $_audioMixingPlayoutVolume',
                    onChanged: _isStartedAudioMixing
                        ? (double value) async {
                            setState(() {
                              _audioMixingPlayoutVolume = value.toInt();
                            });

                            await _engine.adjustAudioMixingPlayoutVolume(
                                _audioMixingPlayoutVolume);
                          }
                        : null,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('adjustAudioMixingVolume:'),
                  Slider(
                    value: _audioMixingVolume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: 'AudioMixingVolume $_audioMixingVolume',
                    onChanged: _isStartedAudioMixing
                        ? (double value) async {
                            setState(() {
                              _audioMixingVolume = value.toInt();
                            });

                            await _engine
                                .adjustAudioMixingVolume(_audioMixingVolume);
                          }
                        : null,
                  )
                ],
              ),
            ],
          ),
      ],
    );

    return SingleChildScrollView(
      child: child,
    );
  }

  void _playEffect() {
    if (playEffect) {
      _engine.stopEffect(_effectSoundId);
      setState(() {
        playEffect = false;
      });
    } else {
      _engine.playEffect(
          soundId: _effectSoundId,
          filePath: _effectUrl,
          loopCount: -1,
          pitch: 1,
          pan: 1,
          gain: 100,
          publish: true);
      // .then((value) {
      setState(() {
        playEffect = true;
      });
    }
  }
}
