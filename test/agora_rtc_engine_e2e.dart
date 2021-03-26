import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:e2e/e2e.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  group('basic', () {
    RtcEngine engine;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      engine = await RtcEngine.create('');
      engine.setEventHandler(RtcEngineEventHandler(warning: (warn) {
        print('engine warn $warn');
      }, rtcStats: (stats) {
        print('engine rtcStats ${stats.toJson()}');
      }));
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (engine != null) {
        await engine.destroy();
      }
    });

    testWidgets('joinChannel', (WidgetTester widgetTester) async {
      await engine.joinChannel(null, '123', null, 0);
      expect(await engine.getCallId(), isNotNull);
    });
  });
}
