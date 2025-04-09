import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/stats_monitoring_widget.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// SendMultiCameraStreamMobile Example
class SendMultiCameraStreamMobile extends StatefulWidget {
  /// Construct the [SendMultiCameraStreamMobile]
  const SendMultiCameraStreamMobile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SendMultiCameraStreamMobile> {
  late final RtcEngineEx _engine;

  bool isJoined = false;

  Set<int> remoteUid = {};
  late TextEditingController _controller;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  final int localFrontCameraUid = 1234;
  final int localRearCameraUid = 5678;

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
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
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
        if (rUid == localFrontCameraUid || rUid == localRearCameraUid) return;

        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        if (rUid == localFrontCameraUid || rUid == localRearCameraUid) return;

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
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        logSink.log(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
      onLocalVideoStateChanged: (source, state, reason) {
        logSink.log(
            '[onLocalVideoStateChanged] source: $source state: $state reason: $reason');
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();

    // call this to enable multi camera on iOS
    if (Platform.isIOS) {
      // call this before any camera functions like startCameraCapture or startPreview will speed up the first frame rendering
      await _engine.enableMultiCamera(
          enabled: true,
          config: const CameraCapturerConfiguration(
            cameraDirection: CameraDirection.cameraRear,
          ));
    }

    // first camera, default is front camera
    await _engine.startCameraCapture(
        sourceType: VideoSourceType.videoSourceCamera,
        config: const CameraCapturerConfiguration(
            cameraDirection: CameraDirection.cameraFront));
    await _engine.startPreview(sourceType: VideoSourceType.videoSourceCamera);

    // second camera, default is rear camera
    await _engine.startCameraCapture(
        sourceType: VideoSourceType.videoSourceCameraSecondary,
        config: const CameraCapturerConfiguration(
            cameraDirection: CameraDirection.cameraRear));
    await _engine.startPreview(
        sourceType: VideoSourceType.videoSourceCameraSecondary);
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: localFrontCameraUid,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: true, // default is front camera
        publishSecondaryCameraTrack: false,
      ),
    );

    await _engine.joinChannelEx(
      token: config.token,
      connection: RtcConnection(
          localUid: localRearCameraUid, channelId: _controller.text),
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: false,
        publishSecondaryCameraTrack: true, // default is rear camera
        publishMicrophoneTrack: false,
        autoSubscribeAudio: false,
        autoSubscribeVideo: false,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Stack(
          children: [
            StatsMonitoringWidget(
              rtcEngine: _engine,
              uid: 0,
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _engine,
                  useFlutterTexture: false,
                  canvas: const VideoCanvas(
                      uid: 0, sourceType: VideoSourceType.videoSourceCamera),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  SizedBox(
                      width: 200,
                      height: 200,
                      child: StatsMonitoringWidget(
                          rtcEngine: _engine,
                          uid: localRearCameraUid,
                          child: AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              useFlutterTexture: false,
                              canvas: const VideoCanvas(
                                  uid: 0,
                                  sourceType: VideoSourceType
                                      .videoSourceCameraSecondary),
                            ),
                          ))),
                  ...List.of(remoteUid.map(
                    (e) => SizedBox(
                      width: 200,
                      height: 200,
                      child: StatsMonitoringWidget(
                        rtcEngine: _engine,
                        uid: e,
                        channelId: _controller.text,
                        child: AgoraVideoView(
                          controller: VideoViewController.remote(
                              rtcEngine: _engine,
                              canvas: VideoCanvas(uid: e),
                              connection:
                                  RtcConnection(channelId: _controller.text)),
                        ),
                      ),
                    ),
                  )),
                ]),
              ),
            )
          ],
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
            const SizedBox(
              height: 20,
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
          ],
        );
      },
    );
    // if (!_isInit) return Container();
  }
}
