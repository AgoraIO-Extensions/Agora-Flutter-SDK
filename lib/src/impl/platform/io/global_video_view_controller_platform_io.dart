import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller_platform.dart';
import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter/services.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

const kNullViewHandle = 0;

class GlobalVideoViewControllerIO extends GlobalVideoViewControllerPlatfrom {
  GlobalVideoViewControllerIO(
      IrisMethodChannel irisMethodChannel, RtcEngineImpl rtcEngine)
      : super(irisMethodChannel, rtcEngine);

  final MethodChannel methodChannel =
      const MethodChannel('agora_rtc_ng/video_view_controller');

  int _irisRtcRenderingHandle = 0;
  @override
  int get irisRtcRenderingHandle => _irisRtcRenderingHandle;

  final Map<int, Completer<void>> _destroyTextureRenderCompleters = {};
  bool _isDetachVFBMing = false;

  void _hotRestartListener(Object? message) {
    assert(() {
      // Free `IrisRtcRendering` when hot restart
      final nativeBindingDelegate = IrisApiEngineNativeBindingDelegateProvider()
              .provideNativeBindingDelegate()
          as NativeIrisApiEngineBindingsDelegate;
      nativeBindingDelegate.initialize();
      nativeBindingDelegate.binding.FreeIrisRtcRendering(
          ffi.Pointer.fromAddress(_irisRtcRenderingHandle));

      return true;
    }());
  }

  @override
  Future<void> attachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    if (_irisRtcRenderingHandle != 0) {
      return;
    }

    irisMethodChannel.addHotRestartListener(_hotRestartListener);

    final CallApiResult result =
        await irisMethodChannel.invokeMethod(IrisMethodCall(
      'CreateIrisRtcRendering',
      jsonEncode({'irisRtcEngineNativeHandle': irisRtcEngineIntPtr}),
    ));
    _irisRtcRenderingHandle = result.data['irisRtcRenderingHandle'] ?? 0;
  }

  @override
  Future<void> detachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    if (_irisRtcRenderingHandle == 0) {
      return;
    }

    irisMethodChannel.removeHotRestartListener(_hotRestartListener);

    _isDetachVFBMing = true;

    // Need wait for all `destroyTextureRender` functions are called completed before
    // `FreeIrisVideoFrameBufferManager`, if not, the `destroyTextureRender`(call
    // `IrisVideoFrameBufferManager.DisableVideoFrameBuffer` in native side) and
    // `FreeIrisVideoFrameBufferManager` will be called parallelly, which will cause crash.
    for (final completer in _destroyTextureRenderCompleters.values) {
      if (!completer.isCompleted) {
        await completer.future;
      }
    }
    _destroyTextureRenderCompleters.clear();

    await irisMethodChannel.invokeMethod(IrisMethodCall(
      'FreeIrisRtcRendering',
      jsonEncode({
        'irisRtcEngineNativeHandle': irisRtcEngineIntPtr,
        'irisRtcRenderingHandle': _irisRtcRenderingHandle,
      }),
    ));
    _irisRtcRenderingHandle = 0;
  }

  @override
  Future<int> createTextureRender(int uid, String channelId,
      int videoSourceType, int videoViewSetupMode) async {
    final textureId =
        await methodChannel.invokeMethod<int>('createTextureRender', {
      'irisRtcRenderingHandle': _irisRtcRenderingHandle,
      'uid': uid,
      'channelId': channelId,
      'videoSourceType': videoSourceType,
      'videoViewSetupMode': videoViewSetupMode,
    });
    return textureId ?? kTextureNotInit;
  }

  /// Call `IrisVideoFrameBufferManager.DisableVideoFrameBuffer` in the native side
  @override
  Future<void> destroyTextureRender(int textureId) async {
    _destroyTextureRenderCompleters.putIfAbsent(
        textureId, () => Completer<void>());

    await methodChannel.invokeMethod('destroyTextureRender', textureId);

    _destroyTextureRenderCompleters[textureId]?.complete(null);

    if (!_isDetachVFBMing) {
      _destroyTextureRenderCompleters.remove(textureId);
    }
  }

  /// Decrease the ref count of the native view(`UIView` in iOS) of the `platformViewId`.
  /// Put this function here since the the `MethodChannel` in the `AgoraVideoView` is released
  /// after `AgoraVideoView.dispose`, so the `MethodChannel.invokeMethod` will never return
  /// after `AgoraVideoView.dispose`.
  @override
  Future<void> dePlatformRenderRef(int platformViewId) async {
    await methodChannel.invokeMethod('dePlatfromViewRef', platformViewId);
  }
}
