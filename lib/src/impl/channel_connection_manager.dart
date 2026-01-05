import 'package:flutter/foundation.dart';
import '../agora_rtc_engine_ex.dart';

class ChannelConnectionManager {
  static final ChannelConnectionManager _instance =
      ChannelConnectionManager._();
  static ChannelConnectionManager get instance => _instance;

  ChannelConnectionManager._();

  final Map<String, RtcConnection> _activeConnections = {};

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

    if (_publishingVideoConnection?.channelId == channelId) {
      _publishingVideoConnection = null;
    }
  }

  void setPublishingVideoConnection(RtcConnection connection) {
    if (_publishingVideoConnection != null &&
        _publishingVideoConnection!.channelId != connection.channelId) {
    }
    _publishingVideoConnection = connection;
    debugPrint(
        '[ChannelConnectionManager] Set publishing connection: channelId=${connection.channelId}, localUid=${connection.localUid}');
  }

  RtcConnection? getPublishingVideoConnection() {
    return _publishingVideoConnection;
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
