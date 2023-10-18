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
  final List<TesterArgsProvider> testerArgs;
  @override
  IrisHandle provide(IrisApiEngineHandle apiEngineHandle) {
    return ObjectIrisHandle(testerArgs[0](apiEngineHandle()));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  IrisTester irisTester = createIrisTester();

  setUp(() {
    irisTester.initialize();
    setMockRtcEngineProvider(
        TestInitilizationArgProvider(irisTester.getTesterArgs()));
  });

  tearDown(() {
    irisTester.dispose();
    setMockRtcEngineProvider(null);
  });

  if (!kIsWeb) {
    audiodevicemanager.audioDeviceManagerSmokeTestCases();
    localspatialaudioengine.testCases();
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
