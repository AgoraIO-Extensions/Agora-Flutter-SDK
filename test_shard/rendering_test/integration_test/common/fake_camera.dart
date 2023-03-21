import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class FakeCamera {
  FakeCamera(this._rtcEngine);
  final RtcEngine _rtcEngine;
  late final MediaPlayerController mediaPlayerController;
  late final MediaPlayerVideoFrameObserver observer;
  late final MediaPlayerSourceObserver mediaPlayerSourceObserver;

  late final Completer<void> _onFirstFrame;
  Future<void> get onFirstFrame => _onFirstFrame.future;

  Future<void> initialize() async {
    _onFirstFrame = Completer<void>();
    const url =
        'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4';
    await _rtcEngine
        .getMediaEngine()
        .setExternalVideoSource(enabled: true, useTexture: false);

    mediaPlayerController = MediaPlayerController(
        rtcEngine: _rtcEngine, canvas: const VideoCanvas());
    await mediaPlayerController.initialize();
    observer = MediaPlayerVideoFrameObserver(
      onFrame: (VideoFrame frame) async {
        if (frame.width == 0 || frame.height == 0) {
          return;
        }

        final width = frame.width!;
        final height = frame.height!;
        final ybuffer = frame.yBuffer!;
        final ubuffer = frame.uBuffer!;
        final vbuffer = frame.vBuffer!;

        final uvSize = frame.uBuffer!.length;

        final buffer = Uint8List(ybuffer.length + uvSize * 2);
        buffer.setRange(0, ybuffer.length, ybuffer);
        buffer.setRange(ybuffer.length, ybuffer.length + uvSize, ubuffer);
        buffer.setRange(ybuffer.length + uvSize, buffer.length, vbuffer);

        await _rtcEngine.getMediaEngine().pushVideoFrame(
            frame: ExternalVideoFrame(
                type: VideoBufferType.videoBufferRawData,
                format: VideoPixelFormat.videoPixelI420,
                buffer: buffer,
                stride: width,
                height: height,
                timestamp: DateTime.now().millisecondsSinceEpoch));

        _notifyOnFirstFrame();
      },
    );
    mediaPlayerController.registerVideoFrameObserver(observer);

    final mediaPlayerControllerPlayed = Completer<void>();

    mediaPlayerSourceObserver = MediaPlayerSourceObserver(
      onPlayerSourceStateChanged:
          (MediaPlayerState state, MediaPlayerError ec) async {
        if (state == MediaPlayerState.playerStateOpenCompleted) {
          await mediaPlayerController.play();
          await mediaPlayerController.setLoopCount(99999);
          mediaPlayerControllerPlayed.complete();
        }
      },
    );
    mediaPlayerController
        .registerPlayerSourceObserver(mediaPlayerSourceObserver);

    await mediaPlayerController.open(url: url, startPos: 0);

    await mediaPlayerControllerPlayed.future;

    await _rtcEngine.joinChannel(
      token: '',
      channelId: 'rendering_test',
      uid: 0,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _notifyOnFirstFrame() async {
    if (!_onFirstFrame.isCompleted) {
      // Delay 2 seconds to ensure the first frame showed
      await Future.delayed(const Duration(seconds: 2));
      if (_onFirstFrame.isCompleted) {
        return;
      }
      _onFirstFrame.complete(null);
    }
  }

  Future<void> dispose() async {
    mediaPlayerController.unregisterVideoFrameObserver(observer);
    mediaPlayerController
        .unregisterPlayerSourceObserver(mediaPlayerSourceObserver);
    await mediaPlayerController.dispose();
  }
}
