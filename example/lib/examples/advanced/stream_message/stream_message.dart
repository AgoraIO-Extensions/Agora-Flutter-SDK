import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// StreamMessage Example
class StreamMessage extends StatefulWidget {
  /// Construct the [StreamMessage]
  const StreamMessage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StreamMessage> {
  late final RtcEngine _engine;
  bool isJoined = false;
  Set<int> remoteUids = {};
  late final TextEditingController _channelIdController;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  Future<void> _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListener();

    // enable video module and set up video encoding configs
    await _engine.enableVideo();

    // make this room live broadcasting room
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(
        config.token, _channelIdController.text, null, config.uid);
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _showMyDialog(int uid, int streamId, String data) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Receive from uid:$uid'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('StreamId $streamId:$data')],
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

  _addListener() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (RtcStats stats) {
        logSink.log('leaveChannel ${stats.toString()}');
        remoteUids.clear();
        setState(() {
          isJoined = false;
        });
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined $uid $elapsed');
        remoteUids.add(uid);
        setState(() {});
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline $uid $reason');
        remoteUids.remove(uid);
        setState(() {});
      },
      streamMessage: (int uid, int streamId, Uint8List data) {
        _showMyDialog(uid, streamId, utf8.decode(data));
        logSink.log('streamMessage $uid $streamId $data');
      },
      streamMessageError:
          (int uid, int streamId, ErrorCode error, int missed, int cached) {
        logSink.log('streamMessage $uid $streamId $error $missed $cached');
      },
    ));
  }

  Future<void> _onPressSend() async {
    if (_controller.text.isEmpty) {
      return;
    }

    try {
      var streamId = await _engine
          .createDataStreamWithConfig(DataStreamConfig(false, false));
      if (streamId != null) {
        await _engine.sendStreamMessage(
            streamId, Uint8List.fromList(utf8.encode(_controller.text)));
      }
      _controller.clear();
    } catch (e) {
      logSink.log('sendStreamMessage error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _channelIdController,
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
            if (isJoined) _renderVideo(),
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
                    onPressed: _onPressSend,
                    child: const Text('Send'),
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }

  Widget _renderVideo() {
    final views = <Widget>[
      const SizedBox(
        height: 120,
        width: 120,
        child: kIsWeb
            ? rtc_local_view.SurfaceView()
            : rtc_local_view.TextureView(),
      ),
    ];
    if (remoteUids.isNotEmpty) {
      views.addAll(remoteUids.map((uid) {
        return (kIsWeb
            ? SizedBox(
                height: 120,
                width: 120,
                child: rtc_remote_view.SurfaceView(
                  uid: uid,
                  channelId: config.channelId,
                ),
              )
            : SizedBox(
                height: 120,
                width: 120,
                child: rtc_remote_view.TextureView(
                  uid: uid,
                  channelId: config.channelId,
                ),
              ));
      }));
    } else {
      views.add(Container(
        color: Colors.grey[200],
      ));
    }
    return Wrap(children: views);
  }
}
