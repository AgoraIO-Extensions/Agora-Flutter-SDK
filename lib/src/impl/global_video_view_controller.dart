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

  int _videoFrameBufferManagerIntPtr = 0;
  int get videoFrameBufferManagerIntPtr => _videoFrameBufferManagerIntPtr;

  Future<void> attachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    if (_videoFrameBufferManagerIntPtr != 0) {
      return;
    }

    final CallApiResult result =
        await irisMethodChannel.invokeMethod(IrisMethodCall(
      'CreateIrisVideoFrameBufferManager',
      jsonEncode({'irisRtcEngineNativeHandle': irisRtcEngineIntPtr}),
    ));
    _videoFrameBufferManagerIntPtr =
        result.data['videoFrameBufferManagerNativeHandle'] ?? 0;
  }

  Future<void> detachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    if (_videoFrameBufferManagerIntPtr == 0) {
      return;
    }
    await irisMethodChannel.invokeMethod(IrisMethodCall(
      'FreeIrisVideoFrameBufferManager',
      jsonEncode({
        'irisRtcEngineNativeHandle': irisRtcEngineIntPtr,
        'videoFrameBufferManagerNativeHandle': _videoFrameBufferManagerIntPtr,
      }),
    ));
    _videoFrameBufferManagerIntPtr = 0;
  }

  Future<int> createTextureRender(
      int uid, String channelId, int videoSourceType) async {
    final textureId =
        await methodChannel.invokeMethod<int>('createTextureRender', {
      'videoFrameBufferManagerNativeHandle': _videoFrameBufferManagerIntPtr,
      'uid': uid,
      'channelId': channelId,
      'videoSourceType': videoSourceType,
    });
    return textureId ?? kTextureNotInit;
  }

  /// [videoSourceType] definition:
  ///
  /// ```c++
  /// typedef enum IrisVideoSourceType {
  ///   kVideoSourceTypeCameraPrimary,
  ///   kVideoSourceTypeCameraSecondary,
  ///   kVideoSourceTypeScreenPrimary,
  ///   kVideoSourceTypeScreenSecondary,
  ///   kVideoSourceTypeCustom,
  ///   kVideoSourceTypeMediaPlayer,
  ///   kVideoSourceTypeRtcImagePng,
  ///   kVideoSourceTypeRtcImageJpeg,
  ///   kVideoSourceTypeRtcImageGif,
  ///   kVideoSourceTypeRemote,
  ///   kVideoSourceTypeTranscoded,
  ///   kVideoSourceTypePreEncode,
  ///   kVideoSourceTypePreEncodeSecondaryCamera,
  ///   kVideoSourceTypePreEncodeScreen,
  ///   kVideoSourceTypePreEncodeSecondaryScreen,
  ///   kVideoSourceTypeUnknown,
  /// } IrisVideoSourceType;
  /// ```
  Future<void> updateTextureRenderData(
      int textureId, int uid, String channelId, int videoSourceType) async {
    await methodChannel.invokeMethod('updateTextureRenderData', {
      'textureId': textureId,
      'uid': uid,
      'channelId': channelId,
      'videoSourceType': videoSourceType,
    });
  }

  Future<void> destroyTextureRender(int textureId) async {
    await methodChannel.invokeMethod('destroyTextureRender', textureId);
  }
}
