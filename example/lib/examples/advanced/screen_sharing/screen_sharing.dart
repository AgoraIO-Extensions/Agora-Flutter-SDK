import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:agora_rtc_ng_example/config/agora.config.dart' as config;
import 'package:agora_rtc_ng_example/examples/example_actions_widget.dart';
import 'package:agora_rtc_ng_example/examples/log_sink.dart';
import 'package:flutter/material.dart';

/// ScreenSharing Example
class ScreenSharing extends StatefulWidget {
  /// Construct the [ScreenSharing]
  const ScreenSharing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ScreenSharing> {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;
  String channelId = config.channelId;
  bool isJoined = false;
  List<int> remoteUid = [];
  late TextEditingController _controller;
  List<ScreenCaptureSourceInfo> _screenCaptureSourceInfos = [];
  late ScreenCaptureSourceInfo _selectedScreenCaptureSourceInfo;
  bool _isScreenShared = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
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

    _engine.registerEventHandler(RtcEngineEventHandler(
      onWarning: (warn, msg) {
        logSink.log('[onWarning] warn: $warn, msg: $msg');
      },
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
      onLocalVideoStateChanged: (RtcConnection connection,
          LocalVideoStreamState state, LocalVideoStreamError errorCode) {},
    ));

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    setState(() {
      _isReadyPreview = true;
    });

    await _initScreenCaptureSourceInfos();
  }

  Future<void> _initScreenCaptureSourceInfos() async {
    Size thumbSize = const Size(width: 360, height: 240);
    Size iconSize = const Size(width: 360, height: 240);
    _screenCaptureSourceInfos = await _engine.getScreenCaptureSources(
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
        onChanged: _isScreenShared
            ? null
            : (v) {
                setState(() {
                  _selectedScreenCaptureSourceInfo = v!;
                });
              });
  }

  void _joinChannel() async {
    await _engine.joinChannelEx(
        token: '',
        connection: RtcConnection(channelId: _controller.text, localUid: 1000),
        options: const ChannelMediaOptions(
          publishCameraTrack: true,
          publishAudioTrack: false,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));

    await _engine.joinChannelEx(
        token: '',
        connection: RtcConnection(channelId: _controller.text, localUid: 1001),
        options: const ChannelMediaOptions(
          publishScreenTrack: true,
          publishCameraTrack: false,
          publishAudioTrack: false,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
  }

  _leaveChannel() async {
    _stopScreenShare();
    await _engine.leaveChannel();
  }

  Future<void> _startScreenShare() async {
    final windowId = _selectedScreenCaptureSourceInfo.sourceId;
    await _engine.startScreenCaptureByWindowId(
      windowId: windowId!,
      regionRect: const Rectangle(),
      captureParams: const ScreenCaptureParameters(
        captureMouseCursor: true,
        frameRate: 30,
      ),
    );
    setState(() {
      _isScreenShared = !_isScreenShared;
    });
  }

  Future<void> _stopScreenShare() async {
    if (!_isScreenShared) return;

    await _engine.stopScreenCapture();
    setState(() {
      _isScreenShared = !_isScreenShared;
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
                        )),
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
          mainAxisSize: MainAxisSize.min,
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
            _createDropdownButton(),
            if (_screenCaptureSourceInfos.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _isScreenShared
                          ? _stopScreenShare
                          : _startScreenShare,
                      child: Text(
                          '${_isScreenShared ? 'Stop' : 'Start'} screen share'),
                    ),
                  )
                ],
              ),
            // _renderVideo(),
          ],
        );
      },
    );
  }
}
