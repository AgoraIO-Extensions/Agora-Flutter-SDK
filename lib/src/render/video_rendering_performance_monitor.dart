import 'package:flutter/foundation.dart';
import '../agora_rtc_engine.dart';

/// Callback handler for video rendering performance updates.
///
/// Implement this interface to receive periodic performance statistics
/// for Flutter Texture rendering mode.
abstract class VideoRenderingPerformanceEventHandler {
  /// Called when video rendering performance statistics are updated.
  ///
  /// This callback is triggered approximately once per second (by default)
  /// for each active video texture that has performance monitoring enabled.
  ///
  /// * [stats] The performance statistics containing FPS, draw cost, and smoothness metrics.
  void onVideoRenderingPerformance(VideoRenderingPerformanceStats stats);
}

/// Performance monitor manager for video rendering in Flutter Texture mode.
///
/// This class manages performance monitoring for video textures and provides
/// a centralized way to receive performance callbacks. Performance data is
/// received through the shared `video_view_controller` channel.
///
/// Example usage:
/// ```dart
/// final monitor = VideoRenderingPerformanceMonitor.instance;
/// monitor.registerHandler(myHandler);
/// ```
class VideoRenderingPerformanceMonitor {
  VideoRenderingPerformanceMonitor._();

  /// Singleton instance of the performance monitor.
  static final VideoRenderingPerformanceMonitor instance =
      VideoRenderingPerformanceMonitor._();

  final List<VideoRenderingPerformanceEventHandler> _handlers = [];
  
  /// Set of texture IDs being monitored (for tracking only)
  final Set<int> _monitoredTextures = {};

  /// Register a performance event handler.
  ///
  /// The handler will receive performance updates for all monitored textures.
  /// You can register multiple handlers - they will all receive the same events.
  ///
  /// * [handler] The handler to register for performance callbacks.
  void registerHandler(VideoRenderingPerformanceEventHandler handler) {
    if (!_handlers.contains(handler)) {
      _handlers.add(handler);
    }
  }

  /// Unregister a performance event handler.
  ///
  /// * [handler] The handler to remove from performance callbacks.
  void unregisterHandler(VideoRenderingPerformanceEventHandler handler) {
    _handlers.remove(handler);
  }

  /// Start monitoring performance for a specific texture.
  ///
  /// Called automatically by VideoViewController when a texture is created.
  /// Note: Actual data reception happens through the shared channel in GlobalVideoViewController.
  ///
  /// * [textureId] The texture ID to monitor.
  void startMonitoring(int textureId) {
    _monitoredTextures.add(textureId);
  }

  /// Stop monitoring performance for a specific texture.
  ///
  /// Called automatically by VideoViewController when a texture is disposed.
  ///
  /// * [textureId] The texture ID to stop monitoring.
  void stopMonitoring(int textureId) {
    _monitoredTextures.remove(textureId);
  }
  
  /// Handle performance stats from native side (called by GlobalVideoViewController).
  ///
  /// This is a public method that can be called from the platform-specific implementations.
  ///
  /// * [data] The performance data from native side.
  void handlePerformanceStatsFromNative(dynamic data) {
    _handlePerformanceStats(data);
  }

  void _handlePerformanceStats(dynamic arguments) {
    try {
      final stats = VideoRenderingPerformanceStats.fromJson(
        Map<String, dynamic>.from(arguments as Map),
      );

      // Dispatch to all registered handlers
      for (final handler in _handlers) {
        try {
          handler.onVideoRenderingPerformance(stats);
        } catch (e) {
          debugPrint(
              '[VideoRenderingPerformanceMonitor] Error in handler: $e');
        }
      }
    } catch (e) {
      debugPrint(
          '[VideoRenderingPerformanceMonitor] Failed to parse performance stats: $e');
      debugPrint('[VideoRenderingPerformanceMonitor] Raw arguments: $arguments');
    }
  }

  /// Get the number of currently monitored textures.
  int get monitoredTextureCount => _monitoredTextures.length;

  /// Clear all handlers and stop monitoring all textures.
  void dispose() {
    _handlers.clear();
    _monitoredTextures.clear();
  }
}
