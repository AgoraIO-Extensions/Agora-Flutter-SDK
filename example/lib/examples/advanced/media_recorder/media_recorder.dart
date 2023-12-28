import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;

/// MediaRecorder Example
class MediaRecorderExample extends StatefulWidget {
  /// @nodoc
  const MediaRecorderExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MediaRecorderExample> {
  late final RtcEngine _engine;

  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];
  late TextEditingController _controller;
  bool _isStartedMediaRecording = false;
  String _recordingFileStoragePath = '';
  bool _isReadyPreview = false;
  MediaRecorder? _mediaRecorder;

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
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
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
    ));

    await _engine.enableVideo();

    await _engine.startPreview();

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
      channelId: _controller.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _startMediaRecording() async {
    _mediaRecorder ??= await _engine.createMediaRecorder(
        RecorderStreamInfo(channelId: _controller.text, uid: 0));

    await _mediaRecorder?.setMediaRecorderObserver(MediaRecorderObserver(
      onRecorderStateChanged: (String channelId, int uid, RecorderState state,
          RecorderReasonCode error) {
        logSink.log(
            'onRecorderStateChanged channelId: $channelId, uid: $uid state: $state, error: $error');
      },
      onRecorderInfoUpdated: (String channelId, int uid, RecorderInfo info) {
        logSink.log(
            'onRecorderInfoUpdated channelId: $channelId, uid: $uid, info: ${info.toJson()}');
      },
    ));

    Directory appDocDir = Platform.isAndroid
        ? (await getExternalStorageDirectory())!
        : await getApplicationDocumentsDirectory();
    String p = path.join(appDocDir.path, 'example.mp4');
    await _mediaRecorder
        ?.startRecording(MediaRecorderConfiguration(storagePath: p));
    setState(() {
      _recordingFileStoragePath = 'Recording file storage path: $p';
      _isStartedMediaRecording = true;
    });
  }

  Future<void> _stopMediaRecording() async {
    if (_mediaRecorder != null) {
      await _mediaRecorder!.stopRecording();
      await _engine.destroyMediaRecorder(_mediaRecorder!);
      _mediaRecorder = null;
    }
    setState(() {
      _recordingFileStoragePath = '';
      _isStartedMediaRecording = false;
    });
  }

  Future<void> _leaveChannel() async {
    if (_isStartedMediaRecording) {
      await _stopMediaRecording();
    }

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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: isJoined
                      ? _isStartedMediaRecording
                          ? _stopMediaRecording
                          : _startMediaRecording
                      : null,
                  child: Text(
                      '${_isStartedMediaRecording ? 'Stop' : 'Start'} media recording'),
                ),
                Text(_recordingFileStoragePath),
              ],
            ),
          ],
        );
      },
    );
  }
}
