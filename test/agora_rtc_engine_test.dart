import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

void main() {
  const MethodChannel channel = MethodChannel('agora_rtc_engine');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
