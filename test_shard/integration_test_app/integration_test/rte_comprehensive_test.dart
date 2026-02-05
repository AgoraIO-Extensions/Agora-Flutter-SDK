import 'package:integration_test/integration_test.dart';

import 'testcases/rte_testcases.dart' as rte_basic;
import 'testcases/rte_error_testcases.dart' as rte_error;
import 'testcases/rte_playback_testcases.dart' as rte_playback;

/// RTE Comprehensive Integration Test Suite
///
/// Includes:
/// - Basic functionality tests (parameter passing, config round-trip)
/// - Error handling tests (invalid params, edge cases)
/// - Playback API tests (openWithUrl, play/pause/stop, seek, mute/unmute)
/// - Observer callback tests
/// - Lifecycle tests (creation/destruction order)
/// - Concurrent operation tests
/// - Protected parameter tests
///
/// ```bash
/// cd test_shard/integration_test_app
/// flutter test integration_test/rte_comprehensive_test.dart \
///   --dart-define=TEST_APP_ID=your_app_id
/// ```
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Run basic RTE tests
  rte_basic.testCases();

  // Run error and edge case tests
  rte_error.errorTestCases();

  // Run playback API tests (NEW)
  rte_playback.playbackTestCases();
}
