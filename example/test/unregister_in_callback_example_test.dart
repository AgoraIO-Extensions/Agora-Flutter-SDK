import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:agora_rtc_engine_example/examples/advanced/index.dart';
import 'package:agora_rtc_engine_example/examples/advanced/unregister_in_callback/unregister_in_callback.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

import '../../test_shard/integration_test_app/integration_test/fake/fake_iris_method_channel.dart';

class _CallbackTestIrisMethodChannel extends FakeIrisMethodChannel {
  _CallbackTestIrisMethodChannel(super.provider);

  @override
  Future<CallApiResult> registerEventHandler(
      ScopedEvent scopedEvent, String params) async {
    final DisposableScopedObjects subScopedObjects =
        scopedEventHandlers.putIfAbsent<DisposableScopedObjects>(
      scopedEvent.scopedKey,
      () => DisposableScopedObjects(),
    );
    final eventKey = EventHandlerHolderKey(
      registerName: scopedEvent.registerName,
      unregisterName: scopedEvent.unregisterName,
    );
    final EventHandlerHolder holder =
        subScopedObjects.putIfAbsent<EventHandlerHolder>(
      eventKey,
      () => EventHandlerHolder(key: eventKey),
    );
    holder.addEventHandler(scopedEvent.handler);
    methodCallQueue.add(IrisMethodCall(scopedEvent.registerName, params));
    return CallApiResult(data: const {'result': 0}, irisReturnCode: 0);
  }

  @override
  Future<CallApiResult> unregisterEventHandler(
      ScopedEvent scopedEvent, String params) async {
    final DisposableScopedObjects? subScopedObjects =
        scopedEventHandlers.get<DisposableScopedObjects>(scopedEvent.scopedKey);
    final eventKey = EventHandlerHolderKey(
      registerName: scopedEvent.registerName,
      unregisterName: scopedEvent.unregisterName,
    );
    final holder = subScopedObjects?.get<EventHandlerHolder>(eventKey);
    await holder?.removeEventHandler(scopedEvent.handler);
    methodCallQueue.add(IrisMethodCall(scopedEvent.unregisterName, params));
    return CallApiResult(data: const {'result': 0}, irisReturnCode: 0);
  }
}

class _SelfRemovingEventLoopHandler extends EventLoopEventHandler {
  _SelfRemovingEventLoopHandler(this.holder, this.onHandled);

  final EventHandlerHolder holder;
  final VoidCallback onHandled;

  @override
  bool handleEventInternal(String eventName, String eventData, List buffers) {
    holder.removeEventHandler(this);
    onHandled();
    return true;
  }
}

List<Object> _dispatchHandlersWithSnapshot(EventHandlerHolder holder) {
  final errors = <Object>[];

  try {
    final handlersSnapshot = holder.getEventHandlers();
    for (final handler in handlersSnapshot.toList()) {
      if (!holder.getEventHandlers().contains(handler)) {
        continue;
      }
      handler.handleEvent('testEvent', '{}', const []);
    }
  } catch (error) {
    errors.add(error);
  }

  return errors;
}

void main() {
  test('shows unregister in callback example entry', () {
    expect(
      advanced.any((item) => item['name'] == 'UnregisterInCallback'),
      isTrue,
    );
  });

  test('self-unregistering example handler calls unregister inside callback',
      () async {
    final irisMethodChannel = _CallbackTestIrisMethodChannel(
      IrisApiEngineNativeBindingDelegateProvider(),
    );
    final engine = RtcEngineImpl.createForTesting(
      irisMethodChannel: irisMethodChannel,
    );
    var unregistered = false;
    var lastRemoteUid = -1;

    final handler = buildSelfUnregisteringEventHandler(
      engine: engine,
      onUnregistered: () {
        unregistered = true;
      },
      onRemoteJoined: (remoteUid) {
        lastRemoteUid = remoteUid;
      },
    );

    engine.registerEventHandler(handler);
    await Future<void>.delayed(Duration.zero);
    expect(
      irisMethodChannel.methodCallQueue
          .where((call) =>
              call.funcName == 'RtcEngine_registerEventHandler_5fc0465')
          .length,
      1,
    );
    expect(irisMethodChannel.scopedEventHandlers.values.length, 1);

    handler.onUserJoined!(
      const RtcConnection(channelId: 'test_channel'),
      42,
      0,
    );
    await Future<void>.delayed(Duration.zero);

    expect(unregistered, isTrue);
    expect(lastRemoteUid, 42);
    expect(
      irisMethodChannel.methodCallQueue
          .where((call) =>
              call.funcName == 'RtcEngine_unregisterEventHandler_5fc0465')
          .length,
      1,
    );
  });

  test(
      'snapshot dispatch tolerates handler self-removal without concurrent modification',
      () {
    final holder = EventHandlerHolder(
      key: const EventHandlerHolderKey(
        registerName: 'register',
        unregisterName: 'unregister',
      ),
    );
    var handled = false;
    holder.addEventHandler(_SelfRemovingEventLoopHandler(
      holder,
      () {
        handled = true;
      },
    ));

    final errors = _dispatchHandlersWithSnapshot(holder);

    expect(errors.whereType<ConcurrentModificationError>(), isEmpty);
    expect(handled, isTrue);
    expect(holder.getEventHandlers(), isEmpty);
  });
}
