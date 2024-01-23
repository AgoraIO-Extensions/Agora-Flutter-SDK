import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:iris_tester/iris_tester.dart';
import '../generated/rtcengine_rtcengineeventhandler_testcases.generated.dart'
    as generated;
import 'package:path/path.dart' as path;
import 'package:iris_method_channel/iris_method_channel.dart';

import '../testcases/event_ids_mapping.dart';

void testCases(ValueGetter<IrisTester> irisTester) {
  generated.generatedTestCases(irisTester);

  testWidgets(
    'onFacePositionChanged',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final onFacePositionChangedCompleter = Completer<bool>();
      final theRtcEngineEventHandler = RtcEngineEventHandler(
        onFacePositionChanged: (int imageWidth, int imageHeight,
            List vecRectangle, List vecDistance, int numFaces) {
          onFacePositionChangedCompleter.complete(true);
        },
      );

      rtcEngine.registerEventHandler(
        theRtcEngineEventHandler,
      );

// Delay 500 milliseconds to ensure the registerEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        const int imageWidth = 10;
        const int imageHeight = 10;
        const List<Rectangle> vecRectangle = [];
        const List<int> vecDistance = [];
        const int numFaces = 10;

        final eventJson = {
          'imageWidth': imageWidth,
          'imageHeight': imageHeight,
          'vecRectangle': vecRectangle,
          'vecDistance': vecDistance,
          'numFaces': numFaces,
        };

        final eventIds =
            eventIdsMapping['RtcEngineEventHandler_onFacePositionChanged'] ??
                [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
          // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (kIsWeb && ret) {
            if (!onFacePositionChangedCompleter.isCompleted) {
              onFacePositionChangedCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled = await onFacePositionChangedCompleter.future;
      expect(eventCalled, isTrue);

      {
        rtcEngine.unregisterEventHandler(
          theRtcEngineEventHandler,
        );
      }
// Delay 500 milliseconds to ensure the unregisterEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 1)),
    skip: kIsWeb || !(!kIsWeb && (Platform.isAndroid || Platform.isIOS)),
  );
}
