import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../log_sink.dart';

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
  double _recordingVolume = 100,
      _playbackVolume = 100,
      _inEarMonitoringVolume = 100;
  late TextEditingController _controller;

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
        .joinChannel(config.token, _controller.text, null, config.uid)
        .catchError((onError) {
      logSink.log('error ${onError.toString()}');
    });
  }

  _leaveChannel() async {
    
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = true;
      enableSpeakerphone = true;
      playEffect = false;
   _enableInEarMonitoring = false;
   _recordingVolume = 100;
      _playbackVolume = 100;
      _inEarMonitoringVolume = 100;
    });
  }

  _switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      logSink.log('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {
      logSink.log('setEnableSpeakerphone $err');
    });
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
      final path =
          (await _engine.getAssetAbsolutePath("assets/Sound_Horizon.mp3"))!;
      logSink.log('path: $path');
      _engine.playEffect(1, path, -1, 1, 1, 100, true).then((value) {
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
    _engine.setInEarMonitoringVolume(_inEarMonitoringVolume.toInt());
  }

  _toggleInEarMonitoring(value) {
    setState(() {
      _enableInEarMonitoring = value;
    });
    _engine.enableInEarMonitoring(value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Channel ID'),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed:
                        isJoined ? this._leaveChannel : this._joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
          ],
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: this._switchMicrophone,
                    child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
                  ),
                  ElevatedButton(
                    onPressed: isJoined ? this._switchSpeakerphone : null,
                    child:
                        Text(enableSpeakerphone ? 'Speakerphone' : 'Earpiece'),
                  ),
                  if (!kIsWeb)
                    ElevatedButton(
                      onPressed: isJoined ? this._switchEffect : null,
                      child: Text('${playEffect ? 'Stop' : 'Play'} effect'),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('RecordingVolume:'),
                      Slider(
                        value: _recordingVolume,
                        min: 0,
                        max: 400,
                        divisions: 5,
                        label: 'RecordingVolume',
                        onChanged: isJoined
                            ? (double value) {
                                setState(() {
                                  _recordingVolume = value;
                                });
                                _engine
                                    .adjustRecordingSignalVolume(value.toInt());
                              }
                            : null,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('PlaybackVolume:'),
                      Slider(
                        value: _playbackVolume,
                        min: 0,
                        max: 400,
                        divisions: 5,
                        label: 'PlaybackVolume',
                        onChanged: isJoined
                            ? (double value) {
                                setState(() {
                                  _playbackVolume = value;
                                });
                                _engine
                                    .adjustPlaybackSignalVolume(value.toInt());
                              }
                            : null,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Text('InEar Monitoring Volume:'),
                        Switch(
                          value: _enableInEarMonitoring,
                          onChanged: isJoined ? _toggleInEarMonitoring : null,
                          activeTrackColor: Colors.grey[350],
                          activeColor: Colors.white,
                        )
                      ]),
                      if (_enableInEarMonitoring)
                        Container(
                            width: 300,
                            child: Slider(
                              value: _inEarMonitoringVolume,
                              min: 0,
                              max: 100,
                              divisions: 5,
                              label:
                                  'InEar Monitoring Volume $_inEarMonitoringVolume',
                              onChanged: isJoined
                                  ? _onChangeInEarMonitoringVolume
                                  : null,
                            ))
                    ],
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            ))
      ],
    );
  }
}
