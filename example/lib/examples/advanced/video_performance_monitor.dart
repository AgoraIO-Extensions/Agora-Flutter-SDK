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
    extends State<VideoPerformanceMonitorExample>
    implements VideoRenderingPerformanceEventHandler {
  late RtcEngine _rtcEngine;
  VideoViewController? _localVideoController;
  bool _isJoined = false;
  final List<String> _performanceLog = [];
  final Completer<void> _videoViewReadyCompleter = Completer<void>();
  Set<int> remoteUid = {};

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

    // Register performance monitoring handler (optional, for custom handling)
    VideoRenderingPerformanceMonitor.instance.registerHandler(this);

    // Enable video
    await _rtcEngine.enableVideo();
    
    // Create local video controller with Flutter Texture rendering
    _localVideoController = VideoViewController(
      rtcEngine: _rtcEngine,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true, // Performance monitoring only works with Flutter Texture
    );

    setState(() {});
    
    // Wait for video view to be created before joining channel
    await _videoViewReadyCompleter.future;
    await _joinChannel();
  }

  @override
  void dispose() {
    VideoRenderingPerformanceMonitor.instance.unregisterHandler(this);
    _rtcEngine.leaveChannel();
    _rtcEngine.release();
    super.dispose();
  }

  @override
  void onVideoRenderingPerformance(VideoRenderingPerformanceStats stats) {
    if (mounted) {
      setState(() {
        _performanceLog.add(
          '${DateTime.now().toString().split(' ').last.substring(0, 8)} - '
          'Texture #${stats.textureId}: UID=${stats.uid}, '
          'InFPS=${stats.renderInputFps?.toStringAsFixed(1)}, '
          'OutFPS=${stats.renderOutputFps?.toStringAsFixed(1)}, '
          'DrawCost=${stats.renderDrawCostMs?.toStringAsFixed(2)}ms, '
          'Variance=${stats.renderIntervalVariance?.toStringAsFixed(2)}ms²',
        );

        // Keep only last 10 entries
        if (_performanceLog.length > 10) {
          _performanceLog.removeAt(0);
        }
      });
    }
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
                              (e) => Container(
                                margin: const EdgeInsets.all(4),
                                width: 120,
                                height: 160,
                                child: AgoraVideoView(
                                  controller: VideoViewController.remote(
                                    rtcEngine: _rtcEngine,
                                    canvas: VideoCanvas(uid: e),
                                    connection: RtcConnection(channelId: config.channelId),
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
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
          

          // Performance log
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Performance Log:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _performanceLog.isEmpty
                        ? const Center(
                            child: Text(
                              'Waiting for performance data...',
                              style: TextStyle(color: Colors.white54),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _performanceLog.length,
                            itemBuilder: (context, index) {
                              return Text(
                                _performanceLog[index],
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                ),
                              );
                            },
                          ),
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
                  child: Text(_isJoined ? 'Channel Joined ✓' : 'Rejoin Channel'),
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

          // Info panel
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   color: Colors.blue.shade50,
          //   child: const Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Performance Metrics Explained:',
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //       SizedBox(height: 4),
          //       Text('• In FPS: Frames arriving at renderer'),
          //       Text('• Out FPS: Frames actually rendered'),
          //       Text('• Draw Cost: Processing time per frame'),
          //       Text('• Smoothness: Rendering consistency'),
          //       SizedBox(height: 4),
          //       Text(
          //         'Note: Performance monitoring only works with Flutter Texture rendering mode.',
          //         style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

