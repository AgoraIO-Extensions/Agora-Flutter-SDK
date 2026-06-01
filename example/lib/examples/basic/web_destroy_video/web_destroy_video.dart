import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WebDestroyVideo extends StatefulWidget {
  const WebDestroyVideo({Key? key}) : super(key: key);

  @override
  State<WebDestroyVideo> createState() => _WebDestroyVideoState();
}

class _WebDestroyVideoState extends State<WebDestroyVideo> {
  RtcEngine? _engine;
  RtcEngineEventHandler? _eventHandler;
  Future<void>? _initFuture;
  bool _isInitialized = false;
  bool _isJoined = false;
  bool _showVideo = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initFuture = _initEngine();
  }

  Future<void> _initEngine() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        await [Permission.microphone, Permission.camera].request();
      }

      final engine = createAgoraRtcEngine();
      _engine = engine;
      await engine.initialize(RtcEngineContext(
        appId: config.appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));

      _eventHandler = RtcEngineEventHandler(
        onError: (ErrorCodeType err, String msg) {
          debugPrint('[WebDestroyVideo][onError] err: $err, msg: $msg');
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          if (!mounted) {
            return;
          }
          setState(() {
            _isJoined = true;
          });
        },
      );
      engine.registerEventHandler(_eventHandler!);

      await engine.enableVideo();
      await engine.startPreview();
      if (!mounted) {
        return;
      }
      setState(() {
        _isInitialized = true;
      });

      await engine.joinChannel(
        token: config.token,
        channelId: config.channelId,
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('[WebDestroyVideo] init failed: $e\n$stackTrace');
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  void dispose() {
    final engine = _engine;
    _engine = null;
    unawaited(_disposeEngine(engine));
    super.dispose();
  }

  Future<void> _disposeEngine(RtcEngine? engine) async {
    if (engine == null) {
      return;
    }

    try {
      await _initFuture;
    } catch (_) {
      // Continue releasing the partially initialized engine.
    }

    final eventHandler = _eventHandler;
    if (eventHandler != null) {
      engine.unregisterEventHandler(eventHandler);
      _eventHandler = null;
    }

    try {
      await engine.leaveChannel();
    } catch (e, stackTrace) {
      debugPrint('[WebDestroyVideo] leaveChannel failed: $e\n$stackTrace');
    }

    try {
      await engine.release();
    } catch (e, stackTrace) {
      debugPrint('[WebDestroyVideo] release failed: $e\n$stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: Text(
            'Background UI',
            style: TextStyle(
              color: Colors.red,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (_isInitialized && _showVideo && _engine != null)
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _engine!,
                  canvas: const VideoCanvas(uid: 0),
                ),
                onAgoraVideoViewCreated: (_) {
                  _engine?.startPreview();
                },
              ),
            ),
          ),
        if (_errorMessage != null)
          Positioned(
            left: 20,
            right: 20,
            top: 20,
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        Positioned(
          bottom: 20,
          left: 20,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _showVideo = !_showVideo;
              });
            },
            child: Text(_showVideo ? 'Destroy Video' : 'Show Video'),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Text(_isJoined ? 'Joined' : 'Preview'),
        ),
      ],
    );
  }
}
