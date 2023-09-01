import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import '../fake/fake_iris_method_channel.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class MediaRecorderFakeIrisMethodChannel extends FakeIrisMethodChannel {
  MediaRecorderFakeIrisMethodChannel(PlatformBindingsProvider provider)
      : super(provider);

  @override
  Future<CallApiResult> invokeMethod(IrisMethodCall methodCall) async {
    final result = super.invokeMethod(methodCall);
    if (methodCall.funcName == 'RtcEngine_createMediaRecorder') {
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

        await rtcEngine.initialize(RtcEngineContext(
          appId: engineAppId,
          areaCode: AreaCode.areaCodeGlob.value(),
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

        expect(_isCallOnce(irisMethodChannel, 'RtcEngine_createMediaRecorder'),
            isTrue);
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_setMediaRecorderObserver'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'MediaRecorder_startRecording'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'MediaRecorder_stopRecording'),
            isTrue);
        // When `RtcEngine.destroyMediaRecorder` is called, will call `MediaRecorderImpl.dispose`
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_unsetMediaRecorderObserver'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'RtcEngine_destroyMediaRecorder'),
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

        expect(_isCallOnce(irisMethodChannel, 'RtcEngine_createMediaRecorder'),
            isTrue);
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_setMediaRecorderObserver'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'MediaRecorder_startRecording'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'MediaRecorder_stopRecording'),
            isTrue);
        // When `RtcEngine.destroyMediaRecorder` is called, will call `MediaRecorderImpl.dispose`
        expect(
            _isCallOnce(
                irisMethodChannel, 'MediaRecorder_unsetMediaRecorderObserver'),
            isTrue);
        expect(_isCallOnce(irisMethodChannel, 'RtcEngine_destroyMediaRecorder'),
            isTrue);
      },
    );
  });
}
