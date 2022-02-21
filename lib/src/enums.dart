import 'package:json_annotation/json_annotation.dart';

///
/// The region for connection, which is the region where
/// the server the SDK connects to is located.
///
///
enum AreaCode {
  @JsonValue(0x00000001)
  ///
  /// Mainland China.
  ///
  CN,

  @JsonValue(0x00000002)
  ///
  /// North America.
  ///
  NA,

  @JsonValue(0x00000004)
  ///
  /// Europe.
  ///
  EU,

  @JsonValue(0x00000008)
  ///
  /// Asia, excluding Mainland China.
  ///
  AS,

  @JsonValue(0x00000010)
  ///
  /// Japan.
  ///
  JP,

  @JsonValue(0x00000020)
  ///
  /// India.
  ///
  IN,

  @JsonValue(0xffffffff)
  ///
  /// (Default) Global.
  ///
  GLOB,
}

///
/// The codec type of the output audio stream for CDN live
/// streaming. The default value is LC-ACC.
///
///
enum AudioCodecProfileType {
  @JsonValue(0)
  ///
  /// 0: (Default) LC-AAC, which is the low-complexity audio codec type.
  ///
  LCAAC,

  @JsonValue(1)
  ///
  /// 1: HE-AAC, which is the high-efficiency audio codec type.
  ///
  HEAAC,
}

///
/// The midrange frequency for audio equalization.
///
///
enum AudioEqualizationBandFrequency {
  @JsonValue(0)
  ///
  /// 0: 31 Hz
  ///
  Band31,

  @JsonValue(1)
  ///
  /// 1: 62 Hz
  ///
  Band62,

  @JsonValue(2)
  ///
  /// 2: 125 Hz
  ///
  Band125,

  @JsonValue(3)
  ///
  /// 3: 250 Hz
  ///
  Band250,

  @JsonValue(4)
  ///
  /// 4: 500 Hz
  ///
  Band500,

  @JsonValue(5)
  ///
  /// 5: 1 kHz
  ///
  Band1K,

  @JsonValue(6)
  ///
  /// 6: 2 kHz
  ///
  Band2K,

  @JsonValue(7)
  ///
  /// 7: 4 kHz
  ///
  Band4K,

  @JsonValue(8)
  ///
  /// 8: 8 kHz
  ///
  Band8K,

  @JsonValue(9)
  ///
  /// 9: 16 kHz
  ///
  Band16K,
}

///
/// Local audio state error codes.
///
///
enum AudioLocalError {
  @JsonValue(0)
  ///
  /// 0: The local audio is normal.
  ///
  Ok,

  @JsonValue(1)
  ///
  /// 1: No specified reason for the local audio failure.
  ///
  Failure,

  @JsonValue(2)
  ///
  /// 2: No permission to use the local audio device.
  ///
  DeviceNoPermission,

  @JsonValue(3)
  ///
  /// 3: The microphone is in use.
  ///
  DeviceBusy,

  @JsonValue(4)
  ///
  /// 4: The local audio capturing fails. Check whether the capturing device is working properly.
  ///
  RecordFailure,

  @JsonValue(5)
  ///
  /// 5: The local audio encoding fails.
  ///
  EncodeFailure,

  @JsonValue(8)
  Interrupted,
}

///
/// Local audio states.
///
///
enum AudioLocalState {
  @JsonValue(0)
  ///
  /// 0: The local audio is in the initial state.
  ///
  Stopped,

  @JsonValue(1)
  ///
  /// 1: The capturing device starts successfully.
  ///
  Recording,

  @JsonValue(2)
  ///
  /// 2: The first audio frame encodes successfully.
  ///
  Encoding,

  @JsonValue(3)
  ///
  /// 3: The local audio fails to start.
  ///
  Failed,
}

///
/// The information acquisition state. This enum is reported in requestAudioFileInfoCallback.
///
///
enum AudioFileInfoError {
  @JsonValue(0)
  ///
  /// 0: Successfully get the information of an audio file.
  ///
  Ok,

  @JsonValue(1)
  ///
  /// 1: Fail to get the information of an audio file.
  ///
  Failure,
}

///
/// Errors that might occur when playing a music
/// file.
///
///
@Deprecated('This enum is deprecated, pls use AudioMixingReason instead.')
enum AudioMixingErrorType {
  @JsonValue(701)
  ///
  /// The SDK cannot open the music file.
  ///
  CanNotOpen,

  @JsonValue(702)
  ///
  /// The SDK opens the music file too frequently.
  ///
  TooFrequentCall,

  @JsonValue(702)
  ///
  /// The playback of the music file is interrupted.
  ///
  InterruptedEOF,

  @JsonValue(0)
  ///
  /// The music file is playing.
  ///
  OK,
}

///
/// The reason why the playback state of the music file changes. Reported in the audioMixingStateChanged callback.
///
///
enum AudioMixingReason {
  @JsonValue(701)
  ///
  /// 701: The SDK cannot open the music file. For example, the local music file
  /// does not exist, the SDK does not support the file format, or  the SDK cannot
  /// access the music file URL.
  ///
  CanNotOpen,

  @JsonValue(702)
  ///
  /// 702: The SDK opens the music file too frequently. If you need to call startAudioMixing multiple times, ensure that the call interval is more than 500 ms.
  ///
  TooFrequentCall,

  @JsonValue(703)
  ///
  /// 703: The music file playback is interrupted.
  ///
  InterruptedEOF,

  @JsonValue(720)
  ///
  /// 720: The method call of startAudioMixing to play music
  /// files succeeds.
  ///
  StartedByUser,

  @JsonValue(721)
  ///
  /// 721: The music file completes a loop playback.
  ///
  OneLoopCompleted,

  @JsonValue(722)
  ///
  /// 722: The music file starts a new loop playback.
  ///
  StartNewLoop,

  @JsonValue(723)
  ///
  /// 723: The music file completes all loop playbacks.
  ///
  AllLoopsCompleted,

  @JsonValue(724)
  ///
  /// 724: The method call of stopAudioMixing to stop playing the
  /// music file succeeds.
  ///
  StoppedByUser,

  @JsonValue(725)
  ///
  /// 725: The method call of pauseAudioMixing to pause playing
  /// the music file succeeds.
  ///
  PausedByUser,

  @JsonValue(726)
  ///
  /// 726: The method call of resumeAudioMixing to resume playing
  /// the music file succeeds.
  ///
  ResumedByUser,

  @JsonValue(0)
  OK,
}

///
/// The playback state of the music file.
///
///
enum AudioMixingStateCode {
  @JsonValue(710)
  ///
  /// 710: The music file is playing.
  ///
  ///
  Playing,

  @JsonValue(711)
  ///
  /// 711: The music file pauses playing.
  ///
  ///
  Paused,

  @JsonValue(712)
  Restart,

  @JsonValue(713)
  ///
  /// 713: The music file stops playing.
  ///
  ///
  Stopped,

  @JsonValue(714)
  ///
  /// 714: An error occurs during the playback of the audio mixing file.
  ///
  ///
  Failed,
}

///
/// The channel mode. Set in setAudioMixingDualMonoMode.
///
///
enum AudioMixingDualMonoMode {
  @JsonValue(0)
  ///
  /// 0: Original mode.
  ///
  Auto,

  @JsonValue(1)
  ///
  /// 1: Left channel mode. This mode replaces the audio of the right channel with the audio of the left channel, which means the user can only hear the audio of the left channel.
  ///
  L,

  @JsonValue(2)
  ///
  /// 2: Right channel mode. This mode replaces the audio of the left channel with the audio of the right channel, which means the user can only hear the audio of the right channel.
  ///
  R,

  @JsonValue(3)
  ///
  /// 3: Mixed channel mode. This mode mixes the audio of the left channel and the right channel, which means the user can hear the audio of the left channel and the right channel at the same time.
  ///
  MIX,
}

///
/// The type of the audio route.
///
///
enum AudioOutputRouting {
  @JsonValue(-1)
  ///
  /// -1: The default audio route.
  ///
  Default,

  @JsonValue(0)
  ///
  /// 0: The headset.
  ///
  Headset,

  @JsonValue(1)
  ///
  /// 1: The earpiece.
  ///
  Earpiece,

  @JsonValue(2)
  ///
  /// 2: The headset with no microphone.
  ///
  HeadsetNoMic,

  @JsonValue(3)
  ///
  /// 3: The built-in speaker on a mobile device.
  ///
  Speakerphone,

  @JsonValue(4)
  ///
  /// 4: The external speaker.
  ///
  Loudspeaker,

  @JsonValue(5)
  ///
  /// 5: The bluetooth headset.
  ///
  HeadsetBluetooth,

  @JsonValue(6)
  USB,

  @JsonValue(7)
  HDMI,

  @JsonValue(8)
  DisplayPort,

  @JsonValue(9)
  AirPlay,
}

///
/// The audio profile.
///
///
enum AudioProfile {
  @JsonValue(0)
  ///
  /// 0: The default audio profile.
  /// For the LIVE_BROADCASTING profile: A sampling rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  /// For the COMMUNICATION profile:
  ///
  ///
  ///
  ///
  Default,

  @JsonValue(1)
  ///
  /// 1: A sampling rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
  ///
  SpeechStandard,

  @JsonValue(2)
  ///
  /// 2: A sampling rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
  ///
  MusicStandard,

  @JsonValue(3)
  ///
  /// 3: A sampling rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps.
  ///
  MusicStandardStereo,

  @JsonValue(4)
  ///
  /// 4: A sampling rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
  ///
  MusicHighQuality,

  @JsonValue(5)
  ///
  /// 5: A sampling rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
  ///
  MusicHighQualityStereo,
}

///
/// Recording quality.
///
///
enum AudioRecordingQuality {
  @JsonValue(0)
  ///
  /// 0: Low quality. The sample rate is 32 kHz, and the file size is around 1.2 MB for 10 minutes
  /// of recording.
  ///
  Low,

  @JsonValue(1)
  ///
  /// 1: Medium quality. The sample rate is 32 kHz, and the file size is around 2 MB for 10 minutes
  /// of recording.
  ///
  Medium,

  @JsonValue(2)
  ///
  /// 2: High quality. The sample rate is 32 kHz, and the file size is around 3.75 MB for 10 minutes
  /// of recording.
  ///
  High,
}

///
/// Recording content. Set in startAudioRecordingWithConfig.
///
///
enum AudioRecordingPosition {
  @JsonValue(0)
  ///
  /// 0: (Default) Records the mixed audio of the local and all remote users.
  ///
  PositionMixedRecordingAndPlayback,

  @JsonValue(1)
  ///
  /// 1: Only records the audio of the local user.
  ///
  PositionRecording,

  @JsonValue(2)
  ///
  /// 2: Only records the audio of all remote users.
  ///
  PositionMixedPlayback,
}

///
/// Remote audio states.
///
///
enum AudioRemoteState {
  @JsonValue(0)
  ///
  /// 0: The local audio is in the initial state. The SDK reports this state in the case of LocalMuted, RemoteMuted or RemoteOffline.
  ///
  Stopped,

  @JsonValue(1)
  ///
  /// 1: The first remote audio packet is received.
  ///
  Starting,

  @JsonValue(2)
  ///
  /// 2: The remote audio stream is decoded and plays normally. The SDK reports this state in the case of NetworkRecovery, LocalUnmuted or RemoteUnmuted.
  ///
  Decoding,

  @JsonValue(3)
  ///
  /// 3: The remote audio is frozen. The SDK reports this state in the case of NetworkCongestion.
  ///
  Frozen,

  @JsonValue(4)
  ///
  /// 4: The remote audio fails to start. The SDK reports this state in the case of Internal.
  ///
  Failed,
}

///
/// The reason for the remote audio state change.
///
///
enum AudioRemoteStateReason {
  @JsonValue(0)
  ///
  /// 0: The SDK reports this reason when the audio state changes.
  ///
  Internal,

  @JsonValue(1)
  ///
  /// 1: Network congestion.
  ///
  NetworkCongestion,

  @JsonValue(2)
  ///
  /// 2: Network recovery.
  ///
  NetworkRecovery,

  @JsonValue(3)
  ///
  /// 3: The local user stops receiving the remote audio stream or disables the audio module.
  ///
  LocalMuted,

  @JsonValue(4)
  ///
  /// 4: The local user resumes receiving the remote audio stream or enables the audio module.
  ///
  LocalUnmuted,

  @JsonValue(5)
  ///
  /// 5: The remote user stops sending the audio stream or disables the audio module.
  ///
  RemoteMuted,

  @JsonValue(6)
  ///
  /// 6: The remote user resumes sending the audio stream or enables the audio module.
  ///
  RemoteUnmuted,

  @JsonValue(7)
  ///
  /// 7: The remote user leaves the channel.
  ///
  RemoteOffline,
}

///
/// Voice reverb presets.
///
///
enum AudioReverbPreset {
  @JsonValue(0x00000000)
  ///
  /// Turn off voice reverb, that is, to use the original voice.
  ///
  Off,

  @JsonValue(0x00000001)
  Popular,

  @JsonValue(0x00000002)
  RnB,

  @JsonValue(0x00000003)
  Rock,

  @JsonValue(0x00000004)
  HipHop,

  @JsonValue(0x00000005)
  VocalConcert,

  @JsonValue(0x00000006)
  KTV,

  @JsonValue(0x00000007)
  Studio,

  @JsonValue(0x00100001)
  ///
  /// The reverb style typical of a KTV venue (enhanced).
  ///
  FX_KTV,

  @JsonValue(0x00100002)
  ///
  /// The reverb style typical of a concert hall (enhanced).
  ///
  FX_VOCAL_CONCERT,

  @JsonValue(0x00100003)
  ///
  /// A middle-aged man's voice.
  ///
  FX_UNCLE,

  @JsonValue(0x00100004)
  ///
  /// The reverb style typical of a young woman's voice.
  ///
  FX_SISTER,

  @JsonValue(0x00100005)
  ///
  /// The reverb style typical of a recording studio (enhanced).
  ///
  FX_STUDIO,

  @JsonValue(0x00100006)
  ///
  /// The reverb style typical of popular music (enhanced).
  ///
  FX_POPULAR,

  @JsonValue(0x00100007)
  ///
  /// The reverb style typical of R&B music (enhanced).
  ///
  FX_RNB,

  @JsonValue(0x00100008)
  ///
  /// The voice effect typical of a vintage phonograph.
  ///
  FX_PHONOGRAPH,

  @JsonValue(0x00200001)
  ///
  /// The reverberation of the virtual stereo. The virtual stereo is an effect that renders the monophonic audio as the stereo audio, so that all users in the channel can hear the stereo voice effect.
  ///
  VIRTUAL_STEREO,

  @JsonValue(0x00300001)
  AUDIO_ELECTRONIC_VOICE,

  @JsonValue(0x00400001)
  AUDIO_THREEDIM_VOICE,
}

///
/// Audio reverberation types.
///
///
enum AudioReverbType {
  @JsonValue(0)
  ///
  /// 0: The level of the dry signal (dB). The value is between -20 and 10.
  ///
  DryLevel,

  @JsonValue(1)
  ///
  /// 1: The level of the early reflection signal (wet signal) (dB). The value is between -20 and 10.
  ///
  WetLevel,

  @JsonValue(2)
  ///
  /// 2: The room size of the reflection. The value is between 0 and 100.
  ///
  RoomSize,

  @JsonValue(3)
  ///
  /// 3: The length of the initial delay of the wet signal (ms). The value is between 0 and 200.
  ///
  WetDelay,

  @JsonValue(4)
  ///
  /// 4: The reverberation strength. The value is between 0 and 100.
  ///
  Strength,
}

///
/// The audio sampling rate of the stream to be pushed to the CDN.
///
///
enum AudioSampleRateType {
  @JsonValue(32000)
  ///
  /// 32000: 32 kHz
  ///
  Type32000,

  @JsonValue(44100)
  ///
  /// 44100: 44.1 kHz
  ///
  Type44100,

  @JsonValue(48000)
  ///
  /// 48000: (Default) 48 kHz
  ///
  Type48000,
}

///
/// Audio application scenarios.
///
///
enum AudioScenario {
  @JsonValue(0)
  ///
  /// 0: The default audio scenario.
  ///
  Default,

  @JsonValue(1)
  ///
  /// 1: Entertainment scenario where users need to frequently switch the user role.
  ///
  ChatRoomEntertainment,

  @JsonValue(2)
  ///
  /// 2: Education scenario where users want smoothness and stability.
  ///
  Education,

  @JsonValue(3)
  ///
  /// 3: High-quality audio chatroom scenario where hosts mainly play music.
  ///
  GameStreaming,

  @JsonValue(4)
  ///
  /// 4: Showroom scenario where a single host wants high-quality audio.
  ///
  ShowRoom,

  @JsonValue(5)
  ///
  /// 5: Gaming scenario for group chat that only contains the human voice.
  ///
  ChatRoomGaming,

  @JsonValue(6)
  ///
  /// 6: IoT (Internet of Things) scenario where users use IoT devices with low power consumption.
  ///
  IOT,

  @JsonValue(8)
  ///
  /// 8: Meeting scenario that mainly contains the human voice.
  ///
  ///
  MEETING,
}

///
/// Local voice changer options.
///
///
enum AudioVoiceChanger {
  @JsonValue(0x00000000)
  ///
  /// The original voice (no local voice change).
  ///
  Off,

  @JsonValue(0x00000001)
  ///
  /// The voice of an old man.
  ///
  OldMan,

  @JsonValue(0x00000002)
  ///
  /// The voice of a little boy.
  ///
  BabyBoy,

  @JsonValue(0x00000003)
  ///
  /// The voice of a little girl.
  ///
  BabyGirl,

  @JsonValue(0x00000004)
  ///
  /// The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a growling bear.
  ///
  ZhuBaJie,

  @JsonValue(0x00000005)
  ///
  /// The ethereal voice.
  ///
  Ethereal,

  @JsonValue(0x00000006)
  ///
  /// The voice of Hulk.
  ///
  Hulk,

  @JsonValue(0x00100001)
  ///
  /// A more vigorous voice.
  ///
  BEAUTY_VIGOROUS,

  @JsonValue(0x00100002)
  ///
  /// A deeper voice.
  ///
  BEAUTY_DEEP,

  @JsonValue(0x00100003)
  ///
  /// A mellower voice.
  ///
  BEAUTY_MELLOW,

  @JsonValue(0x00100004)
  ///
  /// Falsetto.
  ///
  BEAUTY_FALSETTO,

  @JsonValue(0x00100005)
  ///
  /// A fuller voice.
  ///
  BEAUTY_FULL,

  @JsonValue(0x00100006)
  ///
  /// A clearer voice.
  ///
  BEAUTY_CLEAR,

  @JsonValue(0x00100007)
  ///
  /// A more resounding voice.
  ///
  BEAUTY_RESOUNDING,

  @JsonValue(0x00100008)
  ///
  /// A more ringing voice.
  ///
  BEAUTY_RINGING,

  @JsonValue(0x00100009)
  ///
  /// A more spatially resonant voice.
  ///
  BEAUTY_SPACIAL,

  @JsonValue(0x00200001)
  ///
  /// (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice distortion occurs.
  ///
  GENERAL_BEAUTY_VOICE_MALE_MAGNETIC,

  @JsonValue(0x00200002)
  ///
  /// (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
  ///
  GENERAL_BEAUTY_VOICE_FEMALE_FRESH,

  @JsonValue(0x00200003)
  ///
  /// (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs.
  ///
  GENERAL_BEAUTY_VOICE_FEMALE_VITALITY,
}

///
/// Camera capture preference.
///
///
enum CameraCaptureOutputPreference {
  @JsonValue(0)
  ///
  /// 0: (Default) Automatically adjust the camera capture preference. The SDK adjusts the camera output parameters according to the system performance and network conditions to balance CPU consumption and video preview quality.
  ///
  Auto,

  @JsonValue(1)
  ///
  /// 1: Prioritizes the system performance. The SDK chooses the dimension and frame rate of the local camera capture closest to those set by setVideoEncoderConfiguration. In this case, the local preview quality depends on the encoder.
  ///
  Performance,

  @JsonValue(2)
  ///
  /// 2: Prioritizes the local preview quality. The SDK chooses higher camera output parameters to improve the local video preview quality. This option requires extra CPU and RAM usage for video pre-processing.
  ///
  Preview,

  @JsonValue(3)
  ///
  /// 3: Allows you to customize the width and height of the video image captured by the local camera.
  ///
  ///
  Manual,
}

///
/// The camera direction.
///
///
enum CameraDirection {
  @JsonValue(0)
  ///
  /// The rear camera.
  ///
  Rear,

  @JsonValue(1)
  ///
  /// The front camera.
  ///
  Front,
}

///
/// The error code of the channel media replay.
///
///
enum ChannelMediaRelayError {
  @JsonValue(0)
  ///
  /// 0: No error.
  ///
  None,

  @JsonValue(1)
  ///
  /// 1: An error occurs in the server response.
  ///
  ServerErrorResponse,

  @JsonValue(2)
  ///
  /// 2: No server response.
  /// You can call leaveChannel to leave the channel.
  /// This error can also occur if your project has not enabled co-host token authentication. Contact support@agora.io to enable the co-host token authentication service before starting a channel media relay.
  ///
  ///
  ServerNoResponse,

  @JsonValue(3)
  ///
  /// 3: The SDK fails to access the service, probably due to limited resources of the server.
  ///
  NoResourceAvailable,

  @JsonValue(4)
  ///
  /// 4: Fails to send the relay request.
  ///
  FailedJoinSourceChannel,

  @JsonValue(5)
  ///
  /// 5: Fails to accept the relay request.
  ///
  FailedJoinDestinationChannel,

  @JsonValue(6)
  ///
  /// 6: The server fails to receive the media stream.
  ///
  FailedPacketReceivedFromSource,

  @JsonValue(7)
  ///
  /// 7: The server fails to send the media stream.
  ///
  FailedPacketSentToDestination,

  @JsonValue(8)
  ///
  /// 8: The SDK disconnects from the server due to poor network connections. You can call the leaveChannel method to leave the channel.
  ///
  ServerConnectionLost,

  @JsonValue(9)
  ///
  /// 9: An internal error occurs in the server.
  ///
  InternalError,

  @JsonValue(10)
  ///
  /// 10: The token of the source channel has expired.
  ///
  SourceTokenExpired,

  @JsonValue(11)
  ///
  /// 11: The token of the destination channel has expired.
  ///
  DestinationTokenExpired,
}

///
/// The event code of channel media relay.
///
///
enum ChannelMediaRelayEvent {
  @JsonValue(0)
  ///
  /// 0: The user disconnects from the server due to a poor network connection.
  ///
  Disconnect,

  @JsonValue(1)
  ///
  /// 1: The user is connected to the server.
  ///
  Connected,

  @JsonValue(2)
  ///
  /// 2: The user joins the source channel.
  ///
  JoinedSourceChannel,

  @JsonValue(3)
  ///
  /// 3: The user joins the destination channel.
  ///
  JoinedDestinationChannel,

  @JsonValue(4)
  ///
  /// 4: The SDK starts relaying the media stream to the destination channel.
  ///
  SentToDestinationChannel,

  @JsonValue(5)
  ///
  /// 5: The server receives the audio stream from the source channel.
  ///
  ReceivedVideoPacketFromSource,

  @JsonValue(6)
  ///
  /// 6: The server receives the audio stream from the source channel.
  ///
  ReceivedAudioPacketFromSource,

  @JsonValue(7)
  ///
  /// 7: The destination channel is updated.
  ///
  UpdateDestinationChannel,

  @JsonValue(8)
  ///
  /// 8: The destination channel update fails due to internal reasons.
  ///
  UpdateDestinationChannelRefused,

  @JsonValue(9)
  ///
  /// 9: The destination channel does not change, which means that the destination channel fails to be updated.
  ///
  UpdateDestinationChannelNotChange,

  @JsonValue(10)
  ///
  /// 10: The destination channel name is null.
  ///
  UpdateDestinationChannelIsNil,

  @JsonValue(11)
  ///
  /// 11: The video profile is sent to the server.
  ///
  VideoProfileUpdate,

  @JsonValue(12)
  ///
  /// 12: The SDK successfully pauses relaying the media stream to destination channels.
  ///
  PauseSendPacketToDestChannelSuccess,

  @JsonValue(13)
  ///
  /// 13: The SDK fails to pause relaying the media stream to destination channels.
  ///
  PauseSendPacketToDestChannelFailed,

  @JsonValue(14)
  ///
  /// 14: The SDK successfully resumes relaying the media stream to destination channels.
  ///
  ResumeSendPacketToDestChannelSuccess,

  @JsonValue(15)
  ///
  /// 15: The SDK fails to resume relaying the media stream to destination channels.
  ///
  ResumeSendPacketToDestChannelFailed,
}

///
/// The state code of the channel media relay.
///
///
enum ChannelMediaRelayState {
  @JsonValue(0)
  ///
  /// 0: The initial state. After you successfully stop the channel media relay by calling stopChannelMediaRelay, the channelMediaRelayStateChanged callback returns this state.
  ///
  Idle,

  @JsonValue(1)
  ///
  /// 1: The SDK tries to relay the media stream to the destination channel.
  ///
  Connecting,

  @JsonValue(2)
  ///
  /// 2: The SDK successfully relays the media stream to the destination channel.
  ///
  Running,

  @JsonValue(3)
  ///
  /// 3: An error occurs. See code in channelMediaRelayStateChanged for the error code.
  ///
  Failure,
}

///
/// The channel profile.
///
///
enum ChannelProfile {
  @JsonValue(0)
  ///
  /// 0: (Default) The communication profile. This profile applies to scenarios such as an audio call or video call, where all users can publish and subscribe to streams.
  ///
  Communication,

  @JsonValue(1)
  ///
  /// 1: Live streaming. In this profile, you can set the role of users as the host or audience by calling setClientRole. A host both publishes and subscribes to streams, while an audience subscribes to streams only. This profile applies to scenarios such as a chat room or interactive video streaming.
  ///
  LiveBroadcasting,

  @JsonValue(2)
  ///
  /// 2: Gaming. Agora does not recommend using this setting.
  ///
  Game,
}

///
/// The user role in the interactive live streaming.
///
///
enum ClientRole {
  @JsonValue(1)
  ///
  /// 1: Host. A host can both send and receive streams.
  ///
  Broadcaster,

  @JsonValue(2)
  ///
  /// 2: (Default) Audience. An audience member can only receive streams.
  ///
  Audience,
}

///
/// Reasons causing the change of the connection state.
///
///
enum ConnectionChangedReason {
  @JsonValue(0)
  ///
  /// 0: The SDK is connecting to the Agora edge server.
  ///
  Connecting,

  @JsonValue(1)
  ///
  /// 1: The SDK has joined the channel successfully.
  ///
  JoinSuccess,

  @JsonValue(2)
  ///
  /// 2: The connection between the SDK and the Agora edge server is interrupted.
  ///
  Interrupted,

  @JsonValue(3)
  ///
  /// 3: The connection between the SDK and the Agora edge server is banned by the Agora edge server. This error occurs when the user is kicked out of the channel by the server.
  ///
  BannedByServer,

  @JsonValue(4)
  ///
  /// 4: The SDK fails to join the channel. When the SDK fails to join the channel for more than 20 minutes, this error occurs and the SDK stops reconnecting to the channel.
  ///
  JoinFailed,

  @JsonValue(5)
  ///
  /// 5: The SDK has left the channel.
  ///
  LeaveChannel,

  @JsonValue(6)
  ///
  /// 6: The connection failed because the App ID is not valid. Please rejoin the channel with a valid App ID.
  ///
  InvalidAppId,

  @JsonValue(7)
  ///
  /// 7: The connection failed since channel name is not valid. Please rejoin the channel with a valid channel name.
  ///
  InvalidChannelName,

  @JsonValue(8)
  ///
  /// 8: The connection failed because the token is not valid. Typical reasons include:
  /// The App Certificate for the project is enabled in Agora Console, but you do not use a token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
  /// The uid specified when calling joinChannel to join the channel is inconsistent with the uid passed in when generating the token.
  ///
  ///
  InvalidToken,

  @JsonValue(9)
  ///
  /// 9: The connection failed since token is expired.
  ///
  TokenExpired,

  @JsonValue(10)
  ///
  /// 10: The connection is rejected by server. Typical reasons include:
  /// The user is already in the channel and still calls a method, for example, joinChannel, to join the channel. Stop calling this method to clear this error.
  /// The user tries to join the channel when conducting  a pre-call test. The user needs to call the channel after the call test ends.
  ///
  ///
  ///
  RejectedByServer,

  @JsonValue(11)
  ///
  /// 11: The connection state changed to reconnecting because the SDK has set a proxy server.
  ///
  SettingProxyServer,

  @JsonValue(12)
  ///
  /// 12: The connection state changed because the token is renewed.
  ///
  RenewToken,

  @JsonValue(13)
  ///
  /// 13: The IP address of the client has changed, possibly because the network type, IP address, or port has been changed.
  ///
  ClientIpAddressChanged,

  @JsonValue(14)
  ///
  /// 14: Timeout for the keep-alive of the connection between the SDK and the Agora edge server. The connection state changes to Reconnecting.
  ///
  KeepAliveTimeout,

  @JsonValue(15)
  ProxyServerInterrupted,
}

///
/// Connection states.
///
///
enum ConnectionStateType {
  @JsonValue(1)
  ///
  /// 1: The SDK is disconnected from the Agora edge server. The state indicates the SDK is in one of the following phases:
  /// The initial state before calling the joinChannel method.
  /// The app calls the leaveChannel method.
  ///
  ///
  ///
  Disconnected,

  @JsonValue(2)
  ///
  /// 2: The SDK is connecting to the Agora edge server. This state indicates that the SDK is establishing a connection with the specified channel after the app calls joinChannel.
  ///
  ///
  /// 4: The SDK keeps reconnecting to the Agora edge server. The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.
  /// If the SDK cannot rejoin the channel within 10 seconds, it triggers connectionLost, stays in the Reconnecting state, and keeps rejoining the channel.
  ///
  /// 5: The SDK fails to connect to the Agora edge server or join the channel. This state indicates that the SDK stops trying to rejoin the channel. You must call leaveChannel to leave the channel.
  /// You can call joinChannel to rejoin the channel.
  /// If the SDK is banned from joining the channel by the Agora edge server through the RESTful API, the SDK triggers the connectionStateChanged callback.
  ///
  ///
  /// If the SDK fails to rejoin the channel 20 minutes after being disconnected from the Agora edge server, the SDK triggers the connectionStateChanged callback, switches to the Failed state, and stops rejoining the channel.
  ///
  ///
  /// 3: The SDK is connected to the Agora edge server. This state also indicates that the user has joined a channel and can now publish or subscribe to a media stream in the channel. If the connection to the Agora edge server is lost because, for example, the network is down or switched, the SDK automatically tries to reconnect and triggers connectionStateChanged that indicates the connection state switches to Reconnecting.
  ///
  /// If the SDK successfully joins the channel, it triggers the connectionStateChanged callback and the connection state switches to Connected.
  /// After the connection is established, the SDK also initializes the media and triggers joinChannelSuccess when everything is ready.
  ///
  ///
  ///
  Connecting,

  @JsonValue(3)
  Connected,

  @JsonValue(4)
  Reconnecting,

  @JsonValue(5)
  Failed,
}

///
/// Video degradation preferences when the bandwidth is a constraint.
///
///
enum DegradationPreference {
  @JsonValue(0)
  ///
  /// 0: (Default) Prefers to reduce the video frame rate while maintaining video quality during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.
  ///   In the COMMUNICATION channel profile, the resolution of the video sent may change, so remote users need to handle this issue. See videoSizeChanged.
  ///
  MaintainQuality,

  @JsonValue(1)
  ///
  /// 1: Prefers to reduce the video quality while maintaining the video frame rate during video encoding under limited bandwidth. This degradation preference is suitable for scenarios where smoothness is prioritized and video quality is allowed to be reduced.
  ///
  MaintainFramerate,

  @JsonValue(2)
  ///
  /// 2: Reduces the video frame rate and video quality simultaneously during video encoding under limited bandwidth. MaintainBalanced has a lower reduction than MaintainQuality and MaintainFramerate, and this preference is suitable for scenarios where both smoothness and video quality are a priority.
  /// The resolution of the video sent may change, so remote users need to handle this issue. See videoSizeChanged.
  ///
  ///
  MaintainBalanced
}

///
/// The built-in encryption mode.
/// Agora recommends using AES128GCM2 or AES256GCM2 encrypted mode. These two modes support the use of salt for higher security.
///
enum EncryptionMode {
  @deprecated
  @JsonValue(0)
  None,

  @JsonValue(1)
  AES128XTS,

  @JsonValue(2)
  AES128ECB,

  @JsonValue(3)
  AES256XTS,

  @JsonValue(4)
  ///
  /// 4: 128-bit SM4 encryption, ECB mode.
  ///
  SM4128ECB,

  @JsonValue(5)
  AES128GCM,

  @JsonValue(6)
  AES256GCM,

  @JsonValue(7)
  ///
  /// 7: 128-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (encryptionKdfSalt).
  ///
  AES128GCM2,

  @JsonValue(8)
  ///
  /// 8: 256-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (encryptionKdfSalt).
  ///
  AES256GCM2,
}

/* enum-ErrorCode */
enum ErrorCode {
  @JsonValue(0)
  NoError,

  @JsonValue(1)
  Failed,

  @JsonValue(2)
  InvalidArgument,

  @JsonValue(3)
  NotReady,

  @JsonValue(4)
  NotSupported,

  @JsonValue(5)
  Refused,

  @JsonValue(6)
  BufferTooSmall,

  @JsonValue(7)
  NotInitialized,

  @JsonValue(9)
  NoPermission,

  @JsonValue(10)
  TimedOut,

  @JsonValue(11)
  Canceled,

  @JsonValue(12)
  TooOften,

  @JsonValue(13)
  BindSocket,

  @JsonValue(14)
  NetDown,

  @JsonValue(15)
  NoBufs,

  @JsonValue(17)
  JoinChannelRejected,

  @JsonValue(18)
  LeaveChannelRejected,

  @JsonValue(19)
  AlreadyInUse,

  @JsonValue(20)
  Abort,

  @JsonValue(21)
  InitNetEngine,

  @JsonValue(22)
  ResourceLimited,

  @JsonValue(101)
  InvalidAppId,

  @JsonValue(102)
  InvalidChannelId,

  @JsonValue(103)
  NoServerResources,

  @deprecated
  @JsonValue(109)
  TokenExpired,

  @deprecated
  @JsonValue(110)
  InvalidToken,

  @JsonValue(111)
  ConnectionInterrupted,

  @JsonValue(112)
  ConnectionLost,

  @JsonValue(113)
  NotInChannel,

  @JsonValue(114)
  SizeTooLarge,

  @JsonValue(115)
  BitrateLimit,

  @JsonValue(116)
  TooManyDataStreams,

  @JsonValue(120)
  DecryptionFailed,

  @JsonValue(123)
  ClientIsBannedByServer,

  @JsonValue(124)
  WatermarkParam,

  @JsonValue(125)
  WatermarkPath,

  @JsonValue(126)
  WatermarkPng,

  @JsonValue(127)
  WatermarkInfo,

  @JsonValue(128)
  WatermarkAGRB,

  @JsonValue(129)
  WatermarkRead,

  @JsonValue(130)
  EncryptedStreamNotAllowedPublish,

  @JsonValue(134)
  InvalidUserAccount,

  @JsonValue(151)
  PublishStreamCDNError,

  @JsonValue(152)
  PublishStreamNumReachLimit,

  @JsonValue(153)
  PublishStreamNotAuthorized,

  @JsonValue(154)
  PublishStreamInternalServerError,

  @JsonValue(155)
  PublishStreamNotFound,

  @JsonValue(156)
  PublishStreamFormatNotSuppported,

  @JsonValue(157)
  ModuleNotFound,

  @JsonValue(160)
  AlreadyInRecording,

  @JsonValue(1001)
  LoadMediaEngine,

  @JsonValue(1002)
  StartCall,

  @deprecated
  @JsonValue(1003)
  StartCamera,

  @JsonValue(1004)
  StartVideoRender,

  @JsonValue(1005)
  AdmGeneralError,

  @JsonValue(1006)
  AdmJavaResource,

  @JsonValue(1007)
  AdmSampleRate,

  @JsonValue(1008)
  AdmInitPlayout,

  @JsonValue(1009)
  AdmStartPlayout,

  @JsonValue(1010)
  AdmStopPlayout,

  @JsonValue(1011)
  AdmInitRecording,

  @JsonValue(1012)
  AdmStartRecording,

  @JsonValue(1013)
  AdmStopRecording,

  @JsonValue(1015)
  AdmRuntimePlayoutError,

  @JsonValue(1017)
  AdmRuntimeRecordingError,

  @JsonValue(1018)
  AdmRecordAudioFailed,

  @JsonValue(1020)
  AdmPlayAbnormalFrequency,

  @JsonValue(1021)
  AdmRecordAbnormalFrequency,

  @JsonValue(1022)
  AdmInitLoopback,

  @JsonValue(1023)
  AdmStartLoopback,

  @JsonValue(1027)
  AdmNoPermission,

  @JsonValue(1030)
  AudioBtScoFailed,

  @JsonValue(1359)
  AdmNoRecordingDevice,

  @JsonValue(1360)
  AdmNoPlayoutDevice,

  @JsonValue(1501)
  VdmCameraNotAuthorized,

  @JsonValue(1600)
  VcmUnknownError,

  @JsonValue(1601)
  VcmEncoderInitError,

  @JsonValue(1602)
  VcmEncoderEncodeError,

  @deprecated
  @JsonValue(1603)
  VcmEncoderSetError,
}

///
/// States of importing an external video stream in the interactive live streaming.
///
///
enum InjectStreamStatus {
  @JsonValue(0)
  ///
  /// 0: The external video stream is imported successfully.
  ///
  StartSuccess,

  @JsonValue(1)
  ///
  /// 1: The external video stream already exists.
  ///
  StartAlreadyExists,

  @JsonValue(2)
  ///
  /// 2: The external video stream to be imported is unauthorized.
  ///
  StartUnauthorized,

  @JsonValue(3)
  ///
  /// 3: A timeout occurs when importing the external video stream.
  ///
  StartTimedout,

  @JsonValue(4)
  ///
  /// 4: The SDK fails to import the external video stream.
  ///
  StartFailed,

  @JsonValue(5)
  ///
  /// 5: The SDK successfully stops importing the external video stream.
  ///
  StopSuccess,

  @JsonValue(6)
  ///
  /// 6: The external video stream to be stopped importing is not found.
  ///
  StopNotFound,

  @JsonValue(7)
  ///
  /// 7: The external video stream to be stopped importing is unauthorized.
  ///
  StopUnauthorized,

  @JsonValue(8)
  ///
  /// 8: A timeout occurs when stopping importing the external video stream.
  ///
  StopTimedout,

  @JsonValue(9)
  ///
  /// 9: The SDK fails to stop importing the external video stream.
  ///
  StopFailed,

  @JsonValue(10)
  ///
  /// 10: The external video stream is corrupted.
  ///
  Broken,
}

///
/// The status of the last-mile network tests.
///
///
enum LastmileProbeResultState {
  @JsonValue(1)
  ///
  /// 1: The last-mile network probe test is complete.
  ///
  Complete,

  @JsonValue(2)
  ///
  /// 2: The last-mile network probe test is incomplete because the bandwidth estimation is not available due to limited test resources.
  ///
  IncompleteNoBwe,

  @JsonValue(3)
  ///
  /// 3: The last-mile network probe test is not carried out, probably due to poor network conditions.
  ///
  Unavailable,
}

///
/// The contrast level.
///
///
enum LighteningContrastLevel {
  @JsonValue(0)
  ///
  /// Low contrast level.
  ///
  Low,

  @JsonValue(1)
  ///
  /// (Default) Normal contrast level.
  ///
  Normal,

  @JsonValue(2)
  ///
  /// High contrast level.
  ///
  High,
}

///
/// Local video state error codes.
///
///
enum LocalVideoStreamError {
  @JsonValue(0)
  ///
  /// 0: The local video is normal.
  ///
  OK,

  @JsonValue(1)
  ///
  /// 1: No specified reason for the local video failure.
  ///
  Failure,

  @JsonValue(2)
  ///
  /// 2: No permission to use the local video capturing device.
  ///
  DeviceNoPermission,

  @JsonValue(3)
  ///
  /// 3: The local video capturing device is in use.
  ///
  DeviceBusy,

  @JsonValue(4)
  ///
  /// 4: The local video capture fails. Check whether the capturing device is working properly.
  ///
  CaptureFailure,

  @JsonValue(5)
  ///
  /// 5: The local video encoding fails.
  ///
  EncodeFailure,

  @JsonValue(6)
  ///
  /// 6: The local video capturing device not available due to app did enter background.
  ///
  CaptureInBackground,

  @JsonValue(7)
  ///
  /// 7: The local video capturing device not available because the app is running in a multi-app layout (generally on the pad).
  ///
  CaptureMultipleForegroundApps,

  @JsonValue(8)
  ///
  /// 8: Fails to find a local video capture device.
  ///
  ///
  DeviceNotFound,

  @JsonValue(11)
  ///
  /// startScreenCaptureByWindowId11: When calling to share the window, the shared window is in a minimized state.
  ///
  ScreenCaptureWindowMinmized,

  @JsonValue(12)
  ///
  /// 12: The error code indicates that a window shared by the window ID has been closed, or a full-screen window shared by the window ID has exited full-screen mode. After exiting full-screen mode, remote users cannot see the shared window. To prevent remote users from seeing a black screen, Agora recommends that you immediately stop screen sharing.
  /// Common scenarios for reporting this error code:
  ///  When the local user closes the shared window, the SDK reports this error code.
  /// The local user shows some slides in full-screen mode first, and then shares the windows of the slides. After the user exits full-screen mode, the SDK reports this error code.
  /// The local user watches web video or reads web document in full-screen mode first, and then shares the window of the web video or document. After the user exits full-screen mode, the SDK reports this error code.
  ///
  ///
  ///
  ScreenCaptureWindowClosed,

  @JsonValue(10)
  ///
  /// 10: (macOS and Windows only) The SDK cannot find the video device in the video device list. Check whether the ID of the video device is valid.
  ///
  LocalVideoStreamErrorDeviceInvalidId,

  @JsonValue(13)
  ///
  /// 13: (Windows only) The window being shared is overlapped by another window, so the overlapped area is blacked out by the SDK during window sharing.
  ///
  LocalVideoStreamErrorScreenCaptureWindowOccluded,

  @JsonValue(20)
  ///
  /// 20: (Windows only) The SDK does not support sharing this type of window.
  ///
  LocalVideoStreamErrorScreenCaptureWindowNotSupported,
}

///
/// Local video state types
///
///
enum LocalVideoStreamState {
  @JsonValue(0)
  ///
  /// 0: The local video is in the initial state.
  ///
  Stopped,

  @JsonValue(1)
  ///
  /// 1: The local video capturing device starts successfully.
  ///
  Capturing,

  @JsonValue(2)
  ///
  /// 2: The first video frame is successfully encoded.
  ///
  Encoding,

  @JsonValue(3)
  ///
  /// 3: Fails to start the local video.
  ///
  Failed,
}

///
/// The output log level of the SDK.
///
///
enum LogFilter {
  @JsonValue(0)
  ///
  /// 0: Do not output any log information.
  ///
  Off,

  @JsonValue(0x080f)
  ///
  /// 0x080f: Output all log information. Set your log filter as DEBUG if you want to get the most complete log file.
  ///
  Debug,

  @JsonValue(0x000f)
  ///
  /// 0x000f: Output CRITICAL, ERROR, WARNING, and INFO level log information. We recommend setting your log filter as this level.
  ///
  Info,

  @JsonValue(0x000e)
  ///
  /// 0x000e: Output CRITICAL, ERROR, and WARNING level log information.
  ///
  Warning,

  @JsonValue(0x000c)
  ///
  /// 0x000c: Output CRITICAL and ERROR level log information.
  ///
  Error,

  @JsonValue(0x0008)
  ///
  /// 0x0008: Output CRITICAL level log information.
  ///
  Critical,
}

///
/// Network quality types.
///
///
enum NetworkQuality {
  @JsonValue(0)
  ///
  /// 0: The network quality is unknown.
  ///
  Unknown,

  @JsonValue(1)
  ///
  /// 1: The network quality is excellent.
  ///
  Excellent,

  @JsonValue(2)
  ///
  /// 2: The network quality is quite good, but the bitrate may be slightly lower than excellent.
  ///
  Good,

  @JsonValue(3)
  ///
  /// 3: Users can feel the communication slightly impaired.
  ///
  Poor,

  @JsonValue(4)
  ///
  /// 4: Users cannot communicate smoothly.
  ///
  Bad,

  @JsonValue(5)
  ///
  /// 5: The quality is so bad that users can barely communicate.
  ///
  VBad,

  @JsonValue(6)
  ///
  /// 6: The network is down and users cannot communicate at all.
  ///
  Down,

  @JsonValue(7)
  ///
  /// 7: Users cannot detect the network quality. (Not in use.)
  ///
  Unsupported,

  @JsonValue(8)
  ///
  /// 8: Detecting the network quality.
  ///
  Detecting,
}

///
/// Network type.
///
///
enum NetworkType {
  @JsonValue(-1)
  ///
  /// -1: The network type is unknown.
  ///
  Unknown,

  @JsonValue(0)
  ///
  /// 0: The SDK disconnects from the network.
  ///
  Disconnected,

  @JsonValue(1)
  ///
  /// 1: The network type is LAN.
  ///
  LAN,

  @JsonValue(2)
  ///
  /// 2: The network type is Wi-Fi (including hotspots).
  ///
  WIFI,

  @JsonValue(3)
  ///
  /// 3: The network type is mobile 2G.
  ///
  Mobile2G,

  @JsonValue(4)
  ///
  /// 4: The network type is mobile 3G.
  ///
  Mobile3G,

  @JsonValue(5)
  ///
  /// 5: The network type is mobile 4G.
  ///
  Mobile4G,

  @JsonValue(6)
  Mobile5G,
}

///
/// Error codes of the RTMP or RTMPS streaming.
///
///
enum RtmpStreamingErrorCode {
  @JsonValue(0)
  ///
  /// The RTMP or RTMPS streaming publishes successfully.
  ///
  OK,

  @JsonValue(1)
  ///
  /// Invalid argument used. Please check the parameter setting. For example, if you do not call setLiveTranscoding to set the transcoding parameters before calling addPublishStreamUrl, the SDK returns this error.
  ///
  InvalidParameters,

  @JsonValue(2)
  ///
  /// Check whether you set the parameters in the setLiveTranscoding method properly.
  ///
  EncryptedStreamNotAllowed,

  @JsonValue(3)
  ///
  /// The RTMP or RTMPS streaming is encrypted and cannot be published. Call addPublishStreamUrl to re-publish the stream.
  ///
  ConnectionTimeout,

  @JsonValue(4)
  ///
  /// An error occurs in Agora's streaming server. Call the addPublishStreamUrl method to publish the streaming again.
  ///
  InternalServerError,

  @JsonValue(5)
  ///
  /// An error occurs in the CDN server.
  ///
  RtmpServerError,

  @JsonValue(6)
  ///
  /// The RTMP or RTMPS streaming publishes too frequently.
  ///
  TooOften,

  @JsonValue(7)
  ///
  /// The host has published more than 10 URLs. Delete the unnecessary URLs before adding new ones.
  ///
  ReachLimit,

  @JsonValue(8)
  ///
  /// The host manipulates other hosts' streams. For example, the host updates or stops other hosts' streams. Check your app logic.
  ///
  NotAuthorized,

  @JsonValue(9)
  ///
  /// Agora's server fails to find the RTMP or RTMPS streaming.
  ///
  StreamNotFound,

  @JsonValue(10)
  ///
  /// The URL format is incorrect. Check whether the URL format is correct.
  ///
  FormatNotSupported,

  @JsonValue(100)
  UnPublishOK,
}

///
/// States of the RTMP or RTMPS streaming.
///
///
enum RtmpStreamingState {
  @JsonValue(0)
  ///
  /// The RTMP or RTMPS streaming has not started or has ended. This state is also triggered after you remove an RTMP or RTMPS stream from the CDN by calling removePublishStreamUrl.
  ///
  Idle,

  @JsonValue(1)
  ///
  /// The SDK is connecting to Agora's streaming server and the CDN server. This state is triggered after you call the addPublishStreamUrl method.
  ///
  Connecting,

  @JsonValue(2)
  ///
  /// The RTMP or RTMPS streaming publishes. The SDK successfully publishes the RTMP or RTMPS streaming and returns this state.
  ///
  Running,

  @JsonValue(3)
  ///
  /// The RTMP or RTMPS streaming is recovering. When exceptions occur to the CDN, or the streaming is interrupted, the SDK tries to resume RTMP or RTMPS streaming and returns this state.
  ///
  ///  If the SDK successfully resumes the streaming, Running(2) returns.
  ///
  /// The RTMP or RTMPS streaming fails. See the error code for the detailed error information. You can also call the addPublishStreamUrl method to publish the RTMP or RTMPS stream again.
  ///
  ///  If the streaming does not resume within 60 seconds or server errors occur, Failure(4) returns. You can also reconnect to the server by calling the removePublishStreamUrl and addPublishStreamUrl methods.
  ///
  ///
  ///
  Recovering,

  @JsonValue(4)
  Failure,
}

///
/// Stream fallback options.
///
///
enum StreamFallbackOptions {
  @JsonValue(0)
  ///
  /// 0: No fallback behavior for the local/remote video stream when the uplink/downlink network conditions are poor. The quality of the stream is not guaranteed.
  ///
  Disabled,

  @JsonValue(1)
  ///
  /// 1: Under poor downlink network conditions, the remote video stream, to which you subscribe, falls back to the low-quality (low resolution and low bitrate) video stream. This option is only valid for setRemoteSubscribeFallbackOption and is invalid for setLocalPublishFallbackOption.
  ///
  VideoStreamLow,

  @JsonValue(2)
  ///
  /// 2: Under poor uplink network conditions, the published video stream falls back to audio only. Under poor downlink network conditions, the remote video stream, to which you subscribe, first falls back to the low-quality (low resolution and low bitrate) video stream; and then to an audio-only stream if the network conditions worsen.
  ///
  AudioOnly,
}

///
/// Reasons for a user being offline.
///
///
enum UserOfflineReason {
  @JsonValue(0)
  ///
  /// 0: The user quits the call.
  ///
  Quit,

  @JsonValue(1)
  ///
  /// 1: The SDK times out and the user drops offline because no data packet is received within a certain period of time.
  /// If the user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline.
  ///
  Dropped,

  @JsonValue(2)
  ///
  /// 2: The user switches the client role from the host to the audience.
  ///
  BecomeAudience,
}

///
/// The priority of the remote user.
///
///
enum UserPriority {
  @JsonValue(50)
  ///
  /// The user's priority is high.
  ///
  High,

  @JsonValue(100)
  ///
  /// (Default) The user's priority is normal.
  ///
  Normal,
}

///
/// Video codec profile types.
///
///
enum VideoCodecProfileType {
  @JsonValue(66)
  ///
  /// 66: Baseline video codec profile. Generally used for video calls on mobile phones.
  ///
  BaseLine,

  @JsonValue(77)
  ///
  /// 77: Main video codec profile. Generally used in mainstream electronics such as MP4 players, portable video players, PSP, and iPads.
  ///
  Main,

  @JsonValue(100)
  ///
  /// 100: (Default) High video codec profile. Generally used in high-resolution live streaming or television.
  ///
  High,
}

///
/// Video frame rate.
///
///
enum VideoFrameRate {
  @JsonValue(-1)
  Min,

  @JsonValue(1)
  ///
  /// 1: 1 fps
  ///
  Fps1,

  @JsonValue(7)
  ///
  /// 7: 7 fps
  ///
  Fps7,

  @JsonValue(10)
  ///
  /// 10: 10 fps
  ///
  Fps10,

  @JsonValue(15)
  ///
  /// 15: 15 fps
  ///
  Fps15,

  @JsonValue(24)
  ///
  /// 24: 24 fps
  ///
  Fps24,

  @JsonValue(30)
  ///
  /// 30: 30 fps
  ///
  Fps30,

  @JsonValue(60)
  Fps60,
}

/* enum-BitRate */
enum BitRate {
  @JsonValue(0)
  Standard,

  @JsonValue(-1)
  Compatible,
}

///
/// Video mirror mode.
///
///
enum VideoMirrorMode {
  @JsonValue(0)
  ///
  /// 0: (Default) The SDK determines the mirror mode.
  ///
  Auto,

  @JsonValue(1)
  ///
  /// 1: Enable mirror mode.
  ///
  Enabled,

  @JsonValue(2)
  ///
  /// 2: Disable mirror mode.
  ///
  Disabled,
}

///
/// Video output orientation modes.
///
///
enum VideoOutputOrientationMode {
  @JsonValue(0)
  ///
  /// 0: (Default) The output video always follows the orientation of the captured video. The receiver takes the rotational information passed on from the video encoder. This mode applies to scenarios where video orientation can be adjusted on the receiver.
  ///
  ///  If the captured video is in landscape mode, the output video is in landscape mode.
  ///  If the captured video is in portrait mode, the output video is in portrait mode.
  ///
  ///
  ///
  Adaptative,

  @JsonValue(1)
  ///
  /// 1: In this mode, the SDK always outputs videos in landscape (horizontal) mode. If the captured video is in portrait mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
  ///
  FixedLandscape,

  @JsonValue(2)
  ///
  /// 2: In this mode, the SDK always outputs video in portrait (portrait) mode. If the captured video is in landscape mode, the video encoder crops it to fit the output. Applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.
  ///
  FixedPortrait,
}

///
/// Quality change of the local video in terms of target frame rate and target bit rate since last count.
///
///
enum VideoQualityAdaptIndication {
  @JsonValue(0)
  ///
  /// 0: The local video quality stays the same.
  ///
  AdaptNone,

  @JsonValue(1)
  ///
  /// 1: The local video quality improves because the network bandwidth increases.
  ///
  AdaptUpBandwidth,

  @JsonValue(2)
  ///
  /// 2: The local video quality deteriorates because the network bandwidth decreases.
  ///
  AdaptDownBandwidth,
}

///
/// The state of the remote video.
///
///
enum VideoRemoteState {
  @JsonValue(0)
  ///
  /// 0: The remote video is in the initial state. The SDK reports this state in the case of LocalMuted, RemoteMuted or RemoteOffline.
  ///
  Stopped,

  @JsonValue(1)
  ///
  /// 1: The first remote video packet is received.
  ///
  Starting,

  @JsonValue(2)
  ///
  /// 2: The remote video stream is decoded and plays normally. The SDK reports this state in the case of NetworkRecovery, LocalUnmuted,RemoteUnmuted, or AudioFallbackRecovery.
  ///
  Decoding,

  @JsonValue(3)
  ///
  /// 3: The remote video is frozen. The SDK reports this state in the case of NetworkCongestion or AudioFallback.
  ///
  Frozen,

  @JsonValue(4)
  ///
  /// 4: The remote video fails to start. The SDK reports this state in the case of Internal.
  ///
  Failed,
}

///
/// The reason for the remote video state change.
///
///
enum VideoRemoteStateReason {
  @JsonValue(0)
  ///
  /// 0: The SDK reports this reason when the video state changes.
  ///
  Internal,

  @JsonValue(1)
  ///
  /// 1: Network congestion.
  ///
  NetworkCongestion,

  @JsonValue(2)
  ///
  /// 2: Network recovery.
  ///
  NetworkRecovery,

  @JsonValue(3)
  ///
  /// 3: The local user stops receiving the remote video stream or disables the video module.
  ///
  LocalMuted,

  @JsonValue(4)
  ///
  /// 4: The local user resumes receiving the remote video stream or enables the video module.
  ///
  LocalUnmuted,

  @JsonValue(5)
  ///
  /// 5: The remote user stops sending the video stream or disables the video module.
  ///
  RemoteMuted,

  @JsonValue(6)
  ///
  /// 6: The remote user resumes sending the video stream or enables the video module.
  ///
  RemoteUnmuted,

  @JsonValue(7)
  ///
  /// 7: The remote user leaves the channel.
  ///
  RemoteOffline,

  @JsonValue(8)
  ///
  /// 8: The remote audio-and-video stream falls back to the audio-only stream due to poor network conditions.
  ///
  AudioFallback,

  @JsonValue(9)
  ///
  /// 9: The remote audio-only stream switches back to the audio-and-video stream after the network conditions improve.
  ///
  AudioFallbackRecovery,
}

///
/// Video display modes.
///
///
enum VideoRenderMode {
  @JsonValue(1)
  ///
  /// 1: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Hidden mode. One dimension of the video may have clipped contents.
  ///
  Hidden,

  @JsonValue(2)
  ///
  /// 2: Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Fit mode. Areas that are not filled due to disparity in the aspect ratio are filled with black.
  ///
  Fit,

  @deprecated
  @JsonValue(3)
  ///
  ///
  ///
  /// Deprecated:
  /// 3: This mode is deprecated.
  ///
  ///
  ///
  Adaptive,

  @JsonValue(4)
  FILL,
}

///
/// The type of video streams.
///
///
enum VideoStreamType {
  @JsonValue(0)
  ///
  /// 0: High-quality video stream.
  ///
  High,

  @JsonValue(1)
  ///
  /// 1: Low-quality video stream.
  ///
  Low,
}

/* enum-WarningCode */
enum WarningCode {
  @JsonValue(8)
  InvalidView,

  @JsonValue(16)
  InitVideo,

  @JsonValue(20)
  Pending,

  @JsonValue(103)
  NoAvailableChannel,

  @JsonValue(104)
  LookupChannelTimeout,

  @deprecated
  @JsonValue(105)
  LookupChannelRejected,

  @JsonValue(106)
  OpenChannelTimeout,

  @JsonValue(107)
  OpenChannelRejected,

  @JsonValue(111)
  SwitchLiveVideoTimeout,

  @JsonValue(118)
  SetClientRoleTimeout,

  @JsonValue(119)
  SetClientRoleNotAuthorized,

  @JsonValue(121)
  OpenChannelInvalidTicket,

  @JsonValue(122)
  OpenChannelTryNextVos,

  @JsonValue(701)
  AudioMixingOpenError,

  @JsonValue(1014)
  AdmRuntimePlayoutWarning,

  @JsonValue(1016)
  AdmRuntimeRecordingWarning,

  @JsonValue(1019)
  AdmRecordAudioSilence,

  @JsonValue(1020)
  AdmPlaybackMalfunction,

  @JsonValue(1021)
  AdmRecordMalfunction,

  @JsonValue(1025)
  AdmInterruption,

  @JsonValue(1029)
  AdmCategoryNotPlayAndRecord,

  @JsonValue(1031)
  AdmRecordAudioLowlevel,

  @JsonValue(1032)
  AdmPlayoutAudioLowlevel,

  @JsonValue(1033)
  AdmRecordIsOccupied,

  @JsonValue(1040)
  AdmNoDataReadyCallback,

  @JsonValue(1042)
  AdmInconsistentDevices,

  @JsonValue(1051)
  ApmHowling,

  @JsonValue(1052)
  AdmGlitchState,

  @JsonValue(1053)
  ApmResidualEcho,

  @JsonValue(1610)
  SuperResolutionStreamOverLimitation,

  @JsonValue(1611)
  SuperResolutionUserCountOverLimitation,

  @JsonValue(1612)
  SuperResolutionDeviceNotSupported,
}

/* enum-AudioChannel */
enum AudioChannel {
  @JsonValue(0)
  Channel0,

  @JsonValue(1)
  Channel1,

  @JsonValue(2)
  Channel2,

  @JsonValue(3)
  Channel3,

  @JsonValue(4)
  Channel4,

  @JsonValue(5)
  Channel5,
}

///
/// Video codec types.
///
///
enum VideoCodecType {
  @JsonValue(1)
  ///
  /// Standard VP8.
  ///
  VP8,

  @JsonValue(2)
  ///
  /// Standard H.264.
  ///
  H264,

  @JsonValue(3)
  EVP,

  @JsonValue(4)
  E264,
}

/* enum-VideoCodecTypeForStream */
enum VideoCodecTypeForStream {
  @JsonValue(1)
  H264,

  @JsonValue(2)
  H265,
}

///
/// The publishing state.
///
///
enum StreamPublishState {
  @JsonValue(0)
  ///
  /// 0: The initial publishing state after joining the channel.
  ///
  Idle,

  @JsonValue(1)
  ///
  /// 1: Fails to publish the local stream. Possible reasons:
  ///  The local user calls muteLocalAudioStream(true) or muteLocalVideoStream(true) to stop sending the local media stream.
  ///  The local user calls disableAudio or disableVideo to disable the local audio or video module.
  ///  The local user calls enableLocalAudio(false) or enableLocalVideo(false) to disable the local audio or video capture.
  /// The role of the local user is audience.
  ///
  ///
  ///
  ///
  /// 3: Publishes successfully.
  ///
  NoPublished,

  @JsonValue(2)
  ///
  /// 2: Publishing.
  ///
  Publishing,

  @JsonValue(3)
  Published,
}

///
/// The subscribing state.
///
///
enum StreamSubscribeState {
  @JsonValue(0)
  ///
  /// 0: The initial subscribing state after joining the channel.
  ///
  Idle,

  @JsonValue(1)
  ///
  /// 1: Fails to subscribe to the remote stream. Possible reasons:
  /// The remote user:
  /// Calls muteLocalAudioStream(true) or muteLocalVideoStream(true) to stop sending local media stream.
  /// Calls disableAudio or disableVideo to disable the local audio or video module.
  /// Calls enableLocalAudio(false) or enableLocalVideo(false) to disable the local audio or video capture.
  /// The role of the remote user is audience.
  ///
  /// The local user calls the following methods to stop receiving remote streams:
  /// Calls muteRemoteAudioStream(true), muteAllRemoteAudioStreams(true) or setDefaultMuteAllRemoteAudioStreams(true) to stop receiving the remote audio streams.
  /// Calls muteRemoteVideoStream(true), muteAllRemoteVideoStreams(true) or setDefaultMuteAllRemoteVideoStreams(true) to stop receiving the remote video streams.
  ///
  ///
  ///
  ///
  ///
  /// 3: Subscribes to and receives the remote stream successfully.
  ///
  NoSubscribed,

  @JsonValue(2)
  ///
  /// 2: Subscribing.
  ///
  Subscribing,

  @JsonValue(3)
  Subscribed,
}

///
/// Events during the RTMP or RTMPS streaming.
///
///
enum RtmpStreamingEvent {
  @JsonValue(1)
  ///
  /// An error occurs when you add a background image or a watermark image to the RTMP or RTMPS stream.
  ///
  FailedLoadImage,

  @JsonValue(2)
  UrlAlreadyInUse,
}

///
/// The operational permission of the SDK on the audio session.
///
///
enum AudioSessionOperationRestriction {
  @JsonValue(0)
  ///
  /// No restriction, the SDK has full control of the audio session operations.
  ///
  None,

  @JsonValue(1)
  ///
  /// The SDK does not change the audio session category.
  ///
  SetCategory,

  @JsonValue(1 << 1)
  ///
  /// The SDK does not change any setting of the audio session (category, mode, categoryOptions).
  ///
  ConfigureSession,

  @JsonValue(1 << 2)
  ///
  /// The SDK keeps the audio session active when leaving a channel.
  ///
  DeactivateSession,

  @JsonValue(1 << 7)
  ///
  /// The SDK does not configure the audio session anymore.
  ///
  All,
}

///
/// Voice effect presets.
/// For better voice effects, Agora recommends setting the profile parameter of setAudioProfile to
///
///
/// MusicHighQuality
///
///
/// or
///
///
/// MusicHighQualityStereo
///
///
/// before using the following presets:
///
/// RoomAcousticsKTV
/// RoomAcousticsVocalConcert
/// RoomAcousticsStudio
/// RoomAcousticsPhonograph
/// RoomAcousticsSpacial
/// RoomAcousticsEthereal
/// VoiceChangerEffectUncle
/// VoiceChangerEffectOldMan
/// VoiceChangerEffectBoy
/// VoiceChangerEffectSister
/// VoiceChangerEffectGirl
/// VoiceChangerEffectPigKing
/// VoiceChangerEffectHulk
/// PitchCorrection
///
enum AudioEffectPreset {
  @JsonValue(0x00000000)
  ///
  /// Turn off voice effects, that is, use the original voice.
  ///
  AudioEffectOff,

  @JsonValue(0x02010100)
  ///
  /// The voice effect typical of a KTV venue.
  ///
  RoomAcousticsKTV,

  @JsonValue(0x02010200)
  ///
  /// The voice effect typical of a concert hall.
  ///
  RoomAcousticsVocalConcert,

  @JsonValue(0x02010300)
  ///
  /// The voice effect typical of a recording studio.
  ///
  RoomAcousticsStudio,

  @JsonValue(0x02010400)
  ///
  /// The voice effect typical of a vintage phonograph.
  ///
  RoomAcousticsPhonograph,

  @JsonValue(0x02010500)
  ///
  /// The virtual stereo effect, which renders monophonic audio as stereo audio.
  /// Before using this preset, set the profile parameter of setAudioProfile to MusicHighQuality or MusicHighQualityStereo. Otherwise, the preset setting is invalid.
  ///
  ///
  RoomAcousticsVirtualStereo,

  @JsonValue(0x02010600)
  ///
  /// A more spatial voice effect.
  ///
  RoomAcousticsSpacial,

  @JsonValue(0x02010700)
  ///
  /// A more ethereal voice effect.
  ///
  RoomAcousticsEthereal,

  @JsonValue(0x02010800)
  ///
  /// A 3D voice effect that makes the voice appear to be moving around the user. The default movement cycle is 10 seconds. After setting this effect, you can call setAudioEffectParameters to modify the movement period.
  ///
  ///
  ///  Before using this preset, set the profile parameter of setAudioProfile to MusicStandardStereo or MusicHighQualityStereo. Otherwise, the preset setting is invalid.
  ///  If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.
  ///
  ///
  ///
  ///
  RoomAcoustics3DVoice,

  @JsonValue(0x02020100)
  ///
  /// A middle-aged man's voice.
  /// Agora recommends using this preset to process a male-sounding voice;
  /// otherwise, you might not hear the anticipated voice effect.
  ///
  ///
  VoiceChangerEffectUncle,

  @JsonValue(0x02020200)
  ///
  /// A senior man's voice.
  /// Agora recommends using this preset to process a male-sounding voice;
  /// otherwise, you might not hear the anticipated voice effect.
  ///
  ///
  VoiceChangerEffectOldMan,

  @JsonValue(0x02020300)
  ///
  /// A boy's voice.
  /// Agora recommends using this preset to process a male-sounding voice;
  /// otherwise, you might not hear the anticipated voice effect.
  ///
  ///
  VoiceChangerEffectBoy,

  @JsonValue(0x02020400)
  ///
  /// A young woman's voice.
  /// Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  ///
  ///
  VoiceChangerEffectSister,

  @JsonValue(0x02020500)
  ///
  /// A girl's voice.
  /// Agora recommends using this preset to process a female-sounding voice; otherwise, you may not hear the anticipated voice effect.
  ///
  ///
  VoiceChangerEffectGirl,

  @JsonValue(0x02020600)
  ///
  /// The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.
  ///
  VoiceChangerEffectPigKing,

  @JsonValue(0x02020700)
  ///
  /// The Hulk's voice.
  ///
  VoiceChangerEffectHulk,

  @JsonValue(0x02030100)
  ///
  /// The voice effect typical of R&B music.
  /// Before using this preset, set the profile parameter of setAudioProfile to MusicHighQuality or MusicHighQualityStereo. Otherwise, the preset setting is invalid.
  ///
  ///
  StyleTransformationRnB,

  @JsonValue(0x02030200)
  ///
  /// The voice effect typical of popular music.
  /// Before using this preset, set the profile parameter of setAudioProfile to MusicHighQuality or MusicHighQualityStereo. Otherwise, the preset setting is invalid.
  ///
  ///
  StyleTransformationPopular,

  @JsonValue(0x02040100)
  ///
  /// A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. After setting this voice effect, you can call setAudioEffectParameters to adjust the basic mode of tuning and the pitch of the main tone.
  ///
  PitchCorrection,
}

///
/// The options for SDK preset voice beautifier effects.
///
///
enum VoiceBeautifierPreset {
  @JsonValue(0x00000000)
  ///
  /// Turn off voice beautifier effects and use the original voice.
  ///
  VoiceBeautifierOff,

  @JsonValue(0x01010100)
  ///
  /// A more magnetic voice.
  /// Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may experience vocal distortion.
  ///
  ChatBeautifierMagnetic,

  @JsonValue(0x01010200)
  ///
  /// A fresher voice.
  /// Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  ///
  ///
  ChatBeautifierFresh,

  @JsonValue(0x01010300)
  ///
  /// A more vital voice.
  /// Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may experience vocal distortion.
  ///
  ///
  ChatBeautifierVitality,

  @JsonValue(0x01020100)
  ///
  /// Singing beautifier effect.
  ///
  ///  If you call setVoiceBeautifierPreset(SingingBeautifier), you can beautify a male-sounding voice and add a reverberation effect that sounds like singing in a small room. Agora recommends using this enumerator to process a male-sounding voice; otherwise, you might experience vocal distortion.
  ///  If you call setVoiceBeautifierParameters(SingingBeautifier, param1, param2), you can beautify a male- or female-sounding voice and add a reverberation effect.
  ///
  ///
  ///
  SingingBeautifier,

  @JsonValue(0x01030100)
  ///
  /// A more vigorous voice.
  ///
  TimbreTransformationVigorous,

  @JsonValue(0x01030200)
  ///
  /// A deep voice.
  ///
  TimbreTransformationDeep,

  @JsonValue(0x01030300)
  ///
  /// A mellower voice.
  ///
  TimbreTransformationMellow,

  @JsonValue(0x01030400)
  ///
  /// Falsetto.
  ///
  TimbreTransformationFalsetto,

  @JsonValue(0x01030500)
  ///
  /// A fuller voice.
  ///
  TimbreTransformationFull,

  @JsonValue(0x01030600)
  ///
  /// A clearer voice.
  ///
  TimbreTransformationClear,

  @JsonValue(0x01030700)
  ///
  /// A more resounding voice.
  ///
  TimbreTransformationResounding,

  @JsonValue(0x01030800)
  ///
  /// A more ringing voice.
  ///
  TimbreTransformationRinging,
}

///
/// The latency level of an audience member in interactive live streaming. This enum takes effect only when the user role is set to Audience.
///
///
enum AudienceLatencyLevelType {
  @JsonValue(1)
  ///
  /// 1: Low latency.
  ///
  LowLatency,

  @JsonValue(2)
  ///
  /// 2: (Default) Ultra low latency.
  ///
  UltraLowLatency,
}

///
/// The output log level of the SDK.
///
///
enum LogLevel {
  @JsonValue(0x0000)
  ///
  /// 0: Do not output any log information.
  ///
  None,

  @JsonValue(0x0001)
  ///
  /// 0x0001: (Default) Output FATAL, ERROR,
  /// WARN, and INFO level log information. We
  /// recommend setting your log filter as this level.
  ///
  Info,

  @JsonValue(0x0002)
  ///
  /// 0x0002: Output FATAL, ERROR, and WARN level
  /// log information.
  ///
  Warn,

  @JsonValue(0x0004)
  ///
  /// 0x0004: Output FATAL and ERROR level log information.
  ///
  Error,

  @JsonValue(0x0008)
  ///
  /// 0x0008: Output FATAL level log information.
  ///
  Fatal,
}

///
/// The brightness level of the video image captured by the local camera.
///
///
  ///
  /// 1: The brightness level of the video image is too bright.
  ///
enum CaptureBrightnessLevelType {
  @JsonValue(-1)
  ///
  /// -1: The SDK does not detect the brightness level of the video image. Wait a few seconds to get the brightness level from captureBrightnessLevel in the next callback.
  ///
  Invalid,

  @JsonValue(0)
  ///
  /// 0: The brightness level of the video image is normal.
  ///
  Normal,

  @JsonValue(1)
  Bright,

  @JsonValue(2)
  ///
  /// 2: The brightness level of the video image is too dark.
  ///
  Dark,
}

///
/// The reason why super resolution is not successfully enabled.
/// Since
/// v3.5.1
///
enum SuperResolutionStateReason {
  @JsonValue(0)
  ///
  /// 0: Super resolution is successfully enabled.
  ///
  Success,

  @JsonValue(1)
  ///
  /// 1: The original resolution of the remote video is beyond the range where super resolution can be applied.
  ///
  StreamOverLimitation,

  @JsonValue(2)
  ///
  /// 2: Super resolution is already being used to boost another remote user’s video.
  ///
  UserCountOverLimitation,

  @JsonValue(3)
  ///
  /// 3: The device does not support using super resolution.
  ///
  DeviceNotSupported,
}

///
/// The reason for the upload failure.
///
///
enum UploadErrorReason {
  @JsonValue(0)
  ///
  /// 0: Successfully upload the log files.
  ///
  Success,

  @JsonValue(1)
  ///
  /// 1: Network error. Check the network connection and call uploadLogFile again to upload the log file.
  ///
  NetError,

  @JsonValue(2)
  ///
  /// 2: An error occurs in the Agora server. Try uploading the log files later.
  ///
  ServerError,
}

///
/// The cloud proxy type.
///
///
enum CloudProxyType {
  @JsonValue(0)
  ///
  /// 0: Do not use cloud proxy.
  ///
  None,

  @JsonValue(1)
  ///
  /// 1: Use cloud proxy with the UDP protocol.
  ///
  UDP,

  @JsonValue(2)
  TCP,
}

///
/// The Quality of Experience (QoE) of the local user when receiving a remote audio stream.
///
///
enum ExperienceQualityType {
  @JsonValue(0)
  ///
  /// 0: The QoE of the local user is good.
  ///
  Good,

  @JsonValue(1)
  ///
  /// 1: The QoE of the local user is poor.
  ///
  Bad,
}

///
/// Reasons why the QoE of the local user when receiving a remote audio stream is poor.
///
///
enum ExperiencePoorReason {
  @JsonValue(0)
  ///
  /// 0: No reason, indicating a good QoE of the local user.
  ///
  None,

  @JsonValue(1)
  ///
  /// 1: The remote user's network quality is poor.
  ///
  RemoteNetworkQualityPoor,

  @JsonValue(2)
  ///
  /// 2: The local user's network quality is poor.
  ///
  LocalNetworkQualityPoor,

  @JsonValue(4)
  ///
  /// 4: The local user's Wi-Fi or mobile network signal is weak.
  ///
  WirelessSignalPoor,

  @JsonValue(8)
  ///
  /// 8: The local user enables both Wi-Fi and bluetooth, and their signals interfere with each other. As a result, audio transmission quality is undermined.
  ///
  WifiBluetoothCoexist,
}

///
/// The options for SDK preset voice conversion effects.
///
///
enum VoiceConversionPreset {
  @JsonValue(0)
  ///
  /// Turn off voice conversion effects and use the original voice.
  ///
  Off,

  @JsonValue(50397440)
  ///
  /// A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
  ///
  Neutral,

  @JsonValue(50397696)
  ///
  /// A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
  ///
  Sweet,

  @JsonValue(50397952)
  ///
  /// A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
  ///
  Solid,

  @JsonValue(50398208)
  ///
  /// A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
  ///
  Bass,
}

///
/// The type of the custom background image.
///
///
enum VirtualBackgroundSourceType {
  @JsonValue(1)
  ///
  /// 1: (Default) The background image is a solid color.
  ///
  Color,

  @JsonValue(2)
  ///
  /// The background image is a file in PNG or JPG format.
  ///
  Img,

  @JsonValue(3)
  ///
  /// The background image is the blurred background.
  ///
  Blur,
}

///
/// The degree of blurring applied to the custom background image.
///
///
enum VirtualBackgroundBlurDegree {
  @JsonValue(1)
  ///
  /// 1: The degree of blurring applied to the custom background image is low. The user can almost see the background clearly.
  ///
  Low,

  @JsonValue(2)
  ///
  /// The degree of blurring applied to the custom background image is medium. It is difficult for the user to recognize details in the background.
  ///
  Medium,

  @JsonValue(3)
  ///
  /// (Default) The degree of blurring applied to the custom background image is high. The user can barely see any distinguishing features in the background.
  ///
  High,
}

///
/// The reason why virtual background is not successfully enabled.
/// Since
/// v3.5.0
///
enum VirtualBackgroundSourceStateReason {
  @JsonValue(0)
  ///
  /// 0: The virtual background is successfully enabled.
  ///
  Success,

  @JsonValue(1)
  ///
  /// 1: The custom background image does not exist. Please check the value of source in VirtualBackgroundSource.
  ///
  ImageNotExist,

  @JsonValue(2)
  ///
  /// 2: The color format of the custom background image is invalid. Please check the value of color in VirtualBackgroundSource.
  ///
  ColorFormatNotSupported,

  @JsonValue(3)
  ///
  /// 3: The device does not support using the virtual background.
  ///
  DeviceNotSupported,
}

///
/// The content hint for screen sharing.
///
///
enum VideoContentHint {
  @JsonValue(0)
  ///
  /// (Default) No content hint.
  ///
  None,

  @JsonValue(1)
  ///
  /// Motion-intensive content. Choose this option if you prefer smoothness or when you are sharing a video clip, movie, or video game.
  ///
  Motion,

  @JsonValue(2)
  ///
  /// Motionless content. Choose this option if you prefer sharpness or when you are sharing a
  /// picture, PowerPoint slides, or texts.
  ///
  Details,
}

///
/// Media device types.
///
///
enum MediaDeviceType {
  @JsonValue(-1)
  ///
  /// -1: Unknown device type.
  ///
  UnknownAudioDevice,

  @JsonValue(0)
  ///
  /// 0: Audio playback device.
  ///
  AudioPlayoutDevice,

  @JsonValue(1)
  ///
  /// 1: Audio capturing device.
  ///
  AudioRecordingDevice,

  @JsonValue(2)
  ///
  /// 2: Video renderer.
  ///
  VideoRenderDevice,

  @JsonValue(3)
  ///
  /// 3: Video capturer.
  ///
  VideoCaptureDevice,

  @JsonValue(4)
  ///
  /// 4: Application audio playback device.
  ///
  AudioApplicationPlayoutDevice,
}

///
/// Media device states.
///
///
enum MediaDeviceStateType {
  @JsonValue(0)
  ///
  /// 0: The device is ready for use.
  ///
  MediaDeviceStateIdle,

  @JsonValue(1)
  ///
  /// 1: The device is in use.
  ///
  MediaDeviceStateActive,

  @JsonValue(2)
  ///
  /// 2: The device is disabled.
  ///
  MediaDeviceStateDisabled,

  @JsonValue(4)
  ///
  /// 4: The device is not found.
  ///
  MediaDeviceStateNotPresent,

  @JsonValue(8)
  ///
  /// 8: The device is unplugged.
  ///
  MediaDeviceStateUnplugged,

  @JsonValue(16)
  MediaDeviceStateUnrecommended,
}

/* enum-RecorderState */
enum RecorderState {
  @JsonValue(-1)
  Error,

  @JsonValue(2)
  Start,

  @JsonValue(3)
  Stop,
}

/* enum-RecorderError */
enum RecorderError {
  @JsonValue(0)
  RECORDER_ERROR_NONE,

  @JsonValue(1)
  RECORDER_ERROR_WRITE_FAILED,

  @JsonValue(2)
  RECORDER_ERROR_NO_STREAM,

  @JsonValue(3)
  RECORDER_ERROR_OVER_MAX_DURATION,

  @JsonValue(4)
  RECORDER_ERROR_CONFIG_CHANGED,

  @JsonValue(5)
  RECORDER_ERROR_CUSTOM_STREAM_DETECTED,
}

/* enum-AgoraMediaRecorderContainerFormat */
enum AgoraMediaRecorderContainerFormat {
  @JsonValue(1)
  MP4,
}

/* enum-AgoraMediaRecorderStreamType */
enum AgoraMediaRecorderStreamType {
  @JsonValue(1)
  Audio,

  @JsonValue(2)
  Video,

  @JsonValue(3)
  Both,
}
