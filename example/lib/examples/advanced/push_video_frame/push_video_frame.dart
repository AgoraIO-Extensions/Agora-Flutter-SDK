import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// PushVideoFrame Example
class PushVideoFrame extends StatefulWidget {
  /// Construct the [PushVideoFrame]
  const PushVideoFrame({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PushVideoFrame> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;

  late final Uint8List _imageByteData;
  late final int _imageWidth;
  late final int _imageHeight;

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
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    await _engine.setLogFilter(LogFilterType.logFilterError);

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

    await _engine
        .getMediaEngine()
        .setExternalVideoSource(enabled: true, useTexture: false);

    await _engine.enableVideo();

    await _loadImageByteData();

    await _engine.startPreview(sourceType: VideoSourceType.videoSourceCustom);

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
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

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _loadImageByteData() async {
    ByteData data = await rootBundle.load("assets/agora-logo.png");
    Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    ui.Image image = await decodeImageFromList(bytes);

    final byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawStraightRgba);

    _imageByteData = byteData!.buffer.asUint8List();
    _imageWidth = image.width;
    _imageHeight = image.height;
    image.dispose();
  }

  Future<void> _pushVideoFrame() async {
    VideoPixelFormat format = VideoPixelFormat.videoPixelRgba;
    if (kIsWeb) {
      // TODO(littlegnal): https://github.com/flutter/flutter/issues/135409
      // The `Image.toByteData(format: ui.ImageByteFormat.rawStraightRgba)` return
      // bgra at this time.
      format = VideoPixelFormat.videoPixelBgra;
    }
    await _engine.getMediaEngine().pushVideoFrame(
        frame: ExternalVideoFrame(
            type: VideoBufferType.videoBufferRawData,
            format: format,
            buffer: _imageByteData,
            stride: _imageWidth,
            height: _imageHeight,
            timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine,
            canvas: const VideoCanvas(
              uid: 0,
              sourceType: VideoSourceType.videoSourceCustom,
            ),
          ),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/agora-logo.png'),
            ),
            const Text('Push Image as Video Frame'),
            ElevatedButton(
              onPressed: isJoined ? _pushVideoFrame : null,
              child: const Text('Push Video Frame'),
            ),
          ],
        );
      },
    );
  }
}
