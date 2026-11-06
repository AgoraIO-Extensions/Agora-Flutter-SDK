import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// RTCHDRRender Example
///
/// Join a channel to render HDR (PQ / HLG) video over RTC.
///
/// Role (default Audience):
///  - Audience: subscribe to and render the broadcaster's video.
///  - Broadcaster: publish the local camera. HDR capture is enabled
///    automatically when the device reports it is supported.
///
/// On Android, HDR video only reaches the display when the view uses a
/// SurfaceView in Hybrid Composition, so this example exposes both switches.
/// Turn on "Android SurfaceView" and "Android Hybrid Composition (HDR)" before
/// joining to see the HDR effect.
class RTCHDRRender extends StatefulWidget {
  /// Construct the [RTCHDRRender]
  const RTCHDRRender({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RTCHDRRender> {
  late final RtcEngine _engine;

  bool isJoined = false;
  Set<int> remoteUid = {};
  late TextEditingController _channelIdController;
  late TextEditingController _uidController;
  final Map<int, VideoViewController> _remoteVideoControllers = {};

  // Default Audience; can be switched to Broadcaster before joining.
  ClientRoleType _role = ClientRoleType.clientRoleAudience;
  // Whether the device reports HDR capture support (broadcaster only).
  bool _hdrCaptureSupported = false;
  bool _hdrCaptureEnabled = false;

  // Android only. HDR video needs both switches on. Both are locked after join.
  bool _useAndroidSurfaceView = false;
  bool _useAndroidHybridComposition = false;

  late final RtcEngineEventHandler _rtcEngineEventHandler;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: 'rtc_hdr_render');
    _uidController = TextEditingController(text: '10001');
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _remoteVideoControllers.forEach((key, value) {
      value.dispose();
    });
    _remoteVideoControllers.clear();
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
        _updateRemoteVideoController(rUid, connection);
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()} rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
          final vc = _remoteVideoControllers.remove(rUid);
          vc?.dispose();
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
          _remoteVideoControllers.forEach((key, value) {
            value.dispose();
          });
          _remoteVideoControllers.clear();
        });
      },
      onFirstRemoteVideoDecoded: (RtcConnection connection, int remoteUid,
          int width, int height, int elapsed) {
        logSink.log(
            '[onFirstRemoteVideoDecoded] connection: ${connection.toJson()} remoteUid: $remoteUid width: $width height: $height elapsed: $elapsed');
      },
      onVideoSizeChanged:
          (connection, sourceType, uid, width, height, rotation) {
        logSink.log(
            '[onVideoSizeChanged] connection: ${connection.toJson()} sourceType: $sourceType uid: $uid width: $width height: $height rotation: $rotation');
        _updateRemoteVideoController(uid, connection);
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();

    // Query whether the camera module can capture HDR on this device.
    try {
      final cap =
          await _engine.queryHDRCapability(VideoModuleType.videoModuleCapturer);
      _hdrCaptureSupported = cap == HdrCapability.hdrCapabilitySupported;
      logSink.log('[queryHDRCapability] capturer: $cap');
    } catch (e) {
      logSink.log('[queryHDRCapability] failed: $e');
    }
    setState(() {});
  }

  void _updateRemoteVideoController(int uid, RtcConnection connection) {
    if (uid == 0) {
      return;
    }
    if (_remoteVideoControllers.containsKey(uid)) {
      return;
    }

    _remoteVideoControllers[uid] = VideoViewController.remote(
      rtcEngine: _engine,
      canvas: VideoCanvas(uid: uid, renderMode: RenderModeType.renderModeFit),
      connection: connection,
      useAndroidSurfaceView: _useAndroidSurfaceView,
      useAndroidHybridComposition: _useAndroidHybridComposition,
    );
    setState(() {});
  }

  bool get _isBroadcaster => _role == ClientRoleType.clientRoleBroadcaster;

  Future<void> _joinChannel() async {
    final uid = int.tryParse(_uidController.text) ?? 10001;

    if (_isBroadcaster) {
      // Broadcaster: capture HDR when the device supports it, then preview.
      if (_hdrCaptureSupported) {
        await _engine.setParameters('{"che.video.enable_hdr_capture":true}');
        _hdrCaptureEnabled = true;
        logSink.log('[hdr] enable_hdr_capture = true (device supported)');
      } else {
        logSink.log('[hdr] device does not support HDR capture, capturing SDR');
      }
      await _engine.startPreview();
    }

    await _engine.joinChannel(
      token: config.token,
      channelId: _channelIdController.text,
      uid: uid,
      options: ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: _role,
        publishCameraTrack: _isBroadcaster,
        publishMicrophoneTrack: _isBroadcaster,
        autoSubscribeVideo: true,
        autoSubscribeAudio: true,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
    if (_isBroadcaster) {
      await _engine.stopPreview();
      if (_hdrCaptureEnabled) {
        await _engine.setParameters('{"che.video.enable_hdr_capture":false}');
        _hdrCaptureEnabled = false;
      }
    }
  }

  Widget _androidViewSwitch(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(children: [
      Expanded(child: Text(title, style: const TextStyle(fontSize: 12))),
      Switch(value: value, onChanged: isJoined ? null : onChanged),
    ]);
  }

  Widget _localPreview() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(uid: 0),
        useAndroidSurfaceView: _useAndroidSurfaceView,
        useAndroidHybridComposition: _useAndroidHybridComposition,
      ),
      onAgoraVideoViewCreated: (viewId) {
        _engine.startPreview();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        // Broadcaster: show the local HDR preview.
        if (_isBroadcaster) {
          if (!isJoined) {
            return const Center(
              child: Text('Join as broadcaster to preview the local camera'),
            );
          }
          return _localPreview();
        }

        // Audience: render the broadcaster's video.
        if (_remoteVideoControllers.isEmpty) {
          return const Center(
            child: Text('Join as audience to render the broadcaster video'),
          );
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.of(remoteUid.map(
              (e) => SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: _remoteVideoControllers[e] == null
                    ? const SizedBox.shrink()
                    : AgoraVideoView(
                        key: ValueKey('remote_$e'),
                        controller: _remoteVideoControllers[e]!,
                      ),
              ),
            )),
          ),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        const roleItems = [
          DropdownMenuItem(
            value: ClientRoleType.clientRoleAudience,
            child: Text('Audience'),
          ),
          DropdownMenuItem(
            value: ClientRoleType.clientRoleBroadcaster,
            child: Text('Broadcaster'),
          ),
        ];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _channelIdController,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _uidController,
              decoration: const InputDecoration(
                hintText: 'UID for joinChannel (default: 10001)',
                labelText: 'UID',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Role: '),
                const SizedBox(width: 8),
                DropdownButton<ClientRoleType>(
                  value: _role,
                  items: roleItems,
                  onChanged: isJoined
                      ? null
                      : (v) {
                          setState(() {
                            _role = v!;
                          });
                        },
                ),
              ],
            ),
            if (_isBroadcaster)
              Text(
                _hdrCaptureSupported
                    ? 'HDR capture supported: enabled on join'
                    : 'HDR capture not supported on this device (capturing SDR)',
                style: TextStyle(
                  fontSize: 10,
                  color: _hdrCaptureSupported ? Colors.green : Colors.grey,
                ),
              ),
            if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) ...[
              const SizedBox(height: 8),
              _androidViewSwitch('Android SurfaceView', _useAndroidSurfaceView,
                  (changed) {
                setState(() {
                  _useAndroidSurfaceView = changed;
                });
              }),
              _androidViewSwitch('Android Hybrid Composition (HDR)',
                  _useAndroidHybridComposition, (changed) {
                setState(() {
                  _useAndroidHybridComposition = changed;
                });
              }),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
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
