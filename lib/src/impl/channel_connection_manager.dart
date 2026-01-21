import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';

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

  bool _isSameConnection(RtcConnection? a, RtcConnection? b) {
    if (identical(a, b)) return true;
    if (a == null || b == null) return false;
    return a.channelId == b.channelId && a.localUid == b.localUid;
  }

  void addConnection(RtcConnection connection) {
    if (connection.channelId != null && connection.channelId!.isNotEmpty) {
      final existing = _activeConnections[connection.channelId!];
      if (_isSameConnection(existing, connection)) {
        return;
      }
      _activeConnections[connection.channelId!] = connection;
    }
  }

  void removeConnection(String channelId) {
    _activeConnections.remove(channelId);
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
    }

  }

  /// Set publishing video connection for a specific source type
  void setPublishingVideoConnectionBySource(
      VideoSourceType sourceType, RtcConnection connection) {
    final existing = _publishingVideoConnections[sourceType];
    if (_isSameConnection(existing, connection)) {
      return;
    }

    _publishingVideoConnections[sourceType] = connection;
  }

  /// Get publishing video connection for a specific source type
  RtcConnection? getPublishingVideoConnectionBySource(
      VideoSourceType sourceType) {
    return _publishingVideoConnections[sourceType];
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

  List<String> get activeConnectionKeys {
    final keys = <String>[];
    for (final connection in _activeConnections.values) {
      if (connection.channelId != null && connection.channelId!.isNotEmpty) {
        keys.add('${connection.channelId}-${connection.localUid ?? 0}');
      }
    }
    return keys;
  }

  void clear() {
    _activeConnections.clear();
    _publishingVideoConnection = null;
    _publishingVideoConnections.clear();
  }

  RtcConnection? getDefaultConnection() {
    if (_publishingVideoConnection != null) {
      return _publishingVideoConnection;
    }
    return null;
  }

  /// Get active connections by channelId
  /// Returns all unique connections matching the given channelId
  /// (deduplicated by channelId and localUid)
  List<RtcConnection> getActiveConnectionsByChannelId(String channelId) {
    final connections = <RtcConnection>[];
    if (channelId.isEmpty) {
      return connections;
    }

    // Use a set to track seen connection keys (channelId-localUid) for deduplication
    final seenKeys = <String>{};

    // Check in _activeConnections
    final connection = _activeConnections[channelId];
    if (connection != null) {
      connections.add(connection);
      final key = '${connection.channelId}-${connection.localUid ?? 0}';
      seenKeys.add(key);
    }

    // Also check in _publishingVideoConnections (in case it's a publishing connection)
    for (final conn in _publishingVideoConnections.values) {
      if (conn.channelId == channelId) {
        final key = '${conn.channelId}-${conn.localUid ?? 0}';
        if (!seenKeys.contains(key)) {
          // Check if it's actually a different connection using _isSameConnection
          bool isDuplicate = false;
          for (final existingConn in connections) {
            if (_isSameConnection(existingConn, conn)) {
              isDuplicate = true;
              break;
            }
          }
          if (!isDuplicate) {
            connections.add(conn);
            seenKeys.add(key);
          }
        }
      }
    }

    // Also check legacy _publishingVideoConnection
    if (_publishingVideoConnection != null &&
        _publishingVideoConnection!.channelId == channelId) {
      final key =
          '${_publishingVideoConnection!.channelId}-${_publishingVideoConnection!.localUid ?? 0}';
      if (!seenKeys.contains(key)) {
        bool isDuplicate = false;
        for (final existingConn in connections) {
          if (_isSameConnection(existingConn, _publishingVideoConnection)) {
            isDuplicate = true;
            break;
          }
        }
        if (!isDuplicate) {
          connections.add(_publishingVideoConnection!);
          seenKeys.add(key);
        }
      }
    }

    return connections;
  }
}
