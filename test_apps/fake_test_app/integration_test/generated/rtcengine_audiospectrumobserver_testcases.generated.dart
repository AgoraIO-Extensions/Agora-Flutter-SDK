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
    'AudioSpectrumObserver.onLocalAudioSpectrum',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');

      final onLocalAudioSpectrumCompleter = Completer<bool>();
      final theAudioSpectrumObserver = AudioSpectrumObserver(
        onLocalAudioSpectrum: (AudioSpectrumData data) {
          onLocalAudioSpectrumCompleter.complete(true);
        },
      );

      rtcEngine.registerAudioSpectrumObserver(
        theAudioSpectrumObserver,
      );

// Delay 500 milliseconds to ensure the registerAudioSpectrumObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        List<double> dataAudioSpectrumData = List.filled(5, 5.0);
        int dataDataLength = 5;
        AudioSpectrumData data = AudioSpectrumData(
          audioSpectrumData: dataAudioSpectrumData,
          dataLength: dataDataLength,
        );

        final eventJson = {
          'data': data.toJson(),
        };

        final eventIds =
            eventIdsMapping['AudioSpectrumObserver_onLocalAudioSpectrum'] ?? [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
          // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (kIsWeb && ret) {
            if (!onLocalAudioSpectrumCompleter.isCompleted) {
              onLocalAudioSpectrumCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled = await onLocalAudioSpectrumCompleter.future;
      expect(eventCalled, isTrue);

      {
        rtcEngine.unregisterAudioSpectrumObserver(
          theAudioSpectrumObserver,
        );
      }
// Delay 500 milliseconds to ensure the unregisterAudioSpectrumObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  testWidgets(
    'AudioSpectrumObserver.onRemoteAudioSpectrum',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');

      final onRemoteAudioSpectrumCompleter = Completer<bool>();
      final theAudioSpectrumObserver = AudioSpectrumObserver(
        onRemoteAudioSpectrum: (List spectrums, int spectrumNumber) {
          onRemoteAudioSpectrumCompleter.complete(true);
        },
      );

      rtcEngine.registerAudioSpectrumObserver(
        theAudioSpectrumObserver,
      );

// Delay 500 milliseconds to ensure the registerAudioSpectrumObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        final List<UserAudioSpectrumInfo> spectrums = () {
          List<double> spectrumDataAudioSpectrumData = List.filled(5, 5.0);
          int spectrumDataDataLength = 5;
          AudioSpectrumData spectrumsItemSpectrumData = AudioSpectrumData(
            audioSpectrumData: spectrumDataAudioSpectrumData,
            dataLength: spectrumDataDataLength,
          );
          int spectrumsItemUid = 5;
          UserAudioSpectrumInfo spectrumsItem = UserAudioSpectrumInfo(
            uid: spectrumsItemUid,
            spectrumData: spectrumsItemSpectrumData,
          );

          return List.filled(5, spectrumsItem);
        }();

        int spectrumNumber = 5;

        final eventJson = {
          'spectrums': spectrums,
          'spectrumNumber': spectrumNumber,
        };

        final eventIds =
            eventIdsMapping['AudioSpectrumObserver_onRemoteAudioSpectrum'] ??
                [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
          // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (kIsWeb && ret) {
            if (!onRemoteAudioSpectrumCompleter.isCompleted) {
              onRemoteAudioSpectrumCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled = await onRemoteAudioSpectrumCompleter.future;
      expect(eventCalled, isTrue);

      {
        rtcEngine.unregisterAudioSpectrumObserver(
          theAudioSpectrumObserver,
        );
      }
// Delay 500 milliseconds to ensure the unregisterAudioSpectrumObserver call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}