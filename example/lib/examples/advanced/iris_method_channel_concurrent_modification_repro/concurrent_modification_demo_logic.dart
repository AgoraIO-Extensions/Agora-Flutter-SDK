import 'dart:typed_data';

import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:iris_method_channel/iris_method_channel.dart';

class ConcurrentModificationDemoResult {
  const ConcurrentModificationDemoResult({
    required this.handled,
    required this.errors,
  });

  final bool handled;
  final List<Object> errors;

  bool get hasConcurrentModificationError =>
      errors.whereType<ConcurrentModificationError>().isNotEmpty;
}

class _SelfRemovingHandler extends EventLoopEventHandler {
  _SelfRemovingHandler(this.holder, this.onHandled);

  final EventHandlerHolder holder;
  final VoidCallback onHandled;

  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    holder.removeEventHandler(this);
    onHandled();
    return true;
  }
}

EventHandlerHolder _buildHolder({
  required VoidCallback onHandled,
}) {
  final holder = EventHandlerHolder(
    key: const EventHandlerHolderKey(
      registerName: 'register',
      unregisterName: 'unregister',
    ),
  );
  holder.addEventHandler(_SelfRemovingHandler(holder, onHandled));
  return holder;
}

ConcurrentModificationDemoResult runLegacyConcurrentModificationDemo() {
  final errors = <Object>[];
  var handled = false;
  final holder = _buildHolder(
    onHandled: () {
      handled = true;
    },
  );

  try {
    for (final handler in holder.getEventHandlers()) {
      handler.handleEvent('testEvent', '{}', const []);
    }
  } catch (error) {
    errors.add(error);
  }

  return ConcurrentModificationDemoResult(
    handled: handled,
    errors: errors,
  );
}

ConcurrentModificationDemoResult runSnapshotConcurrentModificationDemo() {
  final errors = <Object>[];
  var handled = false;
  final holder = _buildHolder(
    onHandled: () {
      handled = true;
    },
  );

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

  return ConcurrentModificationDemoResult(
    handled: handled,
    errors: errors,
  );
}
