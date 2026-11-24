// NMS-32110: RtcEngineExt.getParameters -> iris RtcEngine_getParameters.
// Runs on the host VM with a fake IrisMethodChannel; no native library is loaded.
import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class _FakeChannel extends IrisMethodChannel {
  _FakeChannel() : super(IrisApiEngineNativeBindingDelegateProvider());

  final List<IrisMethodCall> calls = [];
  CallApiResult Function(IrisMethodCall call)? reply;

  @override
  Future<CallApiResult> invokeMethod(IrisMethodCall methodCall) async {
    calls.add(methodCall);
    final r = reply;
    if (r == null) {
      return CallApiResult(data: const {'result': 0}, irisReturnCode: 0);
    }
    return r(methodCall);
  }
}

void main() {
  late _FakeChannel channel;
  late RtcEngine engine;

  setUp(() {
    channel = _FakeChannel();
    engine = RtcEngineImpl.createForTesting(irisMethodChannel: channel);
  });

  void replyWith(Map<String, dynamic> data, {int irisReturnCode = 0}) {
    channel.reply =
        (_) => CallApiResult(data: data, irisReturnCode: irisReturnCode);
  }

  Future<int> errorCodeOf(Future<dynamic> f) async {
    try {
      await f;
    } on AgoraRtcException catch (e) {
      return e.code;
    }
    fail('expected AgoraRtcException');
  }

  test('sends key and type to RtcEngine_getParameters', () async {
    replyWith({'result': 0, 'value': true});
    expect(await engine.getParameters('rtc.video.enable_video_element', 'bool'),
        true);
    expect(channel.calls.length, 1);
    expect(channel.calls.single.funcName, 'RtcEngine_getParameters');
    expect(jsonDecode(channel.calls.single.params),
        {'key': 'rtc.video.enable_video_element', 'type': 'bool'});
  });

  test('passes args for array', () async {
    replyWith({
      'result': 0,
      'value': [1, 2]
    });
    expect(await engine.getParameters('k', 'array', args: 'a1'), [1, 2]);
    expect(jsonDecode(channel.calls.single.params),
        {'key': 'k', 'type': 'array', 'args': 'a1'});
  });

  final values = <String, dynamic>{
    'int': -7,
    'uint': 4000000000,
    'number': 1.5,
    'string': 'hello',
    'object': {'mode': 2, 'enabled': false},
  };
  values.forEach((type, value) {
    test('returns $type value', () async {
      replyWith({'result': 0, 'value': value});
      expect(await engine.getParameters('k', type), value);
    });
  });

  test('empty string and false are values, not errors', () async {
    replyWith({'result': 0, 'value': ''});
    expect(await engine.getParameters('k', 'string'), '');
    replyWith({'result': 0, 'value': false});
    expect(await engine.getParameters('k', 'bool'), false);
  });

  test('native error is thrown with its code', () async {
    replyWith({'result': -7});
    expect(await errorCodeOf(engine.getParameters('never_set', 'bool')), -7);
  });

  test('iris without the API: iris error code', () async {
    replyWith({}, irisReturnCode: -1009);
    expect(await errorCodeOf(engine.getParameters('k', 'bool')), -1009);
  });

  test('result 0 without value is a failure', () async {
    replyWith({'result': 0});
    expect(await errorCodeOf(engine.getParameters('k', 'bool')),
        -ErrorCodeType.errFailed.value());
  });

  test('invalid key or type is rejected before calling iris', () async {
    expect(await errorCodeOf(engine.getParameters('', 'bool')),
        -ErrorCodeType.errInvalidArgument.value());
    expect(await errorCodeOf(engine.getParameters('k', 'long')),
        -ErrorCodeType.errInvalidArgument.value());
    expect(channel.calls, isEmpty);
  });
}
