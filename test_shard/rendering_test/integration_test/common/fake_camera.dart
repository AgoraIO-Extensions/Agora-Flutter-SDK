import 'dart:async';
import 'dart:ui';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class FakeCamera {
  FakeCamera(this._rtcEngine);
  final RtcEngine _rtcEngine;

  late final Completer<void> _onFirstFrame;
  Future<void> get onFirstFrame => _onFirstFrame.future;

  late final Timer _pushVideoFrameTimer;

  int _pushVideoFrameTimerCount = 0;
  bool _isNotifyOnFirstFrame = false;

  Future<void> initialize() async {
    _onFirstFrame = Completer<void>();
    await _rtcEngine
        .getMediaEngine()
        .setExternalVideoSource(enabled: true, useTexture: false);

    _pushVideoFrame();
  }

  Future<void> _pushVideoFrame() async {
    String assetName = 'agoravideoview_rendering_test_solid_spilt';
    if (kIsWeb) {
      // Use a small image for performence purpose.
      assetName = 'agoravideoview_rendering_test_solid_spilt_small';
    }
    ByteData data = await rootBundle.load("assets/$assetName.png");
    Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    final image = await decodeImageFromList(bytes);

    final byteData =
        await image.toByteData(format: ImageByteFormat.rawStraightRgba);
    final imageByteData = byteData!.buffer.asUint8List();
    final imageWidth = image.width;
    final imageHeight = image.height;
    image.dispose();

    _pushVideoFrameTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _rtcEngine.getMediaEngine().pushVideoFrame(
            frame: ExternalVideoFrame(
              type: VideoBufferType.videoBufferRawData,
              format: VideoPixelFormat.videoPixelRgba,
              buffer: imageByteData,
              stride: imageWidth,
              height: imageHeight,
              timestamp: DateTime.now().millisecondsSinceEpoch,
            ),
          );

      ++_pushVideoFrameTimerCount;

      // Skip 2 frames to ensure the pushed video frame has been shown
      if (_pushVideoFrameTimerCount >= 2) {
        _notifyOnFirstFrame();
      }
    });
  }

  Future<void> _notifyOnFirstFrame() async {
    if (_isNotifyOnFirstFrame) {
      return;
    }

    _isNotifyOnFirstFrame = true;
    if (!_onFirstFrame.isCompleted) {
      // Delay 2 seconds to ensure the first frame showed
      await Future.delayed(const Duration(seconds: 2));
      _onFirstFrame.complete(null);
    }
  }

  Future<void> dispose() async {
    _pushVideoFrameTimer.cancel();
  }
}
