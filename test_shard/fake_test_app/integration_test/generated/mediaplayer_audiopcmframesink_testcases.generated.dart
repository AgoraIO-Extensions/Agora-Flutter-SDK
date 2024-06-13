/// GENERATED BY testcase_gen. DO NOT MODIFY BY HAND.

// ignore_for_file: deprecated_member_use,constant_identifier_names

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

import '../testcases/event_ids_mapping.dart';

void generatedTestCases(ValueGetter<IrisTester> irisTester) {
  testWidgets(
    'AudioPcmFrameSink.onFrame',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');
      MediaPlayerController mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas());
      await mediaPlayerController.initialize();

      final onFrameCompleter = Completer<bool>();
      final theAudioPcmFrameSink = AudioPcmFrameSink(
        onFrame: (AudioPcmFrame frame) {
          onFrameCompleter.complete(true);
        },
      );

      RawAudioFrameOpModeType mode =
          RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly;

      mediaPlayerController.registerAudioFrameObserver(
        observer: theAudioPcmFrameSink,
        mode: mode,
      );

// Delay 500 milliseconds to ensure the registerAudioFrameObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        BytesPerSample frameBytesPerSample = BytesPerSample.twoBytesPerSample;
        int frameCaptureTimestamp = 5;
        int frameSamplesPerChannel = 5;
        int frameSampleRateHz = 5;
        int frameNumChannels = 5;
        List<int> frameData = List.filled(5, 5);
        bool frameIsStereo = true;
        AudioPcmFrame frame = AudioPcmFrame(
          captureTimestamp: frameCaptureTimestamp,
          samplesPerChannel: frameSamplesPerChannel,
          sampleRateHz: frameSampleRateHz,
          numChannels: frameNumChannels,
          bytesPerSample: frameBytesPerSample,
          data: frameData,
          isStereo: frameIsStereo,
        );

        final eventJson = {
          'frame': frame.toJson(),
        };

        final eventIds = eventIdsMapping['AudioPcmFrameSink_onFrame'] ?? [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
          // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (kIsWeb && ret) {
            if (!onFrameCompleter.isCompleted) {
              onFrameCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled = await onFrameCompleter.future;
      expect(eventCalled, isTrue);

      {
        mediaPlayerController.unregisterAudioFrameObserver(
          theAudioPcmFrameSink,
        );
      }
// Delay 500 milliseconds to ensure the unregisterAudioFrameObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
