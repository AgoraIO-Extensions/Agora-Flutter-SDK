import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_media_player.dart';
import 'package:agora_rtc_engine/src/agora_media_player_source.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_base_event_impl.dart'
    as media_base_event_binding;
import 'package:agora_rtc_engine/src/binding/agora_media_player_event_impl.dart'
    as media_player_event_binding;
import 'package:agora_rtc_engine/src/binding/agora_media_player_impl.dart'
    as agora_media_player_impl_binding;
import 'package:agora_rtc_engine/src/binding/agora_media_player_source_event_impl.dart'
    as media_player_source_event_binding;
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart'
    as rtc_engine_impl;
import 'package:agora_rtc_engine/src/render/media_player_controller.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:meta/meta.dart';

class _MediaPlayerScopedKey extends TypedScopedKey {
  const _MediaPlayerScopedKey(Type type, this.mediaPlayerId) : super(type);
  final int mediaPlayerId;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _MediaPlayerScopedKey &&
        other.type == type &&
        other.mediaPlayerId == mediaPlayerId;
  }

  @override
  int get hashCode => Object.hash(type, mediaPlayerId);
}

class AudioPcmFrameSinkWrapper
    extends media_base_event_binding.AudioPcmFrameSinkWrapper {
  const AudioPcmFrameSinkWrapper(
      this.mediaPlayerId, AudioPcmFrameSink audioPcmFrameSink)
      : super(audioPcmFrameSink);

  final int mediaPlayerId;

  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    final jsonMap = Map<String, dynamic>.from(jsonDecode(eventData));
    if (jsonMap.containsKey('playerId') &&
        jsonMap['playerId'] == mediaPlayerId) {
      return super.handleEventInternal(eventName, eventData, buffers);
    }

    return false;
  }
}

class MediaPlayerVideoFrameObserverWrapper
    extends media_player_event_binding.MediaPlayerVideoFrameObserverWrapper {
  MediaPlayerVideoFrameObserverWrapper(this.mediaPlayerId,
      MediaPlayerVideoFrameObserver mediaPlayerVideoFrameObserver)
      : super(mediaPlayerVideoFrameObserver);

  final int mediaPlayerId;

  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    final jsonMap = Map<String, dynamic>.from(jsonDecode(eventData));
    if (jsonMap.containsKey('playerId') &&
        jsonMap['playerId'] == mediaPlayerId) {
      return super.handleEventInternal(eventName, eventData, buffers);
    }

    return false;
  }
}

class MediaPlayerSourceObserverWrapper
    extends media_player_source_event_binding.MediaPlayerSourceObserverWrapper {
  MediaPlayerSourceObserverWrapper(
    this.mediaPlayerId,
    MediaPlayerSourceObserver mediaPlayerSourceObserver,
  ) : super(mediaPlayerSourceObserver);

  final int mediaPlayerId;

  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    final jsonMap = Map<String, dynamic>.from(jsonDecode(eventData));
    if (jsonMap.containsKey('playerId') &&
        jsonMap['playerId'] == mediaPlayerId) {
      return super.handleEventInternal(eventName, eventData, buffers);
    }

    return false;
  }
}

class AudioSpectrumObserverWrapper
    extends media_base_event_binding.AudioSpectrumObserverWrapper {
  const AudioSpectrumObserverWrapper(
      this.mediaPlayerId, AudioSpectrumObserver audioSpectrumObserver)
      : super(audioSpectrumObserver);

  final int mediaPlayerId;

  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    final jsonMap = Map<String, dynamic>.from(jsonDecode(eventData));
    if (jsonMap.containsKey('playerId') &&
        jsonMap['playerId'] == mediaPlayerId) {
      return super.handleEventInternal(eventName, eventData, buffers);
    }

    return false;
  }
}

/// Implementation of [MediaPlayerController]
class MediaPlayerImpl extends agora_media_player_impl_binding.MediaPlayerImpl
    implements MediaPlayer {
  MediaPlayerImpl._(this._mediaPlayerId, IrisMethodChannel irisMethodChannel)
      : super(irisMethodChannel) {
    _mediaPlayerScopedKey =
        _MediaPlayerScopedKey(MediaPlayerImpl, _mediaPlayerId);
  }

  final int _mediaPlayerId;
  late final _MediaPlayerScopedKey _mediaPlayerScopedKey;

  /// Create the [MediaPlayerImpl]
  MediaPlayerImpl.create(int mediaPlayerId, IrisMethodChannel irisMethodChannel)
      : this._(mediaPlayerId, irisMethodChannel);

  @protected
  @override
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return {
      'playerId': _mediaPlayerId,
      ...param,
    };
  }

  @override
  int getMediaPlayerId() {
    return _mediaPlayerId;
  }

  @override
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer) async {
    final eventHandlerWrapper =
        MediaPlayerSourceObserverWrapper(getMediaPlayerId(), observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName: 'MediaPlayer_registerPlayerSourceObserver_15621d7',
            unregisterName:
                'MediaPlayer_unregisterPlayerSourceObserver_15621d7',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterPlayerSourceObserver(
      MediaPlayerSourceObserver observer) async {
    final eventHandlerWrapper =
        MediaPlayerSourceObserverWrapper(getMediaPlayerId(), observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName: 'MediaPlayer_registerPlayerSourceObserver_15621d7',
            unregisterName:
                'MediaPlayer_unregisterPlayerSourceObserver_15621d7',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  Future<void> destroy() async {
    await irisMethodChannel.unregisterEventHandlers(_mediaPlayerScopedKey);
  }

  @override
  Future<void> setPlayerOptionInInt(
      {required String key, required int value}) async {
    const apiType = 'MediaPlayer_setPlayerOption_4d05d29';
    final param = createParams({'key': key, 'value': value});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setPlayerOptionInString(
      {required String key, required String value}) async {
    const apiType = 'MediaPlayer_setPlayerOption_ccad422';
    final param = createParams({'key': key, 'value': value});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void registerAudioFrameObserver(
      {required AudioPcmFrameSink observer,
      RawAudioFrameOpModeType mode =
          RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly}) async {
    final eventHandlerWrapper =
        AudioPcmFrameSinkWrapper(getMediaPlayerId(), observer);
    final param = createParams({'mode': mode.value()});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName: 'MediaPlayer_registerAudioFrameObserver_a5b510b',
            unregisterName: 'MediaPlayer_unregisterAudioFrameObserver_89ab9b5',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterAudioFrameObserver(AudioPcmFrameSink observer) async {
    final eventHandlerWrapper =
        AudioPcmFrameSinkWrapper(getMediaPlayerId(), observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName: 'MediaPlayer_registerAudioFrameObserver_a5b510b',
            unregisterName: 'MediaPlayer_unregisterAudioFrameObserver_89ab9b5',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void registerVideoFrameObserver(
      MediaPlayerVideoFrameObserver observer) async {
    final eventHandlerWrapper =
        MediaPlayerVideoFrameObserverWrapper(getMediaPlayerId(), observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName: 'MediaPlayer_registerVideoFrameObserver_833bd8d',
            unregisterName: 'MediaPlayer_unregisterVideoFrameObserver_5165d4c',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterVideoFrameObserver(
      MediaPlayerVideoFrameObserver observer) async {
    final eventHandlerWrapper =
        MediaPlayerVideoFrameObserverWrapper(getMediaPlayerId(), observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName: 'MediaPlayer_registerVideoFrameObserver_833bd8d',
            unregisterName: 'MediaPlayer_unregisterVideoFrameObserver_5165d4c',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer,
      required int intervalInMS}) async {
    final eventHandlerWrapper =
        AudioSpectrumObserverWrapper(getMediaPlayerId(), observer);
    final param = createParams({'intervalInMS': intervalInMS});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName:
                'MediaPlayer_registerMediaPlayerAudioSpectrumObserver_226bb48',
            unregisterName:
                'MediaPlayer_unregisterMediaPlayerAudioSpectrumObserver_09064ce',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer) async {
    final eventHandlerWrapper =
        AudioSpectrumObserverWrapper(getMediaPlayerId(), observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _mediaPlayerScopedKey,
            registerName:
                'MediaPlayer_registerMediaPlayerAudioSpectrumObserver_226bb48',
            unregisterName:
                'MediaPlayer_unregisterMediaPlayerAudioSpectrumObserver_09064ce',
            handler: eventHandlerWrapper),
        jsonEncode(param));
  }
}

class MediaPlayerCacheManagerImpl extends agora_media_player_impl_binding
    .MediaPlayerCacheManagerImpl with ScopedDisposableObjectMixin {
  MediaPlayerCacheManagerImpl._(IrisMethodChannel irisMethodChannel)
      : super(irisMethodChannel);

  factory MediaPlayerCacheManagerImpl.create(RtcEngine rtcEngine) {
    return rtcEngine.objectPool.putIfAbsent(
        const TypedScopedKey(MediaPlayerCacheManagerImpl),
        () => MediaPlayerCacheManagerImpl._(rtcEngine.irisMethodChannel));
  }

  @override
  Future<void> dispose() async {}
}
