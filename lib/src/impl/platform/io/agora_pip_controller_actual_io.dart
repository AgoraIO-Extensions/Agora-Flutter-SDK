import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '/src/agora_base.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ext.dart';
import '/src/agora_pip_controller.dart';
import '/src/impl/agora_rtc_engine_impl.dart';

class AgoraPipControllerImpl extends AgoraPipController {
  final RtcEngine _rtcEngine;
  AgoraPipStateChangedObserver? _pipStateChangedObserver;

  AgoraPipControllerImpl(this._rtcEngine) {
    _rtcEngine.registerMethodChannelHandler('pipStateChanged', (call) {
      final jsonMap = Map<String, dynamic>.from(call.arguments as Map);
      final stateIndex = jsonMap['state'] as int;
      final state = AgoraPipState.values[stateIndex];
      final error = jsonMap['error'] as String?;
      _pipStateChangedObserver?.onPipStateChanged(state, error);
      return Future.value();
    });
  }

  @override
  Future<void> dispose() async {
    await pipDispose();
    await _rtcEngine.unregisterMethodChannelHandler('pipStateChanged', null);
  }

  @override
  Future<void> registerPipStateChangedObserver(
    AgoraPipStateChangedObserver observer,
  ) {
    _pipStateChangedObserver = observer;
    return Future.value();
  }

  @override
  Future<void> unregisterPipStateChangedObserver() {
    _pipStateChangedObserver = null;
    return Future.value();
  }

  @override
  Future<bool> pipIsSupported() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>('pipIsSupported');
    return result ?? false;
  }

  @override
  Future<bool> pipIsAutoEnterSupported() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>(
      'pipIsAutoEnterSupported',
    );
    return result ?? false;
  }

  @override
  Future<bool> isPipActivated() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>('pipIsActivated');
    return result ?? false;
  }

  @override
  Future<bool> pipSetup(AgoraPipOptions options) async {
    final apiEngine = _rtcEngine.getApiEngineHandle();
    final result = await _rtcEngine.invokeAgoraMethod<bool>(
      'pipSetup',
      {
        ...options.toDictionary(),
        'apiEngine': apiEngine,
      },
    );

    return result ?? false;
  }

  @override
  Future<bool> pipStart() async {
    final result = await _rtcEngine.invokeAgoraMethod<bool>('pipStart');
    return result ?? false;
  }

  @override
  Future<void> pipStop() async {
    await _rtcEngine.invokeAgoraMethod<void>('pipStop');
  }

  @override
  Future<void> pipDispose() async {
    await _rtcEngine.invokeAgoraMethod<void>('pipDispose');
  }
}
