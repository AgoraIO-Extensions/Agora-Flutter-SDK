import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'audio_device_manager.g.dart';

/// 设备 ID 的最大长度。
///
@JsonEnum(alwaysCreate: true)
enum MaxDeviceIdLengthType {
  /// 设备 ID 的最大长度为 512 个字符。
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

/// 音频设备管理方法。
///
abstract class AudioDeviceManager {
  /// 获取系统中所有的播放设备列表。
  ///
  ///
  /// Returns
  /// 方法调用成功，返回 AudioDeviceInfo 数组，包含所有音频播放设备的设备 ID 和设备名称。方法调用失败: 返回空列表。
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices();

  /// 获取系统中所有的音频采集设备列表。
  ///
  ///
  /// Returns
  /// 方法调用成功，返回一个 AudioDeviceInfo 数组，包含所有音频采集设备的设备 ID 和设备名称。方法调用失败: 返回空列表。
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices();

  /// 指定播放设备。
  ///
  ///
  /// * [deviceId] 通过 deviceID 指定播放设备。由 enumeratePlaybackDevices 获取。插拔设备不会影响 deviceId。
  Future<void> setPlaybackDevice(String deviceId);

  /// 获取当前音频播放设备。
  ///
  ///
  /// Returns
  /// 当前音频播放设备。
  Future<String> getPlaybackDevice();

  /// 获取音频播放设备信息。
  ///
  ///
  /// Returns
  /// AudioDeviceInfo 对象，包含音频播放设备的设备 ID 和设备名称。
  Future<AudioDeviceInfo> getPlaybackDeviceInfo();

  /// @nodoc
  Future<void> setPlaybackDeviceVolume(int volume);

  /// @nodoc
  Future<int> getPlaybackDeviceVolume();

  /// 指定音频采集设备。
  ///
  ///
  /// * [deviceId] 音频采集设备的 Device ID。可通过 enumerateRecordingDevices 获取。插拔设备不会影响 deviceId。
  Future<void> setRecordingDevice(String deviceId);

  /// 获取当前音频采集设备。
  ///
  ///
  /// Returns
  /// 当前音频采集设备。
  Future<String> getRecordingDevice();

  /// 获取音频采集设备信息。
  ///
  ///
  /// Returns
  /// AudioDeviceInfo 对象，包含音频采集设备的设备 ID 和设备名称。
  Future<AudioDeviceInfo> getRecordingDeviceInfo();

  /// @nodoc
  Future<void> setRecordingDeviceVolume(int volume);

  /// @nodoc
  Future<int> getRecordingDeviceVolume();

  /// @nodoc
  Future<void> setPlaybackDeviceMute(bool mute);

  /// @nodoc
  Future<bool> getPlaybackDeviceMute();

  /// @nodoc
  Future<void> setRecordingDeviceMute(bool mute);

  /// @nodoc
  Future<bool> getRecordingDeviceMute();

  /// 启动音频播放设备测试。
  /// 该方法测试音频播放设备是否能正常工作。启动测试后，SDK 播放指定的音频文件，测试者如果能听到声音，说明播放设备能正常工作。调用该方法后，SDK 会每隔 100 ms 触发一次 onAudioVolumeIndication 回调，报告 uid = 1 及播放设备的音量信息。该方法需要在加入频道前调用。
  ///
  /// * [testAudioFilePath] 音频文件的绝对路径，路径字符串使用 UTF-8 编码格式。
  ///  支持文件格式: wav、mp3、m4a、aac。支持文件采样率: 8000、16000、32000、44100、48000。
  Future<void> startPlaybackDeviceTest(String testAudioFilePath);

  /// 停止音频播放设备测试。
  /// 该方法停止音频播放设备测试。调用 startPlaybackDeviceTest 后，必须调用该方法停止测试。该方法需要在加入频道前调用。
  Future<void> stopPlaybackDeviceTest();

  /// 启动音频采集设备测试。
  /// 该方法测试音频采集设备是否能正常工作。调用该方法后，SDK 会按设置的时间间隔触发 onAudioVolumeIndication 回调，报告 uid = 0 及采集设备的音量信息。该方法需要在加入频道前调用。
  ///
  /// * [indicationInterval] SDK 触发 onAudioVolumeIndication 回调的时间间隔，单位为毫秒。建议设置到大于 200 毫秒。不得小于 10 毫秒，否则会收不到 onAudioVolumeIndication 回调。
  Future<void> startRecordingDeviceTest(int indicationInterval);

  /// 停止音频采集设备测试。
  /// 该方法停止音频采集设备测试。调用 startRecordingDeviceTest 后，必须调用该方法停止测试。该方法需要在加入频道前调用。
  Future<void> stopRecordingDeviceTest();

  /// 开始音频设备回路测试。
  /// 该方法测试音频采集和播放设备是否能正常工作。一旦测试开始，音频采集设备会采集本地音频，然后使用音频播放设备播放出来。SDK 会按设置的时间间隔触发两个 onAudioVolumeIndication 回调，分别报告音频采集设备（uid = 0）和音频播放设置（uid = 1）的音量信息。该方法需要在加入频道前调用。该方法仅在本地进行音频设备测试，不涉及网络连接。
  ///
  /// * [indicationInterval] SDK 触发 onAudioVolumeIndication 回调的时间间隔，单位为毫秒。建议设置到大于 200 毫秒。不得少于 10 毫秒，否则会收不到 onAudioVolumeIndication 回调。
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval);

  /// 停止音频设备回路测试。
  /// 该方法需要在加入频道前调用。在调用 startAudioDeviceLoopbackTest 后，必须调用该方法停止音频设备回路测试。
  Future<void> stopAudioDeviceLoopbackTest();

  /// 设置 SDK 使用的音频播放设备跟随系统默认的音频播放设备。
  ///
  ///
  /// * [enable] 是否跟随系统默认的音频播放设备： true：跟随。当系统默认音频播放设备发生改变时，SDK 立即切换音频播放设备。false：不跟随。只有当 SDK 使用的音频播放设备被移除后，SDK 才切换至系统默认的音频播放设备。
  Future<void> followSystemPlaybackDevice(bool enable);

  /// 设置 SDK 使用的音频采集设备跟随系统默认的音频采集设备。
  ///
  ///
  /// * [enable] 是否跟随系统默认的音频采集设备：
  ///  true：跟随。当系统默认的音频采集设备改变时，SDK 立即切换音频采集设备。false：不跟随。只有当 SDK 使用的音频采集设备被移除后，SDK 才切换至系统默认的音频采集设备。
  Future<void> followSystemRecordingDevice(bool enable);

  /// 释放 AudioDeviceManager 对象占用的所有资源。
  ///
  Future<void> release();
}
