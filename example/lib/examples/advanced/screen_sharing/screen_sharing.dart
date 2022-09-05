import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ScreenSharing Example
class ScreenSharing extends StatefulWidget {
  /// Construct the [ScreenSharing]
  const ScreenSharing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ScreenSharing> with KeepRemoteVideoViewsMixin {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;
  String channelId = config.channelId;
  bool isJoined = false;
  late TextEditingController _controller;
  late final TextEditingController _localUidController;
  late final TextEditingController _screenShareUidController;

  bool _isScreenShared = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _localUidController = TextEditingController(text: '1000');
    _screenShareUidController = TextEditingController(text: '1001');
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.release();
  }

  _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await _engine.setLogLevel(LogLevel.logLevelError);

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
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));

    await _engine.enableVideo();
    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 1920, height: 1080),
        frameRate: 15,
        bitrate: 0,
      ),
    );
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
    final localUid = int.tryParse(_localUidController.text);
    if (localUid != null) {
      await _engine.joinChannelEx(
          token: '',
          connection:
              RtcConnection(channelId: _controller.text, localUid: localUid),
          options: const ChannelMediaOptions(
            publishCameraTrack: true,
            publishMicrophoneTrack: true,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
          ));
    }

    final shareShareUid = int.tryParse(_screenShareUidController.text);
    if (shareShareUid != null) {
      await _engine.joinChannelEx(
          token: '',
          connection: RtcConnection(
              channelId: _controller.text, localUid: shareShareUid),
          options: const ChannelMediaOptions(
            autoSubscribeVideo: true,
            autoSubscribeAudio: true,
            publishScreenTrack: true,
            publishSecondaryScreenTrack: true,
            publishCameraTrack: false,
            publishMicrophoneTrack: false,
            publishScreenCaptureAudio: true,
            publishScreenCaptureVideo: true,
            clientRoleType: ClientRoleType.clientRoleBroadcaster,
          ));
    }
  }

  Future<void> _updateScreenShareChannelMediaOptions() async {
    final shareShareUid = int.tryParse(_screenShareUidController.text);
    if (shareShareUid == null) return;
    await _engine.updateChannelMediaOptionsEx(
      options: const ChannelMediaOptions(
        publishScreenTrack: true,
        publishSecondaryScreenTrack: true,
        publishCameraTrack: false,
        publishMicrophoneTrack: false,
        publishScreenCaptureAudio: true,
        publishScreenCaptureVideo: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      connection:
          RtcConnection(channelId: _controller.text, localUid: shareShareUid),
    );
  }

  _leaveChannel() async {
    await _engine.stopScreenCapture();
    await _engine.leaveChannel();
    setState(() {
      _isScreenShared = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        final children = <Widget>[
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: AgoraVideoView(
                  controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(
                  uid: 0,
                ),
              )),
            ),
          ),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: _isScreenShared
                  ? AgoraVideoView(
                      controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(
                        uid: 0,
                        sourceType: VideoSourceType.videoSourceScreen,
                      ),
                    ))
                  : Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Text('Screen Sharing View'),
                      ),
                    ),
            ),
          ),
        ];
        Widget localVideoView;
        if (isLayoutHorizontal) {
          localVideoView = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          );
        } else {
          localVideoView = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          );
        }
        return Stack(
          children: [
            localVideoView,
            Align(
              alignment: Alignment.topLeft,
              child: RemoteVideoViewsWidget(
                key: keepRemoteVideoViewsKey,
                rtcEngine: _engine,
                channelId: _controller.text,
                connectionUid: int.tryParse(_localUidController.text),
              ),
            )
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            TextField(
              controller: _localUidController,
              decoration: const InputDecoration(hintText: 'Local Uid'),
            ),
            TextField(
              controller: _screenShareUidController,
              decoration: const InputDecoration(hintText: 'Screen Sharing Uid'),
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
            if (defaultTargetPlatform == TargetPlatform.android ||
                defaultTargetPlatform == TargetPlatform.iOS)
              ScreenShareMobile(
                  rtcEngine: _engine,
                  isScreenShared: _isScreenShared,
                  onStartScreenShared: () {
                    if (isJoined) {
                      _updateScreenShareChannelMediaOptions();
                    }
                    setState(() {
                      _isScreenShared = !_isScreenShared;
                    });
                  },
                  onStopScreenShare: () {
                    setState(() {
                      _isScreenShared = !_isScreenShared;
                    });
                  }),
            if (defaultTargetPlatform == TargetPlatform.windows ||
                defaultTargetPlatform == TargetPlatform.macOS)
              ScreenShareDesktop(
                  rtcEngine: _engine,
                  isScreenShared: _isScreenShared,
                  onStartScreenShared: () {
                    if (isJoined) {
                      _updateScreenShareChannelMediaOptions();
                    }
                    setState(() {
                      _isScreenShared = !_isScreenShared;
                    });
                  },
                  onStopScreenShare: () {
                    setState(() {
                      _isScreenShared = !_isScreenShared;
                    });
                  }),
          ],
        );
      },
    );
  }
}

class ScreenShareMobile extends StatefulWidget {
  const ScreenShareMobile(
      {Key? key,
      required this.rtcEngine,
      required this.isScreenShared,
      required this.onStartScreenShared,
      required this.onStopScreenShare})
      : super(key: key);

  final RtcEngine rtcEngine;
  final bool isScreenShared;
  final VoidCallback onStartScreenShared;
  final VoidCallback onStopScreenShare;

  @override
  State<ScreenShareMobile> createState() => _ScreenShareMobileState();
}

class _ScreenShareMobileState extends State<ScreenShareMobile>
    implements ScreenShareInterface {
  @override
  bool get isScreenShared => widget.isScreenShared;

  @override
  void onStartScreenShared() {
    widget.onStartScreenShared();
  }

  @override
  void onStopScreenShare() {
    widget.onStopScreenShare();
  }

  @override
  RtcEngine get rtcEngine => widget.rtcEngine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: !isScreenShared ? startScreenShare : stopScreenShare,
            child: Text('${isScreenShared ? 'Stop' : 'Start'} screen share'),
          ),
        )
      ],
    );
  }

  @override
  void startScreenShare() async {
    if (isScreenShared) return;

    await rtcEngine.startScreenCapture(
        const ScreenCaptureParameters2(captureAudio: true, captureVideo: true));
    await rtcEngine.startPreview(sourceType: VideoSourceType.videoSourceScreen);
    onStartScreenShared();
  }

  @override
  void stopScreenShare() async {
    if (!isScreenShared) return;

    await rtcEngine.stopScreenCapture();
    onStopScreenShare();
  }
}

class ScreenShareDesktop extends StatefulWidget {
  const ScreenShareDesktop(
      {Key? key,
      required this.rtcEngine,
      required this.isScreenShared,
      required this.onStartScreenShared,
      required this.onStopScreenShare})
      : super(key: key);

  final RtcEngine rtcEngine;
  final bool isScreenShared;
  final VoidCallback onStartScreenShared;
  final VoidCallback onStopScreenShare;

  @override
  State<ScreenShareDesktop> createState() => _ScreenShareDesktopState();
}

class _ScreenShareDesktopState extends State<ScreenShareDesktop>
    implements ScreenShareInterface {
  List<ScreenCaptureSourceInfo> _screenCaptureSourceInfos = [];
  late ScreenCaptureSourceInfo _selectedScreenCaptureSourceInfo;

  @override
  bool get isScreenShared => widget.isScreenShared;

  @override
  void onStartScreenShared() {
    widget.onStartScreenShared();
  }

  @override
  void onStopScreenShare() {
    widget.onStopScreenShare();
  }

  @override
  RtcEngine get rtcEngine => widget.rtcEngine;

  Future<void> _initScreenCaptureSourceInfos() async {
    SIZE thumbSize = const SIZE(width: 360, height: 240);
    SIZE iconSize = const SIZE(width: 360, height: 240);
    _screenCaptureSourceInfos = await rtcEngine.getScreenCaptureSources(
        thumbSize: thumbSize, iconSize: iconSize, includeScreen: true);
    _selectedScreenCaptureSourceInfo = _screenCaptureSourceInfos[0];
    setState(() {});
  }

  Widget _createDropdownButton() {
    if (_screenCaptureSourceInfos.isEmpty) return Container();
    return DropdownButton<ScreenCaptureSourceInfo>(
        items: _screenCaptureSourceInfos.map((info) {
          return DropdownMenuItem(
            value: info,
            child: Text('${info.sourceName}',
                style: const TextStyle(fontSize: 10)),
          );
        }).toList(),
        value: _selectedScreenCaptureSourceInfo,
        onChanged: isScreenShared
            ? null
            : (v) {
                setState(() {
                  _selectedScreenCaptureSourceInfo = v!;
                });
              });
  }

  @override
  void initState() {
    super.initState();

    _initScreenCaptureSourceInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createDropdownButton(),
        if (_screenCaptureSourceInfos.isNotEmpty)
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed:
                      !isScreenShared ? startScreenShare : stopScreenShare,
                  child:
                      Text('${isScreenShared ? 'Stop' : 'Start'} screen share'),
                ),
              )
            ],
          ),
      ],
    );
  }

  @override
  void startScreenShare() async {
    if (isScreenShared) return;

    final sourceId = _selectedScreenCaptureSourceInfo.sourceId;

    if (_selectedScreenCaptureSourceInfo.type ==
        ScreenCaptureSourceType.screencapturesourcetypeScreen) {
      await rtcEngine.startScreenCaptureByDisplayId(
          displayId: sourceId!,
          regionRect: const Rectangle(x: 0, y: 0, width: 0, height: 0),
          captureParams: const ScreenCaptureParameters(
            captureMouseCursor: true,
            frameRate: 30,
          ));
    } else if (_selectedScreenCaptureSourceInfo.type ==
        ScreenCaptureSourceType.screencapturesourcetypeWindow) {
      await rtcEngine.startScreenCaptureByWindowId(
        windowId: sourceId!,
        regionRect: const Rectangle(x: 0, y: 0, width: 0, height: 0),
        captureParams: const ScreenCaptureParameters(
          captureMouseCursor: true,
          frameRate: 30,
        ),
      );
    }

    onStartScreenShared();
  }

  @override
  void stopScreenShare() async {
    if (!isScreenShared) return;

    await rtcEngine.stopScreenCapture();
    onStopScreenShare();
  }
}

abstract class ScreenShareInterface {
  void onStartScreenShared();

  void onStopScreenShare();

  bool get isScreenShared;

  RtcEngine get rtcEngine;

  void startScreenShare();

  void stopScreenShare();
}
