import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/services.dart';

enum _ApiTypeAudioDeviceManager {
  kADMEnumerateAudioPlaybackDevices,
  kADMGetAudioPlaybackDeviceCount,
  kADMGetAudioPlaybackDeviceInfoByIndex,
  kADMSetCurrentAudioPlaybackDeviceId,
  kADMGetCurrentAudioPlaybackDeviceId,
  kADMGetCurrentAudioPlaybackDeviceInfo,
  kADMSetAudioPlaybackDeviceVolume,
  kADMGetAudioPlaybackDeviceVolume,
  kADMSetAudioPlaybackDeviceMute,
  kADMGetAudioPlaybackDeviceMute,
  kADMStartAudioPlaybackDeviceTest,
  kADMStopAudioPlaybackDeviceTest,
  kADMEnumerateAudioRecordingDevices,
  kADMGetAudioRecordingDeviceCount,
  kADMGetAudioRecordingDeviceInfoByIndex,
  kADMSetCurrentAudioRecordingDeviceId,
  kADMGetCurrentAudioRecordingDeviceId,
  kADMGetCurrentAudioRecordingDeviceInfo,
  kADMSetAudioRecordingDeviceVolume,
  kADMGetAudioRecordingDeviceVolume,
  kADMSetAudioRecordingDeviceMute,
  kADMGetAudioRecordingDeviceMute,
  kADMStartAudioRecordingDeviceTest,
  kADMStopAudioRecordingDeviceTest,
  kADMStartAudioDeviceLoopbackTest,
  kADMStopAudioDeviceLoopbackTest,
}

enum _ApiTypeVideoDeviceManager {
  kVDMEnumerateVideoDevices,
  kVDMGetVideoDeviceCount,
  kVDMGetVideoDeviceInfoByIndex,
  kVDMSetCurrentVideoDeviceId,
  kVDMGetCurrentVideoDeviceId,
  kVDMStartVideoDeviceTest,
  kVDMStopVideoDeviceTest,
}

class RtcDeviceManager {
  static const MethodChannel _audioMethodChannel =
      MethodChannel('agora_rtc_audio_device_manager');
  static const MethodChannel _videoMethodChannel =
      MethodChannel('agora_rtc_video_device_manager');

  Future<T?> _invokeAudioMethod<T>(String method,
      [Map<String, dynamic>? arguments]) {
    return _audioMethodChannel.invokeMethod(method, arguments);
  }

  Future<T?> _invokeVideoMethod<T>(String method,
      [Map<String, dynamic>? arguments]) {
    return _videoMethodChannel.invokeMethod(method, arguments);
  }

  Future<List<MediaDeviceInfo>> enumerateAudioPlaybackDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMEnumerateAudioPlaybackDevices.index,
      'params': jsonEncode({})
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  Future<void> setCurrentAudioPlaybackDeviceId(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMSetCurrentAudioPlaybackDeviceId.index,
      'params': jsonEncode({'deviceId': deviceId})
    });
  }

  Future<String?> getCurrentAudioPlaybackDeviceId() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMGetCurrentAudioPlaybackDeviceId.index,
      'params': jsonEncode({})
    });
  }

  Future<MediaDeviceInfo?> getCurrentAudioPlaybackDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager
          .kADMGetCurrentAudioPlaybackDeviceInfo.index,
      'params': jsonEncode({})
    }).then((value) => MediaDeviceInfo.fromJson(jsonDecode(value)));
  }

  Future<void> setAudioPlaybackDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMSetAudioPlaybackDeviceVolume.index,
      'params': jsonEncode({'volume': volume})
    });
  }

  Future<int?> getAudioPlaybackDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMGetAudioPlaybackDeviceVolume.index,
      'params': jsonEncode({})
    });
  }

  Future<void> setAudioPlaybackDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMSetAudioPlaybackDeviceMute.index,
      'params': jsonEncode({'mute': mute})
    });
  }

  Future<bool?> getAudioPlaybackDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMGetAudioPlaybackDeviceMute.index,
      'params': jsonEncode({})
    });
  }

  Future<void> startAudioPlaybackDeviceTest(String testAudioFilePath) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStartAudioPlaybackDeviceTest.index,
      'params': jsonEncode({'testAudioFilePath': testAudioFilePath})
    });
  }

  Future<void> stopAudioPlaybackDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStopAudioPlaybackDeviceTest.index,
      'params': jsonEncode({})
    });
  }

  Future<List<MediaDeviceInfo>> enumerateAudioRecordingDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMEnumerateAudioRecordingDevices.index,
      'params': jsonEncode({})
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  Future<void> setCurrentAudioRecordingDeviceId(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMSetCurrentAudioRecordingDeviceId.index,
      'params': jsonEncode({'deviceId': deviceId})
    });
  }

  Future<String?> getCurrentAudioRecordingDeviceId() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMGetCurrentAudioRecordingDeviceId.index,
      'params': jsonEncode({})
    });
  }

  Future<MediaDeviceInfo?> getCurrentAudioRecordingDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager
          .kADMGetCurrentAudioRecordingDeviceInfo.index,
      'params': jsonEncode({})
    }).then((value) => MediaDeviceInfo.fromJson(jsonDecode(value)));
  }

  Future<void> setAudioRecordingDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMSetAudioRecordingDeviceVolume.index,
      'params': jsonEncode({'volume': volume})
    });
  }

  Future<int?> getAudioRecordingDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMGetAudioRecordingDeviceVolume.index,
      'params': jsonEncode({})
    });
  }

  Future<void> setAudioRecordingDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMSetAudioRecordingDeviceMute.index,
      'params': jsonEncode({'mute': mute})
    });
  }

  Future<bool?> getAudioRecordingDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMGetAudioRecordingDeviceMute.index,
      'params': jsonEncode({})
    });
  }

  Future<void> startAudioRecordingDeviceTest(String testAudioFilePath) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStartAudioRecordingDeviceTest.index,
      'params': jsonEncode({'testAudioFilePath': testAudioFilePath})
    });
  }

  Future<void> stopAudioRecordingDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStopAudioRecordingDeviceTest.index,
      'params': jsonEncode({})
    });
  }

  Future<void> startAudioDeviceLoopbackTest(int indicationInterval) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStartAudioDeviceLoopbackTest.index,
      'params': jsonEncode({'indicationInterval': indicationInterval})
    });
  }

  Future<void> stopAudioDeviceLoopbackTest() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStopAudioDeviceLoopbackTest.index,
      'params': jsonEncode({})
    });
  }

  Future<List<MediaDeviceInfo>> enumerateVideoDevices() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMEnumerateVideoDevices.index,
      'params': jsonEncode({})
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  Future<void> setCurrentVideoDeviceId(String deviceId) {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMSetCurrentVideoDeviceId.index,
      'params': jsonEncode({'deviceId': deviceId})
    });
  }

  Future<String?> getCurrentVideoDeviceId() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMGetCurrentVideoDeviceId.index,
      'params': jsonEncode({})
    });
  }

  Future<void> startVideoDeviceTest(int hwnd) {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMStartVideoDeviceTest.index,
      'params': jsonEncode({'hwnd': hwnd})
    });
  }

  Future<void> stopVideoDeviceTest() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMStopVideoDeviceTest.index,
      'params': jsonEncode({})
    });
  }
}
