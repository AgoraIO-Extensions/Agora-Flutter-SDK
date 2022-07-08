import 'dart:io';

import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:agora_rtc_ng_example/config/agora.config.dart' as config;
import 'package:agora_rtc_ng_example/examples/example_actions_widget.dart';
import 'package:agora_rtc_ng_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// TakeSnapshot Example
class TakeSnapshot extends StatefulWidget {
  /// Construct the [TakeSnapshot]
  const TakeSnapshot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TakeSnapshot> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  late TextEditingController _uidController;
  String _snapshotPath = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);
    _uidController = TextEditingController(text: config.uid.toString());

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

    _engine.registerEventHandler(RtcEngineEventHandler(onWarning: (warn, msg) {
      logSink.log('[onWarning] warn: $warn, msg: $msg');
    }, onError: (ErrorCodeType err, String msg) {
      logSink.log('[onError] err: $err, msg: $msg');
    }, onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      logSink.log(
          '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
      setState(() {
        isJoined = true;
      });
    }, onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
      logSink.log(
          '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
      setState(() {
        remoteUid.add(rUid);
      });
    }, onUserOffline:
        (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
      logSink.log(
          '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
      setState(() {
        remoteUid.removeWhere((element) => element == rUid);
      });
    }, onLeaveChannel: (RtcConnection connection, RtcStats stats) {
      logSink.log(
          '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
      setState(() {
        isJoined = false;
        remoteUid.clear();
      });
    }, onSnapshotTaken: (RtcConnection connection, String filePath, int width,
        int height, int errCode) {
      logSink.log(
          '[onSnapshotTaken] connection: ${connection.toJson()}, filePath: $filePath, width: $width, height: $height, errCode: $errCode');
      setState(() {
        _snapshotPath = filePath;
      });
    }));

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      info: '',
      uid: config.uid,
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      _snapshotPath = '';
    });
  }

  Future<void> _takeSnapshot() async {
    Directory appDocDir = defaultTargetPlatform == TargetPlatform.android
        ? (await getExternalStorageDirectory())!
        : await getApplicationDocumentsDirectory();
    String p = path.join(appDocDir.path, 'snapshot.jpeg');

    SnapShotConfig config = SnapShotConfig(
      channel: _controller.text,
      uid: int.parse(_uidController.text),
      filePath: p,
    );
    await _engine.takeSnapshot(config);
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return _renderVideo();
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
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
            TextField(
              controller: _uidController,
              decoration: const InputDecoration(
                  hintText: 'Remote uid for take snapshot'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined ? _takeSnapshot : null,
              child: const Text('Take Snapshot'),
            ),
            const SizedBox(
              height: 20,
            ),
            _snapshotPath.isNotEmpty
                ? Image.file(
                    File(_snapshotPath),
                    width: 150,
                    height: 200,
                  )
                : Container(
                    width: 150,
                    height: 200,
                    color: Colors.blueGrey.shade100,
                    child: const Text('Snapshot'),
                  ),
          ],
        );
      },
    );
  }

  Widget _renderVideo() {
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
                children: List.of(
              remoteUid.map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: AgoraVideoView(
                          controller: VideoViewController.remote(
                            rtcEngine: _engine,
                            canvas: VideoCanvas(uid: e),
                            connection:
                                RtcConnection(channelId: _controller.text),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Text('uid: $e'),
                      )
                    ],
                  )),
            )),
          ),
        ),
      ],
    );
  }
}
