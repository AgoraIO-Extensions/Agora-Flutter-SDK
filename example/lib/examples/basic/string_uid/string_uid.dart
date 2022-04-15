// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
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
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) {
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
    await _engine.joinChannelWithUserAccount(
        config.token, _controller0.text, _controller1.text);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _getUserInfo() {
    _engine.getUserInfoByUserAccount(_controller1.text).then((userInfo) {
      logSink.log('getUserInfoByUserAccount ${userInfo.toJson()}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${userInfo.toJson()}'),
      ));
    }).catchError((err) {
      logSink.log('getUserInfoByUserAccount ${err}');
    });
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
