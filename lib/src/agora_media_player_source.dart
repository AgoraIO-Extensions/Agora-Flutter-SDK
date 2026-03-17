import '/src/_serializable.dart';
import '/src/binding_forward_export.dart';

/// Provides callbacks for the media player.
class MediaPlayerSourceObserver {
  /// @nodoc
  const MediaPlayerSourceObserver({
    this.onPlayerSourceStateChanged,
    this.onPositionChanged,
    this.onPlayerEvent,
    this.onMetaData,
    this.onPlayBufferUpdated,
    this.onPreloadEvent,
    this.onCompleted,
    this.onAgoraCDNTokenWillExpire,
    this.onPlayerSrcInfoChanged,
    this.onPlayerInfoUpdated,
    this.onPlayerCacheStats,
    this.onPlayerPlaybackStats,
    this.onAudioVolumeIndication,
  });

  /// Reports changes in player state.
  ///
  /// When the player state changes, the SDK triggers this callback to report the new playback state.
  ///
  /// * [state] The new playback state. See MediaPlayerState.
  /// * [reason] The reason for the player state change. See MediaPlayerReason.
  final void Function(MediaPlayerState state, MediaPlayerReason reason)?
      onPlayerSourceStateChanged;

  /// Reports the current playback position of the media resource.
  ///
  /// While playing media files, the SDK automatically triggers this callback every second to report the current playback position.
  ///
  /// * [positionMs] Current playback position in milliseconds.
  /// * [timestampMs] NTP timestamp of the current playback position in milliseconds.
  final void Function(int positionMs, int timestampMs)? onPositionChanged;

  /// Reports player events.
  ///
  /// After calling seek to locate playback, the SDK triggers this callback to report the result of the seek operation.
  ///
  /// * [eventCode] Player event. See MediaPlayerEvent.
  /// * [elapsedTime] The time when the event occurred (in milliseconds).
  /// * [message] Information about the event.
  final void Function(
          MediaPlayerEvent eventCode, int elapsedTime, String message)?
      onPlayerEvent;

  /// Reports retrieved media metadata.
  ///
  /// After parsing the media metadata, the SDK triggers this callback to report the type and content of the metadata.
  ///
  /// * [data] The actual data in a user-defined format.
  /// * [length] The length of the data in bytes.
  final void Function(Uint8List data, int length)? onMetaData;

  /// Reports the playable duration of buffered data.
  ///
  /// While playing online media resources, the SDK triggers this callback every second to report the duration that the current buffered data can support.
  ///  If the buffered duration is less than the threshold (default is 0), playerEventBufferLow (6) is returned.
  ///  If the buffered duration is greater than the threshold (default is 0), playerEventBufferRecover (7) is returned.
  ///
  /// * [playCachedBuffer] The duration (in milliseconds) that the current buffered data can support playback.
  final void Function(int playCachedBuffer)? onPlayBufferUpdated;

  /// Reports events during media resource preloading.
  ///
  /// * [src] Path of the media resource.
  /// * [event] Event that occurred during media resource preloading. See PlayerPreloadEvent.
  final void Function(String src, PlayerPreloadEvent event)? onPreloadEvent;

  /// @nodoc
  final void Function()? onCompleted;

  /// @nodoc
  final void Function()? onAgoraCDNTokenWillExpire;

  /// Callback for changes in video bitrate of media resource.
  ///
  /// * [from] Information about the video bitrate before the change during media playback. See SrcInfo.
  /// * [to] Information about the video bitrate after the change during media playback. See SrcInfo.
  final void Function(SrcInfo from, SrcInfo to)? onPlayerSrcInfoChanged;

  /// Callback when media player-related information changes.
  ///
  /// When media player-related information changes, the SDK triggers this callback. You can use it for issue diagnosis and troubleshooting.
  ///
  /// * [info] Media player-related information. See PlayerUpdatedInfo.
  final void Function(PlayerUpdatedInfo info)? onPlayerInfoUpdated;

  /// Reports information about the media resources currently in cache.
  ///
  /// After calling the openWithMediaSource method and setting the enableCache member to true, the SDK triggers this callback once per second after the media file is opened to report statistics of the currently cached media files.
  ///
  /// * [stats] Information about the media resources in cache. See CacheStatistics.
  final void Function(CacheStatistics stats)? onPlayerCacheStats;

  /// Reports information about the currently playing media resource.
  ///
  /// After the media resource starts playing, the SDK triggers this callback once per second to report information about the media resource.
  ///
  /// * [stats] Information about the media resource. See PlayerPlaybackStats.
  final void Function(PlayerPlaybackStats stats)? onPlayerPlaybackStats;

  /// Callback for media player audio volume indication.
  ///
  /// The SDK triggers this callback every 200 milliseconds to report the current volume of the media player.
  ///
  /// * [volume] Current volume of the media player, ranging from [0,255].
  final void Function(int volume)? onAudioVolumeIndication;
}
