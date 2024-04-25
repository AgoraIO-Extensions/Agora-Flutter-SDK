import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'audio_device_manager.g.dart';

/// The maximum length of the device ID.
@JsonEnum(alwaysCreate: true)
enum MaxDeviceIdLengthType {
  /// The maximum length of the device ID is 512 bytes.
  @JsonValue(512)
  maxDeviceIdLength,
}

/// @nodoc
extension MaxDeviceIdLengthTypeExt on MaxDeviceIdLengthType {
  /// @nodoc
  static MaxDeviceIdLengthType fromValue(int value) {
    return $enumDecode(_$MaxDeviceIdLengthTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$MaxDeviceIdLengthTypeEnumMap[this]!;
  }
}

/// Audio device management methods.
abstract class AudioDeviceManager {
  /// Enumerates the audio playback devices.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// Success: Returns an AudioDeviceInfo array, which includes all the audio playback devices.
  ///  Failure: An empty array.
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices();

  /// Enumerates the audio capture devices.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// Success: An AudioDeviceInfo array, which includes all the audio capture devices.
  ///  Failure: An empty array.
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices();

  /// Sets the audio playback device.
  ///
  /// This method is for Windows and macOS only. You can call this method to change the audio route currently being used, but this does not change the default audio route. For example, if the default audio route is speaker 1, you call this method to set the audio route as speaker 2 before joinging a channel and then start a device test, the SDK conducts device test on speaker 2. After the device test is completed and you join a channel, the SDK still uses speaker 1, the default audio route.
  ///
  /// * [deviceId] The ID of the specified audio playback device. You can get the device ID by calling enumeratePlaybackDevices. Connecting or disconnecting the audio device does not change the value of deviceId.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setPlaybackDevice(String deviceId);

  /// Retrieves the audio playback device associated with the device ID.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// The current audio playback device.
  Future<String> getPlaybackDevice();

  /// Retrieves the information of the audio playback device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// An AudioDeviceInfo object, which contains the ID and device name of the audio devices.
  Future<AudioDeviceInfo> getPlaybackDeviceInfo();

  /// Sets the volume of the audio playback device.
  ///
  /// This method applies to Windows only.
  ///
  /// * [volume] The volume of the audio playback device. The value range is [0,255].
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setPlaybackDeviceVolume(int volume);

  /// Retrieves the volume of the audio playback device.
  ///
  /// Returns
  /// The volume of the audio playback device. The value range is [0,255].
  Future<int> getPlaybackDeviceVolume();

  /// Sets the audio capture device.
  ///
  /// This method is for Windows and macOS only. You can call this method to change the audio route currently being used, but this does not change the default audio route. For example, if the default audio route is microphone, you call this method to set the audio route as bluetooth earphones before joinging a channel and then start a device test, the SDK conducts device test on the bluetooth earphones. After the device test is completed and you join a channel, the SDK still uses the microphone for audio capturing.
  ///
  /// * [deviceId] The ID of the audio capture device. You can get the Device ID by calling enumerateRecordingDevices. Connecting or disconnecting the audio device does not change the value of deviceId.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRecordingDevice(String deviceId);

  /// Gets the current audio recording device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// The current audio recording device.
  Future<String> getRecordingDevice();

  /// Retrieves the information of the audio recording device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// An AudioDeviceInfo object, which includes the device ID and device name.
  Future<AudioDeviceInfo> getRecordingDeviceInfo();

  /// Sets the volume of the audio capture device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// * [volume] The volume of the audio recording device. The value range is [0,255]. 0 means no sound, 255 means maximum volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setRecordingDeviceVolume(int volume);

  /// Retrieves the volume of the audio recording device.
  ///
  /// This method applies to Windows only.
  ///
  /// Returns
  /// The volume of the audio recording device. The value range is [0,255].
  Future<int> getRecordingDeviceVolume();

  /// Sets the loopback device.
  ///
  /// The SDK uses the current playback device as the loopback device by default. If you want to specify another audio device as the loopback device, call this method, and set deviceId to the loopback device you want to specify. You can call this method to change the audio route currently being used, but this does not change the default audio route. For example, if the default audio route is microphone, you call this method to set the audio route as a sound card before joinging a channel and then start a device test, the SDK conducts device test on the sound card. After the device test is completed and you join a channel, the SDK still uses the microphone for audio capturing. This method is for Windows and macOS only. The scenarios where this method is applicable are as follows: Use app A to play music through a Bluetooth headset; when using app B for a video conference, play through the speakers.
  ///  If the loopback device is set as the Bluetooth headset, the SDK publishes the music in app A to the remote end.
  ///  If the loopback device is set as the speaker, the SDK does not publish the music in app A to the remote end.
  ///  If you set the loopback device as the Bluetooth headset, and then use a wired headset to play the music in app A, you need to call this method again, set the loopback device as the wired headset, and the SDK continues to publish the music in app A to remote end.
  ///
  /// * [deviceId] Specifies the loopback device of the SDK. You can get the device ID by calling enumeratePlaybackDevices. Connecting or disconnecting the audio device does not change the value of deviceId. The maximum length is MaxDeviceIdLengthType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setLoopbackDevice(String deviceId);

  /// Gets the current loopback device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// The ID of the current loopback device.
  Future<String> getLoopbackDevice();

  /// Mutes the audio playback device.
  ///
  /// * [mute] Whether to mute the audio playback device: true : Mute the audio playback device. false : Unmute the audio playback device.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> setPlaybackDeviceMute(bool mute);

  /// Retrieves whether the audio playback device is muted.
  ///
  /// Returns
  /// true : The audio playback device is muted. false : The audio playback device is unmuted.
  Future<bool> getPlaybackDeviceMute();

  /// @nodoc
  Future<void> setRecordingDeviceMute(bool mute);

  /// @nodoc
  Future<bool> getRecordingDeviceMute();

  /// Starts the audio playback device test.
  ///
  /// This method tests whether the audio device for local playback works properly. Once a user starts the test, the SDK plays an audio file specified by the user. If the user can hear the audio, the playback device works properly. After calling this method, the SDK triggers the onAudioVolumeIndication callback every 100 ms, reporting uid = 1 and the volume information of the playback device. The difference between this method and the startEchoTest method is that the former checks if the local audio playback device is working properly, while the latter can check the audio and video devices and network conditions. Ensure that you call this method before joining a channel. After the test is completed, call stopPlaybackDeviceTest to stop the test before joining a channel.
  ///
  /// * [testAudioFilePath] The path of the audio file. The data format is string in UTF-8.
  ///  Supported file formats: wav, mp3, m4a, and aac.
  ///  Supported file sample rates: 8000, 16000, 32000, 44100, and 48000 Hz.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startPlaybackDeviceTest(String testAudioFilePath);

  /// Stops the audio playback device test.
  ///
  /// This method stops the audio playback device test. You must call this method to stop the test after calling the startPlaybackDeviceTest method. Ensure that you call this method before joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopPlaybackDeviceTest();

  /// Starts the audio capturing device test.
  ///
  /// This method tests whether the audio capturing device works properly. After calling this method, the SDK triggers the onAudioVolumeIndication callback at the time interval set in this method, which reports uid = 0 and the volume information of the capturing device. The difference between this method and the startEchoTest method is that the former checks if the local audio capturing device is working properly, while the latter can check the audio and video devices and network conditions. Ensure that you call this method before joining a channel. After the test is completed, call stopRecordingDeviceTest to stop the test before joining a channel.
  ///
  /// * [indicationInterval] The interval (ms) for triggering the onAudioVolumeIndication callback. This value should be set to greater than 10, otherwise, you will not receive the onAudioVolumeIndication callback and the SDK returns the error code -2. Agora recommends that you set this value to 100.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  ///  < 0: Failure.
  ///  -2: Invalid parameters. Check your parameter settings.
  Future<void> startRecordingDeviceTest(int indicationInterval);

  /// Stops the audio capturing device test.
  ///
  /// This method stops the audio capturing device test. You must call this method to stop the test after calling the startRecordingDeviceTest method. Ensure that you call this method before joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopRecordingDeviceTest();

  /// Starts an audio device loopback test.
  ///
  /// This method tests whether the local audio capture device and playback device are working properly. After starting the test, the audio capture device records the local audio, and the audio playback device plays the captured audio. The SDK triggers two independent onAudioVolumeIndication callbacks at the time interval set in this method, which reports the volume information of the capture device (uid = 0) and the volume information of the playback device (uid = 1) respectively.
  ///  This method is for Windows and macOS only.
  ///  You can call this method either before or after joining a channel.
  ///  This method only takes effect when called by the host.
  ///  This method tests local audio devices and does not report the network conditions.
  ///  When you finished testing, call stopAudioDeviceLoopbackTest to stop the audio device loopback test.
  ///
  /// * [indicationInterval] The time interval (ms) at which the SDK triggers the onAudioVolumeIndication callback. Agora recommends setting a value greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the onAudioVolumeIndication callback.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval);

  /// Stops the audio device loopback test.
  ///
  /// This method is for Windows and macOS only.
  ///  You can call this method either before or after joining a channel.
  ///  This method only takes effect when called by the host.
  ///  Ensure that you call this method to stop the loopback test after calling the startAudioDeviceLoopbackTest method.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> stopAudioDeviceLoopbackTest();

  /// Sets the audio playback device used by the SDK to follow the system default audio playback device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// * [enable] Whether to follow the system default audio playback device: true : Follow the system default audio playback device. The SDK immediately switches the audio playback device when the system default audio playback device changes. false : Do not follow the system default audio playback device. The SDK switches the audio playback device to the system default audio playback device only when the currently used audio playback device is disconnected.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> followSystemPlaybackDevice(bool enable);

  /// Sets the audio recording device used by the SDK to follow the system default audio recording device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// * [enable] Whether to follow the system default audio recording device: true : Follow the system default audio playback device. The SDK immediately switches the audio recording device when the system default audio recording device changes. false : Do not follow the system default audio playback device. The SDK switches the audio recording device to the system default audio recording device only when the currently used audio recording device is disconnected.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> followSystemRecordingDevice(bool enable);

  /// Sets whether the loopback device follows the system default playback device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// * [enable] Whether to follow the system default audio playback device: true : Follow the system default audio playback device. When the default playback device of the system is changed, the SDK immediately switches to the loopback device. false : Do not follow the system default audio playback device. The SDK switches the audio loopback device to the system default audio playback device only when the current audio playback device is disconnected.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly.
  Future<void> followSystemLoopbackDevice(bool enable);

  /// Releases all the resources occupied by the AudioDeviceManager object.
  Future<void> release();

  /// Gets the default audio playback device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// The details about the default audio playback device. See AudioDeviceInfo.
  Future<AudioDeviceInfo> getPlaybackDefaultDevice();

  /// Gets the default audio capture device.
  ///
  /// This method is for Windows and macOS only.
  ///
  /// Returns
  /// The details about the default audio capture device. See AudioDeviceInfo.
  Future<AudioDeviceInfo> getRecordingDefaultDevice();
}
