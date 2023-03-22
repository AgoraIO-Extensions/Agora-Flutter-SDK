import 'package:integration_test/integration_test.dart';

import 'testcases/fake_agora_video_view_testcases.dart'
    as fake_agora_video_view;

/// Since the `RtcEngine` is singleton, so the fake test and actual integration test can not
/// be run at the same time, say that if a `RtcEngine` with fake implementation has been created,
/// the following test cases all run with this `RtcEngine` with fake implementation(since the `RtcEngine` is singleton),
/// so we spilt the fake test to a standalone test file.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  fake_agora_video_view.testCases();
}
