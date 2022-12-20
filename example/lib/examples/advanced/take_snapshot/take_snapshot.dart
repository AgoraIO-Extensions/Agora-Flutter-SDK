import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
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
  late final RtcEngineEventHandler _eventHandler;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  int _selectedUid = config.uid;
  String _snapshotPath = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);

    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_eventHandler);
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _eventHandler = RtcEngineEventHandler(
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
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
      onSnapshotTaken: (RtcConnection connection, int uid, String filePath,
          int width, int height, int errCode) async {
        logSink.log(
            '[onSnapshotTaken] connection: ${connection.toJson()}, uid: $uid, filePath: $filePath, width: $width, height: $height, errCode: $errCode');

        if (_snapshotPath.isNotEmpty) {
          final preSnapshotFile = File(_snapshotPath);
          if (await preSnapshotFile.exists()) {
            await preSnapshotFile.delete();
          }
        }

        setState(() {
          _snapshotPath = filePath;
        });
      },
    );
    _engine.registerEventHandler(_eventHandler);

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
        uid: config.uid,
        options: const ChannelMediaOptions());
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
    String p = path.join(appDocDir.path,
        'snapshot_${_selectedUid}_${DateTime.now().millisecondsSinceEpoch}.jpeg');

    await _engine.takeSnapshot(uid: _selectedUid, filePath: p);
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
            const SizedBox(
              height: 20,
            ),
            if (_isReadyPreview)
              UidDropdown(
                  rtcEngine: _engine,
                  initialUid: config.uid,
                  onUidSelected: (v) {
                    setState(() {
                      _selectedUid = v;
                    });
                  }),
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

class UidDropdown extends StatefulWidget {
  const UidDropdown(
      {Key? key,
      required this.rtcEngine,
      required this.initialUid,
      required this.onUidSelected})
      : super(key: key);

  final RtcEngine rtcEngine;

  final ValueChanged<int> onUidSelected;

  final int initialUid;

  @override
  State<UidDropdown> createState() => _UidDropdownState();
}

class _UidDropdownState extends State<UidDropdown> {
  late final RtcEngineEventHandler _eventHandler;
  final Set<int> _remoteUids = {};
  late int _selectedRemoteUid;

  @override
  void initState() {
    super.initState();

    _remoteUids.add(widget.initialUid);
    _selectedRemoteUid = _remoteUids.first;
    _eventHandler = RtcEngineEventHandler(
      onUserJoined: (connection, remoteUid, elapsed) {
        logSink.log('_UidDropdownState onUserJoined');
        setState(() {
          _remoteUids.add(remoteUid);
        });
      },
      onUserOffline: (RtcConnection connection, int remoteUid,
          UserOfflineReasonType reason) {
        setState(() {
          _remoteUids.remove(remoteUid);
        });
      },
    );
    widget.rtcEngine.registerEventHandler(_eventHandler);
  }

  @override
  void dispose() {
    widget.rtcEngine.unregisterEventHandler(_eventHandler);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Uids: '),
        DropdownButton<int>(
            items: _remoteUids.map((uid) {
              return DropdownMenuItem(
                value: uid,
                child: Text('$uid'),
              );
            }).toList(),
            value: _selectedRemoteUid,
            onChanged: (v) {
              _selectedRemoteUid = v!;
              widget.onUidSelected(_selectedRemoteUid);
              setState(() {});
            }),
      ],
    );
  }
}
