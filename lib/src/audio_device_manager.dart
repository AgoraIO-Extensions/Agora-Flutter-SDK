import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';
part 'audio_device_manager.g.dart';

/// Maximum length of device ID.
@JsonEnum(alwaysCreate: true)
enum MaxDeviceIdLengthType {
  /// The maximum length of the device ID is 512 characters.
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

/// Methods for managing audio devices.
abstract class AudioDeviceManager {
  /// Gets a list of all playback devices in the system.
  ///
  /// This method is applicable only to Windows and macOS.
  ///
  /// Returns
  /// If the method call succeeds, returns an array of AudioDeviceInfo containing the device ID and name of all playback devices.
  ///  If the method call fails: returns an empty list.
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices();

  /// Gets the list of all audio recording devices in the system.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// If the method call succeeds, returns an array of AudioDeviceInfo containing the device ID and device name of all audio recording devices.
  ///  If the method call fails: returns an empty list.
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices();

  /// Specifies the playback device.
  ///
  /// This method changes the current audio route but does not change the system default audio route. For example, if the system default audio route is Speaker 1, and you call this method to set the current audio route to Speaker 2 before joining a channel, the SDK will test Speaker 2 during device testing. After testing, when you join the channel, the SDK will still use the system default audio route, i.e., Speaker 1. This method is applicable to Windows and macOS only.
  ///
  /// * [deviceId] Specifies the playback device. Obtained via enumeratePlaybackDevices. Plugging or unplugging devices does not affect deviceId.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setPlaybackDevice(String deviceId);

  /// Gets the current audio playback device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// The current audio playback device.
  Future<String> getPlaybackDevice();

  /// Gets audio playback device information.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// An AudioDeviceInfo object containing the device ID and device name of the audio playback device.
  Future<AudioDeviceInfo> getPlaybackDeviceInfo();

  /// Sets the playback device volume.
  ///
  /// (Windows only)
  ///
  /// * [volume] Playback device volume. Value range: [0,255].
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setPlaybackDeviceVolume(int volume);

  /// Gets the playback device volume.
  ///
  /// Returns
  /// Playback device volume. Value range: [0,255].
  Future<int> getPlaybackDeviceVolume();

  /// Specifies the audio recording device.
  ///
  /// This method allows you to change the current audio recording device without changing the system default audio recording device. Suppose the system default recording device is Microphone 1. If you call this method before joining a channel to set the current audio route to Bluetooth Headset 1, the SDK will test Bluetooth Headset 1 during device testing. After the test, when you join a channel, the SDK will still use the system default recording device, i.e., Microphone 1. (Windows and macOS only)
  ///
  /// * [deviceId] The Device ID of the audio recording device. You can get it through enumerateRecordingDevices. Plugging or unplugging the device does not affect the deviceId.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRecordingDevice(String deviceId);

  /// Gets the current audio recording device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// The current audio recording device.
  Future<String> getRecordingDevice();

  /// Gets information about the audio recording device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// AudioDeviceInfo object containing the device ID and name of the audio recording device.
  Future<AudioDeviceInfo> getRecordingDeviceInfo();

  /// Sets the volume of the audio recording device.
  ///
  /// (Windows and macOS only)
  ///
  /// * [volume] Volume of the audio recording device. Value range: [0,255]. 0 means muted, 255 means maximum volume.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRecordingDeviceVolume(int volume);

  /// Gets the volume of the audio recording device.
  ///
  /// This method is applicable to Windows only.
  ///
  /// Returns
  /// Audio recording device volume. Value range: [0,255].
  Future<int> getRecordingDeviceVolume();

  /// Specifies the sound card capture device.
  ///
  /// By default, the SDK uses the current playback device as the sound card capture device. To specify another audio device as the sound card capture device, call this method and set deviceId to the desired device.
  /// This method changes the current recording device but does not change the system default recording device. For example, if the system default recording device is Microphone 1, and you call this method to set the current audio route to Sound Card 1 before joining a channel, the SDK will test Sound Card 1 during device testing. After testing, when you join the channel, the SDK will still use the system default recording device, i.e., Microphone 1. This method is applicable to Windows and macOS only.
  /// Applicable scenarios:
  /// App A plays music through Bluetooth headset; App B conducts a video conference through speaker.
  ///  If the sound card capture device is set to the Bluetooth headset, the SDK will publish the music from App A to the remote end.
  ///  If the sound card capture device is set to the speaker, the SDK will not publish the music from App A.
  ///  If you switch from Bluetooth headset to wired headset for App A after setting the sound card capture device to Bluetooth headset, you need to call this method again to set the sound card capture device to wired headset, so that the SDK continues publishing App A's music to the remote end.
  ///
  /// * [deviceId] Specifies the SDK's sound card capture device. Obtained via enumeratePlaybackDevices. Plugging or unplugging devices does not affect deviceId.
  /// Maximum length is MaxDeviceIdLengthType.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setLoopbackDevice(String deviceId);

  /// Gets the current sound card capture device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// The ID of the current sound card capture device.
  Future<String> getLoopbackDevice();

  /// Sets the playback device to mute.
  ///
  /// * [mute] Whether to mute the playback device: true : Mute the playback device. false : Do not mute the playback device.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setPlaybackDeviceMute(bool mute);

  /// Gets the mute status of the current playback device.
  ///
  /// Returns
  /// true : The playback device is muted. false : The playback device is not muted.
  Future<bool> getPlaybackDeviceMute();

  /// Mutes the current audio recording device.
  ///
  /// * [mute] Whether to mute the audio recording device: true : Mute the recording device. false : Unmute the recording device.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> setRecordingDeviceMute(bool mute);

  /// Gets the mute status of the current recording device.
  ///
  /// Returns
  /// true : The recording device is muted. false : The recording device is not muted.
  Future<bool> getRecordingDeviceMute();

  /// Starts the audio playback device test.
  ///
  /// This method tests whether the local audio playback device is working properly. After starting the test, the SDK plays the specified audio file. If you can hear the sound, it indicates that the playback device is functioning correctly.
  /// After calling this method, the SDK triggers the onAudioVolumeIndication callback every 100 ms to report the volume information of uid = 1 and the playback device.
  /// The difference between this method and startEchoTest is that this method checks whether the local audio playback device works properly, while the latter checks whether the audio/video devices and network are functioning correctly. You must call this method before joining a channel. After the test is complete, if you want to join a channel, make sure to call stopPlaybackDeviceTest to stop the device test first.
  ///
  /// * [testAudioFilePath] The absolute path of the audio file. The path string must be encoded in UTF-8.
  ///  Supported file formats: wav, mp3, m4a, aac.
  ///  Supported sample rates: 8000, 16000, 32000, 44100, 48000.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startPlaybackDeviceTest(String testAudioFilePath);

  /// Stops the audio playback device test.
  ///
  /// This method stops the audio playback device test. After calling startPlaybackDeviceTest, you must call this method to stop the test. You must call this method before joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopPlaybackDeviceTest();

  /// Starts the audio recording device test.
  ///
  /// This method tests whether the local audio recording device works properly. After you call this method, the SDK triggers the onAudioVolumeIndication callback at the specified time interval to report the volume information of the recording device with uid = 0.
  /// The difference between this method and startEchoTest is that this method checks whether the local audio recording device works properly, while the latter checks whether the audio and video devices and network are functioning properly. You must call this method before joining a channel. After the test is complete, if you want to join a channel, make sure to call stopRecordingDeviceTest to stop the device test.
  ///
  /// * [indicationInterval] The time interval at which the SDK triggers the onAudioVolumeIndication callback, in milliseconds. The minimum value is 10. Otherwise, the onAudioVolumeIndication callback will not be received, and the SDK returns error code -2. Agora recommends setting this value to 100.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  < 0: Method call failed. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  ///  -2: Invalid parameter setting. Please reset the parameter.
  Future<void> startRecordingDeviceTest(int indicationInterval);

  /// Stops the audio recording device test.
  ///
  /// This method stops the audio recording device test. After calling startRecordingDeviceTest, you must call this method to stop the test. You must call this method before joining a channel.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopRecordingDeviceTest();

  /// Starts the audio device loopback test.
  ///
  /// This method tests whether the audio recording and playback devices are working properly. Once the test starts, the recording device captures local audio and the playback device plays it back. The SDK triggers two onAudioVolumeIndication callbacks at the specified interval, reporting the volume information of the recording device (uid = 0) and the playback device (uid = 1).
  ///  (Windows and macOS only)
  ///  Can be called before or after joining a channel.
  ///  Only supported for the broadcaster role.
  ///  This method only tests local audio devices and does not involve network connection.
  ///  After the test is complete, you must call stopAudioDeviceLoopbackTest to stop the loopback test.
  ///
  /// * [indicationInterval] The time interval (in milliseconds) at which the SDK triggers the onAudioVolumeIndication callback. It is recommended to set it greater than 200 ms. It must not be less than 10 ms, otherwise the onAudioVolumeIndication callback will not be received.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval);

  /// Stops the audio device loopback test.
  ///
  /// This method is only applicable to Windows and macOS.
  ///  You can call this method either before or after joining a channel.
  ///  Only the host role is allowed to call this method.
  ///  After calling startAudioDeviceLoopbackTest, you must call this method to stop the audio device loopback test.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> stopAudioDeviceLoopbackTest();

  /// Sets whether the audio playback device used by the SDK follows the system default playback device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// * [enable] Whether to follow the system default audio playback device: true : Follow. When the system default playback device changes, the SDK immediately switches the audio playback device. false : Do not follow. The SDK switches to the system default playback device only when the current audio playback device is removed.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> followSystemPlaybackDevice(bool enable);

  /// Sets whether the audio recording device used by the SDK follows the system default recording device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// * [enable] Whether to follow the system default audio recording device: true : Follow. When the system default recording device changes, the SDK immediately switches the recording device. false : Do not follow. The SDK switches to the system default recording device only when the current recording device is removed.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> followSystemRecordingDevice(bool enable);

  /// Sets whether the loopback recording device follows the system default playback device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// * [enable] Whether to follow the system default playback device: true : Follow. When the system default playback device changes, the SDK immediately switches the loopback recording device. false : Do not follow. The SDK switches to the system default playback device only when the current loopback recording device is removed.
  ///
  /// Returns
  /// When the method call succeeds, there is no return value; when fails, the AgoraRtcException exception is thrown. You need to catch the exception and handle it accordingly. See [Error Codes](https://docs.agora.io/en/video-calling/troubleshooting/error-codes) for details and resolution suggestions.
  Future<void> followSystemLoopbackDevice(bool enable);

  /// Releases all resources used by the AudioDeviceManager object.
  Future<void> release();

  /// Gets the system default audio playback device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// Information about the default audio playback device. See AudioDeviceInfo.
  Future<AudioDeviceInfo> getPlaybackDefaultDevice();

  /// Gets the system default audio recording device.
  ///
  /// This method is applicable to Windows and macOS only.
  ///
  /// Returns
  /// Information about the default audio recording device. See AudioDeviceInfo.
  Future<AudioDeviceInfo> getRecordingDefaultDevice();
}
