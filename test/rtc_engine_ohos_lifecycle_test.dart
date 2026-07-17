import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart'
    as implementation;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class _UnusedBindingsProvider extends PlatformBindingsProvider {
  @override
  PlatformBindingsDelegateInterface provideNativeBindingDelegate() {
    throw UnimplementedError();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const engineChannel = MethodChannel('agora_rtc_ng');
  late int ohosInitCalls;

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.ohos;
    ohosInitCalls = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(engineChannel, (call) async {
      if (call.method == 'ohosInit') {
        ohosInitCalls++;
        throw PlatformException(code: 'ohos_init_failed');
      }
      return null;
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(engineChannel, null);
  });

  test('failed OHOS initialization can be retried', () async {
    final engine = implementation.RtcEngineImpl.createForTesting(
      irisMethodChannel: IrisMethodChannel(_UnusedBindingsProvider()),
    );
    const context = RtcEngineContext(appId: 'test-app-id');

    await expectLater(
      engine.initialize(context),
      throwsA(isA<PlatformException>()),
    );
    await expectLater(
      engine.initialize(context),
      throwsA(isA<PlatformException>()),
    );

    expect(ohosInitCalls, 2);
  });
}
