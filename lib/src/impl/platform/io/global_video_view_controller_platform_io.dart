import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller_platform.dart';
import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter/services.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

const kNullViewHandle = 0;

class GlobalVideoViewControllerIO extends GlobalVideoViewControllerPlatfrom {
  GlobalVideoViewControllerIO(
      IrisMethodChannel irisMethodChannel, RtcEngine rtcEngine)
      : super(irisMethodChannel, rtcEngine);

  final MethodChannel methodChannel =
      const MethodChannel('agora_rtc_ng/video_view_controller');

  int _irisRtcRenderingHandle = 0;
  @override
  int get irisRtcRenderingHandle => _irisRtcRenderingHandle;

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

    final irisRtcRenderingHandle = _irisRtcRenderingHandle;
    _irisRtcRenderingHandle = 0;

    irisMethodChannel.removeHotRestartListener(_hotRestartListener);

    await methodChannel.invokeMethod('dispose');

    await irisMethodChannel.invokeMethod(IrisMethodCall(
      'FreeIrisRtcRendering',
      jsonEncode({
        'irisRtcEngineNativeHandle': irisRtcEngineIntPtr,
        'irisRtcRenderingHandle': irisRtcRenderingHandle,
      }),
    ));
  }

  @override
  Future<int> createTextureRender(int uid, String channelId,
      int videoSourceType, int videoViewSetupMode) async {
    if (_irisRtcRenderingHandle == 0) {
      return kTextureNotInit;
    }
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
    if (_irisRtcRenderingHandle == 0) {
      return;
    }

    await methodChannel.invokeMethod('destroyTextureRender', textureId);
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
