import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class StringUid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StringUid> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  String stringUid = config.stringUid;
  bool isJoined = false;
  TextEditingController? _controller0, _controller1;

  @override
  void initState() {
    super.initState();
    _controller0 = TextEditingController(text: channelId);
    _controller1 = TextEditingController(text: stringUid);
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

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        log('warning ${warningCode}');
      },
      error: (errorCode) {
        log('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
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
        config.token, channelId, stringUid);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _getUserInfo() {
    _engine.getUserInfoByUserAccount(stringUid).then((userInfo) {
      log('getUserInfoByUserAccount ${userInfo.toJson()}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${userInfo.toJson()}'),
      ));
    }).catchError((err) {
      log('getUserInfoByUserAccount ${err}');
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
              decoration: InputDecoration(hintText: 'Channel ID'),
              onChanged: (text) {
                setState(() {
                  channelId = text;
                });
              },
            ),
            TextField(
              controller: _controller1,
              decoration: InputDecoration(hintText: 'String User ID'),
              onChanged: (text) {
                setState(() {
                  stringUid = text;
                });
              },
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: this._getUserInfo,
                child: Text('Get userInfo'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
