import 'dart:convert';

import 'package:agora_rtc_engine/media_recorder.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('onRecorderStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');

    bool onRecorderStateChangedCalled = false;

    final mediaRecorder = MediaRecorder.getMediaRecorder(rtcEngine,
        callback: MediaRecorderObserver(
      onRecorderStateChanged: (state, error) {
        onRecorderStateChangedCalled = true;
      },
    ));

    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onRecorderStateChanged', '{"state":2,"error":2}');
    expect(onRecorderStateChangedCalled, isTrue);

    await mediaRecorder.releaseRecorder();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRecorderInfoUpdated', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');

    bool onRecorderInfoUpdatedCalled = false;

    final mediaRecorder = MediaRecorder.getMediaRecorder(rtcEngine,
        callback: MediaRecorderObserver(
      onRecorderInfoUpdated: (info) {
        onRecorderInfoUpdatedCalled = true;
      },
    ));

    RecorderInfo info = RecorderInfo('new_file', 100, 1024);
    await fakeIrisEngine.fireAndWaitEvent(tester, 'onRecorderInfoUpdated',
        '{"info":${jsonEncode(info.toJson())}}');
    expect(onRecorderInfoUpdatedCalled, isTrue);

    await mediaRecorder.releaseRecorder();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
}
