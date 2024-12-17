import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

const kNullViewHandle = 0;
const kPlatformRendererNotInit = 0;

abstract class GlobalVideoViewControllerPlatfrom {
  GlobalVideoViewControllerPlatfrom(this.irisMethodChannel, this.rtcEngine);

  final IrisMethodChannel irisMethodChannel;

  final RtcEngine rtcEngine;

  int get irisRtcRenderingHandle => 0;

  Future<void> attachVideoFrameBufferManager(int irisRtcEngineIntPtr) =>
      SynchronousFuture(null);

  Future<void> detachVideoFrameBufferManager(int irisRtcEngineIntPtr) =>
      SynchronousFuture(null);

  Future<int> createTextureRender(int uid, String channelId,
          int videoSourceType, int videoViewSetupMode) =>
      SynchronousFuture(kTextureNotInit);

  /// Call `IrisVideoFrameBufferManager.DisableVideoFrameBuffer` in the native side
  Future<void> destroyTextureRender(int textureId) => SynchronousFuture(null);

  /// Decrease the ref count of the native view(`UIView` in iOS) of the `platformViewId`.
  /// Put this function here since the the `MethodChannel` in the `AgoraVideoView` is released
  /// after `AgoraVideoView.dispose`, so the `MethodChannel.invokeMethod` will never return
  /// after `AgoraVideoView.dispose`.
  Future<void> dePlatformRenderRef(int platformViewId) =>
      SynchronousFuture(null);

  Future<void> setupVideoView(Object viewHandle, VideoCanvas videoCanvas,
      {RtcConnection? connection}) async {
    await rtcEngine.setupVideoView(
      viewHandle,
      videoCanvas,
      connection: connection,
    );
  }
}
