import 'package:testcase_gen/default_generator.dart';
import 'package:testcase_gen/templated_generator.dart';

List<TemplatedTestCase> createIntegarationTestCases(String outputDir) {
  List<TemplatedTestCase> templatedTestCases = [
    MethoCallTemplatedTestCase(
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
      outputFileSuffixName: 'smoke_test',
    ),
  ];
  return templatedTestCases;
}

List<TemplatedTestCase> createFakeTestCases(String outputDir) {
  List<TemplatedTestCase> templatedTestCases = [
    MethoCallTemplatedTestCase(
      className: 'RtcEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void rtcEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    MethoCallTemplatedTestCase(
      className: 'RtcEngineEx',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void rtcEngineExSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    MethoCallTemplatedTestCase(
      className: 'AudioDeviceManager',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void audioDeviceManagerSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    MethoCallTemplatedTestCase(
      className: 'VideoDeviceManager',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void videoDeviceManagerSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    MethoCallTemplatedTestCase(
      className: 'MediaPlayer',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void mediaPlayerControllerSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    MethoCallTemplatedTestCase(
      className: 'MediaEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void mediaEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    MethoCallTemplatedTestCase(
      className: 'MediaRecorder',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void mediaRecorderSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    MethoCallTemplatedTestCase(
      className: 'LocalSpatialAudioEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void localSpatialAudioEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
    // paraphrase not support find the base class of class at this time, so we define the base class here
    MethoCallTemplatedTestCase(
      className: 'BaseSpatialAudioEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void localSpatialAudioEngineSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
      skipMemberFunctions: [
        'updateSelfPosition',
        'updateSelfPositionEx',
      ],
    ),
    MethoCallTemplatedTestCase(
      className: 'MusicContentCenter',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:fake_test_app/main.dart' as app;
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void musicContentCenterSmokeTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    final irisTester = IrisTester();
    final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
    setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      outputFileSuffixName: 'fake_test',
    ),
  ];
  return templatedTestCases;
}
