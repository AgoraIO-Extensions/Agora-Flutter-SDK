@Skip('currently failing')

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'agora_rtc_device_manager_api_smoke_test.generated.dart'
    as rtc_device_manager;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  rtc_device_manager.rtcDeviceManagerSmokeTestCases();
}
