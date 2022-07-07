import 'dart:ffi';
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
  int _selectedDisplayId = -1;
  int _selectedWindowId = -1;
  List<MediaDeviceInfo> recordings = [];
  String _selectedLoopBackRecordingDeviceName = "";
  List<int> remoteUid = [];
  List<Display> displays = [];
  List<Window> windows = [];
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
    await _enumerateDisplayAndWindow();
    await _enumerateRecording();
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
    await _engine.joinChannel(
        config.token,
        _controller.text,
        null,
        config.uid,
        ChannelMediaOptions(
          publishLocalAudio: true,
        ));
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _enumerateDisplayAndWindow() async {
    if (!(Platform.isWindows || Platform.isMacOS)) {
      return;
    }
    final windows = await _engine.enumerateWindows();
    final displays = await _engine.enumerateDisplays();
    setState(() {
      this.windows = windows;
      this.displays = displays;
    });
  }

  Widget _displayDropDown() {
    if (displays.isEmpty || !(Platform.isWindows || Platform.isMacOS))
      return Container();
    final dropDownMenus = <DropdownMenuItem<int>>[];
    dropDownMenus.add(const DropdownMenuItem(
      child: Text('please select display id'),
      value: -1,
    ));
    for (var v in displays) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text('Display:${v.id}'),
        value: v.id,
      ));
    }
    return DropdownButton<int>(
      items: dropDownMenus,
      value: _selectedDisplayId,
      onChanged: (v) {
        setState(() {
          _selectedDisplayId = v!;
          _selectedWindowId = -1;
        });
      },
    );
  }

  Widget _windowDropDown() {
    if (windows.isEmpty || !(Platform.isWindows || Platform.isMacOS))
      return Container();
    final dropDownMenus = <DropdownMenuItem<int>>[];
    dropDownMenus.add(const DropdownMenuItem(
      child: Text('please select window id'),
      value: -1,
    ));
    for (var v in windows) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text('Window:${v.id}'),
        value: v.id,
      ));
    }
    return DropdownButton<int>(
      items: dropDownMenus,
      value: _selectedWindowId,
      onChanged: (v) {
        setState(() {
          _selectedWindowId = v!;
          _selectedDisplayId = -1;
        });
      },
    );
  }

  Future<void> _enumerateRecording() async {
    if (!(Platform.isWindows || Platform.isMacOS)) {
      return;
    }
    final recordings =
        await _engine.deviceManager.enumerateAudioRecordingDevices();

    setState(() {
      this.recordings = recordings;
    });
  }

  Widget _loopBackRecordingDropDown() {
    if (recordings.isEmpty || !(Platform.isWindows || Platform.isMacOS))
      return Container();
    final dropDownMenus = <DropdownMenuItem<String>>[];
    dropDownMenus.add(const DropdownMenuItem(
      child: Text('select loopBackRecording(Optional)'),
      value: "",
    ));
    for (var v in recordings) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text('Window:${v.deviceName}'),
        value: v.deviceName,
      ));
    }
    return DropdownButton<String>(
      items: dropDownMenus,
      value: _selectedLoopBackRecordingDeviceName,
      onChanged: (v) {
        setState(() {
          _selectedLoopBackRecordingDeviceName = v!;
        });
      },
    );
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
    } else if (Platform.isWindows || Platform.isMacOS) {
      if (_selectedDisplayId != -1) {
        await _engine.startScreenCaptureByDisplayId(
          _selectedDisplayId,
        );
        await _engine.enableAudio();
        await _engine.enableLoopbackRecording(true,
            deviceName: _selectedLoopBackRecordingDeviceName);
      } else if (_selectedWindowId != -1) {
        await _engine.startScreenCaptureByWindowId(_selectedWindowId);
        await _engine.enableAudio();
        var deviceId = await _engine.deviceManager.getAudioRecordingDevice();
        await _engine.enableLoopbackRecording(true,
            deviceName: _selectedLoopBackRecordingDeviceName);
      } else {
        return;
      }
    }

    setState(() {
      screenSharing = true;
    });
  }

  _stopScreenShare() async {
    await _engine.stopScreenCapture();
    setState(() {
      screenSharing = false;
      _selectedDisplayId = -1;
      _selectedWindowId = -1;
    });
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
            _displayDropDown(),
            _windowDropDown(),
            _loopBackRecordingDropDown(),
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
                child: Text('${screenSharing ? 'Stop' : 'Start'} share'),
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
