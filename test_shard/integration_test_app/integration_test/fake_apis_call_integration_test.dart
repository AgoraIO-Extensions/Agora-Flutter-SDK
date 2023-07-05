import 'package:integration_test/integration_test.dart';

import 'testcases/mediarecorder_fake_test_testcases.dart' as fake_mediarecorder;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  fake_mediarecorder.testCases();
}
