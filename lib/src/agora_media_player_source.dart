import 'package:agora_rtc_engine/src/binding_forward_export.dart';

/// Provides callbacks for media players.
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
    this.onAudioVolumeIndication,
  });

  /// Reports the playback state change.
  /// When the state of the media player changes, the SDK triggers this callback to report the current playback state.
  ///
  /// * [state] The playback state, see MediaPlayerState .
  /// * [ec] The error code. See MediaPlayerError .
  final void Function(MediaPlayerState state, MediaPlayerError ec)?
      onPlayerSourceStateChanged;

  /// Reports current playback progress.
  /// When playing media files, the SDK triggers this callback every one second to report current playback progress.
  ///
  /// * [position] The playback position (ms) of media files.
  final void Function(int positionMs)? onPositionChanged;

  /// Reports the playback event.
  /// After calling the seek method, the SDK triggers the callback to report the results of the seek operation.
  ///
  /// * [eventCode] The playback event. See MediaPlayerEvent .
  /// * [elapsedTime] The time (ms) when the event occurs.
  /// * [message] Information about the event.
  final void Function(
          MediaPlayerEvent eventCode, int elapsedTime, String message)?
      onPlayerEvent;

  /// Occurs when the media metadata is received.
  /// The callback occurs when the player receives the media metadata and reports the detailed information of the media metadata.
  ///
  /// * [data] The detailed data of the media metadata.
  /// * [length] The data length (bytes).
  final void Function(Uint8List data, int length)? onMetaData;

  /// Reports the playback duration that the buffered data can support.
  /// When playing online media resources, the SDK triggers this callback every two seconds to report the playback duration that the currently buffered data can support.When the playback duration supported by the buffered data is less than the threshold (0 by default), the SDK returns playerEventBufferLow.When the playback duration supported by the buffered data is greater than the threshold (0 by default), the SDK returns playerEventBufferRecover.
  ///
  /// * [playCachedBuffer] The playback duration (ms) that the buffered data can support.
  final void Function(int playCachedBuffer)? onPlayBufferUpdated;

  /// Reports the events of preloaded media resources.
  ///
  /// * [src] The URL of the media resource.
  /// * [event] Events that occur when media resources are preloaded. See PlayerPreloadEvent .
  final void Function(String src, PlayerPreloadEvent event)? onPreloadEvent;

  /// @nodoc
  final void Function()? onCompleted;

  /// @nodoc
  final void Function()? onAgoraCDNTokenWillExpire;

  /// Occurs when the video bitrate of the media resource changes.
  ///
  /// * [from] Information about the video bitrate of the media resource being played. See SrcInfo .
  /// * [to] Information about the changed video bitrate of media resource being played. See SrcInfo .
  final void Function(SrcInfo from, SrcInfo to)? onPlayerSrcInfoChanged;

  /// Occurs when information related to the media player changes.
  /// When the information about the media player changes, the SDK triggers this callback. You can use this callback for troubleshooting.
  ///
  /// * [info] Information related to the media player. See PlayerUpdatedInfo .
  final void Function(PlayerUpdatedInfo info)? onPlayerInfoUpdated;

  /// Reports the volume of the media player.
  /// The SDK triggers this callback every 200 milliseconds to report the current volume of the media player.
  ///
  /// * [volume] The volume of the media player. The value ranges from 0 to 255.
  final void Function(int volume)? onAudioVolumeIndication;
}
