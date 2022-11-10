import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'audio_device_manager.g.dart';

/// The maximum length of the device ID.
///
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
///
abstract class AudioDeviceManager {
  /// Enumerates the audio playback devices.
  ///
  ///
  /// Returns
  /// Success: Returns an AudioDeviceInfo array, which includes all the audio playback devices.Failure: An empty array.
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices();

  /// Enumerates the audio capture devices.
  ///
  ///
  /// Returns
  /// Success: An AudioDeviceInfo array, which includes all the audio capture devices.Failure: An empty array.
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices();

  /// Sets the audio playback device.
  ///
  ///
  /// * [deviceId] The ID of the specified audio playback device. You can get the device ID by calling enumeratePlaybackDevices . Connecting or disconnecting the audio device does not change the value of deviceId.
  Future<void> setPlaybackDevice(String deviceId);

  /// Retrieves the audio playback device associated with the device ID.
  ///
  ///
  /// Returns
  /// The current audio playback device.
  Future<String> getPlaybackDevice();

  /// Retrieves the audio playback device associated with the device ID.
  ///
  ///
  /// Returns
  /// An AudioDeviceInfo object, which contains the ID and device name of the audio devices.
  Future<AudioDeviceInfo> getPlaybackDeviceInfo();

  /// @nodoc
  Future<void> setPlaybackDeviceVolume(int volume);

  /// @nodoc
  Future<int> getPlaybackDeviceVolume();

  /// Sets the audio recording device.
  ///
  ///
  /// * [deviceId] The ID of the audio recording device. You can get the device ID by calling enumerateRecordingDevices . Plugging or unplugging the audio device does not change the value of deviceId.
  Future<void> setRecordingDevice(String deviceId);

  /// Gets the current audio recording device.
  ///
  ///
  /// Returns
  /// The current audio recording device.
  Future<String> getRecordingDevice();

  /// Retrieves the volume of the audio recording device.
  ///
  ///
  /// Returns
  /// An AudioDeviceInfo object, which includes the device ID and device name.
  Future<AudioDeviceInfo> getRecordingDeviceInfo();

  /// Sets the volume of the audio recording device.
  ///
  ///
  /// * [volume]  The volume of the audio recording device. The value range is [0,255].
  Future<void> setRecordingDeviceVolume(int volume);

  /// @nodoc
  Future<int> getRecordingDeviceVolume();

  /// 指定声卡采集设备。
  /// SDK 默认采用当前的播放设备作为声卡采集设备，如果想要指定其他音频设备作为声卡采集设备，则调用该方法并设置 deviceId 为你想要指定的声卡采集设备。该方法适用的场景如下： 使用 app A 播放音乐，通过蓝牙耳机播放；同时使用 app B 进行视频会议，通过扬声器播放。 如果设置声卡采集设备为蓝牙耳机，则 SDK 会将 app A 中的音乐发布到远端。如果设置声卡采集设备设置为扬声器，则 SDK 不会将 app A 中的音乐发布到远端。如果设置声卡采集设备为蓝牙耳机后，又改用有线耳机播放 app A 中的音乐，则需要重新调用该方法，设置声卡采集设备为有线耳机，则 SDK 会继续将 app A 中的音乐发布到远端。
  ///
  /// * [deviceId] 指定 SDK 的声卡采集设备。由 enumeratePlaybackDevices 获取。插拔设备不会影响 deviceId。
  ///
  /// Returns
  /// 0: 方法调用成功。< 0: 方法调用失败。
  Future<void> setLoopbackDevice(String deviceId);

  /// 获取当前的声卡采集设备。
  ///
  ///
  /// * [deviceId] 输出参数，当前声卡采集设备的 ID。最大长度为 MaxDeviceIdLengthType 。
  ///
  /// Returns
  /// 0: 方法调用成功。< 0: 方法调用失败。
  Future<String> getLoopbackDevice();

  /// @nodoc
  Future<void> setPlaybackDeviceMute(bool mute);

  /// @nodoc
  Future<bool> getPlaybackDeviceMute();

  /// @nodoc
  Future<void> setRecordingDeviceMute(bool mute);

  /// @nodoc
  Future<bool> getRecordingDeviceMute();

  /// Starts the audio playback device test.
  /// This method tests whether the audio playback device works properly. Once a user starts the test, the SDK plays an audio file specified by the user. If the user can hear the audio, the playback device works properly.After calling this method, the SDK triggers the onAudioVolumeIndication callback every 100 ms, reporting uid = 1 and the volume information of the playback device.Ensure that you call this method before joining a channel.
  ///
  /// * [testAudioFilePath] The path of the audio file. The data format is string in UTF-8.Supported file formats: wav, mp3, m4a, and aac.Supported file sample rates: 8000, 16000, 32000, 44100, and 48000 Hz.
  Future<void> startPlaybackDeviceTest(String testAudioFilePath);

  /// Stops the audio playback device test.
  /// This method stops the audio playback device test. You must call this method to stop the test after calling the startPlaybackDeviceTest method.Ensure that you call this method before joining a channel.
  Future<void> stopPlaybackDeviceTest();

  /// Starts the audio capture device test.
  /// This method tests whether the audio capture device works properly. After calling this method, the SDK triggers the onAudioVolumeIndication callback at the time interval set in this method, which reports uid = 0 and the volume information of the capturing device.Ensure that you call this method before joining a channel.
  ///
  /// * [indicationInterval] The time interval (ms) at which the SDK triggers the onAudioVolumeIndication callback. Agora recommends a setting greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the onAudioVolumeIndication callback.
  Future<void> startRecordingDeviceTest(int indicationInterval);

  /// Stops the audio capture device test.
  /// This method stops the audio capture device test. You must call this method to stop the test after calling the startRecordingDeviceTest method.Ensure that you call this method before joining a channel.
  Future<void> stopRecordingDeviceTest();

  /// Starts an audio device loopback test.
  /// This method tests whether the local audio capture device and playback device are working properly. Once the test starts, the audio recording device records the local audio, and the audio playback device plays the captured audio. The SDK triggers two independent onAudioVolumeIndication callbacks at the time interval set in this method, which reports the volume information of the capture device (uid = 0) and the volume information of the playback device (uid = 1) respectively.Ensure that you call this method before joining a channel.This method tests local audio devices and does not report the network conditions.
  ///
  /// * [indicationInterval] The time interval (ms) at which the SDK triggers the onAudioVolumeIndication callback. Agora recommends setting a value greater than 200 ms. This value must not be less than 10 ms; otherwise, you can not receive the onAudioVolumeIndication callback.
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval);

  /// Stops the audio device loopback test.
  /// Ensure that you call this method before joining a channel.Ensure that you call this method to stop the loopback test after calling the startAudioDeviceLoopbackTest method.
  Future<void> stopAudioDeviceLoopbackTest();

  /// Sets the audio playback device used by the SDK to follow the system default audio playback device.
  ///
  ///
  /// * [enable] Whether to follow the system default audio playback device:true: Follow. The SDK immediately switches the audio playback device when the system default audio playback device changes.false: Do not follow. The SDK switches the audio playback device to the system default audio playback device only when the currently used audio playback device is disconnected.
  Future<void> followSystemPlaybackDevice(bool enable);

  /// Sets the audio recording device used by the SDK to follow the system default audio recording device.
  ///
  ///
  /// * [enable] Whether to follow the system default audio recording device:true: Follow. The SDK immediately switches the audio recording device when the system default audio recording device changes.false: Do not follow. The SDK switches the audio recording device to the system default audio recording device only when the currently used audio recording device is disconnected.
  Future<void> followSystemRecordingDevice(bool enable);

  /// 设置声卡采集设备是否跟随系统默认的播放设备。
  ///
  ///
  /// * [enable] 是否跟随系统默认的播放设备： true：跟随。当系统默认播放设备发生改变时，SDK 立即跟随切换声卡采集设备。false：不跟随。只有当 SDK 使用的声卡采集设备被移除后，SDK 才切换至系统默认的音频播放设备。
  Future<void> followSystemLoopbackDevice(bool enable);

  /// Releases all the resources occupied by the AudioDeviceManager object.
  ///
  Future<void> release();

  /// @nodoc
  Future<AudioDeviceInfo> getPlaybackDefaultDevice();

  /// @nodoc
  Future<AudioDeviceInfo> getRecordingDefaultDevice();
}
