import 'dart:async';
import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/services.dart';
import 'agora_rte_canvas_impl.dart';

/// RTE player implementation
class AgoraRtePlayerImpl implements AgoraRtePlayer {
  @override
  final String playerId;
  final MethodChannel _channel;
  AgoraRtePlayerObserver? _observer;

  AgoraRtePlayerImpl(this.playerId, this._channel);

  /// Handle callbacks (called by AgoraRteCoreImpl)
  void handleCallback(String method, Map args) {
    print('xpz = $method');
    if (_observer == null) return;

    switch (method) {
      case 'rtePlayerOnStateChanged':
        _observer!.onStateChanged(
          AgoraRtePlayerState.values[args['oldState'] ?? 0],
          AgoraRtePlayerState.values[args['newState'] ?? 0],
          args['errorCode'] != null && args['errorCode'] != 0
              ? AgoraRteErrorCode.values[args['errorCode']]
              : null,
        );
        break;
      case 'rtePlayerOnPositionChanged':
        _observer!.onPositionChanged(
            args['currentTime'] ?? 0, args['utcTime'] ?? 0);
        break;
      case 'rtePlayerOnResolutionChanged':
        _observer!.onResolutionChanged(
            args['width'] ?? 0, args['height'] ?? 0);
        break;
      case 'rtePlayerOnEvent':
        _observer!.onEvent(
            AgoraRtePlayerEvent.values[args['event'] ?? 0]);
        break;
      case 'rtePlayerOnMetadata':
        final data = args['data'] is Uint8List 
            ? args['data'] as Uint8List 
            : (args['data'] is List 
                ? Uint8List.fromList(List<int>.from(args['data']))
                : Uint8List(0));
        _observer!.onMetadata(
          AgoraRtePlayerMetadataType.values[args['type'] ?? 0],
          data);
        break;
      case 'rtePlayerOnPlayerInfoUpdated':
        final info = args['info'];
        Map<String, dynamic> infoMap;
        if (info is Map) {
          infoMap = Map<String, dynamic>.from(info);
        } else {
          infoMap = <String, dynamic>{};
        }
        _observer!.onPlayerInfoUpdated(
            AgoraRtePlayerInfo.fromJson(infoMap));
        break;
      case 'rtePlayerOnAudioVolumeIndication':
        _observer!.onAudioVolumeIndication(args['volume'] ?? 0);
        break;
    }
  }

  @override
  Future<void> openWithUrl(String url, int startTime) async {
    await _channel.invokeMethod('rtePlayerOpenUrl', {
      'playerId': playerId,
      'url': url,
      'startTime': startTime,
    });
  }

  @override
  Future<void> openWithCustomSourceProvider(dynamic provider, int startTime) async {
    await _channel.invokeMethod('rtePlayerOpenWithCustomSourceProvider', {
      'playerId': playerId,
      'startTime': startTime,
      'provider': provider,
    });
  }

  @override
  Future<void> openWithStream(dynamic stream) async {
    await _channel.invokeMethod('rtePlayerOpenWithStream', {
      'playerId': playerId,
      'stream': stream,
    });
  }

  @override
  Future<void> switchWithUrl(String url, bool syncPts) async {
    await _channel.invokeMethod('rtePlayerSwitchWithUrl', {
      'playerId': playerId,
      'url': url,
      'syncPts': syncPts,
    });
  }

  @override
  Future<AgoraRtePlayerStats> getStats() async {
    final result = await _channel
        .invokeMethod('rtePlayerGetStats', {'playerId': playerId});
    if (result == null) {
      return const AgoraRtePlayerStats();
    }
    return AgoraRtePlayerStats.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<void> setCanvas(AgoraRteCanvas canvas) async {
    await _channel.invokeMethod('rtePlayerSetCanvas', {
      'playerId': playerId,
      'canvasId': canvas.canvasId,
    });
    // Automatically set playerId in canvas implementation for setConfigs to work
    if (canvas is AgoraRteCanvasImpl) {
      canvas.setPlayerId(playerId);
    }
  }

  @override
  Future<void> play() async {
    await _channel.invokeMethod('rtePlayerPlay', {'playerId': playerId});
  }

  @override
  Future<void> stop() async {
    await _channel.invokeMethod('rtePlayerStop', {'playerId': playerId});
  }

  @override
  Future<void> pause() async {
    await _channel.invokeMethod('rtePlayerPause', {'playerId': playerId});
  }

  @override
  Future<void> seek(int newTime) async {
    await _channel.invokeMethod(
        'rtePlayerSeek', {'playerId': playerId, 'position': newTime});
  }

  @override
  Future<void> muteAudio(bool mute) async {
    await _channel.invokeMethod(
        'rtePlayerMuteAudio', {'playerId': playerId, 'mute': mute});
  }

  @override
  Future<void> muteVideo(bool mute) async {
    await _channel.invokeMethod(
        'rtePlayerMuteVideo', {'playerId': playerId, 'mute': mute});
  }

  @override
  Future<int> getPosition() async {
    return await _channel
        .invokeMethod('rtePlayerGetCurrentTime', {'playerId': playerId});
  }

  /// Get duration
  Future<int> getDuration() async {
    return await _channel
        .invokeMethod('rtePlayerGetDuration', {'playerId': playerId});
  }

  @override
  Future<AgoraRtePlayerInfo> getInfo() async {
    final result = await _channel
        .invokeMethod('rtePlayerGetInfo', {'playerId': playerId});
    if (result == null) {
      return const AgoraRtePlayerInfo();
    }
    return AgoraRtePlayerInfo.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<void> setConfigs(AgoraRtePlayerConfig config) async {
    await _channel.invokeMethod('rtePlayerSetConfigs', {
      'playerId': playerId,
      'config': config.toJson(),
    });
  }

  @override
  Future<AgoraRtePlayerConfig> getConfigs() async {
    final result = await _channel
        .invokeMethod('rtePlayerGetConfigs', {'playerId': playerId});
    if (result == null) {
      return const AgoraRtePlayerConfig();
    }
    return AgoraRtePlayerConfig.fromJson(Map<String, dynamic>.from(result));
  }
  @override
  Future<void> registerObserver(AgoraRtePlayerObserver observer) async {
    _observer = observer;
    await _channel
        .invokeMethod('rtePlayerRegisterObserver', {'playerId': playerId});
  }

  @override
  Future<void> unregisterObserver(AgoraRtePlayerObserver observer) async {
    _observer = null;
    await _channel
        .invokeMethod('rtePlayerUnregisterObserver', {'playerId': playerId});
  }
}
