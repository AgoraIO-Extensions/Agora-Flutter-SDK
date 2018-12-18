import 'dart:async';

import 'package:flutter/services.dart';

class AgoraRtcEngine {
  static const MethodChannel _channel =
      const MethodChannel('agora_rtc_engine');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> createEngine(String appid) async {
     return await _channel.invokeMethod('createEngine', [appid]);
  }

  static Future<bool> joinChannel(String token, String channelId, String info, int uid) async {
    final bool success = await _channel.invokeMethod('joinChannel', [token, channelId, info, uid]);
    return success;
  }

  static Future<bool> leaveChannel() async {
    final bool success = await _channel.invokeMethod('leaveChannel');
    return success;
  }
}
