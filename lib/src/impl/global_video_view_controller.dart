import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter/services.dart';

// ignore_for_file: public_member_api_docs

class GlobalVideoViewController {
  GlobalVideoViewController();

  final MethodChannel methodChannel =
      const MethodChannel('agora_rtc_ng/video_view_controller');

  int _videoFrameBufferManagerIntPtr = 0;
  int get videoFrameBufferManagerIntPtr => _videoFrameBufferManagerIntPtr;

  Future<void> attachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    final videoFrameBufferManagerIntPtr = await methodChannel.invokeMethod<int>(
        'attachVideoFrameBufferManager', irisRtcEngineIntPtr);

    _videoFrameBufferManagerIntPtr = videoFrameBufferManagerIntPtr ?? 0;
  }

  Future<void> detachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    await methodChannel.invokeMethod(
        'detachVideoFrameBufferManager', irisRtcEngineIntPtr);
  }

  Future<int> createTextureRender(
      int uid, String channelId, int videoSourceType) async {
    final textureId =
        await methodChannel.invokeMethod<int>('createTextureRender', {
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
