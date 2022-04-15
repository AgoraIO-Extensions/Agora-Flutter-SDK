import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/rtc_device_manager_impl.dart';

///
/// The RTC device manager class, which manages the audio and video devices in the system.
///
///
abstract class RtcDeviceManager {
  /// Constructs the [RtcDeviceManager].
  factory RtcDeviceManager() {
    return RtcDeviceManagerImpl();
  }

  ///
  /// Enumerates the audio playback devices.
  ///
  ///
  /// **return** Success: Returns a MediaDeviceInfo list that contains
  ///  the device ID and device name of all the audio playback devices.
  ///  Failure: null.
  ///
  Future<List<MediaDeviceInfo>> enumerateAudioPlaybackDevices();

  ///
  /// Sets the audio playback device.
  ///
  ///
  /// Param [deviceId] The ID of the audio playback device. You can get the device ID by calling enumerateAudioPlaybackDevices . Plugging or unplugging the audio device does not change the device ID.
  ///
  ///
  Future<void> setAudioPlaybackDevice(String deviceId);

  ///
  /// Retrieves the audio playback device associated with the device ID.
  ///
  ///
  /// **return** The current audio playback device.
  ///
  Future<String?> getAudioPlaybackDevice();

  ///
  /// Retrieves the audio playback device information associated with the device ID and device name.
  ///
  ///
  /// **return** A MediaDeviceInfo class, which includes the device ID and the device name.
  ///
  Future<MediaDeviceInfo?> getAudioPlaybackDeviceInfo();

  ///
  /// Sets the volume of the audio playback device.
  ///
  ///
  /// Param [volume] The volume of the audio playback device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  Future<void> setAudioPlaybackDeviceVolume(int volume);

  ///
  /// Retrieves the volume of the audio playback device.
  ///
  ///
  /// **return** The volume of the audio playback device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  Future<int?> getAudioPlaybackDeviceVolume();

  ///
  /// Mutes the audio playback device.
  ///
  ///
  /// Param [mute] Whether to mute the audio playback device:
  ///  true: Mute the audio playback device.
  ///  false: Unmute the audio playback device.
  ///
  ///
  Future<void> setAudioPlaybackDeviceMute(bool mute);

  ///
  /// Retrieves whether the audio playback device is muted.
  ///
  ///
  /// **return** true: The audio playback device is muted.
  /// false: The audio playback device is unmuted.
  ///
  Future<bool?> getAudioPlaybackDeviceMute();

  ///
  /// Starts the audio playback device test.
  /// This method tests whether the audio playback device works properly. Once a user starts the test, the SDK plays an audio file specified by the user. If the user can hear the audio, the playback device works properly.
  ///  After calling this method, the SDK triggers the audioVolumeIndication callback every 100 ms, reporting uid = 1 and the volume information of the playback device.
  ///  Ensure that you call this method before joining a channel.
  ///
  /// Param [testAudioFilePath] The path of the audio file for the audio playback device test in UTF-8.
  ///
  ///
  Future<void> startAudioPlaybackDeviceTest(String testAudioFilePath);

  ///
  /// Stops the audio playback device test.
  /// This method stops the audio playback device test. You must call this method to stop the test after calling the startAudioPlaybackDeviceTest method.
  ///  Ensure that you call this method before joining a channel.
  ///
  Future<void> stopAudioPlaybackDeviceTest();

  ///
  /// Enumerates the audio capture devices.
  ///
  ///
  /// **return** Success: Returns a MediaDeviceInfo list that contains the device ID and device name of all the audio recording devices.
  ///  Failure: null.
  ///
  Future<List<MediaDeviceInfo>> enumerateAudioRecordingDevices();

  ///
  /// Sets the audio capture device.
  ///
  ///
  /// Param [deviceId] The ID of the audio capture device. You can get the device ID by calling enumerateAudioRecordingDevices . Plugging or unplugging the audio device does not change the device ID.
  ///
  ///
  Future<void> setAudioRecordingDevice(String deviceId);

  ///
  /// Gets the current audio recording device.
  ///
  ///
  /// **return** The current audio recording device.
  ///
  Future<String?> getAudioRecordingDevice();

  ///
  /// Retrieves the audio capture device information associated with the device ID and device name.
  ///
  ///
  /// **return** A MediaDeviceInfo class that contains the device ID and device name of all the audio recording devices.
  ///
  Future<MediaDeviceInfo?> getAudioRecordingDeviceInfo();

  ///
  /// Sets the volume of the audio capture device.
  ///
  ///
  /// Param [volume] The volume of the audio recording device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  Future<void> setAudioRecordingDeviceVolume(int volume);

  ///
  /// Retrieves the volume of the audio recording device.
  ///
  ///
  /// **return** The volume of the audio recording device. The value ranges between 0 (lowest volume) and 255 (highest volume).
  ///
  Future<int?> getAudioRecordingDeviceVolume();

  ///
  /// Sets the mute status of the audio capture device.
  ///
  ///
  /// Param [mute] Whether to mute the audio capture device:
  ///  true: Mute the audio capture device.
  ///  false: Unmute the audio capture device.
  ///
  ///
  Future<void> setAudioRecordingDeviceMute(bool mute);

  ///
  /// Gets the microphone's mute status.
  ///
  ///
  /// **return** true: The microphone is muted.
  ///  false: The microphone is unmuted.
  ///
  Future<bool?> getAudioRecordingDeviceMute();

  ///
  /// Starts the audio capture device test.
  /// This method tests whether the audio capture device works properly. After calling this method, the SDK triggers the audioVolumeIndication callback at the time interval set in this method, which reports uid = 0 and the volume information of the capture device.
  ///  Ensure that you call this method before joining a channel.
  ///
  /// Param [indicationInterval] The time interval (ms) at which the SDK triggers the audioVolumeIndication callback. Agora recommends a setting greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the audioVolumeIndication callback.
  ///
  Future<void> startAudioRecordingDeviceTest(int indicationInterval);

  ///
  /// Stops the audio capture device test.
  /// This method stops the audio capture device test. You must call this method to stop the test after calling the startAudioRecordingDeviceTest method.
  ///  Ensure that you call this method before joining a channel.
  ///
  Future<void> stopAudioRecordingDeviceTest();

  ///
  /// Starts an audio device loopback test.
  /// This method tests whether the local audio capture device and playback device are working properly. After starting the test, the audio capture device records the local audio, and the audio playback device plays the captured audio. The SDK triggers two independent audioVolumeIndication callbacks at the time interval set in this method, which reports the volume information of the capture device (uid = 0) and the volume information of the playback device (uid = 1) respectively. Ensure that you call this method before joining a channel.
  ///  This method tests local audio devices and does not report the network conditions.
  ///
  /// Param [indicationInterval] The time interval (ms) at which the SDK triggers the audioVolumeIndication callback. Agora recommends a setting greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the callback.
  ///
  ///
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval);

  ///
  /// Stops the audio device loopback test.
  /// Ensure that you call this method before joining a channel.
  ///  Ensure that you call this method to stop the loopback test after calling the startAudioDeviceLoopbackTest method.
  ///
  Future<void> stopAudioDeviceLoopbackTest();

  ///
  /// Enumerates the video devices.
  ///
  ///
  /// **return** Success: Returns a MediaDeviceInfo that contains all the video devices.
  ///  Failure: null.
  ///
  Future<List<MediaDeviceInfo>> enumerateVideoDevices();

  ///
  /// Specifies the video capture device with the device ID.
  /// Plugging or unplugging a device does not change its device ID.
  ///
  /// Param [deviceId] The device ID. You can get the device ID by calling enumerateVideoDevices .
  ///
  ///
  Future<void> setVideoDevice(String deviceId);

  ///
  /// Retrieves the current video capture device.
  ///
  ///
  /// **return** The video capture device.
  ///
  Future<String?> getVideoDevice();

  ///
  /// Sets the audio playback device used by the SDK to follow the system default audio playback device.
  ///
  ///
  /// Param [enable] Whether to follow the system default audio playback device:
  ///  true: Follow. The SDK immediately switches the audio playback device when the system default audio playback device changes.
  ///  false: Do not follow. The SDK switches the audio playback device to the system default audio playback device only when the currently used audio playback device is disconnected.
  ///
  ///
  Future<void> followSystemPlaybackDevice(bool enable);

  ///
  /// Sets the audio recording device used by the SDK to follow the system default audio recording device.
  ///
  ///
  /// Param [enable] Whether to follow the system default audio recording device: true: Follow. The SDK immediately switches the audio recording device when the system default audio recording device changes.
  ///  false: Do not follow. The SDK switches the audio recording device to the system default audio recording device only when the currently used audio recording device is disconnected.
  ///
  ///
  Future<void> followSystemRecordingDevice(bool enable);
}
