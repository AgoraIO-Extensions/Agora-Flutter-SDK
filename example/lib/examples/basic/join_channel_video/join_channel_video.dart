import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/basic_video_configuration_widget.dart';
import 'package:agora_rtc_engine_example/components/stats_monitoring_widget.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  /// Construct the [JoinChannelVideo]
  const JoinChannelVideo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;

  bool isJoined = false,
      switchCamera = true,
      switchRender = true,
      openCamera = true,
      muteCamera = false,
      muteAllRemoteVideo = false;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  VideoViewController? _remoteVideoController;
  bool test = false;
  bool _isUseFlutterTexture = true;
  bool _isUseAndroidSurfaceView = false;
  
  // Test switches
  bool _reuseController = true; // Whether to reuse controller
  bool _switchViewLevel = true; // Whether to switch view level when remote resolution changes
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late final RtcEngineEventHandler _rtcEngineEventHandler;
  // global key
  final GlobalKey _agoraVideoViewKey = GlobalKey();
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
    _engine = createAgoraRtcEngine();
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
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        logSink.log(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
      onFirstRemoteVideoDecoded: (RtcConnection connection, int remoteUid,
          int width, int height, int elapsed) {
        logSink.log(
            '[onFirstRemoteVideoDecoded] connection: ${connection.toJson()} remoteUid: $remoteUid width: $width height: $height elapsed: $elapsed');
      },
      onFirstRemoteVideoFrame: (RtcConnection connection, int remoteUid,
          int width, int height, int elapsed) {
        logSink.log(
            '[onFirstRemoteVideoFrame] connection: ${connection.toJson()} remoteUid: $remoteUid width: $width height: $height elapsed: $elapsed');
      },
      onVideoSizeChanged:
          (connection, sourceType, uid, width, height, rotation) {
        logSink.log(
            '[onVideoSizeChanged] connection: ${connection.toJson()} sourceType: $sourceType uid: $uid width: $width height: $height rotation: $rotation');
        
        if (_reuseController) {
          // Reuse controller
          _remoteVideoController ??= VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: uid),
            connection: connection,
            useFlutterTexture: _isUseFlutterTexture,
            useAndroidSurfaceView: _isUseAndroidSurfaceView,
          );
        } else {
          // Create new controller each time
          _remoteVideoController = VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: uid),
            connection: connection,
            useFlutterTexture: _isUseFlutterTexture,
            useAndroidSurfaceView: _isUseAndroidSurfaceView,
          );
        }
        
        if (_switchViewLevel) {
          // Switch view level
          test = !test;
        }
        setState(() {});
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    // await _engine.startPreview();
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      openCamera = true;
      muteCamera = false;
      muteAllRemoteVideo = false;
    });
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  _openCamera() async {
    await _engine.enableLocalVideo(!openCamera);
    setState(() {
      openCamera = !openCamera;
    });
  }

  _muteLocalVideoStream() async {
    await _engine.muteLocalVideoStream(!muteCamera);
    setState(() {
      muteCamera = !muteCamera;
    });
  }

  _muteAllRemoteVideoStreams() async {
    await _engine.muteAllRemoteVideoStreams(!muteAllRemoteVideo);
    setState(() {
      muteAllRemoteVideo = !muteAllRemoteVideo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Stack(
          children: [
            // StatsMonitoringWidget(
            //   rtcEngine: _engine,
            //   uid: 0,
            //   child: AgoraVideoView(
            //     controller: VideoViewController(
            //       rtcEngine: _engine,
            //       canvas: const VideoCanvas(uid: 0),
            //       useFlutterTexture: _isUseFlutterTexture,
            //       useAndroidSurfaceView: _isUseAndroidSurfaceView,
            //     ),
            //     onAgoraVideoViewCreated: (viewId) {
            //       _engine.startPreview();
            //     },
            //   ),
            // ),
            if (_remoteVideoController != null)
              if (test)
                Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.of(remoteUid.map(
                        (e) => SizedBox(
                          width: 200,
                          height: 200,
                          child: StatsMonitoringWidget(
                            rtcEngine: _engine,
                            uid: e,
                            channelId: _controller.text,
                            child: AgoraVideoView(
                              key: UniqueKey(),
                              // key: ValueKey(e),
                              controller: _remoteVideoController!,
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                )
              else if (remoteUid.isNotEmpty)
                Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: StatsMonitoringWidget(
                        rtcEngine: _engine,
                        uid: remoteUid.first,
                        channelId: _controller.text,
                        child: AgoraVideoView(
                          key: UniqueKey(),
                          // key: ValueKey(remoteUid.first),
                          controller: _remoteVideoController!,
                        ),
                      ),
                    ))
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        final channelProfileType = [
          ChannelProfileType.channelProfileLiveBroadcasting,
          ChannelProfileType.channelProfileCommunication,
        ];
        final items = channelProfileType
            .map((e) => DropdownMenuItem(
                  child: Text(
                    e.toString().split('.')[1],
                  ),
                  value: e,
                ))
            .toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            if (!kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS))
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Rendered by Flutter texture: '),
                        Switch(
                          value: _isUseFlutterTexture,
                          onChanged: isJoined
                              ? null
                              : (changed) {
                                  setState(() {
                                    _isUseFlutterTexture = changed;
                                  });
                                },
                        )
                      ]),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            const Text('Channel Profile: '),
            DropdownButton<ChannelProfileType>(
              items: items,
              value: _channelProfileType,
              onChanged: isJoined
                  ? null
                  : (v) {
                      setState(() {
                        _channelProfileType = v!;
                      });
                    },
            ),
            const SizedBox(
              height: 20,
            ),
            // Test switches area
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Test Switches',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Triggers onVideoSizeChanged when remote resolution changes',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reuse Controller', style: TextStyle(fontSize: 12)),
                            Text(
                              'ON: Reuse same controller\nOFF: Create new controller each time',
                              style: TextStyle(fontSize: 9, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _reuseController,
                        onChanged: isJoined
                            ? null
                            : (changed) {
                                setState(() {
                                  _reuseController = changed;
                                });
                              },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Switch View Level', style: TextStyle(fontSize: 12)),
                            Text(
                              'ON: Toggle test, switch layout\nOFF: View level unchanged',
                              style: TextStyle(fontSize: 9, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _switchViewLevel,
                        onChanged: (changed) {
                          setState(() {
                            _switchViewLevel = changed;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Current: test=$test, controller=${_remoteVideoController?.hashCode ?? "null"}',
                    style: const TextStyle(fontSize: 10, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BasicVideoConfigurationWidget(
              rtcEngine: _engine,
              title: 'Video Encoder Configuration',
              setConfigButtonText: const Text(
                'setVideoEncoderConfiguration',
                style: TextStyle(fontSize: 10),
              ),
              onConfigChanged: (width, height, frameRate, bitrate) {
                _engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
                  dimensions: VideoDimensions(width: width, height: height),
                  frameRate: frameRate,
                  bitrate: bitrate,
                ));
              },
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
            if (!kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS)) ...[
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _switchCamera,
                child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
              ),
            ],
            if (kIsWeb) ...[
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _muteLocalVideoStream,
                child: Text('Camera ${muteCamera ? 'muted' : 'unmute'}'),
              ),
              ElevatedButton(
                onPressed: _muteAllRemoteVideoStreams,
                child: Text(
                    'All Remote Camera ${muteAllRemoteVideo ? 'muted' : 'unmute'}'),
              ),
              ElevatedButton(
                onPressed: _openCamera,
                child: Text('Camera ${openCamera ? 'on' : 'off'}'),
              ),
            ],
          ],
        );
      },
    );
    // if (!_isInit) return Container();
  }
}
