// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// EnableSpatialAudio Example
class EnableSpatialAudio extends StatefulWidget {
  /// Construct the [EnableSpatialAudio]
  const EnableSpatialAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<EnableSpatialAudio> {
  late final RtcEngine _engine;
  bool isJoined = false;
  late TextEditingController _controller0;
  bool _isEnableSpatialAudio = false;
  double _speakerAzimuth = 0.0;
  double _speakerElevation = 0.0;
  double _speakerDistance = 0.0;

  /// speaker orientation [0-180]: 0 degree is the same with listener orientation
  int _speakerOrientation = 0;
  bool _enableBlur = false;
  bool _enableAirAbsorb = false;

  final Set<int> _remoteUids = {};
  int _selectedRemoteUid = 0;

  @override
  void initState() {
    super.initState();
    _controller0 = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  void _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _initEngine() async {
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
        setState(() {
          _remoteUids.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          _remoteUids.remove(rUid);
        });
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
  }

  void _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    await _engine.joinChannel(
        token: config.token,
        channelId: _controller0.text,
        uid: 1000,
        options: const ChannelMediaOptions());
  }

  _leaveChannel() async {
    setState(() {
      _isEnableSpatialAudio = false;
    });
    await _engine.enableSpatialAudio(_isEnableSpatialAudio);

    await _engine.leaveChannel();
  }

  Widget _buildSpatialAudioOptions() {
    if (_selectedRemoteUid == 0 && _remoteUids.isNotEmpty) {
      _selectedRemoteUid = _remoteUids.first;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Remote Uids: '),
            DropdownButton<int>(
                items: _remoteUids.map((uid) {
                  return DropdownMenuItem(
                    value: uid,
                    child: Text('$uid'),
                  );
                }).toList(),
                value: _selectedRemoteUid,
                onChanged: (v) {
                  setState(() {
                    _selectedRemoteUid = v!;
                  });
                }),
          ],
        ),
        const Text('The options can be set after remote user joined'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Speaker Azimuth:'),
            Slider(
              value: _speakerAzimuth,
              min: 0,
              max: 500,
              divisions: 5,
              label: 'Speaker Azimuth',
              onChanged: _remoteUids.isNotEmpty
                  ? (double value) {
                      setState(() {
                        _speakerAzimuth = value;
                      });
                      _engine.setRemoteUserSpatialAudioParams(
                        uid: _selectedRemoteUid,
                        params: SpatialAudioParams(
                          speakerAzimuth: _speakerAzimuth,
                          speakerElevation: _speakerElevation,
                          speakerDistance: _speakerDistance,
                          speakerOrientation: _speakerOrientation,
                          enableBlur: _enableBlur,
                          enableAirAbsorb: _enableAirAbsorb,
                        ),
                      );
                    }
                  : null,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Speaker Elevation:'),
            Slider(
              value: _speakerElevation,
              min: 0,
              max: 500,
              divisions: 5,
              label: 'Speaker Elevation',
              onChanged: _remoteUids.isNotEmpty
                  ? (double value) {
                      setState(() {
                        _speakerElevation = value;
                      });
                      _engine.setRemoteUserSpatialAudioParams(
                        uid: _selectedRemoteUid,
                        params: SpatialAudioParams(
                          speakerAzimuth: _speakerAzimuth,
                          speakerElevation: _speakerElevation,
                          speakerDistance: _speakerDistance,
                          speakerOrientation: _speakerOrientation,
                          enableBlur: _enableBlur,
                          enableAirAbsorb: _enableAirAbsorb,
                        ),
                      );
                    }
                  : null,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Speaker Distance:'),
            Slider(
              value: _speakerDistance,
              min: 0,
              max: 500,
              divisions: 5,
              label: 'Speaker Distance',
              onChanged: _remoteUids.isNotEmpty
                  ? (double value) {
                      setState(() {
                        _speakerDistance = value;
                      });
                      _engine.setRemoteUserSpatialAudioParams(
                        uid: _selectedRemoteUid,
                        params: SpatialAudioParams(
                          speakerAzimuth: _speakerAzimuth,
                          speakerElevation: _speakerElevation,
                          speakerDistance: _speakerDistance,
                          speakerOrientation: _speakerOrientation,
                          enableBlur: _enableBlur,
                          enableAirAbsorb: _enableAirAbsorb,
                        ),
                      );
                    }
                  : null,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Speaker Orientation:'),
            Slider(
              value: _speakerOrientation.toDouble(),
              min: 0,
              max: 180,
              divisions: 18,
              label: 'Speaker Orientation',
              onChanged: _remoteUids.isNotEmpty
                  ? (double value) {
                      setState(() {
                        _speakerOrientation = value.toInt();
                      });
                      _engine.setRemoteUserSpatialAudioParams(
                        uid: _selectedRemoteUid,
                        params: SpatialAudioParams(
                          speakerAzimuth: _speakerAzimuth,
                          speakerElevation: _speakerElevation,
                          speakerDistance: _speakerDistance,
                          speakerOrientation: _speakerOrientation,
                          enableBlur: _enableBlur,
                          enableAirAbsorb: _enableAirAbsorb,
                        ),
                      );
                    }
                  : null,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enable Blur:'),
            Switch(
              value: _enableBlur,
              onChanged: _remoteUids.isNotEmpty
                  ? (value) {
                      setState(() {
                        _enableBlur = value;
                      });
                      _engine.setRemoteUserSpatialAudioParams(
                        uid: _selectedRemoteUid,
                        params: SpatialAudioParams(
                          speakerAzimuth: _speakerAzimuth,
                          speakerElevation: _speakerElevation,
                          speakerDistance: _speakerDistance,
                          speakerOrientation: _speakerOrientation,
                          enableBlur: _enableBlur,
                          enableAirAbsorb: _enableAirAbsorb,
                        ),
                      );
                    }
                  : null,
              activeTrackColor: Colors.grey[350],
              activeColor: Colors.white,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enable Air Absorb:'),
            Switch(
              value: _enableAirAbsorb,
              onChanged: _remoteUids.isNotEmpty
                  ? (value) {
                      setState(() {
                        _enableAirAbsorb = value;
                      });
                      _engine.setRemoteUserSpatialAudioParams(
                        uid: _selectedRemoteUid,
                        params: SpatialAudioParams(
                          speakerAzimuth: _speakerAzimuth,
                          speakerElevation: _speakerElevation,
                          speakerDistance: _speakerDistance,
                          speakerOrientation: _speakerOrientation,
                          enableBlur: _enableBlur,
                          enableAirAbsorb: _enableAirAbsorb,
                        ),
                      );
                    }
                  : null,
              activeTrackColor: Colors.grey[350],
              activeColor: Colors.white,
            )
          ],
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
            TextField(
              controller: _controller0,
              decoration: const InputDecoration(hintText: 'Channel ID'),
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: isJoined
                        ? () {
                            setState(() {
                              _isEnableSpatialAudio = !_isEnableSpatialAudio;
                            });
                            _engine.enableSpatialAudio(_isEnableSpatialAudio);
                          }
                        : null,
                    child: Text(
                        '${_isEnableSpatialAudio ? 'Disable' : 'Enable'}SpatialAudio'),
                  ),
                )
              ],
            ),
            if (_isEnableSpatialAudio) _buildSpatialAudioOptions(),
          ],
        ),
      ],
    );
  }
}
