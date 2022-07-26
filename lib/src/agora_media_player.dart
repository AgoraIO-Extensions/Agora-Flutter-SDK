import 'package:agora_rtc_engine/src/binding_forward_export.dart';

/// 提供媒体播放器功能的类，支持多实例。
///
abstract class MediaPlayer {
  /// 获取播放器 ID。
  ///
  ///
  /// Returns
  /// 方法调用成功，返回播放器 ID。< 0: 方法调用失败。
  int getMediaPlayerId();

  /// 打开媒体资源。
  /// 该方法为异步调用。如需播放媒体文件，请在收到 onPlayerSourceStateChanged 回调报告播放状态为playerStateOpenCompleted 后再调用 play 方法播放媒体文件。
  ///
  /// * [url] 设置媒体文件的路径，支持本地和在线文件。在 Android 平台上，如果你需要打开 URI 格式的文件，请使用 open 。
  /// * [startPos] 设置起始播放位置（毫秒），默认值为 0。
  Future<void> open({required String url, required int startPos});

  /// 打开媒体资源并进行播放设置。
  /// 该方法支持你打开不同类型的媒体资源，包括自定义的媒体资源文件，并可进行播放设置。
  ///
  /// * [source] 媒体资源，详见 MediaSource 。
  ///
  /// Returns
  /// 0：方法调用成功。< 0：方法调用失败。
  Future<void> openWithMediaSource(MediaSource source);

  /// 播放媒体文件。
  /// 调用open 或seek 后，你可以调用该方法播放媒体文件。
  Future<void> play();

  /// 暂停播放。
  ///
  Future<void> pause();

  /// 停止播放。
  ///
  Future<void> stop();

  /// 暂停后恢复播放。
  ///
  Future<void> resume();

  /// 定位到媒体文件的指定播放位置。
  /// 成功调用该方法后，你会收到 onPlayerEvent 回调，报告当前播放器发生的事件，如定位开始、定位成功或定位失败。如果你想定位播放，请进行如下操作：调用该方法定位。定位完成后，调用 play 方法播放。
  ///
  /// * [newPos] 指定的位置（毫秒）。
  Future<void> seek(int newPos);

  /// 调整当前播放的媒体资源的音调。
  /// 你需要在调用 open 后调用该方法。
  ///
  /// * [pitch] 按半音音阶调整本地播放的音乐文件的音调，默认值为 0，即不调整音调。取值范围为 [-12,12]，每相邻两个值的音高距离相差半音。取值的绝对值越大，音调升高或降低得越多。
  Future<void> setAudioPitch(int pitch);

  /// 获取媒体文件总时长。
  ///
  ///
  /// Returns
  /// 媒体文件总时长（毫秒）。
  Future<int> getDuration();

  /// 获取当前播放进度。
  ///
  ///
  /// Returns
  /// 方法调用成功，返回当前播放进度（毫秒）。< 0: 方法调用失败，详见 MediaPlayerError 。
  Future<int> getPlayPosition();

  /// 获取当前媒体文件中媒体流的数量。
  /// 你需要在 open 后调用该方法。
  ///
  /// Returns
  /// 方法调用成功，返回该媒体文件中媒体流的数量。< 0: 方法调用失败，详见 MediaPlayerError 。
  Future<int> getStreamCount();

  /// 通过媒体流的索引值获取媒体流信息。
  /// 你需要在 getStreamCount 后调用该方法。
  ///
  /// * [index] 媒体流索引值。
  ///
  /// Returns
  /// 方法调用成功，返回媒体流信息，详见 PlayerStreamInfo 。方法调用失败，返回NULL。
  Future<PlayerStreamInfo> getStreamInfo(int index);

  /// 设置循环播放。
  /// 如果你希望循环播放，请调用该方法并设置循环播放次数。循环播放结束时，SDK 会触发 onPlayerSourceStateChanged 回调，向你报告播放状态为playerStatePlaybackAllLoopsCompleted。
  ///
  /// * [loopCount] 循环播放的次数。
  Future<void> setLoopCount(int loopCount);

  /// 设置当前音频文件的播放速度。
  /// 你需要在 open 后调用该方法。
  ///
  /// * [speed] 播放速度。推荐取值范围为 [50,400]，其中：50: 0.5 倍速。100: 原始速度。400: 4 倍速。
  Future<void> setPlaybackSpeed(int speed);

  /// 指定当前音频文件的播放音轨。
  /// 获取音频文件的音轨索引后，你可以调用该方法指定任一音轨进行播放。例如，如果一个多音轨文件的不同音轨存放了不同语言的歌曲，则你可以调用该方法设置播放语言。你需要在调用 getStreamInfo 获取音频流索引值后调用该方法。
  ///
  /// * [index] 音轨的索引值。
  Future<void> selectAudioTrack(int index);

  /// @nodoc
  Future<void> takeScreenshot(String filename);

  /// @nodoc
  Future<void> selectInternalSubtitle(int index);

  /// @nodoc
  Future<void> setExternalSubtitle(String url);

  /// 获取播放器当前状态。
  ///
  ///
  /// Returns
  /// 播放器当前状态，详见 MediaPlayerState 。
  Future<MediaPlayerState> getState();

  /// 设置是否静音。
  ///
  ///
  /// * [mute] 静音选项。true：静音。false：（默认）不静音。
  Future<void> mute(bool muted);

  /// 获取当前播放的媒体文件是否静音。
  ///
  ///
  /// Returns
  /// true：当前播放的媒体文件为静音。false：当前播放的媒体文件没有静音。
  Future<bool> getMute();

  /// 调节本地播放音量。
  ///
  ///
  /// * [volume] 本地播放音量，取值范围从 0 到 100：0: 无声。100: （默认）媒体文件的原始播放音量。
  Future<void> adjustPlayoutVolume(int volume);

  /// 获取当前本地播放音量。
  ///
  ///
  /// Returns
  /// 返回当前本地播放音量，取值范围从 0 到 100： 0: 无声。100: （默认）媒体文件的原始播放音量。
  Future<int> getPlayoutVolume();

  /// 调节远端用户听到的音量。
  /// 连接到 Agora 服务器后，你可以调用该方法，调节远端用户听到的媒体文件的音量。
  ///
  /// * [volume] 信号音量，取值范围从 0 到 400：0: 无声。100: （默认）媒体文件的原始音量。400: 原始音量的四倍（自带溢出保护）。
  Future<void> adjustPublishSignalVolume(int volume);

  /// 获取远端用户听到的音量。
  ///
  ///
  /// Returns
  /// ≥ 0: 播放文件的远端播放音量。< 0: 方法调用失败。
  Future<int> getPublishSignalVolume();

  /// 设置播放器渲染视图。
  ///
  Future<void> setView(int view);

  /// 设置播放器视图的渲染模式。
  ///
  ///
  /// * [renderMode] 播放器视图的渲染模式。详见 RenderModeType 。
  Future<void> setRenderMode(RenderModeType renderMode);

  /// 注册一个播放观测器。
  ///
  ///
  /// * [observer] 播放观测器，报告播放中的事件，详见 MediaPlayerSourceObserver 。
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// 取消注册播放观测器。
  ///
  ///
  /// * [observer] 播放观测器，报告播放中的事件，详见 MediaPlayerSourceObserver 。
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer);

  /// @nodoc
  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer, required int intervalInMS});

  /// @nodoc
  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer);

  /// 设置当前音频文件的声道模式。
  /// 在双声道音频文件中，左声道和右声道可以存储不同的音频数据。根据实际需要，你可以设置声道模式为原始模式、左声道模式、右声道模式或混合模式。例如，在 KTV 场景中，音频文件的左声道存储了伴奏，右声道存储了原唱的歌声。如果你只需听伴奏，调用该方法设置音频文件的声道模式为左声道模式；如果你需要同时听伴奏和原唱，调用该方法设置声道模式为混合模式。你需要在调用 open 后调用该方法。该方法仅适用于双声道的音频文件。
  ///
  /// * [mode] 声道模式。详见 AudioDualMonoMode 。
  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode);

  /// @nodoc
  Future<String> getPlayerSdkVersion();

  /// @nodoc
  Future<String> getPlaySrc();

  /// 打开媒体资源，并通过自研调度中心请求媒体资源的所有 CDN 线路。
  /// 该方法为异步调用。如需播放媒体文件，请在收到 onPlayerSourceStateChanged 回调报告播放状态为playerStateOpenCompleted 后再调用 play 方法播放媒体文件。调用该方法后，Agora 会打开媒体资源并通过自研调度中心请求媒体资源的所有 CDN 线路。Agora 默认使用第一个线路，你也可以通过 switchAgoraCDNLineByIndex 自行切换线路。如果你希望保障连接和播放媒体资源的安全性，你可以协商鉴权字段 (sign) 和鉴权过期时间 (ts)。确定字段后，请将其作为 URL 的query parameter 以更新媒体资源的网路路径。例如：媒体资源网络路径为rtmp://$domain/$appName/$streamName通过鉴权信息更新过的媒体资源网络路径为rtmp://$domain/$appName/$streamName?ts=$ts&sign=$sign鉴权信息说明：sign : 通过authKey +appName +streamName +ts 进行 md5 算法加密得出的鉴权字段。你需要咨询你的authKey 字段内容。ts : 鉴权过期时间。你可以指定再过多久鉴权过期。例如，24h 或1h30m20s。
  ///
  /// * [src] 媒体资源的网络路径。
  /// * [startPos] 设置起始播放位置 (毫秒)，默认值为 0。如果媒体资源为直播流，则无需赋值。
  Future<void> openWithAgoraCDNSrc(
      {required String src, required int startPos});

  /// 获取媒体资源的 CDN 线路数量。
  ///
  Future<int> getAgoraCDNLineCount();

  /// 切换媒体资源的 CDN 线路。
  /// 通过 openWithAgoraCDNSrc 打开媒体资源后，如果你想切换媒体资源 CDN 线路，你可以调用该方法。请在 openWithAgoraCDNSrc 后调用该方法。该方法在 play 前后均可调用。如果你在play 前调用该方法，切换不会立即生效。SDK 会等待播放完成后再切换媒体资源的 CDN 线路。
  ///
  /// * [index] CDN 线路索引。
  Future<void> switchAgoraCDNLineByIndex(int index);

  /// 获取当前使用的媒体资源的 CDN 线路索引。
  ///
  Future<int> getCurrentAgoraCDNIndex();

  /// 开启/关闭自动切换媒体资源的 CDN 线路。
  /// 如果你想设置 SDK 根据网络情况自动切换媒体资源 CDN 线路，你可以调用该方法。请在 openWithAgoraCDNSrc 前调用该方法。
  ///
  /// * [enable] 设置是否开启自动切换媒体资源的 CDN 线路:true：开启自动切换媒体资源的 CDN 线路。false：(默认) 关闭自动切换媒体资源的 CDN 线路。
  Future<void> enableAutoSwitchAgoraCDN(bool enable);

  /// 更新媒体资源网络路径的鉴权信息。
  /// 当鉴权信息过期（超出ts 时间）时，你可以调用 openWithAgoraCDNSrc 或 switchAgoraCDNSrc 重新打开或切换媒体资源，并传入带新鉴权信息（如更新ts 字段内容）的媒体资源网络路径。如果你在切换媒体资源线路 ( switchAgoraCDNLineByIndex ) 时遇到鉴权信息过期，你需要调用该方法并传入新的鉴权信息，以更新该媒体资源网络路径的鉴权信息。更新鉴权信息后，你还需调用 switchAgoraCDNLineByIndex 才能完成线路切换。为避免鉴权信息频繁过期，请务必根据场景需求设置合适的ts 字段内容或。
  ///
  /// * [token] 鉴权字段。即鉴权信息中的sign 字段。
  /// * [ts] 鉴权过期时间。即鉴权信息中的ts 字段。
  Future<void> renewAgoraCDNSrcToken({required String token, required int ts});

  /// 切换媒体资源。
  /// 如果你希望保障连接和播放媒体资源的安全性，你可以协商鉴权字段 (sign) 和鉴权过期时间 (ts)。确定字段后，请将其作为 URL 的query parameter 以更新媒体资源的网路路径。例如：媒体资源网络路径为rtmp://$domain/$appName/$streamName通过鉴权信息更新过的媒体资源网络路径为rtmp://$domain/$appName/$streamName?ts=$ts&sign=$sign鉴权信息说明：sign : 通过authKey +appName +streamName +ts 进行 md5 算法加密得出的鉴权字段。你需要咨询你的authKey 字段内容。ts : 鉴权过期时间。你可以指定再过多久鉴权过期。例如，24h 或1h30m20s。如果用户需要自定义播放线路，你可以调用该方法实现媒体资源切换。Agora 会通过自研调度中心支持调度线路，提升观看用户体验。如果用户不需要自定义播放线路，你可以调用 switchSrc 实现媒体资源切换。请在 openWithAgoraCDNSrc 后调用该方法。该方法在 play 前后均可调用。如果你在play 前调用该方法，SDK 会等你调用play 后再完成线路切换。
  ///
  /// * [src] 媒体资源的网络路径。
  /// * [syncPts] 是否同步切换前后的起始播放位置:true：同步。false：(默认) 不同步。如果媒体资源为直播流，你只能将该参数设置为false，否则 SDK 切换媒体资源会失败。如果媒体资源为点播流，你可以根据场景需求对该参数赋值。
  Future<void> switchAgoraCDNSrc({required String src, bool syncPts = false});

  /// 切换媒体资源。
  /// 你可以根据当前网络状态调用该方法切换播放的媒体资源的码率。例如：在网络较差时，将播放的媒体资源切换为较低码率的媒体资源地址。在网络较好时，将播放的媒体资源切换为较高码率的媒体资源地址。调用该方法后，如果你收到 onPlayerEvent 回调报告事件playerEventSwitchComplete，则媒体资源切换成功；如果你收到 onPlayerEvent 回调报告事件playerEventSwitchError，则媒体资源切换失败。请确保在 open 之后调用该方法。为保证播放正常，请在调用该方法时注意如下：不要在播放暂停时调用该方法。不要在切换码率过程中调用 seek 。确保切换码率前的播放位置不大于待切换的媒体资源总时长。
  ///
  /// * [src] 媒体资源的网络路径。
  /// * [syncPts] 是否同步切换前后的起始播放位置:true：同步。false：(默认) 不同步。如果媒体资源为直播流，你只能将该参数设置为false，否则 SDK 切换媒体资源会失败。如果媒体资源为点播流，你可以根据场景需求对该参数赋值。
  Future<void> switchSrc({required String src, bool syncPts = true});

  /// 预加载媒体资源。
  /// 你可以调用该方法将一个媒体资源预加载到播放列表中。如果需要预加载多个媒体资源，你可以多次调用该方法。预加载成功后，如果你想播放媒体资源，请调用 playPreloadedSrc ；如果你想清空播放列表，请调用 stop 。Agora 不支持你预加载重复的媒体资源到播放列表，但支持你将正在播放的媒体资源再次预加载到播放列表。
  ///
  /// * [src] 媒体资源的网络路径。
  /// * [startPos] 预加载到播放列表后，开始播放时的起始位置（毫秒）。预加载直播流时，将该参数设置为 0。
  Future<void> preloadSrc({required String src, required int startPos});

  /// 播放预加载的媒体资源。
  /// 调用 preloadSrc 方法将媒体资源预加载到播放列表后，可以调用该方法播放已预加载的媒体资源。调用该方法后，如果你收到 onPlayerSourceStateChanged 回调报告状态playerStatePlaying，则表示播放成功。如果你想更换播放的预加载媒体资源，你可以再次调用该方法并指定新的媒体资源路径。如果你想重新播放媒体资源，你需要在播放前调用 preloadSrc 重新将该媒体资源预加载到播放列表。如果你想清空播放列表，请调用 stop 。如果你在播放暂停时调用该方法，该方法会在恢复播放后才生效。
  ///
  /// * [src] 播放列表中的媒体资源 URL 地址，必须与preloadSrc 方法设置的src 一致，否则无法播放。
  Future<void> playPreloadedSrc(String src);

  /// 释放预加载的媒体资源。
  /// 该方法不支持释放当前播放的媒体资源。
  ///
  /// * [src] 媒体资源的网络路径。
  Future<void> unloadSrc(String src);

  /// @nodoc
  Future<void> setSpatialAudioParams(SpatialAudioParams params);

  /// @nodoc
  Future<void> setSoundPositionParams(
      {required double pan, required double gain});

  /// 注册音频帧观测器。
  /// 你需要在该方法中实现一个 MediaPlayerAudioFrameObserver 类，并根据场景需要，注册该类的回调。成功注册音频帧观测器后，SDK 会在捕捉到每个音频帧时，触发你所注册的回调。
  ///
  /// * [observer] 音频帧观测器，观测每帧音频的接收，详见 MediaPlayerAudioFrameObserver 。
  void registerAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  /// 取消注册音频帧观测器 。
  ///
  ///
  /// * [observer] 音频帧观测器，详见 MediaPlayerAudioFrameObserver 。
  void unregisterAudioFrameObserver(MediaPlayerAudioFrameObserver observer);

  /// 注册视频帧观测器。
  /// 你需要在该方法中实现一个 MediaPlayerVideoFrameObserver 类，并根据场景需要，注册该类的回调。成功注册视频帧观测器后，SDK 会在捕捉到每个视频帧时，触发你所注册的回调。
  ///
  /// * [observer] 视频帧观测器，观测每帧视频的接收。详见 MediaPlayerVideoFrameObserver 。
  void registerVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  /// 取消注册视频帧观测器。
  ///
  ///
  /// * [observer] 视频帧观测器，观测每帧视频的接收，详见 MediaPlayerVideoFrameObserver 。
  void unregisterVideoFrameObserver(MediaPlayerVideoFrameObserver observer);

  /// @nodoc
  Future<void> setPlayerOptionInInt({required String key, required int value});

  /// @nodoc
  Future<void> setPlayerOptionInString(
      {required String key, required String value});
}

/// 该类提供管理媒体播放器中缓存媒体文件的方法。
///
abstract class MediaPlayerCacheManager {
  /// 删除媒体播放器中所有已缓存的媒体文件。
  /// 该方法不会删除正在播放中的已缓存媒体文件。
  Future<void> removeAllCaches();

  /// 删除媒体播放器中近期最少使用的一个缓存媒体文件。
  /// 缓存媒体文件占用过多空间时，你可以调用该方法清理缓存文件。调用该方法后，SDK 会删除最少使用的一个缓存媒体文件。当你调用此方法删除缓存媒体文件时，当前正在播放的已缓存媒体文件不会被删除。
  Future<void> removeOldCache();

  /// 删除指定的已缓存媒体文件。
  /// 该方法不会删除正在播放中的已缓存媒体文件。
  ///
  /// * [uri] 待删除的缓存文件的 URI（Uniform Resource Identifier），可用于标识媒体文件。
  Future<void> removeCacheByUri(String uri);

  /// 设置待缓存的媒体文件的储存路径。
  /// 该方法需在初始化 RtcEngine 之前调用。
  ///
  /// * [path] 缓存文件储存的绝对路径。请确保指定的目录存在且可写。
  Future<void> setCacheDir(String path);

  /// 设置缓存媒体文件数量的上限。
  ///
  ///
  /// * [count] 可缓存的媒体文件数量的上限，默认值为 1000。
  Future<void> setMaxCacheFileCount(int count);

  /// 设置缓存媒体文件的总缓存大小的上限。
  ///
  ///
  /// * [cacheSize] 缓存媒体文件的总缓存上限，单位为字节。默认为 1 GB。
  Future<void> setMaxCacheFileSize(int cacheSize);

  /// 设置是否开启自动清除缓存文件功能。
  /// 开启自动清除缓存文件后，当播放器中缓存的媒体文件超过你设置的文件数量或总缓存大小的上限时，SDK 会自动清除近期最少使用的一个缓存文件。
  ///
  /// * [enable] 是否自动清除缓存文件：true：开启自动清除缓存文件功能。false：（默认）关闭自动清除缓存文件功能。
  Future<void> enableAutoRemoveCache(bool enable);

  /// 获取缓存文件的储存路径。
  /// 如果你在调用该方法前未曾调用 setCacheDir 方法自定义缓存文件的储存路径，该方法返回的为 SDK 默认的缓存文件储存路径。
  ///
  /// * [length] 输入参数，缓存文件储存路径字符串的最大长度。
  ///
  /// Returns
  /// 方法调用成功时，返回缓存文件的储存路径。< 0：方法调用失败，详见 MediaPlayerError 。
  Future<String> getCacheDir(int length);

  /// 获取所设置的缓存文件数量上限。
  /// SDK 默认的缓存文件数量上限为 1000。
  ///
  /// Returns
  /// > 0：方法调用成功，返回缓存文件数量的上限。< 0：方法调用失败，详见 MediaPlayerError 。
  Future<int> getMaxCacheFileCount();

  /// 获取所设置的缓存文件总缓存的上限。
  /// SDK 默认的缓存文件总缓存上限为 1GB。你可以调用 setMaxCacheFileSize 方法自定义总缓存大小的上限。
  ///
  /// Returns
  /// > 0：方法调用成功，返回缓存文件的总缓存上限，单位为字节。< 0：方法调用失败，详见 MediaPlayerError 。
  Future<int> getMaxCacheFileSize();

  /// 获取当前已缓存的媒体文件的总数量。
  ///
  ///
  /// Returns
  /// ≥ 0：方法调用成功，返回当前已缓存的媒体文件的总数量。< 0：方法调用失败，详见 MediaPlayerError 。
  Future<int> getCacheFileCount();
}

/// 媒体播放器的音频数据观测器。
///
class MediaPlayerAudioFrameObserver {
  /// @nodoc
  const MediaPlayerAudioFrameObserver({
    this.onFrame,
  });

  /// 已获取音频帧回调。
  /// 注册音频帧观测器后，每次接收到一帧音频帧时，都会触发该回调，报告音频帧信息。
  ///
  /// * [frame] 音频帧信息，详见 AudioPcmFrame 。
  final void Function(AudioPcmFrame frame)? onFrame;
}

/// 媒体播放器的视频数据观测器。
///
class MediaPlayerVideoFrameObserver {
  /// @nodoc
  const MediaPlayerVideoFrameObserver({
    this.onFrame,
  });

  /// 已获取视频帧回调。
  /// 注册视频观测器后，每次接收到一帧视频时，都会触发该回调，报告视频帧信息。
  ///
  /// * [frame] 视频帧信息，详见 VideoFrame 。
  final void Function(VideoFrame frame)? onFrame;
}
