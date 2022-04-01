import 'dart:async';
import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/src/rtc_device_manager.dart';
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
  kADMFollowSystemPlaybackDevice,
  kADMFollowSystemRecordingDevice,
}

enum _ApiTypeVideoDeviceManager {
  kVDMEnumerateVideoDevices,
  kVDMSetDevice,
  kVDMGetDevice,
  // ignore: unused_field
  kVDMStartDeviceTest,
  // ignore: unused_field
  kVDMStopDeviceTest,
}

///
/// The RTC device manager class, which manages the audio and video devices in the system.
///
///
class RtcDeviceManagerImpl implements RtcDeviceManager {
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

  ///
  /// Enumerates the audio playback devices.
  ///
  ///
  /// **return** Success: Returns a MediaDeviceInfo list that contains
  /// the device ID and device name of all the audio playback devices.
  /// Failure: null.
  ///
  @override
  Future<List<MediaDeviceInfo>> enumerateAudioPlaybackDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMEnumeratePlaybackDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  ///
  /// Sets the audio playback device.
  ///
  ///
  /// Param [deviceId] The ID of the audio playback device. You can get the device ID by calling enumerateAudioPlaybackDevices. Plugging or unplugging the audio device does not change the device ID.
  ///
  ///
  @override
  Future<void> setAudioPlaybackDevice(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  ///
  /// Retrieves the audio playback device associated with the device ID.
  ///
  ///
  /// **return** The current audio playback device.
  ///
  @override
  Future<String?> getAudioPlaybackDevice() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDevice.index,
      'params': jsonEncode({}),
    });
  }

  ///
  /// Retrieves the audio playback device information associated with the device ID and device name.
  ///
  ///
  /// **return** A MediaDeviceInfo class, which includes the device ID and the device name.
  ///
  @override
  Future<MediaDeviceInfo?> getAudioPlaybackDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceInfo.index,
      'params': jsonEncode({}),
    }).then((value) => MediaDeviceInfo.fromJson(jsonDecode(value)));
  }

  ///
  /// Sets the volume of the audio playback device.
  ///
  ///
  /// Param [volume] The volume of the audio playback device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  @override
  Future<void> setAudioPlaybackDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDeviceVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  ///
  /// Retrieves the volume of the audio playback device.
  ///
  ///
  /// **return** The volume of the audio playback device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  @override
  Future<int?> getAudioPlaybackDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceVolume.index,
      'params': jsonEncode({}),
    }).then((value) => int.tryParse(value));
  }

  ///
  /// Mutes the audio playback device.
  ///
  ///
  /// Param [mute] Whether to mute the audio playback device:
  /// true: Mute the audio playback device.
  /// false: Unmute the audio playback device.
  ///
  ///
  @override
  Future<void> setAudioPlaybackDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetPlaybackDeviceMute.index,
      'params': jsonEncode({
        'mute': mute,
      }),
    });
  }

  ///
  /// Retrieves whether the audio playback device is muted.
  ///
  ///
  /// **return** true: The audio playback device is muted.
  /// false: The audio playback device is unmuted.
  ///
  @override
  Future<bool?> getAudioPlaybackDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetPlaybackDeviceMute.index,
      'params': jsonEncode({}),
    }).then((value) => value == 'true');
  }

  ///
  /// Starts the audio playback device test.
  /// This method tests whether the audio playback device works properly. Once a user starts the test, the SDK plays an audio file specified by the user. If the user can hear the audio, the playback device works properly.
  /// After calling this method, the SDK triggers the audioVolumeIndication callback every 100 ms, reporting uid = 1 and the volume information of the playback device.
  /// Ensure that you call this method before joining a channel.
  ///
  /// Param [testAudioFilePath] The path of the audio file for the audio playback device test in UTF-8.
  /// Supported file formats: wav, mp3, m4a, and aac.
  /// Supported file sample rates: 8000, 16000, 32000, 44100, and 48000 Hz.
  ///
  ///
  @override
  Future<void> startAudioPlaybackDeviceTest(String testAudioFilePath) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStartPlaybackDeviceTest.index,
      'params': jsonEncode({
        'testAudioFilePath': testAudioFilePath,
      }),
    });
  }

  ///
  /// Stops the audio playback device test.
  /// This method stops the audio playback device test. You must call this method to stop the test after calling the startAudioPlaybackDeviceTest method.
  /// Ensure that you call this method before joining a channel.
  ///
  @override
  Future<void> stopAudioPlaybackDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStopPlaybackDeviceTest.index,
      'params': jsonEncode({}),
    });
  }

  ///
  /// Enumerates the audio capture devices.
  ///
  ///
  /// **return** Success: Returns a MediaDeviceInfo list that contains the device ID and device name of all the audio recording devices.
  /// Failure: null.
  ///
  @override
  Future<List<MediaDeviceInfo>> enumerateAudioRecordingDevices() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMEnumerateRecordingDevices.index,
      'params': jsonEncode({}),
    }).then((value) => List<MediaDeviceInfo>.of(
            List<Map<String, dynamic>>.from(jsonDecode(value)).map((e) {
          return MediaDeviceInfo.fromJson(e);
        })));
  }

  ///
  /// Sets the audio capture device.
  ///
  ///
  /// Param [deviceId] The ID of the audio capture device. You can get the device ID by calling enumerateAudioRecordingDevices. Plugging or unplugging the audio device does not change the device ID.
  ///
  ///
  @override
  Future<void> setAudioRecordingDevice(String deviceId) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDevice.index,
      'params': jsonEncode({
        'deviceId': deviceId,
      }),
    });
  }

  ///
  /// Gets the current audio recording device.
  ///
  ///
  /// **return** The current audio recording device.
  ///
  @override
  Future<String?> getAudioRecordingDevice() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDevice.index,
      'params': jsonEncode({}),
    });
  }

  ///
  /// Retrieves the audio capture device information associated with the device ID and device name.
  ///
  ///
  /// **return** A MediaDeviceInfo class that contains the device ID and device name of all the audio recording devices.
  ///
  @override
  Future<MediaDeviceInfo?> getAudioRecordingDeviceInfo() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceInfo.index,
      'params': jsonEncode({}),
    }).then((value) =>
        value != null ? MediaDeviceInfo.fromJson(jsonDecode(value)) : null);
  }

  ///
  /// Sets the volume of the audio capture device.
  ///
  ///
  /// Param [volume] The volume of the audio recording device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  @override
  Future<void> setAudioRecordingDeviceVolume(int volume) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDeviceVolume.index,
      'params': jsonEncode({
        'volume': volume,
      }),
    });
  }

  ///
  /// Retrieves the volume of the audio recording device.
  ///
  ///
  /// **return** The volume of the audio recording device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  @override
  Future<int?> getAudioRecordingDeviceVolume() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceVolume.index,
      'params': jsonEncode({}),
    }).then((value) => int.tryParse(value));
  }

  ///
  /// Sets the mute status of the audio capture device.
  ///
  ///
  /// Param [mute] Whether to mute the audio capture device:
  /// true: Mute the audio capture device.
  /// false: Unmute the audio capture device.
  ///
  ///
  @override
  Future<void> setAudioRecordingDeviceMute(bool mute) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMSetRecordingDeviceMute.index,
      'params': jsonEncode({
        'mute': mute,
      }),
    });
  }

  ///
  /// Gets the microphone's mute status.
  ///
  ///
  /// **return** true: The microphone is muted.
  /// false: The microphone is unmuted.
  ///
  @override
  Future<bool?> getAudioRecordingDeviceMute() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMGetRecordingDeviceMute.index,
      'params': jsonEncode({}),
    }).then((value) => value == 'true');
  }

  ///
  /// Starts the audio capture device test.
  /// This method tests whether the audio capture device works properly. After calling this method, the SDK triggers the audioVolumeIndication callback at the time interval set in this method, which reports uid = 0 and the volume information of the capture device.
  /// Ensure that you call this method before joining a channel.
  ///
  /// Param [indicationInterval] The time interval (ms) at which the SDK triggers the audioVolumeIndication callback. Agora recommends a setting greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the audioVolumeIndication callback.
  ///
  @override
  Future<void> startAudioRecordingDeviceTest(int indicationInterval) {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStartRecordingDeviceTest.index,
      'params': jsonEncode({
        'indicationInterval': indicationInterval,
      }),
    });
  }

  ///
  /// Stops the audio capture device test.
  /// This method stops the audio capture device test. You must call this method to stop the test after calling the startAudioRecordingDeviceTest method.
  /// Ensure that you call this method before joining a channel.
  ///
  @override
  Future<void> stopAudioRecordingDeviceTest() {
    return _invokeAudioMethod('callApi', {
      'apiType': _ApiTypeAudioDeviceManager.kADMStopRecordingDeviceTest.index,
      'params': jsonEncode({}),
    });
  }

  ///
  /// Starts an audio device loopback test.
  /// This method tests whether the local audio capture device and playback device are working properly. After starting the test, the audio capture device records the local audio, and the audio playback device plays the captured audio. The SDK triggers two independent audioVolumeIndication callbacks at the time interval set in this method, which reports the volume information of the capture device (uid = 0) and the volume information of the playback device (uid = 1) respectively.
  ///
  /// Ensure that you call this method before joining a channel.
  /// This method tests local audio devices and does not report the network conditions.
  ///
  /// Param [indicationInterval] The time interval (ms) at which the SDK triggers the audioVolumeIndication callback. Agora recommends a setting greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the audioVolumeIndication callback.
  ///
  @override
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval) {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStartAudioDeviceLoopbackTest.index,
      'params': jsonEncode({
        'indicationInterval': indicationInterval,
      }),
    });
  }

  ///
  /// Stops the audio device loopback test.
  /// Ensure that you call this method before joining a channel.
  /// Ensure that you call this method to stop the loopback test after calling the startAudioDeviceLoopbackTest method.
  ///
  @override
  Future<void> stopAudioDeviceLoopbackTest() {
    return _invokeAudioMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMStopAudioDeviceLoopbackTest.index,
      'params': jsonEncode({}),
    });
  }

  ///
  /// Enumerates the video devices.
  ///
  ///
  /// **return** Success: Returns a MediaDeviceInfo that contains all the video devices.
  /// Failure: null.
  ///
  @override
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
  @override
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
  /// **return** The video capture device.
  ///
  @override
  Future<String?> getVideoDevice() {
    return _invokeVideoMethod('callApi', {
      'apiType': _ApiTypeVideoDeviceManager.kVDMGetDevice.index,
      'params': jsonEncode({}),
    });
  }

  @override
  Future<void> followSystemPlaybackDevice(bool enable) {
    return _invokeVideoMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMFollowSystemPlaybackDevice.index,
      'params': jsonEncode({
        'enable': enable,
      }),
    });
  }

  @override
  Future<void> followSystemRecordingDevice(bool enable) {
    return _invokeVideoMethod('callApi', {
      'apiType':
          _ApiTypeAudioDeviceManager.kADMFollowSystemRecordingDevice.index,
      'params': jsonEncode({
        'enable': enable,
      }),
    });
  }
}
