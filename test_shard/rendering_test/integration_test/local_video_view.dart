import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocalVideoView extends StatefulWidget {
  const LocalVideoView({
    Key? key,
    required this.onRendered,
    this.useFlutterTexture = false,
  }) : super(key: key);

  final Function(RtcEngineEx rtcEngine) onRendered;
  final bool useFlutterTexture;

  @override
  State<LocalVideoView> createState() => _LocalVideoViewState();
}

class _LocalVideoViewState extends State<LocalVideoView> {
  // late final RtcEngineEventHandler rtcEngineEventHandler;
  late final RtcEngineEx rtcEngine;
  late final MediaPlayerController mediaPlayerController;
  late final MediaPlayerVideoFrameObserver observer;
  late final MediaPlayerSourceObserver mediaPlayerSourceObserver;
  bool isInit = false;

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

    // rtcEngineEventHandler = RtcEngineEventHandler(
    //   onFirstLocalVideoFrame: (connection, width, height, elapsed) {
    //     print('bbbb');
    //     if (!widget.useFlutterTexture) {
    //       widget.onFirstFrame();
    //     }
    //   },
    // );

    // rtcEngine.registerEventHandler(rtcEngineEventHandler);

    await rtcEngine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 800,
      ),
    );

    mediaPlayerController = MediaPlayerController(
      rtcEngine: rtcEngine,
      canvas: const VideoCanvas(
        uid: 0,
        renderMode: RenderModeType.renderModeFit,
      ),
      useFlutterTexture: widget.useFlutterTexture,
    );
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

    await mediaPlayerController.open(
        url:
            'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt.mp4',
        startPos: 0);

    await mediaPlayerControllerPlayed.future;

    setState(() {
      isInit = true;
    });
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    // rtcEngine.unregisterEventHandler(rtcEngineEventHandler);
    mediaPlayerController.unregisterVideoFrameObserver(observer);
    await mediaPlayerController.dispose();
    await rtcEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      return Container();
    }
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
