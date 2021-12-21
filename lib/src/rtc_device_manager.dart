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

/* class-RtcDeviceManager */
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

  /* api-audio-enumerateAudioPlaybackDevices */
  Future<List<MediaDeviceInfo>> enumerateAudioPlaybackDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMEnumeratePlaybackDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  /* api-audio-setAudioPlaybackDevice */
  Future<void> setAudioPlaybackDevice(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  /* api-audio-getAudioPlaybackDevice */
  Future<String?> getAudioPlaybackDevice() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDevice.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-getAudioPlaybackDeviceInfo */
  Future<MediaDeviceInfo?> getAudioPlaybackDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceInfo.index,
      'params': jsonEncode({}),
    }).then((value) => MediaDeviceInfo.fromJson(jsonDecode(value)));
  }

  /* api-audio-setAudioPlaybackDeviceVolume */
  Future<void> setAudioPlaybackDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDeviceVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  /* api-audio-getAudioPlaybackDeviceVolume */
  Future<int?> getAudioPlaybackDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceVolume.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-setAudioPlaybackDeviceMute */
  Future<void> setAudioPlaybackDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDeviceMute.index,
      'params': jsonEncode({
        'mute': mute,
      }),
    });
  }

  /* api-audio-getAudioPlaybackDeviceMute */
  Future<bool?> getAudioPlaybackDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceMute.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-startAudioPlaybackDeviceTest */
  Future<void> startAudioPlaybackDeviceTest(String testAudioFilePath) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStartPlaybackDeviceTest.index,
      'params': jsonEncode({
        'testAudioFilePath': testAudioFilePath,
      }),
    });
  }

  /* api-audio-stopAudioPlaybackDeviceTest */
  Future<void> stopAudioPlaybackDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStopPlaybackDeviceTest.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-enumerateAudioRecordingDevices */
  Future<List<MediaDeviceInfo>> enumerateAudioRecordingDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMEnumerateRecordingDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  /* api-audio-setAudioRecordingDevice */
  Future<void> setAudioRecordingDevice(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  /* api-audio-getAudioRecordingDevice */
  Future<String?> getAudioRecordingDevice() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDevice.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-getAudioRecordingDeviceInfo */
  Future<MediaDeviceInfo?> getAudioRecordingDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceInfo.index,
      'params': jsonEncode({}),
    }).then((value) => MediaDeviceInfo.fromJson(jsonDecode(value)));
  }

  /* api-audio-setAudioRecordingDeviceVolume */
  Future<void> setAudioRecordingDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDeviceVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  /* api-audio-getAudioRecordingDeviceVolume */
  Future<int?> getAudioRecordingDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceVolume.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-setAudioRecordingDeviceMute */
  Future<void> setAudioRecordingDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDeviceMute.index,
      'params': jsonEncode({
        'mute': mute,
      }),
    });
  }

  /* api-audio-getAudioRecordingDeviceMute */
  Future<bool?> getAudioRecordingDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceMute.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-startAudioRecordingDeviceTest */
  Future<void> startAudioRecordingDeviceTest(String testAudioFilePath) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStartRecordingDeviceTest.index,
      'params': jsonEncode({
        'testAudioFilePath': testAudioFilePath,
      }),
    });
  }

  /* api-audio-stopAudioRecordingDeviceTest */
  Future<void> stopAudioRecordingDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStopRecordingDeviceTest.index,
      'params': jsonEncode({}),
    });
  }

  /* api-audio-startAudioDeviceLoopbackTest */
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStartAudioDeviceLoopbackTest.index,
      'params': jsonEncode({
        'indicationInterval': indicationInterval,
      }),
    });
  }

  /* api-audio-stopAudioDeviceLoopbackTest */
  Future<void> stopAudioDeviceLoopbackTest() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStopAudioDeviceLoopbackTest.index,
      'params': jsonEncode({}),
    });
  }

  /* api-video-enumerateVideoDevices */
  Future<List<MediaDeviceInfo>> enumerateVideoDevices() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMEnumerateVideoDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  ///
  /// Specifies the video capture device with the device ID.
  /// Plugging or unplugging a device does not change its device ID.
  ///
  /// Param [deviceId] The device ID. You can get the device ID by calling enumerateVideoDevices.
  /// 
  ///
  /// **return** 0: Success.
  /// < 0: Failure.
  ///
  Future<void> setVideoDevice(String deviceId) {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMSetDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  ///
  /// Retrieves the current video capture device.
  /// 
  ///
  /// **return** 0: Success.
  /// < 0: Failure.
  /// 
  /// The video capture device. See .
  /// The video capture device.
  ///
  Future<String?> getVideoDevice() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMGetDevice.index,
      'params': jsonEncode({}),
    });
  }

  /* api-video-startVideoDeviceTest */
  Future<void> startVideoDeviceTest(int hwnd) {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMStartDeviceTest.index,
      'params': jsonEncode({
        'hwnd': hwnd,
      }),
    });
  }

  /* api-video-stopVideoDeviceTest */
  Future<void> stopVideoDeviceTest() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMStopDeviceTest.index,
      'params': jsonEncode({}),
    });
  }
}
