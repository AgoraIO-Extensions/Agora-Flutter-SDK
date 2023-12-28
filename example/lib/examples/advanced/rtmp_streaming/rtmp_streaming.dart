import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// RtmpStreaming Example
class RtmpStreaming extends StatefulWidget {
  /// Construct the [RtmpStreaming]
  const RtmpStreaming({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RtmpStreamingState();
}

class _RtmpStreamingState extends State<RtmpStreaming> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  String channelId = config.channelId;
  bool isJoined = false;
  bool switchCamera = true;
  late TextEditingController _channelIdController;
  late TextEditingController _rtmpUrlController;
  late final TextEditingController _channelUidController;

  bool _isStreaming = false;
  int _remoteUid = 0;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: channelId);
    _channelUidController = TextEditingController(text: '1001');
    _rtmpUrlController = TextEditingController();
    _initEngine();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
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
        _startTranscoding();
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          _remoteUid = rUid;
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          _remoteUid = 0;
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) async {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');

        if (_isStreaming && _rtmpUrlController.text.isNotEmpty) {
          await _engine.stopRtmpStream(_rtmpUrlController.text);
          _isStreaming = false;
        }

        setState(() {
          isJoined = false;
        });
      },
      onRtmpStreamingStateChanged: (String url, RtmpStreamPublishState state,
          RtmpStreamPublishReason errCode) {
        logSink.log(
            '[onRtmpStreamingStateChanged] url: $url state: $state, errCode: $errCode');
      },
      onRtmpStreamingEvent: (String url, RtmpStreamingEvent eventCode) {
        logSink.log('[onRtmpStreamingEvent] url: $url eventCode: $eventCode');
      },
    ));

    await _engine.enableVideo();
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
    final uid = int.tryParse(_channelUidController.text);
    if (uid == null) return;
    await _engine.joinChannel(
        token: config.token,
        channelId: _channelIdController.text,
        uid: uid,
        options: const ChannelMediaOptions());
  }

  void _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _startTranscoding({bool isRemoteUser = false}) async {
    final uid = int.tryParse(_channelUidController.text);
    if (uid == null) return;

    if (_isStreaming && !isRemoteUser) return;
    final streamUrl = _rtmpUrlController.text;

    _isStreaming = true;

    final List<TranscodingUser> transcodingUsers = [
      TranscodingUser(
        uid: uid,
        x: 0,
        y: 0,
        width: 360,
        height: 640,
        audioChannel: 0,
        alpha: 1.0,
      )
    ];

    int width = 360;
    int height = 640;

    if (isRemoteUser) {
      transcodingUsers.add(TranscodingUser(
        uid: _remoteUid,
        x: 360,
        y: 0,
        width: 360,
        height: 640,
        audioChannel: 0,
        alpha: 1.0,
      ));

      width = 720;
      height = 640;
    }

    final liveTranscoding = LiveTranscoding(
      transcodingUsers: transcodingUsers,
      userCount: transcodingUsers.length,
      width: width,
      height: height,
      videoBitrate: 400,
      videoCodecProfile: VideoCodecProfileType.videoCodecProfileHigh,
      videoGop: 30,
      videoFramerate: 15,
      lowLatency: false,
      audioSampleRate: AudioSampleRateType.audioSampleRate44100,
      audioBitrate: 48,
      audioChannels: 1,
      audioCodecProfile: AudioCodecProfileType.audioCodecProfileLcAac,
    );

    try {
      await _engine.startRtmpStreamWithTranscoding(
          url: streamUrl, transcoding: liveTranscoding);
    } catch (e) {
      logSink.log('startRtmpStreamWithTranscoding error: ${e.toString()}');
    }
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
            if (_remoteUid != 0)
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: _remoteUid != 0
                      ? AgoraVideoView(
                          controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          canvas: VideoCanvas(uid: _remoteUid),
                          connection: RtcConnection(
                              channelId: _channelIdController.text),
                        ))
                      : Container(
                          color: Colors.grey[200],
                        ),
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
            ),
            TextField(
              controller: _channelUidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel uid',
              ),
            ),
            TextField(
              controller: _rtmpUrlController,
              decoration: const InputDecoration(hintText: 'Input rtmp url'),
            ),
            Row(
              children: [
                Expanded(
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
  }
}
