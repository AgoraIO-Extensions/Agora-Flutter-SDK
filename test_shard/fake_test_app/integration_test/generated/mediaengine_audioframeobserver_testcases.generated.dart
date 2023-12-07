/// GENERATED BY testcase_gen. DO NOT MODIFY BY HAND.

// ignore_for_file: deprecated_member_use,constant_identifier_names

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases(IrisTester irisTester) {
  testWidgets(
    'onPlaybackAudioFrameBeforeMixing',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      final mediaEngine = rtcEngine.getMediaEngine();

      final onPlaybackAudioFrameBeforeMixingCompleter = Completer<bool>();
      final theAudioFrameObserver = AudioFrameObserver(
        onPlaybackAudioFrameBeforeMixing:
            (String channelId, int uid, AudioFrame audioFrame) {
          onPlaybackAudioFrameBeforeMixingCompleter.complete(true);
        },
      );

      mediaEngine.registerAudioFrameObserver(
        theAudioFrameObserver,
      );

// Delay 500 milliseconds to ensure the registerAudioFrameObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        const String channelId = "hello";
        const int uid = 10;
        const AudioFrameType audioFrameType = AudioFrameType.frameTypePcm16;
        const BytesPerSample audioFrameBytesPerSample =
            BytesPerSample.twoBytesPerSample;
        const int audioFrameSamplesPerChannel = 10;
        const int audioFrameChannels = 10;
        const int audioFrameSamplesPerSec = 10;
        Uint8List audioFrameBuffer = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int audioFrameRenderTimeMs = 10;
        const int audioFrameAvsyncType = 10;
        const int audioFramePresentationMs = 10;
        const int audioFrameAudioTrackNumber = 10;
        final AudioFrame audioFrame = AudioFrame(
          type: audioFrameType,
          samplesPerChannel: audioFrameSamplesPerChannel,
          bytesPerSample: audioFrameBytesPerSample,
          channels: audioFrameChannels,
          samplesPerSec: audioFrameSamplesPerSec,
          buffer: audioFrameBuffer,
          renderTimeMs: audioFrameRenderTimeMs,
          avsyncType: audioFrameAvsyncType,
          presentationMs: audioFramePresentationMs,
          audioTrackNumber: audioFrameAudioTrackNumber,
        );

        final eventJson = {
          'channelId': channelId,
          'uid': uid,
          'audioFrame': audioFrame.toJson(),
        };

        if (!kIsWeb) {
          irisTester.fireEvent(
              'AudioFrameObserver_onPlaybackAudioFrameBeforeMixing',
              params: eventJson);
        } else {
          final ret = irisTester.fireEvent(
              'AudioFrameObserver_onPlaybackAudioFrameBeforeMixing',
              params: eventJson);
// Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
// TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (ret) {
            if (!onPlaybackAudioFrameBeforeMixingCompleter.isCompleted) {
              onPlaybackAudioFrameBeforeMixingCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled =
          await onPlaybackAudioFrameBeforeMixingCompleter.future;
      expect(eventCalled, isTrue);

      {
        mediaEngine.unregisterAudioFrameObserver(
          theAudioFrameObserver,
        );
      }
// Delay 500 milliseconds to ensure the unregisterAudioFrameObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}

