import 'package:integration_test/integration_test.dart';

import 'testcases/rte_testcases.dart' as rte;

/// RTE Integration Test - Main Entry
/// 
/// 运行所有 RTE 集成测试
/// 
/// 运行方式:
/// ```bash
/// cd test_shard/integration_test_app
/// flutter test integration_test/rte_integration_test.dart \
///   --dart-define=TEST_APP_ID=your_app_id
/// ```
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  rte.testCases();
}
