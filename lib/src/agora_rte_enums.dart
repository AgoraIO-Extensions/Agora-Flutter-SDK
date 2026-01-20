/// RTE enum definitions
///
/// This file contains all RTE-related enum types corresponding to native SDK enums.
/// Native SDK enums are imported via #import <AgoraRtcKit/AgoraRteKit.h>, no need to redefine in native layer.

/// RTE error codes
enum AgoraRteErrorCode {
  /// 0: Success
  ok,

  /// 1: Default error, not specifically categorized
  errorDefault,

  /// 2: Invalid parameter passed when calling API
  errorInvalidArgument,

  /// 3: Unsupported API operation
  errorInvalidOperation,

  /// 4: Network error
  errorNetworkError,

  /// 5: Authentication failed
  errorAuthenticationFailed,

  /// 6: Stream not found
  errorStreamNotFound,
}

/// Player state
enum AgoraRtePlayerState {
  /// 0: Idle state
  idle,

  /// 1: Opening
  opening,

  /// 2: Open completed
  openCompleted,

  /// 3: Playing
  playing,

  /// 4: Paused
  paused,

  /// 5: Playback completed
  playbackCompleted,

  /// 6: Stopped
  stopped,

  /// 7: Failed
  failed,
}

/// Player events
enum AgoraRtePlayerEvent {
  /// 0: Start seeking to specified position
  seekBegin,

  /// 1: Seek completed
  seekComplete,

  /// 2: Error occurred while seeking to new position
  seekError,

  /// 3: Current buffer insufficient for playback
  bufferLow,

  /// 4: Current buffer sufficient for playback
  bufferRecover,

  /// 5: Audio or video playback started stuttering
  freezeStart,

  /// 6: Audio or video playback recovered, no longer stuttering
  freezeStop,

  /// 7: One loop of playback completed
  oneLoopPlaybackCompleted,

  /// 8: URL authentication is about to expire
  authenticationWillExpire,

  /// 9: When fallback enabled, ABR degraded to audio-only due to poor network
  abrFallbackToAudioOnlyLayer,

  /// 10: When fallback enabled, ABR recovered from audio-only to video
  abrRecoverFromAudioOnlyLayer,

  /// 11: Start switching to new URL
  switchBegin,

  /// 12: Switch to new URL completed
  switchComplete,

  /// 13: Error occurred while switching to new URL
  switchError,

  /// 14: First video frame rendered
  firstDisplayed,

  /// 15: Cache file count reached maximum
  reachCacheFileMaxCount,

  /// 16: Cache file size reached maximum
  reachCacheFileMaxSize,

  /// 17: Start attempting to open new URL
  tryOpenStart,

  /// 18: Successfully opened new URL
  tryOpenSucceed,

  /// 19: Failed to open new URL
  tryOpenFailed,

  /// 20: Audio track changed
  audioTrackChanged,
}

/// Video render mode
enum AgoraRteVideoRenderMode {
  /// 0: Hidden mode, fills the view, excess is cropped
  hidden,

  /// 1: Fit mode, renders entire image within the view
  fit,
}

/// Mirror mode
enum AgoraRteVideoMirrorMode {
  /// 0: SDK decides mirror mode
  auto,

  /// 1: Enable mirror mode
  enabled,

  /// 2: Disable mirror mode
  disabled,
}

/// Metadata type
enum AgoraRtePlayerMetadataType {
  /// SEI type
  sei,
}

/// ABR subscription layer
enum AgoraRteAbrSubscriptionLayer {
  /// 0: High quality video stream, highest resolution and bitrate
  high,

  /// 1: Low quality video stream, lowest resolution and bitrate
  low,

  /// 2: Layer1 video stream, resolution and bitrate lower than high quality
  layer1,

  /// 3: Layer2 video stream, resolution and bitrate lower than layer1
  layer2,

  /// 4: Layer3 video stream, resolution and bitrate lower than layer2
  layer3,

  /// 5: Layer4 video stream, resolution and bitrate lower than layer3
  layer4,

  /// 6: Layer5 video stream, resolution and bitrate lower than layer4
  layer5,

  /// 7: Layer6 video stream, resolution and bitrate lower than layer5
  layer6,
}

/// ABR fallback layer
enum AgoraRteAbrFallbackLayer {
  /// 0: No fallback to low resolution stream on poor network, may fallback to SVC but keeps high resolution
  disabled,

  /// 1: Receive low quality video stream on poor network
  low,

  /// 2: Fallback to low quality first on poor network, then to audio layer, receive only audio if network is extremely poor
  audioOnly,

  /// 3: Layer1 fallback
  layer1,

  /// 4: Layer2 fallback
  layer2,

  /// 5: Layer3 fallback
  layer3,

  /// 6: Layer4 fallback
  layer4,

  /// 7: Layer5 fallback
  layer5,

  /// 8: Layer6 fallback
  layer6,
}
