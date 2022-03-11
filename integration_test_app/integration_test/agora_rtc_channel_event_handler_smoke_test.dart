import 'package:integration_test/integration_test.dart';

import 'agora_rtc_channel_event_handler_smoke_test.generated.dart'
    as rtc_channel_event;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  rtc_channel_event.rtcChannelEventHandlerSomkeTestCases();
}
