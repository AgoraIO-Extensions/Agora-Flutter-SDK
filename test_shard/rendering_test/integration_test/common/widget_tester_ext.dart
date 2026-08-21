import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

final List<RtcEngine> _pendingRtcEngineReleases = <RtcEngine>[];

void queueRtcEngineRelease(RtcEngine rtcEngine) {
  _pendingRtcEngineReleases.add(rtcEngine);
}

Future<void> waitFrame(WidgetTester tester) async {
  // Call `pumpAndSettle` more times to ensure the video rendered
  for (int i = 0; i < 5; i++) {
    await tester.pumpAndSettle(const Duration(seconds: 10));
  }
}

Future<void> waitDisposed(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  // Force pump an empty Widget to trigger the dispose() for RemoteVideoView,
  // so that the previous RtcEngine can be released before the next test case start.
  await tester.pumpWidget(Container());
  await binding.delayed(const Duration(seconds: 10));

  final engines = List<RtcEngine>.of(_pendingRtcEngineReleases);
  _pendingRtcEngineReleases.clear();
  for (final engine in engines) {
    await engine.release();
  }
}
