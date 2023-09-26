import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

import 'fake_camera.dart';

class FakeCameraRemoteVideoView extends StatefulWidget {
  const FakeCameraRemoteVideoView(
      {Key? key,
      required this.rtcEngine,
      required this.onFirstFrame,
      required this.builder})
      : super(key: key);

  final VoidCallback onFirstFrame;
  final Widget Function(
          BuildContext context, String channelId, int localUid, int remoteUid)
      builder;
  final RtcEngine rtcEngine;

  @override
  State<FakeCameraRemoteVideoView> createState() =>
      _FakeCameraRemoteVideoViewState();
}

class _FakeCameraRemoteVideoViewState extends State<FakeCameraRemoteVideoView> {
  static const int _myUid = 12345;
  static const int _remoteUid = 67890;
  static const String _channelId = 'rendering_test';

  late final RtcEngine _rtcEngine;
  late final FakeCamera _fakeCamera;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _init() async {
    _rtcEngine = widget.rtcEngine;

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');
    await _rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    _rtcEngine.registerEventHandler(RtcEngineEventHandler(
      onUserJoined: (connection, remoteUid, elapsed) {
        if (remoteUid == _remoteUid) {
          _waitFirstFrame();
        }
      },
    ));

    _fakeCamera = FakeCamera(_rtcEngine);
    await _fakeCamera.initialize();

    await _rtcEngine.enableVideo();

    await (_rtcEngine as RtcEngineEx).joinChannelEx(
      token: '',
      connection: const RtcConnection(
        channelId: _channelId,
        localUid: _myUid,
      ),
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishMicrophoneTrack: false,
        publishCameraTrack: false,
      ),
    );

    // Simulate a remote user join
    await (_rtcEngine as RtcEngineEx).joinChannelEx(
      token: '',
      connection: const RtcConnection(
        channelId: _channelId,
        localUid: _remoteUid,
      ),
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: false,
        autoSubscribeVideo: false,
        publishCustomVideoTrack: true,
      ),
    );
  }

  Future<void> _waitFirstFrame() async {
    await _fakeCamera.onFirstFrame;
    widget.onFirstFrame();
  }

  Future<void> _dispose() async {
    await _fakeCamera.dispose();
    await _rtcEngine.release();
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
              child: widget.builder(context, _channelId, _myUid, _remoteUid),
            ),
          ),
        ),
      ),
    );
  }
}
