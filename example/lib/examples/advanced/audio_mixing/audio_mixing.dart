import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// AudioMixing Example
class AudioMixing extends StatefulWidget {
  /// Construct the [AudioMixing]
  const AudioMixing({Key? key}) : super(key: key);

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
  late final TextEditingController _controller;

  bool _isStartedAudioMixing = false;
  bool _loopback = false;
  double _cycle = 1.0;
  double _startPos = 1000;

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
    return Column(
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
            children: [
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
                mainAxisAlignment: MainAxisAlignment.end,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('startPos:'),
                  Slider(
                    value: _startPos,
                    min: 1000,
                    max: 5000,
                    divisions: 100,
                    label: 'startPos value ${_startPos / 1000.0}s',
                    onChanged: (double value) async {
                      setState(() {
                        _startPos = value;
                      });

                      if (_isStartedAudioMixing) {
                        await _engine.setAudioMixingPosition(_startPos.toInt());
                      }
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
            ],
          ),
      ],
    );
  }
}
