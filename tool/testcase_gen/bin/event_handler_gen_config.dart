import 'package:testcase_gen/default_generator.dart';
import 'package:testcase_gen/templated_generator.dart';

List<TemplatedTestCase> createEventHandlerTestCases(String outputDir) {
  List<TemplatedTestCase> templatedTestCases = [
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'RtcEngine',
      className: 'RtcEngineEventHandler',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'rtcEngine',
      outputDir: outputDir,
      eventPrefixOverride: 'RtcEngineEventHandlerEx',
      registerFunctionName: 'registerEventHandler',
      unregisterFunctionName: 'unregisterEventHandler',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'RtcEngine',
      className: 'AudioEncodedFrameObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'rtcEngine',
      outputDir: outputDir,
      registerFunctionName: 'registerAudioEncodedFrameObserver',
      unregisterFunctionName: 'unregisterAudioEncodedFrameObserver',
      isUpperFirstCaseOfEventName: true,
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'RtcEngine',
      className: 'AudioSpectrumObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'rtcEngine',
      outputDir: outputDir,
      registerFunctionName: 'registerAudioSpectrumObserver',
      unregisterFunctionName: 'unregisterAudioSpectrumObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'RtcEngine',
      className: 'MetadataObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'rtcEngine',
      outputDir: outputDir,
      registerFunctionName: 'registerMediaMetadataObserver',
      unregisterFunctionName: 'unregisterMediaMetadataObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaEngine',
      className: 'AudioFrameObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      final mediaEngine = rtcEngine.getMediaEngine();

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaEngine',
      outputDir: outputDir,
      registerFunctionName: 'registerAudioFrameObserver',
      unregisterFunctionName: 'unregisterAudioFrameObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaEngine',
      className: 'VideoFrameObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      final mediaEngine = rtcEngine.getMediaEngine();

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaEngine',
      outputDir: outputDir,
      registerFunctionName: 'registerVideoFrameObserver',
      unregisterFunctionName: 'unregisterVideoFrameObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaEngine',
      className: 'VideoEncodedFrameObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      final mediaEngine = rtcEngine.getMediaEngine();

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaEngine',
      outputDir: outputDir,
      registerFunctionName: 'registerVideoEncodedFrameObserver',
      unregisterFunctionName: 'unregisterVideoEncodedFrameObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaPlayer',
      className: 'MediaPlayerSourceObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      final mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas());
      await mediaPlayerController.initialize();

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaPlayerController',
      outputDir: outputDir,
      registerFunctionName: 'registerPlayerSourceObserver',
      unregisterFunctionName: 'unregisterPlayerSourceObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaPlayer',
      className: 'AudioSpectrumObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      MediaPlayerController mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas());
      await mediaPlayerController.initialize();

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaPlayerController',
      outputDir: outputDir,
      registerFunctionName: 'registerMediaPlayerAudioSpectrumObserver',
      unregisterFunctionName: 'unregisterMediaPlayerAudioSpectrumObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaPlayer',
      className: 'MediaPlayerAudioFrameObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      MediaPlayerController mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas());
      await mediaPlayerController.initialize();

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaPlayerController',
      outputDir: outputDir,
      registerFunctionName: 'registerAudioFrameObserver',
      unregisterFunctionName: 'unregisterAudioFrameObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaPlayer',
      className: 'MediaPlayerVideoFrameObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      MediaPlayerController mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas());
      await mediaPlayerController.initialize();

      {{TEST_CASE_BODY}}

      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaPlayerController',
      outputDir: outputDir,
      registerFunctionName: 'registerVideoFrameObserver',
      unregisterFunctionName: 'unregisterVideoFrameObserver',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MediaRecorder',
      className: 'MediaRecorderObserver',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaRecorder = rtcEngine.getMediaRecorder();

      {{TEST_CASE_BODY}}

      await mediaRecorder.release();
      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'mediaRecorder',
      outputDir: outputDir,
      registerFunctionName: 'setMediaRecorderObserver',
      unregisterFunctionName: '',
    ),
    EventHandlerTemplatedTestCase(
      callerObjClassName: 'MusicContentCenter',
      className: 'MusicContentCenterEventHandler',
      testCaseFileTemplate: '''
$defaultHeader

import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

void generatedTestCases() {
  {{TEST_CASES_CONTENT}} 
}
''',
      testCaseTemplate: '''
testWidgets('{{TEST_CASE_NAME}}', (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.getDebugApiEngineNativeHandle();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final musicContentCenter = rtcEngine.getMusicContentCenter();
      const musicContentCenterConfiguration = MusicContentCenterConfiguration(
          appId: 'app_id', token: 'token', mccUid: 10);
      await musicContentCenter.initialize(musicContentCenterConfiguration);

      {{TEST_CASE_BODY}}

      await musicContentCenter.release();
      await rtcEngine.release();
  },
  timeout: const Timeout(Duration(minutes: 1)),
);
''',
      callerObjName: 'musicContentCenter',
      outputDir: outputDir,
      registerFunctionName: 'registerEventHandler',
      unregisterFunctionName: 'unregisterEventHandler',
    ),
  ];
  return templatedTestCases;
}
