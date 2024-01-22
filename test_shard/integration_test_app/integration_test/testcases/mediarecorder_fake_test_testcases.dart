import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import '../fake/fake_iris_method_channel.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class MediaRecorderFakeIrisMethodChannel extends FakeIrisMethodChannel {
  MediaRecorderFakeIrisMethodChannel(PlatformBindingsProvider provider)
      : super(provider);

  @override
  Future<CallApiResult> invokeMethod(IrisMethodCall methodCall) async {
    final result = super.invokeMethod(methodCall);
    if (methodCall.funcName == 'RtcEngine_createMediaRecorder_f779617') {
      return CallApiResult(data: {'result': '1000'}, irisReturnCode: 0);
    }

    return result;
  }

  Future<CallApiResult> registerEventHandler(
      ScopedEvent scopedEvent, String params) async {
    IrisMethodCall methodCall =
        IrisMethodCall(scopedEvent.registerName, params);

    return invokeMethod(methodCall);
  }

  Future<CallApiResult> unregisterEventHandler(
      ScopedEvent scopedEvent, String params) async {
    IrisMethodCall methodCall =
        IrisMethodCall(scopedEvent.unregisterName, params);

    return invokeMethod(methodCall);
  }
}

void testCases() {
  bool _isCallOnce(
      MediaRecorderFakeIrisMethodChannel irisMethodChannel, String apiName) {
    final calls = irisMethodChannel.methodCallQueue
        .where((e) => e.funcName == apiName)
        .toList();

    return calls.length == 1;
  }

  group('FakeIrisMethodChannel integration test', () {
    final MediaRecorderFakeIrisMethodChannel irisMethodChannel =
        MediaRecorderFakeIrisMethodChannel(
            IrisApiEngineNativeBindingDelegateProvider());
    final RtcEngine rtcEngine =
        RtcEngineImpl.create(irisMethodChannel: irisMethodChannel);

    setUp(() {
      irisMethodChannel.reset();
    });

    testWidgets(
      'can call startRecording after previous MediaRecorder destroy',
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

        MediaRecorder? recorder = await rtcEngine.createMediaRecorder(
            const RecorderStreamInfo(channelId: 'test', uid: 0));
        recorder?.setMediaRecorderObserver(MediaRecorderObserver(
          onRecorderStateChanged: (channelId, uid, state, error) {},
        ));
        await recorder?.startRecording(
            const MediaRecorderConfiguration(storagePath: 'path'));
        await recorder?.stopRecording();
        await rtcEngine.destroyMediaRecorder(recorder!);

        expect(
            _isCallOnce(
                irisMethodChannel, 'RtcEngine_createMediaRecorder_f779617'),
            isTrue);
        expect(
            _isCallOnce(irisMethodChannel,
                'MediaRecorder_setMediaRecorderObserver_e1f7340'),
            isTrue);
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_startRecording_94480b3'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'MediaRecorder_stopRecording'),
            isTrue);
        // When `RtcEngine.destroyMediaRecorder` is called, will call `MediaRecorderImpl.dispose`
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_unsetMediaRecorderObserver'),
            isTrue);
        expect(
            _isCallOnce(
                irisMethodChannel, 'RtcEngine_destroyMediaRecorder_95cdef5'),
            isTrue);

        irisMethodChannel.reset();

        recorder = await rtcEngine.createMediaRecorder(
            const RecorderStreamInfo(channelId: 'test', uid: 0));
        recorder?.setMediaRecorderObserver(MediaRecorderObserver(
          onRecorderStateChanged: (channelId, uid, state, error) {},
        ));
        await recorder?.startRecording(
            const MediaRecorderConfiguration(storagePath: 'path'));
        await recorder?.stopRecording();
        await rtcEngine.destroyMediaRecorder(recorder!);

        expect(
            _isCallOnce(
                irisMethodChannel, 'RtcEngine_createMediaRecorder_f779617'),
            isTrue);
        expect(
            _isCallOnce(irisMethodChannel,
                'MediaRecorder_setMediaRecorderObserver_e1f7340'),
            isTrue);
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_startRecording_94480b3'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'MediaRecorder_stopRecording'),
            isTrue);
        // When `RtcEngine.destroyMediaRecorder` is called, will call `MediaRecorderImpl.dispose`
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_unsetMediaRecorderObserver'),
            isTrue);
        expect(
            _isCallOnce(
                irisMethodChannel, 'RtcEngine_destroyMediaRecorder_95cdef5'),
            isTrue);
      },
    );
  });
}
