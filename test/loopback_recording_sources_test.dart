import 'dart:convert';
import 'package:agora_rtc_engine/agora_rtc_engine.dart' show AgoraRtcException;

import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/binding/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_media_engine_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class _Channel extends Fake implements IrisMethodChannel {
  _Channel(this.response);
  CallApiResult response;
  IrisMethodCall? lastCall;

  @override
  Future<CallApiResult> invokeMethod(IrisMethodCall call) async {
    lastCall = call;
    return response;
  }
}

void main() {
  test('leaves platform-dependent screen audio defaults to the SDK', () {
    expect(const ScreenAudioParameters().toJson(), isEmpty);
  });

  test('decodes loopback source JSON into typed models and passes flags',
      () async {
    final channel =
        _Channel(CallApiResult(irisReturnCode: 0, data: jsonDecode('''
      {"result":[
        {"appName":"Music","windowTitle":"Player","processIds":[12,34],"processCount":2},
        {"appName":"Browser","processIds":[56],"processCount":1}
      ]}
    ''')));
    final sources = await RtcEngineImpl(channel).getLoopbackRecordingSources(
        const LoopbackRecordingSourceOptions(flags: 3));
    expect(sources.map((source) => source.appName), ['Music', 'Browser']);
    expect(sources.first.windowTitle, 'Player');
    expect(sources.first.processIds, [12, 34]);
    expect(sources.first.processCount, 2);
    expect(channel.lastCall!.funcName,
        'RtcEngine_getLoopbackRecordingSources_89105d0');
    expect(jsonDecode(channel.lastCall!.params), {
      'options': {'flags': 3}
    });
  });

  test('returns an empty typed list for empty enumeration', () async {
    final channel = _Channel(
        CallApiResult(irisReturnCode: 0, data: jsonDecode('{"result":[]}')));
    expect(
        await RtcEngineImpl(channel).getLoopbackRecordingSources(
            const LoopbackRecordingSourceOptions(flags: 1)),
        isEmpty);
  });

  test('preserves Iris errors before decoding results', () async {
    final channel = _Channel(CallApiResult(irisReturnCode: -4, data: const {}));
    await expectLater(
        RtcEngineImpl(channel).getLoopbackRecordingSources(
            const LoopbackRecordingSourceOptions(flags: 2)),
        throwsA(isA<AgoraRtcException>().having((e) => e.code, 'code', -4)));
  });

  test('passes loopback exclusion arrays and counts without flattening',
      () async {
    final channel =
        _Channel(CallApiResult(irisReturnCode: 0, data: const {'result': 7}));
    final id = await MediaEngineImpl(channel).createLoopbackAudioTrack(
        const LoopbackAudioTrackConfig(
            excludedAppNames: ['Music', 'Browser'],
            excludedAppCount: 2,
            excludedProcessIds: [12, 34],
            excludedProcessCount: 2));
    expect(id, 7);
    final config = jsonDecode(channel.lastCall!.params)['config'];
    expect(config['excludedAppNames'], ['Music', 'Browser']);
    expect(config['excludedAppCount'], 2);
    expect(config['excludedProcessIds'], [12, 34]);
    expect(config['excludedProcessCount'], 2);
  });
}
