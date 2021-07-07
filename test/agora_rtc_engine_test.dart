import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const channel = MethodChannel('agora_rtc_engine');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  test('LiveTranscoding', () {
    var transcoding = LiveTranscoding([], backgroundColor: Colors.red);
    print(transcoding.backgroundColor);
    print(transcoding.toJson());
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
