import 'package:flutter/foundation.dart';

/// @nodoc
class VideoRenderingPerformanceStats {
  /// @nodoc
  VideoRenderingPerformanceStats({
    this.textureId,
    this.uid,
    this.totalFramesRendered,
    this.renderDrawCostMs,
  });

  /// @nodoc
  final int? textureId;

  /// @nodoc
  final int? uid;

  /// @nodoc
  final int? totalFramesRendered;

  /// @nodoc
  final double? renderDrawCostMs;

  /// @nodoc
  factory VideoRenderingPerformanceStats.fromJson(Map<String, dynamic> json) {
    /// @nodoc
    return VideoRenderingPerformanceStats(
      textureId: json['textureId'] as int?,
      uid: json['uid'] as int?,
      totalFramesRendered: json['totalFramesRendered'] as int?,
      renderDrawCostMs: (json['renderDrawCostMs'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (textureId != null) {
      json['textureId'] = textureId;
    }
    if (uid != null) {
      json['uid'] = uid;
    }
    if (totalFramesRendered != null) {
      json['totalFramesRendered'] = totalFramesRendered;
    }
    if (renderDrawCostMs != null) {
      json['renderDrawCostMs'] = renderDrawCostMs;
    }
    return json;
  }
}

/// @nodoc
abstract class VideoRenderingPerformanceEventHandler {
  /// @nodoc
  void onVideoRenderingPerformance(VideoRenderingPerformanceStats stats);
}

/// @nodoc
class VideoRenderingPerformanceMonitor {
  /// @nodoc
  VideoRenderingPerformanceMonitor._();

  static final VideoRenderingPerformanceMonitor instance =

      /// @nodoc
      VideoRenderingPerformanceMonitor._();

  final List<VideoRenderingPerformanceEventHandler> _handlers = [];
  final Set<int> _monitoredTextures = {};

  /// @nodoc
  void registerHandler(VideoRenderingPerformanceEventHandler handler) {
    if (!_handlers.contains(handler)) {
      _handlers.add(handler);
    }
  }

  /// @nodoc
  void unregisterHandler(VideoRenderingPerformanceEventHandler handler) {
    _handlers.remove(handler);
  }

  /// @nodoc
  void startMonitoring(int textureId) {
    _monitoredTextures.add(textureId);
  }

  /// @nodoc
  void stopMonitoring(int textureId) {
    _monitoredTextures.remove(textureId);
  }

  /// @nodoc
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

  int get monitoredTextureCount => _monitoredTextures.length;

  /// @nodoc
  void dispose() {
    _handlers.clear();
    _monitoredTextures.clear();
  }
}
