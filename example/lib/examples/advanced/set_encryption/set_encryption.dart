// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// SetEncryption Example
// ignore: use_key_in_widget_constructors
class SetEncryption extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SetEncryptionState();
}

class _SetEncryptionState extends State<SetEncryption> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  String channelId = config.channelId;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  late TextEditingController _controller;
  Set<int> remoteUid = {};

  // Only take 3 EncryptionMode for demo purpose
  final List<EncryptionMode> encryptionModes = [
    EncryptionMode.aes128Gcm2,
    EncryptionMode.aes128Xts,
    EncryptionMode.aes256Gcm,
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
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.remove(rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          remoteUid.clear();
          isJoined = false;
        });
      },
      onEncryptionError:
          (RtcConnection connection, EncryptionErrorType errorType) {
        logSink.log(
            '[onEncryptionError] connection: ${connection.toJson()} errorType: ${errorType}');
      },
    ));

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _destroy() async {
    _leaveChannel();
    await _engine.release();
  }

  Future<void> _joinChannel() async {
    final EncryptionConfig encryptionConfig = EncryptionConfig(
      encryptionMode: _selectedEncryptionMode,
      encryptionKey: _encryptionKey.text,
      encryptionKdfSalt:
          Uint8List.fromList(utf8.encode(_encryptionKdfSalt.text)),
    );
    await _engine.enableEncryption(enabled: true, config: encryptionConfig);

    await _engine.joinChannel(
        token: config.token,
        channelId: _controller.text,
        uid: config.uid,
        options: const ChannelMediaOptions());
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.of(remoteUid.map(
                    (e) => SizedBox(
                      width: 120,
                      height: 120,
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          canvas: VideoCanvas(uid: e),
                          connection:
                              RtcConnection(channelId: _controller.text),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            )
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        final dropDownMenus = <DropdownMenuItem<EncryptionMode>>[];
        for (var v in encryptionModes) {
          dropDownMenus.add(DropdownMenuItem(
            child: Text(
              '$v',
              style: const TextStyle(fontSize: 12),
            ),
            value: v,
          ));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
              // onChanged: (text) {
              //   setState(() {
              //     channelId = text;
              //   });
              // },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Encryption Mode: '),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
            const SizedBox(
              height: 20,
            ),
            const Text('Input Encryption Key: '),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _encryptionKey,
                    readOnly: isJoined,
                    decoration:
                        const InputDecoration(hintText: 'Encryption Key'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Input EncryptionKdfSalt: '),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
      },
    );
  }
}
