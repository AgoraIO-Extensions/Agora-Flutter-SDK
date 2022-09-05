import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// StartDirectCDNStreaming Example
class StartDirectCDNStreaming extends StatefulWidget {
  /// Construct the [JoinChannelVideo]
  const StartDirectCDNStreaming({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StartDirectCDNStreaming> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  late TextEditingController _publishUrlController;
  late TextEditingController _heightController;
  late TextEditingController _widthController;
  late TextEditingController _fpsController;
  bool _isStartDirectCDNStreaming = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);
    _publishUrlController = TextEditingController(
        text: 'rtmp://push.alexmk.name/live/agora_rtc_engine');
    _widthController = TextEditingController(text: '360');
    _heightController = TextEditingController(text: '240');
    _fpsController = TextEditingController(text: '30');

    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _controller.dispose();
    _publishUrlController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _fpsController.dispose();

    if (_isStartDirectCDNStreaming) {
      await _engine.stopDirectCdnStreaming();
    }
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

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

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
        token: config.token,
        channelId: _controller.text,
        uid: config.uid,
        options: const ChannelMediaOptions());
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _startDirectCdnStreaming() async {
    await _engine.startPreview();
    await _engine.setDirectCdnStreamingAudioConfiguration(
        AudioProfileType.audioProfileDefault);
    await _engine
        .setDirectCdnStreamingVideoConfiguration(VideoEncoderConfiguration(
      codecType: VideoCodecType.videoCodecH264,
      dimensions: VideoDimensions(
        width: int.parse(_widthController.text),
        height: int.parse(_heightController.text),
      ),
      frameRate: int.parse(_fpsController.text),
      bitrate: 2260,
      minBitrate: defaultMinBitrate,
      orientationMode: OrientationMode.orientationModeFixedLandscape,
      degradationPreference: DegradationPreference.maintainQuality,
      mirrorMode: VideoMirrorModeType.videoMirrorModeDisabled,
    ));
    await _engine.startDirectCdnStreaming(
        eventHandler: DirectCdnStreamingEventHandler(
          onDirectCdnStreamingStateChanged: (state, error, message) {
            logSink.log(
                '[onDirectCdnStreamingStateChanged] state: $state, error: $error, message: $message');
            if (state ==
                DirectCdnStreamingState.directCdnStreamingStateRunning) {
              setState(() {
                _isStartDirectCDNStreaming = true;
              });
            } else if (state ==
                    DirectCdnStreamingState.directCdnStreamingStateStopped ||
                state ==
                    DirectCdnStreamingState.directCdnStreamingStateFailed) {
              setState(() {
                _isStartDirectCDNStreaming = false;
              });
            }
          },
          onDirectCdnStreamingStats: (DirectCdnStreamingStats stats) {
            logSink.log('[onDirectCdnStreamingStats] stats: ${stats.toJson()}');
          },
        ),
        publishUrl: _publishUrlController.text,
        options: const DirectCdnStreamingMediaOptions(
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
        ));
  }

  Future<void> _stopDirectCdnStreaming() async {
    if (_isStartDirectCDNStreaming) {
      await _engine.stopDirectCdnStreaming();
      setState(() {
        _isStartDirectCDNStreaming = !_isStartDirectCDNStreaming;
      });
    }
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.of(remoteUid.map(
                    (e) => SizedBox(
                      width: 120,
                      height: 120,
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          canvas: VideoCanvas(uid: e),
                          connection:
                              RtcConnection(channelId: _controller.text),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            )
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            TextField(
              controller: _publishUrlController,
              decoration: const InputDecoration(hintText: 'Publish Url'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('width: '),
                Expanded(
                  child: TextField(
                    readOnly: _isStartDirectCDNStreaming,
                    controller: _widthController,
                    decoration: const InputDecoration(
                      hintText: 'width',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('heigth: '),
                Expanded(
                  child: TextField(
                    readOnly: _isStartDirectCDNStreaming,
                    controller: _heightController,
                    decoration: const InputDecoration(
                      hintText: 'height',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('fps: '),
                Expanded(
                  child: TextField(
                    readOnly: _isStartDirectCDNStreaming,
                    controller: _fpsController,
                    decoration: const InputDecoration(
                      hintText: 'fps',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _isStartDirectCDNStreaming ? null : _switchCamera,
              child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _isStartDirectCDNStreaming
                        ? _stopDirectCdnStreaming
                        : _startDirectCdnStreaming,
                    child: Text(
                        '${_isStartDirectCDNStreaming ? 'Stop' : 'Start'}DirectCdnStreaming'),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
