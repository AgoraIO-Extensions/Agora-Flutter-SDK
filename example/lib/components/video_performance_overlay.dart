import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

/// A widget that displays video rendering performance statistics as an overlay.
///
/// This widget wraps a video view and shows real-time performance metrics
/// including FPS, draw cost, and rendering smoothness. It's useful for
/// debugging and monitoring video playback quality.
///
/// Example usage:
/// ```dart
/// VideoPerformanceOverlay(
///   child: AgoraVideoView(
///     controller: videoController,
///   ),
/// )
/// ```
class VideoPerformanceOverlay extends StatefulWidget {
  const VideoPerformanceOverlay({
    Key? key,
    required this.child,
    this.position = PerformanceOverlayPosition.topRight,
    this.backgroundColor = Colors.black54,
  }) : super(key: key);

  /// The video view widget to monitor.
  final Widget child;

  /// The position of the performance overlay.
  final PerformanceOverlayPosition position;

  /// The background color of the overlay.
  final Color backgroundColor;

  @override
  State<VideoPerformanceOverlay> createState() =>
      _VideoPerformanceOverlayState();
}

class _VideoPerformanceOverlayState extends State<VideoPerformanceOverlay>
    implements VideoRenderingPerformanceEventHandler {
  VideoRenderingPerformanceStats? _stats;
  DateTime? _lastUpdateTime;

  @override
  void initState() {
    super.initState();
    VideoRenderingPerformanceMonitor.instance.registerHandler(this);
  }

  @override
  void dispose() {
    VideoRenderingPerformanceMonitor.instance.unregisterHandler(this);
    super.dispose();
  }

  @override
  void onVideoRenderingPerformance(VideoRenderingPerformanceStats stats) {
    if (mounted) {
      setState(() {
        _stats = stats;
        _lastUpdateTime = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_stats != null) _buildOverlay(),
      ],
    );
  }

  Widget _buildOverlay() {
    final stats = _stats!;

    // Check if data is stale (more than 2 seconds old)
    final isStale = _lastUpdateTime != null &&
        DateTime.now().difference(_lastUpdateTime!).inSeconds > 2;

    return Positioned(
      top: widget.position == PerformanceOverlayPosition.topLeft ||
              widget.position == PerformanceOverlayPosition.topRight
          ? 4
          : null,
      bottom: widget.position == PerformanceOverlayPosition.bottomLeft ||
              widget.position == PerformanceOverlayPosition.bottomRight
          ? 4
          : null,
      left: widget.position == PerformanceOverlayPosition.topLeft ||
              widget.position == PerformanceOverlayPosition.bottomLeft
          ? 4
          : null,
      right: widget.position == PerformanceOverlayPosition.topRight ||
              widget.position == PerformanceOverlayPosition.bottomRight
          ? 4
          : null,
      child: Opacity(
        opacity: isStale ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _getBorderColor(stats),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Texture #${stats.textureId}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              _buildMetricRow(
                'UID',
                stats.uid?.toString() ?? 'N/A',
                Colors.white,
              ),
              _buildMetricRow(
                'In FPS',
                stats.renderInputFps?.toStringAsFixed(1) ?? 'N/A',
                _getFpsColor(stats.renderInputFps ?? 0),
              ),
              _buildMetricRow(
                'Out FPS',
                stats.renderOutputFps?.toStringAsFixed(1) ?? 'N/A',
                _getFpsColor(stats.renderOutputFps ?? 0),
              ),
              _buildMetricRow(
                'Interval',
                '${stats.renderFrameIntervalMs?.toStringAsFixed(2) ?? 'N/A'} ms',
                _getFrameIntervalColor(stats.renderFrameIntervalMs ?? 0, stats.renderOutputFps ?? 0),
              ),
              _buildMetricRow(
                'Duration',
                '${stats.renderDrawCostMs?.toStringAsFixed(2) ?? 'N/A'} ms',
                _getDrawCostColor(stats.renderDrawCostMs ?? 0),
              ),
              const SizedBox(height: 2),
              Text(
                'Frames: ${stats.totalFramesReceived ?? 0}/${stats.totalFramesRendered ?? 0}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBorderColor(VideoRenderingPerformanceStats stats) {
    final inFps = stats.renderInputFps ?? 0;
    final outFps = stats.renderOutputFps ?? 0;
    final drawCost = stats.renderDrawCostMs ?? 0;

    // Red if major issues
    if (outFps < 15 || drawCost > 50) {
      return Colors.red;
    }

    // Orange if minor issues
    if (outFps < 25 || drawCost > 30 || (inFps - outFps).abs() > 5) {
      return Colors.orange;
    }

    // Green if good
    return Colors.green;
  }

  Color _getFpsColor(double fps) {
    if (fps >= 28) return Colors.green;
    if (fps >= 20) return Colors.orange;
    return Colors.red;
  }

  Color _getDrawCostColor(double cost) {
    if (cost <= 16.67) return Colors.green; // Good for 60fps
    if (cost <= 33.33) return Colors.orange; // OK for 30fps
    return Colors.red; // Too slow
  }

  Color _getFrameIntervalColor(double interval, double fps) {
    if (fps == 0 || interval == 0) return Colors.grey;
    
    // Calculate expected interval for the given FPS
    double expectedInterval = 1000.0 / fps; // ms
    double deviation = (interval - expectedInterval).abs() / expectedInterval;
    
    // Green: within 10% of expected
    // Yellow: 10-30% deviation
    // Orange: 30-50% deviation
    // Red: >50% deviation
    if (deviation < 0.1) return Colors.green;
    if (deviation < 0.3) return Colors.lightGreen;
    if (deviation < 0.5) return Colors.orange;
    return Colors.red;
  }
}

/// Position options for the performance overlay.
enum PerformanceOverlayPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

