import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// DeviceManager Example
class DeviceManager extends StatefulWidget {
  /// Construct the [DeviceManager]
  const DeviceManager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DeviceManager> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false;
  List<int> remoteUid = [];
  List<MediaDeviceInfo> devices = [];
  TextEditingController? _controller;
  late String _selectedDeviceId;
  bool _isSetVideoDeviceEnabled = false;
  List<MediaDeviceInfo> recordings = [];
  List<MediaDeviceInfo> playbackDevices = [];
  String _selectedRecordingDeviceId = "";
  String _selectedPlaybackDeviceId = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _enumerateVideoDevices();
    _enumerateRecording();
    _enumeratePlaybackDevices();
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
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(config.token, channelId, null, config.uid);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _enumerateVideoDevices() async {
    _selectedDeviceId = (await _engine.deviceManager.getVideoDevice())!;
    final devices = await _engine.deviceManager.enumerateVideoDevices();
    setState(() {
      this.devices = devices;
    });
  }

  Widget _devicesDropDown() {
    if (devices.isEmpty) return Container();
    final dropDownMenus = <DropdownMenuItem<String>>[];
    for (var v in devices) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text(v.deviceName),
        value: v.deviceId,
      ));
    }
    return DropdownButton<String>(
      items: dropDownMenus,
      value: _selectedDeviceId,
      onChanged: (v) {
        setState(() {
          _isSetVideoDeviceEnabled = _selectedDeviceId != v;
          _selectedDeviceId = v!;
        });
      },
    );
  }

  Future<void> _enumeratePlaybackDevices() async {
    if (!(Platform.isWindows || Platform.isMacOS)) {
      return;
    }
    final playbackDevices =
        await _engine.deviceManager.enumerateAudioPlaybackDevices();

    _selectedPlaybackDeviceId =
        await _engine.deviceManager.getAudioPlaybackDevice() ?? '';

    setState(() {
      this.playbackDevices = playbackDevices;
    });
  }

  Widget _playbackDevicesDropDown() {
    if (playbackDevices.isEmpty || !(Platform.isWindows || Platform.isMacOS)) {
      return Container();
    }
    final dropDownMenus = <DropdownMenuItem<String>>[];
    for (var v in playbackDevices) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text('playback DeviceId:${v.deviceName}'),
        value: v.deviceId,
      ));
    }
    return DropdownButton<String>(
      items: dropDownMenus,
      value: _selectedPlaybackDeviceId,
      onChanged: (v) async {
        _selectedPlaybackDeviceId = v!;

        await _engine.deviceManager
            .setAudioPlaybackDevice(_selectedPlaybackDeviceId);

        setState(() {});
      },
    );
  }

  Future<void> _enumerateRecording() async {
    if (!(Platform.isWindows || Platform.isMacOS)) {
      return;
    }
    final recordings =
        await _engine.deviceManager.enumerateAudioRecordingDevices();

    _selectedRecordingDeviceId =
        await _engine.deviceManager.getAudioRecordingDevice() ?? '';

    setState(() {
      this.recordings = recordings;
    });
  }

  Widget _loopBackRecordingDropDown() {
    if (recordings.isEmpty || !(Platform.isWindows || Platform.isMacOS)) {
      return Container();
    }
    final dropDownMenus = <DropdownMenuItem<String>>[];
    for (var v in recordings) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text('recording deviceId:${v.deviceName}'),
        value: v.deviceId,
      ));
    }
    return DropdownButton<String>(
      items: dropDownMenus,
      value: _selectedRecordingDeviceId,
      onChanged: (v) async {
        _selectedRecordingDeviceId = v!;

        await _engine.deviceManager
            .setAudioRecordingDevice(_selectedRecordingDeviceId);

        setState(() {});
      },
    );
  }

  Future<void> _setVideoDevice(String deviceId) async {
    await _engine.deviceManager.setVideoDevice(deviceId);
    setState(() {
      _isSetVideoDeviceEnabled = false;
    });
    logSink.log('setVideoDevice deviceId: $deviceId');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
              ],
            ),
            _loopBackRecordingDropDown(),
            _playbackDevicesDropDown(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _engine.deviceManager
                            .followSystemPlaybackDevice(true);
                        _enumeratePlaybackDevices();
                      },
                      child: const Text('followSystemPlaybackDevice'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _engine.deviceManager
                            .followSystemRecordingDevice(true);
                        _enumerateRecording();
                      },
                      child: const Text('followSystemRecordingDevice'),
                    ),
                  ),
                ),
              ],
            ),
            _devicesDropDown(),
            ElevatedButton(
              onPressed: _isSetVideoDeviceEnabled
                  ? () {
                      _setVideoDevice(_selectedDeviceId);
                    }
                  : null,
              child: const Text('Set video device'),
            ),
            _renderVideo(),
          ],
        ),
      ],
    );
  }

  _renderVideo() {
    return Expanded(
        child: Stack(
      children: [
        Row(
          children: const [
            Expanded(
                flex: 1,
                child: kIsWeb
                    ? rtc_local_view.SurfaceView()
                    : rtc_local_view.TextureView()),
          ],
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
