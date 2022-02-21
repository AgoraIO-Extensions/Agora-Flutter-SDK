import 'package:integration_test/integration_test.dart';

import 'agora_rtc_engine_subprocess_api_smoke_test.generated.dart'
    as rtc_engine_subprocess;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  rtc_engine_subprocess.rtcEngineSubProcessSmokeTestCases();
}
