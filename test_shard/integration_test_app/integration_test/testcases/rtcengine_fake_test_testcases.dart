import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import '../fake/fake_iris_method_channel.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

void testCases() {
  group('RtcEngine.initialize', () {
    final FakeIrisMethodChannel irisMethodChannel =
        FakeIrisMethodChannel(IrisApiEngineNativeBindingDelegateProvider());
    final RtcEngine rtcEngine =
        RtcEngineImpl.createForTesting(irisMethodChannel: irisMethodChannel);

    setUp(() {
      irisMethodChannel.reset();
    });

    testWidgets(
      'only initialize once',
      (WidgetTester tester) async {
        String engineAppId = const String.fromEnvironment('TEST_APP_ID',
            defaultValue: '<YOUR_APP_ID>');

        Directory appDocDir = await getApplicationDocumentsDirectory();
        String logPath = path.join(appDocDir.path, 'test_log.txt');

        await rtcEngine.initialize(RtcEngineContext(
          appId: engineAppId,
          areaCode: AreaCode.areaCodeGlob.value(),
          logConfig: LogConfig(filePath: logPath),
        ));
        await rtcEngine.initialize(RtcEngineContext(
          appId: engineAppId,
          areaCode: AreaCode.areaCodeGlob.value(),
          logConfig: LogConfig(filePath: logPath),
        ));
        await rtcEngine.initialize(RtcEngineContext(
          appId: engineAppId,
          areaCode: AreaCode.areaCodeGlob.value(),
          logConfig: LogConfig(filePath: logPath),
        ));
        final calls = irisMethodChannel.methodCallQueue
            .where((e) => e.funcName == 'initilize')
            .toList();
        expect(calls.length == 1, true);

        await rtcEngine.release();
      },
    );

    testWidgets(
      'only initialize once when called simultaneously',
      (WidgetTester tester) async {
        String engineAppId = const String.fromEnvironment('TEST_APP_ID',
            defaultValue: '<YOUR_APP_ID>');

        Directory appDocDir = await getApplicationDocumentsDirectory();
        String logPath = path.join(appDocDir.path, 'test_log.txt');

        for (int i = 0; i < 5; ++i) {
          rtcEngine.initialize(RtcEngineContext(
            appId: engineAppId,
            areaCode: AreaCode.areaCodeGlob.value(),
            logConfig: LogConfig(filePath: logPath),
          ));
        }
        // Wait for the 5 times calls of `irisMethodChannel.initilize` are completed.
        await Future.delayed(const Duration(milliseconds: 1000));

        final calls = irisMethodChannel.methodCallQueue
            .where((e) => e.funcName == 'initilize')
            .toList();
        expect(calls.length == 1, true);

        await rtcEngine.release();
      },
    );

    testWidgets(
      're-initialize once after release',
      (WidgetTester tester) async {
        String engineAppId = const String.fromEnvironment('TEST_APP_ID',
            defaultValue: '<YOUR_APP_ID>');

        Directory appDocDir = await getApplicationDocumentsDirectory();
        String logPath = path.join(appDocDir.path, 'test_log.txt');
        {
          await rtcEngine.initialize(RtcEngineContext(
            appId: engineAppId,
            areaCode: AreaCode.areaCodeGlob.value(),
            logConfig: LogConfig(filePath: logPath),
          ));
          await rtcEngine.initialize(RtcEngineContext(
            appId: engineAppId,
            areaCode: AreaCode.areaCodeGlob.value(),
            logConfig: LogConfig(filePath: logPath),
          ));
          await rtcEngine.initialize(RtcEngineContext(
            appId: engineAppId,
            areaCode: AreaCode.areaCodeGlob.value(),
            logConfig: LogConfig(filePath: logPath),
          ));

          final calls = irisMethodChannel.methodCallQueue
              .where((e) => e.funcName == 'initilize')
              .toList();
          expect(calls.length == 1, true);

          await rtcEngine.release();
        }

        irisMethodChannel.reset();

        {
          await rtcEngine.initialize(RtcEngineContext(
            appId: engineAppId,
            areaCode: AreaCode.areaCodeGlob.value(),
            logConfig: LogConfig(filePath: logPath),
          ));
          await rtcEngine.initialize(RtcEngineContext(
            appId: engineAppId,
            areaCode: AreaCode.areaCodeGlob.value(),
            logConfig: LogConfig(filePath: logPath),
          ));
          await rtcEngine.initialize(RtcEngineContext(
            appId: engineAppId,
            areaCode: AreaCode.areaCodeGlob.value(),
            logConfig: LogConfig(filePath: logPath),
          ));

          final calls = irisMethodChannel.methodCallQueue
              .where((e) => e.funcName == 'initilize')
              .toList();
          expect(calls.length == 1, true);
        }

        await rtcEngine.release();
      },
    );
  });
}
