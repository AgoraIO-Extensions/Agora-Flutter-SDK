import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// AudioMixing Example
class AudioMixing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AudioMixingState();
}

class _AudioMixingState extends State<AudioMixing> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  TextEditingController? _controller;

  bool _isStartedAudioMixing = false;
  bool _loopback = false;
  bool _replace = false;
  double _cycle = 1.0;
  double _startPos = 1000;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void reassemble() {
    super.reassemble();
    _destroy();
  }

  @override
  void dispose() {
    super.dispose();
    _destroy();
  }

  Future<void> _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    this._addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning ${warningCode}');
      },
      error: (errorCode) {
        logSink.log('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log(
            'joinChannelSuccess channel: ${channel}, uid: ${uid}, elapsed: ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) async {
        logSink.log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      audioMixingFinished: () {
        logSink.log('audioMixingFinished');
      },
      audioMixingStateChanged: (
        AudioMixingStateCode state,
        AudioMixingReason reason,
      ) {
        logSink.log(
            'audioMixingStateChanged state:${state.toString()}, reason: ${reason.toString()}}');
      },
      remoteAudioMixingBegin: () {
        logSink.log('remoteAudioMixingBegin');
      },
      remoteAudioMixingEnd: () {
        logSink.log('remoteAudioMixingEnd');
      },
    ));
  }

  Future<void> _destroy() async {
    await _engine.leaveChannel();
    await _engine.destroy();
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine
        .joinChannel(config.token, config.channelId, null, config.uid)
        .catchError((onError) {
      logSink.log('error ${onError.toString()}');
    });
  }

  Future<void> _leaveChannel() async {
    await _stopAudioMixing();
    _isStartedAudioMixing = false;
    _loopback = false;
    _replace = false;
    _cycle = 1.0;
    _startPos = 0;
    await _engine.leaveChannel();
  }

  Future<void> _startAudioMixing() async {
    final filePath = await _engine
        .getAssetAbsolutePath('assets/audio_mixing/Agora.io-Interactions.mp3');
    await _engine.startAudioMixing(
      filePath!,
      _loopback,
      _replace,
      _cycle.toInt(),
      _startPos.toInt(),
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
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Channel ID'),
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
                onPressed: isJoined ? this._leaveChannel : this._joinChannel,
                child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
              ),
            )
          ],
        ),
        if (isJoined)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('loopback: '),
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
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text('replace: '),
                Switch(
                  value: _replace,
                  onChanged: _isStartedAudioMixing
                      ? null
                      : (changed) {
                          setState(() {
                            _replace = changed;
                          });
                        },
                  activeTrackColor: Colors.grey[350],
                  activeColor: Colors.white,
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('cycle:'),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('startPos:'),
                  Slider(
                    value: _startPos,
                    min: 1000,
                    max: 5000,
                    divisions: 100,
                    label: 'startPos value ${_startPos / 1000.0}s',
                    onChanged: (double value) {
                      setState(() {
                        _startPos = value;
                      });

                      if (_isStartedAudioMixing) {
                        _engine.setAudioMixingPosition(_startPos.toInt());
                      }
                    },
                  )
                ],
              ),
              ElevatedButton(
                onPressed: !_isStartedAudioMixing
                    ? this._startAudioMixing
                    : this._stopAudioMixing,
                child: Text(
                    '${_isStartedAudioMixing ? 'Stop' : 'Start'} Audio Mixing'),
              ),
            ],
          ),
      ],
    );
  }
}
