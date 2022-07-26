import 'dart:io';

import 'package:paraphrase/paraphrase.dart';
import 'package:testcase_gen/default_generator.dart';
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

final List<Generator> generators = [
  const RtcEngineSubProcessSmokeTestGenerator(),
  const RtcEngineEventHandlerSomkeTestGenerator(),
  const RtcDeviceManagerSmokeTestGenerator(),
  const RtcChannelEventHandlerSomkeTestGenerator(),
  const MediaRecorderObserverSomkeTestGenerator(),
];

const file.FileSystem fileSystem = LocalFileSystem();

void main(List<String> arguments) {
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
  ];

  final outDir = path.join(
    fileSystem.currentDirectory.absolute.path,
    'integration_test_app',
    'integration_test',
  );

  List<TemplatedTestCase> templatedTestCases = [
    TemplatedTestCase(
      className: 'RtcEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void rtcEngineSmokeTestCases() {
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
      methodInvokeObjectName: 'rtcEngine',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [
        'release',
        'registerAudioEncodedFrameObserver',
        'registerAudioSpectrumObserver',
        'unregisterAudioSpectrumObserver',
        'registerEventHandler',
        'unregisterEventHandler',
        'registerPacketObserver',
        'registerMediaMetadataObserver',
        'unregisterMediaMetadataObserver',
        'destroyMediaPlayer',
        'setupRemoteVideo',
        'setupLocalVideo',
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
import 'package:integration_test_app/main.dart' as app;

void rtcEngineExSmokeTestCases() {
  {{TEST_CASES_CONTENT}}
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

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
      }
      expect(e is AgoraRtcException, true);
      debugPrint(
        '[{{TEST_CASE_NAME}}] errorcode: \${(e as AgoraRtcException).code}');
    }

    await rtcEngineEx.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'rtcEngineEx',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [],
    ),
    TemplatedTestCase(
      className: 'AudioDeviceManager',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void audioDeviceManagerSmokeTestCases() {
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

    final audioDeviceManager = rtcEngine.getAudioDeviceManager();

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

    audioDeviceManager.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'audioDeviceManager',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [
        'release',
      ],
    ),
    TemplatedTestCase(
      className: 'VideoDeviceManager',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void videoDeviceManagerSmokeTestCases() {
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

    final videoDeviceManager = rtcEngine.getVideoDeviceManager();

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

    videoDeviceManager.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'videoDeviceManager',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [
        'release',
      ],
    ),
    TemplatedTestCase(
      className: 'MediaPlayer',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void mediaPlayerControllerSmokeTestCases() {
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

    final mediaPlayerController = MediaPlayerController(
        rtcEngine: rtcEngine, canvas: const VideoCanvas(uid: 0));
    await mediaPlayerController.initialize();
    
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

    await mediaPlayerController.dispose();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'mediaPlayerController',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [
        'release',
        'setView',
      ],
    ),
    TemplatedTestCase(
      className: 'MediaEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void mediaEngineSmokeTestCases() {
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

    final mediaEngine = rtcEngine.getMediaEngine();
    
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

    await mediaEngine.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'mediaEngine',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [
        'release',
      ],
    ),
    TemplatedTestCase(
      className: 'MediaRecorder',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void mediaRecorderSmokeTestCases() {
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

    final mediaRecorder = rtcEngine.getMediaRecorder();
    
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

    await mediaRecorder.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'mediaRecorder',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [
        'release',
      ],
    ),
        TemplatedTestCase(
      className: 'LocalSpatialAudioEngine',
      testCaseFileTemplate: '''
$defaultHeader

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void localSpatialAudioEngineSmokeTestCases() {
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

    final localSpatialAudioEngine = rtcEngine.getLocalSpatialAudioEngine();
    
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

    await localSpatialAudioEngine.release();
    await rtcEngine.release();
  },
//  skip: {{TEST_CASE_SKIP}},
);
''',
      methodInvokeObjectName: 'localSpatialAudioEngine',
      outputDir: path.join(outDir, 'generated'),
      skipMemberFunctions: [
        'release',
      ],
    ),
  ];

  Paraphrase paraphrase = Paraphrase(includedPaths: includedPaths);
  final parseResult = paraphrase.visit();

  TemplatedGenerator generator = TemplatedGenerator(templatedTestCases);
  final file = File('tmp');
  final fileSink = file.openWrite();
  generator.generate(fileSink, parseResult);

  file.delete(recursive: true);
}
