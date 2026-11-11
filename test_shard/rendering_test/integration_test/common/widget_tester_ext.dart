import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

abstract class AsyncTestDisposal {
  Future<void> get disposed;
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
  final disposals = tester.allStates
      .whereType<AsyncTestDisposal>()
      .map((state) => state.disposed)
      .toList();
  final disposed = Future.wait(disposals);
  // Force pump an empty Widget to trigger the dispose() for RemoteVideoView,
  // so that the previous RtcEngine can be released before the next test case start.
  await tester.pumpWidget(Container());
  if (disposals.isNotEmpty) {
    await disposed.timeout(const Duration(seconds: 15));
  } else {
    await binding.delayed(const Duration(seconds: 10));
  }
}
