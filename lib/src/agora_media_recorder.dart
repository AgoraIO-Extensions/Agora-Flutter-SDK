import 'package:agora_rtc_engine/src/binding_forward_export.dart';

/// 用于在客户端录制音视频流。
/// 该类支持录制以下内容：本地麦克风采集且经 SDK 编码为 AAC 格式的音频。本地摄像头采集且经 SDK 编码的视频。
abstract class MediaRecorder {
  /// 注册 MediaRecorderObserver 对象。
  /// 该方法需要在初始化 RtcEngine 对象后调用。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [callback] 本地音视频流录制回调，详见 MediaRecorderObserver 。
  Future<void> setMediaRecorderObserver(
      {required RtcConnection connection,
      required MediaRecorderObserver callback});

  /// 开启本地音视频流录制。
  /// 调用 getMediaRecorder 方法获取 MediaRecorder 对象后，你可以调用该方法开启本地音视频流录制。该方法录制的是本地麦克风采集的、编码为 AAC 格式的音频或本地摄像头采集的、编码为 H.264 格式的视频。只有当检测到可录制的音视频流时，才能成功生成录制文件；当没有可录制的音视频或录制中的音视频流中断超过 5 秒后，SDK 会停止录制，并触发onRecorderStateChanged(recorderStateError,recorderErrorNoStream) 回调。开启本地音视频流录制后，当视频分辨率在录制过程中发生变化时，SDK 会停止录制；当音频采样率和声道数发生变化时，SDK 会持续录制并生成单个 MP4 录制文件。该方法需要在加入频道后调用。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [config] 音视频流录制配置。详见 MediaRecorderConfiguration 。
  ///
  /// Returns
  /// 0: 方法调用成功。< 0: 方法调用失败。2: 参数无效。请确保：指定的录制文件保存路径正确且可写。指定的录制文件格式正确。设置的最大录制时长正确。4: RtcEngine 当前状态不支持该操作。可能因为录制正在进行中或录制出错停止。7: RtcEngine 尚未初始化就调用方法。
  Future<void> startRecording(
      {required RtcConnection connection,
      required MediaRecorderConfiguration config});

  /// 停止本地音视频流录制。
  /// 调用 startRecording 后，如果要停止录制，必须调用该方法停止录制；否则，生成的录制文件可能无法正常播放。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  ///
  /// Returns
  /// 0(ERR_OK): 方法调用成功< 0: 方法调用失败：-7: RtcEngine 尚未初始化就调用方法。
  Future<void> stopRecording(RtcConnection connection);

  /// @nodoc
  Future<void> release();
}
