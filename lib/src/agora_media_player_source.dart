import 'package:agora_rtc_ng/src/binding_forward_export.dart';

/// Provides callbacks for media players.
class MediaPlayerSourceObserver {
  /// Construct the [MediaPlayerSourceObserver].
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
    this.onAudioVolumeIndication,
  });

  /// Reports the playback state change.
  /// When the state of the media player changes, the SDK triggers this callback to report the current playback state.
  ///
  /// * [state] The playback state, see MediaPlayerState .None
  ///
  /// * [ec] The error code. See MediaPlayerError .None
  final void Function(MediaPlayerState state, MediaPlayerError ec)?
      onPlayerSourceStateChanged;

  /// Reports the current playback progress.
  /// When playing media files, the SDK triggers this callback every one second to report current playback progress.
  ///
  /// * [position] The playback position (ms) of media files.None
  final void Function(int position)? onPositionChanged;

  /// Reports the playback event.
  /// After calling the seek method, the SDK triggers the callback to report the results of the seek operation.
  ///
  /// * [eventCode] The playback event. See MediaPlayerEvent .None
  ///
  /// * [elapsedTime] The time (ms) when the event occurs.None
  ///
  /// * [message] Information about the event.None
  final void Function(
          MediaPlayerEvent eventCode, int elapsedTime, String message)?
      onPlayerEvent;

  /// Occurs when the media metadata is received.
  /// The callback occurs when the player receives the media metadata and reports the detailed information of the media metadata.
  ///
  /// * [data] The detailed data of the media metadata.None
  ///
  /// * [length] The data length (bytes).None
  final void Function(Uint8List data, int length)? onMetaData;

  /// @nodoc
  final void Function(int playCachedBuffer)? onPlayBufferUpdated;

  /// @nodoc
  final void Function(String src, PlayerPreloadEvent event)? onPreloadEvent;

  /// /// @nodoc
  final void Function()? onCompleted;

  /// @nodoc
  final void Function()? onAgoraCDNTokenWillExpire;

  /// @nodoc
  final void Function(SrcInfo from, SrcInfo to)? onPlayerSrcInfoChanged;

  /// @nodoc
  final void Function(PlayerUpdatedInfo info)? onPlayerInfoUpdated;

  /// @nodoc
  final void Function(int volume)? onAudioVolumeIndication;
}
