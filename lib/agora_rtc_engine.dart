import 'dart:async';

import 'package:flutter/services.dart';

class AgoraRtcEngine {
  static const MethodChannel _channel =
      const MethodChannel('agora_rtc_engine');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
