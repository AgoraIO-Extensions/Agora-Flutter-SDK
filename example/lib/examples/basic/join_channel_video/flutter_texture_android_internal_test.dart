import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/basic_video_configuration_widget.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A case for internal testing only
class FlutterTextureAndroidTest extends StatefulWidget {
  /// Construct the [FlutterTextureAndroidTest]
  const FlutterTextureAndroidTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<FlutterTextureAndroidTest> {
  late final RtcEngine _engine;

  bool isJoined = false;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  static const bool _isUseFlutterTexture = true;
  bool _isAndroidTextureOes = false;
  bool _isAndroidYuv = false;
  bool _isAndroidTexture2D = false;
  bool _isStartedPreview = false;
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
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
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
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
                useFlutterTexture: _isUseFlutterTexture,
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
                          useFlutterTexture: _isUseFlutterTexture,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Video Format: textureoes'),
                          Switch(
                            value: _isAndroidTextureOes,
                            onChanged: isJoined
                                ? null
                                : (changed) {
                                    setState(() {
                                      _isAndroidTextureOes = changed;
                                    });

                                    if (_isAndroidTextureOes) {
                                      _engine.setParameters(
                                          '{"che.video.android_texture.copy_enable":false}');
                                    }
                                  },
                          ),
                          const Text('Video Format: textureo2d'),
                          Switch(
                            value: _isAndroidTexture2D,
                            onChanged: isJoined
                                ? null
                                : (changed) {
                                    setState(() {
                                      _isAndroidTexture2D = changed;
                                    });
                                    if (_isAndroidTexture2D) {
                                      _engine.setParameters(
                                          '{"che.video.android_texture.copy_enable":true}');
                                    }
                                  },
                          ),
                          const Text('Video Format: yuv'),
                          Switch(
                            value: _isAndroidYuv,
                            onChanged: isJoined
                                ? null
                                : (changed) {
                                    setState(() {
                                      _isAndroidYuv = changed;
                                    });
                                    if (_isAndroidYuv) {
                                      _engine.setParameters(
                                          '{"che.video.android_camera_output_type":0}');
                                    }
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
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
                    onPressed: () {
                      if (_isStartedPreview) {
                        _engine.stopPreview();
                      } else {
                        _engine.startPreview();
                      }
                      setState(() {
                        _isStartedPreview = !_isStartedPreview;
                      });
                    },
                    child:
                        Text('${_isStartedPreview ? 'Stop' : 'Start'} Preview'),
                  ),
                )
              ],
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
  }
}
