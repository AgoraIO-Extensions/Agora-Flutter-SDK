import 'dart:typed_data';

import 'package:agora_rtc_engine/src/impl/api_caller.dart';
import 'package:iris_event/iris_event.dart';
import 'package:meta/meta.dart';

class EventLoopEventHandlerKey {
  const EventLoopEventHandlerKey(this.type);
  final Type type;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is EventLoopEventHandlerKey && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;
}

abstract class EventLoopEventHandler {
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    return handleEventInternal(eventName, eventData, buffers);
  }

  @protected
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers);
}

class EventLoop implements IrisEventHandler {
  final Map<EventLoopEventHandlerKey, Set<EventLoopEventHandler>>
      _eventHandlers = {};

  void run() {
    apiCaller.addEventHandler(this);
  }

  void terminate() {
    _eventHandlers.clear();
    apiCaller.removeEventHandler(this);
  }

  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    bool handled = false;
    for (final es in _eventHandlers.values) {
      for (final e in es) {
        if (e.handleEvent(event, data, buffers)) {
          handled = true;
        }
      }

      if (handled) {
        break;
      }
    }
  }

  void addEventHandler(
      EventLoopEventHandlerKey key, EventLoopEventHandler eventHandler) {
    final events =
        _eventHandlers.putIfAbsent(key, () => <EventLoopEventHandler>{});
    events.add(eventHandler);
  }

  void addEventHandlerIfAbsent(
      EventLoopEventHandlerKey key, EventLoopEventHandler eventHandler) {
    final events =
        _eventHandlers.putIfAbsent(key, () => <EventLoopEventHandler>{});
    if (!events.contains(eventHandler)) {
      events.add(eventHandler);
    }
  }

  void removeEventHandler(
      EventLoopEventHandlerKey key, EventLoopEventHandler eventHandler) {
    final events = _eventHandlers[key];
    events?.remove(eventHandler);
  }

  void removeEventHandlers(EventLoopEventHandlerKey key) {
    _eventHandlers.remove(key);
  }

  bool isEventHandlerEmpty(EventLoopEventHandlerKey key) {
    return _eventHandlers[key]?.isEmpty == true;
  }
}
