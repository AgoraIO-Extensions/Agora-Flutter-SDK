import 'package:flutter/foundation.dart';
import '../agora_rtc_engine.dart';

/// Callback handler for video rendering performance updates.
abstract class VideoRenderingPerformanceEventHandler {
  /// Called when raw frame stats are received from native layer.
  void onVideoRenderingPerformance(VideoRenderingPerformanceStats stats);
}

/// Simple performance monitor that receives raw frame data from native
/// and dispatches to registered handlers.
/// 
/// Native layer sends raw data per frame (no timer).
/// Handlers (like PerformanceStatsHandler) collect and aggregate data.
class VideoRenderingPerformanceMonitor {
  VideoRenderingPerformanceMonitor._();

  static final VideoRenderingPerformanceMonitor instance =
      VideoRenderingPerformanceMonitor._();

  final List<VideoRenderingPerformanceEventHandler> _handlers = [];
  final Set<int> _monitoredTextures = {};

  void registerHandler(VideoRenderingPerformanceEventHandler handler) {
    if (!_handlers.contains(handler)) {
      _handlers.add(handler);
    }
  }

  void unregisterHandler(VideoRenderingPerformanceEventHandler handler) {
    _handlers.remove(handler);
  }

  void startMonitoring(int textureId) {
    _monitoredTextures.add(textureId);
  }

  void stopMonitoring(int textureId) {
    _monitoredTextures.remove(textureId);
  }

  /// Called from GlobalVideoViewControllerIO when native sends raw frame data.
  void handlePerformanceStatsFromNative(dynamic data) {
    if (_handlers.isEmpty) return;

    try {
      final stats = VideoRenderingPerformanceStats.fromJson(
        Map<String, dynamic>.from(data as Map),
      );

      for (final handler in _handlers) {
        try {
          handler.onVideoRenderingPerformance(stats);
        } catch (e) {
          debugPrint('[VideoRenderingPerformanceMonitor] Handler error: $e');
        }
      }
    } catch (e) {
      debugPrint('[VideoRenderingPerformanceMonitor] Parse error: $e');
    }
  }

  /// Get the number of currently monitored textures.
  int get monitoredTextureCount => _monitoredTextures.length;

  void dispose() {
    _handlers.clear();
    _monitoredTextures.clear();
  }
}
