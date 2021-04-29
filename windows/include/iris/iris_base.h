//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_IRIS_BASE_H
#define IRIS_IRIS_BASE_H

#if defined(_WIN32)
#define IRIS_CALL __cdecl
#if defined(IRIS_EXPORT)
#define IRIS_API extern "C" __declspec(dllexport)
#define IRIS_CPP_API __declspec(dllexport)
#else
#define IRIS_API extern "C" __declspec(dllimport)
#define IRIS_CPP_API __declspec(dllimport)
#endif
#elif defined(__APPLE__)
#define IRIS_API __attribute__((visibility("default"))) extern "C"
#define IRIS_CPP_API __attribute__((visibility("default")))
#define IRIS_CALL
#elif defined(__ANDROID__) || defined(__linux__)
#define IRIS_API extern "C" __attribute__((visibility("default")))
#define IRIS_CPP_API __attribute__((visibility("default")))
#define IRIS_CALL
#else
#define IRIS_API extern "C"
#define IRIS_CPP_API
#define IRIS_CALL
#endif

#if defined(IRIS_DEBUG)
#define IRIS_DEBUG_API IRIS_API
#define IRIS_DEBUG_CPP_API IRIS_CPP_API
#else
#define IRIS_DEBUG_API
#define IRIS_DEBUG_CPP_API
#endif

#ifdef __cplusplus
extern "C" {
#endif

const int kBasicResultLength = 512;
const int kMaxResultLength = 2048;

enum ApiTypeEngine {
  kEngineInitialize,
  kEngineRelease,
  kEngineSetChannelProfile,
  kEngineSetClientRole,
  kEngineJoinChannel,
  kEngineSwitchChannel,
  kEngineLeaveChannel,
  kEngineRenewToken,
  kEngineRegisterLocalUserAccount,
  kEngineJoinChannelWithUserAccount,
  kEngineGetUserInfoByUserAccount,
  kEngineGetUserInfoByUid,
  kEngineStartEchoTest,
  kEngineStopEchoTest,
  kEngineSetCloudProxy,
  kEngineEnableVideo,
  kEngineDisableVideo,
  kEngineSetVideoProfile,
  kEngineSetVideoEncoderConfiguration,
  kEngineSetCameraCapturerConfiguration,
  kEngineSetupLocalVideo,
  kEngineSetupRemoteVideo,
  kEngineStartPreview,
  kEngineSetRemoteUserPriority,
  kEngineStopPreview,
  kEngineEnableAudio,
  kEngineEnableLocalAudio,
  kEngineDisableAudio,
  kEngineSetAudioProfile,
  kEngineMuteLocalAudioStream,
  kEngineMuteAllRemoteAudioStreams,
  kEngineSetDefaultMuteAllRemoteAudioStreams,
  kEngineAdjustUserPlaybackSignalVolume,
  kEngineMuteRemoteAudioStream,
  kEngineMuteLocalVideoStream,
  kEngineEnableLocalVideo,
  kEngineMuteAllRemoteVideoStreams,
  kEngineSetDefaultMuteAllRemoteVideoStreams,
  kEngineMuteRemoteVideoStream,
  kEngineSetRemoteVideoStreamType,
  kEngineSetRemoteDefaultVideoStreamType,
  kEngineEnableAudioVolumeIndication,
  kEngineStartAudioRecording,
  kEngineStopAudioRecording,
  kEngineStartAudioMixing,
  kEngineStopAudioMixing,
  kEnginePauseAudioMixing,
  kEngineResumeAudioMixing,
  kEngineSetHighQualityAudioParameters,
  kEngineAdjustAudioMixingVolume,
  kEngineAdjustAudioMixingPlayoutVolume,
  kEngineGetAudioMixingPlayoutVolume,
  kEngineAdjustAudioMixingPublishVolume,
  kEngineGetAudioMixingPublishVolume,
  kEngineGetAudioMixingDuration,
  kEngineGetAudioMixingCurrentPosition,
  kEngineSetAudioMixingPosition,
  kEngineSetAudioMixingPitch,
  kEngineGetEffectsVolume,
  kEngineSetEffectsVolume,
  kEngineSetVolumeOfEffect,
  kEngineEnableFaceDetection,
  kEnginePlayEffect,
  kEngineStopEffect,
  kEngineStopAllEffects,
  kEnginePreloadEffect,
  kEngineUnloadEffect,
  kEnginePauseEffect,
  kEnginePauseAllEffects,
  kEngineResumeEffect,
  kEngineResumeAllEffects,
  kEngineEnableDeepLearningDenoise,
  kEngineEnableSoundPositionIndication,
  kEngineSetRemoteVoicePosition,
  kEngineSetLocalVoicePitch,
  kEngineSetLocalVoiceEqualization,
  kEngineSetLocalVoiceReverb,
  kEngineSetLocalVoiceChanger,
  kEngineSetLocalVoiceReverbPreset,
  kEngineSetVoiceBeautifierPreset,
  kEngineSetAudioEffectPreset,
  kEngineSetVoiceConversionPreset,
  kEngineSetAudioEffectParameters,
  kEngineSetVoiceBeautifierParameters,
  kEngineSetLogFile,
  kEngineSetLogFilter,
  kEngineSetLogFileSize,
  kEngineUploadLogFile,
  kEngineSetLocalRenderMode,
  kEngineSetRemoteRenderMode,
  kEngineSetLocalVideoMirrorMode,
  kEngineEnableDualStreamMode,
  kEngineSetExternalAudioSource,
  kEngineSetExternalAudioSink,
  kEngineSetRecordingAudioFrameParameters,
  kEngineSetPlaybackAudioFrameParameters,
  kEngineSetMixedAudioFrameParameters,
  kEngineAdjustRecordingSignalVolume,
  kEngineAdjustPlaybackSignalVolume,
  kEngineEnableWebSdkInteroperability,
  kEngineSetVideoQualityParameters,
  kEngineSetLocalPublishFallbackOption,
  kEngineSetRemoteSubscribeFallbackOption,
  kEngineSwitchCamera,
  kEngineSetDefaultAudioRouteToSpeakerPhone,
  kEngineSetEnableSpeakerPhone,
  kEngineEnableInEarMonitoring,
  kEngineSetInEarMonitoringVolume,
  kEngineIsSpeakerPhoneEnabled,
  kEngineSetAudioSessionOperationRestriction,
  kEngineEnableLoopBackRecording,
  kEngineStartScreenCaptureByDisplayId,
  kEngineStartScreenCaptureByScreenRect,
  kEngineStartScreenCaptureByWindowId,
  kEngineSetScreenCaptureContentHint,
  kEngineUpdateScreenCaptureParameters,
  kEngineUpdateScreenCaptureRegion,
  kEngineStopScreenCapture,
  kEngineStartScreenCapture,
  kEngineSetVideoSource,
  kEngineGetCallId,
  kEngineRate,
  kEngineComplain,
  kEngineGetVersion,
  kEngineEnableLastMileTest,
  kEngineDisableLastMileTest,
  kEngineStartLastMileProbeTest,
  kEngineStopLastMileProbeTest,
  kEngineGetErrorDescription,
  kEngineSetEncryptionSecret,
  kEngineSetEncryptionMode,
  kEngineEnableEncryption,
  kEngineRegisterPacketObserver,
  kEngineCreateDataStream,
  kEngineSendStreamMessage,
  kEngineAddPublishStreamUrl,
  kEngineRemovePublishStreamUrl,
  kEngineSetLiveTranscoding,
  kEngineAddVideoWaterMark,
  kEngineClearVideoWaterMarks,
  kEngineSetBeautyEffectOptions,
  kEngineAddInjectStreamUrl,
  kEngineStartChannelMediaRelay,
  kEngineUpdateChannelMediaRelay,
  kEngineStopChannelMediaRelay,
  kEngineRemoveInjectStreamUrl,
  kEngineSendCustomReportMessage,
  kEngineGetConnectionState,
  kEngineEnableRemoteSuperResolution,
  kEngineRegisterMediaMetadataObserver,
  kEngineSetParameters,

  kEngineUnRegisterMediaMetadataObserver,
  kEngineSetMaxMetadataSize,
  kEngineSendMetadata,
  kEngineSetAppType,

  kMediaPushAudioFrame,
  kMediaPullAudioFrame,
  kMediaSetExternalVideoSource,
  kMediaPushVideoFrame,
};

enum ApiTypeChannel {
  kChannelCreateChannel,
  kChannelRelease,
  kChannelJoinChannel,
  kChannelJoinChannelWithUserAccount,
  kChannelLeaveChannel,
  kChannelPublish,
  kChannelUnPublish,
  kChannelChannelId,
  kChannelGetCallId,
  kChannelRenewToken,
  kChannelSetEncryptionSecret,
  kChannelSetEncryptionMode,
  kChannelEnableEncryption,
  kChannelRegisterPacketObserver,
  kChannelRegisterMediaMetadataObserver,
  kChannelUnRegisterMediaMetadataObserver,
  kChannelSetMaxMetadataSize,
  kChannelSendMetadata,
  kChannelSetClientRole,
  kChannelSetRemoteUserPriority,
  kChannelSetRemoteVoicePosition,
  kChannelSetRemoteRenderMode,
  kChannelSetDefaultMuteAllRemoteAudioStreams,
  kChannelSetDefaultMuteAllRemoteVideoStreams,
  kChannelMuteAllRemoteAudioStreams,
  kChannelAdjustUserPlaybackSignalVolume,
  kChannelMuteRemoteAudioStream,
  kChannelMuteAllRemoteVideoStreams,
  kChannelMuteRemoteVideoStream,
  kChannelSetRemoteVideoStreamType,
  kChannelSetRemoteDefaultVideoStreamType,
  kChannelCreateDataStream,
  kChannelSendStreamMessage,
  kChannelAddPublishStreamUrl,
  kChannelRemovePublishStreamUrl,
  kChannelSetLiveTranscoding,
  kChannelAddInjectStreamUrl,
  kChannelRemoveInjectStreamUrl,
  kChannelStartChannelMediaRelay,
  kChannelUpdateChannelMediaRelay,
  kChannelStopChannelMediaRelay,
  kChannelGetConnectionState,
  kChannelEnableRemoteSuperResolution,
};

enum ApiTypeAudioDeviceManager {
  kGetAudioPlaybackDeviceCount,
  kGetAudioPlaybackDeviceInfoByIndex,
  kSetCurrentAudioPlaybackDeviceId,
  kGetCurrentAudioPlaybackDeviceId,
  kGetCurrentAudioPlaybackDeviceInfo,
  kSetAudioPlaybackDeviceVolume,
  kGetAudioPlaybackDeviceVolume,
  kSetAudioPlaybackDeviceMute,
  kGetAudioPlaybackDeviceMute,
  kStartAudioPlaybackDeviceTest,
  kStopAudioPlaybackDeviceTest,

  kGetAudioRecordingDeviceCount,
  kGetAudioRecordingDeviceInfoByIndex,
  kSetCurrentAudioRecordingDeviceId,
  kGetCurrentAudioRecordingDeviceId,
  kGetCurrentAudioRecordingDeviceInfo,
  kSetAudioRecordingDeviceVolume,
  kGetAudioRecordingDeviceVolume,
  kSetAudioRecordingDeviceMute,
  kGetAudioRecordingDeviceMute,
  kStartAudioRecordingDeviceTest,
  kStopAudioRecordingDeviceTest,

  kStartAudioDeviceLoopbackTest,
  kStopAudioDeviceLoopbackTest,
};

enum ApiTypeVideoDeviceManager {
  kGetVideoDeviceCount,
  kGetVideoDeviceInfoByIndex,
  kSetCurrentVideoDeviceId,
  kGetCurrentVideoDeviceId,
  kStartVideoDeviceTest,
  kStopVideoDeviceTest,
};

enum ApiTypeRawDataPlugin {
  kRegisterPlugin,
  kUnregisterPlugin,
  kHasPlugin,
  kEnablePlugin,
  kGetPlugins,
  kSetPluginParameter,
  kGetPluginParameter,
  kRelease
};

#ifdef __cplusplus
}
#endif

namespace agora {
namespace iris {
class IRIS_CPP_API IrisProxy {
 public:
  virtual int CallApi(unsigned int api_type, const char *params,
                      char *result) = 0;

  virtual int CallApi(unsigned int api_type, const char *params, void *buffer,
                      char *result) = 0;
};
}// namespace iris
}// namespace agora

#endif// IRIS_IRIS_BASE_H
