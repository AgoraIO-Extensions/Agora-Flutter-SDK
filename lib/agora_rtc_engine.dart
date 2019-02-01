import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgoraRtcEngine {
  static const MethodChannel _channel = const MethodChannel('agora_rtc_engine');

  // Core Events
  static void Function(int warn) onWarning;
  static void Function(int err) onError;
  static void Function(String channel, int uid, int elapsed)
      onJoinChannelSuccess;
  static void Function(String channel, int uid, int elapsed)
      onRejoinChannelSuccess;
  static VoidCallback onLeaveChannel;
  static void Function(int oldRole, int newRole) onClientRoleChanged;
  static void Function(int uid, int elapsed) onUserJoined;
  static void Function(int uid, int elapsed) onUserOffline;
  static void Function(int state, int reason) onConnectionStateChanged;
  static VoidCallback onConnectionLost;
  static void Function(int error, String api, String result) onApiCallExecuted;
  static void Function(String token) onTokenPrivilegeWillExpire;
  static VoidCallback onRequestToken;

  // Media Events
  static void Function(bool enabled) onMicrophoneEnabled;
  static void Function(int totalVolume, List<AudioVolumeInfo> speakers)
      onAudioVolumeIndication;
  static void Function(int uid) onActiveSpeaker;
  static void Function(int elapsed) onFirstLocalAudioFrame;
  static void Function(int uid, int elapsed) onFirstRemoteAudioFrame;
  static VoidCallback onVideoStopped;
  static void Function(double width, double height, int elapsed)
      onFirstLocalVideoFrame;
  static void Function(int uid, double width, double height, int elapsed)
      onFirstRemoteVideoDecoded;
  static void Function(int uid, double width, double height, int elapsed)
      onFirstRemoteVideoFrame;
  static void Function(int uid, bool muted) onUserMuteAudio;
  static void Function(int uid, bool muted) onUserMuteVideo;
  static void Function(int uid, bool enabled) onUserEnableVideo;
  static void Function(int uid, bool enabled) onUserEnableLocalVideo;
  static void Function(int uid, double width, double height, int rotation)
      onVideoSizeChanged;
  static void Function(int uid, int state) onRemoteVideoStateChanged;

  // Fallback Events
  static void Function(bool isFallbackOrRecover)
      onLocalPublishFallbackToAudioOnly;
  static void Function(int uid, bool isFallbackOrRecover)
      onRemoteSubscribeFallbackToAudioOnly;

  // Device Events
  static void Function(int routing) onAudioRouteChanged;
  static VoidCallback onCameraReady;

  // Statistics Events
  static void Function(RemoteAudioStats stats) onRemoteAudioStats;
  static void Function(RtcStats stats) onRtcStats;
  static void Function(int uid, int txQuality, int rxQuality) onNetworkQuality;
  static void Function(LocalVideoStats stats) onLocalVideoStats;
  static void Function(RemoteVideoStats stats) onRemoteVideoStats;
  static void Function(int uid, int delay, int lost, int rxKBitRate)
      onRemoteAudioTransportStats;
  static void Function(int uid, int delay, int lost, int rxKBitRate)
      onRemoteVideoTransportStats;

  // Miscellaneous Events
  static VoidCallback onMediaEngineLoadSuccess;
  static VoidCallback onMediaEngineStartCallSuccess;

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
        case 'onWarning':
          if (onWarning != null) {
            onWarning(
                values['warn']);
          }
          break;
        case 'onError':
          if (onError != null) {
            onError(values['err']);
          }
          break;
        case 'onJoinChannelSuccess':
          if (onJoinChannelSuccess != null) {
            onJoinChannelSuccess(
                values['channel'], values['uid'], values['elapsed']);
          }
          break;
        case 'onRejoinChannelSuccess':
          if (onRejoinChannelSuccess != null) {
            onRejoinChannelSuccess(
                values['channel'], values['uid'], values['elapsed']);
          }
          break;
        case 'onLeaveChannel':
          if (onLeaveChannel != null) {
            onLeaveChannel();
          }
          break;
        case 'onClientRoleChanged':
          if (onClientRoleChanged != null) {
            onClientRoleChanged(values['oldRole'], values['newRole']);
          }
          break;
        case 'onUserJoined':
          if (onUserJoined != null) {
            onUserJoined(values['uid'], values['elapsed']);
          }
          break;
        case 'onUserOffline':
          if (onUserOffline != null) {
            onUserOffline(values['uid'], values['reason']);
          }
          break;
        case 'onConnectionStateChanged':
          if (onConnectionStateChanged != null) {
            onConnectionStateChanged(values['state'], values['reason']);
          }
          break;
        case 'onConnectionLost':
          if (onConnectionLost != null) {
            onConnectionLost();
          }
          break;
        case 'onApiCallExecuted':
          if (onApiCallExecuted != null) {
            onApiCallExecuted(values['error'], values['api'], values['result']);
          }
          break;
        case 'onTokenPrivilegeWillExpire':
          if (onTokenPrivilegeWillExpire != null) {
            onTokenPrivilegeWillExpire(values['token']);
          }
          break;
        case 'onRequestToken':
          if (onRequestToken != null) {
            onRequestToken();
          }
          break;
        // Media Events
        case 'onMicrophoneEnabled':
          if (onMicrophoneEnabled != null) {
            onMicrophoneEnabled(values['enabled']);
          }
          break;
        case 'onAudioVolumeIndication':
          if (onAudioVolumeIndication != null) {
            List<Map> speakerValues = values['speakers'];
            List<AudioVolumeInfo> speakers = List<AudioVolumeInfo>();
            for (Map speakerValue in speakerValues) {
              AudioVolumeInfo info =
                  AudioVolumeInfo(speakerValue['uid'], speakerValue['volume']);
              speakers.add(info);
            }
            onAudioVolumeIndication(values['totalVolume'], speakers);
          }
          break;
        case 'onActiveSpeaker':
          if (onActiveSpeaker != null) {
            onActiveSpeaker(values['uid']);
          }
          break;
        case 'onFirstLocalAudioFrame':
          if (onFirstLocalAudioFrame != null) {
            onFirstLocalAudioFrame(values['elapsed']);
          }
          break;
        case 'onFirstRemoteAudioFrame':
          if (onFirstRemoteAudioFrame != null) {
            onFirstRemoteAudioFrame(values['uid'], values['elapsed']);
          }
          break;
        case 'onVideoStopped':
          if (onVideoStopped != null) {
            onVideoStopped();
          }
          break;
        case 'onFirstLocalVideoFrame':
          if (onFirstLocalVideoFrame != null) {
            onFirstLocalVideoFrame(
                values['width'], values['height'], values['elapsed']);
          }
          break;
        case 'onFirstRemoteVideoDecoded':
          if (onFirstRemoteVideoDecoded != null) {
            onFirstRemoteVideoDecoded(values['uid'], values['width'],
                values['height'], values['elapsed']);
          }
          break;
        case 'onFirstRemoteVideoFrame':
          if (onFirstRemoteVideoFrame != null) {
            onFirstRemoteVideoFrame(values['uid'], values['width'],
                values['height'], values['elapsed']);
          }
          break;
        case 'onUserMuteAudio':
          if (onUserMuteAudio != null) {
            onUserMuteAudio(values['uid'], values['muted']);
          }
          break;

        case 'onUserMuteVideo':
          if (onUserMuteVideo != null) {
            onUserMuteVideo(values['uid'], values['muted']);
          }
          break;
        case 'onUserEnableVideo':
          if (onUserEnableVideo != null) {
            onUserEnableVideo(values['uid'], values['enabled']);
          }
          break;
        case 'onUserEnableLocalVideo':
          if (onUserEnableLocalVideo != null) {
            onUserEnableLocalVideo(values['uid'], values['enabled']);
          }
          break;
        case 'onVideoSizeChanged':
          if (onVideoSizeChanged != null) {
            onVideoSizeChanged(values['uid'], values['width'], values['height'],
                values['rotation']);
          }
          break;
        case 'onRemoteVideoStateChanged':
          if (onRemoteVideoStateChanged != null) {
            onRemoteVideoStateChanged(values['uid'], values['state']);
          }
          break;
        // Fallback Events
        case 'onLocalPublishFallbackToAudioOnly':
          if (onLocalPublishFallbackToAudioOnly != null) {
            onLocalPublishFallbackToAudioOnly(values['isFallbackOrRecover']);
          }
          break;
        case 'onRemoteSubscribeFallbackToAudioOnly':
          if (onRemoteSubscribeFallbackToAudioOnly != null) {
            onRemoteSubscribeFallbackToAudioOnly(
                values['uid'], values['isFallbackOrRecover']);
          }
          break;

        // Device Events
        case 'onAudioRouteChanged':
          if (onAudioRouteChanged != null) {
            onAudioRouteChanged(values['routing']);
          }
          break;
        case 'onCameraReady':
          if (onCameraReady != null) {
            onCameraReady();
          }
          break;

        // Statistics Events
        case 'onRemoteAudioStats':
          if (onRemoteAudioStats != null) {
            Map statsValue = values['stats'];
            RemoteAudioStats stats = RemoteAudioStats();
            stats.uid = statsValue['uid'];
            stats.quality = statsValue['quality'];
            stats.networkTransportDelay = statsValue['networkTransportDelay'];
            stats.jitterBufferDelay = statsValue['jitterBufferDelay'];
            stats.audioLossRate = statsValue['audioLossRate'];
            onRemoteAudioStats(stats);
          }
          break;
        case 'onRtcStats':
          if (onRtcStats != null) {
            Map statsValue = values['stats'];
            RtcStats stats = RtcStats();
            stats.totalDuration = statsValue['totalDuration'];
            stats.txBytes = statsValue['txBytes'];
            stats.rxBytes = statsValue['rxBytes'];
            stats.txKBitRate = statsValue['txKBitRate'];
            stats.rxKBitRate = statsValue['rxKBitRate'];

            stats.txAudioKBitRate = statsValue['txAudioKBitRate'];
            stats.rxAudioKBitRate = statsValue['rxAudioKBitRate'];
            stats.txVideoKBitRate = statsValue['txVideoKBitRate'];
            stats.rxVideoKBitRate = statsValue['rxVideoKBitRate'];
            stats.users = statsValue['users'];
            stats.lastmileDelay = statsValue['lastmileDelay'];
            stats.cpuTotalUsage = statsValue['cpuTotalUsage'];
            stats.cpuAppUsage = statsValue['cpuAppUsage'];
            onRtcStats(stats);
          }
          break;
        case 'onNetworkQuality':
          if (onNetworkQuality != null) {
            onNetworkQuality(
                values['uid'], values['txQuality'], values['rxQuality']);
          }
          break;
        case 'onLocalVideoStats':
          if (onLocalVideoStats != null) {
            Map statsValue = values['stats'];
            LocalVideoStats stats = LocalVideoStats();
            stats.sentBitrate = statsValue['sentBitrate'];
            stats.sentFrameRate = statsValue['sentFrameRate'];
            onLocalVideoStats(stats);
          }
          break;
        case 'onRemoteVideoStats':
          if (onRemoteVideoStats != null) {
            Map statsValue = values['stats'];
            RemoteVideoStats stats = RemoteVideoStats();
            stats.uid = statsValue['uid'];
            stats.delay = statsValue['delay'];
            stats.width = statsValue['width'];
            stats.height = statsValue['height'];
            stats.receivedBitrate = statsValue['receivedBitrate'];
            stats.receivedFrameRate = statsValue['receivedFrameRate'];
            stats.rxStreamType = statsValue['rxStreamType'];
            onRemoteVideoStats(stats);
          }
          break;
        case 'onRemoteAudioTransportStats':
          if (onRemoteAudioTransportStats != null) {
            Map statsValue = values['stats'];
            onRemoteAudioTransportStats(values['uid'], values['delay'],
                values['lost'], values['rxKBitRate']);
          }
          break;
        case 'onRemoteVideoTransportStats':
          if (onRemoteVideoTransportStats != null) {
            onRemoteVideoTransportStats(values['uid'], values['delay'],
                values['lost'], values['rxKBitRate']);
          }
          break;
        // Miscellaneous Events
        case 'onMediaEngineLoadSuccess':
          if (onMediaEngineLoadSuccess != null) {
            Map statsValue = values['stats'];
            onMediaEngineLoadSuccess();
          }
          break;
        case 'onMediaEngineStartCallSuccess':
          if (onMediaEngineStartCallSuccess != null) {
            onMediaEngineStartCallSuccess();
          }
          break;
        default:
      }
    });
  }

  static void removeMethodCallHandler() {
    _channel.setMethodCallHandler(null);
  }
}

class AudioVolumeInfo {
  int uid;
  int volume;

  AudioVolumeInfo(int uid, int volume) {
    this.uid = uid;
    this.volume = volume;
  }
}

class RtcStats {
  int totalDuration;
  int txBytes;
  int rxBytes;
  int txKBitRate;
  int rxKBitRate;
  int txAudioKBitRate;
  int rxAudioKBitRate;
  int txVideoKBitRate;
  int rxVideoKBitRate;
  int users;
  int lastmileDelay;
  double cpuTotalUsage;
  double cpuAppUsage;
}

class LocalVideoStats {
  int sentBitrate;
  int sentFrameRate;
}

class RemoteVideoStats {
  int uid;
  int delay;
  int width;
  int height;
  int receivedBitrate;
  int receivedFrameRate;
  int rxStreamType;
}

class RemoteAudioStats {
  int uid;
  int quality;
  int networkTransportDelay;
  int jitterBufferDelay;
  int audioLossRate;
}
