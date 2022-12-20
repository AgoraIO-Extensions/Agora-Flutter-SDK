import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
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
}

mixin VideoViewControllerBaseMixin implements VideoViewControllerBase {
  int _textureId = kTextureNotInit;

  @override
  int getTextureId() => _textureId;

  @override
  void setTextureId(int textureId) {
    _textureId = textureId;
  }

  @override
  Future<void> dispose() async {}

  @internal
  @override
  Future<void> disposeRender() async {
    if (shouldUseFlutterTexture) {
      await rtcEngine.globalVideoViewController
          .destroyTextureRender(getTextureId());
      _textureId = kTextureNotInit;
      return;
    }

    VideoCanvas videoCanvas = VideoCanvas(
      view: 0, // null
      renderMode: canvas.renderMode,
      mirrorMode: canvas.mirrorMode,
      uid: canvas.uid,
      sourceType: canvas.sourceType,
      cropArea: canvas.cropArea,
      setupMode: canvas.setupMode,
      mediaPlayerId: canvas.mediaPlayerId,
    );
    if (canvas.uid != 0) {
      await rtcEngine.setupRemoteVideo(videoCanvas);
    } else {
      await rtcEngine.setupLocalVideo(videoCanvas);
    }
  }

  @protected
  @override
  Future<int> createTextureRender(
    int uid,
    String channelId,
    int videoSourceType,
  ) {
    return rtcEngine.globalVideoViewController.createTextureRender(
      uid,
      channelId,
      videoSourceType,
    );
  }

  @override
  Future<void> initializeRender() async {
    if (shouldUseFlutterTexture) {
      if (_textureId == kTextureNotInit) {
        _textureId = await createTextureRender(
          canvas.uid!,
          connection?.channelId ?? '',
          canvas.sourceType?.value() ?? getVideoSourceType(),
        );
      }
    } else {}
  }

  @override
  Future<void> setupView(int nativeViewPtr) async {
    VideoCanvas videoCanvas = VideoCanvas(
      view: nativeViewPtr,
      renderMode: canvas.renderMode,
      mirrorMode: canvas.mirrorMode,
      uid: canvas.uid,
      sourceType: canvas.sourceType,
      cropArea: canvas.cropArea,
      setupMode: canvas.setupMode,
      mediaPlayerId: canvas.mediaPlayerId,
    );
    if (canvas.uid != 0) {
      if (connection != null) {
        await (rtcEngine as RtcEngineEx)
            .setupRemoteVideoEx(canvas: videoCanvas, connection: connection!);
      } else {
        await rtcEngine.setupRemoteVideo(videoCanvas);
      }
    } else {
      await rtcEngine.setupLocalVideo(videoCanvas);
    }
  }
}
