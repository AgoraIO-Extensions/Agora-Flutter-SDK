import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import '../fake/fake_iris_method_channel.dart';

class _RenderViewWidget extends StatefulWidget {
  const _RenderViewWidget({
    Key? key,
    required this.builder,
    required this.rtcEngine,
  }) : super(key: key);

  final Function(BuildContext context, RtcEngine engine) builder;

  final RtcEngine rtcEngine;

  @override
  State<_RenderViewWidget> createState() => _RenderViewWidgetState();
}

class _RenderViewWidgetState extends State<_RenderViewWidget> {
  late final RtcEngine _engine;

  @override
  void initState() {
    super.initState();
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
    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    _engine = widget.rtcEngine;
    await _engine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    try {
      await _engine.enableVideo();
      await _engine.startPreview();
    } catch (e) {
      debugPrint(e.toString());
    }

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.builder(context, _engine),
      ),
    );
  }
}

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
    'Show local AgoraVideoView after RtcEngine.initialize',
    (WidgetTester tester) async {
      final irisMethodChannel = FakeIrisMethodChannel();
      final rtcEngine =
          RtcEngineImpl.create(irisMethodChannel: irisMethodChannel);

      await tester.pumpWidget(_RenderViewWidget(
        rtcEngine: rtcEngine,
        builder: (context, engine) {
          return SizedBox(
            height: 100,
            width: 100,
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));
      // pumpAndSettle again to ensure the `AgoraVideoView` shown
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      if (defaultTargetPlatform == TargetPlatform.android) {
        expect(find.byType(AndroidView), findsOneWidget);
      }

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        expect(find.byType(UiKitView), findsOneWidget);
      }

      final setupLocalVideoCalls = irisMethodChannel.methodCallQueue
          .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
          .toList();

      final jsonMap2 = jsonDecode(setupLocalVideoCalls[0].params);
      expect(jsonMap2['canvas']['view'] != 0, isTrue);

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(AgoraVideoView), findsNothing);
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'onAgoraVideoViewCreated should be called after AgoraVideoView created',
    (WidgetTester tester) async {
      final rtcEngine = createAgoraRtcEngine();
      final videoViewCreatedCompleter = Completer<bool>();

      await tester.pumpWidget(_RenderViewWidget(
        rtcEngine: rtcEngine,
        builder: (context, engine) {
          return SizedBox(
            height: 100,
            width: 100,
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: engine,
                canvas: const VideoCanvas(uid: 0),
              ),
              onAgoraVideoViewCreated: (viewId) {
                if (!videoViewCreatedCompleter.isCompleted) {
                  videoViewCreatedCompleter.complete(true);
                }
              },
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));
      // pumpAndSettle again to ensure the `AgoraVideoView` shown
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      final videoViewCreatedCalled = await videoViewCreatedCompleter.future;
      expect(videoViewCreatedCalled, isTrue);

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(AgoraVideoView), findsNothing);
    },
  );

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

  testWidgets(
    'Switch local/remote AgoraVideoView with RtcConnection',
    (WidgetTester tester) async {
      final irisMethodChannel = FakeIrisMethodChannel();
      final rtcEngine =
          RtcEngineImpl.create(irisMethodChannel: irisMethodChannel);

      await tester.pumpWidget(_RenderViewWidget(
        rtcEngine: rtcEngine,
        builder: (context, engine) {
          return Column(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: engine,
                    canvas: const VideoCanvas(uid: 1000),
                    connection: const RtcConnection(
                      channelId: 'switch_video_view',
                      localUid: 1000,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));
      // pumpAndSettle again to ensure the `AgoraVideoView` shown
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      if (defaultTargetPlatform == TargetPlatform.android) {
        expect(find.byType(AndroidView), findsNWidgets(2));
      }

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        expect(find.byType(UiKitView), findsNWidgets(2));
      }

      // Clear the methodCall records
      irisMethodChannel.reset();

      await tester.pumpWidget(_RenderViewWidget(
        rtcEngine: rtcEngine,
        builder: (context, engine) {
          return Column(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: engine,
                    canvas: const VideoCanvas(uid: 1000),
                    connection: const RtcConnection(
                      channelId: 'switch_video_view',
                      localUid: 1000,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                ),
              )
            ],
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));
      if (defaultTargetPlatform == TargetPlatform.android) {
        expect(find.byType(AndroidView), findsNWidgets(2));
      }
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        expect(find.byType(UiKitView), findsNWidgets(2));
      }

      final setupRemoteVideoExCalls = irisMethodChannel.methodCallQueue
          .where((e) => e.funcName == 'RtcEngineEx_setupRemoteVideoEx')
          .toList();

      final jsonMap1 = jsonDecode(setupRemoteVideoExCalls[0].params);
      expect(jsonMap1['canvas']['view'] == 0, isTrue);

      final jsonMap2 = jsonDecode(setupRemoteVideoExCalls[1].params);
      expect(jsonMap2['canvas']['view'] != 0, isTrue);

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );
}
