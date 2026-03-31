import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'testcases/rte_testcases.dart' as rte_basic;
import 'testcases/rte_error_testcases.dart' as rte_error;
import 'testcases/rte_playback_testcases.dart' as rte_playback;

/// RTE Comprehensive Integration Test Suite
///
/// Single global SDK lifecycle shared across all test suites.
/// This avoids "RTE instance already created" on Android where the
/// native singleton does not tolerate repeated createWithConfig calls.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const String testAppId =
      String.fromEnvironment('TEST_APP_ID', defaultValue: '<YOUR_APP_ID>');

  late AgoraRte rte;

  setUpAll(() async {
    rte = createAgoraRte();
    // Defensive: destroy any stale native state from a previous run
    // (e.g. hot-restart on a real device where the app process survived).
    try {
      await rte.destroy();
      debugPrint('=== Global setUpAll: cleared stale RTE state ===');
    } catch (_) {
      // Expected on a clean start — no instance to destroy.
    }
    rte = createAgoraRte();
    await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
    await rte.initMediaEngine();
    debugPrint('=== Global setUpAll: RTE initialized ===');
  });

  tearDownAll(() async {
    try {
      await rte.destroy();
      debugPrint('=== Global tearDownAll: RTE destroyed ===');
    } catch (e) {
      debugPrint('=== Global tearDownAll: destroy error: $e ===');
    }
  });

  rte_basic.testCases(() => rte);
  rte_error.errorTestCases(() => rte, (r) => rte = r);
  rte_playback.playbackTestCases(() => rte);
}
