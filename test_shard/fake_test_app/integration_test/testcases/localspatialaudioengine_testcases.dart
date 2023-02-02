import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
import '../generated/localspatialaudioengine_fake_test.generated.dart'
    as generated;
import '../generated/basespatialaudioengine_fake_test.generated.dart'
    as basespatialaudioengine;

void testCases() {
  generated.localSpatialAudioEngineSmokeTestCases();
  basespatialaudioengine.localSpatialAudioEngineSmokeTestCases();

  testWidgets(
    'updateSelfPosition',
    (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final localSpatialAudioEngine = rtcEngine.getLocalSpatialAudioEngine();

      try {
        const List<double> position = [1, 2, 3];
        const List<double> axisForward = [1, 2, 3];
        const List<double> axisRight = [1, 2, 3];
        const List<double> axisUp = [1, 2, 3];
        await localSpatialAudioEngine.updateSelfPosition(
          position: position,
          axisForward: axisForward,
          axisRight: axisRight,
          axisUp: axisUp,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[updateSelfPosition] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await localSpatialAudioEngine.release();
      await rtcEngine.release();
    },
  );

  testWidgets(
    'updateSelfPositionEx',
    (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final localSpatialAudioEngine = rtcEngine.getLocalSpatialAudioEngine();

      try {
        const List<double> position = [1, 2, 3];
        const List<double> axisForward = [1, 2, 3];
        const List<double> axisRight = [1, 2, 3];
        const List<double> axisUp = [1, 2, 3];
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        await localSpatialAudioEngine.updateSelfPositionEx(
          position: position,
          axisForward: axisForward,
          axisRight: axisRight,
          axisUp: axisUp,
          connection: connection,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[updateSelfPositionEx] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await localSpatialAudioEngine.release();
      await rtcEngine.release();
    },
  );
}
