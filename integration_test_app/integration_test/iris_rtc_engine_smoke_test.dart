import 'dart:io';

import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel methodChannel = MethodChannel('agora_rtc_engine');

  testWidgets(
    'Force destroy IrisRtcEngine',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      final context = RtcEngineContext(
        engineAppId,
        areaCode: const [AreaCode.GLOB],
      );

      final rtcEngine = await RtcEngine.createWithContext(context);
      rtcEngine.setEventHandler(RtcEngineEventHandler());

      await rtcEngine.enableAudioVolumeIndication(200, 3, false);

      final rtcChannel = await RtcChannel.create('testonci');
      rtcChannel.setEventHandler(RtcChannelEventHandler());
      await rtcChannel.joinChannel(null, null, 0, ChannelMediaOptions());

      await methodChannel.invokeMethod('forceDestroyIrisRtcEngine');
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );
}
