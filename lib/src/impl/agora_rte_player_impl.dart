import 'dart:async';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/services.dart';

/// RTE 播放器实现类
class AgoraRtePlayerImpl implements AgoraRtePlayer {
  @override
  final String playerId;
  final MethodChannel _channel;
  AgoraRtePlayerObserver? _observer;

  AgoraRtePlayerImpl(this.playerId, this._channel);

  /// 处理回调（由 AgoraRteCoreImpl 调用）
  void handleCallback(String method, Map args) {
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
        _observer!.onMetadata(
            AgoraRtePlayerMetadataType.values[args['type'] ?? 0],
            args['data'] is Uint8List ? args['data'] : Uint8List(0));
        break;
      case 'rtePlayerOnPlayerInfoUpdated':
        _observer!.onPlayerInfoUpdated(
            AgoraRtePlayerInfo.fromJson(args['info'] ?? {}));
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
    final Map result = await _channel
        .invokeMethod('rtePlayerGetStats', {'playerId': playerId});
    return AgoraRtePlayerStats.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<void> setCanvas(AgoraRteCanvas canvas) async {
    await _channel.invokeMethod('rtePlayerSetCanvas', {
      'playerId': playerId,
      'canvasId': canvas.canvasId,
    });
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

  /// 获取播放时长
  Future<int> getDuration() async {
    return await _channel
        .invokeMethod('rtePlayerGetDuration', {'playerId': playerId});
  }

  @override
  Future<AgoraRtePlayerInfo> getInfo() async {
    final Map result = await _channel
        .invokeMethod('rtePlayerGetInfo', {'playerId': playerId});
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
    final Map result = await _channel
        .invokeMethod('rtePlayerGetConfigs', {'playerId': playerId});
    return AgoraRtePlayerConfig(
      autoPlay: result['autoPlay'],
      playbackSpeed: result['playbackSpeed'],
      playoutAudioTrackIdx: result['playoutAudioTrackIdx'],
      publishAudioTrackIdx: result['publishAudioTrackIdx'],
      audioTrackIdx: result['audioTrackIdx'],
      subtitleTrackIdx: result['subtitleTrackIdx'],
      externalSubtitleTrackIdx: result['externalSubtitleTrackIdx'],
      audioPitch: result['audioPitch'],
      playoutVolume: result['playoutVolume'],
      audioPlaybackDelay: result['audioPlaybackDelay'],
      audioDualMonoMode: result['audioDualMonoMode'],
      publishVolume: result['publishVolume'],
      loopCount: result['loopCount'],
      jsonParameter: result['jsonParameter'],
      abrSubscriptionLayer: result['abrSubscriptionLayer'] != null
          ? AgoraRteAbrSubscriptionLayer.values[result['abrSubscriptionLayer']]
          : null,
      abrFallbackLayer: result['abrFallbackLayer'] != null
          ? AgoraRteAbrFallbackLayer.values[result['abrFallbackLayer']]
          : null,
    );
  }

  // 单个配置属性的 getter/setter
  Future<bool> getAutoPlay() async {
    final result = await _channel.invokeMethod(
        'rtePlayerGetAutoPlay', {'playerId': playerId});
    return result ?? false;
  }

  Future<void> setAutoPlay(bool autoPlay) async {
    await _channel.invokeMethod('rtePlayerSetAutoPlay', {
      'playerId': playerId,
      'autoPlay': autoPlay,
    });
  }

  Future<int> getPlaybackSpeed() async {
    return await _channel.invokeMethod(
        'rtePlayerGetPlaybackSpeed', {'playerId': playerId});
  }

  Future<void> setPlaybackSpeed(int speed) async {
    await _channel.invokeMethod('rtePlayerSetPlaybackSpeed', {
      'playerId': playerId,
      'speed': speed,
    });
  }

  Future<int> getPlayoutVolume() async {
    return await _channel.invokeMethod(
        'rtePlayerGetPlayoutVolume', {'playerId': playerId});
  }

  Future<void> setPlayoutVolume(int volume) async {
    await _channel.invokeMethod('rtePlayerSetPlayoutVolume', {
      'playerId': playerId,
      'volume': volume,
    });
  }

  Future<int> getLoopCount() async {
    return await _channel.invokeMethod(
        'rtePlayerGetLoopCount', {'playerId': playerId});
  }

  Future<void> setLoopCount(int count) async {
    await _channel.invokeMethod('rtePlayerSetLoopCount', {
      'playerId': playerId,
      'count': count,
    });
  }

  Future<int> getPlayoutAudioTrackIdx() async {
    return await _channel.invokeMethod(
        'rtePlayerGetPlayoutAudioTrackIdx', {'playerId': playerId});
  }

  Future<void> setPlayoutAudioTrackIdx(int idx) async {
    await _channel.invokeMethod('rtePlayerSetPlayoutAudioTrackIdx', {
      'playerId': playerId,
      'idx': idx,
    });
  }

  Future<int> getPublishAudioTrackIdx() async {
    return await _channel.invokeMethod(
        'rtePlayerGetPublishAudioTrackIdx', {'playerId': playerId});
  }

  Future<void> setPublishAudioTrackIdx(int idx) async {
    await _channel.invokeMethod('rtePlayerSetPublishAudioTrackIdx', {
      'playerId': playerId,
      'idx': idx,
    });
  }

  Future<int> getAudioTrackIdx() async {
    return await _channel.invokeMethod(
        'rtePlayerGetAudioTrackIdx', {'playerId': playerId});
  }

  Future<void> setAudioTrackIdx(int idx) async {
    await _channel.invokeMethod('rtePlayerSetAudioTrackIdx', {
      'playerId': playerId,
      'idx': idx,
    });
  }

  Future<int> getSubtitleTrackIdx() async {
    return await _channel.invokeMethod(
        'rtePlayerGetSubtitleTrackIdx', {'playerId': playerId});
  }

  Future<void> setSubtitleTrackIdx(int idx) async {
    await _channel.invokeMethod('rtePlayerSetSubtitleTrackIdx', {
      'playerId': playerId,
      'idx': idx,
    });
  }

  Future<int> getExternalSubtitleTrackIdx() async {
    return await _channel.invokeMethod(
        'rtePlayerGetExternalSubtitleTrackIdx', {'playerId': playerId});
  }

  Future<void> setExternalSubtitleTrackIdx(int idx) async {
    await _channel.invokeMethod('rtePlayerSetExternalSubtitleTrackIdx', {
      'playerId': playerId,
      'idx': idx,
    });
  }

  Future<int> getAudioPitch() async {
    return await _channel.invokeMethod(
        'rtePlayerGetAudioPitch', {'playerId': playerId});
  }

  Future<void> setAudioPitch(int pitch) async {
    await _channel.invokeMethod('rtePlayerSetAudioPitch', {
      'playerId': playerId,
      'pitch': pitch,
    });
  }

  Future<int> getAudioPlaybackDelay() async {
    return await _channel.invokeMethod(
        'rtePlayerGetAudioPlaybackDelay', {'playerId': playerId});
  }

  Future<void> setAudioPlaybackDelay(int delay) async {
    await _channel.invokeMethod('rtePlayerSetAudioPlaybackDelay', {
      'playerId': playerId,
      'delay': delay,
    });
  }

  Future<int> getAudioDualMonoMode() async {
    return await _channel.invokeMethod(
        'rtePlayerGetAudioDualMonoMode', {'playerId': playerId});
  }

  Future<void> setAudioDualMonoMode(int mode) async {
    await _channel.invokeMethod('rtePlayerSetAudioDualMonoMode', {
      'playerId': playerId,
      'mode': mode,
    });
  }

  Future<int> getPublishVolume() async {
    return await _channel.invokeMethod(
        'rtePlayerGetPublishVolume', {'playerId': playerId});
  }

  Future<void> setPublishVolume(int volume) async {
    await _channel.invokeMethod('rtePlayerSetPublishVolume', {
      'playerId': playerId,
      'volume': volume,
    });
  }

  Future<String> getJsonParameter() async {
    return await _channel.invokeMethod(
        'rtePlayerGetJsonParameter', {'playerId': playerId});
  }

  Future<void> setJsonParameter(String jsonParameter) async {
    await _channel.invokeMethod('rtePlayerSetJsonParameter', {
      'playerId': playerId,
      'jsonParameter': jsonParameter,
    });
  }

  Future<AgoraRteAbrSubscriptionLayer> getAbrSubscriptionLayer() async {
    final result = await _channel.invokeMethod(
        'rtePlayerGetAbrSubscriptionLayer', {'playerId': playerId});
    return AgoraRteAbrSubscriptionLayer.values[result ?? 0];
  }

  Future<void> setAbrSubscriptionLayer(AgoraRteAbrSubscriptionLayer layer) async {
    await _channel.invokeMethod('rtePlayerSetAbrSubscriptionLayer', {
      'playerId': playerId,
      'layer': layer.index,
    });
  }

  Future<AgoraRteAbrFallbackLayer> getAbrFallbackLayer() async {
    final result = await _channel.invokeMethod(
        'rtePlayerGetAbrFallbackLayer', {'playerId': playerId});
    return AgoraRteAbrFallbackLayer.values[result ?? 0];
  }

  Future<void> setAbrFallbackLayer(AgoraRteAbrFallbackLayer layer) async {
    await _channel.invokeMethod('rtePlayerSetAbrFallbackLayer', {
      'playerId': playerId,
      'layer': layer.index,
    });
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
