import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/basic_video_configuration_widget.dart';
import 'package:agora_rtc_engine_example/components/stats_monitoring_widget.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:permission_handler/permission_handler.dart';

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
      muteAllRemoteVideo = false,
      openMicrophone = true,
      muteMicrophone = false,
      muteAllRemoteAudio = false;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  bool _isUseFlutterTexture = false;
  bool _isUseAndroidSurfaceView = false;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

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

    if (defaultTargetPlatform == TargetPlatform.ohos) {
      await [Permission.microphone, Permission.camera].request();
    }

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
      onLocalVideoStateChanged: (VideoSourceType source,
          LocalVideoStreamState state, LocalVideoStreamReason error) {
        logSink.log(
            '[onLocalVideoStateChanged] source: $source, state: $state, error: $error');
      },
      onFirstRemoteVideoDecoded: (RtcConnection connection, int remoteUid,
          int width, int height, int elapsed) {
        logSink.log(
            '[onFirstRemoteVideoDecoded] connection: ${connection.toJson()} remoteUid: $remoteUid width: $width height: $height elapsed: $elapsed');
      },
      onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid,
          RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
        logSink.log(
            '[onRemoteAudioStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
      onAudioPublishStateChanged: (String channel, StreamPublishState oldState,
          StreamPublishState newState, int elapsed) {
        logSink.log(
            '[onAudioPublishStateChanged] channel: $channel oldState: $oldState newState: $newState elapsed: $elapsed');
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.setParameters('{"rtc.enable_debug_log": true}');
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
      openMicrophone = true;
      muteMicrophone = false;
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

  _openMicrophone() async {
    await _engine.enableLocalAudio(!openMicrophone);
    setState(() {
      openMicrophone = !openMicrophone;
    });
  }

  _muteMicrophoneStream() async {
    await _engine.muteLocalAudioStream(!muteMicrophone);
    setState(() {
      muteMicrophone = !muteMicrophone;
    });
  }

  _muteAllRemoteAudioStreams() async {
    await _engine.muteAllRemoteAudioStreams(!muteAllRemoteAudio);
    setState(() {
      muteAllRemoteAudio = !muteAllRemoteAudio;
    });
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
                  canvas: const VideoCanvas(uid: 0),
                  useFlutterTexture: _isUseFlutterTexture,
                  useAndroidSurfaceView: _isUseAndroidSurfaceView,
                ),
                onAgoraVideoViewCreated: (viewId) {
                  logSink.log('[onAgoraVideoViewCreated] viewId: $viewId');
                  _engine.startPreview();
                },
              ),
            ),
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
                          controller: VideoViewController.remote(
                            rtcEngine: _engine,
                            canvas: VideoCanvas(uid: e),
                            connection:
                                RtcConnection(
                                    channelId: _controller.text,
                                    localUid: config.uid),
                            useFlutterTexture: _isUseFlutterTexture,
                            useAndroidSurfaceView: _isUseAndroidSurfaceView,
                          ),
                          onAgoraVideoViewCreated: (viewId) {
                            logSink.log(
                                '[onAgoraVideoViewCreated] viewId: $viewId');
                          },
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
                    defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.ohos)) ...[
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _switchCamera,
                child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
              ),
            ],
            if (kIsWeb || defaultTargetPlatform == TargetPlatform.ohos) ...[
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _muteAllRemoteAudioStreams,
                child: Text(
                    'All Remote Audio ${muteAllRemoteAudio ? 'muted' : 'unmute'}'),
              ),
            ],
            if (!kIsWeb && defaultTargetPlatform == TargetPlatform.ohos) ...[
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _openMicrophone,
                child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _muteMicrophoneStream,
                child:
                    Text('Microphone ${muteMicrophone ? 'muted' : 'unmute'}'),
              ),
            ],
          ],
        );
      },
    );
    // if (!_isInit) return Container();
  }
}
