// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// SetEncryption Example
// ignore: use_key_in_widget_constructors
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
  late TextEditingController _controller;

  // Only take 3 EncryptionMode for demo purpose
  final List<EncryptionMode> encryptionModes = [
    EncryptionMode.AES128GCM2,
    EncryptionMode.AES128XTS,
    EncryptionMode.AES256GCM,
  ];

  late EncryptionMode _selectedEncryptionMode;
  final TextEditingController _encryptionKey = TextEditingController();
  late final TextEditingController _encryptionKdfSalt;

  @override
  void initState() {
    super.initState();
    _selectedEncryptionMode = encryptionModes[0];
    _controller = TextEditingController(text: channelId);
    _encryptionKdfSalt =
        TextEditingController(text: 'EncryptionKdfSaltInBase64Strings');
    _initEngine();
  }

  @override
  void reassemble() {
    super.reassemble();
    _destroy();
  }

  @override
  void dispose() {
    _controller.dispose();
    _encryptionKey.dispose();
    _encryptionKdfSalt.dispose();
    _destroy();

    super.dispose();
  }

  Future<void> _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log(
            'joinChannelSuccess channel: ${channel}, uid: ${uid}, elapsed: ${elapsed}');
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

  Future<void> _destroy() async {
    await _leaveChannel();
    await _engine.destroy();
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    final EncryptionConfig encryptionConfig = EncryptionConfig(
      encryptionMode: _selectedEncryptionMode,
      encryptionKey: _encryptionKey.text,
      encryptionKdfSalt: utf8.encode(_encryptionKdfSalt.text),
    );
    await _engine.enableEncryption(true, encryptionConfig);

    await _engine
        .joinChannel(config.token, _controller.text, null, config.uid)
        .catchError((onError) {
      logSink.log('error ${onError.toString()}');
    });
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    final dropDownMenus = <DropdownMenuItem<EncryptionMode>>[];
    for (var v in encryptionModes) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text('$v'),
        value: v,
      ));
    }

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
            const Text('Encryption Mode: '),
            DropdownButton<EncryptionMode>(
              items: dropDownMenus,
              value: _selectedEncryptionMode,
              onChanged: isJoined
                  ? null
                  : (v) {
                      setState(() {
                        _selectedEncryptionMode = v!;
                      });
                    },
            ),
          ],
        ),
        Row(
          children: [
            const Text('Input Encryption Key: '),
            Expanded(
              child: TextField(
                controller: _encryptionKey,
                readOnly: isJoined,
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Input EncryptionKdfSalt: '),
            Expanded(
              child: TextField(
                controller: _encryptionKdfSalt,
                readOnly: isJoined,
              ),
            ),
          ],
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
    );
  }
}
