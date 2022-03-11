import 'package:integration_test/integration_test.dart';

import 'agora_rtc_engine_event_handler_smoke_test.generated.dart'
    as rtc_engine_event;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  rtc_engine_event.rtcEngineEventHandlerSomkeTestCases();
}
