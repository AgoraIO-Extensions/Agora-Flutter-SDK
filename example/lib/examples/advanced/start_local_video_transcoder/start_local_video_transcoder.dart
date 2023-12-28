import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// StartLocalVideoTranscoder Example
class StartLocalVideoTranscoder extends StatefulWidget {
  /// Construct the [StartLocalVideoTranscoder]
  const StartLocalVideoTranscoder({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<StartLocalVideoTranscoder> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  late final VideoDeviceManager _videoDeviceManager;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  late TextEditingController _mediaPlayerUrlController;
  late MediaPlayerController _mediaPlayerController;
  MediaPlayerSourceObserver? _mediaPlayerSourceObserver;
  List<TranscodingVideoStream> transcodingVideoStreams = [];
  List<VideoDeviceInfo> _videoDevices = [];
  bool _isStartLocalvideoTranscoder = false;
  bool _isSecondaryCameraSource = false;
  bool _isPrimaryScreenSource = false;
  bool _isMediaPlayerSource = false;
  bool _isRtcImagePngSource = false;
  bool _isRtcImageJpegSource = false;
  bool _isRtcImageGifSource = false;
  String _pngFilePath = '';
  String _jpgFilePath = '';
  String _gifFilePath = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);
    _mediaPlayerUrlController = TextEditingController(
        text:
            'https://agoracdn.s3.us-west-1.amazonaws.com/videos/Agora.io-Interactions.mp4');

    _initEngine();
    _initImageFiles();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _stopLocalVideoTranscoder();
    await _mediaPlayerController.dispose();

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
      onLocalVideoTranscoderError: (stream, error) {
        logSink
            .log('[onLocalVideoTranscoderError] stream: $stream error: $error');
      },
    ));

    _videoDeviceManager = _engine.getVideoDeviceManager();

    if (!(defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS)) {
      _videoDevices = await _videoDeviceManager.enumerateVideoDevices();
    }

    _mediaPlayerController = MediaPlayerController(
        rtcEngine: _engine, canvas: const VideoCanvas(uid: 0));
    await _mediaPlayerController.initialize();

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _initImageFiles() async {
    _pngFilePath = await _getFilePath('agora-logo.png');
    _jpgFilePath = await _getFilePath('jpg.jpg');
    _gifFilePath = await _getFilePath('gif.gif');

    setState(() {});
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        publishCameraTrack: false,
        publishSecondaryCameraTrack: false,
        publishTranscodedVideoTrack: true,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    // await _stopLocalVideoTranscoder();
    await _engine.leaveChannel();
  }

  LocalTranscoderConfiguration _createLocalTranscoderConfiguration() {
    return LocalTranscoderConfiguration(
      streamCount: transcodingVideoStreams.length,
      videoInputStreams: transcodingVideoStreams,
      videoOutputConfiguration: const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 320),
      ),
    );
  }

  Future<String> _getFilePath(String fileName) async {
    ByteData data = await rootBundle.load("assets/$fileName");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String p = path.join(appDocDir.path, fileName);
    final file = File(p);
    if (!(await file.exists())) {
      await file.create();
      await file.writeAsBytes(bytes);
    }

    return p;
  }

  Future<void> _startLocalVideoTranscoder() async {
    if (!(defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS)) {
      transcodingVideoStreams.add(const TranscodingVideoStream(
          sourceType: VideoSourceType.videoSourceCameraPrimary,
          width: 640,
          height: 320));

      final config = CameraCapturerConfiguration(
        format: const VideoFormat(width: 640, height: 320, fps: 30),
        deviceId: _videoDevices[0].deviceId,
      );

      await _engine.startCameraCapture(
          sourceType: VideoSourceType.videoSourceCameraPrimary, config: config);
    } else {
      transcodingVideoStreams.add(const TranscodingVideoStream(
          sourceType: VideoSourceType.videoSourceCameraPrimary,
          width: 160,
          height: 320));
    }

    await _engine
        .startLocalVideoTranscoder(_createLocalTranscoderConfiguration());
    await _engine.startPreview(
        sourceType: VideoSourceType.videoSourceTranscoded);
  }

  Future<void> _stopLocalVideoTranscoder() async {
    if (_isMediaPlayerSource) {
      await _mediaPlayerController.stop();
    }

    if (_isSecondaryCameraSource) {
      await _engine
          .stopCameraCapture(VideoSourceType.videoSourceCameraSecondary);
    }

    if (_isPrimaryScreenSource) {
      await _engine.stopScreenCapture();
    }

    await _engine.stopCameraCapture(VideoSourceType.videoSourceCameraPrimary);
    await _engine.stopLocalVideoTranscoder();
    await _engine.startPreview();
    transcodingVideoStreams.clear();
    _isSecondaryCameraSource = false;
    _isPrimaryScreenSource = false;
    _isMediaPlayerSource = false;
    _isRtcImagePngSource = false;
    _isRtcImageJpegSource = false;
    _isRtcImageGifSource = false;
  }

  Widget _transcoderOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text('Start Primary Camera Source By Default'),
        ElevatedButton(
          onPressed: () async {
            _isStartLocalvideoTranscoder = !_isStartLocalvideoTranscoder;

            if (_isStartLocalvideoTranscoder) {
              await _startLocalVideoTranscoder();
            } else {
              await _stopLocalVideoTranscoder();
            }

            setState(() {});
          },
          child: Text(
              '${_isStartLocalvideoTranscoder ? 'Stop' : 'Start'}LocalVideoTranscoder'),
        ),
        const SizedBox(
          height: 20,
        ),
        if (!(defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) ...[
          Wrap(
            children: [
              const Text('SecondaryCameraSource:'),
              Switch(
                value: _isSecondaryCameraSource,
                onChanged: _isStartLocalvideoTranscoder &&
                        _videoDevices.length >= 2
                    ? (v) async {
                        if (!v) {
                          await _engine.stopCameraCapture(
                              VideoSourceType.videoSourceCameraSecondary);
                          transcodingVideoStreams.removeWhere((element) =>
                              element.sourceType ==
                              VideoSourceType.videoSourceCameraSecondary);
                        } else {
                          transcodingVideoStreams.add(
                              const TranscodingVideoStream(
                                  sourceType: VideoSourceType
                                      .videoSourceCameraSecondary,
                                  width: 360,
                                  height: 240));

                          final config = CameraCapturerConfiguration(
                            format: const VideoFormat(
                                width: 640, height: 320, fps: 30),
                            deviceId: _videoDevices[1].deviceId,
                          );

                          await _engine.startCameraCapture(
                              sourceType:
                                  VideoSourceType.videoSourceCameraSecondary,
                              config: config);
                        }

                        await _engine.updateLocalTranscoderConfiguration(
                            _createLocalTranscoderConfiguration());

                        setState(() {
                          _isSecondaryCameraSource = !_isSecondaryCameraSource;
                        });
                      }
                    : null,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            children: [
              const Text('PrimaryScreenSource:'),
              Switch(
                value: _isPrimaryScreenSource,
                onChanged: _isStartLocalvideoTranscoder
                    ? (v) async {
                        if (!v) {
                          await _engine.stopScreenCapture();
                          transcodingVideoStreams.removeWhere((element) =>
                              element.sourceType ==
                              VideoSourceType.videoSourceScreen);
                        } else {
                          SIZE t = const SIZE(width: 360, height: 240);

                          SIZE s = const SIZE(width: 360, height: 240);

                          var info = await _engine.getScreenCaptureSources(
                              thumbSize: t, iconSize: s, includeScreen: true);

                          if (info.isNotEmpty) {
                            final item = info[0];
                            if (item.type ==
                                ScreenCaptureSourceType
                                    .screencapturesourcetypeWindow) {
                              await _engine.startScreenCaptureByWindowId(
                                windowId: item.sourceId!,
                                regionRect: const Rectangle(
                                    x: 0, y: 0, width: 0, height: 0),
                                captureParams: const ScreenCaptureParameters(),
                              );
                            } else if (item.type ==
                                ScreenCaptureSourceType
                                    .screencapturesourcetypeScreen) {
                              await _engine.startScreenCaptureByDisplayId(
                                displayId: item.sourceId!,
                                regionRect: const Rectangle(
                                    x: 0, y: 0, width: 0, height: 0),
                                captureParams: const ScreenCaptureParameters(
                                    captureMouseCursor: true, frameRate: 30),
                              );
                            }
                            transcodingVideoStreams.add(
                                const TranscodingVideoStream(
                                    sourceType:
                                        VideoSourceType.videoSourceScreen,
                                    x: 110,
                                    y: 110,
                                    width: 200,
                                    height: 200,
                                    zOrder: 20));
                          } else {
                            logSink.log('No Screen Capture Sources Avaliable');
                          }
                        }

                        await _engine.updateLocalTranscoderConfiguration(
                            _createLocalTranscoderConfiguration());

                        setState(() {
                          _isPrimaryScreenSource = !_isPrimaryScreenSource;
                        });
                      }
                    : null,
              )
            ],
          ),
        ],
        Wrap(
          children: [
            const Text('MediaPlayerSource:'),
            Switch(
              value: _isMediaPlayerSource,
              onChanged: _isStartLocalvideoTranscoder
                  ? (v) async {
                      if (!v) {
                        _mediaPlayerController.unregisterPlayerSourceObserver(
                            _mediaPlayerSourceObserver!);
                        await _mediaPlayerController.stop();
                        transcodingVideoStreams.removeWhere((element) =>
                            element.sourceType ==
                            VideoSourceType.videoSourceMediaPlayer);
                      } else {
                        _mediaPlayerSourceObserver ??=
                            MediaPlayerSourceObserver(
                          onPlayerSourceStateChanged: (state, ec) {
                            if (state ==
                                MediaPlayerState.playerStateOpenCompleted) {
                              _mediaPlayerController.play();
                            }
                          },
                        );

                        _mediaPlayerController.registerPlayerSourceObserver(
                            _mediaPlayerSourceObserver!);

                        _mediaPlayerController.open(
                          url: _mediaPlayerUrlController.text,
                          startPos: 0,
                        );

                        transcodingVideoStreams.add(TranscodingVideoStream(
                          sourceType: VideoSourceType.videoSourceMediaPlayer,
                          mediaPlayerId:
                              _mediaPlayerController.getMediaPlayerId(),
                          width: 360,
                          height: 240,
                          zOrder: 10,
                          alpha: 1,
                        ));
                      }

                      await _engine.updateLocalTranscoderConfiguration(
                          _createLocalTranscoderConfiguration());

                      setState(() {
                        _isMediaPlayerSource = !_isMediaPlayerSource;
                      });
                    }
                  : null,
            )
          ],
        ),
        TextField(
          controller: _mediaPlayerUrlController,
          decoration: const InputDecoration(hintText: 'Media Player Url'),
        ),
        SizedBox(
          width: 150,
          height: 100,
          child: _isMediaPlayerSource
              ? AgoraVideoView(
                  controller: _mediaPlayerController,
                )
              : Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: const Text('MediaPlayer source'),
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            const Text('RtcImagePngSource:'),
            Switch(
              value: _isRtcImagePngSource,
              onChanged: _isStartLocalvideoTranscoder
                  ? (v) async {
                      if (!v) {
                        transcodingVideoStreams.removeWhere((element) =>
                            element.sourceType ==
                            VideoSourceType.videoSourceRtcImagePng);
                      } else {
                        transcodingVideoStreams.add(TranscodingVideoStream(
                            sourceType: VideoSourceType.videoSourceRtcImagePng,
                            imageUrl: _pngFilePath,
                            x: 220,
                            y: 60,
                            width: 200,
                            height: 200));
                      }

                      await _engine.updateLocalTranscoderConfiguration(
                          _createLocalTranscoderConfiguration());

                      setState(() {
                        _isRtcImagePngSource = !_isRtcImagePngSource;
                      });
                    }
                  : null,
            )
          ],
        ),
        if (_pngFilePath.isNotEmpty)
          SizedBox(
            height: 100,
            width: 100,
            child: Image.file(File(_pngFilePath)),
          ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            const Text('RtcImageJpegSource:'),
            Switch(
              value: _isRtcImageJpegSource,
              onChanged: _isStartLocalvideoTranscoder
                  ? (v) async {
                      if (!v) {
                        transcodingVideoStreams.removeWhere((element) =>
                            element.sourceType ==
                            VideoSourceType.videoSourceRtcImageJpeg);
                      } else {
                        transcodingVideoStreams.add(TranscodingVideoStream(
                            sourceType: VideoSourceType.videoSourceRtcImageJpeg,
                            imageUrl: _jpgFilePath,
                            x: 360,
                            y: 0,
                            width: 100,
                            height: 200));
                      }

                      await _engine.updateLocalTranscoderConfiguration(
                          _createLocalTranscoderConfiguration());

                      setState(() {
                        _isRtcImageJpegSource = !_isRtcImageJpegSource;
                      });
                    }
                  : null,
            )
          ],
        ),
        if (_jpgFilePath.isNotEmpty)
          SizedBox(
            height: 100,
            width: 100,
            child: Image.file(File(_jpgFilePath)),
          ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            const Text('RtcImageGifSource:'),
            Switch(
              value: _isRtcImageGifSource,
              onChanged: _isStartLocalvideoTranscoder
                  ? (v) async {
                      if (!v) {
                        transcodingVideoStreams.removeWhere((element) =>
                            element.sourceType ==
                            VideoSourceType.videoSourceRtcImageGif);
                      } else {
                        transcodingVideoStreams.add(TranscodingVideoStream(
                          sourceType: VideoSourceType.videoSourceRtcImageGif,
                          imageUrl: _gifFilePath,
                          x: 360,
                          y: 0,
                          width: 360,
                          height: 240,
                        ));
                      }

                      await _engine.updateLocalTranscoderConfiguration(
                          _createLocalTranscoderConfiguration());

                      setState(() {
                        _isRtcImageGifSource = !_isRtcImageGifSource;
                      });
                    }
                  : null,
            )
          ],
        ),
        if (_gifFilePath.isNotEmpty)
          SizedBox(
            height: 100,
            width: 100,
            child: Image.file(File(_gifFilePath)),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            if (_isStartLocalvideoTranscoder)
              AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _engine,
                  canvas: const VideoCanvas(
                    uid: 0,
                    sourceType: VideoSourceType.videoSourceTranscoded,
                    renderMode: RenderModeType.renderModeFit,
                  ),
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
            if (_isReadyPreview) _transcoderOptions(),
          ],
        );
      },
    );
  }
}
