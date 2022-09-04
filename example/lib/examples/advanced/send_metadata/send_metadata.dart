import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// StreamMessage Example
class SendMetadata extends StatefulWidget {
  /// Construct the [StreamMessage]
  const SendMetadata({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SendMetadata> {
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
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    _engine.release();
  }

  void _initEngine() async {
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
          remoteUids.clear();
          isJoined = false;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          remoteUids.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUids.remove(rUid);
        });
      },
    ));

    _engine.registerMediaMetadataObserver(
      observer: MetadataObserver(
        onMetadataReceived: (metadata) {
          logSink.log(
              '[onMetadataReceived] metadata: ${metadata.toJson()}, metadata.buffer: ${metadata.buffer}');
          debugPrint(
              '[onMetadataReceived] metadata: ${metadata.toJson()}, metadata.buffer: ${metadata.buffer}');
          debugPrint(
              '[onMetadataReceived] metadata: ${metadata.toJson()}, String.fromCharCodes(metadata.buffer!): ${String.fromCharCodes(metadata.buffer!)}');

          _showMyDialog(metadata.uid!,
              utf8.decode(metadata.buffer!, allowMalformed: true));
        },
      ),
      type: MetadataType.videoMetadata,
    );

    // enable video module and set up video encoding configs
    await _engine.enableVideo();

    // make this room live broadcasting room
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
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

    try {
      final data = Uint8List.fromList(utf8.encode(_controller.text));

      await _engine.sendMetaData(
          metadata: Metadata(buffer: data, size: data.length),
          sourceType: VideoSourceType.videoSourceCamera);

      _controller.clear();
    } catch (e) {
      logSink.log('sendMetaData error: ${e.toString()}');
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
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.of(remoteUids.map(
                    (e) => SizedBox(
                      width: 120,
                      height: 120,
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          canvas: VideoCanvas(uid: e),
                          connection: RtcConnection(
                              channelId: _channelIdController.text),
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
            // if (isJoined) _renderVideo(),
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
