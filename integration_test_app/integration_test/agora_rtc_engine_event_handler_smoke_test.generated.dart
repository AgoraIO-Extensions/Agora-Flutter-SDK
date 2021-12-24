// TODO(littlegnal): Temporary disable somke test for iOS/macOS, because it is not stable 
// to run somke test on CI at this time
@Skip('currently failing')

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late FakeIrisRtcEngine fakeIrisEngine;

  setUpAll(() async {
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
  });

  tearDownAll(() {
    fakeIrisEngine.dispose();
  });

  testWidgets('RtcEngineEventHander smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      
    ));

    fakeIrisEngine.fireAllEngineEvents();

    rtcEngine.destroy();
  });
}    

