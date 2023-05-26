// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:flutter/material.dart';

/// SetBeautyEffect Example
class SetBeautyEffect extends StatefulWidget {
  /// Construct the [SetBeautyEffect]
  const SetBeautyEffect({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SetBeautyEffect> with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool isJoined = false;
  late TextEditingController _channelIdController;
  double _lighteningLevel = 0.0;
  double _smoothnessLevel = 0.0;
  double _rednessLevel = 0.0;
  double _sharpnessLevel = 0.0;

  LighteningContrastLevel _selectedLighteningContrastLevel =
      LighteningContrastLevel.lighteningContrastHigh;
  final List<LighteningContrastLevel> _lighteningContrastLevels = [
    LighteningContrastLevel.lighteningContrastLow,
    LighteningContrastLevel.lighteningContrastNormal,
    LighteningContrastLevel.lighteningContrastHigh,
  ];

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  void _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _initEngine() async {
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
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      onExtensionError:
          (String provider, String extName, int error, String msg) {
        logSink.log(
            '[onExtensionErrored] provider: $provider, extName: $extName, error: $error, msg: $msg');
      },
      onExtensionStarted: (String provider, String extName) {
        logSink
            .log('[onExtensionStarted] provider: $provider, extName: $extName');
      },
      onExtensionEvent:
          (String provider, String extName, String key, String value) {
        logSink
            .log('[onExtensionEvent] provider: $provider, extName: $extName');
      },
      onExtensionStopped: (String provider, String extName) {
        logSink
            .log('[onExtensionStopped] provider: $provider, extName: $extName');
      },
    ));

    await _engine.enableVideo();

    await _engine.enableExtension(
        provider: "agora_video_filters_clear_vision",
        extension: "clear_vision");

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
    await _engine.joinChannel(
        token: config.token,
        channelId: _channelIdController.text,
        uid: 0,
        options: const ChannelMediaOptions());
  }

  _leaveChannel() async {
    await _engine.setBeautyEffectOptions(
      enabled: false,
      options: BeautyOptions(
        lighteningContrastLevel: _selectedLighteningContrastLevel,
        lighteningLevel: _lighteningLevel,
        smoothnessLevel: _smoothnessLevel,
        rednessLevel: _rednessLevel,
        sharpnessLevel: _sharpnessLevel,
      ),
    );

    await _engine.leaveChannel();

    setState(() {
      _lighteningLevel = 0.0;
      _smoothnessLevel = 0.0;
      _rednessLevel = 0.0;
      _sharpnessLevel = 0.0;
      _selectedLighteningContrastLevel =
          LighteningContrastLevel.lighteningContrastHigh;
    });
  }

  Widget _buildSpatialAudioOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('LighteningContrastLevels: '),
            DropdownButton<LighteningContrastLevel>(
                items: _lighteningContrastLevels.map((v) {
                  return DropdownMenuItem(
                    value: v,
                    child: Text(
                      v.toString().split('.')[1],
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
                value: _selectedLighteningContrastLevel,
                onChanged: (v) async {
                  _selectedLighteningContrastLevel = v!;

                  await _engine.setBeautyEffectOptions(
                    enabled: true,
                    options: BeautyOptions(
                      lighteningContrastLevel: _selectedLighteningContrastLevel,
                      lighteningLevel: _lighteningLevel,
                      smoothnessLevel: _smoothnessLevel,
                      rednessLevel: _rednessLevel,
                      sharpnessLevel: _sharpnessLevel,
                    ),
                  );

                  setState(() {});
                }),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Lightening Level:'),
            Slider(
              value: _lighteningLevel,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'Lightening Level',
              onChanged: (double value) async {
                _lighteningLevel = value;

                await _engine.setBeautyEffectOptions(
                  enabled: true,
                  options: BeautyOptions(
                    lighteningContrastLevel: _selectedLighteningContrastLevel,
                    lighteningLevel: _lighteningLevel,
                    smoothnessLevel: _smoothnessLevel,
                    rednessLevel: _rednessLevel,
                    sharpnessLevel: _sharpnessLevel,
                  ),
                );

                setState(() {});
              },
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Smoothness Level:'),
            Slider(
              value: _smoothnessLevel,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'Smoothness Level',
              onChanged: (double value) async {
                _smoothnessLevel = value;

                await _engine.setBeautyEffectOptions(
                  enabled: true,
                  options: BeautyOptions(
                    lighteningContrastLevel: _selectedLighteningContrastLevel,
                    lighteningLevel: _lighteningLevel,
                    smoothnessLevel: _smoothnessLevel,
                    rednessLevel: _rednessLevel,
                    sharpnessLevel: _sharpnessLevel,
                  ),
                );

                setState(() {});
              },
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Redness Level:'),
            Slider(
              value: _rednessLevel,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'Redness Level',
              onChanged: (double value) async {
                _rednessLevel = value;
                await _engine.setBeautyEffectOptions(
                  enabled: true,
                  options: BeautyOptions(
                    lighteningContrastLevel: _selectedLighteningContrastLevel,
                    lighteningLevel: _lighteningLevel,
                    smoothnessLevel: _smoothnessLevel,
                    rednessLevel: _rednessLevel,
                    sharpnessLevel: _sharpnessLevel,
                  ),
                );

                setState(() {});
              },
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Sharpness Level:'),
            Slider(
              value: _sharpnessLevel,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'Sharpness Level',
              onChanged: (double value) async {
                _sharpnessLevel = value;
                await _engine.setBeautyEffectOptions(
                  enabled: true,
                  options: BeautyOptions(
                    lighteningContrastLevel: _selectedLighteningContrastLevel,
                    lighteningLevel: _lighteningLevel,
                    smoothnessLevel: _smoothnessLevel,
                    rednessLevel: _rednessLevel,
                    sharpnessLevel: _sharpnessLevel,
                  ),
                );
                setState(() {});
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        TextField(
          controller: _channelIdController,
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
        if (isJoined) _buildSpatialAudioOptions(),
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
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
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
        return _buildOptions();
      },
    );
  }
}
