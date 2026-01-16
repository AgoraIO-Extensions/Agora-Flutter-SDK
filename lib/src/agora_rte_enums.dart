/// RTE 枚举定义文件
/// 
/// 此文件包含所有 RTE 相关的枚举类型，与原生 SDK 的枚举定义对应。
/// 原生 SDK 的枚举通过 #import <AgoraRtcKit/AgoraRteKit.h> 引入，不需要在 native 层重新定义。

/// RTE 错误代码
enum AgoraRteErrorCode {
  /// 0: 成功
  ok,

  /// 1: 默认错误，未具体分类
  errorDefault,

  /// 2: 调用 API 时传递的参数无效
  errorInvalidArgument,

  /// 3: 不支持的 API 操作
  errorInvalidOperation,

  /// 4: 网络错误
  errorNetworkError,

  /// 5: 身份验证失败
  errorAuthenticationFailed,

  /// 6: 未找到流
  errorStreamNotFound,
}

/// 播放器状态
enum AgoraRtePlayerState {
  /// 0: 空闲状态
  idle,

  /// 1: 正在打开
  opening,

  /// 2: 打开完成
  openCompleted,

  /// 3: 正在播放
  playing,

  /// 4: 已暂停
  paused,

  /// 5: 播放完成
  playbackCompleted,

  /// 6: 已停止
  stopped,

  /// 7: 失败状态
  failed,
}

/// 播放器事件
enum AgoraRtePlayerEvent {
  /// 0: 开始跳转到指定位置播放
  seekBegin,

  /// 1: 跳转完成
  seekComplete,

  /// 2: 跳转到新播放位置时发生错误
  seekError,

  /// 3: 当前缓存数据不足以支持播放
  bufferLow,

  /// 4: 当前缓存数据刚好足以支持播放
  bufferRecover,

  /// 5: 音频或视频播放开始卡顿
  freezeStart,

  /// 6: 音频或视频播放恢复，不再卡顿
  freezeStop,

  /// 7: 一轮循环播放完成
  oneLoopPlaybackCompleted,

  /// 8: URL 身份验证即将过期
  authenticationWillExpire,

  /// 9: 开启降级选项时，由于网络差，ABR 降级到纯音频层
  abrFallbackToAudioOnlyLayer,

  /// 10: 开启降级选项时，ABR 从纯音频层恢复到视频层
  abrRecoverFromAudioOnlyLayer,

  /// 11: 开始切换到新 URL
  switchBegin,

  /// 12: 切换到新 URL 完成
  switchComplete,

  /// 13: 切换到新 URL 时发生错误
  switchError,

  /// 14: 视频第一帧已显示
  firstDisplayed,

  /// 15: 缓存文件数量达到最大值
  reachCacheFileMaxCount,

  /// 16: 缓存文件大小达到最大值
  reachCacheFileMaxSize,

  /// 17: 开始尝试打开新 URL
  tryOpenStart,

  /// 18: 尝试打开新 URL 成功
  tryOpenSucceed,

  /// 19: 尝试打开新 URL 失败
  tryOpenFailed,

  /// 20: 音轨已更改
  audioTrackChanged,
}

/// 视频渲染模式
enum AgoraRteVideoRenderMode {
  /// 0: 隐藏模式，填满整个视图，超出部分将被裁剪
  hidden,

  /// 1: 适应模式，在视图内完整渲染整个图像
  fit,
}

/// 镜像模式
enum AgoraRteVideoMirrorMode {
  /// 0: SDK 决定镜像模式
  auto,

  /// 1: 启用镜像模式
  enabled,

  /// 2: 禁用镜像模式
  disabled,
}

/// 元数据类型
enum AgoraRtePlayerMetadataType {
  /// SEI 类型
  sei,
}

/// ABR 订阅层
enum AgoraRteAbrSubscriptionLayer {
  /// 0: 高质量视频流，分辨率和码率最高
  high,

  /// 1: 低质量视频流，分辨率和码率最低
  low,

  /// 2: Layer1 视频流，分辨率和码率低于高质量流
  layer1,

  /// 3: Layer2 视频流，分辨率和码率低于 layer1
  layer2,

  /// 4: Layer3 视频流，分辨率和码率低于 layer2
  layer3,

  /// 5: Layer4 视频流，分辨率和码率低于 layer3
  layer4,

  /// 6: Layer5 视频流，分辨率和码率低于 layer4
  layer5,

  /// 7: Layer6 视频流，分辨率和码率低于 layer5
  layer6,
}

/// ABR 降级层
enum AgoraRteAbrFallbackLayer {
  /// 0: 网络差时不降级到低分辨率流，可能降级到可伸缩视频编码但保持高质量分辨率
  disabled,

  /// 1: 网络差时接收低质量视频流
  low,

  /// 2: 网络差时先降级到低质量流，若存在则继续降级到音频层，若网络极差则仅接收音频
  audioOnly,

  /// 3: Layer1 降级
  layer1,

  /// 4: Layer2 降级
  layer2,

  /// 5: Layer3 降级
  layer3,

  /// 6: Layer4 降级
  layer4,

  /// 7: Layer5 降级
  layer5,

  /// 8: Layer6 降级
  layer6,
}
