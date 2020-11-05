import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  RtcEngine _engine = null;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  String channelId = config.channelId;
  bool isJoined = false, switchCamera = true;
  int remoteUid;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    widget._engine?.destroy();
  }

  _initEngine() async {
    widget._engine = await RtcEngine.create(config.appId);
    this._addListeners();

    await widget._engine.enableVideo();
    await widget._engine.startPreview();
    await widget._engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await widget._engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    widget._engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined  ${uid} ${elapsed}');
        setState(() {
          remoteUid = uid;
        });
      },
      userOffline: (uid, reason) {
        log('userOffline  ${uid} ${reason}');
        if (uid == remoteUid) {
          setState(() {
            remoteUid = null;
          });
        }
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
      await [Permission.microphone, Permission.camera].request();
    }
    await widget._engine?.joinChannel(config.token, channelId, null, 0);
  }

  _leaveChannel() async {
    await widget._engine?.leaveChannel();
  }

  _switchCamera() {
    widget._engine?.switchCamera()?.then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    })?.catchError((err) {
      log('switchCamera $err');
    });
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
                  child: RaisedButton(
                    onPressed:
                        isJoined ? this._leaveChannel : this._joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
            _renderVideo(),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                onPressed: this._switchCamera,
                child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
              ),
            ],
          ),
        )
      ],
    );
  }

  _renderVideo() {
    return Expanded(
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          remoteUid != null
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: RtcRemoteView.SurfaceView(
                      uid: remoteUid,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
