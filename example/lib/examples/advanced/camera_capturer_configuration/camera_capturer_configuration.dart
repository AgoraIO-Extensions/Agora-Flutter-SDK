import 'package:agora_rtc_engine/agora_rtc_engine.dart' as agora;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/material.dart';

/// CameraCapturerConfiguration Example
class CameraCapturerConfiguration extends StatefulWidget {
  /// Construct the [CameraCapturerConfiguration]
  const CameraCapturerConfiguration({Key? key}) : super(key: key);

  @override
  State<CameraCapturerConfiguration> createState() => _State();
}

class _State extends State<CameraCapturerConfiguration>
    with KeepRemoteVideoViewsMixin {
  late final agora.RtcEngine _engine;
  late final agora.RtcEngineEventHandler _eventHandler;
  late final TextEditingController _channelIdController;
  late final TextEditingController _uidController;
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;
  late final TextEditingController _fpsController;
  agora.CameraDirection _cameraDirection = agora.CameraDirection.cameraFront;
  agora.CameraFocalLengthType _cameraFocalLengthType =
      agora.CameraFocalLengthType.cameraFocalLengthDefault;
  bool _followEncodeDimensionRatio = true;
  bool _isReady = false;
  bool _isJoined = false;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _uidController = TextEditingController(text: config.uid.toString());
    _widthController = TextEditingController(text: '960');
    _heightController = TextEditingController(text: '540');
    _fpsController = TextEditingController(text: '15');
    _initEngine();
  }

  @override
  void dispose() {
    _channelIdController.dispose();
    _uidController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _fpsController.dispose();
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_eventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = agora.createAgoraRtcEngine();
    await _engine.initialize(agora.RtcEngineContext(
      appId: config.appId,
      channelProfile: agora.ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _eventHandler = agora.RtcEngineEventHandler(
      onError: (agora.ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onLocalVideoEvent:
          (agora.VideoSourceType source, agora.LocalVideoEventType event) {
        logSink.log(
            '[onLocalVideoEvent] source: $source, event: $event, value: ${event.value()}');
      },
      onJoinChannelSuccess: (agora.RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() => _isJoined = true);
      },
      onLeaveChannel: (agora.RtcConnection connection, agora.RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() => _isJoined = false);
      },
    );
    _engine.registerEventHandler(_eventHandler);

    await _engine.enableVideo();

    setState(() => _isReady = true);
  }

  Future<void> _joinChannel() async {
    final cameraConfig = agora.CameraCapturerConfiguration(
      cameraDirection: _cameraDirection,
      cameraFocalLengthType: _cameraFocalLengthType,
      followEncodeDimensionRatio: _followEncodeDimensionRatio,
      format: agora.VideoFormat(
        width: int.tryParse(_widthController.text) ?? 960,
        height: int.tryParse(_heightController.text) ?? 540,
        fps: int.tryParse(_fpsController.text) ?? 15,
      ),
    );
    logSink.log('[setCameraCapturerConfiguration] ${cameraConfig.toJson()}');
    await _engine.setCameraCapturerConfiguration(cameraConfig);
    await _engine.startPreview();

    await _engine.joinChannel(
      token: config.token,
      channelId: _channelIdController.text,
      uid: int.tryParse(_uidController.text) ?? 0,
      options: const agora.ChannelMediaOptions(
        clientRoleType: agora.ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
    await _engine.stopPreview();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReady) return Container();

        return Stack(
          children: [
            agora.AgoraVideoView(
              controller: agora.VideoViewController(
                rtcEngine: _engine,
                canvas: const agora.VideoCanvas(uid: 0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RemoteVideoViewsWidget(
                key: keepRemoteVideoViewsKey,
                rtcEngine: _engine,
                channelId: _channelIdController.text,
              ),
            ),
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _channelIdController,
              decoration: const InputDecoration(hintText: 'Channel ID'),
              enabled: !_isJoined,
            ),
            TextField(
              controller: _uidController,
              decoration: const InputDecoration(
                hintText: 'UID for joinChannel (default: 0)',
                labelText: 'UID',
              ),
              keyboardType: TextInputType.number,
              enabled: !_isJoined,
            ),
            const Text('Camera direction:'),
            DropdownButton<agora.CameraDirection>(
              value: _cameraDirection,
              items: agora.CameraDirection.values
                  .map((direction) => DropdownMenuItem(
                        value: direction,
                        child: Text(direction.name),
                      ))
                  .toList(),
              onChanged: _isJoined
                  ? null
                  : (direction) {
                      setState(() => _cameraDirection = direction!);
                    },
            ),
            const Text('Camera focal length type:'),
            DropdownButton<agora.CameraFocalLengthType>(
              value: _cameraFocalLengthType,
              items: agora.CameraFocalLengthType.values
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.name),
                      ))
                  .toList(),
              onChanged: _isJoined
                  ? null
                  : (type) {
                      setState(() => _cameraFocalLengthType = type!);
                    },
            ),
            Row(
              children: [
                const Expanded(child: Text('Follow encode dimension ratio')),
                Switch(
                  value: _followEncodeDimensionRatio,
                  onChanged: _isJoined
                      ? null
                      : (value) {
                          setState(() => _followEncodeDimensionRatio = value);
                        },
                ),
              ],
            ),
            const Text('Capture format:'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _widthController,
                    decoration: const InputDecoration(labelText: 'Width'),
                    keyboardType: TextInputType.number,
                    enabled: !_isJoined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Height'),
                    keyboardType: TextInputType.number,
                    enabled: !_isJoined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _fpsController,
                    decoration: const InputDecoration(labelText: 'FPS'),
                    keyboardType: TextInputType.number,
                    enabled: !_isJoined,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isReady
                        ? (_isJoined ? _leaveChannel : _joinChannel)
                        : null,
                    child: Text('${_isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
