import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

class EventHandlerTester {
  final Completer<bool> _isEventCalledCompleter = Completer();
  void markEventCalled() {
    _isEventCalledCompleter.complete(true);
  }
}

typedef EventHandlerTesterCallback = Future<void> Function(
  WidgetTester widgetTester,
  EventHandlerTester eventHandlerTester,
);

@isTest
void testEventCall(String description, EventHandlerTesterCallback callback) {
  testWidgets(
    description,
    (WidgetTester tester) async {
      final eventHandlerTester = EventHandlerTester();
      await callback(tester, eventHandlerTester);
      await eventHandlerTester._isEventCalledCompleter.future;
      expect(
        eventHandlerTester._isEventCalledCompleter.isCompleted,
        isTrue,
        reason:
            'Callback of $description not be marked called, make sure you call'
            ' the `eventHandlerTester.markEventCalled` function inside the callback.'
            'If the `eventHandlerTester.markEventCalled` is called inside the callback, '
            'but the error still occur, that mean the callback is actually not be called,'
            'you should check the callback logic again.',
      );
    },
    timeout: const Timeout(Duration(milliseconds: 10000)),
  );
}
