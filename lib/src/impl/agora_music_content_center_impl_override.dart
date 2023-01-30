import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/agora_music_content_center.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/binding/agora_music_content_center_event_impl.dart'
    as event_binding;
import 'package:agora_rtc_engine/src/binding/agora_music_content_center_impl.dart'
    as binding;
import 'package:agora_rtc_engine/src/binding/call_api_event_handler_buffer_ext.dart';
import 'package:agora_rtc_engine/src/binding/event_handler_param_json.dart';

import 'package:agora_rtc_engine/src/impl/agora_music_content_center_impl_json.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/media_player_impl.dart'
    as media_player_impl;
import 'package:iris_method_channel/iris_method_channel.dart';

class MusicCollectionImpl extends MusicCollection {
  MusicCollectionImpl(this._musicCollectionJson);

  final MusicCollectionJson _musicCollectionJson;

  @override
  int getCount() {
    return _musicCollectionJson.count;
  }

  @override
  Music getMusic(int index) {
    assert(index < getCount());

    return _musicCollectionJson.music![index];
  }

  @override
  int getPage() {
    return _musicCollectionJson.page;
  }

  @override
  int getPageSize() {
    return _musicCollectionJson.pageSize;
  }

  @override
  int getTotal() {
    return _musicCollectionJson.total;
  }
}

class MusicContentCenterEventHandlerWrapper
    extends event_binding.MusicContentCenterEventHandlerWrapper {
  MusicContentCenterEventHandlerWrapper(
      MusicContentCenterEventHandler musicContentCenterEventHandler)
      : super(musicContentCenterEventHandler);

  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onMusicChartsResult':
        if (musicContentCenterEventHandler.onMusicChartsResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MusicContentCenterEventHandlerOnMusicChartsResultJson paramJson =
            MusicContentCenterEventHandlerOnMusicChartsResultJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        MusicContentCenterStatusCode? status = paramJson.status;
        List<MusicChartInfo>? result = paramJson.result;
        if (requestId == null || status == null || result == null) {
          return true;
        }
        result = result.map((e) => e.fillBuffers(buffers)).toList();
        musicContentCenterEventHandler.onMusicChartsResult!(
            requestId, status, result);

        return true;

      case 'onMusicCollectionResult':
        if (musicContentCenterEventHandler.onMusicCollectionResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MusicContentCenterEventHandlerOnMusicCollectionResultJson paramJson =
            MusicContentCenterEventHandlerOnMusicCollectionResultJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        MusicContentCenterStatusCode? status = paramJson.status;
        if (requestId == null || status == null) {
          return true;
        }

        final musicCollectionJson =
            MusicCollectionJson.fromJson(jsonMap['result']);
        final musicCollectionImpl = MusicCollectionImpl(musicCollectionJson);

        musicContentCenterEventHandler.onMusicCollectionResult!(
            requestId, status, musicCollectionImpl);
        return true;
    }

    return super.handleEventInternal(eventName, eventData, buffers);
  }
}

class MusicPlayerImpl extends media_player_impl.MediaPlayerImpl
    implements MusicPlayer {
  MusicPlayerImpl.create(int mediaPlayerId, IrisMethodChannel irisMethodChannel)
      : super.create(mediaPlayerId, irisMethodChannel);

  @override
  Future<void> openWithSongCode(
      {required int songCode, int startPos = 0}) async {
    final apiType = '${isOverrideClassName ? className : 'MusicPlayer'}_open';
    final param = createParams({'songCode': songCode, 'startPos': startPos});
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
}

class MusicContentCenterImpl extends binding.MusicContentCenterImpl
    with ScopedDisposableObjectMixin {
  MusicContentCenterImpl._(RtcEngine rtcEngine)
      : _rtcEngine = rtcEngine,
        super(rtcEngine.irisMethodChannel);

  factory MusicContentCenterImpl.create(RtcEngine rtcEngine) {
    return rtcEngine.objectPool.putIfAbsent(
        _musicContentCenterScopeKey, () => MusicContentCenterImpl._(rtcEngine));
  }

  final RtcEngine _rtcEngine;

  static const _musicContentCenterScopeKey =
      TypedScopedKey(MusicContentCenterImpl);

  final Map<int, MusicPlayerImpl> _musicPlayers = {};

  MusicContentCenterEventHandler? _musicContentCenterEventHandler;

  @override
  Future<MusicPlayer> createMusicPlayer() async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_createMusicPlayer';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    final musicPlayerId = result as int;

    final mp = MusicPlayerImpl.create(musicPlayerId, irisMethodChannel);

    _musicPlayers.putIfAbsent(musicPlayerId, () => mp);

    return mp;
  }

  @override
  void registerEventHandler(MusicContentCenterEventHandler eventHandler) async {
    if (_musicContentCenterEventHandler != null) return;

    _musicContentCenterEventHandler = eventHandler;
    final eventHandlerWrapper =
        MusicContentCenterEventHandlerWrapper(_musicContentCenterEventHandler!);

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _musicContentCenterScopeKey,
            registerName: 'MusicContentCenter_registerEventHandler',
            unregisterName: 'MusicContentCenter_unregisterEventHandler',
            handler: eventHandlerWrapper),
        jsonEncode({}));
  }

  @override
  void unregisterEventHandler() async {
    if (_musicContentCenterEventHandler == null) return;
    final eventHandlerWrapper =
        MusicContentCenterEventHandlerWrapper(_musicContentCenterEventHandler!);
    _musicContentCenterEventHandler = null;

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _musicContentCenterScopeKey,
            registerName: 'MusicContentCenter_registerEventHandler',
            unregisterName: 'MusicContentCenter_unregisterEventHandler',
            handler: eventHandlerWrapper),
        jsonEncode({}));
  }

  void removeMusicPlayerById(int musicPlayerId) {
    _musicPlayers.remove(musicPlayerId);
  }

  @override
  Future<void> release() async {
    markDisposed();
    try {
      // Allow error for super call
      await super.release();
    } catch (e) {
      // do nothing
    }

    for (final player in _musicPlayers.values) {
      await _rtcEngine.destroyMediaPlayer(player);
    }

    _musicPlayers.clear();
    _musicContentCenterEventHandler = null;
  }

  @override
  Future<void> dispose() async {
    await release();
  }

  @override
  Future<bool> isPreloaded(int songCode) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_isPreloaded';
    final param = createParams({'songCode': songCode});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result == 0;
  }
}
