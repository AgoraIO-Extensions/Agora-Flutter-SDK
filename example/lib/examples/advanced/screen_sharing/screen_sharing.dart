import 'dart:io';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const String _kDefaultAppGroup = 'io.agora';

/// ScreenSharing Example
class ScreenSharing extends StatefulWidget {
  /// Construct the [ScreenSharing]
  const ScreenSharing({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ScreenSharing> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false, screenSharing = false;
  List<int> remoteUid = [];
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined  $uid $elapsed');
        if (uid == config.screenSharingUid) {
          return;
        }
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline  $uid $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        logSink.log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
      localVideoStateChanged:
          (LocalVideoStreamState localVideoState, LocalVideoStreamError error) {
        logSink.log(
            'ScreenSharing localVideoStateChanged $localVideoState $error');
        if (error == LocalVideoStreamError.ScreenCaptureWindowClosed) {
          _stopScreenShare();
        }
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(config.token, _controller.text, null, config.uid);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _startScreenShare() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      const ScreenAudioParameters parametersAudioParams = ScreenAudioParameters(
        100,
      );
      const VideoDimensions videoParamsDimensions = VideoDimensions(
        width: 1280,
        height: 720,
      );
      const ScreenVideoParameters parametersVideoParams = ScreenVideoParameters(
        dimensions: videoParamsDimensions,
        frameRate: 15,
        bitrate: 1000,
        contentHint: VideoContentHint.Motion,
      );
      const ScreenCaptureParameters2 parameters = ScreenCaptureParameters2(
        captureAudio: true,
        audioParams: parametersAudioParams,
        captureVideo: true,
        videoParams: parametersVideoParams,
      );

      await _engine.startScreenCaptureMobile(parameters);
    } else {
      var windowId = 0;
      var random = Random();
      final windows = _engine.enumerateWindows();
      if (windows.isNotEmpty) {
        final index = random.nextInt(windows.length - 1);
        logSink.log('ScreenSharing window with index $index');
        windowId = windows[index].id;
      }
      await _engine.startScreenCaptureByWindowId(windowId);
    }

    setState(() {
      screenSharing = true;
    });
  }

  _stopScreenShare() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await _engine.stopScreenCapture();
      setState(() {
        screenSharing = false;
      });
    } else {
      final helper = await _engine.getScreenShareHelper();
      await helper.stopScreenCapture();
      await helper.destroy().then((value) {
        setState(() {
          screenSharing = false;
        });
      }).catchError((err) {
        logSink.log('_stopScreenShare $err');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: _controller,
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
            _renderVideo(),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: screenSharing ? _stopScreenShare : _startScreenShare,
                child: Text('${screenSharing ? 'Stop' : 'Start'} screen share'),
              ),
            ],
          ),
        )
      ],
    );
  }

  _renderVideo() {
    return Expanded(
        child: Stack(
      children: [
        const SizedBox.expand(
          child: kIsWeb
              ? rtc_local_view.SurfaceView()
              : rtc_local_view.TextureView(),
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
                  child: kIsWeb
                      ? rtc_remote_view.SurfaceView(
                          uid: e,
                          channelId: channelId,
                        )
                      : rtc_remote_view.TextureView(
                          uid: e,
                          channelId: channelId,
                        ),
                ),
              )),
            ),
          ),
        )
      ],
    ));
  }
}
