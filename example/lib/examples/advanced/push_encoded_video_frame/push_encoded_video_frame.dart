import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// PushEncodedVideoFrame Example
class PushEncodedVideoFrame extends StatefulWidget {
  /// Construct the [PushEncodedVideoFrame]
  const PushEncodedVideoFrame({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PushEncodedVideoFrame> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
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
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
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
      onUserJoined:
          (RtcConnection connection, int remoteUid, int elapsed) async {
        await _engine.setRemoteVideoSubscriptionOptions(
            uid: remoteUid,
            options: const VideoSubscriptionOptions(encodedFrameOnly: true));
      },
    ));

    await _engine.getMediaEngine().setExternalVideoSource(
        enabled: true,
        useTexture: false,
        sourceType: ExternalVideoSourceType.encodedVideoFrame,
        encodedVideoOption:
            const SenderOptions(codecType: VideoCodecType.videoCodecGeneric));

    // enable video module and set up video encoding configs
    await _engine.enableVideo();

    _engine
        .getMediaEngine()
        .registerVideoEncodedFrameObserver(VideoEncodedFrameObserver(
      onEncodedVideoFrameReceived:
          (uid, imageBuffer, length, videoEncodedFrameInfo) {
        debugPrint(
            '[onEncodedVideoFrameReceived] uid: $uid imageBuffer: $imageBuffer, length: $length, videoEncodedFrameInfo: ${videoEncodedFrameInfo.toJson()}');
        try {
          _showMyDialog(uid, utf8.decode(imageBuffer));
        } catch (e, stacktrace) {
          debugPrint('${e.toString()}\nstacktrace: $stacktrace');
        }
      },
    ));

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
    await _engine.joinChannel(
        token: config.token,
        channelId: _channelIdController.text,
        uid: config.uid,
        options: const ChannelMediaOptions());
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
              children: <Widget>[Text(data)],
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

    final data = Uint8List.fromList(utf8.encode(_controller.text));
    await _engine.getMediaEngine().pushEncodedVideoImage(
        imageBuffer: data,
        length: data.length,
        videoEncodedFrameInfo: const EncodedVideoFrameInfo(
            framesPerSecond: 60,
            codecType: VideoCodecType.videoCodecGeneric,
            frameType: VideoFrameType.videoFrameTypeKeyFrame));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();

        return const Center(
          child: Text('No Preview'),
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
                    onPressed: _onPressSend,
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
