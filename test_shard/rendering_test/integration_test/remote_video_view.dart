import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

import 'agora_video_view_render_test.dart';
import 'common/widget_tester_ext.dart';

class RemoteVideoView extends StatefulWidget {
  const RemoteVideoView({
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
  State<RemoteVideoView> createState() => _RemoteVideoViewState();
}

class _RemoteVideoViewState extends State<RemoteVideoView> {
  late final RtcEngineEventHandler rtcEngineEventHandler;
  late final RtcEngineEx rtcEngine;
  late final MediaPlayerController mediaPlayerController;
  late final MediaPlayerSourceObserver mediaPlayerSourceObserver;
  late final VideoFrameObserver videoFrameObserver;
  final Completer<void> _initializationDone = Completer<void>();
  Completer<void>? _mediaPlayerPlayed;
  bool isMpkJoined = false;
  bool _isDisposed = false;
  bool _rtcEngineInitialized = false;
  bool _mediaPlayerInitialized = false;
  bool _eventHandlerRegistered = false;
  bool _videoFrameObserverRegistered = false;
  bool _sourceObserverRegistered = false;

  static const int _myUid = 12345;
  static const int _mpkRemoteUid = 67890;
  static const String _channelId = 'rendering_test';

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
      );
    } else {
      mediaPlayerController = MediaPlayerController(
        rtcEngine: rtcEngine,
        canvas: VideoCanvas(
          uid: 0,
          renderMode: widget.renderModeType,
          mirrorMode: widget.mirrorModeType,
        ),
      );
    }

    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));
    _rtcEngineInitialized = true;
    if (_isDisposed) return;

    rtcEngineEventHandler = RtcEngineEventHandler(
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        if (!_isDisposed && mounted && remoteUid == _mpkRemoteUid) {
          setState(() {
            isMpkJoined = true;
          });
        }
      },
    );

    rtcEngine.registerEventHandler(rtcEngineEventHandler);
    _eventHandlerRegistered = true;

    videoFrameObserver = VideoFrameObserver(
      onRenderVideoFrame: (channelId, remoteUid, videoFrame) {
        // Delay 2 seconds to ensure the first frame showed
        Future.delayed(const Duration(seconds: 2), () {
          if (_isDisposed) return;
          widget.onRendered(rtcEngine);
        });
      },
    );

    rtcEngine.getMediaEngine().registerVideoFrameObserver(videoFrameObserver);
    _videoFrameObserverRegistered = true;

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

    await rtcEngine.joinChannelEx(
      token: '',
      connection: const RtcConnection(
        channelId: _channelId,
        localUid: _myUid,
      ),
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
        enableAudioRecordingOrPlayout: true,
        publishMicrophoneTrack: false,
        publishCameraTrack: false,
      ),
    );
    if (_isDisposed) return;

    await mediaPlayerControllerPlayed.future;
    if (_isDisposed) return;

    // Simulate a remote user join
    await rtcEngine.joinChannelEx(
      token: '',
      connection: const RtcConnection(
        channelId: _channelId,
        localUid: _mpkRemoteUid,
      ),
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: false,
        autoSubscribeVideo: false,
        enableAudioRecordingOrPlayout: false,
        publishMediaPlayerAudioTrack: true,
        publishMediaPlayerVideoTrack: true,
        publishMediaPlayerId: mediaPlayerController.getMediaPlayerId(),
      ),
    );
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
      rtcEngine
          .getMediaEngine()
          .unregisterVideoFrameObserver(videoFrameObserver);
      _videoFrameObserverRegistered = false;
    }
    if (_eventHandlerRegistered) {
      rtcEngine.unregisterEventHandler(rtcEngineEventHandler);
      _eventHandlerRegistered = false;
    }
    if (_sourceObserverRegistered) {
      mediaPlayerController
          .unregisterPlayerSourceObserver(mediaPlayerSourceObserver);
      _sourceObserverRegistered = false;
    }
    if (_rtcEngineInitialized) {
      await rtcEngine.leaveChannel();
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
    if (!isMpkJoined) {
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
                controller: VideoViewController.remote(
                  rtcEngine: rtcEngine,
                  canvas: VideoCanvas(
                    uid: _mpkRemoteUid,
                    renderMode: widget.renderModeType,
                    mirrorMode: widget.mirrorModeType,
                  ),
                  connection: const RtcConnection(
                    channelId: _channelId,
                    localUid: _myUid,
                  ),
                  useFlutterTexture: widget.useFlutterTexture,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
