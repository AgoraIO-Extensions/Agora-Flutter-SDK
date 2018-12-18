import 'dart:async';

import 'package:flutter/services.dart';

typedef void DidJoinChannelHandler(String channel, int uid, int elapsed);
typedef void DidLeaveChannelHandler();

class AgoraRtcEngine {
  static const MethodChannel _channel = const MethodChannel('agora_rtc_engine');

  static DidJoinChannelHandler didJoinChannelHandler =
      (String channel, int uid, int elapsed) {};
  static DidLeaveChannelHandler didLeaveChannelHandler = () {};

  static Future<void> createEngine(String appid) async {
    addMethodCallHandler();
    return await _channel.invokeMethod('createEngine', [appid]);
  }

  static Future<bool> joinChannel(
      String token, String channelId, String info, int uid) async {
    final bool success = await _channel
        .invokeMethod('joinChannel', [token, channelId, info, uid]);
    return success;
  }

  static Future<bool> leaveChannel() async {
    final bool success = await _channel.invokeMethod('leaveChannel');
    return success;
  }

  static void addMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) {
      String method = call.method;

      if (method == 'didJoinChannel') {
        Map values = call.arguments;
        didJoinChannelHandler(
            values['channel'], values['uid'], values['elapsed']);
      } else if (method == 'didLeaveChannel') {
        didLeaveChannelHandler();
      }
    });
  }
}
