// ignore_for_file: public_member_api_docs

import 'package:agora_rtc_engine/src/enums.dart';
import 'package:json_annotation/json_annotation.dart';



part 'enum_converter.g.dart';

abstract class EnumConverter<E extends Enum, T> {
  E e;

  EnumConverter(this.e);

  EnumConverter.fromValue(Map<E, T> map, T t) : e = $enumDecode<E, T>(map, t);

  T toValue(Map<E, T> map) {
    return map[e] as T;
  }
}

@JsonSerializable()
class AreaCodeConverter extends EnumConverter<AreaCode, int> {
  AreaCodeConverter(AreaCode e) : super(e);

  AreaCodeConverter.fromValue(int value)
      : super.fromValue(_$AreaCodeEnumMap, value);

  int value() {
    return super.toValue(_$AreaCodeEnumMap);
  }
}

@JsonSerializable()
class AudioCodecProfileTypeConverter
    extends EnumConverter<AudioCodecProfileType, int> {
  AudioCodecProfileTypeConverter(AudioCodecProfileType e) : super(e);

  AudioCodecProfileTypeConverter.fromValue(int value)
      : super.fromValue(_$AudioCodecProfileTypeEnumMap, value);

  int value() {
    return super.toValue(_$AudioCodecProfileTypeEnumMap);
  }
}

@JsonSerializable()
class AudioEqualizationBandFrequencyConverter
    extends EnumConverter<AudioEqualizationBandFrequency, int> {
  AudioEqualizationBandFrequencyConverter(AudioEqualizationBandFrequency e)
      : super(e);

  AudioEqualizationBandFrequencyConverter.fromValue(int value)
      : super.fromValue(_$AudioEqualizationBandFrequencyEnumMap, value);

  int value() {
    return super.toValue(_$AudioEqualizationBandFrequencyEnumMap);
  }
}

@JsonSerializable()
class AudioLocalErrorConverter extends EnumConverter<AudioLocalError, int> {
  AudioLocalErrorConverter(AudioLocalError e) : super(e);

  AudioLocalErrorConverter.fromValue(int value)
      : super.fromValue(_$AudioLocalErrorEnumMap, value);

  int value() {
    return super.toValue(_$AudioLocalErrorEnumMap);
  }
}

@JsonSerializable()
class AudioLocalStateConverter extends EnumConverter<AudioLocalState, int> {
  AudioLocalStateConverter(AudioLocalState e) : super(e);

  AudioLocalStateConverter.fromValue(int value)
      : super.fromValue(_$AudioLocalStateEnumMap, value);

  int value() {
    return super.toValue(_$AudioLocalStateEnumMap);
  }
}

@JsonSerializable()
class AudioFileInfoErrorConverter
    extends EnumConverter<AudioFileInfoError, int> {
  AudioFileInfoErrorConverter(AudioFileInfoError e) : super(e);

  AudioFileInfoErrorConverter.fromValue(int value)
      : super.fromValue(_$AudioFileInfoErrorEnumMap, value);

  int value() {
    return super.toValue(_$AudioFileInfoErrorEnumMap);
  }
}

@JsonSerializable()
class AudioMixingReasonConverter extends EnumConverter<AudioMixingReason, int> {
  AudioMixingReasonConverter(AudioMixingReason e) : super(e);

  AudioMixingReasonConverter.fromValue(int value)
      : super.fromValue(_$AudioMixingReasonEnumMap, value);

  int value() {
    return super.toValue(_$AudioMixingReasonEnumMap);
  }
}

@JsonSerializable()
class AudioMixingStateCodeConverter
    extends EnumConverter<AudioMixingStateCode, int> {
  AudioMixingStateCodeConverter(AudioMixingStateCode e) : super(e);

  AudioMixingStateCodeConverter.fromValue(int value)
      : super.fromValue(_$AudioMixingStateCodeEnumMap, value);

  int value() {
    return super.toValue(_$AudioMixingStateCodeEnumMap);
  }
}

@JsonSerializable()
class AudioMixingDualMonoModeConverter
    extends EnumConverter<AudioMixingDualMonoMode, int> {
  AudioMixingDualMonoModeConverter(AudioMixingDualMonoMode e) : super(e);

  AudioMixingDualMonoModeConverter.fromValue(int value)
      : super.fromValue(_$AudioMixingDualMonoModeEnumMap, value);

  int value() {
    return super.toValue(_$AudioMixingDualMonoModeEnumMap);
  }
}

@JsonSerializable()
class AudioOutputRoutingConverter
    extends EnumConverter<AudioOutputRouting, int> {
  AudioOutputRoutingConverter(AudioOutputRouting e) : super(e);

  AudioOutputRoutingConverter.fromValue(int value)
      : super.fromValue(_$AudioOutputRoutingEnumMap, value);

  int value() {
    return super.toValue(_$AudioOutputRoutingEnumMap);
  }
}

@JsonSerializable()
class AudioProfileConverter extends EnumConverter<AudioProfile, int> {
  AudioProfileConverter(AudioProfile e) : super(e);

  AudioProfileConverter.fromValue(int value)
      : super.fromValue(_$AudioProfileEnumMap, value);

  int value() {
    return super.toValue(_$AudioProfileEnumMap);
  }
}

@JsonSerializable()
class AudioRecordingQualityConverter
    extends EnumConverter<AudioRecordingQuality, int> {
  AudioRecordingQualityConverter(AudioRecordingQuality e) : super(e);

  AudioRecordingQualityConverter.fromValue(int value)
      : super.fromValue(_$AudioRecordingQualityEnumMap, value);

  int value() {
    return super.toValue(_$AudioRecordingQualityEnumMap);
  }
}

@JsonSerializable()
class AudioRecordingPositionConverter
    extends EnumConverter<AudioRecordingPosition, int> {
  AudioRecordingPositionConverter(AudioRecordingPosition e) : super(e);

  AudioRecordingPositionConverter.fromValue(int value)
      : super.fromValue(_$AudioRecordingPositionEnumMap, value);

  int value() {
    return super.toValue(_$AudioRecordingPositionEnumMap);
  }
}

@JsonSerializable()
class AudioRemoteStateConverter extends EnumConverter<AudioRemoteState, int> {
  AudioRemoteStateConverter(AudioRemoteState e) : super(e);

  AudioRemoteStateConverter.fromValue(int value)
      : super.fromValue(_$AudioRemoteStateEnumMap, value);

  int value() {
    return super.toValue(_$AudioRemoteStateEnumMap);
  }
}

@JsonSerializable()
class AudioRemoteStateReasonConverter
    extends EnumConverter<AudioRemoteStateReason, int> {
  AudioRemoteStateReasonConverter(AudioRemoteStateReason e) : super(e);

  AudioRemoteStateReasonConverter.fromValue(int value)
      : super.fromValue(_$AudioRemoteStateReasonEnumMap, value);

  int value() {
    return super.toValue(_$AudioRemoteStateReasonEnumMap);
  }
}

@JsonSerializable()
class AudioReverbPresetConverter extends EnumConverter<AudioReverbPreset, int> {
  AudioReverbPresetConverter(AudioReverbPreset e) : super(e);

  AudioReverbPresetConverter.fromValue(int value)
      : super.fromValue(_$AudioReverbPresetEnumMap, value);

  int value() {
    return super.toValue(_$AudioReverbPresetEnumMap);
  }
}

@JsonSerializable()
class AudioReverbTypeConverter extends EnumConverter<AudioReverbType, int> {
  AudioReverbTypeConverter(AudioReverbType e) : super(e);

  AudioReverbTypeConverter.fromValue(int value)
      : super.fromValue(_$AudioReverbTypeEnumMap, value);

  int value() {
    return super.toValue(_$AudioReverbTypeEnumMap);
  }
}

@JsonSerializable()
class AudioSampleRateTypeConverter
    extends EnumConverter<AudioSampleRateType, int> {
  AudioSampleRateTypeConverter(AudioSampleRateType e) : super(e);

  AudioSampleRateTypeConverter.fromValue(int value)
      : super.fromValue(_$AudioSampleRateTypeEnumMap, value);

  int value() {
    return super.toValue(_$AudioSampleRateTypeEnumMap);
  }
}

@JsonSerializable()
class AudioScenarioConverter extends EnumConverter<AudioScenario, int> {
  AudioScenarioConverter(AudioScenario e) : super(e);

  AudioScenarioConverter.fromValue(int value)
      : super.fromValue(_$AudioScenarioEnumMap, value);

  int value() {
    return super.toValue(_$AudioScenarioEnumMap);
  }
}

@JsonSerializable()
class AudioVoiceChangerConverter extends EnumConverter<AudioVoiceChanger, int> {
  AudioVoiceChangerConverter(AudioVoiceChanger e) : super(e);

  AudioVoiceChangerConverter.fromValue(int value)
      : super.fromValue(_$AudioVoiceChangerEnumMap, value);

  int value() {
    return super.toValue(_$AudioVoiceChangerEnumMap);
  }
}

@JsonSerializable()
class CameraCaptureOutputPreferenceConverter
    extends EnumConverter<CameraCaptureOutputPreference, int> {
  CameraCaptureOutputPreferenceConverter(CameraCaptureOutputPreference e)
      : super(e);

  CameraCaptureOutputPreferenceConverter.fromValue(int value)
      : super.fromValue(_$CameraCaptureOutputPreferenceEnumMap, value);

  int value() {
    return super.toValue(_$CameraCaptureOutputPreferenceEnumMap);
  }
}

@JsonSerializable()
class CameraDirectionConverter extends EnumConverter<CameraDirection, int> {
  CameraDirectionConverter(CameraDirection e) : super(e);

  CameraDirectionConverter.fromValue(int value)
      : super.fromValue(_$CameraDirectionEnumMap, value);

  int value() {
    return super.toValue(_$CameraDirectionEnumMap);
  }
}

@JsonSerializable()
class ChannelMediaRelayErrorConverter
    extends EnumConverter<ChannelMediaRelayError, int> {
  ChannelMediaRelayErrorConverter(ChannelMediaRelayError e) : super(e);

  ChannelMediaRelayErrorConverter.fromValue(int value)
      : super.fromValue(_$ChannelMediaRelayErrorEnumMap, value);

  int value() {
    return super.toValue(_$ChannelMediaRelayErrorEnumMap);
  }
}

@JsonSerializable()
class ChannelMediaRelayEventConverter
    extends EnumConverter<ChannelMediaRelayEvent, int> {
  ChannelMediaRelayEventConverter(ChannelMediaRelayEvent e) : super(e);

  ChannelMediaRelayEventConverter.fromValue(int value)
      : super.fromValue(_$ChannelMediaRelayEventEnumMap, value);

  int value() {
    return super.toValue(_$ChannelMediaRelayEventEnumMap);
  }
}

@JsonSerializable()
class ChannelMediaRelayStateConverter
    extends EnumConverter<ChannelMediaRelayState, int> {
  ChannelMediaRelayStateConverter(ChannelMediaRelayState e) : super(e);

  ChannelMediaRelayStateConverter.fromValue(int value)
      : super.fromValue(_$ChannelMediaRelayStateEnumMap, value);

  int value() {
    return super.toValue(_$ChannelMediaRelayStateEnumMap);
  }
}

@JsonSerializable()
class ChannelProfileConverter extends EnumConverter<ChannelProfile, int> {
  ChannelProfileConverter(ChannelProfile e) : super(e);

  ChannelProfileConverter.fromValue(int value)
      : super.fromValue(_$ChannelProfileEnumMap, value);

  int value() {
    return super.toValue(_$ChannelProfileEnumMap);
  }
}

@JsonSerializable()
class ClientRoleConverter extends EnumConverter<ClientRole, int> {
  ClientRoleConverter(ClientRole e) : super(e);

  ClientRoleConverter.fromValue(int value)
      : super.fromValue(_$ClientRoleEnumMap, value);

  int value() {
    return super.toValue(_$ClientRoleEnumMap);
  }
}

@JsonSerializable()
class ConnectionChangedReasonConverter
    extends EnumConverter<ConnectionChangedReason, int> {
  ConnectionChangedReasonConverter(ConnectionChangedReason e) : super(e);

  ConnectionChangedReasonConverter.fromValue(int value)
      : super.fromValue(_$ConnectionChangedReasonEnumMap, value);

  int value() {
    return super.toValue(_$ConnectionChangedReasonEnumMap);
  }
}

@JsonSerializable()
class ConnectionStateTypeConverter
    extends EnumConverter<ConnectionStateType, int> {
  ConnectionStateTypeConverter(ConnectionStateType e) : super(e);

  ConnectionStateTypeConverter.fromValue(int value)
      : super.fromValue(_$ConnectionStateTypeEnumMap, value);

  int value() {
    return super.toValue(_$ConnectionStateTypeEnumMap);
  }
}

@JsonSerializable()
class DegradationPreferenceConverter
    extends EnumConverter<DegradationPreference, int> {
  DegradationPreferenceConverter(DegradationPreference e) : super(e);

  DegradationPreferenceConverter.fromValue(int value)
      : super.fromValue(_$DegradationPreferenceEnumMap, value);

  int value() {
    return super.toValue(_$DegradationPreferenceEnumMap);
  }
}

@JsonSerializable()
class EncryptionModeConverter extends EnumConverter<EncryptionMode, int> {
  EncryptionModeConverter(EncryptionMode e) : super(e);

  EncryptionModeConverter.fromValue(int value)
      : super.fromValue(_$EncryptionModeEnumMap, value);

  int value() {
    return super.toValue(_$EncryptionModeEnumMap);
  }
}

@JsonSerializable()
class ErrorCodeConverter extends EnumConverter<ErrorCode, int> {
  ErrorCodeConverter(ErrorCode e) : super(e);

  ErrorCodeConverter.fromValue(int value)
      : super.fromValue(_$ErrorCodeEnumMap, value);

  int value() {
    return super.toValue(_$ErrorCodeEnumMap);
  }
}

@JsonSerializable()
class InjectStreamStatusConverter
    extends EnumConverter<InjectStreamStatus, int> {
  InjectStreamStatusConverter(InjectStreamStatus e) : super(e);

  InjectStreamStatusConverter.fromValue(int value)
      : super.fromValue(_$InjectStreamStatusEnumMap, value);

  int value() {
    return super.toValue(_$InjectStreamStatusEnumMap);
  }
}

@JsonSerializable()
class LastmileProbeResultStateConverter
    extends EnumConverter<LastmileProbeResultState, int> {
  LastmileProbeResultStateConverter(LastmileProbeResultState e) : super(e);

  LastmileProbeResultStateConverter.fromValue(int value)
      : super.fromValue(_$LastmileProbeResultStateEnumMap, value);

  int value() {
    return super.toValue(_$LastmileProbeResultStateEnumMap);
  }
}

@JsonSerializable()
class LighteningContrastLevelConverter
    extends EnumConverter<LighteningContrastLevel, int> {
  LighteningContrastLevelConverter(LighteningContrastLevel e) : super(e);

  LighteningContrastLevelConverter.fromValue(int value)
      : super.fromValue(_$LighteningContrastLevelEnumMap, value);

  int value() {
    return super.toValue(_$LighteningContrastLevelEnumMap);
  }
}

@JsonSerializable()
class LocalVideoStreamErrorConverter
    extends EnumConverter<LocalVideoStreamError, int> {
  LocalVideoStreamErrorConverter(LocalVideoStreamError e) : super(e);

  LocalVideoStreamErrorConverter.fromValue(int value)
      : super.fromValue(_$LocalVideoStreamErrorEnumMap, value);

  int value() {
    return super.toValue(_$LocalVideoStreamErrorEnumMap);
  }
}

@JsonSerializable()
class LocalVideoStreamStateConverter
    extends EnumConverter<LocalVideoStreamState, int> {
  LocalVideoStreamStateConverter(LocalVideoStreamState e) : super(e);

  LocalVideoStreamStateConverter.fromValue(int value)
      : super.fromValue(_$LocalVideoStreamStateEnumMap, value);

  int value() {
    return super.toValue(_$LocalVideoStreamStateEnumMap);
  }
}

@JsonSerializable()
class LogFilterConverter extends EnumConverter<LogFilter, int> {
  LogFilterConverter(LogFilter e) : super(e);

  LogFilterConverter.fromValue(int value)
      : super.fromValue(_$LogFilterEnumMap, value);

  int value() {
    return super.toValue(_$LogFilterEnumMap);
  }
}

@JsonSerializable()
class NetworkQualityConverter extends EnumConverter<NetworkQuality, int> {
  NetworkQualityConverter(NetworkQuality e) : super(e);

  NetworkQualityConverter.fromValue(int value)
      : super.fromValue(_$NetworkQualityEnumMap, value);

  int value() {
    return super.toValue(_$NetworkQualityEnumMap);
  }
}

@JsonSerializable()
class NetworkTypeConverter extends EnumConverter<NetworkType, int> {
  NetworkTypeConverter(NetworkType e) : super(e);

  NetworkTypeConverter.fromValue(int value)
      : super.fromValue(_$NetworkTypeEnumMap, value);

  int value() {
    return super.toValue(_$NetworkTypeEnumMap);
  }
}

@JsonSerializable()
class RtmpStreamingErrorCodeConverter
    extends EnumConverter<RtmpStreamingErrorCode, int> {
  RtmpStreamingErrorCodeConverter(RtmpStreamingErrorCode e) : super(e);

  RtmpStreamingErrorCodeConverter.fromValue(int value)
      : super.fromValue(_$RtmpStreamingErrorCodeEnumMap, value);

  int value() {
    return super.toValue(_$RtmpStreamingErrorCodeEnumMap);
  }
}

@JsonSerializable()
class RtmpStreamingStateConverter
    extends EnumConverter<RtmpStreamingState, int> {
  RtmpStreamingStateConverter(RtmpStreamingState e) : super(e);

  RtmpStreamingStateConverter.fromValue(int value)
      : super.fromValue(_$RtmpStreamingStateEnumMap, value);

  int value() {
    return super.toValue(_$RtmpStreamingStateEnumMap);
  }
}

@JsonSerializable()
class StreamFallbackOptionsConverter
    extends EnumConverter<StreamFallbackOptions, int> {
  StreamFallbackOptionsConverter(StreamFallbackOptions e) : super(e);

  StreamFallbackOptionsConverter.fromValue(int value)
      : super.fromValue(_$StreamFallbackOptionsEnumMap, value);

  int value() {
    return super.toValue(_$StreamFallbackOptionsEnumMap);
  }
}

@JsonSerializable()
class UserOfflineReasonConverter extends EnumConverter<UserOfflineReason, int> {
  UserOfflineReasonConverter(UserOfflineReason e) : super(e);

  UserOfflineReasonConverter.fromValue(int value)
      : super.fromValue(_$UserOfflineReasonEnumMap, value);

  int value() {
    return super.toValue(_$UserOfflineReasonEnumMap);
  }
}

@JsonSerializable()
class UserPriorityConverter extends EnumConverter<UserPriority, int> {
  UserPriorityConverter(UserPriority e) : super(e);

  UserPriorityConverter.fromValue(int value)
      : super.fromValue(_$UserPriorityEnumMap, value);

  int value() {
    return super.toValue(_$UserPriorityEnumMap);
  }
}

@JsonSerializable()
class VideoCodecProfileTypeConverter
    extends EnumConverter<VideoCodecProfileType, int> {
  VideoCodecProfileTypeConverter(VideoCodecProfileType e) : super(e);

  VideoCodecProfileTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoCodecProfileTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoCodecProfileTypeEnumMap);
  }
}

@JsonSerializable()
class VideoFrameRateConverter extends EnumConverter<VideoFrameRate, int> {
  VideoFrameRateConverter(VideoFrameRate e) : super(e);

  VideoFrameRateConverter.fromValue(int value)
      : super.fromValue(_$VideoFrameRateEnumMap, value);

  int value() {
    return super.toValue(_$VideoFrameRateEnumMap);
  }
}

@JsonSerializable()
class BitRateConverter extends EnumConverter<BitRate, int> {
  BitRateConverter(BitRate e) : super(e);

  BitRateConverter.fromValue(int value)
      : super.fromValue(_$BitRateEnumMap, value);

  int value() {
    return super.toValue(_$BitRateEnumMap);
  }
}

@JsonSerializable()
class VideoMirrorModeConverter extends EnumConverter<VideoMirrorMode, int> {
  VideoMirrorModeConverter(VideoMirrorMode e) : super(e);

  VideoMirrorModeConverter.fromValue(int value)
      : super.fromValue(_$VideoMirrorModeEnumMap, value);

  int value() {
    return super.toValue(_$VideoMirrorModeEnumMap);
  }
}

@JsonSerializable()
class VideoOutputOrientationModeConverter
    extends EnumConverter<VideoOutputOrientationMode, int> {
  VideoOutputOrientationModeConverter(VideoOutputOrientationMode e) : super(e);

  VideoOutputOrientationModeConverter.fromValue(int value)
      : super.fromValue(_$VideoOutputOrientationModeEnumMap, value);

  int value() {
    return super.toValue(_$VideoOutputOrientationModeEnumMap);
  }
}

@JsonSerializable()
class VideoQualityAdaptIndicationConverter
    extends EnumConverter<VideoQualityAdaptIndication, int> {
  VideoQualityAdaptIndicationConverter(VideoQualityAdaptIndication e)
      : super(e);

  VideoQualityAdaptIndicationConverter.fromValue(int value)
      : super.fromValue(_$VideoQualityAdaptIndicationEnumMap, value);

  int value() {
    return super.toValue(_$VideoQualityAdaptIndicationEnumMap);
  }
}

@JsonSerializable()
class VideoRemoteStateConverter extends EnumConverter<VideoRemoteState, int> {
  VideoRemoteStateConverter(VideoRemoteState e) : super(e);

  VideoRemoteStateConverter.fromValue(int value)
      : super.fromValue(_$VideoRemoteStateEnumMap, value);

  int value() {
    return super.toValue(_$VideoRemoteStateEnumMap);
  }
}

@JsonSerializable()
class VideoRemoteStateReasonConverter
    extends EnumConverter<VideoRemoteStateReason, int> {
  VideoRemoteStateReasonConverter(VideoRemoteStateReason e) : super(e);

  VideoRemoteStateReasonConverter.fromValue(int value)
      : super.fromValue(_$VideoRemoteStateReasonEnumMap, value);

  int value() {
    return super.toValue(_$VideoRemoteStateReasonEnumMap);
  }
}

@JsonSerializable()
class VideoRenderModeConverter extends EnumConverter<VideoRenderMode, int> {
  VideoRenderModeConverter(VideoRenderMode e) : super(e);

  VideoRenderModeConverter.fromValue(int value)
      : super.fromValue(_$VideoRenderModeEnumMap, value);

  int value() {
    return super.toValue(_$VideoRenderModeEnumMap);
  }
}

@JsonSerializable()
class VideoStreamTypeConverter extends EnumConverter<VideoStreamType, int> {
  VideoStreamTypeConverter(VideoStreamType e) : super(e);

  VideoStreamTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoStreamTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoStreamTypeEnumMap);
  }
}

@JsonSerializable()
class WarningCodeConverter extends EnumConverter<WarningCode, int> {
  WarningCodeConverter(WarningCode e) : super(e);

  WarningCodeConverter.fromValue(int value)
      : super.fromValue(_$WarningCodeEnumMap, value);

  int value() {
    return super.toValue(_$WarningCodeEnumMap);
  }
}

@JsonSerializable()
class AudioChannelConverter extends EnumConverter<AudioChannel, int> {
  AudioChannelConverter(AudioChannel e) : super(e);

  AudioChannelConverter.fromValue(int value)
      : super.fromValue(_$AudioChannelEnumMap, value);

  int value() {
    return super.toValue(_$AudioChannelEnumMap);
  }
}

@JsonSerializable()
class VideoCodecTypeConverter extends EnumConverter<VideoCodecType, int> {
  VideoCodecTypeConverter(VideoCodecType e) : super(e);

  VideoCodecTypeConverter.fromValue(int value)
      : super.fromValue(_$VideoCodecTypeEnumMap, value);

  int value() {
    return super.toValue(_$VideoCodecTypeEnumMap);
  }
}

@JsonSerializable()
class StreamPublishStateConverter
    extends EnumConverter<StreamPublishState, int> {
  StreamPublishStateConverter(StreamPublishState e) : super(e);

  StreamPublishStateConverter.fromValue(int value)
      : super.fromValue(_$StreamPublishStateEnumMap, value);

  int value() {
    return super.toValue(_$StreamPublishStateEnumMap);
  }
}

@JsonSerializable()
class StreamSubscribeStateConverter
    extends EnumConverter<StreamSubscribeState, int> {
  StreamSubscribeStateConverter(StreamSubscribeState e) : super(e);

  StreamSubscribeStateConverter.fromValue(int value)
      : super.fromValue(_$StreamSubscribeStateEnumMap, value);

  int value() {
    return super.toValue(_$StreamSubscribeStateEnumMap);
  }
}

@JsonSerializable()
class RtmpStreamingEventConverter
    extends EnumConverter<RtmpStreamingEvent, int> {
  RtmpStreamingEventConverter(RtmpStreamingEvent e) : super(e);

  RtmpStreamingEventConverter.fromValue(int value)
      : super.fromValue(_$RtmpStreamingEventEnumMap, value);

  int value() {
    return super.toValue(_$RtmpStreamingEventEnumMap);
  }
}

@JsonSerializable()
class AudioSessionOperationRestrictionConverter
    extends EnumConverter<AudioSessionOperationRestriction, int> {
  AudioSessionOperationRestrictionConverter(AudioSessionOperationRestriction e)
      : super(e);

  AudioSessionOperationRestrictionConverter.fromValue(int value)
      : super.fromValue(_$AudioSessionOperationRestrictionEnumMap, value);

  int value() {
    return super.toValue(_$AudioSessionOperationRestrictionEnumMap);
  }
}

@JsonSerializable()
class AudioEffectPresetConverter extends EnumConverter<AudioEffectPreset, int> {
  AudioEffectPresetConverter(AudioEffectPreset e) : super(e);

  AudioEffectPresetConverter.fromValue(int value)
      : super.fromValue(_$AudioEffectPresetEnumMap, value);

  int value() {
    return super.toValue(_$AudioEffectPresetEnumMap);
  }
}

@JsonSerializable()
class VoiceBeautifierPresetConverter
    extends EnumConverter<VoiceBeautifierPreset, int> {
  VoiceBeautifierPresetConverter(VoiceBeautifierPreset e) : super(e);

  VoiceBeautifierPresetConverter.fromValue(int value)
      : super.fromValue(_$VoiceBeautifierPresetEnumMap, value);

  int value() {
    return super.toValue(_$VoiceBeautifierPresetEnumMap);
  }
}

@JsonSerializable()
class AudienceLatencyLevelTypeConverter
    extends EnumConverter<AudienceLatencyLevelType, int> {
  AudienceLatencyLevelTypeConverter(AudienceLatencyLevelType e) : super(e);

  AudienceLatencyLevelTypeConverter.fromValue(int value)
      : super.fromValue(_$AudienceLatencyLevelTypeEnumMap, value);

  int value() {
    return super.toValue(_$AudienceLatencyLevelTypeEnumMap);
  }
}

@JsonSerializable()
class LogLevelConverter extends EnumConverter<LogLevel, int> {
  LogLevelConverter(LogLevel e) : super(e);

  LogLevelConverter.fromValue(int value)
      : super.fromValue(_$LogLevelEnumMap, value);

  int value() {
    return super.toValue(_$LogLevelEnumMap);
  }
}

@JsonSerializable()
class CaptureBrightnessLevelTypeConverter
    extends EnumConverter<CaptureBrightnessLevelType, int> {
  CaptureBrightnessLevelTypeConverter(CaptureBrightnessLevelType e) : super(e);

  CaptureBrightnessLevelTypeConverter.fromValue(int value)
      : super.fromValue(_$CaptureBrightnessLevelTypeEnumMap, value);

  int value() {
    return super.toValue(_$CaptureBrightnessLevelTypeEnumMap);
  }
}

@JsonSerializable()
class SuperResolutionStateReasonConverter
    extends EnumConverter<SuperResolutionStateReason, int> {
  SuperResolutionStateReasonConverter(SuperResolutionStateReason e) : super(e);

  SuperResolutionStateReasonConverter.fromValue(int value)
      : super.fromValue(_$SuperResolutionStateReasonEnumMap, value);

  int value() {
    return super.toValue(_$SuperResolutionStateReasonEnumMap);
  }
}

@JsonSerializable()
class UploadErrorReasonConverter extends EnumConverter<UploadErrorReason, int> {
  UploadErrorReasonConverter(UploadErrorReason e) : super(e);

  UploadErrorReasonConverter.fromValue(int value)
      : super.fromValue(_$UploadErrorReasonEnumMap, value);

  int value() {
    return super.toValue(_$UploadErrorReasonEnumMap);
  }
}

@JsonSerializable()
class MediaDeviceTypeConverter extends EnumConverter<MediaDeviceType, int> {
  MediaDeviceTypeConverter(MediaDeviceType e) : super(e);

  MediaDeviceTypeConverter.fromValue(int value)
      : super.fromValue(_$MediaDeviceTypeEnumMap, value);

  int value() {
    return super.toValue(_$MediaDeviceTypeEnumMap);
  }
}

@JsonSerializable()
class MediaDeviceStateTypeConverter
    extends EnumConverter<MediaDeviceStateType, int> {
  MediaDeviceStateTypeConverter(MediaDeviceStateType e) : super(e);

  MediaDeviceStateTypeConverter.fromValue(int value)
      : super.fromValue(_$MediaDeviceStateTypeEnumMap, value);

  int value() {
    return super.toValue(_$MediaDeviceStateTypeEnumMap);
  }
}

@JsonSerializable()
class CloudProxyTypeConverter extends EnumConverter<CloudProxyType, int> {
  CloudProxyTypeConverter(CloudProxyType e) : super(e);

  CloudProxyTypeConverter.fromValue(int value)
      : super.fromValue(_$CloudProxyTypeEnumMap, value);

  int value() {
    return super.toValue(_$CloudProxyTypeEnumMap);
  }
}

@JsonSerializable()
class ExperienceQualityTypeConverter
    extends EnumConverter<ExperienceQualityType, int> {
  ExperienceQualityTypeConverter(ExperienceQualityType e) : super(e);

  ExperienceQualityTypeConverter.fromValue(int value)
      : super.fromValue(_$ExperienceQualityTypeEnumMap, value);

  int value() {
    return super.toValue(_$ExperienceQualityTypeEnumMap);
  }
}

@JsonSerializable()
class ExperiencePoorReasonConverter
    extends EnumConverter<ExperiencePoorReason, int> {
  ExperiencePoorReasonConverter(ExperiencePoorReason e) : super(e);

  ExperiencePoorReasonConverter.fromValue(int value)
      : super.fromValue(_$ExperiencePoorReasonEnumMap, value);

  int value() {
    return super.toValue(_$ExperiencePoorReasonEnumMap);
  }
}

@JsonSerializable()
class VoiceConversionPresetConverter
    extends EnumConverter<VoiceConversionPreset, int> {
  VoiceConversionPresetConverter(VoiceConversionPreset e) : super(e);

  VoiceConversionPresetConverter.fromValue(int value)
      : super.fromValue(_$VoiceConversionPresetEnumMap, value);

  int value() {
    return super.toValue(_$VoiceConversionPresetEnumMap);
  }
}

@JsonSerializable()
class VirtualBackgroundSourceTypeConverter
    extends EnumConverter<VirtualBackgroundSourceType, int> {
  VirtualBackgroundSourceTypeConverter(VirtualBackgroundSourceType e)
      : super(e);

  VirtualBackgroundSourceTypeConverter.fromValue(int value)
      : super.fromValue(_$VirtualBackgroundSourceTypeEnumMap, value);

  int value() {
    return super.toValue(_$VirtualBackgroundSourceTypeEnumMap);
  }
}

@JsonSerializable()
class VirtualBackgroundBlurDegreeConverter
    extends EnumConverter<VirtualBackgroundBlurDegree, int> {
  VirtualBackgroundBlurDegreeConverter(VirtualBackgroundBlurDegree e)
      : super(e);

  VirtualBackgroundBlurDegreeConverter.fromValue(int value)
      : super.fromValue(_$VirtualBackgroundBlurDegreeEnumMap, value);

  int value() {
    return super.toValue(_$VirtualBackgroundBlurDegreeEnumMap);
  }
}

@JsonSerializable()
class VirtualBackgroundSourceStateReasonConverter
    extends EnumConverter<VirtualBackgroundSourceStateReason, int> {
  VirtualBackgroundSourceStateReasonConverter(
      VirtualBackgroundSourceStateReason e)
      : super(e);

  VirtualBackgroundSourceStateReasonConverter.fromValue(int value)
      : super.fromValue(_$VirtualBackgroundSourceStateReasonEnumMap, value);

  int value() {
    return super.toValue(_$VirtualBackgroundSourceStateReasonEnumMap);
  }
}

@JsonSerializable()
class VideoContentHintConverter extends EnumConverter<VideoContentHint, int> {
  VideoContentHintConverter(VideoContentHint e) : super(e);

  VideoContentHintConverter.fromValue(int value)
      : super.fromValue(_$VideoContentHintEnumMap, value);

  int value() {
    return super.toValue(_$VideoContentHintEnumMap);
  }
}
