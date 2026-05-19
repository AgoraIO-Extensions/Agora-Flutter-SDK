import '/src/agora_base.dart';
import '/src/agora_media_base.dart';
import '/src/impl/agora_rtc_engine_impl.dart';
import '/src/impl/platform/global_video_view_controller.dart';
import '/src/render/video_view_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

// ignore_for_file: public_member_api_docs

const int kTextureNotInit = -1;
const int kInvalidPlatformViewId = -1;

class SurfaceTextureRenderTargetDisposable {
  SurfaceTextureRenderTargetDisposable._(
      this._controller, this._viewId, this.textureId);

  final VideoViewControllerBaseMixin _controller;
  final int _viewId;
  final int textureId;
  bool _isDisposed = false;

  static Future<SurfaceTextureRenderTargetDisposable> create(
    VideoViewControllerBaseMixin controller,
    int viewId,
  ) async {
    final renderTarget = await controller._acquireSurfaceTextureRenderTarget(
      viewId,
    );
    return SurfaceTextureRenderTargetDisposable._(
      controller,
      viewId,
      renderTarget['textureId']!,
    );
  }

  bool get isDisposed => _isDisposed;

  Future<void> dispose() async {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    await _controller._releaseSurfaceTextureRenderTarget(_viewId);
  }
}

class TextureRenderDisposable {
  TextureRenderDisposable._(this._controller, this._viewId);

  final VideoViewControllerBaseMixin _controller;
  final int _viewId;
  bool _isDisposed = false;

  static Future<TextureRenderDisposable> create(
    VideoViewControllerBaseMixin controller,
    int viewId,
  ) async {
    await controller._acquireTextureRender(viewId);
    return TextureRenderDisposable._(controller, viewId);
  }

  int get textureId =>
      _isDisposed ? kTextureNotInit : _controller.getTextureId();

  bool get isDisposed => _isDisposed;

  Future<void> dispose() async {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    await _controller._releaseTextureRender(_viewId);
  }
}

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
  int _sdkTextureTargetHandle = kNullViewHandle;
  int _viewHandle = kNullViewHandle;
  int _platformViewId = kInvalidPlatformViewId;

  final Set<int> _activeViewIds = {};

  int _textureWidth = 0;
  int _textureHeight = 0;

  @internal
  int get textureWidth => _textureWidth;

  @internal
  set textureWidth(int width) => _textureWidth = width;

  @internal
  int get textureHeight => _textureHeight;

  @internal
  set textureHeight(int height) => _textureHeight = height;

  @internal
  int get renderRefCount => _activeViewIds.length;

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
  int getSdkTextureTargetHandle() => _sdkTextureTargetHandle;

  @override
  int getViewHandle() => _viewHandle;

  @override
  int getPlatformViewId() => _platformViewId;

  @internal
  void updateController(VideoViewControllerBase oldController) {
    assert(oldController is VideoViewControllerBaseMixin);
    final oldControllerMixin = oldController as VideoViewControllerBaseMixin;
    _textureId = oldControllerMixin.getTextureId();
    _sdkTextureTargetHandle = oldControllerMixin.getSdkTextureTargetHandle();
    _viewHandle = oldControllerMixin.getViewHandle();
    _platformViewId = oldControllerMixin.getPlatformViewId();
  }

  @override
  Future<void> dispose() async {}

  Future<void> _acquireTextureRender(int viewId) async {
    if (!shouldUseFlutterTexture) {
      return;
    }

    if (_activeViewIds.contains(viewId)) {
      return;
    }

    _activeViewIds.add(viewId);

    if (_textureId == kTextureNotInit) {
      _textureId = await createTextureRender(
        canvas.uid!,
        connection?.channelId ?? '',
        canvas.sourceType?.value() ?? getVideoSourceType(),
        canvas.setupMode?.value() ??
            VideoViewSetupMode.videoViewSetupReplace.value(),
      );
    }
  }

  @internal
  bool get shouldUseSdkSurfaceTextureRender {
    return defaultTargetPlatform == TargetPlatform.android && useFlutterTexture;
  }

  @protected
  int getSurfaceTextureObserverId() => canvas.uid!;

  @protected
  Future<void> bindSdkSurfaceTextureTarget(int surfaceTextureHandle) async {}

  @protected
  Future<void> unbindSdkSurfaceTextureTarget() async {}

  Future<void> setupSdkSurfaceTextureRender() async {
    if (!shouldUseSdkSurfaceTextureRender ||
        _sdkTextureTargetHandle == kNullViewHandle) {
      return;
    }

    debugPrint(
      '[AgoraSurfaceTexture] bind '
      'uid=${canvas.uid} '
      'remote=${canvas.uid != 0} '
      'textureId=$_textureId '
      'surfaceTextureHandle=$_sdkTextureTargetHandle',
    );

    await bindSdkSurfaceTextureTarget(_sdkTextureTargetHandle);

    final newCanvas = VideoCanvas(
      uid: canvas.uid,
      subviewUid: canvas.subviewUid,
      view: _sdkTextureTargetHandle,
      backgroundColor: canvas.backgroundColor,
      renderMode: canvas.renderMode,
      mirrorMode: canvas.mirrorMode,
      setupMode: canvas.setupMode,
      sourceType: canvas.sourceType,
      mediaPlayerId: canvas.mediaPlayerId,
      cropArea: canvas.cropArea,
      enableAlphaMask: canvas.enableAlphaMask,
      position: canvas.position,
    );

    await rtcEngine.globalVideoViewController
        ?.setupVideoView(kNullViewHandle, newCanvas, connection: connection);
  }

  Future<Map<String, int>> _acquireSurfaceTextureRenderTarget(int viewId) async {
    if (!shouldUseSdkSurfaceTextureRender) {
      return {
        'textureId': kTextureNotInit,
        'surfaceTextureHandle': kNullViewHandle,
      };
    }

    if (_activeViewIds.contains(viewId) && _textureId != kTextureNotInit) {
      return {
        'textureId': _textureId,
        'surfaceTextureHandle': _sdkTextureTargetHandle,
      };
    }

    _activeViewIds.add(viewId);

    if (_textureId == kTextureNotInit ||
        _sdkTextureTargetHandle == kNullViewHandle) {
      final renderTarget = await rtcEngine.globalVideoViewController
          ?.createSurfaceTextureRenderTarget(
        getSurfaceTextureObserverId(),
        connection?.channelId ?? '',
        canvas.sourceType?.value() ?? getVideoSourceType(),
        canvas.setupMode?.value() ??
            VideoViewSetupMode.videoViewSetupReplace.value(),
      );
      _textureId = renderTarget?['textureId'] ?? kTextureNotInit;
      _sdkTextureTargetHandle =
          renderTarget?['surfaceTextureHandle'] ?? kNullViewHandle;
    }

    return {
      'textureId': _textureId,
      'surfaceTextureHandle': _sdkTextureTargetHandle,
    };
  }

  Future<void> _releaseTextureRender(int viewId) async {
    if (!shouldUseFlutterTexture) {
      return;
    }

    if (!_activeViewIds.contains(viewId)) {
      return;
    }

    _activeViewIds.remove(viewId);

    if (_activeViewIds.isEmpty && _textureId != kTextureNotInit) {
      await rtcEngine.globalVideoViewController
          ?.destroyTextureRender(_textureId);
      _textureId = kTextureNotInit;
      _textureWidth = 0;
      _textureHeight = 0;
    }
  }

  Future<void> _releaseSurfaceTextureRenderTarget(int viewId) async {
    if (!shouldUseSdkSurfaceTextureRender) {
      return;
    }

    if (!_activeViewIds.contains(viewId)) {
      return;
    }

    _activeViewIds.remove(viewId);

    if (_activeViewIds.isEmpty && _textureId != kTextureNotInit) {
      debugPrint(
        '[AgoraSurfaceTexture] release target '
        'textureId=$_textureId '
        'surfaceTextureHandle=$_sdkTextureTargetHandle',
      );
      await rtcEngine.globalVideoViewController
          ?.destroySurfaceTextureRenderTarget(_textureId);
      _textureId = kTextureNotInit;
      _sdkTextureTargetHandle = kNullViewHandle;
      _textureWidth = 0;
      _textureHeight = 0;
    }
  }

  @protected
  Future<void> disposeRenderInternal() async {
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

    if (_sdkTextureTargetHandle != kNullViewHandle) {
      debugPrint(
        '[AgoraSurfaceTexture] unbind '
        'uid=${canvas.uid} '
        'remote=${canvas.uid != 0} '
        'textureId=$_textureId '
        'surfaceTextureHandle=$_sdkTextureTargetHandle',
      );
      final newCanvas = VideoCanvas(
        view: _sdkTextureTargetHandle,
        renderMode: canvas.renderMode,
        mirrorMode: canvas.mirrorMode,
        uid: canvas.uid,
        sourceType: canvas.sourceType,
        cropArea: canvas.cropArea,
        setupMode: VideoViewSetupMode.videoViewSetupRemove,
        mediaPlayerId: canvas.mediaPlayerId,
      );

      await rtcEngine.globalVideoViewController
          ?.setupVideoView(kNullViewHandle, newCanvas, connection: connection);

      await unbindSdkSurfaceTextureTarget();

      _sdkTextureTargetHandle = kNullViewHandle;
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
    if (!shouldUseFlutterTexture) {
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
