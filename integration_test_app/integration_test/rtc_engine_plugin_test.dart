import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel methodChannel =
      MethodChannel('agora_rtc_engine/integration_test/rtc_engine_plugin');

  testWidgets(
    'RtcEnginePlugin callbacks called',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      final context = RtcEngineContext(
        engineAppId,
        areaCode: const [AreaCode.GLOB],
      );

      await methodChannel.invokeMethod('registerRtcEnginePlugin');

      final rtcEngine = await RtcEngine.createWithContext(context);

      final isRtcEngineCreated =
          await methodChannel.invokeMethod('isRtcEngineCreated');
      expect(isRtcEngineCreated, isTrue);

      final rtcEngineNativeHandleFromPlugin = await methodChannel
          .invokeMethod('getRtcEngineNativeHandleFromPlugin');

      final rtcEngineNativeHandle = await rtcEngine.getNativeHandle();
      expect(rtcEngineNativeHandle == rtcEngineNativeHandleFromPlugin, isTrue);

      await rtcEngine.destroy();

      final isRtcEngineDestroyed =
          await methodChannel.invokeMethod('isRtcEngineDestroyed');

      expect(isRtcEngineDestroyed, isTrue);

      await methodChannel.invokeMethod('unregisterRtcEnginePlugin');
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'should not call RtcEnginePlugin callbacks  after unregister',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      final context = RtcEngineContext(
        engineAppId,
        areaCode: const [AreaCode.GLOB],
      );

      await methodChannel.invokeMethod('registerRtcEnginePlugin');
      await methodChannel.invokeMethod('unregisterRtcEnginePlugin');

      final rtcEngine = await RtcEngine.createWithContext(context);
      final isRtcEngineCreated =
          await methodChannel.invokeMethod('isRtcEngineCreated');
      expect(isRtcEngineCreated, isFalse);

      await rtcEngine.destroy();

      final isRtcEngineDestroyed =
          await methodChannel.invokeMethod('isRtcEngineDestroyed');

      expect(isRtcEngineDestroyed, isFalse);
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );
}
