import 'package:flutter/foundation.dart';

import '/src/agora_rtc_engine.dart';
import '/src/agora_pip_controller.dart';

class AgoraPipControllerImpl extends AgoraPipController {
  AgoraPipControllerImpl(RtcEngine rtcEngine) {
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() {
    throw UnimplementedError();
  }

  @override
  Future<void> registerPipStateChangedObserver(
    AgoraPipStateChangedObserver observer,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> unregisterPipStateChangedObserver() {
    throw UnimplementedError();
  }

  @override
  Future<bool> pipIsSupported() {
    throw UnimplementedError();
  }

  @override
  Future<bool> pipIsAutoEnterSupported() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isPipActivated() {
    throw UnimplementedError();
  }

  @override
  Future<bool> pipSetup(AgoraPipOptions options) {
    throw UnimplementedError();
  }

  @override
  Future<bool> pipStart() {
    throw UnimplementedError();
  }

  @override
  Future<void> pipStop() {
    throw UnimplementedError();
  }

  @override
  Future<void> pipDispose() {
    throw UnimplementedError();
  }
}
