import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class RemoteVideoView extends StatefulWidget {
  const RemoteVideoView({
    Key? key,
    required this.onRendered,
    this.useFlutterTexture = false,
  }) : super(key: key);

  final Function(RtcEngineEx rtcEngine) onRendered;
  final bool useFlutterTexture;

  @override
  State<RemoteVideoView> createState() => _RemoteVideoViewState();
}

class _RemoteVideoViewState extends State<RemoteVideoView> {
  late final RtcEngineEventHandler rtcEngineEventHandler;
  late final RtcEngineEx rtcEngine;
  late final MediaPlayerController mediaPlayerController;
  late final MediaPlayerSourceObserver mediaPlayerSourceObserver;
  late final VideoFrameObserver videoFrameObserver;
  bool isMpkJoined = false;

  static const int _myUid = 12345;
  static const int _mpkRemoteUid = 67890;
  static const String _channelId = 'rendering_test';

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

    rtcEngineEventHandler = RtcEngineEventHandler(
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        if (remoteUid == _mpkRemoteUid) {
          setState(() {
            isMpkJoined = true;
          });
        }
      },
    );

    rtcEngine.registerEventHandler(rtcEngineEventHandler);

    videoFrameObserver = VideoFrameObserver(
      onRenderVideoFrame: (channelId, remoteUid, videoFrame) {
        widget.onRendered(rtcEngine);
      },
    );

    rtcEngine.getMediaEngine().registerVideoFrameObserver(videoFrameObserver);

    await rtcEngine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 800,
      ),
    );

    mediaPlayerController = MediaPlayerController(
      rtcEngine: rtcEngine,
      canvas: const VideoCanvas(uid: 0),
    );
    await mediaPlayerController.initialize();

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

    await mediaPlayerControllerPlayed.future;

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
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    rtcEngine.getMediaEngine().unregisterVideoFrameObserver(videoFrameObserver);
    rtcEngine.unregisterEventHandler(rtcEngineEventHandler);
    mediaPlayerController
        .unregisterPlayerSourceObserver(mediaPlayerSourceObserver);
    await rtcEngine.leaveChannel();
    await mediaPlayerController.dispose();
    await rtcEngine.release();
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
                  canvas: const VideoCanvas(
                    uid: _mpkRemoteUid,
                    renderMode: RenderModeType.renderModeFit,
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
