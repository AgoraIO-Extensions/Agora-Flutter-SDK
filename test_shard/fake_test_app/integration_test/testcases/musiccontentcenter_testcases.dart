import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import '../generated/musiccontentcenter_fake_test.generated.dart' as generated;

import '../testcases/event_ids_mapping.dart';

void testCases() {
  generated.musicContentCenterSmokeTestCases();

  testWidgets(
    'MusicContentCenter.destroyMusicPlayer',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');

      final musicContentCenter = rtcEngine.getMusicContentCenter();

      try {
        final musicPlayer = (await musicContentCenter.createMusicPlayer())!;
        await musicContentCenter.destroyMusicPlayer(
          musicPlayer,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint(
              '[MusicContentCenter.destroyMusicPlayer] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await musicContentCenter.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );
}
