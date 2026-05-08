import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/agora_rtc_engine_debug.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const _channelId0 = 'channel0';
const _channelId1 = 'channel1';
const _channelId2 = 'channel2';
const _channelId3 = 'channel3';

/// JoinMultipleChannel Example
class JoinMultipleChannel extends StatefulWidget {
  /// Construct the [JoinMultipleChannel]
  const JoinMultipleChannel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinMultipleChannel> with WidgetsBindingObserver {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;
  late RtcConnection _channel0, _channel1, _channel2, _channel3;
  bool isJoined0 = false, isJoined1 = false, isJoined2 = false, isJoined3 = false;
  List<int> remoteUid0 = [], remoteUid1 = [], remoteUid2 = [], remoteUid3 = [];
  late final TextEditingController _channel0UidController;
  late final TextEditingController _channel1UidController;
  late final TextEditingController _channel2UidController;
  late final TextEditingController _channel3UidController;
  bool _startDumpVideo = false;
  final GlobalKey _captureBoundaryKey = GlobalKey();
  bool _captureOnResume = false;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _channel0UidController = TextEditingController(text: '1000');
    _channel1UidController = TextEditingController(text: '1001');
    _channel2UidController = TextEditingController(text: '1002');
    _channel3UidController = TextEditingController(text: '1003');
    _initEngine();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _channel0UidController.dispose();
    _channel1UidController.dispose();
    _channel2UidController.dispose();
    _channel3UidController.dispose();
    super.dispose();
    _engine.release();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _captureOnResume) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_runResumeCaptureSequence());
      });
    }
  }

  Future<void> _runResumeCaptureSequence() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    await _captureViaSentryWidget();
    await Future<void>.delayed(const Duration(milliseconds: 150));
    await _captureViaSentryEvent();
    await Future<void>.delayed(const Duration(milliseconds: 150));
    await _captureCurrentViewToImage();
  }

  _initEngine() async {
    _engine = createAgoraRtcEngineEx();
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
        if (connection.channelId == _channelId0) {
          setState(() {
            isJoined0 = true;
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            isJoined1 = true;
          });
        } else if (connection.channelId == _channelId2) {
          setState(() {
            isJoined2 = true;
          });
        } else if (connection.channelId == _channelId3) {
          setState(() {
            isJoined3 = true;
          });
        }
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        if (connection.channelId == _channelId0) {
          setState(() {
            remoteUid0.add(rUid);
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            remoteUid1.add(rUid);
          });
        } else if (connection.channelId == _channelId2) {
          setState(() {
            remoteUid2.add(rUid);
          });
        } else if (connection.channelId == _channelId3) {
          setState(() {
            remoteUid3.add(rUid);
          });
        }
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        if (connection.channelId == _channelId0) {
          setState(() {
            remoteUid0.remove(rUid);
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            remoteUid1.remove(rUid);
          });
        } else if (connection.channelId == _channelId2) {
          setState(() {
            remoteUid2.remove(rUid);
          });
        } else if (connection.channelId == _channelId3) {
          setState(() {
            remoteUid3.remove(rUid);
          });
        }
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        if (connection.channelId == _channelId0) {
          setState(() {
            isJoined0 = false;
            remoteUid0.clear();
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            isJoined1 = false;
            remoteUid1.clear();
          });
        } else if (connection.channelId == _channelId2) {
          setState(() {
            isJoined2 = false;
            remoteUid2.clear();
          });
        } else if (connection.channelId == _channelId3) {
          setState(() {
            isJoined3 = false;
            remoteUid3.clear();
          });
        }
      },
    ));

    await _engine.enableVideo();

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel0() async {
    final uid = int.tryParse(_channel0UidController.text);
    if (uid == null) return;
    _channel0 = RtcConnection(channelId: _channelId0, localUid: uid);
    await _engine.joinChannelEx(
        token: '',
        connection: _channel0,
        options: const ChannelMediaOptions(
            clientRoleType: ClientRoleType.clientRoleAudience,
            publishCameraTrack: false,
            publishMicrophoneTrack: false,
            autoSubscribeAudio: true,
            autoSubscribeVideo: true));
  }

  void _joinChannel1() async {
    final uid = int.tryParse(_channel1UidController.text);
    if (uid == null) return;
    _channel1 = RtcConnection(channelId: _channelId1, localUid: uid);
    await _engine.joinChannelEx(
        token: '',
        connection: _channel1,
        options: const ChannelMediaOptions(
            clientRoleType: ClientRoleType.clientRoleAudience,
            publishCameraTrack: false,
            publishMicrophoneTrack: false,
            autoSubscribeAudio: true,
            autoSubscribeVideo: true));
  }

  void _joinChannel2() async {
    final uid = int.tryParse(_channel2UidController.text);
    if (uid == null) return;
    _channel2 = RtcConnection(channelId: _channelId2, localUid: uid);
    await _engine.joinChannelEx(
        token: '',
        connection: _channel2,
        options: const ChannelMediaOptions(
            clientRoleType: ClientRoleType.clientRoleAudience,
            publishCameraTrack: false,
            publishMicrophoneTrack: false,
            autoSubscribeAudio: true,
            autoSubscribeVideo: true));
  }

  void _joinChannel3() async {
    final uid = int.tryParse(_channel3UidController.text);
    if (uid == null) return;
    _channel3 = RtcConnection(channelId: _channelId3, localUid: uid);
    await _engine.joinChannelEx(
        token: '',
        connection: _channel3,
        options: const ChannelMediaOptions(
            clientRoleType: ClientRoleType.clientRoleAudience,
            publishCameraTrack: false,
            publishMicrophoneTrack: false,
            autoSubscribeAudio: true,
            autoSubscribeVideo: true));
  }

  _leaveChannel0() async {
    if (isJoined0) {
      await _engine.leaveChannelEx(connection: _channel0);
    }
  }

  _leaveChannel1() async {
    if (isJoined1) {
      await _engine.leaveChannelEx(connection: _channel1);
    }
  }

  _leaveChannel2() async {
    if (isJoined2) {
      await _engine.leaveChannelEx(connection: _channel2);
    }
  }

  _leaveChannel3() async {
    if (isJoined3) {
      await _engine.leaveChannelEx(connection: _channel3);
    }
  }

  Future<void> _joinAllAudience() async {
    _joinChannel0();
    _joinChannel1();
    _joinChannel2();
    _joinChannel3();
  }

  Future<void> _captureCurrentViewToImage() async {
    if (_isCapturing) {
      logSink.log('[capture] skip: capture already in progress');
      return;
    }

    final context = _captureBoundaryKey.currentContext;
    final renderObject = context?.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      logSink.log('[capture] skip: RenderRepaintBoundary not attached');
      return;
    }

    _isCapturing = true;
    try {
      logSink.log('[capture] begin toImage, remote0=${remoteUid0.length}, '
          'remote1=${remoteUid1.length}, remote2=${remoteUid2.length}, '
          'remote3=${remoteUid3.length}');
      final ui.Image image = await renderObject.toImage(
        pixelRatio: View.of(context!).devicePixelRatio,
      );
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) {
        logSink.log('[capture] toByteData returned null');
        image.dispose();
        return;
      }
      final bytes = data.buffer.asUint8List();
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
          '${dir.path}/join_multiple_channel_capture_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes, flush: true);
      image.dispose();
      logSink.log('[capture] saved screenshot: ${file.path}');
    } catch (e, st) {
      logSink.log('[capture] toImage failed: $e\n$st');
    } finally {
      _isCapturing = false;
    }
  }

  Future<void> _captureViaSentryWidget() async {
    try {
      logSink.log('[sentry] begin captureScreenshot');
      final screenshot = await SentryFlutter.captureScreenshot();
      if (screenshot == null) {
        logSink.log('[sentry] captureScreenshot returned null');
        return;
      }
      final bytes = await screenshot.bytes;
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
          '${dir.path}/join_multiple_channel_sentry_capture_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes, flush: true);
      logSink.log('[sentry] captureScreenshot saved: ${file.path}');
    } catch (e, st) {
      logSink.log('[sentry] captureScreenshot failed: $e\n$st');
    }
  }

  Future<void> _captureViaSentryEvent() async {
    try {
      logSink.log('[sentry] begin captureMessage');
      final eventId = await Sentry.captureMessage(
        'JoinMultipleChannel screenshot repro',
        level: SentryLevel.error,
      );
      logSink.log('[sentry] captureMessage eventId=$eventId');
    } catch (e, st) {
      logSink.log('[sentry] captureMessage failed: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return RepaintBoundary(
          key: _captureBoundaryKey,
          child: Stack(
            children: [
              Container(color: Colors.black),
              if (remoteUid0.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        _channelId0,
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: remoteUid0
                            .map(
                              (e) => SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey('remote_$_channelId0\_$e'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: e),
                                    connection: _channel0,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              if (remoteUid1.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 136, top: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        _channelId1,
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: remoteUid1
                            .map(
                              (e) => SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey('remote_$_channelId1\_$e'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: e),
                                    connection: _channel1,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              if (remoteUid2.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 136 + 136, top: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        _channelId2,
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: remoteUid2
                            .map(
                              (e) => SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey('remote_$_channelId2\_$e'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: e),
                                    connection: _channel2,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              if (remoteUid3.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 136),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        _channelId3,
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: remoteUid3
                            .map(
                              (e) => SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey('remote_$_channelId3\_$e'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: e),
                                    connection: _channel3,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _joinAllAudience,
              child: const Text('Join All Audience (4 channels)'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel0UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel0 uid',
              ),
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
                      if (isJoined0) {
                        _leaveChannel0();
                      } else {
                        _joinChannel0();
                      }
                    },
                    child: Text('${isJoined0 ? 'Leave' : 'Join'} $_channelId0'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel1UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel1 uid',
              ),
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
                      if (isJoined1) {
                        _leaveChannel1();
                      } else {
                        _joinChannel1();
                      }
                    },
                    child: Text('${isJoined1 ? 'Leave' : 'Join'} $_channelId1'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel2UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel2 uid',
              ),
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
                      if (isJoined2) {
                        _leaveChannel2();
                      } else {
                        _joinChannel2();
                      }
                    },
                    child: Text('${isJoined2 ? 'Leave' : 'Join'} $_channelId2'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel3UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel3 uid',
              ),
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
                      if (isJoined3) {
                        _leaveChannel3();
                      } else {
                        _joinChannel3();
                      }
                    },
                    child: Text('${isJoined3 ? 'Leave' : 'Join'} $_channelId3'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _captureCurrentViewToImage,
              child: const Text('Capture toImage'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _captureViaSentryWidget,
              child: const Text('Capture Sentry Screenshot'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _captureViaSentryEvent,
              child: const Text('Capture Sentry Event'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Capture on resume'),
                ),
                Switch(
                  value: _captureOnResume,
                  onChanged: (value) {
                    setState(() {
                      _captureOnResume = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'This repro page keeps the device as pure audience and renders four remote AgoraVideoView with useFlutterTexture=true, then triggers RenderRepaintBoundary.toImage() or sentry_flutter screenshot capture.',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 20,
            ),
            if (defaultTargetPlatform == TargetPlatform.windows)
              ElevatedButton(
                onPressed: () async {
                  _startDumpVideo = !_startDumpVideo;

                  Directory appDocDir =
                      await getApplicationDocumentsDirectory();

                  if (_startDumpVideo) {
                    _engine.startDumpVideo(
                      VideoSourceType.videoSourceCamera.value(),
                      appDocDir.absolute.path,
                    );
                    logSink.log(
                        'Video data has dump to ${appDocDir.absolute.path}');
                  } else {
                    _engine.stopDumpVideo();
                  }

                  setState(() {});
                },
                child: Text('${_startDumpVideo ? 'Stop' : 'Start'} dump video'),
              ),
          ],
        );
      },
    );
  }
}
