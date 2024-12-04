import 'package:integration_test/integration_test.dart';

import 'testcases/mediarecorder_fake_test_testcases.dart' as fake_mediarecorder;
import 'testcases/rtcengine_fake_test_testcases.dart' as fake_rtcengine;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  fake_mediarecorder.testCases();
  fake_rtcengine.testCases();
}
