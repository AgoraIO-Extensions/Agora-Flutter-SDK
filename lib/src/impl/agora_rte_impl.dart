import 'dart:async';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/services.dart';

class AgoraRteImpl implements AgoraRte {
  static const MethodChannel _channel = MethodChannel('agora_rtc_ng');
  static final AgoraRteImpl _instance = AgoraRteImpl._internal();

  factory AgoraRteImpl() => _instance;

  AgoraRteImpl._internal() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  final Map<String, AgoraRtePlayerImpl> _players = {};
  final Map<String, AgoraRteCanvasImpl> _canvases = {};

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    final args = call.arguments as Map;
    final playerId = args['playerId'] as String?;

    if (playerId != null && _players.containsKey(playerId)) {
      _players[playerId]!._handleCallback(call.method, args);
    } else if (call.method == 'rteInitMediaEngineCallback') {
      // Handle global callbacks if any
    }
  }

  @override
  Future<void> createFromBridge() async {
    await _channel.invokeMethod('rteCreateFromBridge');
  }

  @override
  Future<void> createWithConfig(AgoraRteConfig config) async {
    await _channel.invokeMethod('rteCreateWithConfig', config.toJson());
  }

  @override
  Future<void> initMediaEngine() async {
    await _channel.invokeMethod('rteInitMediaEngine');
  }

  @override
  Future<void> destroy() async {
    await _channel.invokeMethod('rteDestroy');
    _players.clear();
    _canvases.clear();
  }

  @override
  Future<void> setConfigs(AgoraRteConfig config) async {
    await _channel.invokeMethod('rteSetConfigs', config.toJson());
  }

  @override
  Future<AgoraRteConfig> getConfigs() async {
    final Map result = await _channel.invokeMethod('rteGetConfigs');
    return AgoraRteConfig(
      appId: result['appId'],
      logFolder: result['logFolder'],
      logFileSize: result['logFileSize'],
      areaCode: result['areaCode'],
      cloudProxy: result['cloudProxy'],
      jsonParameter: result['jsonParameter'],
    );
  }

  @override
  Future<String> appId() async {
    final String result = await _channel.invokeMethod('rteGetAppId');
    return result;
  }

  @override
  Future<String> logFolder() async {
    final String result = await _channel.invokeMethod('rteGetLogFolder');
    return result;
  }

  @override
  Future<int> logFileSize() async {
    final int result = await _channel.invokeMethod('rteGetLogFileSize');
    return result;
  }

  @override
  Future<int> areaCode() async {
    final int result = await _channel.invokeMethod('rteGetAreaCode');
    return result;
  }

  @override
  Future<String> cloudProxy() async {
    final String result = await _channel.invokeMethod('rteGetCloudProxy');
    return result;
  }

  @override
  Future<String> jsonParameter() async {
    final String result = await _channel.invokeMethod('rteGetJsonParameter');
    return result;
  }

  @override
  Future<void> registerObserver(AgoraRteObserver observer) async {
    await _channel.invokeMethod('rteRegisterObserver');
  }

  @override
  Future<void> unregisterObserver(AgoraRteObserver observer) async {
    await _channel.invokeMethod('rteUnregisterObserver');
  }

  Future<AgoraRtePlayer> createPlayer(AgoraRtePlayerConfig config) async {
    final String playerId =
        await _channel.invokeMethod('rtePlayerCreate', config.toJson());
    final player = AgoraRtePlayerImpl(playerId);
    _players[playerId] = player;
    return player;
  }

  Future<AgoraRteCanvas> createCanvas(AgoraRteCanvasConfig config) async {
    final String canvasId =
        await _channel.invokeMethod('rteCanvasCreate', config.toJson());
    final canvas = AgoraRteCanvasImpl(canvasId);
    _canvases[canvasId] = canvas;
    return canvas;
  }
}

class AgoraRtePlayerImpl implements AgoraRtePlayer {
  @override
  final String playerId;
  AgoraRtePlayerObserver? _observer;

  AgoraRtePlayerImpl(this.playerId);

  void _handleCallback(String method, Map args) {
    if (_observer == null) return;

    switch (method) {
      case 'onStateChanged':
        _observer!.onStateChanged(
          AgoraRtePlayerState.values[args['oldState']],
          AgoraRtePlayerState.values[args['newState']],
          args['errorCode'] != 0
              ? AgoraRteErrorCode.values[args['errorCode']]
              : null,
        );
        break;
      case 'onPositionChanged':
        _observer!.onPositionChanged(args['currentTime'], args['utcTime']);
        break;
      case 'onResolutionChanged':
        _observer!.onResolutionChanged(args['width'], args['height']);
        break;
      case 'onEvent':
        _observer!.onEvent(AgoraRtePlayerEvent.values[args['event']]);
        break;
      case 'onMetadata':
        _observer!.onMetadata(
            AgoraRtePlayerMetadataType.values[args['type']], args['data']);
        break;
      case 'onPlayerInfoUpdated':
        _observer!
            .onPlayerInfoUpdated(AgoraRtePlayerInfo.fromJson(args['info']));
        break;
      case 'onAudioVolumeIndication':
        _observer!.onAudioVolumeIndication(args['volume']);
        break;
    }
  }

  @override
  Future<void> openWithUrl(String url, int startTime) async {
    await AgoraRteImpl._channel.invokeMethod('rtePlayerOpenUrl', {
      'playerId': playerId,
      'url': url,
      'startTime': startTime,
    });
  }

  @override
  Future<void> openWithCustomSourceProvider(provider, int startTime) async {
    await AgoraRteImpl._channel
        .invokeMethod('rtePlayerOpenWithCustomSourceProvider', {
      'playerId': playerId,
      'startTime': startTime,
      // Handle provider if needed
    });
  }

  @override
  Future<void> openWithStream(stream) async {
    await AgoraRteImpl._channel.invokeMethod('rtePlayerOpenWithStream', {
      'playerId': playerId,
      // Handle stream if needed
    });
  }

  @override
  Future<void> switchWithUrl(String url, bool syncPts) async {
    await AgoraRteImpl._channel.invokeMethod('rtePlayerSwitchWithUrl', {
      'playerId': playerId,
      'url': url,
      'syncPts': syncPts,
    });
  }

  @override
  Future<AgoraRtePlayerStats> getStats() async {
    final Map result = await AgoraRteImpl._channel
        .invokeMethod('rtePlayerGetStats', {'playerId': playerId});
    return AgoraRtePlayerStats.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<void> setCanvas(AgoraRteCanvas canvas) async {
    await AgoraRteImpl._channel.invokeMethod('rtePlayerSetCanvas', {
      'playerId': playerId,
      'canvasId': canvas.canvasId,
    });
  }

  @override
  Future<void> play() async {
    await AgoraRteImpl._channel
        .invokeMethod('rtePlayerPlay', {'playerId': playerId});
  }

  @override
  Future<void> stop() async {
    await AgoraRteImpl._channel
        .invokeMethod('rtePlayerStop', {'playerId': playerId});
  }

  @override
  Future<void> pause() async {
    await AgoraRteImpl._channel
        .invokeMethod('rtePlayerPause', {'playerId': playerId});
  }

  @override
  Future<void> seek(int newTime) async {
    await AgoraRteImpl._channel.invokeMethod(
        'rtePlayerSeek', {'playerId': playerId, 'position': newTime});
  }

  @override
  Future<void> muteAudio(bool mute) async {
    await AgoraRteImpl._channel.invokeMethod(
        'rtePlayerMuteAudio', {'playerId': playerId, 'mute': mute});
  }

  @override
  Future<void> muteVideo(bool mute) async {
    await AgoraRteImpl._channel.invokeMethod(
        'rtePlayerMuteVideo', {'playerId': playerId, 'mute': mute});
  }

  @override
  Future<int> getPosition() async {
    return await AgoraRteImpl._channel
        .invokeMethod('rtePlayerGetCurrentTime', {'playerId': playerId});
  }

  @override
  Future<AgoraRtePlayerInfo> getInfo() async {
    final Map result = await AgoraRteImpl._channel
        .invokeMethod('rtePlayerGetInfo', {'playerId': playerId});
    return AgoraRtePlayerInfo.fromJson(Map<String, dynamic>.from(result));
  }

  @override
  Future<void> setConfigs(AgoraRtePlayerConfig config) async {
    await AgoraRteImpl._channel.invokeMethod('rtePlayerSetConfigs', {
      'playerId': playerId,
      'config': config.toJson(),
    });
  }

  @override
  Future<AgoraRtePlayerConfig> getConfigs() async {
    final Map result = await AgoraRteImpl._channel
        .invokeMethod('rtePlayerGetConfigs', {'playerId': playerId});
    // Parse back to AgoraRtePlayerConfig
    return AgoraRtePlayerConfig(
      autoPlay: result['autoPlay'],
      playbackSpeed: result['playbackSpeed'],
      // ... fill others
    );
  }

  @override
  Future<void> registerObserver(AgoraRtePlayerObserver observer) async {
    _observer = observer;
    await AgoraRteImpl._channel
        .invokeMethod('rtePlayerRegisterObserver', {'playerId': playerId});
  }

  @override
  Future<void> unregisterObserver(AgoraRtePlayerObserver observer) async {
    _observer = null;
    await AgoraRteImpl._channel
        .invokeMethod('rtePlayerUnregisterObserver', {'playerId': playerId});
  }
}

class AgoraRteCanvasImpl implements AgoraRteCanvas {
  @override
  final String canvasId;

  AgoraRteCanvasImpl(this.canvasId);

  @override
  Future<void> setConfigs(AgoraRteCanvasConfig config) async {
    await AgoraRteImpl._channel.invokeMethod('rteCanvasSetConfigs', {
      'canvasId': canvasId,
      'config': config.toJson(),
    });
  }

  @override
  Future<AgoraRteCanvasConfig> getConfigs() async {
    final Map result = await AgoraRteImpl._channel
        .invokeMethod('rteCanvasGetConfigs', {'canvasId': canvasId});
    return AgoraRteCanvasConfig(
      videoRenderMode: result['videoRenderMode'] != null
          ? AgoraRteVideoRenderMode.values[result['videoRenderMode']]
          : null,
      videoMirrorMode: result['videoMirrorMode'] != null
          ? AgoraRteVideoMirrorMode.values[result['videoMirrorMode']]
          : null,
      cropArea: result['cropArea'] != null
          ? AgoraRteRect.fromJson(Map<String, dynamic>.from(result['cropArea']))
          : null,
    );
  }

  @override
  Future<void> addView(int viewPtr, {AgoraRteViewConfig? config}) async {
    await AgoraRteImpl._channel.invokeMethod('rteCanvasAddView', {
      'canvasId': canvasId,
      'viewPtr': viewPtr,
      'config': config?.toJson(),
    });
  }

  @override
  Future<void> removeView(int viewPtr, {AgoraRteViewConfig? config}) async {
    await AgoraRteImpl._channel.invokeMethod('rteCanvasRemoveView', {
      'canvasId': canvasId,
      'viewPtr': viewPtr,
      'config': config?.toJson(),
    });
  }
}
