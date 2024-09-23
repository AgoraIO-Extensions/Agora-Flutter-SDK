import 'dart:async';

import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller.dart';
import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

// ignore_for_file: public_member_api_docs

const int kTextureNotInit = -1;

extension VideoViewControllerBaseExt on VideoViewControllerBase {
  bool isSame(VideoViewControllerBase other) {
    bool isSame = canvas.view == other.canvas.view &&
        canvas.renderMode == other.canvas.renderMode &&
        canvas.mirrorMode == other.canvas.mirrorMode &&
        canvas.uid == other.canvas.uid &&
        canvas.sourceType == other.canvas.sourceType &&
        canvas.cropArea == other.canvas.cropArea &&
        canvas.setupMode == other.canvas.setupMode &&
        canvas.mediaPlayerId == other.canvas.mediaPlayerId;
    isSame = isSame &&
        connection?.channelId == other.connection?.channelId &&
        connection?.localUid == other.connection?.localUid;
    isSame = isSame && shouldUseFlutterTexture == other.shouldUseFlutterTexture;
    isSame = isSame && useAndroidSurfaceView == other.useAndroidSurfaceView;
    return isSame;
  }

  @internal
  bool get shouldUseFlutterTexture =>
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows) ||
      useFlutterTexture;

  @internal
  bool get shouldHandlerRenderMode =>
      this is VideoViewControllerBaseMixin &&
      (this as VideoViewControllerBaseMixin).shouldHandlerRenderMode;

  @internal
  bool get isLocalUid => canvas.uid == 0;
}

mixin VideoViewControllerBaseMixin implements VideoViewControllerBase {
  int _textureId = kTextureNotInit;

  @internal
  bool get isInitialzed => (rtcEngine as RtcEngineImpl).isInitialzed;

  @internal
  void addInitializedCompletedListener(VoidCallback listener) {
    final engine = rtcEngine as RtcEngineImpl;
    engine.addInitializedCompletedListener(listener);
  }

  @internal
  void removeInitializedCompletedListener(VoidCallback listener) {
    final engine = rtcEngine as RtcEngineImpl;
    engine.removeInitializedCompletedListener(listener);
  }

  @override
  int getTextureId() => _textureId;

  @internal
  void updateController(VideoViewControllerBase oldController) {
    assert(oldController is VideoViewControllerBaseMixin);
    final oldControllerMixin = oldController as VideoViewControllerBaseMixin;
    _textureId = oldControllerMixin.getTextureId();
  }

  @override
  Future<void> dispose() async {}

  @protected
  Future<void> disposeRenderInternal() async {
    if (shouldUseFlutterTexture) {
      await rtcEngine.globalVideoViewController
          ?.destroyTextureRender(getTextureId());
      _textureId = kTextureNotInit;
      return;
    }

    await rtcEngine.globalVideoViewController
        ?.setupVideoView(kNullViewHandle, canvas, connection: connection);
  }

  @internal
  @override
  Future<void> disposeRender() async {
    await disposeRenderInternal();
  }

  @protected
  @override
  Future<int> createTextureRender(
    int uid,
    String channelId,
    int videoSourceType,
    int videoViewSetupMode,
  ) async {
    if (rtcEngine.globalVideoViewController == null) {
      return kTextureNotInit;
    }

    final textureId =
        await rtcEngine.globalVideoViewController!.createTextureRender(
      uid,
      channelId,
      videoSourceType,
      videoViewSetupMode,
    );

    return textureId;
  }

  @override
  Future<void> initializeRender() async {
    if (shouldUseFlutterTexture) {
      if (_textureId == kTextureNotInit) {
        _textureId = await createTextureRender(
          canvas.uid!,
          connection?.channelId ?? '',
          canvas.sourceType?.value() ?? getVideoSourceType(),
          canvas.setupMode?.value() ??
              VideoViewSetupMode.videoViewSetupReplace.value(),
        );
      }
    } else {
      if (kIsWeb) {
        // Make sure the `platformViewRegistry.registerViewFactory` is called.
        rtcEngine.globalVideoViewController;
      }
    }
  }

  @override
  Future<void> setupView(int nativeViewPtr) async {
    await rtcEngine.globalVideoViewController
        ?.setupVideoView(nativeViewPtr, canvas, connection: connection);
  }

  Future<void> dePlatformRenderRef(int platformViewId) async {
    await rtcEngine.globalVideoViewController
        ?.dePlatformRenderRef(platformViewId);
  }

  @internal
  bool get shouldHandlerRenderMode => true;
}

/// Implementation of [PIPVideoViewController]
class PIPVideoViewControllerImpl extends VideoViewController
    implements PIPVideoViewController {
  /// @nodoc
  // ignore: use_super_parameters
  PIPVideoViewControllerImpl(
      {required RtcEngine rtcEngine,
      required VideoCanvas canvas,
      bool useAndroidSurfaceView = false})
      : super(
          rtcEngine: rtcEngine,
          canvas: canvas,
          useFlutterTexture: false,
          useAndroidSurfaceView: useAndroidSurfaceView,
        );

  /// @nodoc
  // ignore: use_super_parameters
  PIPVideoViewControllerImpl.remote(
      {required RtcEngine rtcEngine,
      required VideoCanvas canvas,
      required RtcConnection connection,
      bool useAndroidSurfaceView = false})
      : super.remote(
          rtcEngine: rtcEngine,
          canvas: canvas,
          connection: connection,
          useFlutterTexture: false,
          useAndroidSurfaceView: useAndroidSurfaceView,
        );

  int _nativeViewPtr = 0;
  Completer _attachNativeViewCompleter = Completer<void>();
  bool _isStartPictureInPicture = false;
  bool _isDisposedRender = false;

  @override
  Future<void> setupView(int nativeViewPtr) async {
    await super.setupView(nativeViewPtr);

    _isDisposedRender = false;
    _nativeViewPtr = nativeViewPtr;
    _attachNativeViewCompleter.complete();
  }

  @override
  Future<void> disposeRender() async {
    _isDisposedRender = true;
    _nativeViewPtr = 0;
    _attachNativeViewCompleter = Completer<void>();
    return super.disposeRender();
  }

  @override
  Future<void> dispose() async {
    return stopPictureInPicture();
  }

  @override
  Future<bool> isPipSupported() {
    return rtcEngine.isPipSupported();
  }

  @override
  Future<void> startPictureInPicture(PipOptions options) async {
    assert(!kIsWeb, 'PIP feature is not supported on web.');
    assert(
        defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android,
        'PIP feature is not supported on this platform.');
    if (_isStartPictureInPicture || _isDisposedRender) {
      return;
    }

    _isStartPictureInPicture = true;

    late int contentSource = 0;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _attachNativeViewCompleter.future;
      contentSource = _nativeViewPtr;
    } else {
      assert(defaultTargetPlatform == TargetPlatform.android);
      contentSource =
          await rtcEngine.globalVideoViewController!.getCurrentActivityHandle();
    }

    if (contentSource == 0 || _isDisposedRender) {
      return;
    }

    final newVideoCanvasMap = (options.canvas ?? canvas).toJson();
    newVideoCanvasMap['view'] = contentSource;
    VideoCanvas? newVideoCanvas = VideoCanvas.fromJson(newVideoCanvasMap);
    PipOptions newOptions = PipOptions(
      contentSource: contentSource,
      contentWidth: options.contentWidth,
      contentHeight: options.contentHeight,
      autoEnterPip: options.autoEnterPip,
      canvas: newVideoCanvas,
    );

    await rtcEngine.setupPip(newOptions);
    await rtcEngine.startPip();
  }

  @override
  Future<void> stopPictureInPicture() async {
    if (!_isStartPictureInPicture) {
      return;
    }

    _isStartPictureInPicture = false;
    // On android, there's no stop pip function
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await rtcEngine.stopPip();
    }
  }

  @override
  bool get isInPictureInPictureMode => _isStartPictureInPicture;
}
