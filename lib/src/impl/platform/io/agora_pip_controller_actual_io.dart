import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '/src/agora_base.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ext.dart';
import '/src/agora_pip_controller.dart';
import '/src/impl/agora_rtc_engine_impl.dart';

class AgoraPipNativeViewPair {
  final int nativeView;
  final AgoraPipVideoStream videoStream;

  AgoraPipNativeViewPair(this.nativeView, this.videoStream);
}

class AgoraPipControllerImpl extends AgoraPipController {
  final RtcEngine _rtcEngine;
  AgoraPipStateChangedObserver? _pipStateChangedObserver;

  int _pipContentView = 0;
  final Map<int, AgoraPipNativeViewPair> _pipSubViews = {};

  AgoraPipControllerImpl(this._rtcEngine) {
    _rtcEngine.registerMethodChannelHandler('pipStateChanged', (call) {
      final jsonMap = Map<String, dynamic>.from(call.arguments as Map);
      final stateIndex = jsonMap['state'] as int;
      final state = AgoraPipState.values[stateIndex];
      final error = jsonMap['error'] as String?;
      _pipStateChangedObserver?.onPipStateChanged(state, error);
      return Future.value();
    });
  }

  @override
  Future<void> dispose() async {
    await pipDispose();
    await _rtcEngine.unregisterMethodChannelHandler('pipStateChanged', null);
  }

  @override
  Future<void> registerPipStateChangedObserver(
    AgoraPipStateChangedObserver observer,
  ) {
    _pipStateChangedObserver = observer;
    return Future.value();
  }

  @override
  Future<void> unregisterPipStateChangedObserver() {
    _pipStateChangedObserver = null;
    return Future.value();
  }

  @override
  Future<bool> pipIsSupported() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>('pipIsSupported');
    return result ?? false;
  }

  @override
  Future<bool> pipIsAutoEnterSupported() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>(
      'pipIsAutoEnterSupported',
    );
    return result ?? false;
  }

  @override
  Future<bool> isPipActivated() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>('pipIsActivated');
    return result ?? false;
  }

  Future<void> _disposeNativeViews() async {
    if (_pipSubViews.isNotEmpty) {
      await Future.wait(
        _pipSubViews.values.map((pair) async {
          await _rtcEngine.setupVideoView(
            pair.nativeView,
            VideoCanvas(
              view: pair.nativeView,
              uid: pair.videoStream.canvas.uid,
              sourceType: pair.videoStream.canvas.sourceType,
              setupMode: VideoViewSetupMode.videoViewSetupRemove,
            ),
            connection: pair.videoStream.connection,
          );
          await _rtcEngine.destroyNativeView(pair.nativeView);
        }),
      );
      _pipSubViews.clear();
    }

    if (_pipContentView != 0) {
      await _rtcEngine.destroyNativeView(_pipContentView);
      _pipContentView = 0;
    }
  }

  Future<bool> _pipSetupForIos(AgoraPipOptions options) async {
    if ((options.contentView == null || options.contentView == 0) &&
        (options.videoStreams == null || options.videoStreams!.isEmpty)) {
      throw AgoraRtcException(code: -ErrorCodeType.errInvalidArgument.value());
    }

    int pipContentView = 0;

    if (options.contentView != null && options.contentView != 0) {
      pipContentView = options.contentView!;
      if (_pipContentView != 0) {
        await _disposeNativeViews();
      }
    } else {
      pipContentView = _pipContentView;
    }

    // if pip content view is still 0, create a new native view
    if (pipContentView == 0) {
      pipContentView = await _rtcEngine.createNativeView();

      // set _pipContentView to the new native view
      _pipContentView = pipContentView;
    }

    // if pip content view is not created, return false
    if (pipContentView == 0) {
      return false;
    }

    // get removed native views in _pipSubViews but not in options.videoStreams, clear them first
    final removedNativeViews = _pipSubViews.keys
        .where(
          (uid) => !options.videoStreams!.any(
            (videoStream) => videoStream.canvas.uid == uid,
          ),
        )
        .toList();

    // remove removed native views
    for (var uid in removedNativeViews) {
      final videoStream = _pipSubViews[uid]!.videoStream;
      final nativeView = _pipSubViews[uid]!.nativeView;

      await _rtcEngine.setupVideoView(
        nativeView,
        VideoCanvas(
          view: nativeView,
          uid: uid,
          sourceType: videoStream.canvas.sourceType,
          setupMode: VideoViewSetupMode.videoViewSetupRemove,
        ),
        connection: videoStream.connection,
      );
      await _rtcEngine.destroyNativeView(nativeView);
      _pipSubViews.remove(uid);
    }

    for (var i = 0; i < options.videoStreams!.length; i++) {
      final videoStream = options.videoStreams![i];
      if (videoStream.canvas.uid == null) {
        continue;
      }

      late final int nativeView;

      // if not exists, create new native view
      if (!_pipSubViews.containsKey(videoStream.canvas.uid!)) {
        nativeView = await _rtcEngine.createNativeView();
        if (nativeView == 0) {
          continue;
        }

        _pipSubViews[videoStream.canvas.uid!] = AgoraPipNativeViewPair(
          nativeView,
          videoStream,
        );

        final newCanvas = VideoCanvas(
          uid: videoStream.canvas.uid,
          subviewUid: videoStream.canvas.subviewUid,
          view: nativeView, // only replace view, other properties keep the same
          backgroundColor: videoStream.canvas.backgroundColor,
          renderMode: videoStream.canvas.renderMode,
          mirrorMode: videoStream.canvas.mirrorMode,
          setupMode: videoStream.canvas.setupMode,
          sourceType: videoStream.canvas.sourceType,
          mediaPlayerId: videoStream.canvas.mediaPlayerId,
          cropArea: videoStream.canvas.cropArea,
          enableAlphaMask: videoStream.canvas.enableAlphaMask,
          position: videoStream.canvas.position,
        );

        await _rtcEngine.setupVideoView(
          nativeView,
          newCanvas,
          connection: videoStream.connection,
        );
      } else {
        nativeView = _pipSubViews[videoStream.canvas.uid]!.nativeView;
      }

      await _rtcEngine.setNativeViewParent(nativeView, pipContentView, i);
    }

    if (_pipContentView != 0) {
      await _rtcEngine.setNativeViewLayout(
        _pipContentView,
        options.contentViewLayout?.toDictionary(),
      );
    }

    options.contentView = pipContentView;
    final result = await _rtcEngine.invokeAgoraMethod<bool>(
      'pipSetup',
      options.toDictionary(),
    );

    return result ?? false;
  }

  @override
  Future<bool> pipSetup(AgoraPipOptions options) async {
    // for iOS, we need to setup the pip view with extra parameters
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _pipSetupForIos(options);
    }

    // for other platforms, we can use the default setup method
    final result = await _rtcEngine.invokeAgoraMethod<bool>(
      'pipSetup',
      options.toDictionary(),
    );

    return result ?? false;
  }

  @override
  Future<bool> pipStart() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>('pipStart');
    return result ?? false;
  }

  @override
  Future<void> pipStop() async {
    await _rtcEngine.invokeAgoraMethod<void>('pipStop');
  }

  @override
  Future<void> pipDispose() async {
    await _disposeNativeViews();
    await _rtcEngine.invokeAgoraMethod<void>('pipDispose');
  }
}
