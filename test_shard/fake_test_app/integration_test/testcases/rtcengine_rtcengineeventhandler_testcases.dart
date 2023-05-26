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

void testCases(IrisTester irisTester) {
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

        irisTester.fireEvent('RtcEngineEventHandler_onFacePositionChanged',
            params: eventJson);
        irisTester.fireEvent('RtcEngineEventHandlerEx_onFacePositionChanged',
            params: eventJson);
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
    skip: !(Platform.isAndroid || Platform.isIOS),
  );
}
