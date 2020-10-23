import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class JoinChannelAudio extends StatefulWidget {
  RtcEngine _engine = null;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  String channelId = config.channelId;
  bool isJoined = false, openMicrophone = true, enableSpeakerphone = true;
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

    await widget._engine.enableAudio();
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
    await widget._engine?.joinChannel(config.token, channelId, null, 0);
  }

  _leaveChannel() async {
    await widget._engine?.leaveChannel();
  }

  _switchMicrophone() {
    widget._engine?.enableLocalAudio(!openMicrophone)?.then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    })?.catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    widget._engine?.setEnableSpeakerphone(!enableSpeakerphone)?.then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    })?.catchError((err) {
      log('setEnableSpeakerphone $err');
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
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                onPressed: this._switchMicrophone,
                child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
              ),
              RaisedButton(
                onPressed: this._switchSpeakerphone,
                child: Text(enableSpeakerphone ? 'Speakerphone' : 'Earpiece'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
