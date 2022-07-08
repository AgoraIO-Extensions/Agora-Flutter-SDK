import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_ng/src/agora_base.dart';
import 'package:agora_rtc_ng/src/agora_media_player.dart';
import 'package:agora_rtc_ng/src/agora_media_player_source.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_ng/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_ng/src/binding/agora_media_player_impl.dart'
    as agora_media_player_impl_binding;
import 'package:agora_rtc_ng/src/binding/agora_media_player_source_event_impl.dart';
import 'package:agora_rtc_ng/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_ng/src/render/media_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:iris_event/iris_event.dart';

import 'api_caller.dart';
import 'video_view_controller_impl.dart';

/// Implementation of [MediaPlayerController]
class MediaPlayerImpl extends agora_media_player_impl_binding.MediaPlayerImpl
    with VideoViewControllerBaseMixin
    implements MediaPlayer, MediaPlayerController, IrisEventHandler {
  MediaPlayerImpl._(this._mediaPlayerId) {
    apiCaller.addEventHandler(this);
  }

  final int _mediaPlayerId;

  final Set<MediaPlayerSourceObserver> _mediaPlayerSourceObservers = {};

  /// Create the [MediaPlayerImpl]
  factory MediaPlayerImpl.create(int mediaPlayerId) {
    final instance = MediaPlayerImpl._(mediaPlayerId);

    return instance;
  }

  /// Create the [MediaPlayerController].
  static Future<MediaPlayerController> createMediaPlayerController({
    required RtcEngine rtcEngine,
    required VideoCanvas canvas,
    bool useFlutterTexture = false,
    bool useAndroidSurfaceView = false,
  }) async {
    final mp = await rtcEngine.createMediaPlayer();
    final mediaPlayer = mp as MediaPlayerImpl;
    mediaPlayer.rtcEngine = rtcEngine;
    mediaPlayer.canvas = canvas;
    mediaPlayer.connection = null;
    mediaPlayer.useFlutterTexture = useFlutterTexture;
    mediaPlayer.useAndroidSurfaceView = useAndroidSurfaceView;

    return mediaPlayer;
  }

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
  Future<void> disposeRender() async {
    if (shouldUseFlutterTexture) {
      await super.disposeRender();
    }
  }

  @override
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    _mediaPlayerSourceObservers.add(observer);
  }

  @override
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer) {
    _mediaPlayerSourceObservers.remove(observer);
  }

  void _destroy() {
    apiCaller.removeEventHandler(this);

    _mediaPlayerSourceObservers.clear();
  }

  @override
  Future<void> dispose() async {
    _destroy();
    super.dispose();
    await rtcEngine.destroyMediaPlayer(this);
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    for (final eh in _mediaPlayerSourceObservers) {
      eh.process(event, data, buffers);
    }
  }

  RtcEngine? _rtcEngine;
  set rtcEngine(RtcEngine rtcEngine) {
    _rtcEngine = rtcEngine;
  }

  @override
  RtcEngine get rtcEngine => _rtcEngine!;

  VideoCanvas? _canvas;
  set canvas(VideoCanvas canvas) {
    _canvas = canvas;
  }

  @override
  VideoCanvas get canvas => _canvas!;

  RtcConnection? _connection;
  set connection(RtcConnection? connection) {
    _connection = connection;
  }

  @override
  RtcConnection? get connection => _connection;

  bool? _useFlutterTexture;
  set useFlutterTexture(bool useFlutterTexture) {
    _useFlutterTexture = useFlutterTexture;
  }

  @override
  bool get useFlutterTexture => _useFlutterTexture!;

  bool? _useAndroidSurfaceView;
  set useAndroidSurfaceView(bool useAndroidSurfaceView) {
    _useAndroidSurfaceView = useAndroidSurfaceView;
  }

  @override
  bool get useAndroidSurfaceView => _useAndroidSurfaceView!;

  @override
  Future<int> createTextureRender(
      int uid, String channelId, int videoSourceType) {
    return rtcEngine.globalVideoViewController.createTextureRender(
      getMediaPlayerId(),
      channelId,
      videoSourceType,
    );
  }

  @override
  int getVideoSourceType() => VideoSourceType.videoSourceMediaPlayer.value();

  @override
  Future<void> setupView(int nativeViewPtr) async {
    await setView(nativeViewPtr);
  }

  @override
  Future<void> setPlayerOptionInInt(
      {required String key, required int value}) async {
    const apiType = 'MediaPlayer_setPlayerOption';
    final param = createParams({'key': key, 'value': value});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
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
    const apiType = 'MediaPlayer_setPlayerOption2';
    final param = createParams({'key': key, 'value': value});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
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
