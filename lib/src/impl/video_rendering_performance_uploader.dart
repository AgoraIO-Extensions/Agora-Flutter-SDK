import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'channel_connection_manager.dart';

/// Context information for a texture renderer
class RenderContext {
  final RtcEngine rtcEngine;
  final int uid;
  final RtcConnection? connection;
  final VideoSourceType? sourceType;

  RenderContext(
      {required this.rtcEngine,
      required this.uid,
      this.connection,
      this.sourceType});
}

/// Handler for processing video rendering performance statistics.
/// Converts stats from native and uploads them to RtcEngine.
class PerformanceStatsHandler implements VideoRenderingPerformanceEventHandler {
  static final PerformanceStatsHandler instance = PerformanceStatsHandler._();
  PerformanceStatsHandler._();

  final Map<int, RenderContext> _contextMap = {};

  void register(int textureId, RenderContext context) {
    _contextMap[textureId] = context;
    // Auto-register with monitor if not already
    VideoRenderingPerformanceMonitor.instance.registerHandler(this);
  }

  void unregister(int textureId) {
    // Keep context for a while to handle final reports arriving after dispose
    // Future.delayed(const Duration(seconds: 2), () {
      _contextMap.remove(textureId);
    // });
  }

  @override
  void onVideoRenderingPerformance(VideoRenderingPerformanceStats stats) {
    if (stats.textureId == null || !_contextMap.containsKey(stats.textureId)) {
      return;
    }

    final context = _contextMap[stats.textureId]!;
    _handleStats(stats, context);
  }

  void _handleStats(
      VideoRenderingPerformanceStats stats, RenderContext context) {
    final rtcEngine = context.rtcEngine;
    final uid = context.uid;
    final connection = context.connection;

    RtcConnection? effectiveConnection = connection;
    final isLocal = uid == 0;

    // For remote video, always validate connection against active connections
    // to ensure we use the correct connection (context.connection might be stale)
    if (!isLocal && connection?.channelId != null) {
      final activeConnections = ChannelConnectionManager.instance
          .getActiveConnectionsByChannelId(connection!.channelId!);
      if (activeConnections.isNotEmpty) {
        // Prefer connection matching the localUid from context
        if (connection.localUid != null) {
          final matchingConnection = activeConnections.firstWhere(
            (conn) => conn.localUid == connection.localUid,
            orElse: () => activeConnections.first,
          );
          effectiveConnection = matchingConnection;
          if (matchingConnection.localUid != connection.localUid) {
            debugPrint(
                '[PerformanceStatsHandler] Corrected remote video connection: from ${connection.localUid} to ${matchingConnection.localUid}');
          }
        } else {
          effectiveConnection = activeConnections.first;
        }
      }
    }

    // Only auto-resolve connection if it's null or invalid
    if (effectiveConnection == null ||
        effectiveConnection.channelId == null ||
        effectiveConnection.localUid == null) {
      if (isLocal) {
        // For local video (uid=0), try to get connection info from manager
        // Use sourceType to query the correct publishing connection
        final sourceType =
            context.sourceType ?? VideoSourceType.videoSourceCamera;
        final publishingConnection = ChannelConnectionManager.instance
            .getPublishingVideoConnectionBySource(sourceType);

        if (publishingConnection != null) {
          effectiveConnection = publishingConnection;
          debugPrint(
              '[PerformanceStatsHandler] Auto-resolved connection for local $sourceType: connection=${effectiveConnection.toString()}');
        } else {
          // Fallback: try to get any publishing connection
          final anyPublishingConnection =
              ChannelConnectionManager.instance.getPublishingVideoConnection();
          if (anyPublishingConnection != null) {
            effectiveConnection = anyPublishingConnection;
            debugPrint(
                '[PerformanceStatsHandler] Auto-resolved connection to ANY publishing connection for local video: connection=${effectiveConnection.toString()}');
          } else {
            // Last resort: use default connection
            final defaultConnection =
                ChannelConnectionManager.instance.getDefaultConnection();
            if (defaultConnection != null) {
              effectiveConnection = defaultConnection;
              debugPrint(
                  '[PerformanceStatsHandler] Auto-resolved connection to DEFAULT connection for local video: connection=${effectiveConnection.toString()}');
            }
          }
        }
      } else {
        // For remote video (uid != 0), if still no valid connection,
        // try to find from active connections by channelId
        if (connection?.channelId != null) {
          final activeConnections = ChannelConnectionManager.instance
              .getActiveConnectionsByChannelId(connection!.channelId!);
          if (activeConnections.isNotEmpty) {
            effectiveConnection = activeConnections.first;
            debugPrint(
                '[PerformanceStatsHandler] Auto-resolved connection for remote video from active connections: connection=${effectiveConnection.toString()}');
          }
        }
      }
    }
    // Pass raw frame data to collector for aggregation
    // FPS will be calculated in Dart layer based on totalFramesRendered delta
    PerformanceDataCollector.instance.addPerformanceData(
      rtcEngine: rtcEngine,
      uid: uid,
      connection: effectiveConnection,
      sourceType: context.sourceType ?? VideoSourceType.videoSourceCamera,
      totalFramesRendered: stats.totalFramesRendered ?? 0,
      drawCost: stats.renderDrawCostMs,
    );
  }
}

/// Global collector for aggregating performance data from multiple views
/// and uploading them periodically to avoid frequent SDK calls.
class PerformanceDataCollector {
  static final PerformanceDataCollector instance = PerformanceDataCollector._();
  PerformanceDataCollector._();

  // Store performance data by channel
  final Map<String, _ChannelPerformanceData> _channelDataMap = {};

  // Store the time when a channel was cleared to ignore stale stats (grace period)
  // Key: channel key, Value: clear timestamp
  final Map<String, int> _clearedChannelsGracePeriod = {};

  // Grace period duration: ignore data arriving within this time after clearing
  static const int _gracePeriodMs = 2000;

  Timer? _uploadTimer;
  static const Duration _uploadInterval = Duration(seconds: 6);
  bool _isDisposed = false;

  /// Add raw frame data for a specific uid in a channel
  void addPerformanceData({
    required RtcEngine rtcEngine,
    required int uid,
    required RtcConnection? connection,
    required VideoSourceType sourceType,
    required int totalFramesRendered,
    double? drawCost,
  }) {
    // Reset disposed state if new data arrives (new channel joined)
    if (_isDisposed) {
      _isDisposed = false;
    }

    // 2. Condition: don't upload if connection is null
    if (connection?.channelId == null || connection?.localUid == null) {
      return;
    }

    // 1. Group by connection only: Include only channelId and localUid in the key.
    // Multiple sourceTypes (camera, screen) will be aggregated in the same _ChannelPerformanceData.
    final key = '${connection?.channelId}-${connection?.localUid}';

    // Check if this channel/source was recently cleared (grace period)
    if (_clearedChannelsGracePeriod.containsKey(key)) {
      final clearTime = _clearedChannelsGracePeriod[key]!;
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - clearTime < _gracePeriodMs) {
        return; // Ignore stale data during grace period
      } else {
        _clearedChannelsGracePeriod.remove(key);
      }
    }

    _channelDataMap.putIfAbsent(
      key,
      () => _ChannelPerformanceData(
        rtcEngine: rtcEngine,
        connection: connection,
      ),
    );

    _channelDataMap[key]!.addRawFrameData(
      uid: uid,
      sourceType: sourceType,
      totalFramesRendered: totalFramesRendered,
      drawCost: drawCost,
    );

    // Start periodic timer when first data arrives (??= only creates if null)
    _uploadTimer ??= Timer.periodic(_uploadInterval, (_) {
      // First, scan and clear data for channels that are no longer active in the manager
      final activeKeys = ChannelConnectionManager.instance.activeConnectionKeys;
      clearInactiveChannelData(activeKeys);

      // Auto-cleanup when all channels are left and no data remains
      // This serves as a fallback cleanup mechanism that doesn't depend on
      // client calling specific methods (e.g., leaveChannel or release)
      if (activeKeys.isEmpty && _channelDataMap.isEmpty) {
        dispose();
        return;
      }

      _uploadAllChannelData();
    });
  }

  /// Upload all channel data (called by periodic timer)
  void _uploadAllChannelData() {
    if (_channelDataMap.isEmpty) return;

    for (final channelData in _channelDataMap.values) {
      channelData.uploadAndClear();
    }
  }

  /// Clear performance data for a specific channel and optionally a specific source
  /// This should be called when leaving a channel or switching publishing channel
  /// to prevent data from different channels being mixed together
  void clearChannelData(String channelId, int localUid,
      [VideoSourceType? sourceType]) {
    final key = '$channelId-$localUid';
    _clearSpecificKey(key);
  }

  void _clearSpecificKey(String key) {
    // Mark the channel/source as cleared for the grace period
    _clearedChannelsGracePeriod[key] = DateTime.now().millisecondsSinceEpoch;

    if (_channelDataMap.containsKey(key)) {
      _channelDataMap.remove(key);
      debugPrint('[PerformanceDataCollector] Cleared data for key: $key');
    }
  }

  /// Clear all data for channels that are no longer active
  void clearInactiveChannelData(List<String> activeConnectionKeys) {
    final keysToRemove = <String>[];
    for (final key in _channelDataMap.keys) {
      if (!activeConnectionKeys.contains(key)) {
        keysToRemove.add(key);
      }
    }

    for (final key in keysToRemove) {
      _clearedChannelsGracePeriod[key] = DateTime.now().millisecondsSinceEpoch;
      _channelDataMap[key]!.uploadAndClear();
      _channelDataMap.remove(key);
      debugPrint(
          '[PerformanceDataCollector] Cleared inactive channel data: $key');
    }
  }

  /// Dispose the collector and cancel timer
  /// This method is idempotent and can be safely called multiple times
  void dispose() {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;

    _uploadTimer?.cancel();
    _uploadTimer = null;
    ChannelConnectionManager.instance.clear();
    _channelDataMap.clear();
    _clearedChannelsGracePeriod.clear();
  }
}

/// Performance data for a specific channel
class _ChannelPerformanceData {
  _ChannelPerformanceData({
    required this.rtcEngine,
    required this.connection,
  });

  final RtcEngine rtcEngine;
  final RtcConnection? connection;

  // Raw frame data buffer for FPS calculation
  // Key: "uid-sourceType" -> _UidFrameBuffer
  final Map<String, _UidFrameBuffer> _uidBuffers = {};

  /// Add raw frame data for a specific uid
  void addRawFrameData({
    required int uid,
    required VideoSourceType sourceType,
    required int totalFramesRendered,
    double? drawCost,
  }) {
    final String key = '$uid-${sourceType.index}';
    _uidBuffers.putIfAbsent(
        key, () => _UidFrameBuffer(uid: uid, isLocal: uid == 0));
    _uidBuffers[key]!
        .addFrame(totalFramesRendered: totalFramesRendered, drawCost: drawCost);
  }

  /// Upload all collected data to RtcEngine and clear the buffer
  void uploadAndClear() {
    if (_uidBuffers.isEmpty) return;

    final List<Map<String, dynamic>> dataArray = [];

    _uidBuffers.forEach((key, buffer) {
      final counters = buffer.computeCounters();
      if (counters.isNotEmpty) {
        dataArray.add({
          "uid": buffer.uid,
          "counters": counters,
        });
      }
    });

    if (dataArray.isEmpty) return;

    final params = {
      "data": dataArray,
      "connection": {
        "channelId": connection?.channelId,
        "localUid": connection?.localUid,
      }
    };

    final jsonString = jsonEncode(params);

    rtcEngine.setParameters('{"rtc.report.argus_counters":$jsonString}');

    clear();
  }

  void clear() {
    _uidBuffers.clear();
  }
}

/// Buffer for collecting raw frame data per uid
class _UidFrameBuffer {
  _UidFrameBuffer({required this.uid, required this.isLocal});

  final int uid;
  final bool isLocal;

  // For FPS calculation: track frame count at period start and end
  int? _periodStartFrameCount;
  int? _periodStartTimestamp;
  int? _latestFrameCount;
  int? _latestTimestamp;

  final List<double> _drawCostSamples = [];

  void addFrame({required int totalFramesRendered, double? drawCost}) {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Record period start (first frame of this period)
    if (_periodStartFrameCount == null) {
      _periodStartFrameCount = totalFramesRendered;
      _periodStartTimestamp = now;
    }

    // Always update latest frame
    _latestFrameCount = totalFramesRendered;
    _latestTimestamp = now;

    // Collect draw cost samples (filter out invalid values)
    if (drawCost != null && drawCost > 0 && drawCost < 1000) {
      _drawCostSamples.add(drawCost);
    }
  }

  /// Compute FPS and average draw cost, return counters array
  List<Map<String, dynamic>> computeCounters() {
    final counters = <Map<String, dynamic>>[];

    // Counter IDs:
    // 526/537: Local/Remote Render FPS
    // 577/576: Local/Remote Render Draw Cost
    final fpsId = isLocal ? 526 : 537;
    final drawCostId = isLocal ? 577 : 576;

    // Calculate FPS: (latestFrameCount - periodStartFrameCount) / durationSeconds
    if (_periodStartFrameCount != null &&
        _latestFrameCount != null &&
        _periodStartTimestamp != null &&
        _latestTimestamp != null) {
      final framesDelta = _latestFrameCount! - _periodStartFrameCount!;
      final durationMs = _latestTimestamp! - _periodStartTimestamp!;

      debugPrint(
          '[_UidFrameBuffer] uid=$uid, startFrame=$_periodStartFrameCount, latestFrame=$_latestFrameCount, framesDelta=$framesDelta, durationMs=$durationMs, samples=${_drawCostSamples.length}');

      if (durationMs > 0 && framesDelta > 0) {
        final fps = framesDelta / (durationMs / 1000.0);
        counters.add({"counterId": fpsId, "value": fps.round()});
      }
    }

    // Calculate average draw cost
    if (_drawCostSamples.isNotEmpty) {
      final avgDrawCost =
          _drawCostSamples.reduce((a, b) => a + b) / _drawCostSamples.length;
      counters.add({
        "counterId": drawCostId,
        "value": avgDrawCost.round()
      });
    }

    return counters;
  }

  /// Reset for next period, keeping latest frame as next period's start
  void clear() {
    // Use latest frame as next period's start point
    _periodStartFrameCount = _latestFrameCount;
    _periodStartTimestamp = _latestTimestamp;
    _drawCostSamples.clear();
  }
}
