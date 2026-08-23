import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

final List<RtcEngine> _pendingRtcEngineReleases = <RtcEngine>[];
final List<Future<void>> _pendingDisposals = <Future<void>>[];

void queueRtcEngineRelease(RtcEngine rtcEngine) {
  _pendingRtcEngineReleases.add(rtcEngine);
}

void queueDisposal(Future<void> disposal) {
  _pendingDisposals.add(disposal);
}

Future<void> waitPendingDisposals([
  IntegrationTestWidgetsFlutterBinding? binding,
]) async {
  if (_pendingDisposals.isEmpty && _pendingRtcEngineReleases.isEmpty) {
    return;
  }

  const delay = Duration(seconds: 10);
  if (binding == null) {
    await Future<void>.delayed(delay);
  } else {
    await binding.delayed(delay);
  }

  final disposals = List<Future<void>>.of(_pendingDisposals);
  _pendingDisposals.clear();
  await Future.wait(disposals);

  final engines = List<RtcEngine>.of(_pendingRtcEngineReleases);
  _pendingRtcEngineReleases.clear();
  for (final engine in engines) {
    await engine.release();
  }
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
  await waitPendingDisposals(binding);
}
