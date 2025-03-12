import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller.dart';
import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

// ignore_for_file: public_member_api_docs

const int kTextureNotInit = -1;
const int kInvalidPlatformViewId = -1;

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
  int _viewHandle = kNullViewHandle;
  int _platformViewId = kInvalidPlatformViewId;

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

  @override
  int getViewHandle() => _viewHandle;

  @override
  int getPlatformViewId() => _platformViewId;

  @internal
  void updateController(VideoViewControllerBase oldController) {
    assert(oldController is VideoViewControllerBaseMixin);
    final oldControllerMixin = oldController as VideoViewControllerBaseMixin;
    _textureId = oldControllerMixin.getTextureId();
    _viewHandle = oldControllerMixin.getViewHandle();
    _platformViewId = oldControllerMixin.getPlatformViewId();
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

    // Pass view handle with kNullViewHandle will clear all setup renderers,
    // since we decide to use VideoViewSetupMode.videoViewSetupRemove to remove
    // the renderers, we should return directly here.
    if (_viewHandle != kNullViewHandle) {
      VideoCanvas newCanvas = VideoCanvas(
        view: _viewHandle,
        renderMode: canvas.renderMode,
        mirrorMode: canvas.mirrorMode,
        uid: canvas.uid,
        sourceType: canvas.sourceType,
        cropArea: canvas.cropArea,
        setupMode: VideoViewSetupMode.videoViewSetupRemove,
        mediaPlayerId: canvas.mediaPlayerId,
      );

      await rtcEngine.globalVideoViewController
          ?.setupVideoView(_viewHandle, newCanvas, connection: connection);

      _viewHandle = kNullViewHandle;
    }

    // We need to ensure the platform view is valid before calling setupVideoView since
    // we use VideoViewSetupMode.videoViewSetupRemove to remove renderers. This is important
    // because the platform view is shared between the app and native side via a GlobalRef address.
    if (_platformViewId != kInvalidPlatformViewId) {
      await dePlatformRenderRef(_platformViewId);
      _platformViewId = kInvalidPlatformViewId;
    }
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
  Future<void> setupView(int platformViewId, int nativeViewPtr) async {
    _platformViewId = platformViewId;
    _viewHandle = nativeViewPtr;

    if (_platformViewId != kInvalidPlatformViewId) {
      await addPlatformRenderRef(_platformViewId);
    }

    await rtcEngine.globalVideoViewController
        ?.setupVideoView(nativeViewPtr, canvas, connection: connection);
  }

  Future<void> addPlatformRenderRef(int platformViewId) async {
    await rtcEngine.globalVideoViewController
        ?.addPlatformRenderRef(platformViewId);
  }

  Future<void> dePlatformRenderRef(int platformViewId) async {
    await rtcEngine.globalVideoViewController
        ?.dePlatformRenderRef(platformViewId);
  }

  @internal
  bool get shouldHandlerRenderMode => true;
}
