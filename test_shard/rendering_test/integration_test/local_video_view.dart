import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

import 'agora_video_view_render_test.dart';
import 'common/widget_tester_ext.dart';

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
  final Completer<void> _initializationDone = Completer<void>();
  Completer<void>? _mediaPlayerPlayed;
  bool _isDisposed = false;
  bool _rtcEngineInitialized = false;
  bool _mediaPlayerInitialized = false;
  bool _videoFrameObserverRegistered = false;
  bool _sourceObserverRegistered = false;

  @override
  void initState() {
    super.initState();

    _init().whenComplete(() {
      if (!_initializationDone.isCompleted) {
        _initializationDone.complete();
      }
    });
  }

  Future<void> _init() async {
    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    rtcEngine = createAgoraRtcEngineEx();

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

    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));
    _rtcEngineInitialized = true;
    if (_isDisposed) return;

    await rtcEngine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 800,
      ),
    );
    if (_isDisposed) return;

    await mediaPlayerController.initialize();
    _mediaPlayerInitialized = true;
    if (_isDisposed) return;

    observer = MediaPlayerVideoFrameObserver(
      onFrame: (frame) {
        if (_isDisposed) return;
        widget.onRendered(rtcEngine);
      },
    );
    mediaPlayerController.registerVideoFrameObserver(observer);
    _videoFrameObserverRegistered = true;

    final mediaPlayerControllerPlayed = Completer<void>();

    mediaPlayerSourceObserver = MediaPlayerSourceObserver(
      onPlayerSourceStateChanged:
          (MediaPlayerState state, MediaPlayerReason ec) async {
        if (state == MediaPlayerState.playerStateOpenCompleted) {
          if (_isDisposed) {
            if (!mediaPlayerControllerPlayed.isCompleted) {
              mediaPlayerControllerPlayed.complete();
            }
            return;
          }
          await mediaPlayerController.play();
          if (_isDisposed) return;
          await mediaPlayerController.setLoopCount(99999);
          if (!mediaPlayerControllerPlayed.isCompleted) {
            mediaPlayerControllerPlayed.complete();
          }
        }
      },
    );
    _mediaPlayerPlayed = mediaPlayerControllerPlayed;
    mediaPlayerController
        .registerPlayerSourceObserver(mediaPlayerSourceObserver);
    _sourceObserverRegistered = true;

    await mediaPlayerController.open(url: widget.url, startPos: 0);
    if (_isDisposed) return;

    await mediaPlayerControllerPlayed.future;
  }

  @override
  void dispose() {
    _isDisposed = true;
    queueDisposal(_dispose());
    super.dispose();
  }

  Future<void> _dispose() async {
    final mediaPlayerPlayed = _mediaPlayerPlayed;
    if (mediaPlayerPlayed != null && !mediaPlayerPlayed.isCompleted) {
      mediaPlayerPlayed.complete();
    }
    await _initializationDone.future;
    if (_videoFrameObserverRegistered) {
      mediaPlayerController.unregisterVideoFrameObserver(observer);
      _videoFrameObserverRegistered = false;
    }
    if (_sourceObserverRegistered) {
      mediaPlayerController.unregisterPlayerSourceObserver(
        mediaPlayerSourceObserver,
      );
      _sourceObserverRegistered = false;
    }
    if (_mediaPlayerInitialized) {
      await mediaPlayerController.dispose();
    }
    if (_rtcEngineInitialized) {
      await rtcEngine.release();
    }
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
