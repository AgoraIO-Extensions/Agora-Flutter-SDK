// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// StringUid Example
class StringUid extends StatefulWidget {
  /// Construct the [StringUid]
  const StringUid({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StringUid> {
  late final RtcEngine _engine;
  bool isJoined = false;
  late TextEditingController _controller0, _controller1;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  @override
  void initState() {
    super.initState();
    _controller0 = TextEditingController(text: config.channelId);
    _controller1 = TextEditingController(text: config.stringUid);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _rtcEngineEventHandler = RtcEngineEventHandler(
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
      onUserInfoUpdated: (int uid, UserInfo info) {
        logSink
            .log('[onUserInfoUpdated] uid: ${uid} UserInfo: ${info.toJson()}');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    );
    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  void _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    await _engine.joinChannelWithUserAccount(
        token: config.token,
        channelId: _controller0.text,
        userAccount: _controller1.text);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _getUserInfo() async {
    final userInfo = await _engine.getUserInfoByUserAccount(_controller1.text);
    // .then((userInfo) {
    logSink.log('getUserInfoByUserAccount ${userInfo.toJson()}');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${userInfo.toJson()}'),
    ));
    // }).catchError((err) {
    //   logSink.log('getUserInfoByUserAccount ${err}');
    // });
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
            TextField(
              controller: _controller1,
              decoration: const InputDecoration(hintText: 'String User ID'),
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
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _getUserInfo,
                child: const Text('Get userInfo'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
