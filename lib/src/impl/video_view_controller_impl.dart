import '/src/agora_base.dart';
import '/src/agora_media_base.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/agora_rtc_engine_impl.dart';
import '/src/impl/platform/global_video_view_controller.dart';
import '/src/impl/video_rendering_performance_uploader.dart';
import '/src/render/video_view_controller.dart';
import '/src/render/video_rendering_performance_monitor.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart' show internal;

// ignore_for_file: public_member_api_docs

const int kTextureNotInit = -1;
const int kInvalidPlatformViewId = -1;

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

  @visibleForTesting
  VideoSourceType get resolvedTextureVideoSourceType =>
      canvas.sourceType ?? VideoSourceTypeExt.fromValue(getVideoSourceType());

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
        connection,
        resolvedTextureVideoSourceType.value(),
        canvas.setupMode?.value() ??
            VideoViewSetupMode.videoViewSetupReplace.value(),
      );

      if (_textureId != kTextureNotInit) {
        _registerPerformanceStats(_textureId);
      }
    }
  }

  void _registerPerformanceStats(int textureId) {
    PerformanceStatsHandler.instance.register(
      textureId,
      RenderContext(
        rtcEngine: rtcEngine,
        uid: canvas.uid ?? 0,
        connection: connection,
        sourceType: resolvedTextureVideoSourceType,
      ),
    );
    VideoRenderingPerformanceMonitor.instance.startMonitoring(textureId);
  }

  void _unregisterPerformanceStats(int textureId) {
    PerformanceStatsHandler.instance.unregister(textureId);
    VideoRenderingPerformanceMonitor.instance.stopMonitoring(textureId);
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
      _unregisterPerformanceStats(_textureId);
      await rtcEngine.globalVideoViewController
          ?.destroyTextureRender(_textureId);
      _textureId = kTextureNotInit;
      _textureWidth = 0;
      _textureHeight = 0;
    }
  }

  @protected
  Future<void> disposeRenderInternal() async {
    if (shouldUseFlutterTexture) {
      // Stop performance monitoring for this texture
      if (_textureId != kTextureNotInit) {
        _unregisterPerformanceStats(_textureId);
      }

      await rtcEngine.globalVideoViewController
          ?.destroyTextureRender(getTextureId());
      _textureId = kTextureNotInit;
      if (connection != null) {
        PerformanceDataCollector.instance.clearChannelData(
            connection!.channelId ?? '',
            connection!.localUid ?? 0,
            resolvedTextureVideoSourceType);
      }
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

    if (connection?.channelId != null && connection?.localUid != null) {
      PerformanceDataCollector.instance.clearChannelData(
          connection!.channelId ?? '',
          connection!.localUid ?? 0,
          resolvedTextureVideoSourceType);
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
    RtcConnection? connection,
    int videoSourceType,
    int videoViewSetupMode,
  ) async {
    if (rtcEngine.globalVideoViewController == null) {
      return kTextureNotInit;
    }

    final textureId =
        await rtcEngine.globalVideoViewController!.createTextureRender(
      uid,
      connection,
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
          connection,
          resolvedTextureVideoSourceType.value(),
          canvas.setupMode?.value() ??
              VideoViewSetupMode.videoViewSetupReplace.value(),
        );

        // Start performance monitoring for this texture
        if (_textureId != kTextureNotInit) {
          _registerPerformanceStats(_textureId);
        }
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
