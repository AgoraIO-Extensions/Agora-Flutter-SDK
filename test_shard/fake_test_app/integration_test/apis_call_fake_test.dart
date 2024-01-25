import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'generated/audiodevicemanager_fake_test.generated.dart'
    as audiodevicemanager;
import 'testcases/localspatialaudioengine_testcases.dart'
    as localspatialaudioengine;
import 'generated/mediaengine_fake_test.generated.dart' as mediaengine;
import 'generated/mediaplayer_fake_test.generated.dart' as mediaplayer;
import 'generated/mediarecorder_fake_test.generated.dart' as mediarecorder;
import 'generated/musiccontentcenter_fake_test.generated.dart'
    as musiccontentcenter;
import 'testcases/rtcengine_debug_testcases.dart' as rtcengine_debug;
import 'testcases/rtcengine_testcases.dart' as rtcengine;
import 'testcases/rtcengineex_testcases.dart' as rtcengineex;
import 'generated/videodevicemanager_fake_test.generated.dart'
    as videodevicemanager;

import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class TestInitilizationArgProvider implements InitilizationArgProvider {
  TestInitilizationArgProvider(this.testerArgs);
  TestInitilizationArgProvider.fromValue(IrisHandle this.value)
      : testerArgs = [];
  final List<TesterArgsProvider> testerArgs;
  IrisHandle? value;
  @override
  IrisHandle provide(IrisApiEngineHandle apiEngineHandle) {
    return value ?? ObjectIrisHandle(testerArgs[0](apiEngineHandle()));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  IrisTester? irisTester; // = createIrisTester();

  setUp(() {
    irisTester = createIrisTester();
    irisTester!.initialize();
    if (kIsWeb) {
      setMockRtcEngineProvider(
          TestInitilizationArgProvider(irisTester!.getTesterArgs()));
    } else {
      // On IO, the function return from the `irisTester.getTesterArgs()` capture
      // the `Pointer` from `IrisTester`, which is invalid to pass to the `Isolate`,
      // so directly pass the `ObjectIrisHandle` as value to the `setMockRtcEngineProvider`
      final value =
          irisTester!.getTesterArgs()[0](const IrisApiEngineHandle(0));
      setMockRtcEngineProvider(
          TestInitilizationArgProvider.fromValue(ObjectIrisHandle(value)));
    }
  });

  tearDown(() async {
    print('[iris_api_engine] tearDown start');
    setMockRtcEngineProvider(null);
    irisTester!.dispose();
    irisTester = null;
    await Future.delayed(const Duration(milliseconds: 500));
    print('[iris_api_engine] tearDown end');
  });

  if (!kIsWeb) {
    // audiodevicemanager.audioDeviceManagerSmokeTestCases();
    // localspatialaudioengine.testCases();
    mediaplayer.mediaPlayerControllerSmokeTestCases();
    mediarecorder.mediaRecorderSmokeTestCases();
    musiccontentcenter.musicContentCenterSmokeTestCases();
    rtcengine_debug.testCases();
  }

  mediaengine.mediaEngineSmokeTestCases();
  rtcengine.testCases();
  rtcengineex.testCases();
  videodevicemanager.videoDeviceManagerSmokeTestCases();
}
