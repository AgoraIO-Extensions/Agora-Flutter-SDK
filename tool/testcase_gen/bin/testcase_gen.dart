import 'dart:io';

import 'package:args/args.dart';
import 'package:paraphrase/paraphrase.dart';
import 'package:testcase_gen/default_generator.dart';
import 'package:testcase_gen/fake_test_templated_generator.dart';
import 'package:testcase_gen/generator.dart';
import 'package:testcase_gen/media_recorder_observer_somke_test_generator.dart';
import 'package:testcase_gen/rtc_channel_event_handler_smoke_test_generator.dart';
import 'package:testcase_gen/rtc_device_manager_smoke_test_generator.dart';
import 'package:testcase_gen/rtc_engine_event_handler_somke_test_generator.dart';
import 'package:testcase_gen/rtc_engine_sub_process_smoke_test_generator.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:path/path.dart' as path;
import 'package:testcase_gen/templated_generator.dart';

List<TemplatedTestCase> _createIntegarationTestCases(String outputDir) {
  List<TemplatedTestCase> templatedTestCases = [
    TemplatedTestCase(
      className: 'MediaPlayerCacheManager',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void mediaPlayerCacheManagerSmokeTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final mediaPlayerCacheManager = getMediaPlayerCacheManager(rtcEngine);
    
    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
      }
      expect(e is AgoraRtcException, true);
      debugPrint(
        '[{{TEST_CASE_NAME}}] errorcode: \${(e as AgoraRtcException).code}');
    }

    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'mediaPlayerCacheManager',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
  ];
  return templatedTestCases;
}

List<TemplatedTestCase> _createFakeTestCases(String outputDir) {
  List<TemplatedTestCase> templatedTestCases = [
    TemplatedTestCase(
      className: 'RtcEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void rtcEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await rtcEngine.release();
  },
);
''',
      methodInvokeObjectName: 'rtcEngine',
      outputDir: outputDir,
      skipMemberFunctions: [
        'destroyMediaPlayer',
        // These cases should handle the list size manually.
        'setLocalAccessPoint',
        'startChannelMediaRelay',
        'updateChannelMediaRelay',
        'setSubscribeAudioBlocklist',
        'setSubscribeAudioAllowlist',
        'setSubscribeVideoBlocklist',
        'setSubscribeVideoAllowlist',
      ],
    ),
    TemplatedTestCase(
      className: 'RtcEngineEx',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void rtcEngineExSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngineEx rtcEngineEx = createAgoraRtcEngineEx();
    await rtcEngineEx.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await rtcEngineEx.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'rtcEngineEx',
      outputDir: outputDir,
      skipMemberFunctions: [
        // These cases should handle the list size manually.
        'setSubscribeAudioBlocklistEx',
        'setSubscribeAudioAllowlistEx',
        'setSubscribeVideoBlocklistEx',
        'setSubscribeVideoAllowlistEx',
        'startChannelMediaRelayEx',
        'updateChannelMediaRelayEx',
      ],
    ),
    TemplatedTestCase(
      className: 'AudioDeviceManager',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void audioDeviceManagerSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final audioDeviceManager = rtcEngine.getAudioDeviceManager();

    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }
    
    await audioDeviceManager.release();
    await rtcEngine.release();
  },
);
''',
      methodInvokeObjectName: 'audioDeviceManager',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
    TemplatedTestCase(
      className: 'VideoDeviceManager',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void videoDeviceManagerSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final videoDeviceManager = rtcEngine.getVideoDeviceManager();

    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await videoDeviceManager.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'videoDeviceManager',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
    TemplatedTestCase(
      className: 'MediaPlayer',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void mediaPlayerControllerSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final mediaPlayerController = MediaPlayerController(
        rtcEngine: rtcEngine, canvas: const VideoCanvas(uid: 0));
    await mediaPlayerController.initialize();
    
    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await mediaPlayerController.dispose();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'mediaPlayerController',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
    TemplatedTestCase(
      className: 'MediaEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void mediaEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final mediaEngine = rtcEngine.getMediaEngine();
    
    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await mediaEngine.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'mediaEngine',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
    TemplatedTestCase(
      className: 'MediaRecorder',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void mediaRecorderSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final mediaRecorder = rtcEngine.getMediaRecorder();
    
    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await mediaRecorder.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'mediaRecorder',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
    TemplatedTestCase(
      className: 'LocalSpatialAudioEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void localSpatialAudioEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final localSpatialAudioEngine = rtcEngine.getLocalSpatialAudioEngine();
    
    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await localSpatialAudioEngine.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'localSpatialAudioEngine',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
    // paraphrase not support find the base class of class at this time, so we define the base class here
    TemplatedTestCase(
      className: 'BaseSpatialAudioEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void localSpatialAudioEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final localSpatialAudioEngine = rtcEngine.getLocalSpatialAudioEngine();
    
    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await localSpatialAudioEngine.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'localSpatialAudioEngine',
      outputDir: outputDir,
      skipMemberFunctions: [
        'updateSelfPosition',
        'updateSelfPositionEx',
      ],
    ),
    TemplatedTestCase(
      className: 'MusicContentCenter',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:agora_rtc_engine/src/impl/api_caller.dart';

void musicContentCenterSmokeTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisApiEngineIntPtr(debugApiEngineIntPtr);

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
      defaultValue: '<YOUR_APP_ID>');

    RtcEngine rtcEngine = createAgoraRtcEngine();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final musicContentCenter = rtcEngine.getMusicContentCenter();
    
    try {
      {{TEST_CASE_BODY}}
    } catch (e) {
      if (e is! AgoraRtcException) {
        debugPrint('[{{TEST_CASE_NAME}}] error: \${e.toString()}');
        rethrow;
      }

      if (e.code != -4) {
        // Only not supported error supported.
        rethrow;
      }
    }

    await musicContentCenter.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'musicContentCenter',
      outputDir: outputDir,
      skipMemberFunctions: [],
    ),
  ];
  return templatedTestCases;
}

final List<Generator> generators = [
  const RtcEngineSubProcessSmokeTestGenerator(),
  const RtcEngineEventHandlerSomkeTestGenerator(),
  const RtcDeviceManagerSmokeTestGenerator(),
  const RtcChannelEventHandlerSomkeTestGenerator(),
  const MediaRecorderObserverSomkeTestGenerator(),
];

const file.FileSystem fileSystem = LocalFileSystem();

void main(List<String> arguments) {
  final parser = ArgParser();
  parser.addFlag('gen-integration-test');
  parser.addFlag('gen-fake-test');
  parser.addOption('output-dir', mandatory: true);

  final results = parser.parse(arguments);

  final genIntegrationTest = results['gen-integration-test'] ?? false;
  final genFakeTest = results['gen-fake-test'] ?? false;
  final outputDir = results['output-dir']!;

  final srcDir = path.join(
    fileSystem.currentDirectory.absolute.path,
    'lib',
    'src',
  );
  final List<String> includedPaths = <String>[
    path.join(srcDir, 'agora_base.dart'),
    path.join(srcDir, 'agora_log.dart'),
    path.join(srcDir, 'agora_media_base.dart'),
    path.join(srcDir, 'agora_media_player.dart'),
    path.join(srcDir, 'agora_media_player_types.dart'),
    path.join(srcDir, 'agora_media_player_source.dart'),
    path.join(srcDir, 'agora_rhythm_player.dart'),
    path.join(srcDir, 'agora_rtc_engine.dart'),
    path.join(srcDir, 'agora_rtc_engine_ex.dart'),
    path.join(srcDir, 'audio_device_manager.dart'),
    path.join(srcDir, 'agora_media_engine.dart'),
    path.join(srcDir, 'agora_spatial_audio.dart'),
    path.join(srcDir, 'agora_media_recorder.dart'),
    path.join(srcDir, 'agora_music_content_center.dart'),
  ];

  // final outDir = path.join(
  //   fileSystem.currentDirectory.absolute.path,
  //   'integration_test_app',
  //   'integration_test',
  // );

  List<TemplatedTestCase> templatedTestCases = [];
  if (genIntegrationTest) {
    templatedTestCases = _createIntegarationTestCases(outputDir);
  } else if (genFakeTest) {
    templatedTestCases = _createFakeTestCases(outputDir);
  }

  Paraphrase paraphrase = Paraphrase(includedPaths: includedPaths);
  final parseResult = paraphrase.visit();

  Generator? generator;
  if (genIntegrationTest) {
    generator = TemplatedGenerator(templatedTestCases);
  }
  if (genFakeTest) {
    generator = FakeTestTemplatedGenerator(templatedTestCases);
  }

  final file = File('tmp');
  final fileSink = file.openWrite();
  generator?.generate(fileSink, parseResult);

  file.delete(recursive: true);
}
