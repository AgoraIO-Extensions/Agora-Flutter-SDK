import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/media_player_controller_impl.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRtcEngine extends Fake implements RtcEngine {}

class _RecordingTextureController
    with VideoViewControllerBaseMixin
    implements VideoViewControllerBase {
  _RecordingTextureController({
    required this.rtcEngine,
    required this.canvas,
    required this.connection,
  });

  @override
  final RtcEngine rtcEngine;

  @override
  final VideoCanvas canvas;

  @override
  final RtcConnection? connection;

  @override
  final bool useFlutterTexture = true;

  @override
  final bool useAndroidSurfaceView = false;

  RtcConnection? recordedConnection;
  int? recordedUid;
  int? recordedVideoSourceType;
  int? recordedVideoViewSetupMode;

  @override
  int getVideoSourceType() => VideoSourceType.videoSourceCamera.value();

  @override
  Future<int> createTextureRender(
    int uid,
    RtcConnection? connection,
    int videoSourceType,
    int videoViewSetupMode,
  ) async {
    recordedUid = uid;
    recordedConnection = connection;
    recordedVideoSourceType = videoSourceType;
    recordedVideoViewSetupMode = videoViewSetupMode;
    return 100;
  }

  @override
  Future<void> setupView(int platformViewId, int nativeViewPtr) async {}
}

void main() {
  late RtcEngine rtcEngine;

  setUp(() {
    rtcEngine = _FakeRtcEngine();
  });

  group('resolvedTextureVideoSourceType', () {
    test('returns explicit canvas source type when provided', () {
      final controller = VideoViewController(
        rtcEngine: rtcEngine,
        canvas: const VideoCanvas(
          uid: 0,
          sourceType: VideoSourceType.videoSourceScreenPrimary,
        ),
      );

      expect(
        controller.resolvedTextureVideoSourceType.value(),
        VideoSourceType.videoSourceScreenPrimary.value(),
      );
    });

    test('falls back to local camera source for default local video view', () {
      final controller = VideoViewController(
        rtcEngine: rtcEngine,
        canvas: const VideoCanvas(uid: 0),
      );

      expect(
        controller.resolvedTextureVideoSourceType.value(),
        VideoSourceType.videoSourceCamera.value(),
      );
    });

    test('falls back to remote source for default remote video view', () {
      final controller = VideoViewController.remote(
        rtcEngine: rtcEngine,
        canvas: const VideoCanvas(uid: 1001),
        connection: const RtcConnection(channelId: 'demo'),
      );

      expect(
        controller.resolvedTextureVideoSourceType.value(),
        VideoSourceType.videoSourceRemote.value(),
      );
    });

    test('falls back to media player source for media player controller', () {
      final controller = MediaPlayerControllerImpl(
        rtcEngine,
        const VideoCanvas(uid: 0),
        null,
        true,
        false,
      );

      expect(
        controller.resolvedTextureVideoSourceType.value(),
        VideoSourceType.videoSourceMediaPlayer.value(),
      );
    });
  });

  test('initializeRender forwards full rtc connection to createTextureRender',
      () async {
    const connection = RtcConnection(channelId: 'demo', localUid: 42);
    final controller = _RecordingTextureController(
      rtcEngine: rtcEngine,
      canvas: const VideoCanvas(uid: 0),
      connection: connection,
    );

    await controller.initializeRender();

    expect(controller.recordedUid, 0);
    expect(controller.recordedConnection, connection);
    expect(
      controller.recordedVideoSourceType,
      VideoSourceType.videoSourceCamera.value(),
    );
    expect(
      controller.recordedVideoViewSetupMode,
      VideoViewSetupMode.videoViewSetupReplace.value(),
    );
  });
}
