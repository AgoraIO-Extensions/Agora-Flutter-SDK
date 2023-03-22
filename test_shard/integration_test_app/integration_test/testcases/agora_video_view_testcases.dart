import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import '../fake/fake_iris_method_channel.dart';

class MultipleVideoViewWithFlutterTexture extends StatefulWidget {
  const MultipleVideoViewWithFlutterTexture({
    Key? key,
    required this.onRendered,
    this.url =
        'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt.mp4',
  }) : super(key: key);

  final Function(RtcEngineEx rtcEngine) onRendered;

  final String url;

  @override
  State<MultipleVideoViewWithFlutterTexture> createState() =>
      _MultipleVideoViewWithFlutterTextureState();
}

class _MultipleVideoViewWithFlutterTextureState
    extends State<MultipleVideoViewWithFlutterTexture> {
  late final RtcEngineEx rtcEngine;
  late final MediaPlayerController mediaPlayerController;
  late final MediaPlayerController mediaPlayerController2;
  late final MediaPlayerController mediaPlayerController3;
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

    mediaPlayerController = MediaPlayerController(
      rtcEngine: rtcEngine,
      canvas: const VideoCanvas(uid: 0),
    );

    mediaPlayerController2 = MediaPlayerController(
      rtcEngine: rtcEngine,
      canvas: const VideoCanvas(uid: 0),
    );

    mediaPlayerController3 = MediaPlayerController(
      rtcEngine: rtcEngine,
      canvas: const VideoCanvas(uid: 0),
    );

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

    await mediaPlayerController.initialize();
    await mediaPlayerController2.initialize();
    await mediaPlayerController3.initialize();

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
    await mediaPlayerController2.open(url: widget.url, startPos: 0);
    await mediaPlayerController3.open(url: widget.url, startPos: 0);

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
    await mediaPlayerController2.dispose();
    await mediaPlayerController3.dispose();
    await rtcEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: mediaPlayerController,
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: mediaPlayerController2,
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: mediaPlayerController3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void testCases() {
  testWidgets(
    'Show multiple and then dispose AgoraVideoViews with no error',
    (WidgetTester tester) async {
      final readyRender = Completer<void>();
      await tester
          .pumpWidget(MultipleVideoViewWithFlutterTexture(onRendered: (engine) {
        if (!readyRender.isCompleted) {
          readyRender.complete(null);
        }
      }));

      await tester.pumpAndSettle(const Duration(seconds: 10));

      await readyRender.future;

      await tester.pumpAndSettle(const Duration(seconds: 10));
      // pumpAndSettle again to ensure the `AgoraVideoView` shown
      await tester.pumpAndSettle(const Duration(seconds: 10));

      await tester.pumpWidget(Container());
      // pumpAndSettle to ensure the dispose is called.
      await tester.pumpAndSettle(const Duration(seconds: 10));
      await Future.delayed(const Duration(seconds: 5));
    },
    skip: Platform.isAndroid,
  );
}
