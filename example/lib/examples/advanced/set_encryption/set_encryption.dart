import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// SetEncryption Example
class SetEncryption extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SetEncryptionState();
}

class _SetEncryptionState extends State<SetEncryption> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void reassemble() {
    super.reassemble();
    _destroy();
  }

  @override
  void dispose() {
    super.dispose();
    _destroy();
  }

  Future<void> _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    this._addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        debugPrint('warning ${warningCode}');
      },
      error: (errorCode) {
        debugPrint('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        debugPrint(
            'joinChannelSuccess channel: ${channel}, uid: ${uid}, elapsed: ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) async {
        debugPrint('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));
  }

  Future<void> _destroy() async {
    await _leaveChannel();
    await _engine.destroy();
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    final EncryptionConfig encryptionConfig = EncryptionConfig(
      encryptionMode: EncryptionMode.AES128GCM2,
      encryptionKey: 'EncryptionKey',
      encryptionKdfSalt: utf8.encode('EncryptionKdfSaltInBase64Strings'),
    );
    await _engine.enableEncryption(true, encryptionConfig);

    await _engine
        .joinChannel(config.token, config.channelId, null, config.uid)
        .catchError((onError) {
      debugPrint('error ${onError.toString()}');
    });
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                onPressed: isJoined ? this._leaveChannel : this._joinChannel,
                child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
              ),
            )
          ],
        ),
      ],
    );
  }
}
