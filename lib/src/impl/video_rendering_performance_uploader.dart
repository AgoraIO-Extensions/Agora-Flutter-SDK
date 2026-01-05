import 'dart:async';

import 'package:flutter/foundation.dart';

import '../agora_rtc_engine.dart';
import '../render/video_rendering_performance_monitor.dart';
import 'channel_connection_manager.dart';

/// Context information for a texture renderer
class RenderContext {
  final RtcEngine rtcEngine;
  final int uid;
  final String channelId;
  final int localUid;

  RenderContext({
    required this.rtcEngine,
    required this.uid,
    required this.channelId,
    required this.localUid,
  });
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
    Future.delayed(const Duration(seconds: 2), () {
      _contextMap.remove(textureId);
    });
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
    final channelId = context.channelId;
    final localUid = context.localUid;

    // For local video (uid=0), try to get connection info from manager if not provided
    String effectiveChannelId = channelId;
    int effectiveLocalUid = localUid;

    final isLocal = uid == 0;
    if (isLocal && (channelId.isEmpty || localUid == 0)) {
      // Try to get the current publishing connection from manager
      final publishingConnection =
          ChannelConnectionManager.instance.getPublishingVideoConnection();
      if (publishingConnection != null) {
        effectiveChannelId = publishingConnection.channelId ?? '';
        effectiveLocalUid = publishingConnection.localUid ?? 0;
        debugPrint(
            'xpz ==[PerformanceStatsHandler] Auto-resolved connection for local video: channelId=$effectiveChannelId, localUid=$effectiveLocalUid');
      } else {
        // If no current publishing connection, check if it's a late report from the last one
        final lastConnection = ChannelConnectionManager.instance
            .getDefaultConnection();
        if (lastConnection != null) {
          effectiveChannelId = lastConnection.channelId ?? '';
          effectiveLocalUid = lastConnection.localUid ?? 0;
          debugPrint(
              'xpz ==[PerformanceStatsHandler] Auto-resolved connection to LAST connection for local video: channelId=$effectiveChannelId, localUid=$effectiveLocalUid');
        } else {
          // Fallback to default
          final defaultConnection =
              ChannelConnectionManager.instance.getDefaultConnection();
          if (defaultConnection != null) {
            effectiveChannelId = defaultConnection.channelId ?? '';
            effectiveLocalUid = defaultConnection.localUid ?? 0;
          }
        }
      }
    }

    // Report metrics to native SDK using setParameters
    // Counter IDs:
    // - 526: Video Local Render Mean FPS
    // - 537: Video Remote Render Mean FPS
    // - 577: Video Local Render Draw Cost
    // - 576: Video Remote Render Draw Cost

    final fpsCounterId = isLocal ? 526 : 537;
    final drawCostCounterId = isLocal ? 577 : 576;

    // Build counters array with all metrics
    final List<Map<String, dynamic>> counters = [];

    // Add FPS counter if available
    if (stats.renderOutputFps != null) {
      counters.add(
          {"counterId": fpsCounterId, "value": stats.renderOutputFps!.round()});
    }

    // Add Draw Cost counter if available
    if (stats.renderDrawCostMs != null) {
      counters.add({
        "counterId": drawCostCounterId,
        "value": stats.renderDrawCostMs!.round()
      });
    }

    // Add data to global collector to aggregate all uids before uploading
    if (counters.isNotEmpty) {
      PerformanceDataCollector.instance.addPerformanceData(
        rtcEngine: rtcEngine,
        uid: effectiveLocalUid,
        channelId: effectiveChannelId,
        localUid: effectiveLocalUid,
        counters: counters,
      );
    }

    // Also dispatch to any registered handlers (for debugging/monitoring)
    // Note: VideoRenderingPerformanceMonitor already dispatched to US, so don't loop back.
    // But if there are other handlers, they got the message too.

    debugPrint(
        'xpz == ${DateTime.now().toString()} [AgoraRenderTexture] Performance: isLocal=$isLocal, channelId=$effectiveChannelId, localUid=$effectiveLocalUid, UID=$uid, InFPS=${stats.renderInputFps?.toStringAsFixed(1)}, '
        'OutFPS=${stats.renderOutputFps?.toStringAsFixed(1)}, '
        'Interval=${stats.renderFrameIntervalMs?.toStringAsFixed(2)}ms, '
        'DrawCost=${stats.renderDrawCostMs?.toStringAsFixed(2)}ms');
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
  // 延迟上传时间，用于聚合同一批次的多个 uid 数据
  static const Duration _uploadDelay = Duration(milliseconds: 100);

  // Set of channel keys that have pending data to upload
  final Set<String> _pendingChannelKeys = {};

  /// Add performance data for a specific uid in a channel
  void addPerformanceData({
    required RtcEngine rtcEngine,
    required int uid,
    required String channelId,
    required int localUid,
    required List<Map<String, dynamic>> counters,
  }) {
    if (counters.isEmpty) return;

    final key = '$channelId-$localUid';

    // Check if this channel was recently cleared (grace period)
    if (_clearedChannelsGracePeriod.containsKey(key)) {
      final clearTime = _clearedChannelsGracePeriod[key]!;
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - clearTime < _gracePeriodMs) {
        // Ignored stale data during grace period
        debugPrint(
            'xpz ==[PerformanceDataCollector] Ignored stale data for recently cleared channel: $key');
        return;
      } else {
        // Grace period passed, remove from the map
        _clearedChannelsGracePeriod.remove(key);
      }
    }

    // 获取或创建该频道的数据容器
    _channelDataMap.putIfAbsent(
      key,
      () => _ChannelPerformanceData(
        rtcEngine: rtcEngine,
        channelId: channelId,
        localUid: localUid,
      ),
    );

    // 添加该 uid 的数据
    _channelDataMap[key]!.addUidData(uid, counters);
    _pendingChannelKeys.add(key);

    // 如果没有正在运行的定时器，则开启一个新的
    _uploadTimer ??= Timer(_uploadDelay, () {
        _uploadPendingData();
        _uploadTimer = null;
    });
  }

  /// Upload pending data for marked channels
  void _uploadPendingData() {
    if (_pendingChannelKeys.isEmpty) return;

    final keysToUpload = List<String>.from(_pendingChannelKeys);
    _pendingChannelKeys.clear();

    for (final key in keysToUpload) {
      if (_channelDataMap.containsKey(key)) {
        _channelDataMap[key]!.uploadAndClear();
      }
    }
  }

  /// Upload all collected data for all channels
  void _uploadAllData() {
    if (_channelDataMap.isEmpty) return;

    for (final channelData in _channelDataMap.values) {
      channelData.uploadAndClear();
    }
    _pendingChannelKeys.clear();
  }

  /// Clear performance data for a specific channel
  /// This should be called when leaving a channel or switching publishing channel
  /// to prevent data from different channels being mixed together
  void clearChannelData(String channelId, int localUid) {
    final key = '$channelId-$localUid';

    // Mark the channel as cleared for the grace period
    _clearedChannelsGracePeriod[key] = DateTime.now().millisecondsSinceEpoch;

    if (_channelDataMap.containsKey(key)) {
      // Remove from pending keys to prevent redundant upload
      _pendingChannelKeys.remove(key);

      // Upload the data immediately before clearing to ensure no data is lost
      print(
          'xpz ==xpz[AgoraRenderTexture] _channelDataMap = ${_channelDataMap[key]?.localUid}');
      _channelDataMap[key]!.uploadAndClear();
      _channelDataMap.remove(key);
      debugPrint(
          'xpz == [PerformanceDataCollector] Cleared data for channel: $key');
    }
  }

  /// Clear all data for channels that are no longer active
  /// This is called when switching publishing channel to prevent old channel data
  /// from being mixed with new channel data
  void clearInactiveChannelData(List<String> activeChannelKeys) {
    final keysToRemove = <String>[];
    for (final key in _channelDataMap.keys) {
      if (!activeChannelKeys.contains(key)) {
        keysToRemove.add(key);
      }
    }

    for (final key in keysToRemove) {
      // Mark as cleared for grace period
      _clearedChannelsGracePeriod[key] = DateTime.now().millisecondsSinceEpoch;

      _pendingChannelKeys.remove(key);
      // Upload the data before clearing
      _channelDataMap[key]!.uploadAndClear();
      _channelDataMap.remove(key);
      debugPrint(
          'xpz ==[PerformanceDataCollector] Cleared inactive channel data: $key');
    }
  }

  /// Dispose the collector and cancel timer
  void dispose() {
    _uploadTimer?.cancel();
    _uploadTimer = null;
    _channelDataMap.clear();
  }
}

/// Performance data for a specific channel
class _ChannelPerformanceData {
  _ChannelPerformanceData({
    required this.rtcEngine,
    required this.channelId,
    required this.localUid,
  });

  final RtcEngine rtcEngine;
  final String channelId;
  final int localUid;

  // Map of uid -> counters
  final Map<int, List<Map<String, dynamic>>> _uidDataMap = {};

  /// Add performance counters for a specific uid
  void addUidData(int uid, List<Map<String, dynamic>> counters) {
    _uidDataMap[uid] = counters;
  }

  /// Upload all collected data to RtcEngine and clear the buffer
  void uploadAndClear() {
    if (_uidDataMap.isEmpty) return;

    // Build data array with all uids
    final List<Map<String, dynamic>> dataArray = [];
    for (final entry in _uidDataMap.entries) {
      dataArray.add({
        "counters": entry.value,
        "uid": entry.key,
      });
    }

    // Prepare params for upload to SDK (currently commented out)
    // ignore: unused_local_variable
    final params = {
      "data": dataArray,
      "connection": {
        "channelId": channelId,
        "localUid": localUid,
      }
    };
    // TODO: Uncomment when ready to upload to SDK
    // rtcEngine.setParameters(jsonEncode(params));
    debugPrint('xpz ==[AgoraRenderTexture] Performance: $params');
    _uidDataMap.clear();
  }
}
