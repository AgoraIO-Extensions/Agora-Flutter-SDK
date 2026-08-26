import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/platform/platform_bindings_provider.dart';
import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:flutter/services.dart' show MethodChannel;
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class _FakeIrisMethodChannel extends IrisMethodChannel {
  _FakeIrisMethodChannel({
    this.initializeFailuresRemaining = 0,
    this.disposeFailuresRemaining = 0,
    this.rtcEngineInitializeFailuresRemaining = 0,
  }) : super(createPlatformBindingsProvider());

  int initializeFailuresRemaining;
  int disposeFailuresRemaining;
  int rtcEngineInitializeFailuresRemaining;
  int initializeCalls = 0;
  int disposeCalls = 0;
  bool initialized = false;

  @override
  Future<InitilizationResult?> initilize(
      List<InitilizationArgProvider> args) async {
    initializeCalls++;
    if (initializeFailuresRemaining > 0) {
      initializeFailuresRemaining--;
      throw StateError('initialize failed');
    }
    initialized = true;
    return null;
  }

  @override
  Future<CallApiResult> invokeMethod(IrisMethodCall methodCall) async {
    if (methodCall.funcName == 'RtcEngine_initialize_0320339' &&
        rtcEngineInitializeFailuresRemaining > 0) {
      rtcEngineInitializeFailuresRemaining--;
      return CallApiResult(irisReturnCode: -1, data: const {});
    }
    return CallApiResult(
      irisReturnCode: 0,
      data: {
        'result': 0,
        if (methodCall.funcName == 'CreateIrisRtcRendering')
          'irisRtcRenderingHandle': 0,
      },
    );
  }

  @override
  Future<void> unregisterEventHandlers(TypedScopedKey scopedKey) async {}

  @override
  int getApiEngineHandle() => initialized ? 1 : 0;

  @override
  VoidCallback addHotRestartListener(HotRestartListener listener) => () {};

  @override
  void removeHotRestartListener(HotRestartListener listener) {}

  @override
  Future<void> dispose() async {
    disposeCalls++;
    initialized = false;
    if (disposeFailuresRemaining > 0) {
      disposeFailuresRemaining--;
      throw StateError('dispose failed');
    }
  }
}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  const engineMethodChannel = MethodChannel('agora_rtc_ng');

  const context = RtcEngineContext(appId: 'test-app-id');

  setUp(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      engineMethodChannel,
      (call) async => true,
    );
  });

  tearDown(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      engineMethodChannel,
      null,
    );
  });

  test('initialize can retry after Iris initialization fails', () async {
    final irisMethodChannel =
        _FakeIrisMethodChannel(initializeFailuresRemaining: 1);
    final engine = RtcEngineImpl.createForTesting(
      irisMethodChannel: irisMethodChannel,
    ) as RtcEngineImpl;

    await expectLater(engine.initialize(context), throwsStateError);
    await engine.initialize(context);

    expect(irisMethodChannel.initializeCalls, 2);
    expect(engine.isInitialzed, isTrue);
    await engine.release();
  });

  test('concurrent initialize retries when the first attempt fails', () async {
    final irisMethodChannel =
        _FakeIrisMethodChannel(initializeFailuresRemaining: 1);
    final engine = RtcEngineImpl.createForTesting(
      irisMethodChannel: irisMethodChannel,
    ) as RtcEngineImpl;

    final firstInitialize = engine.initialize(context);
    final secondInitialize = engine.initialize(context);

    await expectLater(firstInitialize, throwsStateError);
    await secondInitialize;

    expect(irisMethodChannel.initializeCalls, 2);
    expect(engine.isInitialzed, isTrue);
    await engine.release();
  });

  test('initialize can proceed after Iris disposal reports an error', () async {
    final irisMethodChannel =
        _FakeIrisMethodChannel(disposeFailuresRemaining: 1);
    final engine = RtcEngineImpl.createForTesting(
      irisMethodChannel: irisMethodChannel,
    ) as RtcEngineImpl;

    await engine.initialize(context);
    await expectLater(engine.release(), throwsStateError);
    await engine.initialize(context).timeout(const Duration(seconds: 1));

    expect(irisMethodChannel.initializeCalls, 2);
    expect(engine.isInitialzed, isTrue);
    await engine.release();
  });

  test('native initialization failure rolls back the Iris owner', () async {
    final irisMethodChannel = _FakeIrisMethodChannel(
      rtcEngineInitializeFailuresRemaining: 1,
    );
    final engine = RtcEngineImpl.createForTesting(
      irisMethodChannel: irisMethodChannel,
    ) as RtcEngineImpl;

    await expectLater(
      engine.initialize(context),
      throwsA(isA<AgoraRtcException>()),
    );

    expect(irisMethodChannel.disposeCalls, 1);
    expect(irisMethodChannel.initialized, isFalse);

    await engine.initialize(context);
    expect(irisMethodChannel.initializeCalls, 2);
    await engine.release();
  });
}
