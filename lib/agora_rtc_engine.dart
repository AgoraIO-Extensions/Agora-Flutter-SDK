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
    return await _channel.invokeMethod('createEngine', {'appId': appid});
  }

  static Future<bool> joinChannel(
      String token, String channelId, String info, int uid) async {
    final bool success = await _channel.invokeMethod('joinChannel',
        {'token': token, 'channelId': channelId, 'info': info, 'uid': uid});
    return success;
  }

  static Future<bool> leaveChannel() async {
    final bool success = await _channel.invokeMethod('leaveChannel');
    return success;
  }

  static Future<void> enableVideo() async {
    await _channel.invokeMethod('enableVideo');
  }

  static Future<void> disableVideo() async {
    await _channel.invokeMethod('disableVideo');
  }

  static Future<void> startPreview() async {
    await _channel.invokeMethod('startPreview');
  }

  static Future<void> stopPreview() async {
    await _channel.invokeMethod('stopPreview');
  }

  static Future<void> setupLocalVideo(int viewId, int renderMode) async {
    await _channel.invokeMethod(
        'setupLocalVideo', {'viewId': viewId, 'renderMode': renderMode});
  }

  static Future<void> setupRemoteVideo(
      int viewId, int renderMode, int uid) async {
    await _channel.invokeMethod('setupRemoteVideo', {
      'viewId': viewId,
      'renderMode': renderMode,
      'uid': uid,
    });
  }

  static void addMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) {
      switch (call.method) {
        case 'didJoinChannel':
          Map values = call.arguments;
          didJoinChannelHandler(
              values['channel'], values['uid'], values['elapsed']);
          break;
        case 'didLeaveChannel':
          didLeaveChannelHandler();
          break;
        default:
      }
    });
  }
}
