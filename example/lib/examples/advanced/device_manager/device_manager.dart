import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// DeviceManager Example
class DeviceManager extends StatefulWidget {
  /// Construct the [DeviceManager]
  const DeviceManager({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DeviceManager> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  String channelId = config.channelId;
  bool isJoined = false;
  List<int> remoteUid = [];
  List<VideoDeviceInfo> devices = [];
  late final VideoDeviceManager _videoDeviceManager;
  late TextEditingController _controller;
  late String _selectedDeviceId;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _controller.dispose();
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
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
        setState(() {});
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {});
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _enumerateVideoDevices();

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
    await _engine.joinChannel(
        token: config.token,
        channelId: channelId,
        uid: config.uid,
        options: const ChannelMediaOptions());
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _enumerateVideoDevices() async {
    _videoDeviceManager = _engine.getVideoDeviceManager();
    _selectedDeviceId = await _videoDeviceManager.getDevice();
    final devices = await _videoDeviceManager.enumerateVideoDevices();
    setState(() {
      this.devices = devices;
    });
  }

  Widget _devicesDropDown() {
    if (devices.isEmpty) return Container();
    final dropDownMenus = <DropdownMenuItem<String>>[];
    for (var v in devices) {
      dropDownMenus.add(DropdownMenuItem(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'deviceName: ${v.deviceName!}',
              style: const TextStyle(fontSize: 10),
            ),
            Text(
              'deviceId: ${v.deviceId!}',
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
        value: v.deviceId,
      ));
    }
    return DropdownButton<String>(
      items: dropDownMenus,
      value: _selectedDeviceId,
      onChanged: (v) {
        setState(() {
          _selectedDeviceId = v!;
        });
      },
    );
  }

  Future<void> _setVideoDevice(String deviceId) async {
    _videoDeviceManager.setDevice(deviceId);
    logSink.log('setVideoDevice deviceId: $deviceId');
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine,
            canvas: const VideoCanvas(uid: 0),
          ),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
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
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _devicesDropDown(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _setVideoDevice(_selectedDeviceId);
              },
              child: const Text('Set video device'),
            ),
          ],
        );
      },
    );
  }
}
