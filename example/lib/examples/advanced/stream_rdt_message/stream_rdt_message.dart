import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// StreamRdtMessage Example
class StreamRdtMessage extends StatefulWidget {
  /// Construct the [StreamRdtMessage]
  const StreamRdtMessage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StreamRdtMessage> with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool isJoined = false;
  bool _isRdtStateOpened = false;
  late final TextEditingController _channelIdController;
  late final TextEditingController _myUidController;
  late final TextEditingController _toUidController;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _myUidController = TextEditingController(text: config.uid.toString());
    _toUidController = TextEditingController(text: '1000');
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
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
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      onRdtMessage: (connection, userId, type, data, length) {
        logSink.log(
            '[onRdtMessage] connection: ${connection.toJson()} userId: $userId, type: $type, data: $data, length: $length');
        _showMyDialog(userId, utf8.decode(data));
      },
      onRdtStateChanged: (connection, userId, state) {
        logSink.log(
            '[onRdtStateChanged] connection: ${connection.toJson()} userId: $userId, state: $state');

        if (state == RdtState.rdtStateOpened) {
          setState(() {
            _isRdtStateOpened = true;
          });
        }
      },
    ));

    // enable video module and set up video encoding configs
    await _engine.enableVideo();

    // make this room live broadcasting room
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    int? myUid = int.tryParse(_myUidController.text);
    if (myUid == null) {
      return;
    }

    await _engine.joinChannel(
        token: config.token,
        channelId: _channelIdController.text,
        uid: myUid,
        options: const ChannelMediaOptions(autoConnectRdt: true));
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _showMyDialog(int uid, String data) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Receive from uid:$uid'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('data: $data')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onPressSend() async {
    if (_controller.text.isEmpty) {
      return;
    }

    int? toUid = int.tryParse(_toUidController.text);
    if (toUid == null) {
      return;
    }

    try {
      final data = Uint8List.fromList(utf8.encode(_controller.text));

      await _engine.sendRdtMessage(
          uid: toUid,
          type: RdtStreamType.rdtStreamData,
          data: data,
          length: data.lengthInBytes);

      _controller.clear();
    } catch (e) {
      logSink.log('sendRdtMessage error: ${e.toString()}');
    }
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
                  rtcEngine: _engine, canvas: const VideoCanvas(uid: 0)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RemoteVideoViewsWidget(
                key: keepRemoteVideoViewsKey,
                rtcEngine: _engine,
                channelId: _controller.text,
                connectionUid: int.tryParse(_controller.text),
              ),
            )
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _channelIdController,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            TextField(
              controller: _myUidController,
              decoration: const InputDecoration(hintText: 'Input my uid'),
            ),
            TextField(
              controller: _toUidController,
              decoration: const InputDecoration(hintText: 'Input to uid'),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Input Message',
                          ))),
                  ElevatedButton(
                    onPressed: _isRdtStateOpened ? _onPressSend : null,
                    child: const Text('Send'),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
