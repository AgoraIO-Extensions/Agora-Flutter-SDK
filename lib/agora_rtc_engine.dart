import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgoraRtcEngine {
  static const MethodChannel _channel = const MethodChannel('agora_rtc_engine');

  static void Function(String channel, int uid, int elapsed)
      onJoinChannelSuccess;
  static VoidCallback onLeaveChannel;
  static void Function(int uid, int elapsed) onUserJoined;
  static void Function(int uid, int elapsed) onUserOffline;

  // Core Methods
  static Future<void> create(String appid) async {
    addMethodCallHandler();
    return await _channel.invokeMethod('create', {'appId': appid});
  }

  static Future<void> destroy() async {
    removeMethodCallHandler();
    return await _channel.invokeMethod('destroy');
  }

  static Future<void> setChannelProfile(int profile) async {
    return await _channel
        .invokeMethod('setChannelProfile', {'profile': profile});
  }

  static Future<void> setClientRole(int role) async {
    return await _channel.invokeMethod('setClientRole', {'role': role});
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

  static Future<void> renewToken(String token) async {
    return await _channel.invokeMethod('renewToken', {'token': token});
  }

  static Future<void> enableWebSdkInteroperability(bool enabled) async {
    return await _channel
        .invokeMethod('enableWebSdkInteroperability', {'enabled': enabled});
  }

  static Future<int> getConnectionState() async {
    final int state = await _channel.invokeMethod('getConnectionState');
    return state;
  }

  // Core Audio
  static Future<void> enableAudio() async {
    await _channel.invokeMethod('enableAudio');
  }

  static Future<void> disableAudio() async {
    await _channel.invokeMethod('disableAudio');
  }

  static Future<void> setAudioProfile(int profile, int scenario) async {
    await _channel.invokeMethod(
        'setAudioProfile', {'profile': profile, 'scenario': scenario});
  }

  static Future<void> adjustRecordingSignalVolume(int volume) async {
    await _channel
        .invokeMethod('adjustRecordingSignalVolume', {'volume': volume});
  }

  static Future<void> adjustPlaybackSignalVolume(int volume) async {
    await _channel
        .invokeMethod('adjustPlaybackSignalVolume', {'volume': volume});
  }

  static Future<void> enableAudioVolumeIndication(
      int interval, int smooth) async {
    await _channel.invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth});
  }

  static Future<void> enableLocalAudio(bool enabled) async {
    await _channel.invokeMethod('enableLocalAudio', {'enabled': enabled});
  }

  static Future<void> muteLocalAudioStream(bool muted) async {
    await _channel.invokeMethod('muteLocalAudioStream', {'muted': muted});
  }

  static Future<void> muteRemoteAudioStream(int uid, bool muted) async {
    await _channel
        .invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  static Future<void> muteAllRemoteAudioStreams(bool muted) async {
    await _channel.invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  static Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) async {
    await _channel
        .invokeMethod('setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  // Core Video
  static Future<void> enableVideo() async {
    await _channel.invokeMethod('enableVideo');
  }

  static Future<void> disableVideo() async {
    await _channel.invokeMethod('disableVideo');
  }

  static Future<void> setVideoEncoderConfiguration(Size dimensions,
      int frameRate, int bitrate, int minBitrate, int orientationMode) async {
    await _channel.invokeMethod('setVideoEncoderConfiguration', {
      'width': dimensions.width,
      'height': dimensions.height,
      'frameRate': frameRate,
      'minBitrate': minBitrate,
      'orientationMode': orientationMode
    });
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

  static Future<void> setLocalRenderMode(int mode) async {
    await _channel.invokeMethod('setLocalRenderMode', {'mode': mode});
  }

  static Future<void> setRemoteRenderMode(int uid, int mode) async {
    await _channel
        .invokeMethod('setRemoteRenderMode', {'uid': uid, 'mode': mode});
  }

  static Future<void> startPreview() async {
    await _channel.invokeMethod('startPreview');
  }

  static Future<void> stopPreview() async {
    await _channel.invokeMethod('stopPreview');
  }

  static Future<void> enableLocalVideo(bool enabled) async {
    await _channel.invokeMethod('enableLocalVideo', {'enabled': enabled});
  }

  static Future<void> muteLocalVideoStream(bool muted) async {
    await _channel.invokeMethod('muteLocalVideoStream', {'muted': muted});
  }

  static Future<void> muteRemoteVideoStream(int uid, bool muted) async {
    await _channel
        .invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  static Future<void> muteAllRemoteVideoStreams(bool muted) async {
    await _channel.invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  static Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) async {
    await _channel
        .invokeMethod('setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
  }

  // Audio Routing Controller
  static Future<void> setDefaultAudioRouteToSpeaker(
      bool defaultToSpeaker) async {
    await _channel.invokeMethod('setDefaultAudioRouteToSpeaker',
        {'defaultToSpeaker': defaultToSpeaker});
  }

  static Future<void> setEnableSpeakerphone(bool enabled) async {
    await _channel.invokeMethod('setEnableSpeakerphone', {'enabled': enabled});
  }

  static Future<bool> isSpeakerphoneEnabled() async {
    final bool enabled = await _channel.invokeMethod('isSpeakerphoneEnabled');
    return enabled;
  }

  // Stream Fallback
  static Future<void> setLocalPublishFallbackOption(int option) async {
    await _channel
        .invokeMethod('setLocalPublishFallbackOption', {'option': option});
  }

  static Future<void> setRemoteSubscribeFallbackOption(int option) async {
    await _channel
        .invokeMethod('setRemoteSubscribeFallbackOption', {'option': option});
  }

  // Dual-stream Mode
  static Future<void> enableDualStreamMode(bool enabled) async {
    await _channel.invokeMethod('enableDualStreamMode', {'enabled': enabled});
  }

  static Future<void> setRemoteVideoStreamType(int uid, int streamType) async {
    await _channel.invokeMethod(
        'setRemoteVideoStreamType', {'uid': uid, 'streamType': streamType});
  }

  static Future<void> setRemoteDefaultVideoStreamType(int streamType) async {
    await _channel.invokeMethod(
        'setRemoteDefaultVideoStreamType', {'streamType': streamType});
  }

  // Camera Control
  static Future<void> switchCamera() async {
    await _channel.invokeMethod('switchCamera');
  }

  // Miscellaneous Methods
  static Future<String> getSdkVersion() async {
    final String version = await _channel.invokeMethod('getSdkVersion');
    return version;
  }

  // CallHandler
  static void addMethodCallHandler() {
    _channel.setMethodCallHandler((MethodCall call) {
      Map values = call.arguments;

      switch (call.method) {
        // Core Events
        case 'onJoinChannelSuccess':
          onJoinChannelSuccess(
              values['channel'], values['uid'], values['elapsed']);
          break;
        case 'onLeaveChannel':
          onLeaveChannel();
          break;
        case 'onUserJoined':
          onUserJoined(values['uid'], values['elapsed']);
          break;
        case 'onUserOffline':
          onUserOffline(values['uid'], values['reason']);
          break;
        default:
      }
    });
  }

  static void removeMethodCallHandler() {
    _channel.setMethodCallHandler(null);
  }
}
