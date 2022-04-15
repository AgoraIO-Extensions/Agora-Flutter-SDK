import 'dart:io';

import 'package:agora_rtc_engine/media_recorder.dart' as media_recorder;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// MediaRecorder Example
class MediaRecorder extends StatefulWidget {
  /// @nodoc
  const MediaRecorder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MediaRecorder> {
  late final RtcEngine _engine;
  media_recorder.MediaRecorder? _mediaRecorder;

  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];
  late TextEditingController _controller;
  bool _isStartedMediaRecording = false;
  String _recordingFileStoragePath = '';

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
    await _mediaRecorder?.releaseRecorder();
    await _engine.destroy();
  }

  Future<void> _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
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
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      virtualBackgroundSourceEnabled:
          (bool enabled, VirtualBackgroundSourceStateReason reason) {
        logSink.log(
            'virtualBackgroundSourceEnabled enabled: $enabled, reason: $reason');
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined  $uid $elapsed');
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline  $uid $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        logSink.log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    await _engine.joinChannel(config.token, _controller.text, null, config.uid);
  }

  Future<void> _startMediaRecording() async {
    media_recorder.MediaRecorderObserver observer =
        media_recorder.MediaRecorderObserver(
      onRecorderStateChanged: (RecorderState state, RecorderErrorCode error) {
        logSink.log('onRecorderStateChanged state: $state, error: $error');
      },
      onRecorderInfoUpdated: (RecorderInfo info) {
        logSink.log('onRecorderInfoUpdated info: ${info.toJson()}');
      },
    );
    _mediaRecorder = media_recorder.MediaRecorder.getMediaRecorder(_engine,
        callback: observer);

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
    await _mediaRecorder?.stopRecording();
    setState(() {
      _recordingFileStoragePath = '';
      _isStartedMediaRecording = false;
    });
  }

  Future<void> _leaveChannel() async {
    await _stopMediaRecording();
    await _engine.leaveChannel();
  }

  void _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
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
            _renderVideo(),
          ],
        ),
      ],
    );
  }

  Widget _renderVideo() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            child: (kIsWeb)
                ? const rtc_local_view.SurfaceView(
                    zOrderMediaOverlay: true,
                    zOrderOnTop: true,
                  )
                : const rtc_local_view.TextureView(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(remoteUid.map(
                  (e) => GestureDetector(
                    onTap: _switchRender,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: (kIsWeb)
                          ? rtc_remote_view.SurfaceView(
                              uid: e,
                              channelId: _controller.text,
                            )
                          : rtc_remote_view.TextureView(
                              uid: e,
                              channelId: _controller.text,
                            ),
                    ),
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
