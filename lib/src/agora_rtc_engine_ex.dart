import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rtc_engine_ex.g.dart';

/// 包含连接信息的类。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RtcConnection {
  /// @nodoc
  const RtcConnection({this.channelId, this.localUid});

  /// 频道名。
  @JsonKey(name: 'channelId')
  final String? channelId;

  /// 本地用户 ID。
  @JsonKey(name: 'localUid')
  final int? localUid;

  /// @nodoc
  factory RtcConnection.fromJson(Map<String, dynamic> json) =>
      _$RtcConnectionFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcConnectionToJson(this);
}

/// 提供多频道方法的接口类。
/// 继承自 RtcEngine 。
abstract class RtcEngineEx implements RtcEngine {
  /// 使用连接 ID 加入频道。
  /// 调用该方法，你可以同时加入多个频道。如果你已经在一个频道内，你不能用相同的用户 UID 再次加入该频道。如果你想在不同的设备上加入相同的频道，请确保你在不同设备上使用的用户 UID 都不同。请确保生成 Token 时传入的 app ID 和创建 RtcEngine 实例时传入的 app ID 一致。
  ///
  /// * [options] 频道媒体设置选项。详见 ChannelMediaOptions 。
  /// * [token] 在服务端生成的用于鉴权的动态密钥。详见。
  ///
  Future<void> joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options});

  /// 离开频道。
  ///
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  Future<void> leaveChannelEx(RtcConnection connection);

  /// 加入频道后更新频道媒体选项 。
  ///
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [options] 频道媒体选项，详见 ChannelMediaOptions 。
  Future<void> updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection});

  /// 设置本地视频编码属性。
  /// 每一种视频编码属性对应一系列视频相关参数设置，包含分辨率、帧率和码率。该方法的 config 参数设置是在理想网络状态下能达到的最大值。如果网络状态不好，视频引擎便不能使用该
  ///  config 渲染本地视频， 它会自动降低到一个合适的视频参数设置。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [config] 视频编码参数配置。详见 VideoEncoderConfiguration 。
  ///
  /// Returns
  /// 0: 方法调用成功。< 0: 方法调用失败。
  Future<void> setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection});

  /// 初始化远端用户视图。
  /// 该方法绑定远端用户和显示视图，并设置远端用户视图在本地显示时的渲染模式和镜像模式，只影响本地用户看到的视频画面。调用该方法时需要在 VideoCanvas 中指定远端视频的用户 ID，一般可以在进频道前提前设置好。如果无法在加入频道前得到远端用户的 uid，可以在收到 onUserJoined 回调时调用该方法。如果启用了视频录制功能，视频录制服务会做为一个哑客户端加入频道，因此其他客户端也会收到它的 onUserJoined 事件， App 不应给它绑定视图（因为它不会发送视频流）。如需解除某个远端用户的绑定视图，可以调用该方法并将 view 设置为空。离开频道后，SDK 会清除远端用户视图的绑定关系。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [canvas] 视频画布信息。详见 VideoCanvas 。
  Future<void> setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection});

  /// 停止/恢复接收指定的音频流。
  /// 该方法停止/恢复接收某一个指定远端用户的音频流。在加入频道前或后都可以调用。该方法的设置在离开频道后失效。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uid] 指定用户的 ID。
  /// * [mute] 是否停止接收指定音频流：true: 停止接收指定音频流。false:（默认）继续接收指定音频流。
  ///
  /// Returns
  /// 0: 方法调用成功 < 0: 方法调用失败
  Future<void> muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// 停止/恢复接收指定的视频流。
  /// 该方法停止/恢复接收某一个指定远端用户的视频流。在加入频道前或后都可以调用。该方法的设置在离开频道后失效。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uid] 远端用户的 ID。
  /// * [mute] 是否停止接收某个远端用户的视频： true: 停止接收。false: （默认）恢复接收。
  ///
  /// Returns
  /// 0：方法调用成功。< 0：方法调用失败。
  Future<void> muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection});

  /// 设置音频订阅黑名单。
  /// 你可以调用该方法指定不订阅的音频流。该方法在加入频道前后均可调用。音频订阅黑名单不受 muteRemoteAudioStream 、 muteAllRemoteAudioStreams 以及 ChannelMediaOptions 中的 autoSubscribeAudio 影响。设置订阅黑名单后，如果离开当前频道后再重新加入频道，黑名单依然生效。如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uidNumber] 黑名单用户 ID 列表中的用户数量。
  /// * [uidList] 订阅黑名单的用户 ID 列表。如果你想指定不订阅某一发流用户的音频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅黑名单中移除，需要重新调用 setSubscribeAudioBlacklist 方法更新订阅黑名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  Future<void> setSubscribeAudioBlacklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// 设置音频订阅白名单。
  /// 你可以调用该方法指定想要订阅的音频流。 如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。该方法在加入频道前后均可调用。音频订阅白名单不受 muteRemoteAudioStream 、 muteAllRemoteAudioStreams 以及 ChannelMediaOptions 中的 autoSubscribeAudio 的影响。
  ///  设置订阅白名单后，如果离开当前频道后再重新加入频道，白名单依然生效。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uidNumber] 白名单用户 ID 列表中的用户数量。
  /// * [uidList] 音频订阅白名单的用户 ID 列表。
  ///  如果你想指定订阅某一发流用户的音频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅白名单中移除，需要重新调用 setSubscribeAudioWhitelist 方法更新音频订阅白名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  ///
  Future<void> setSubscribeAudioWhitelistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// 设置视频订阅黑名单。
  /// 你可以调用该方法指定不订阅的视频流。 如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。设置订阅黑名单后，如果离开当前频道后再重新加入频道，黑名单依然生效。该方法在加入频道前后均可调用。视频订阅黑名单不受 muteRemoteVideoStream 、 muteAllRemoteVideoStreams 以及 ChannelMediaOptions 中的 autoSubscribeVideo 的影响。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uidNumber] 黑名单用户 ID 列表中的用户数量。
  /// * [uidList] 视频订阅黑名单的用户 ID 列表。
  ///  如果你想指定不订阅某一发流用户的视频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅黑名单中移除，需要重新调用 setSubscribeVideoBlacklist 方法更新订阅黑名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  ///
  Future<void> setSubscribeVideoBlacklistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// 设置视频订阅白名单。
  /// 你可以调用该方法指定想要订阅的视频流。 如果某个用户同时在音频订阅黑名单和白名单中，仅订阅黑名单生效。设置订阅白名单后，如果离开当前频道后再重新加入频道，白名单依然生效。
  ///  该方法在加入频道前后均可调用。视频订阅白名单不受 muteRemoteVideoStream 、 muteAllRemoteVideoStreams 以及 ChannelMediaOptions 中的 autoSubscribeVideo 的影响。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uidNumber] 白名单用户 ID 列表中的用户数量。
  /// * [uidList] 视频订阅白名单的用户 ID 列表。
  ///  如果你想指定仅订阅某一发流用户的视频流，将该用户的 ID 加入此列表中。如果你想要将某一用户从订阅白名单中移除，需要重新调用 setSubscribeVideoWhitelist 方法更新音频订阅白名单的用户 ID 列表，使其不包含你想移除的用户的 uid。
  ///
  Future<void> setSubscribeVideoWhitelistEx(
      {required List<int> uidList,
      required int uidNumber,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setRemoteVideoSubscriptionOptionsEx(
      {required int uid,
      required VideoSubscriptionOptions options,
      required RtcConnection connection});

  /// 设置远端用户声音的 2D 位置，即水平面位置。
  /// 设置远端用户声音的空间位置和音量，方便本地用户听声辨位。通过调用该接口设置远端用户声音出现的位置，左右声道的声音差异会产生声音的方位感，从而判断出远端用户的实时位置。在多人在线游戏场景，如吃鸡游戏中，该方法能有效增加游戏角色的方位感，模拟真实场景。为获得最佳听觉体验，我们建议用户佩戴有线耳机。该方法需要在加入频道后调用。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [uid] 远端用户的 ID。
  /// * [pan] 设置远端用户声音的空间位置，取值范围为 [-1.0,1.0]:
  ///  -1.0: 声音出现在左边。(默认）0.0: 声音出现在正前方。1.0: 声音出现在右边。
  /// * [gain] 设置远端用户声音的音量，取值范围为 [0.0,100.0]，默认值为 100.0，表示该用户的原始音量。取值越小，则音量越低。
  ///
  /// Returns
  /// 0: 方法调用成功< 0: 方法调用失败
  Future<void> setRemoteVoicePositionEx(
      {required int uid,
      required double pan,
      required double gain,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setRemoteUserSpatialAudioParamsEx(
      {required int uid,
      required SpatialAudioParams params,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection});

  /// 开启声卡采集。
  /// 启用声卡采集功能后，声卡播放的声音会被合到本地音频流中，从而可以发送到远端。macOS 系统默认声卡不支持采集功能，如果你需要使用该功能，请启用一个虚拟声卡，并将该虚拟声卡的名字传入 deviceName 参数。Agora 推荐你使用虚拟声卡 Soundflower 进行声卡采集。该方法在加入频道前后都能调用。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [enabled] 是否开启声卡采集：
  ///  true: 开启声卡采集。false:（默认）不开启声卡采集。
  /// * [deviceName] 设备名称。
  ///
  /// Returns
  /// 0: 方法调用成功。< 0: 方法调用失败。
  Future<void> enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName});

  /// 获取当前网络连接状态。
  /// 该方法在加入频道前后都能调用。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  ///
  /// Returns
  /// 当前网络连接状态。详见 ConnectionStateType 。
  Future<ConnectionStateType> getConnectionStateEx(RtcConnection connection);

  /// @nodoc
  Future<void> enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config});

  /// 发送数据流。
  /// 调用 createDataStreamEx 后，你可以调用本方法向频道内所有用户发送数据流消息。SDK 对该方法有如下限制： 频道内每秒最多能发送 60 个包，且每个包最大为 1 KB。每个客户端每秒最多能发送 30 KB 数据。频道内每人最多能同时有 5 个数据通道。成功调用该方法后，远端会触发 onStreamMessage 回调，远端用户可以在该回调中获取接收到的流消息；
  ///  若调用失败，远端会触发 onStreamMessageError 回调。请确保在调用该方法前，已调用 createDataStreamEx 创建了数据通道。该方法仅适用于通信场景以及直播场景下的主播用户，如果直播场景下的观众调用此方法可能会造成观众变主播。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [streamId] 数据流 ID。可以通过 createDataStreamEx 获取。
  /// * [data] 待发送的数据。
  /// * [length] 数据长度。
  ///
  /// Returns
  /// 0: 方法调用成功。< 0: 方法调用失败。
  Future<void> sendStreamMessageEx(
      {required int streamId,
      required Uint8List data,
      required int length,
      required RtcConnection connection});

  /// 添加本地视频水印。
  /// 该方法将一张 PNG 图片作为水印添加到本地发布的直播视频流上，同一直播频道中的用户、旁路直播观众和采集设备都能看到或采集到该水印图片。
  ///  Agora 当前只支持在直播视频流中添加一个水印，后添加的水印会替换掉之前添加的水印。水印坐标和 setVideoEncoderConfigurationEx 方法中的设置有依赖关系： 如果视频编码方向（ OrientationMode ）固定为横屏或自适应模式下的横屏，那么水印使用横屏坐标。如果视频编码方向（OrientationMode）固定为竖屏或自适应模式下的竖屏，那么水印使用竖屏坐标。设置水印坐标时，水印的图像区域不能超出 setVideoEncoderConfigurationEx 方法中设置的视频尺寸，否则超出部分将被裁剪。你需要在调用 enableVideo 方法之后再调用本方法。待添加水印图片必须是 PNG 格式。本方法支持所有像素格式的 PNG 图片：RGBA、RGB、Palette、Gray 和 Alpha_gray。如果待添加的 PNG 图片的尺寸与你在本方法中设置的尺寸不一致，SDK 会对 PNG 图片进行缩放或裁剪，以与设置相符。如果你已经使用 startPreview 方法开启本地视频预览，那么本方法的 visibleInPreview 可设置水印在预览时是否可见。如果你已设置本地视频为镜像模式，那么此处的本地水印也为镜像。为避免本地用户看本地视频时的水印也被镜像，Agora 建议你不要对本地视频同时使用镜像和水印功能，请在应用层实现本地水印功能。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [options] 待添加的水印图片的设置选项，详见 WatermarkOptions 。
  /// * [watermarkUrl] 待添加的水印图片的本地路径。该方法支持从本地绝对/相对路径添加水印图片。
  ///
  /// Returns
  /// 0: 方法调用成功< 0: 方法调用失败
  Future<void> addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection});

  /// 删除已添加的视频水印。
  ///
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  Future<void> clearVideoWatermarkEx(RtcConnection connection);

  /// 自定义数据上报和分析服务。
  /// 声网提供自定义数据上报和分析服务。该服务当前处于免费内测期。内测期提供的能力为 6 秒内最多上报 10 条数据，每条自定义数据不能超过 256 字节，每个字符串不能超过 100 字节。如需试用该服务，请联系 开通并商定自定义数据格式。
  Future<void> sendCustomReportMessageEx(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value,
      required RtcConnection connection});

  /// @nodoc
  Future<void> enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection});

  /// @nodoc
  Future<UserInfo> getUserInfoByUserAccountEx(
      {required String userAccount, required RtcConnection connection});

  /// @nodoc
  Future<UserInfo> getUserInfoByUidEx(
      {required int uid, required RtcConnection connection});

  /// @nodoc
  Future<void> setVideoProfileEx(
      {required int width,
      required int height,
      required int frameRate,
      required int bitrate});

  /// @nodoc
  Future<void> enableDualStreamModeEx(
      {required VideoSourceType sourceType,
      required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  /// @nodoc
  Future<void> setDualStreamModeEx(
      {required VideoSourceType sourceType,
      required SimulcastStreamMode mode,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection});

  @override
  Future<void> enableWirelessAccelerate(bool enabled);

  /// 获取视频截图。
  /// 该方法是异步操作，调用返回时 SDK 并没有真正获取截图。成功调用该方法后，SDK 会触发 onSnapshotTaken 回调报告截图是否成功和获取截图的详情。
  ///  该方法用于对指定用户的视频流进行截图，生成一张 JPG 格式的图片，并保存至指定的路径。
  ///  该方法需要在调用 joinChannelEx 后调用。该方法对 ChannelMediaOptions 中指定发布的视频流进行截图。如果用户的视频经过前处理，例如，添加了水印或美颜，生成的截图会包含前处理效果。
  ///
  /// * [filePath] 截图的本地保存路径，需精确到文件名及格式， 例如： Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg
  ///  iOS: /App Sandbox/Library/Caches/example.jpg
  ///  macOS: ～/Library/Logs/example.jpg
  ///  Android: /storage/emulated/0/Android/data/<package name>/files/example.jpg
  ///  请确保目录存在且可写。
  ///
  /// * [uid] 用户 ID。如果要对本地用户的视频截图，则设为 0。
  /// * [connection] Connection 信息。详见 RtcConnection 。
  Future<void> takeSnapshotEx(
      {required RtcConnection connection,
      required int uid,
      required String filePath});

  /// 创建数据流。
  /// 创建数据流。每个用户在每个频道中最多只能创建 5 个数据流。相比 createDataStreamEx ，本方法不支持数据可靠。接收方会丢弃超出发送时间 5 秒后的数据包。
  ///
  /// * [connection] Connection 信息。详见 RtcConnection 。
  /// * [config] 数据流设置。详见 DataStreamConfig 。
  ///
  /// Returns
  /// < 0：方法调用失败。
  Future<int> createDataStreamEx(
      {required DataStreamConfig config, required RtcConnection connection});
}
