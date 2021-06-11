import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/services.dart';

enum _ApiTypeAudioDeviceManager {
  kADMEnumeratePlaybackDevices,
  kADMSetPlaybackDevice,
  kADMGetPlaybackDevice,
  kADMGetPlaybackDeviceInfo,
  kADMSetPlaybackDeviceVolume,
  kADMGetPlaybackDeviceVolume,
  kADMSetPlaybackDeviceMute,
  kADMGetPlaybackDeviceMute,
  kADMStartPlaybackDeviceTest,
  kADMStopPlaybackDeviceTest,
  kADMEnumerateRecordingDevices,
  kADMSetRecordingDevice,
  kADMGetRecordingDevice,
  kADMGetRecordingDeviceInfo,
  kADMSetRecordingDeviceVolume,
  kADMGetRecordingDeviceVolume,
  kADMSetRecordingDeviceMute,
  kADMGetRecordingDeviceMute,
  kADMStartRecordingDeviceTest,
  kADMStopRecordingDeviceTest,
  kADMStartAudioDeviceLoopbackTest,
  kADMStopAudioDeviceLoopbackTest,
}

enum _ApiTypeVideoDeviceManager {
  kVDMEnumerateVideoDevices,
  kVDMSetDevice,
  kVDMGetDevice,
  kVDMStartDeviceTest,
  kVDMStopDeviceTest,
}

/// TODO(doc)
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

  /// TODO(doc)
  Future<List<MediaDeviceInfo>> enumerateAudioPlaybackDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMEnumeratePlaybackDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  /// TODO(doc)
  Future<void> setAudioPlaybackDevice(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  /// TODO(doc)
  Future<String?> getAudioPlaybackDevice() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDevice.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<MediaDeviceInfo?> getAudioPlaybackDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceInfo.index,
      'params': jsonEncode({}),
    }).then((value) => MediaDeviceInfo.fromJson(jsonDecode(value)));
  }

  /// TODO(doc)
  Future<void> setAudioPlaybackDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDeviceVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  /// TODO(doc)
  Future<int?> getAudioPlaybackDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceVolume.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<void> setAudioPlaybackDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDeviceMute.index,
      'params': jsonEncode({
        'mute': mute,
      }),
    });
  }

  /// TODO(doc)
  Future<bool?> getAudioPlaybackDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceMute.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<void> startAudioPlaybackDeviceTest(String testAudioFilePath) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStartPlaybackDeviceTest.index,
      'params': jsonEncode({
        'testAudioFilePath': testAudioFilePath,
      }),
    });
  }

  /// TODO(doc)
  Future<void> stopAudioPlaybackDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStopPlaybackDeviceTest.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<List<MediaDeviceInfo>> enumerateAudioRecordingDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMEnumerateRecordingDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  /// TODO(doc)
  Future<void> setAudioRecordingDevice(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  /// TODO(doc)
  Future<String?> getAudioRecordingDevice() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDevice.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<MediaDeviceInfo?> getAudioRecordingDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceInfo.index,
      'params': jsonEncode({}),
    }).then((value) => MediaDeviceInfo.fromJson(jsonDecode(value)));
  }

  /// TODO(doc)
  Future<void> setAudioRecordingDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDeviceVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  /// TODO(doc)
  Future<int?> getAudioRecordingDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceVolume.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<void> setAudioRecordingDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDeviceMute.index,
      'params': jsonEncode({
        'mute': mute,
      }),
    });
  }

  /// TODO(doc)
  Future<bool?> getAudioRecordingDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceMute.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<void> startAudioRecordingDeviceTest(String testAudioFilePath) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStartRecordingDeviceTest.index,
      'params': jsonEncode({
        'testAudioFilePath': testAudioFilePath,
      }),
    });
  }

  /// TODO(doc)
  Future<void> stopAudioRecordingDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStopRecordingDeviceTest.index,
      'params': jsonEncode({}),
    });
  }

  Future<void> startAudioDeviceLoopbackTest(int indicationInterval) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStartAudioDeviceLoopbackTest.index,
      'params': jsonEncode({
        'indicationInterval': indicationInterval,
      }),
    });
  }

  Future<void> stopAudioDeviceLoopbackTest() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStopAudioDeviceLoopbackTest.index,
      'params': jsonEncode({}),
    });
  }

  Future<List<MediaDeviceInfo>> enumerateVideoDevices() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMEnumerateVideoDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  /// TODO(doc)
  Future<void> setVideoDevice(String deviceId) {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMSetDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  /// TODO(doc)
  Future<String?> getVideoDevice() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMGetDevice.index,
      'params': jsonEncode({}),
    });
  }

  /// TODO(doc)
  Future<void> startVideoDeviceTest(int hwnd) {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMStartDeviceTest.index,
      'params': jsonEncode({
        'hwnd': hwnd,
      }),
    });
  }

  /// TODO(doc)
  Future<void> stopVideoDeviceTest() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMStopDeviceTest.index,
      'params': jsonEncode({}),
    });
  }
}
