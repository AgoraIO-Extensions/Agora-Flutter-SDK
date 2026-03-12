import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/channel_connection_manager.dart';
import 'package:agora_rtc_engine/src/impl/media_player_controller_impl.dart';
import 'package:agora_rtc_engine/src/impl/video_rendering_performance_uploader.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:agora_rtc_engine/src/render/video_rendering_performance_monitor.dart';
import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingRtcEngine extends Fake implements RtcEngine {
  final List<String> uploadedParameters = [];

  @override
  Future<void> setParameters(String parameters) async {
    uploadedParameters.add(parameters);
  }
}

class _RegisteredContext {
  const _RegisteredContext({
    required this.textureId,
    required this.context,
    required this.drawCostMs,
  });

  final int textureId;
  final RenderContext context;
  final double drawCostMs;
}

RenderContext _contextFromController(VideoViewControllerBase controller) {
  final mixin = controller as VideoViewControllerBaseMixin;
  return RenderContext(
    rtcEngine: controller.rtcEngine,
    uid: controller.canvas.uid ?? 0,
    connection: controller.connection,
    sourceType: mixin.resolvedTextureVideoSourceType,
  );
}

Future<List<String>> _collectUploads(
  List<_RegisteredContext> contexts, {
  void Function()? seedManager,
}) async {
  seedManager?.call();

  for (final registered in contexts) {
    PerformanceStatsHandler.instance
        .register(registered.textureId, registered.context);
    PerformanceStatsHandler.instance.onVideoRenderingPerformance(
      VideoRenderingPerformanceStats(
        textureId: registered.textureId,
        uid: registered.context.uid,
        totalFramesRendered: 1,
        renderDrawCostMs: registered.drawCostMs,
      ),
    );
  }

  PerformanceDataCollector.instance.clearInactiveChannelData(const []);

  final uploads = <String>[];
  for (final registered in contexts) {
    final engine = registered.context.rtcEngine as _RecordingRtcEngine;
    uploads.addAll(engine.uploadedParameters);
    PerformanceStatsHandler.instance.unregister(registered.textureId);
  }
  return uploads;
}

Map<String, dynamic> _decodeUpload(String raw) {
  final outer = jsonDecode(raw) as Map<String, dynamic>;
  return Map<String, dynamic>.from(
    outer['rtc.report.argus_counters'] as Map,
  );
}

void main() {
  setUp(() {
    PerformanceDataCollector.instance.dispose();
    VideoRenderingPerformanceMonitor.instance.dispose();
    ChannelConnectionManager.instance.clear();
  });

  tearDown(() {
    PerformanceDataCollector.instance.dispose();
    VideoRenderingPerformanceMonitor.instance.dispose();
    ChannelConnectionManager.instance.clear();
  });

  test('local camera view does not upload without a valid rtc connection', () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads([
      _RegisteredContext(
        textureId: 1,
        context: _contextFromController(controller),
        drawCostMs: 12,
      ),
    ]);

    expect(uploads, isEmpty);
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceCamera.value(),
    );
  });

  test('local screen share does not upload without a valid rtc connection',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceScreenPrimary,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads([
      _RegisteredContext(
        textureId: 2,
        context: _contextFromController(controller),
        drawCostMs: 13,
      ),
    ]);

    expect(uploads, isEmpty);
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceScreenPrimary.value(),
    );
  });

  test('media player uploads with its own source type when connection is passed',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = MediaPlayerControllerImpl(
      engine,
      const VideoCanvas(uid: 0),
      const RtcConnection(channelId: 'media', localUid: 7),
      true,
      false,
    );

    final uploads = await _collectUploads([
      _RegisteredContext(
        textureId: 3,
        context: _contextFromController(controller),
        drawCostMs: 15,
      ),
    ]);

    expect(uploads, hasLength(1));

    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'media',
      'localUid': 7,
    });
    expect(payload['data'], [
      {
        'uid': 0,
        'counters': [
          {'counterId': 577, 'value': 15},
        ],
      },
    ]);
    expect(
      controller.resolvedTextureVideoSourceType.value(),
      VideoSourceType.videoSourceMediaPlayer.value(),
    );
  });

  test('media player does not upload without an explicit rtc connection',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = MediaPlayerControllerImpl(
      engine,
      const VideoCanvas(uid: 0),
      null,
      true,
      false,
    );

    final uploads = await _collectUploads([
      _RegisteredContext(
        textureId: 33,
        context: _contextFromController(controller),
        drawCostMs: 16,
      ),
    ]);

    expect(uploads, isEmpty);
    expect(
      controller.resolvedTextureVideoSourceType.value(),
      VideoSourceType.videoSourceMediaPlayer.value(),
    );
  });

  test('remote view uploads with explicit rtc connection and remote source type',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController.remote(
      rtcEngine: engine,
      canvas: const VideoCanvas(uid: 1001),
      connection: const RtcConnection(channelId: 'demo', localUid: 42),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads([
      _RegisteredContext(
        textureId: 4,
        context: _contextFromController(controller),
        drawCostMs: 12,
      ),
    ]);

    expect(uploads, hasLength(1));

    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'demo',
      'localUid': 42,
    });
    expect(payload['data'], [
      {
        'uid': 1001,
        'counters': [
          {'counterId': 576, 'value': 12},
        ],
      },
    ]);
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceRemote.value(),
    );
  });

  test(
      'remote view can fall back to active connection when local uid is missing',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController.remote(
      rtcEngine: engine,
      canvas: const VideoCanvas(uid: 1002),
      connection: const RtcConnection(channelId: 'fallback'),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 5,
          context: _contextFromController(controller),
          drawCostMs: 14,
        ),
      ],
      seedManager: () {
        ChannelConnectionManager.instance.addConnection(
          const RtcConnection(channelId: 'fallback', localUid: 99),
        );
      },
    );

    expect(uploads, hasLength(1));

    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'fallback',
      'localUid': 99,
    });
    expect(payload['data'], [
      {
        'uid': 1002,
        'counters': [
          {'counterId': 576, 'value': 14},
        ],
      },
    ]);
  });

  test('two remote connections in the same channel upload separate payloads',
      () async {
    final engineA = _RecordingRtcEngine();
    final engineB = _RecordingRtcEngine();

    final controllerA = VideoViewController.remote(
      rtcEngine: engineA,
      canvas: const VideoCanvas(uid: 2001),
      connection: const RtcConnection(channelId: 'room', localUid: 1),
      useFlutterTexture: true,
    );
    final controllerB = VideoViewController.remote(
      rtcEngine: engineB,
      canvas: const VideoCanvas(uid: 2002),
      connection: const RtcConnection(channelId: 'room', localUid: 2),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads([
      _RegisteredContext(
        textureId: 6,
        context: _contextFromController(controllerA),
        drawCostMs: 21,
      ),
      _RegisteredContext(
        textureId: 7,
        context: _contextFromController(controllerB),
        drawCostMs: 22,
      ),
    ]);

    expect(uploads, hasLength(2));

    final payloads = uploads.map(_decodeUpload).toList();
    expect(
      payloads
          .map((payload) => payload['connection'])
          .map((connection) => '${connection['channelId']}-${connection['localUid']}')
          .toSet(),
      {'room-1', 'room-2'},
    );
    expect(
      payloads
          .expand((payload) => payload['data'] as List)
          .map((entry) => entry['uid'])
          .toSet(),
      {2001, 2002},
    );
  });

  test(
      'local and remote views both upload when local source mapping is available',
      () async {
    final localEngine = _RecordingRtcEngine();
    final remoteEngine = _RecordingRtcEngine();

    final localController = VideoViewController(
      rtcEngine: localEngine,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true,
    );
    final remoteController = VideoViewController.remote(
      rtcEngine: remoteEngine,
      canvas: const VideoCanvas(uid: 3001),
      connection: const RtcConnection(channelId: 'pair', localUid: 8),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 8,
          context: _contextFromController(localController),
          drawCostMs: 11,
        ),
        _RegisteredContext(
          textureId: 9,
          context: _contextFromController(remoteController),
          drawCostMs: 12,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'pair', localUid: 8),
          options: const ChannelMediaOptions(
            publishCameraTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));

    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'pair',
      'localUid': 8,
    });
    expect(
      (payload['data'] as List).map((entry) => entry['uid']).toSet(),
      {0, 3001},
    );
  });

  test('local screen share uploads when screen source mapping is available',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceScreenPrimary,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 10,
          context: _contextFromController(controller),
          drawCostMs: 17,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'screen', localUid: 66),
          options: const ChannelMediaOptions(
            publishScreenTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));

    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'screen',
      'localUid': 66,
    });
    expect(payload['data'], [
      {
        'uid': 0,
        'counters': [
          {'counterId': 577, 'value': 17},
        ],
      },
    ]);
  });

  test('local media player uploads when media player publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = MediaPlayerControllerImpl(
      engine,
      const VideoCanvas(uid: 0),
      null,
      true,
      false,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 11,
          context: _contextFromController(controller),
          drawCostMs: 18,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'media-option', localUid: 12),
          options: const ChannelMediaOptions(
            publishMediaPlayerVideoTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'media-option',
      'localUid': 12,
    });
    expect(payload['data'], [
      {
        'uid': 0,
        'counters': [
          {'counterId': 577, 'value': 18},
        ],
      },
    ]);
    expect(
      controller.resolvedTextureVideoSourceType.value(),
      VideoSourceType.videoSourceMediaPlayer.value(),
    );
  });

  test('local custom source uploads when custom video publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceCustom,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 12,
          context: _contextFromController(controller),
          drawCostMs: 19,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'custom', localUid: 21),
          options: const ChannelMediaOptions(
            publishCustomVideoTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'custom',
      'localUid': 21,
    });
    expect(payload['data'], [
      {
        'uid': 0,
        'counters': [
          {'counterId': 577, 'value': 19},
        ],
      },
    ]);
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceCustom.value(),
    );
  });

  test(
      'local transcoded source uploads when transcoded video publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceTranscoded,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 13,
          context: _contextFromController(controller),
          drawCostMs: 20,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'transcoded', localUid: 31),
          options: const ChannelMediaOptions(
            publishTranscodedVideoTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'transcoded',
      'localUid': 31,
    });
    expect(payload['data'], [
      {
        'uid': 0,
        'counters': [
          {'counterId': 577, 'value': 20},
        ],
      },
    ]);
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceTranscoded.value(),
    );
  });

  test(
      'local secondary camera uploads when secondary camera publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceCameraSecondary,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 14,
          context: _contextFromController(controller),
          drawCostMs: 23,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'secondary-camera', localUid: 41),
          options: const ChannelMediaOptions(
            publishSecondaryCameraTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'secondary-camera',
      'localUid': 41,
    });
    expect(payload['data'], [
      {
        'uid': 0,
        'counters': [
          {'counterId': 577, 'value': 23},
        ],
      },
    ]);
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceCameraSecondary.value(),
    );
  });

  test('local third camera uploads when third camera publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceCameraThird,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 19,
          context: _contextFromController(controller),
          drawCostMs: 28,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'third-camera', localUid: 43),
          options: const ChannelMediaOptions(
            publishThirdCameraTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'third-camera',
      'localUid': 43,
    });
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceCameraThird.value(),
    );
  });

  test('local fourth camera uploads when fourth camera publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceCameraFourth,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 20,
          context: _contextFromController(controller),
          drawCostMs: 29,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'fourth-camera', localUid: 44),
          options: const ChannelMediaOptions(
            publishFourthCameraTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'fourth-camera',
      'localUid': 44,
    });
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceCameraFourth.value(),
    );
  });

  test(
      'local primary screen uploads when screen capture video option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceScreenPrimary,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 21,
          context: _contextFromController(controller),
          drawCostMs: 30,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'screen-capture', localUid: 71),
          options: const ChannelMediaOptions(
            publishScreenCaptureVideo: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'screen-capture',
      'localUid': 71,
    });
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceScreenPrimary.value(),
    );
  });

  test('local secondary screen uploads when secondary screen publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceScreenSecondary,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 22,
          context: _contextFromController(controller),
          drawCostMs: 31,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'secondary-screen', localUid: 72),
          options: const ChannelMediaOptions(
            publishSecondaryScreenTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'secondary-screen',
      'localUid': 72,
    });
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceScreenSecondary.value(),
    );
  });

  test('local third screen uploads when third screen publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceScreenThird,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 23,
          context: _contextFromController(controller),
          drawCostMs: 32,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'third-screen', localUid: 73),
          options: const ChannelMediaOptions(
            publishThirdScreenTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'third-screen',
      'localUid': 73,
    });
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceScreenThird.value(),
    );
  });

  test('local fourth screen uploads when fourth screen publish option is enabled',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = VideoViewController(
      rtcEngine: engine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceScreenFourth,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 24,
          context: _contextFromController(controller),
          drawCostMs: 33,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'fourth-screen', localUid: 74),
          options: const ChannelMediaOptions(
            publishFourthScreenTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'fourth-screen',
      'localUid': 74,
    });
    expect(
      (controller as VideoViewControllerBaseMixin)
          .resolvedTextureVideoSourceType
          .value(),
      VideoSourceType.videoSourceScreenFourth.value(),
    );
  });

  test(
      'different local source types can upload to different channels in parallel',
      () async {
    final cameraEngine = _RecordingRtcEngine();
    final screenEngine = _RecordingRtcEngine();

    final cameraController = VideoViewController(
      rtcEngine: cameraEngine,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true,
    );
    final screenController = VideoViewController(
      rtcEngine: screenEngine,
      canvas: const VideoCanvas(
        uid: 0,
        sourceType: VideoSourceType.videoSourceScreenPrimary,
      ),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 15,
          context: _contextFromController(cameraController),
          drawCostMs: 24,
        ),
        _RegisteredContext(
          textureId: 16,
          context: _contextFromController(screenController),
          drawCostMs: 25,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'camera-room', localUid: 51),
          options: const ChannelMediaOptions(
            publishCameraTrack: true,
          ),
        );
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'screen-room', localUid: 52),
          options: const ChannelMediaOptions(
            publishScreenTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(2));
    final payloads = uploads.map(_decodeUpload).toList();
    expect(
      payloads
          .map((payload) => payload['connection'])
          .map((connection) =>
              '${connection['channelId']}-${connection['localUid']}')
          .toSet(),
      {'camera-room-51', 'screen-room-52'},
    );
  });

  test(
      'same local source type across multiple channels collapses to latest mapping',
      () async {
    final engineA = _RecordingRtcEngine();
    final engineB = _RecordingRtcEngine();

    final controllerA = VideoViewController(
      rtcEngine: engineA,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true,
    );
    final controllerB = VideoViewController(
      rtcEngine: engineB,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 17,
          context: _contextFromController(controllerA),
          drawCostMs: 26,
        ),
        _RegisteredContext(
          textureId: 18,
          context: _contextFromController(controllerB),
          drawCostMs: 27,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'first-camera', localUid: 61),
          options: const ChannelMediaOptions(
            publishCameraTrack: true,
          ),
        );
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection:
              const RtcConnection(channelId: 'second-camera', localUid: 62),
          options: const ChannelMediaOptions(
            publishCameraTrack: true,
          ),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'second-camera',
      'localUid': 62,
    });
    expect(
      (payload['data'] as List).map((entry) => entry['uid']).toList(),
      [0],
    );
  });

  test(
      'refreshing publishing connections updates upload group connection without rewriting remote uid',
      () async {
    final localEngine = _RecordingRtcEngine();
    final remoteEngine = _RecordingRtcEngine();

    final localController = VideoViewController(
      rtcEngine: localEngine,
      canvas: const VideoCanvas(uid: 0),
      useFlutterTexture: true,
    );
    final remoteController = VideoViewController.remote(
      rtcEngine: remoteEngine,
      canvas: const VideoCanvas(uid: 12321),
      connection: const RtcConnection(channelId: 'test1', localUid: 2511698660),
      useFlutterTexture: true,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 25,
          context: _contextFromController(localController),
          drawCostMs: 2,
        ),
        _RegisteredContext(
          textureId: 26,
          context: _contextFromController(remoteController),
          drawCostMs: 3,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'test1', localUid: 0),
          options: const ChannelMediaOptions(
            publishCameraTrack: true,
          ),
        );
        ChannelConnectionManager.instance.refreshPublishingConnections(
          const RtcConnection(channelId: 'test1', localUid: 2511698660),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'test1',
      'localUid': 2511698660,
    });
    expect(
      (payload['data'] as List).map((entry) => entry['uid']).toSet(),
      {0, 12321},
    );
  });

  test(
      'refreshing publishing connections upgrades media player mapping from placeholder uid',
      () async {
    final engine = _RecordingRtcEngine();
    final controller = MediaPlayerControllerImpl(
      engine,
      const VideoCanvas(uid: 0),
      null,
      true,
      false,
    );

    final uploads = await _collectUploads(
      [
        _RegisteredContext(
          textureId: 27,
          context: _contextFromController(controller),
          drawCostMs: 4,
        ),
      ],
      seedManager: () {
        syncPublishingConnectionsFromMediaOptions(
          manager: ChannelConnectionManager.instance,
          connection: const RtcConnection(channelId: 'MP', localUid: 0),
          options: const ChannelMediaOptions(
            publishMediaPlayerVideoTrack: true,
          ),
        );
        ChannelConnectionManager.instance.refreshPublishingConnections(
          const RtcConnection(channelId: 'MP', localUid: 456),
        );
      },
    );

    expect(uploads, hasLength(1));
    final payload = _decodeUpload(uploads.single);
    expect(payload['connection'], {
      'channelId': 'MP',
      'localUid': 456,
    });
  });
}
