import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:flutter/material.dart';

/// SetVideoEncoderConfiguration Example
class SetVideoEncoderConfiguration extends StatefulWidget {
  /// Construct the [SetVideoEncoderConfiguration]
  const SetVideoEncoderConfiguration({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SetVideoEncoderConfigurationState();
}

class _SetVideoEncoderConfigurationState
    extends State<SetVideoEncoderConfiguration> with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  String channelId = config.channelId;
  bool isJoined = false;
  bool switchCamera = true;
  late TextEditingController _channelIdController;
  int _selectedDimensionIndex = 0;
  List<VideoDimensions> dimensions = const [
    VideoDimensions(width: 640, height: 480),
    VideoDimensions(width: 480, height: 480),
    VideoDimensions(width: 480, height: 240),
  ];
  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.release();
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
        setState(() {});
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {});
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
        token: config.token,
        channelId: channelId,
        uid: config.uid,
        options: const ChannelMediaOptions());
    await setVideoEncoderConfiguration(dim: _selectedDimensionIndex);
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> setVideoEncoderConfiguration({int dim = 0}) async {
    if (dim >= dimensions.length) {
      logSink.log("Invalid dimension choice!");
      return;
    }

    VideoEncoderConfiguration config = VideoEncoderConfiguration(
      dimensions: dimensions[dim],
      frameRate: FrameRate.frameRateFps15.value(),
      bitrate: 0,
      minBitrate: -1,
      orientationMode: OrientationMode.orientationModeAdaptive,
      degradationPreference: DegradationPreference.maintainFramerate,
      mirrorMode: VideoMirrorModeType.videoMirrorModeAuto,
    );
    await _engine.setVideoEncoderConfiguration(config);
  }

  @override
  Widget build(BuildContext context) {
    final dimesionsMenus = <DropdownMenuItem<int>>[];
    for (int i = 0; i < dimensions.length; i++) {
      final e = dimensions[i];
      dimesionsMenus.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          'width: ${e.width}, height: ${e.height}',
          style: const TextStyle(fontSize: 13),
        ),
      ));
    }

    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                  rtcEngine: _engine, canvas: const VideoCanvas(uid: 0)),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RemoteVideoViewsWidget(
                key: keepRemoteVideoViewsKey,
                rtcEngine: _engine,
                channelId: _channelIdController.text,
              ),
            ),
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _channelIdController,
              decoration: const InputDecoration(hintText: 'Channel ID'),
              onChanged: (text) {
                setState(() {
                  channelId = text;
                });
              },
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
            const Text('Video dimensions: '),
            DropdownButton<int>(
              value: _selectedDimensionIndex,
              items: dimesionsMenus,
              onChanged: (value) {
                setState(() {
                  _selectedDimensionIndex = value!;
                });

                setVideoEncoderConfiguration(dim: _selectedDimensionIndex);
              },
            ),
          ],
        );
      },
    );
  }
}
