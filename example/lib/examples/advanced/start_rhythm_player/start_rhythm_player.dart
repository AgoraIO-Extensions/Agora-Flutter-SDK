// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// StartRhythmPlayer Example
class StartRhythmPlayer extends StatefulWidget {
  /// Construct the [StartRhythmPlayer]
  const StartRhythmPlayer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StartRhythmPlayer> {
  late final RtcEngine _engine;

  bool isJoined = false;
  late TextEditingController _controller0;

  final Set<int> _remoteUids = {};

  double _beatsPerMeasure = 4;
  double _beatsPerMinute = 60;

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

  Future<void> _dispose() async {
    await _engine.stopRhythmPlayer();
    await _engine.leaveChannel();
    await _engine.release();
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

  Future<String> _getFilePath(String fileName) async {
    ByteData data = await rootBundle.load("assets/$fileName");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String p = path.join(appDocDir.path, fileName);
    final file = File(p);
    if (!(await file.exists())) {
      await file.create();
      await file.writeAsBytes(bytes);
    }

    return p;
  }

  void _joinChannel() async {
    final sound1 = await _getFilePath('dang.mp3');
    final sound2 = await _getFilePath('ding.mp3');
    await _engine.startRhythmPlayer(
      sound1: sound1,
      sound2: sound2,
      config: AgoraRhythmPlayerConfig(
          beatsPerMeasure: _beatsPerMeasure.toInt(),
          beatsPerMinute: _beatsPerMinute.toInt()),
    );

    await _engine.joinChannel(
      token: config.token,
      channelId: _controller0.text,
      uid: 0,
      options: const ChannelMediaOptions(publishRhythmPlayerTrack: true),
    );
  }

  _leaveChannel() async {
    await _engine.stopRhythmPlayer();
    await _engine.leaveChannel();
    setState(() {
      _beatsPerMeasure = 4;
      _beatsPerMinute = 60;
    });
  }

  Widget _buildRhythmPlayerOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Beats Per Measure:'),
            Slider(
              value: _beatsPerMeasure,
              min: 1,
              max: 9,
              divisions: 9,
              label: 'Beats Per Measure',
              onChanged: (double value) async {
                setState(() {
                  _beatsPerMeasure = value;
                });
                await _engine.configRhythmPlayer(
                  AgoraRhythmPlayerConfig(
                      beatsPerMeasure: _beatsPerMeasure.toInt(),
                      beatsPerMinute: _beatsPerMinute.toInt()),
                );
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Beats Per Minute:'),
            Slider(
              value: _beatsPerMinute,
              min: 60,
              max: 360,
              divisions: 60,
              label: 'Beats Per Minute',
              onChanged: (double value) async {
                setState(() {
                  _beatsPerMinute = value;
                });
                await _engine.configRhythmPlayer(
                  AgoraRhythmPlayerConfig(
                      beatsPerMeasure: _beatsPerMeasure.toInt(),
                      beatsPerMinute: _beatsPerMinute.toInt()),
                );
              },
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
            if (isJoined) _buildRhythmPlayerOptions(),
          ],
        ),
      ],
    );
  }
}
