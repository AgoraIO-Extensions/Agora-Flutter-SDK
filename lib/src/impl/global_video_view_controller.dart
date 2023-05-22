import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter/services.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

class GlobalVideoViewController {
  GlobalVideoViewController(this.irisMethodChannel);

  final IrisMethodChannel irisMethodChannel;

  final MethodChannel methodChannel =
      const MethodChannel('agora_rtc_ng/video_view_controller');

  int _irisRtcRenderingHandle = 0;
  int get irisRtcRenderingHandle => _irisRtcRenderingHandle;

  final Map<int, Completer<void>> _destroyTextureRenderCompleters = {};
  bool _isDetachVFBMing = false;

  Future<void> attachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    if (_irisRtcRenderingHandle != 0) {
      return;
    }

    final CallApiResult result =
        await irisMethodChannel.invokeMethod(IrisMethodCall(
      'CreateIrisRtcRendering',
      jsonEncode({'irisRtcEngineNativeHandle': irisRtcEngineIntPtr}),
    ));
    _irisRtcRenderingHandle = result.data['irisRtcRenderingHandle'] ?? 0;
  }

  Future<void> detachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    if (_irisRtcRenderingHandle == 0) {
      return;
    }

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
  Future<void> destroyTextureRender(int textureId) async {
    _destroyTextureRenderCompleters.putIfAbsent(
        textureId, () => Completer<void>());

    await methodChannel.invokeMethod('destroyTextureRender', textureId);

    _destroyTextureRenderCompleters[textureId]?.complete(null);

    if (!_isDetachVFBMing) {
      _destroyTextureRenderCompleters.remove(textureId);
    }
  }
}
