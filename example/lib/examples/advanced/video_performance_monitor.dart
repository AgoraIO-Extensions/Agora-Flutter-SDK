import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/video_performance_overlay.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;

/// Example demonstrating video rendering performance monitoring.
///
/// This example shows how to:
/// 1. Enable performance monitoring for video textures
/// 2. Display real-time performance metrics as an overlay
/// 3. Receive and handle performance callbacks
class VideoPerformanceMonitorExample extends StatefulWidget {
  const VideoPerformanceMonitorExample({Key? key}) : super(key: key);

  @override
  State<VideoPerformanceMonitorExample> createState() =>
      _VideoPerformanceMonitorExampleState();
}

class _VideoPerformanceMonitorExampleState
    extends State<VideoPerformanceMonitorExample> {
  late RtcEngine _rtcEngine;
  VideoViewController? _localVideoController;
  bool _isJoined = false;
  final Completer<void> _videoViewReadyCompleter = Completer<void>();
  Set<int> remoteUid = {};
  bool _isUseFlutterTexture = false;

  @override
  void initState() {
    super.initState();
    _initializeEngine();
  }

  Future<void> _initializeEngine() async {
    // Initialize RTC Engine
    _rtcEngine = createAgoraRtcEngine();
    await _rtcEngine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    // Register event handler to monitor connection
    _rtcEngine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, elapsed) {
        setState(() => _isJoined = true);
      },
      onUserJoined: (connection, rUid, elapsed) {
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline: (connection, rUid, reason) {
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (connection, stats) {
        setState(() {
          _isJoined = false;
          remoteUid.clear();
        });
      },
      onError: (err, msg) {
        debugPrint('[Performance Monitor] Error: $err - $msg');
      },
    ));

    // Enable video
    await _rtcEngine.enableVideo();

    // Create local video controller with Flutter Texture rendering
    _localVideoController = VideoViewController(
      rtcEngine: _rtcEngine,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: false,
    );

    setState(() {});

    // Wait for video view to be created before joining channel
    await _videoViewReadyCompleter.future;
    await _joinChannel();
  }

  @override
  void dispose() {
    _rtcEngine.leaveChannel();
    _rtcEngine.release();
    super.dispose();
  }

  Future<void> _joinChannel() async {
    await _rtcEngine.joinChannel(
      token: config.token,
      channelId: config.channelId,
      uid: config.uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );
    setState(() => _isJoined = true);
  }

  Future<void> _leaveChannel() async {
    await _rtcEngine.leaveChannel();
    setState(() => _isJoined = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Video view with performance overlay
          Expanded(
            flex: 3,
            child: _localVideoController != null
                ? Stack(
                    children: [
                      VideoPerformanceOverlay(
                        position: PerformanceOverlayPosition.topRight,
                        child: AgoraVideoView(
                          controller: _localVideoController!,
                          onAgoraVideoViewCreated: (viewId) {
                            _rtcEngine.startPreview();

                            // Signal that video view is ready
                            if (!_videoViewReadyCompleter.isCompleted) {
                              _videoViewReadyCompleter.complete();
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.of(remoteUid.map(
                              (e) {
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      // key: ValueKey(e),
                                      margin: const EdgeInsets.all(4),
                                      width: 120,
                                      height: 160,
                                      child: AgoraVideoView(
                                        controller: VideoViewController.remote(
                                          rtcEngine: _rtcEngine,
                                          canvas: VideoCanvas(uid: e),
                                          connection: RtcConnection(
                                              channelId: config.channelId),
                                          useFlutterTexture: _isUseFlutterTexture,
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   color: Colors.blue,
                                    //   // key: ValueKey('${e}_2'),
                                    //   margin: const EdgeInsets.all(4),
                                    //   width: 120,
                                    //   height: 160,
                                    //   child: AgoraVideoView(
                                    //     controller: VideoViewController.remote(
                                    //       rtcEngine: _rtcEngine,
                                    //       canvas: VideoCanvas(
                                    //         uid: e,
                                    //         setupMode: VideoViewSetupMode
                                    //             .videoViewSetupAdd,
                                    //       ),
                                    //       connection: RtcConnection(
                                    //           channelId: config.channelId),
                                    //       useFlutterTexture: false,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            )),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),

          // Info panel
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Use Flutter Texture: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Switch(
                        value: _isUseFlutterTexture,
                        onChanged: (value) {
                          setState(() {
                            _isUseFlutterTexture = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Controls
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isJoined ? null : _joinChannel,
                  child:
                      Text(_isJoined ? 'Channel Joined ✓' : 'Rejoin Channel'),
                ),
                ElevatedButton(
                  onPressed: _isJoined ? _leaveChannel : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isJoined ? Colors.red : Colors.grey,
                  ),
                  child: const Text('Leave Channel'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
