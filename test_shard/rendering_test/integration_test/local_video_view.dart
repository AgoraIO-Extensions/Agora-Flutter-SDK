import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

import 'agora_video_view_render_test.dart';

class LocalVideoView extends StatefulWidget {
  const LocalVideoView({
    Key? key,
    required this.onRendered,
    this.useFlutterTexture = false,
    this.renderModeType,
    this.mirrorModeType,
    this.isRenderModeTest = true,
    this.url =
        'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt.mp4',
  }) : super(key: key);

  final Function(RtcEngineEx rtcEngine) onRendered;
  final bool useFlutterTexture;
  final RenderModeType? renderModeType;
  final VideoMirrorModeType? mirrorModeType;
  final bool isRenderModeTest;
  final String url;

  @override
  State<LocalVideoView> createState() => _LocalVideoViewState();
}

class _LocalVideoViewState extends State<LocalVideoView> {
  late final RtcEngineEx rtcEngine;
  late final MediaPlayerController mediaPlayerController;
  late final MediaPlayerVideoFrameObserver observer;
  late final MediaPlayerSourceObserver mediaPlayerSourceObserver;

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    rtcEngine = createAgoraRtcEngineEx();

    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    await rtcEngine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 800,
      ),
    );

    if (widget.isRenderModeTest) {
      mediaPlayerController = TestMediaPlayerController(
        rtcEngine: rtcEngine,
        canvas: VideoCanvas(
          uid: 0,
          renderMode: widget.renderModeType,
          mirrorMode: widget.mirrorModeType,
        ),
        useFlutterTexture: widget.useFlutterTexture,
      );
    } else {
      mediaPlayerController = MediaPlayerController(
        rtcEngine: rtcEngine,
        canvas: VideoCanvas(
          uid: 0,
          renderMode: widget.renderModeType,
          mirrorMode: widget.mirrorModeType,
        ),
        useFlutterTexture: widget.useFlutterTexture,
      );
    }

    await mediaPlayerController.initialize();

    observer = MediaPlayerVideoFrameObserver(
      onFrame: (frame) {
        widget.onRendered(rtcEngine);
      },
    );
    mediaPlayerController.registerVideoFrameObserver(observer);

    final mediaPlayerControllerPlayed = Completer<void>();

    mediaPlayerSourceObserver = MediaPlayerSourceObserver(
      onPlayerSourceStateChanged:
          (MediaPlayerState state, MediaPlayerError ec) async {
        if (state == MediaPlayerState.playerStateOpenCompleted) {
          await mediaPlayerController.play();
          await mediaPlayerController.setLoopCount(99999);
          mediaPlayerControllerPlayed.complete();
        }
      },
    );
    mediaPlayerController
        .registerPlayerSourceObserver(mediaPlayerSourceObserver);

    await mediaPlayerController.open(url: widget.url, startPos: 0);

    await mediaPlayerControllerPlayed.future;
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    mediaPlayerController.unregisterVideoFrameObserver(observer);
    await mediaPlayerController.dispose();
    await rtcEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: AgoraVideoView(
                controller: mediaPlayerController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
