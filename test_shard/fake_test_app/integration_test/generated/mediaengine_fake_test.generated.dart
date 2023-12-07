/// GENERATED BY testcase_gen. DO NOT MODIFY BY HAND.

// ignore_for_file: deprecated_member_use,constant_identifier_names

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void mediaEngineSmokeTestCases() {
  testWidgets(
    'registerAudioFrameObserver',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        final AudioFrameObserver observer = AudioFrameObserver(
          onRecordAudioFrame: (String channelId, AudioFrame audioFrame) {},
          onPlaybackAudioFrame: (String channelId, AudioFrame audioFrame) {},
          onMixedAudioFrame: (String channelId, AudioFrame audioFrame) {},
          onEarMonitoringAudioFrame: (AudioFrame audioFrame) {},
          onPlaybackAudioFrameBeforeMixing:
              (String channelId, int uid, AudioFrame audioFrame) {},
        );
        mediaEngine.registerAudioFrameObserver(
          observer,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[registerAudioFrameObserver] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'registerVideoFrameObserver',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        final VideoFrameObserver observer = VideoFrameObserver(
          onCaptureVideoFrame:
              (VideoSourceType sourceType, VideoFrame videoFrame) {},
          onPreEncodeVideoFrame:
              (VideoSourceType sourceType, VideoFrame videoFrame) {},
          onMediaPlayerVideoFrame:
              (VideoFrame videoFrame, int mediaPlayerId) {},
          onRenderVideoFrame:
              (String channelId, int remoteUid, VideoFrame videoFrame) {},
          onTranscodedVideoFrame: (VideoFrame videoFrame) {},
        );
        mediaEngine.registerVideoFrameObserver(
          observer,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[registerVideoFrameObserver] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'registerVideoEncodedFrameObserver',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        final VideoEncodedFrameObserver observer = VideoEncodedFrameObserver(
          onEncodedVideoFrameReceived: (int uid, Uint8List imageBuffer,
              int length, EncodedVideoFrameInfo videoEncodedFrameInfo) {},
        );
        mediaEngine.registerVideoEncodedFrameObserver(
          observer,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint(
              '[registerVideoEncodedFrameObserver] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'pushAudioFrame',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const AudioFrameType frameType = AudioFrameType.frameTypePcm16;
        const BytesPerSample frameBytesPerSample =
            BytesPerSample.twoBytesPerSample;
        const int frameSamplesPerChannel = 10;
        const int frameChannels = 10;
        const int frameSamplesPerSec = 10;
        Uint8List frameBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int frameRenderTimeMs = 10;
        const int frameAvsyncType = 10;
        const int framePresentationMs = 10;
        const int frameAudioTrackNumber = 10;
        final AudioFrame frame = AudioFrame(
          type: frameType,
          samplesPerChannel: frameSamplesPerChannel,
          bytesPerSample: frameBytesPerSample,
          channels: frameChannels,
          samplesPerSec: frameSamplesPerSec,
          buffer: frameBuffer,
          renderTimeMs: frameRenderTimeMs,
          avsyncType: frameAvsyncType,
          presentationMs: framePresentationMs,
          audioTrackNumber: frameAudioTrackNumber,
        );
        const int trackId = 10;
        await mediaEngine.pushAudioFrame(
          frame: frame,
          trackId: trackId,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[pushAudioFrame] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'pullAudioFrame',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const AudioFrameType frameType = AudioFrameType.frameTypePcm16;
        const BytesPerSample frameBytesPerSample =
            BytesPerSample.twoBytesPerSample;
        const int frameSamplesPerChannel = 10;
        const int frameChannels = 10;
        const int frameSamplesPerSec = 10;
        Uint8List frameBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int frameRenderTimeMs = 10;
        const int frameAvsyncType = 10;
        const int framePresentationMs = 10;
        const int frameAudioTrackNumber = 10;
        final AudioFrame frame = AudioFrame(
          type: frameType,
          samplesPerChannel: frameSamplesPerChannel,
          bytesPerSample: frameBytesPerSample,
          channels: frameChannels,
          samplesPerSec: frameSamplesPerSec,
          buffer: frameBuffer,
          renderTimeMs: frameRenderTimeMs,
          avsyncType: frameAvsyncType,
          presentationMs: framePresentationMs,
          audioTrackNumber: frameAudioTrackNumber,
        );
        await mediaEngine.pullAudioFrame(
          frame,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[pullAudioFrame] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'setExternalVideoSource',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const bool enabled = true;
        const bool useTexture = true;
        const ExternalVideoSourceType sourceType =
            ExternalVideoSourceType.videoFrame;
        const TCcMode encodedVideoOptionCcMode = TCcMode.ccEnabled;
        const VideoCodecType encodedVideoOptionCodecType =
            VideoCodecType.videoCodecNone;
        const int encodedVideoOptionTargetBitrate = 10;
        const SenderOptions encodedVideoOption = SenderOptions(
          ccMode: encodedVideoOptionCcMode,
          codecType: encodedVideoOptionCodecType,
          targetBitrate: encodedVideoOptionTargetBitrate,
        );
        await mediaEngine.setExternalVideoSource(
          enabled: enabled,
          useTexture: useTexture,
          sourceType: sourceType,
          encodedVideoOption: encodedVideoOption,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setExternalVideoSource] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'setExternalAudioSource',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const bool enabled = true;
        const int sampleRate = 10;
        const int channels = 10;
        const bool localPlayback = true;
        const bool publish = true;
        await mediaEngine.setExternalAudioSource(
          enabled: enabled,
          sampleRate: sampleRate,
          channels: channels,
          localPlayback: localPlayback,
          publish: publish,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setExternalAudioSource] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'destroyCustomAudioTrack',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const int trackId = 10;
        await mediaEngine.destroyCustomAudioTrack(
          trackId,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[destroyCustomAudioTrack] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'setExternalAudioSink',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const bool enabled = true;
        const int sampleRate = 10;
        const int channels = 10;
        await mediaEngine.setExternalAudioSink(
          enabled: enabled,
          sampleRate: sampleRate,
          channels: channels,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setExternalAudioSink] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'enableCustomAudioLocalPlayback',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const int trackId = 10;
        const bool enabled = true;
        await mediaEngine.enableCustomAudioLocalPlayback(
          trackId: trackId,
          enabled: enabled,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[enableCustomAudioLocalPlayback] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'pushVideoFrame',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        const VideoBufferType frameType = VideoBufferType.videoBufferRawData;
        const VideoPixelFormat frameFormat = VideoPixelFormat.videoPixelDefault;
        const EglContextType frameEglType = EglContextType.eglContext10;
        Uint8List frameBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int frameStride = 10;
        const int frameHeight = 10;
        const int frameCropLeft = 10;
        const int frameCropTop = 10;
        const int frameCropRight = 10;
        const int frameCropBottom = 10;
        const int frameRotation = 10;
        const int frameTimestamp = 10;
        const int frameTextureId = 10;
        const List<double> frameMatrix = [];
        Uint8List frameMetadataBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int frameMetadataSize = 10;
        Uint8List frameAlphaBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int frameTextureSliceIndex = 10;
        final ExternalVideoFrame frame = ExternalVideoFrame(
          type: frameType,
          format: frameFormat,
          buffer: frameBuffer,
          stride: frameStride,
          height: frameHeight,
          cropLeft: frameCropLeft,
          cropTop: frameCropTop,
          cropRight: frameCropRight,
          cropBottom: frameCropBottom,
          rotation: frameRotation,
          timestamp: frameTimestamp,
          eglType: frameEglType,
          textureId: frameTextureId,
          matrix: frameMatrix,
          metadataBuffer: frameMetadataBuffer,
          metadataSize: frameMetadataSize,
          alphaBuffer: frameAlphaBuffer,
          textureSliceIndex: frameTextureSliceIndex,
        );
        const int videoTrackId = 10;
        await mediaEngine.pushVideoFrame(
          frame: frame,
          videoTrackId: videoTrackId,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[pushVideoFrame] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'pushEncodedVideoImage',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        Uint8List imageBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int length = 10;
        const VideoCodecType videoEncodedFrameInfoCodecType =
            VideoCodecType.videoCodecNone;
        const VideoFrameType videoEncodedFrameInfoFrameType =
            VideoFrameType.videoFrameTypeBlankFrame;
        const VideoOrientation videoEncodedFrameInfoRotation =
            VideoOrientation.videoOrientation0;
        const VideoStreamType videoEncodedFrameInfoStreamType =
            VideoStreamType.videoStreamHigh;
        const int videoEncodedFrameInfoUid = 10;
        const int videoEncodedFrameInfoWidth = 10;
        const int videoEncodedFrameInfoHeight = 10;
        const int videoEncodedFrameInfoFramesPerSecond = 10;
        const int videoEncodedFrameInfoTrackId = 10;
        const int videoEncodedFrameInfoCaptureTimeMs = 10;
        const int videoEncodedFrameInfoDecodeTimeMs = 10;
        const EncodedVideoFrameInfo videoEncodedFrameInfo =
            EncodedVideoFrameInfo(
          uid: videoEncodedFrameInfoUid,
          codecType: videoEncodedFrameInfoCodecType,
          width: videoEncodedFrameInfoWidth,
          height: videoEncodedFrameInfoHeight,
          framesPerSecond: videoEncodedFrameInfoFramesPerSecond,
          frameType: videoEncodedFrameInfoFrameType,
          rotation: videoEncodedFrameInfoRotation,
          trackId: videoEncodedFrameInfoTrackId,
          captureTimeMs: videoEncodedFrameInfoCaptureTimeMs,
          decodeTimeMs: videoEncodedFrameInfoDecodeTimeMs,
          streamType: videoEncodedFrameInfoStreamType,
        );
        const int videoTrackId = 10;
        await mediaEngine.pushEncodedVideoImage(
          imageBuffer: imageBuffer,
          length: length,
          videoEncodedFrameInfo: videoEncodedFrameInfo,
          videoTrackId: videoTrackId,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[pushEncodedVideoImage] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'release',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        await mediaEngine.release();
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[release] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'unregisterAudioFrameObserver',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        final AudioFrameObserver observer = AudioFrameObserver(
          onRecordAudioFrame: (String channelId, AudioFrame audioFrame) {},
          onPlaybackAudioFrame: (String channelId, AudioFrame audioFrame) {},
          onMixedAudioFrame: (String channelId, AudioFrame audioFrame) {},
          onEarMonitoringAudioFrame: (AudioFrame audioFrame) {},
          onPlaybackAudioFrameBeforeMixing:
              (String channelId, int uid, AudioFrame audioFrame) {},
        );
        mediaEngine.unregisterAudioFrameObserver(
          observer,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[unregisterAudioFrameObserver] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'unregisterVideoFrameObserver',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        final VideoFrameObserver observer = VideoFrameObserver(
          onCaptureVideoFrame:
              (VideoSourceType sourceType, VideoFrame videoFrame) {},
          onPreEncodeVideoFrame:
              (VideoSourceType sourceType, VideoFrame videoFrame) {},
          onMediaPlayerVideoFrame:
              (VideoFrame videoFrame, int mediaPlayerId) {},
          onRenderVideoFrame:
              (String channelId, int remoteUid, VideoFrame videoFrame) {},
          onTranscodedVideoFrame: (VideoFrame videoFrame) {},
        );
        mediaEngine.unregisterVideoFrameObserver(
          observer,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[unregisterVideoFrameObserver] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'unregisterVideoEncodedFrameObserver',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaEngine = rtcEngine.getMediaEngine();

      try {
        final VideoEncodedFrameObserver observer = VideoEncodedFrameObserver(
          onEncodedVideoFrameReceived: (int uid, Uint8List imageBuffer,
              int length, EncodedVideoFrameInfo videoEncodedFrameInfo) {},
        );
        mediaEngine.unregisterVideoEncodedFrameObserver(
          observer,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint(
              '[unregisterVideoEncodedFrameObserver] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await mediaEngine.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );
}

