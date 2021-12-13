import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// JoinChannelAudio Example
class JoinChannelAudio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 0, _playbackVolume = 0, _inEarMonitoringVolume = 0;
  String _soundId = '1';
  bool _isEditSoundId = false;
  double _loopCount = -1;
  double _pitch = 0.5;
  double _pan = 0;
  double _gain = 0;
  bool _isPublish = true;

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    this._addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning ${warningCode}');
      },
      error: (errorCode) {
        logSink.log('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
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
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine
        .joinChannel(config.token, config.channelId, null, config.uid)
        .catchError((onError) {
      logSink.log('error ${onError.toString()}');
    });
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _switchEffect() async {
    if (playEffect) {
      _engine.stopEffect(1).then((value) {
        setState(() {
          playEffect = false;
        });
      }).catchError((err) {
        logSink.log('stopEffect $err');
      });
    } else {
      _engine
          .playEffect(
              1,
              (await _engine.getAssetAbsolutePath("assets/Sound_Horizon.mp3"))!,
              _loopCount.toInt(),
              _pitch,
              _pan,
              _gain.toInt(),
              _isPublish)
          .then((value) {
        setState(() {
          playEffect = true;
        });
      }).catchError((err) {
        logSink.log('playEffect $err');
      });
    }
  }

  _onChangeInEarMonitoringVolume(double value) {
    setState(() {
      _inEarMonitoringVolume = value;
    });
    _engine.setInEarMonitoringVolume(value.toInt());
  }

  _toggleInEarMonitoring(value) {
    setState(() {
      _enableInEarMonitoring = value;
    });
    _engine.enableInEarMonitoring(value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
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
                      onPressed: () async {
                        try {
                          if (isJoined) {
                            await _leaveChannel();
                          } else {
                            await _joinChannel();
                          }
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Text(
                                    '${isJoined ? 'Leave' : 'Join'} channel with error:\n${e.toString()}');
                              });
                        }
                      },
                      child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                    ),
                  )
                ],
              ),
            ],
          ),
          if (isJoined)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
                    Switch(
                      value: openMicrophone,
                      onChanged: (value) {
                        setState(() {
                          openMicrophone = value;
                        });
                        _engine
                            .enableLocalAudio(openMicrophone)
                            .catchError((err) {
                          logSink.log('enableLocalAudio $err');
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(enableSpeakerphone ? 'Speakerphone' : 'Earpiece'),
                    Switch(
                      value: enableSpeakerphone,
                      onChanged: (value) {
                        setState(() {
                          enableSpeakerphone = value;
                        });
                        _engine
                            .setEnableSpeakerphone(enableSpeakerphone)
                            .catchError((err) {
                          logSink.log('setEnableSpeakerphone $err');
                        });
                      },
                    )
                  ],
                ),
                if (!kIsWeb)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Play Effect',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'file path: assets/Sound_Horizon.mp3',
                      ),
                      Row(
                        children: [
                          Text(
                            'sound id: ',
                          ),

                          Slider(
                            value: _loopCount,
                            min: -1,
                            max: 10,
                            divisions: 11,
                            label: 'loop count $_loopCount',
                            onChanged: playEffect
                                ? null
                                : (value) {
                                    setState(() {
                                      _loopCount = value;
                                    });
                                  },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'loop count: ',
                          ),
                          Slider(
                            value: _loopCount,
                            min: -1,
                            max: 10,
                            divisions: 11,
                            label: 'loop count $_loopCount',
                            onChanged: playEffect
                                ? null
                                : (value) {
                                    setState(() {
                                      _loopCount = value;
                                    });
                                  },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'pitch: ',
                          ),
                          Slider(
                            // The pitch of the audio effect. The range is [0.5,2.0]. The default value is 1.0, which means the original pitch.
                            value: _pitch,
                            min: 0.5,
                            max: 2.0,
                            divisions: 5,
                            label: 'pitch $_pitch',
                            onChanged: playEffect
                                ? null
                                : (value) {
                                    setState(() {
                                      _pitch = value;
                                    });
                                  },
                          )
                        ],
                      ),
                      // _pan
                      Row(
                        children: [
                          Text(
                            'pan: ',
                          ),
                          Slider(
                            // The spatial position of the audio effect. The range is [-1.0,1.0]
                            value: _pan,
                            min: -1.0,
                            max: 1.0,
                            divisions: 3,
                            label: 'pan $_pan',
                            onChanged: playEffect
                                ? null
                                : (value) {
                                    setState(() {
                                      _pan = value;
                                    });
                                  },
                          )
                        ],
                      ),
                      // _gain
                      Row(
                        children: [
                          Text(
                            'gain: ',
                          ),
                          Slider(
                            // The volume of the audio effect. The range is [0.0,100.0]
                            value: _gain,
                            min: 0.0,
                            max: 100.0,
                            divisions: 100,
                            label: 'gain $_gain',
                            onChanged: playEffect
                                ? null
                                : (value) {
                                    setState(() {
                                      _gain = value;
                                    });
                                  },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Is publish: ',
                          ),
                          Switch(
                            value: _isPublish,
                            onChanged: playEffect
                                ? null
                                : (value) {
                                    setState(() {
                                      _isPublish = value;
                                    });
                                  },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: this._switchEffect,
                        child: Text('${playEffect ? 'Stop' : 'Play'} effect'),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('RecordingVolume:'),
                    Slider(
                      value: _recordingVolume,
                      min: 0,
                      max: 400,
                      divisions: 5,
                      label: 'RecordingVolume',
                      onChanged: (double value) {
                        setState(() {
                          _recordingVolume = value;
                        });
                        _engine.adjustRecordingSignalVolume(value.toInt());
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('PlaybackVolume:'),
                    Slider(
                      value: _playbackVolume,
                      min: 0,
                      max: 400,
                      divisions: 5,
                      label: 'PlaybackVolume',
                      onChanged: (double value) {
                        setState(() {
                          _playbackVolume = value;
                        });
                        _engine.adjustPlaybackSignalVolume(value.toInt());
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('InEar Monitoring Volume:'),
                        Switch(
                          value: _enableInEarMonitoring,
                          onChanged: _toggleInEarMonitoring,
                        )
                      ],
                    ),
                    if (_enableInEarMonitoring)
                      Container(
                          width: 300,
                          child: Slider(
                            // Sets the volume of the in-ear monitor. The value ranges between 0 and 100 (default).
                            value: _inEarMonitoringVolume,
                            min: 0,
                            max: 100,
                            divisions: 5,
                            label:
                                'InEar Monitoring Volume $_inEarMonitoringVolume',
                            onChanged: _onChangeInEarMonitoringVolume,
                          ))
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
