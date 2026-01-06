import 'package:flutter/foundation.dart';
import '../agora_rtc_engine_ex.dart';
import '../agora_media_base.dart';

class ChannelConnectionManager {
  static final ChannelConnectionManager _instance =
      ChannelConnectionManager._();
  static ChannelConnectionManager get instance => _instance;

  ChannelConnectionManager._();

  final Map<String, RtcConnection> _activeConnections = {};

  // Track publishing connections by video source type
  // This allows different local video sources (camera, screen) to have their own connections
  final Map<VideoSourceType, RtcConnection> _publishingVideoConnections = {};

  // Legacy single publishing connection (for backward compatibility)
  RtcConnection? _publishingVideoConnection;

  void addConnection(RtcConnection connection) {
    if (connection.channelId != null && connection.channelId!.isNotEmpty) {
      _activeConnections[connection.channelId!] = connection;
      debugPrint(
          '[ChannelConnectionManager] Added connection: channelId=${connection.channelId}, localUid=${connection.localUid}');
    }
  }

  void removeConnection(String channelId) {
    if (_activeConnections.containsKey(channelId)) {
      _activeConnections.remove(channelId);
      debugPrint(
          '[ChannelConnectionManager] Removed connection: channelId=$channelId');
    }

    // Remove from legacy publishing connection
    if (_publishingVideoConnection?.channelId == channelId) {
      _publishingVideoConnection = null;
    }

    // Remove from all source-specific publishing connections
    final keysToRemove = <VideoSourceType>[];
    _publishingVideoConnections.forEach((sourceType, connection) {
      if (connection.channelId == channelId) {
        keysToRemove.add(sourceType);
      }
    });
    for (final sourceType in keysToRemove) {
      _publishingVideoConnections.remove(sourceType);
      debugPrint(
          '[ChannelConnectionManager] Removed publishing connection for $sourceType due to channel leave');
    }
  }

  /// Set publishing video connection for a specific source type
  void setPublishingVideoConnectionBySource(
      VideoSourceType sourceType, RtcConnection connection) {
    _publishingVideoConnections[sourceType] = connection;
    debugPrint(
        '[ChannelConnectionManager] Set publishing connection for $sourceType: channelId=${connection.channelId}, localUid=${connection.localUid}');
  }

  /// Get publishing video connection for a specific source type
  RtcConnection? getPublishingVideoConnectionBySource(
      VideoSourceType sourceType) {
    return _publishingVideoConnections[sourceType];
  }

  /// Remove publishing video connection for a specific source type
  void removePublishingVideoConnectionBySource(VideoSourceType sourceType) {
    _publishingVideoConnections.remove(sourceType);
    debugPrint(
        '[ChannelConnectionManager] Removed publishing connection for $sourceType');
  }

  /// Legacy method: Set publishing video connection (defaults to camera source)
  void setPublishingVideoConnection(RtcConnection connection) {
    _publishingVideoConnection = connection;
    // Also set it for camera source for consistency
    setPublishingVideoConnectionBySource(
        VideoSourceType.videoSourceCamera, connection);
    debugPrint(
        '[ChannelConnectionManager] Set publishing connection (legacy): channelId=${connection.channelId}, localUid=${connection.localUid}');
  }

  /// Legacy method: Get publishing video connection
  /// Returns camera connection first, then screen, then any other, or legacy connection
  RtcConnection? getPublishingVideoConnection() {
    return _publishingVideoConnections[VideoSourceType.videoSourceCamera] ??
        _publishingVideoConnections[VideoSourceType.videoSourceScreen] ??
        _publishingVideoConnections[VideoSourceType.videoSourceScreenPrimary] ??
        (_publishingVideoConnections.isNotEmpty
            ? _publishingVideoConnections.values.first
            : null) ??
        _publishingVideoConnection;
  }

  List<RtcConnection> getAllActiveConnections() {
    return _activeConnections.values.toList();
  }

  RtcConnection? getConnection(String channelId) {
    return _activeConnections[channelId];
  }

  void clear() {
    _activeConnections.clear();
    _publishingVideoConnection = null;
    _publishingVideoConnections.clear();
    debugPrint('[ChannelConnectionManager] Cleared all connections');
  }

  RtcConnection? getDefaultConnection() {
    if (_publishingVideoConnection != null) {
      return _publishingVideoConnection;
    }
    if (_activeConnections.isNotEmpty) {
      return _activeConnections.values.first;
    }
    return null;
  }
}
