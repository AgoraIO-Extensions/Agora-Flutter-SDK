import 'dart:convert';

import 'package:agora_rtc_engine/src/agora_h265_transcoder.dart';
import 'package:agora_rtc_engine/src/binding/agora_h265_transcoder_impl.dart'
    as impl_binding;
import 'package:agora_rtc_engine/src/binding/agora_h265_transcoder_event_impl.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

class H265TranscoderImplOverride extends impl_binding.H265TranscoderImpl {
  H265TranscoderImplOverride(IrisMethodChannel irisMethodChannel)
      : super(irisMethodChannel);

  final _observerScopedKey = const TypedScopedKey(H265TranscoderImplOverride);

  @override
  void registerTranscoderObserver(H265TranscoderObserver observer) async {
    final observerWrapper = H265TranscoderObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.registerEventHandler(
        ScopedEvent(
            scopedKey: _observerScopedKey,
            registerName: 'H265Transcoder_registerTranscoderObserver_e1ee996',
            unregisterName:
                'H265Transcoder_unregisterTranscoderObserver_e1ee996',
            handler: observerWrapper),
        jsonEncode(param));
  }

  @override
  void unregisterTranscoderObserver(H265TranscoderObserver observer) async {
    final observerWrapper = H265TranscoderObserverWrapper(observer);
    final param = createParams({});

    await irisMethodChannel.unregisterEventHandler(
        ScopedEvent(
            scopedKey: _observerScopedKey,
            registerName: 'H265Transcoder_registerTranscoderObserver_e1ee996',
            unregisterName:
                'H265Transcoder_unregisterTranscoderObserver_e1ee996',
            handler: observerWrapper),
        jsonEncode(param));
  }
}
