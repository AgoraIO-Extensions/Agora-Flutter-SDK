#pragma once

// class IVideoDeviceManager start
#define FUNC_VIDEODEVICEMANAGER_ENUMERATEVIDEODEVICES                          \
  "VideoDeviceManager_enumerateVideoDevices"
#define FUNC_VIDEODEVICEMANAGER_SETDEVICE "VideoDeviceManager_setDevice"
#define FUNC_VIDEODEVICEMANAGER_GETDEVICE "VideoDeviceManager_getDevice"
#define FUNC_VIDEODEVICEMANAGER_STARTDEVICETEST                                \
  "VideoDeviceManager_startDeviceTest"
#define FUNC_VIDEODEVICEMANAGER_STOPDEVICETEST                                 \
  "VideoDeviceManager_stopDeviceTest"
#define FUNC_VIDEODEVICEMANAGER_RELEASE "VideoDeviceManager_release"
#define FUNC_VIDEODEVICEMANAGER_NUMBEROFCAPABILITIES                           \
  "VideoDeviceManager_numberOfCapabilities"
#define FUNC_VIDEODEVICEMANAGER_GETCAPABILITY "VideoDeviceManager_getCapability"

// class IVideoDeviceManager end

// class IMediaPlayer start
// class IMediaPlayer end

// class IRtcEngine start
#define FUNC_RTCENGINE_SETAPPTYPE "RtcEngine_setAppType"
#define FUNC_RTCENGINE_SETPARAMETERS "RtcEngine_setParameters"
#define FUNC_RTCENGINE_STARTMEDIARENDERINGTRACING                              \
  "RtcEngine_startMediaRenderingTracing"
#define FUNC_RTCENGINEEX_STARTMEDIARENDERINGTRACINGEX                          \
  "RtcEngineEx_startMediaRenderingTracingEx"
#define FUNC_RTCENGINE_ENABLEINSTANTMEDIARENDERING                             \
  "RtcEngine_enableInstantMediaRendering"
#define FUNC_RTCENGINE_RELEASE "RtcEngine_release"
#define FUNC_RTCENGINE_INITIALIZE "RtcEngine_initialize"
#define FUNC_RTCENGINE_QUERYINTERFACE "RtcEngine_queryInterface"
#define FUNC_RTCENGINE_GETVERSION "RtcEngine_getVersion"
#define FUNC_RTCENGINE_GETERRORDESCRIPTION "RtcEngine_getErrorDescription"
#define FUNC_RTCENGINE_QUERYCODECCAPABILITY "RtcEngine_queryCodecCapability"
#define FUNC_RTCENGINE_QUERYDEVICESCORE "RtcEngine_queryDeviceScore"
#define FUNC_RTCENGINE_JOINCHANNEL "RtcEngine_joinChannel"
#define FUNC_RTCENGINE_JOINCHANNEL2 "RtcEngine_joinChannel2"
#define FUNC_RTCENGINE_UPDATECHANNELMEDIAOPTIONS                               \
  "RtcEngine_updateChannelMediaOptions"
#define FUNC_RTCENGINE_LEAVECHANNEL "RtcEngine_leaveChannel"
#define FUNC_RTCENGINE_LEAVECHANNEL2 "RtcEngine_leaveChannel2"
#define FUNC_RTCENGINE_RENEWTOKEN "RtcEngine_renewToken"
#define FUNC_RTCENGINE_SETCHANNELPROFILE "RtcEngine_setChannelProfile"
#define FUNC_RTCENGINE_SETCLIENTROLE "RtcEngine_setClientRole"
#define FUNC_RTCENGINE_SETCLIENTROLE2 "RtcEngine_setClientRole2"
#define FUNC_RTCENGINE_STARTECHOTEST "RtcEngine_startEchoTest"
#define FUNC_RTCENGINE_STARTECHOTEST2 "RtcEngine_startEchoTest2"
#define FUNC_RTCENGINE_STARTECHOTEST3 "RtcEngine_startEchoTest3"
#define FUNC_RTCENGINE_STOPECHOTEST "RtcEngine_stopEchoTest"
#define FUNC_RTCENGINE_ENABLEVIDEO "RtcEngine_enableVideo"
#define FUNC_RTCENGINE_DISABLEVIDEO "RtcEngine_disableVideo"
#define FUNC_RTCENGINE_STARTPREVIEW "RtcEngine_startPreview"
#define FUNC_RTCENGINE_STARTPREVIEW2 "RtcEngine_startPreview2"
#define FUNC_RTCENGINE_STOPPREVIEW "RtcEngine_stopPreview"
#define FUNC_RTCENGINE_STOPPREVIEW2 "RtcEngine_stopPreview2"
#define FUNC_RTCENGINE_STARTLASTMILEPROBETEST "RtcEngine_startLastmileProbeTest"
#define FUNC_RTCENGINE_STOPLASTMILEPROBETEST "RtcEngine_stopLastmileProbeTest"
#define FUNC_RTCENGINE_SETVIDEOENCODERCONFIGURATION                            \
  "RtcEngine_setVideoEncoderConfiguration"
#define FUNC_RTCENGINE_SETBEAUTYEFFECTOPTIONS "RtcEngine_setBeautyEffectOptions"
#define FUNC_RTCENGINE_ENABLEVIRTUALBACKGROUND                                 \
  "RtcEngine_enableVirtualBackground"
#define FUNC_RTCENGINE_SETREMOTEVIDEOSUBSCRIPTIONOPTIONS                       \
  "RtcEngine_setRemoteVideoSubscriptionOptions"
#define FUNC_RTCENGINEEX_SETREMOTEVIDEOSUBSCRIPTIONOPTIONSEX                   \
  "RtcEngineEx_setRemoteVideoSubscriptionOptionsEx"
#define FUNC_RTCENGINE_ENABLEVIDEOIMAGESOURCE "RtcEngine_enableVideoImageSource"
#define FUNC_RTCENGINE_ENABLECONTENTINSPECT "RtcEngine_enableContentInspect"
#define FUNC_RTCENGINE_GETCURRENTMONOTONICTIMEINMS                             \
  "RtcEngine_getCurrentMonotonicTimeInMs"
#define FUNC_RTCENGINE_SETEARMONITORINGAUDIOFRAMEPARAMETERS                    \
  "RtcEngine_setEarMonitoringAudioFrameParameters"
#define FUNC_RTCENGINE_SETUPREMOTEVIDEO "RtcEngine_setupRemoteVideo"
#define FUNC_RTCENGINE_SETUPLOCALVIDEO "RtcEngine_setupLocalVideo"
#define FUNC_RTCENGINE_SETVIDEOSCENARIO "RtcEngine_setVideoScenario"
#define FUNC_RTCENGINE_ENABLEAUDIO "RtcEngine_enableAudio"
#define FUNC_RTCENGINE_DISABLEAUDIO "RtcEngine_disableAudio"
#define FUNC_RTCENGINE_SETAUDIOPROFILE "RtcEngine_setAudioProfile"
#define FUNC_RTCENGINE_SETAUDIOPROFILE2 "RtcEngine_setAudioProfile2"
#define FUNC_RTCENGINE_ENABLELOCALAUDIO "RtcEngine_enableLocalAudio"
#define FUNC_RTCENGINE_MUTELOCALAUDIOSTREAM "RtcEngine_muteLocalAudioStream"
#define FUNC_RTCENGINE_MUTEALLREMOTEAUDIOSTREAMS                               \
  "RtcEngine_muteAllRemoteAudioStreams"
#define FUNC_RTCENGINE_SETDEFAULTMUTEALLREMOTEAUDIOSTREAMS                     \
  "RtcEngine_setDefaultMuteAllRemoteAudioStreams"
#define FUNC_RTCENGINE_MUTEREMOTEAUDIOSTREAM "RtcEngine_muteRemoteAudioStream"
#define FUNC_RTCENGINE_MUTELOCALVIDEOSTREAM "RtcEngine_muteLocalVideoStream"
#define FUNC_RTCENGINE_ENABLELOCALVIDEO "RtcEngine_enableLocalVideo"
#define FUNC_RTCENGINE_MUTEALLREMOTEVIDEOSTREAMS                               \
  "RtcEngine_muteAllRemoteVideoStreams"
#define FUNC_RTCENGINE_SETDEFAULTMUTEALLREMOTEVIDEOSTREAMS                     \
  "RtcEngine_setDefaultMuteAllRemoteVideoStreams"
#define FUNC_RTCENGINE_MUTEREMOTEVIDEOSTREAM "RtcEngine_muteRemoteVideoStream"
#define FUNC_RTCENGINE_SETREMOTEVIDEOSTREAMTYPE                                \
  "RtcEngine_setRemoteVideoStreamType"
#define FUNC_RTCENGINE_SETREMOTEDEFAULTVIDEOSTREAMTYPE                         \
  "RtcEngine_setRemoteDefaultVideoStreamType"
#define FUNC_RTCENGINE_ENABLEAUDIOVOLUMEINDICATION                             \
  "RtcEngine_enableAudioVolumeIndication"
#define FUNC_RTCENGINE_STARTAUDIORECORDING "RtcEngine_startAudioRecording"
#define FUNC_RTCENGINE_STARTAUDIORECORDING2 "RtcEngine_startAudioRecording2"
#define FUNC_RTCENGINE_STARTAUDIORECORDING3 "RtcEngine_startAudioRecording3"
#define FUNC_RTCENGINE_REGISTERAUDIOENCODEDFRAMEOBSERVER                       \
  "RtcEngine_registerAudioEncodedFrameObserver"
#define FUNC_RTCENGINE_UNREGISTERAUDIOENCODEDFRAMEOBSERVER                     \
  "RtcEngine_unregisterAudioEncodedFrameObserver"

#define FUNC_RTCENGINE_STOPAUDIORECORDING "RtcEngine_stopAudioRecording"
#define FUNC_RTCENGINE_CREATEMEDIAPLAYER "RtcEngine_createMediaPlayer"
#define FUNC_RTCENGINE_DESTROYMEDIAPLAYER "RtcEngine_destroyMediaPlayer"
#define FUNC_RTCENGINE_STARTAUDIOMIXING "RtcEngine_startAudioMixing"
#define FUNC_RTCENGINE_STARTAUDIOMIXING2 "RtcEngine_startAudioMixing2"
#define FUNC_RTCENGINE_STOPAUDIOMIXING "RtcEngine_stopAudioMixing"
#define FUNC_RTCENGINE_PAUSEAUDIOMIXING "RtcEngine_pauseAudioMixing"
#define FUNC_RTCENGINE_RESUMEAUDIOMIXING "RtcEngine_resumeAudioMixing"
#define FUNC_RTCENGINE_ADJUSTAUDIOMIXINGVOLUME                                 \
  "RtcEngine_adjustAudioMixingVolume"
#define FUNC_RTCENGINE_ADJUSTAUDIOMIXINGPUBLISHVOLUME                          \
  "RtcEngine_adjustAudioMixingPublishVolume"
#define FUNC_RTCENGINE_GETAUDIOMIXINGPUBLISHVOLUME                             \
  "RtcEngine_getAudioMixingPublishVolume"
#define FUNC_RTCENGINE_ADJUSTAUDIOMIXINGPLAYOUTVOLUME                          \
  "RtcEngine_adjustAudioMixingPlayoutVolume"
#define FUNC_RTCENGINE_GETAUDIOMIXINGPLAYOUTVOLUME                             \
  "RtcEngine_getAudioMixingPlayoutVolume"
#define FUNC_RTCENGINE_GETAUDIOMIXINGDURATION "RtcEngine_getAudioMixingDuration"
#define FUNC_RTCENGINE_GETAUDIOMIXINGCURRENTPOSITION                           \
  "RtcEngine_getAudioMixingCurrentPosition"
#define FUNC_RTCENGINE_SETAUDIOMIXINGPOSITION "RtcEngine_setAudioMixingPosition"
#define FUNC_RTCENGINE_SETAUDIOMIXINGPITCH "RtcEngine_setAudioMixingPitch"
#define FUNC_RTCENGINE_GETEFFECTSVOLUME "RtcEngine_getEffectsVolume"
#define FUNC_RTCENGINE_SETEFFECTSVOLUME "RtcEngine_setEffectsVolume"
#define FUNC_RTCENGINE_PRELOADEFFECT "RtcEngine_preloadEffect"
#define FUNC_RTCENGINE_PLAYEFFECT "RtcEngine_playEffect"
#define FUNC_RTCENGINE_PLAYALLEFFECTS "RtcEngine_playAllEffects"
#define FUNC_RTCENGINE_GETVOLUMEOFEFFECT "RtcEngine_getVolumeOfEffect"
#define FUNC_RTCENGINE_SETVOLUMEOFEFFECT "RtcEngine_setVolumeOfEffect"
#define FUNC_RTCENGINE_PAUSEEFFECT "RtcEngine_pauseEffect"
#define FUNC_RTCENGINE_PAUSEALLEFFECTS "RtcEngine_pauseAllEffects"
#define FUNC_RTCENGINE_RESUMEEFFECT "RtcEngine_resumeEffect"
#define FUNC_RTCENGINE_RESUMEALLEFFECTS "RtcEngine_resumeAllEffects"
#define FUNC_RTCENGINE_STOPEFFECT "RtcEngine_stopEffect"
#define FUNC_RTCENGINE_STOPALLEFFECTS "RtcEngine_stopAllEffects"
#define FUNC_RTCENGINE_UNLOADEFFECT "RtcEngine_unloadEffect"
#define FUNC_RTCENGINE_UNLOADALLEFFECTS "RtcEngine_unloadAllEffects"
#define FUNC_RTCENGINE_ENABLESOUNDPOSITIONINDICATION                           \
  "RtcEngine_enableSoundPositionIndication"
#define FUNC_RTCENGINE_SETREMOTEVOICEPOSITION "RtcEngine_setRemoteVoicePosition"
#define FUNC_RTCENGINE_ENABLESPATIALAUDIO "RtcEngine_enableSpatialAudio"
#define FUNC_RTCENGINE_SETREMOTEUSERSPATIALAUDIOPARAMS                         \
  "RtcEngine_setRemoteUserSpatialAudioParams"
#define FUNC_RTCENGINE_SETVOICEBEAUTIFIERPRESET                                \
  "RtcEngine_setVoiceBeautifierPreset"
#define FUNC_RTCENGINE_SETAUDIOEFFECTPRESET "RtcEngine_setAudioEffectPreset"
#define FUNC_RTCENGINE_SETVOICECONVERSIONPRESET                                \
  "RtcEngine_setVoiceConversionPreset"
#define FUNC_RTCENGINE_SETAUDIOEFFECTPARAMETERS                                \
  "RtcEngine_setAudioEffectParameters"
#define FUNC_RTCENGINE_SETVOICEBEAUTIFIERPARAMETERS                            \
  "RtcEngine_setVoiceBeautifierParameters"
#define FUNC_RTCENGINE_SETVOICECONVERSIONPARAMETERS                            \
  "RtcEngine_setVoiceConversionParameters"
#define FUNC_RTCENGINE_SETLOCALVOICEPITCH "RtcEngine_setLocalVoicePitch"
#define FUNC_RTCENGINE_SETLOCALVOICEFORMANT "RtcEngine_setLocalVoiceFormant"
#define FUNC_RTCENGINE_SETLOCALVOICEEQUALIZATION                               \
  "RtcEngine_setLocalVoiceEqualization"
#define FUNC_RTCENGINE_SETLOCALVOICEREVERB "RtcEngine_setLocalVoiceReverb"
#define FUNC_RTCENGINE_SETLOGFILE "RtcEngine_setLogFile"
#define FUNC_RTCENGINE_SETLOGFILTER "RtcEngine_setLogFilter"
#define FUNC_RTCENGINE_SETLOGLEVEL "RtcEngine_setLogLevel"
#define FUNC_RTCENGINE_SETLOGFILESIZE "RtcEngine_setLogFileSize"
#define FUNC_RTCENGINE_UPLOADLOGFILE "RtcEngine_uploadLogFile"
#define FUNC_RTCENGINE_SETLOCALRENDERMODE "RtcEngine_setLocalRenderMode"
#define FUNC_RTCENGINE_SETREMOTERENDERMODE "RtcEngine_setRemoteRenderMode"
#define FUNC_RTCENGINE_SETLOCALRENDERMODE2 "RtcEngine_setLocalRenderMode2"
#define FUNC_RTCENGINE_SETLOCALVIDEOMIRRORMODE                                 \
  "RtcEngine_setLocalVideoMirrorMode"
#define FUNC_RTCENGINE_ENABLEDUALSTREAMMODE "RtcEngine_enableDualStreamMode"
#define FUNC_RTCENGINE_ENABLEDUALSTREAMMODE2 "RtcEngine_enableDualStreamMode2"

#define FUNC_RTCENGINE_ENABLECUSTOMAUDIOLOCALPLAYBACK                          \
  "RtcEngine_enableCustomAudioLocalPlayback"
#define FUNC_RTCENGINE_SETRECORDINGAUDIOFRAMEPARAMETERS                        \
  "RtcEngine_setRecordingAudioFrameParameters"
#define FUNC_RTCENGINE_SETPLAYBACKAUDIOFRAMEPARAMETERS                         \
  "RtcEngine_setPlaybackAudioFrameParameters"
#define FUNC_RTCENGINE_SETMIXEDAUDIOFRAMEPARAMETERS                            \
  "RtcEngine_setMixedAudioFrameParameters"
#define FUNC_RTCENGINE_SETPLAYBACKAUDIOFRAMEBEFOREMIXINGPARAMETERS             \
  "RtcEngine_setPlaybackAudioFrameBeforeMixingParameters"
#define FUNC_RTCENGINE_ENABLEAUDIOSPECTRUMMONITOR                              \
  "RtcEngine_enableAudioSpectrumMonitor"
#define FUNC_RTCENGINE_DISABLEAUDIOSPECTRUMMONITOR                             \
  "RtcEngine_disableAudioSpectrumMonitor"
#define FUNC_RTCENGINE_REGISTERAUDIOSPECTRUMOBSERVER                           \
  "RtcEngine_registerAudioSpectrumObserver"
#define FUNC_RTCENGINE_UNREGISTERAUDIOSPECTRUMOBSERVER                         \
  "RtcEngine_unregisterAudioSpectrumObserver"
#define FUNC_RTCENGINE_REGISTERAUDIOSPECTRUMOBSERVER_OBSERVER                  \
  "RtcEngine_registerAudioSpectrumObserverObserver"
#define FUNC_RTCENGINE_UNREGISTERAUDIOSPECTRUMOBSERVER_OBSERVER                \
  "RtcEngine_unregisterAudioSpectrumObserverObserver"

#define FUNC_RTCENGINE_ADJUSTRECORDINGSIGNALVOLUME                             \
  "RtcEngine_adjustRecordingSignalVolume"
#define FUNC_RTCENGINE_MUTERECORDINGSIGNAL "RtcEngine_muteRecordingSignal"
#define FUNC_RTCENGINE_ADJUSTPLAYBACKSIGNALVOLUME                              \
  "RtcEngine_adjustPlaybackSignalVolume"
#define FUNC_RTCENGINE_ADJUSTUSERPLAYBACKSIGNALVOLUME                          \
  "RtcEngine_adjustUserPlaybackSignalVolume"
#define FUNC_RTCENGINE_SETLOCALPUBLISHFALLBACKOPTION                           \
  "RtcEngine_setLocalPublishFallbackOption"
#define FUNC_RTCENGINE_SETREMOTESUBSCRIBEFALLBACKOPTION                        \
  "RtcEngine_setRemoteSubscribeFallbackOption"
#define FUNC_RTCENGINE_SETHIGHPRIORITYUSERLIST                                 \
  "RtcEngine_setHighPriorityUserList"
#define FUNC_RTCENGINE_ENABLELOOPBACKRECORDING                                 \
  "RtcEngine_enableLoopbackRecording"
#define FUNC_RTCENGINE_ADJUSTLOOPBACKRECORDINGVOLUME                           \
  "RtcEngine_adjustLoopbackRecordingVolume"
#define FUNC_RTCENGINE_GETLOOPBACKRECORDINGVOLUME                              \
  "RtcEngine_getLoopbackRecordingVolume"
#define FUNC_RTCENGINE_ENABLEINEARMONITORING "RtcEngine_enableInEarMonitoring"
#define FUNC_RTCENGINE_SETINEARMONITORINGVOLUME                                \
  "RtcEngine_setInEarMonitoringVolume"
#define FUNC_RTCENGINE_LOADEXTENSIONPROVIDER "RtcEngine_loadExtensionProvider"
#define FUNC_RTCENGINE_SETEXTENSIONPROVIDERPROPERTY                            \
  "RtcEngine_setExtensionProviderProperty"
#define FUNC_RTCENGINE_ENABLEEXTENSION "RtcEngine_enableExtension"
#define FUNC_RTCENGINE_SETEXTENSIONPROPERTY "RtcEngine_setExtensionProperty"
#define FUNC_RTCENGINE_GETEXTENSIONPROPERTY "RtcEngine_getExtensionProperty"
#define FUNC_RTCENGINE_SETCAMERACAPTURERCONFIGURATION                          \
  "RtcEngine_setCameraCapturerConfiguration"
#define FUNC_RTCENGINE_SWITCHCAMERA "RtcEngine_switchCamera"
#define FUNC_RTCENGINE_ISCAMERAZOOMSUPPORTED "RtcEngine_isCameraZoomSupported"
#define FUNC_RTCENGINE_ISCAMERAFACEDETECTSUPPORTED                             \
  "RtcEngine_isCameraFaceDetectSupported"
#define FUNC_RTCENGINE_ISCAMERATORCHSUPPORTED "RtcEngine_isCameraTorchSupported"
#define FUNC_RTCENGINE_ISCAMERAFOCUSSUPPORTED "RtcEngine_isCameraFocusSupported"
#define FUNC_RTCENGINE_ISCAMERAAUTOFOCUSFACEMODESUPPORTED                      \
  "RtcEngine_isCameraAutoFocusFaceModeSupported"
#define FUNC_RTCENGINE_SETCAMERAZOOMFACTOR "RtcEngine_setCameraZoomFactor"
#define FUNC_RTCENGINE_ENABLEFACEDETECTION "RtcEngine_enableFaceDetection"
#define FUNC_RTCENGINE_GETCAMERAMAXZOOMFACTOR "RtcEngine_getCameraMaxZoomFactor"
#define FUNC_RTCENGINE_SETCAMERAFOCUSPOSITIONINPREVIEW                         \
  "RtcEngine_setCameraFocusPositionInPreview"
#define FUNC_RTCENGINE_SETCAMERATORCHON "RtcEngine_setCameraTorchOn"
#define FUNC_RTCENGINE_SETCAMERAAUTOFOCUSFACEMODEENABLED                       \
  "RtcEngine_setCameraAutoFocusFaceModeEnabled"
#define FUNC_RTCENGINE_ISCAMERAEXPOSUREPOSITIONSUPPORTED                       \
  "RtcEngine_isCameraExposurePositionSupported"
#define FUNC_RTCENGINE_ISCAMERAEXPOSURESUPPORTED                               \
  "RtcEngine_isCameraExposureSupported"
#define FUNC_RTCENGINE_SETCAMERAEXPOSUREFACTOR                                 \
  "RtcEngine_setCameraExposureFactor"
#define FUNC_RTCENGINE_SETCAMERAEXPOSUREPOSITION                               \
  "RtcEngine_setCameraExposurePosition"
#define FUNC_RTCENGINE_ISCAMERAAUTOEXPOSUREFACEMODESUPPORTED                   \
  "RtcEngine_isCameraAutoExposureFaceModeSupported"
#define FUNC_RTCENGINE_SETCAMERAAUTOEXPOSUREFACEMODEENABLED                    \
  "RtcEngine_setCameraAutoExposureFaceModeEnabled"
#define FUNC_RTCENGINE_SETDEFAULTAUDIOROUTETOSPEAKERPHONE                      \
  "RtcEngine_setDefaultAudioRouteToSpeakerphone"
#define FUNC_RTCENGINE_SETENABLESPEAKERPHONE "RtcEngine_setEnableSpeakerphone"
#define FUNC_RTCENGINE_ISSPEAKERPHONEENABLED "RtcEngine_isSpeakerphoneEnabled"
#define FUNC_RTCENGINE_SETROUTEINCOMMUNICATIONMODE                             \
  "RtcEngine_setRouteInCommunicationMode"
#define FUNC_RTCENGINE_GETSCREENCAPTURESOURCES                                 \
  "RtcEngine_getScreenCaptureSources"
#define FUNC_RTCENGINE_RELEASESCREENCAPTURESOURCES                             \
  "RtcEngine_releaseScreenCaptureSources"
#define FUNC_RTCENGINE_SETAUDIOSESSIONOPERATIONRESTRICTION                     \
  "RtcEngine_setAudioSessionOperationRestriction"
#define FUNC_RTCENGINE_STARTSCREENCAPTUREBYSCREENRECT                          \
  "RtcEngine_startScreenCaptureByScreenRect"
#define FUNC_RTCENGINE_STARTSCREENCAPTURE "RtcEngine_startScreenCapture"
#define FUNC_RTCENGINE_GETAUDIODEVICEINFO "RtcEngine_getAudioDeviceInfo"
#define FUNC_RTCENGINE_STARTSCREENCAPTUREBYWINDOWID                            \
  "RtcEngine_startScreenCaptureByWindowId"
#define FUNC_RTCENGINE_SETSCREENCAPTURECONTENTHINT                             \
  "RtcEngine_setScreenCaptureContentHint"
#define FUNC_RTCENGINE_UPDATESCREENCAPTUREREGION                               \
  "RtcEngine_updateScreenCaptureRegion"
#define FUNC_RTCENGINE_UPDATESCREENCAPTUREPARAMETERS                           \
  "RtcEngine_updateScreenCaptureParameters"
#define FUNC_RTCENGINE_STOPSCREENCAPTURE "RtcEngine_stopScreenCapture"
#define FUNC_RTCENGINE_GETCALLID "RtcEngine_getCallId"
#define FUNC_RTCENGINE_RATE "RtcEngine_rate"
#define FUNC_RTCENGINE_COMPLAIN "RtcEngine_complain"
//#define FUNC_RTCENGINE_ADDPUBLISHSTREAMURL "RtcEngine_addPublishStreamUrl"
//#define FUNC_RTCENGINE_REMOVEPUBLISHSTREAMURL "RtcEngine_removePublishStreamUrl"
//#define FUNC_RTCENGINE_SETLIVETRANSCODING "RtcEngine_setLiveTranscoding"
#define FUNC_RTCENGINE_STARTRTMPSTREAMWITHOUTTRANSCODING                       \
  "RtcEngine_startRtmpStreamWithoutTranscoding"
#define FUNC_RTCENGINE_STARTRTMPSTREAMWITHTRANSCODING                          \
  "RtcEngine_startRtmpStreamWithTranscoding"
#define FUNC_RTCENGINE_UPDATERTMPTRANSCODING "RtcEngine_updateRtmpTranscoding"
#define FUNC_RTCENGINE_STOPRTMPSTREAM "RtcEngine_stopRtmpStream"
#define FUNC_RTCENGINE_STARTLOCALVIDEOTRANSCODER                               \
  "RtcEngine_startLocalVideoTranscoder"
#define FUNC_RTCENGINE_UPDATELOCALTRANSCODERCONFIGURATION                      \
  "RtcEngine_updateLocalTranscoderConfiguration"
#define FUNC_RTCENGINE_STOPLOCALVIDEOTRANSCODER                                \
  "RtcEngine_stopLocalVideoTranscoder"
#define FUNC_RTCENGINE_STARTCAMERACAPTURE "RtcEngine_startCameraCapture"
#define FUNC_RTCENGINE_STOPCAMERACAPTURE "RtcEngine_stopCameraCapture"
#define FUNC_RTCENGINE_SETCAMERADEVICEORIENTATION                              \
  "RtcEngine_setCameraDeviceOrientation"
#define FUNC_RTCENGINE_SETSCREENCAPTUREORIENTATION                             \
  "RtcEngine_setScreenCaptureOrientation"
#define FUNC_RTCENGINE_STARTSCREENCAPTURE2 "RtcEngine_startScreenCapture2"
#define FUNC_RTCENGINE_STOPSCREENCAPTURE2 "RtcEngine_stopScreenCapture2"
#define FUNC_RTCENGINE_GETCONNECTIONSTATE "RtcEngine_getConnectionState"
#define FUNC_RTCENGINE_REGISTEREVENTHANDLER "RtcEngine_registerEventHandler"
#define FUNC_RTCENGINE_UNREGISTEREVENTHANDLER "RtcEngine_unregisterEventHandler"
#define FUNC_RTCENGINE_SETREMOTEUSERPRIORITY "RtcEngine_setRemoteUserPriority"
#define FUNC_RTCENGINE_REGISTERPACKETOBSERVER "RtcEngine_registerPacketObserver"
#define FUNC_RTCENGINE_SETENCRYPTIONMODE "RtcEngine_setEncryptionMode"
#define FUNC_RTCENGINE_SETENCRYPTIONSECRET "RtcEngine_setEncryptionSecret"
#define FUNC_RTCENGINE_ENABLEENCRYPTION "RtcEngine_enableEncryption"
#define FUNC_RTCENGINE_CREATEDATASTREAM "RtcEngine_createDataStream"
#define FUNC_RTCENGINE_CREATEDATASTREAM2 "RtcEngine_createDataStream2"
#define FUNC_RTCENGINE_SENDSTREAMMESSAGE "RtcEngine_sendStreamMessage"
#define FUNC_RTCENGINE_ADDVIDEOWATERMARK "RtcEngine_addVideoWatermark"
#define FUNC_RTCENGINE_ADDVIDEOWATERMARK2 "RtcEngine_addVideoWatermark2"
//#define FUNC_RTCENGINE_CLEARVIDEOWATERMARK "RtcEngine_clearVideoWatermark"
#define FUNC_RTCENGINE_CLEARVIDEOWATERMARKS "RtcEngine_clearVideoWatermarks"
#define FUNC_RTCENGINE_PAUSEAUDIO "RtcEngine_pauseAudio"
#define FUNC_RTCENGINE_RESUMEAUDIO "RtcEngine_resumeAudio"
#define FUNC_RTCENGINE_ENABLEWEBSDKINTEROPERABILITY                            \
  "RtcEngine_enableWebSdkInteroperability"
#define FUNC_RTCENGINE_SENDCUSTOMREPORTMESSAGE                                 \
  "RtcEngine_sendCustomReportMessage"

#define FUNC_RTCENGINE_REGISTERMEDIAMETADATAOBSERVER                           \
  "RtcEngine_registerMediaMetadataObserver"
#define FUNC_RTCENGINE_UNREGISTERMEDIAMETADATAOBSERVER                         \
  "RtcEngine_unregisterMediaMetadataObserver"

#define FUNC_RTCENGINE_STARTAUDIOFRAMEDUMP "RtcEngine_startAudioFrameDump"
#define FUNC_RTCENGINE_STOPAUDIOFRAMEDUMP "RtcEngine_stopAudioFrameDump"
#define FUNC_RTCENGINE_SETAINSMODE "RtcEngine_setAINSMode"
#define FUNC_RTCENGINE_REGISTERLOCALUSERACCOUNT                                \
  "RtcEngine_registerLocalUserAccount"
#define FUNC_RTCENGINE_JOINCHANNELWITHUSERACCOUNT                              \
  "RtcEngine_joinChannelWithUserAccount"
#define FUNC_RTCENGINE_JOINCHANNELWITHUSERACCOUNT2                             \
  "RtcEngine_joinChannelWithUserAccount2"
#define FUNC_RTCENGINE_JOINCHANNELWITHUSERACCOUNTEX                            \
  "RtcEngine_joinChannelWithUserAccountEx"
#define FUNC_RTCENGINE_GETUSERINFOBYUSERACCOUNT                                \
  "RtcEngine_getUserInfoByUserAccount"
#define FUNC_RTCENGINE_GETUSERINFOBYUID "RtcEngine_getUserInfoByUid"
#define FUNC_RTCENGINE_STARTCHANNELMEDIARELAY "RtcEngine_startChannelMediaRelay"
#define FUNC_RTCENGINE_UPDATECHANNELMEDIARELAY                                 \
  "RtcEngine_updateChannelMediaRelay"
#define FUNC_RTCENGINE_STOPCHANNELMEDIARELAY "RtcEngine_stopChannelMediaRelay"
#define FUNC_RTCENGINE_PAUSEALLCHANNELMEDIARELAY                               \
  "RtcEngine_pauseAllChannelMediaRelay"
#define FUNC_RTCENGINE_RESUMEALLCHANNELMEDIARELAY                              \
  "RtcEngine_resumeAllChannelMediaRelay"
#define FUNC_RTCENGINE_SETDIRECTCDNSTREAMINGAUDIOCONFIGURATION                 \
  "RtcEngine_setDirectCdnStreamingAudioConfiguration"
#define FUNC_RTCENGINE_SETDIRECTCDNSTREAMINGVIDEOCONFIGURATION                 \
  "RtcEngine_setDirectCdnStreamingVideoConfiguration"
#define FUNC_RTCENGINE_STARTDIRECTCDNSTREAMING                                 \
  "RtcEngine_startDirectCdnStreaming"
#define FUNC_RTCENGINE_STOPDIRECTCDNSTREAMING "RtcEngine_stopDirectCdnStreaming"
#define FUNC_RTCENGINE_UPDATEDIRECTCDNSTREAMINGMEDIAOPTIONS                    \
  "RtcEngine_updateDirectCdnStreamingMediaOptions"
//to delete
//#define FUNC_RTCENGINE_PUSHDIRECTCDNSTREAMINGCUSTOMVIDEOFRAME                  \
//  "RtcEngine_pushDirectCdnStreamingCustomVideoFrame"
#define FUNC_RTCENGINE_TAKESNAPSHOT "RtcEngine_takeSnapshot"
//to delete
//#define FUNC_RTCENGINE_SETCONTENTINSPECT "RtcEngine_SetContentInspect"
//#define FUNC_RTCENGINE_SWITCHCHANNEL "RtcEngine_switchChannel"
#define FUNC_RTCENGINE_STARTRHYTHMPLAYER "RtcEngine_startRhythmPlayer"
#define FUNC_RTCENGINE_STOPRHYTHMPLAYER "RtcEngine_stopRhythmPlayer"
#define FUNC_RTCENGINE_CONFIGRHYTHMPLAYER "RtcEngine_configRhythmPlayer"
#define FUNC_RTCENGINE_ADJUSTCUSTOMAUDIOPUBLISHVOLUME                          \
  "RtcEngine_adjustCustomAudioPublishVolume"
#define FUNC_RTCENGINE_ADJUSTCUSTOMAUDIOPLAYOUTVOLUME                          \
  "RtcEngine_adjustCustomAudioPlayoutVolume"
#define FUNC_RTCENGINE_SETCLOUDPROXY "RtcEngine_setCloudProxy"
#define FUNC_RTCENGINE_SETLOCALACCESSPOINT "RtcEngine_setLocalAccessPoint"
//#define FUNC_RTCENGINE_ENABLEFISHEYECORRECTION                                 \
//  "RtcEngine_enableFishEyeCorrection"
#define FUNC_RTCENGINE_SETADVANCEDAUDIOOPTIONS                                 \
  "RtcEngine_setAdvancedAudioOptions"
#define FUNC_RTCENGINE_SETAVSYNCSOURCE "RtcEngine_setAVSyncSource"
#define FUNC_RTCENGINE_STARTSCREENCAPTUREBYDISPLAYID                           \
  "RtcEngine_startScreenCaptureByDisplayId"
#define FUNC_RTCENGINE_SETMAXMETADATASIZE "RtcEngine_setMaxMetadataSize"
#define FUNC_RTCENGINE_SENDMETADATA "RtcEngine_sendMetaData"

#define FUNC_RTCENGINE_SETVIDEODENOISEROPTIONS                                 \
  "RtcEngine_setVideoDenoiserOptions"

#define FUNC_RTCENGINE_DESTROYCUSTOMVIDEOTRACK                                 \
  "RtcEngine_destroyCustomVideoTrack"
#define FUNC_RTCENGINE_SETSUBSCRIBEAUDIOBLOCKLIST                              \
  "RtcEngine_setSubscribeAudioBlocklist"

#define FUNC_RTCENGINE_SETLOWLIGHTENHANCEOPTIONS                               \
  "RtcEngine_setLowlightEnhanceOptions"
#define FUNC_RTCENGINE_SETCOLORENHANCEOPTIONS "RtcEngine_setColorEnhanceOptions"
#define FUNC_RTCENGINE_ENABLEVIRTUALBACKGROUND                                 \
  "RtcEngine_enableVirtualBackground"
#define FUNC_RTCENGINE_SETAUDIOSCENARIO "RtcEngine_setAudioScenario"
#define FUNC_RTCENGINE_SETREMOTEVIDEOSUBSCRIPTIONOPTIONS                       \
  "RtcEngine_setRemoteVideoSubscriptionOptions"
#define FUNC_RTCENGINE_SETSUBSCRIBEAUDIOALLOWLIST                              \
  "RtcEngine_setSubscribeAudioAllowlist"
#define FUNC_RTCENGINE_SETSUBSCRIBEVIDEOBLOCKLIST                              \
  "RtcEngine_setSubscribeVideoBlocklist"
#define FUNC_RTCENGINE_SETSUBSCRIBEVIDEOALLOWLIST                              \
  "RtcEngine_setSubscribeVideoAllowlist"
#define FUNC_RTCENGINE_UPDATESCREENCAPTURE "RtcEngine_updateScreenCapture"
#define FUNC_RTCENGINE_QUERYSCREENCAPTURECAPABILITY                            \
  "RtcEngine_queryScreenCaptureCapability"
#define FUNC_RTCENGINE_SELECTAUDIOTRACK "RtcEngine_selectAudioTrack"
#define FUNC_RTCENGINE_GETAUDIOTRACKCOUNT "RtcEngine_getAudioTrackCount"
#define FUNC_RTCENGINE_SETAUDIOMIXINGDUALMONOMODE                              \
  "RtcEngine_setAudioMixingDualMonoMode"
#define FUNC_RTCENGINE_CREATECUSTOMENCODEDVIDEOTRACK                           \
  "RtcEngine_createCustomEncodedVideoTrack"
#define FUNC_RTCENGINE_CREATECUSTOMVIDEOTRACK "RtcEngine_createCustomVideoTrack"
#define FUNC_RTCENGINE_ADJUSTLOOPBACKSIGNALVOLUME                              \
  "RtcEngine_adjustLoopbackSignalVolume"
#define FUNC_RTCENGINE_SETADVANCEDAUDIOOPTIONS                                 \
  "RtcEngine_setAdvancedAudioOptions"
#define FUNC_RTCENGINE_DESTROYCUSTOMENCODEDVIDEOTRACK                          \
  "RtcEngine_destroyCustomEncodedVideoTrack"
#define FUNC_RTCENGINE_SETSCREENCAPTURESCENARIO                                \
  "RtcEngine_setScreenCaptureScenario"
#define FUNC_RTCENGINE_STARTSCREENCAPTURE "RtcEngine_startScreenCapture"
#define FUNC_RTCENGINE_ENABLEWIRELESSACCELERATE                                \
  "RtcEngine_enableWirelessAccelerate"
#define FUNC_RTCENGINE_ENABLECONTENTINSPECT "RtcEngine_enableContentInspect"
#define FUNC_RTCENGINE_ENABLEVIDEOIMAGESOURCE "RtcEngine_enableVideoImageSource"
#define FUNC_RTCENGINE_SETDUALSTREAMMODE "RtcEngine_setDualStreamMode"
#define FUNC_RTCENGINE_SETDUALSTREAMMODE2 "RtcEngine_setDualStreamMode2"
#define FUNC_RTCENGINE_GETEFFECTCURRENTPOSITION                                \
  "RtcEngine_getEffectCurrentPosition"
#define FUNC_RTCENGINE_GETEFFECTDURATION "RtcEngine_getEffectDuration"
#define FUNC_RTCENGINE_SETEFFECTPOSITION "RtcEngine_setEffectPosition"
#define FUNC_RTCENGINE_GETNATIVEHANDLE "RtcEngine_getNativeHandle"

#define FUNC_RTCENGINE_GETNETWORKTYPE "RtcEngine_getNetworkType"
#define FUNC_RTCENGINE_SETADVANCEDAUDIOOPTIONS                                 \
  "RtcEngine_setAdvancedAudioOptions"
#define FUNC_RTCENGINE_SETEARMONITORINGAUDIOFRAMEPARAMETERS                    \
  "RtcEngine_setEarMonitoringAudioFrameParameters"
#define FUNC_RTCENGINE_ENABLEMULTICAMERA "RtcEngine_enableMultiCamera"
#define FUNC_RTCENGINE_GETCURRENTMONOTONICTIMEINMS                             \
  "RtcEngine_getCurrentMonotonicTimeInMs"
#define FUNC_RTCENGINE_SETHEADPHONEEQPARAMETERS                                \
  "RtcEngine_setHeadphoneEQParameters"
#define FUNC_RTCENGINE_SETHEADPHONEEQPRESET "RtcEngine_setHeadphoneEQPreset"
#define FUNC_RTCENGINE_SETEXTENSIONPROPERTY2 "RtcEngine_setExtensionProperty2"
#define FUNC_RTCENGINE_ENABLEEXTENSION2 "RtcEngine_enableExtension2"
#define FUNC_RTCENGINE_GETEXTENSIONPROPERTY2 "RtcEngine_getExtensionProperty2"
#define FUNC_RTCENGINE_REGISTEREXTENSION "RtcEngine_registerExtension"
#define FUNC_RTCENGINE_STARTORUPDATECHANNELMEDIARELAY                          \
  "RtcEngine_startOrUpdateChannelMediaRelay"
#define FUNC_RTCENGINE_GETNTPWALLTIMEINMS "RtcEngine_getNtpWallTimeInMs"
#define FUNC_RTCENGINE_ISFEATUREAVAILABLEONDEVICE                              \
  "RtcEngine_isFeatureAvailableOnDevice"
#define FUNC_RTCENGINE_PRELOADCHANNEL "RtcEngine_preloadChannel"
#define FUNC_RTCENGINE_PRELOADCHANNEL2 "RtcEngine_preloadChannel2"
#define FUNC_RTCENGINE_UPDATEPRELOADCHANNELTOKEN                               \
  "RtcEngine_updatePreloadChannelToken"
// class IRtcEngine end

// class IMediaRecorder start
#define FUNC_RTCENGINE_CREATEMEDIARECORDER "RtcEngine_createMediaRecorder"
#define FUNC_RTCENGINE_DESTROYMEDIARECORDER "RtcEngine_destroyMediaRecorder"
#define FUNC_MEDIARECORDER_SETMEDIARECORDEROBSERVER                            \
  "MediaRecorder_setMediaRecorderObserver"
#define FUNC_MEDIARECORDER_UNSETMEDIARECORDEROBSERVER                          \
  "MediaRecorder_unsetMediaRecorderObserver"
#define FUNC_MEDIARECORDER_STARTRECORDING "MediaRecorder_startRecording"
#define FUNC_MEDIARECORDER_STOPRECORDING "MediaRecorder_stopRecording"
// class IMediaRecorder end

// class IMediaPlayer start
#define FUNC_MEDIAPLAYER_INITIALIZE "MediaPlayer_initialize"
#define FUNC_MEDIAPLAYER_GETMEDIAPLAYERID "MediaPlayer_getMediaPlayerId"
#define FUNC_MEDIAPLAYER_OPEN "MediaPlayer_open"
#define FUNC_MEDIAPLAYER_OPENWITHCUSTOMSOURCE "MediaPlayer_openWithCustomSource"
#define FUNC_MEDIAPLAYER_PLAY "MediaPlayer_play"
#define FUNC_MEDIAPLAYER_PAUSE "MediaPlayer_pause"
#define FUNC_MEDIAPLAYER_STOP "MediaPlayer_stop"
#define FUNC_MEDIAPLAYER_RESUME "MediaPlayer_resume"
#define FUNC_MEDIAPLAYER_SEEK "MediaPlayer_seek"
#define FUNC_MEDIAPLAYER_SETAUDIOPITCH "MediaPlayer_setAudioPitch"
#define FUNC_MEDIAPLAYER_GETDURATION "MediaPlayer_getDuration"
#define FUNC_MEDIAPLAYER_GETPLAYPOSITION "MediaPlayer_getPlayPosition"
#define FUNC_MEDIAPLAYER_GETSTREAMCOUNT "MediaPlayer_getStreamCount"
#define FUNC_MEDIAPLAYER_GETSTREAMINFO "MediaPlayer_getStreamInfo"
#define FUNC_MEDIAPLAYER_SETLOOPCOUNT "MediaPlayer_setLoopCount"
/*#define FUNC_MEDIAPLAYER_MUTEAUDIO "MediaPlayer_muteAudio"
#define FUNC_MEDIAPLAYER_ISAUDIOMUTED "MediaPlayer_isAudioMuted"
#define FUNC_MEDIAPLAYER_MUTEVIDEO "MediaPlayer_muteVideo"
#define FUNC_MEDIAPLAYER_ISVIDEOMUTED "MediaPlayer_isVideoMuted"*/
#define FUNC_MEDIAPLAYER_SETPLAYBACKSPEED "MediaPlayer_setPlaybackSpeed"
#define FUNC_MEDIAPLAYER_SELECTAUDIOTRACK "MediaPlayer_selectAudioTrack"
#define FUNC_MEDIAPLAYER_SELECTMULTIAUDIOTRACK                                 \
  "MediaPlayer_selectMultiAudioTrack"
#define FUNC_MEDIAPLAYER_SETPLAYEROPTION "MediaPlayer_setPlayerOption"
#define FUNC_MEDIAPLAYER_SETPLAYEROPTION2 "MediaPlayer_setPlayerOption2"
#define FUNC_MEDIAPLAYER_TAKESCREENSHOT "MediaPlayer_takeScreenshot"
#define FUNC_MEDIAPLAYER_SELECTINTERNALSUBTITLE                                \
  "MediaPlayer_selectInternalSubtitle"
#define FUNC_MEDIAPLAYER_SETEXTERNALSUBTITLE "MediaPlayer_setExternalSubtitle"
#define FUNC_MEDIAPLAYER_GETSTATE "MediaPlayer_getState"
#define FUNC_MEDIAPLAYER_MUTE "MediaPlayer_mute"
#define FUNC_MEDIAPLAYER_GETMUTE "MediaPlayer_getMute"
#define FUNC_MEDIAPLAYER_ADJUSTPLAYOUTVOLUME "MediaPlayer_adjustPlayoutVolume"
#define FUNC_MEDIAPLAYER_GETPLAYOUTVOLUME "MediaPlayer_getPlayoutVolume"
#define FUNC_MEDIAPLAYER_ADJUSTPUBLISHSIGNALVOLUME                             \
  "MediaPlayer_adjustPublishSignalVolume"
#define FUNC_MEDIAPLAYER_GETPUBLISHSIGNALVOLUME                                \
  "MediaPlayer_getPublishSignalVolume"
#define FUNC_MEDIAPLAYER_SETVIEW "MediaPlayer_setView"
#define FUNC_MEDIAPLAYER_SETRENDERMODE "MediaPlayer_setRenderMode"
#define FUNC_MEDIAPLAYER_REGISTERPLAYERSOURCEOBSERVER                          \
  "MediaPlayer_registerPlayerSourceObserver"
#define FUNC_MEDIAPLAYER_UNREGISTERPLAYERSOURCEOBSERVER                        \
  "MediaPlayer_unregisterPlayerSourceObserver"
#define FUNC_MEDIAPLAYER_REGISTERAUDIOFRAMEOBSERVER                            \
  "MediaPlayer_registerAudioFrameObserver"
#define FUNC_MEDIAPLAYER_UNREGISTERAUDIOFRAMEOBSERVER                          \
  "MediaPlayer_unregisterAudioFrameObserver"

#define FUNC_MEDIAPLAYER_REGISTERAUDIOFRAMEOBSERVEROBSERVER                    \
  "MediaPlayer_registerAudioFrameObserverObserver"
#define FUNC_MEDIAPLAYER_UNREGISTERAUDIOFRAMEOBSERVEROBSERVER                  \
  "MediaPlayer_unregisterAudioFrameObserverObserver"

#define FUNC_MEDIAPLAYER_REGISTERVIDEOFRAMEOBSERVER                            \
  "MediaPlayer_registerVideoFrameObserver"
#define FUNC_MEDIAPLAYER_UNREGISTERVIDEOFRAMEOBSERVER                          \
  "MediaPlayer_unregisterVideoFrameObserver"
#define FUNC_MEDIAPLAYER_REGISTERVIDEOFRAMEOBSERVEROBSERVER                    \
  "MediaPlayer_registerVideoFrameObserverObserver"
#define FUNC_MEDIAPLAYER_UNREGISTERVIDEOFRAMEOBSERVEROBSERVER                  \
  "MediaPlayer_unregisterVideoFrameObserverObserver"

#define FUNC_MEDIAPLAYER_REGISTERMEDIAPLAYERAUDIOSPECTRUMOBSERVER              \
  "MediaPlayer_registerMediaPlayerAudioSpectrumObserver"
#define FUNC_MEDIAPLAYER_UNREGISTERMEDIAPLAYERAUDIOSPECTRUMOBSERVER            \
  "MediaPlayer_unregisterMediaPlayerAudioSpectrumObserver"

#define FUNC_MEDIAPLAYER_REGISTERMEDIAPLAYERAUDIOSPECTRUMOBSERVER_OBSERVER     \
  "MediaPlayer_registerMediaPlayerAudioSpectrumObserverObserver"
#define FUNC_MEDIAPLAYER_UNREGISTERMEDIAPLAYERAUDIOSPECTRUMOBSERVER_OBSERVER   \
  "MediaPlayer_unregisterMediaPlayerAudioSpectrumObserverObserver"

#define FUNC_MEDIAPLAYER_SETAUDIODUALMONOMODE "MediaPlayer_setAudioDualMonoMode"
#define FUNC_MEDIAPLAYER_GETPLAYERSDKVERSION "MediaPlayer_getPlayerSdkVersion"
#define FUNC_MEDIAPLAYER_GETPLAYSRC "MediaPlayer_getPlaySrc"
#define FUNC_MEDIAPLAYER_OPENWITHAGORACDNSRC "MediaPlayer_openWithAgoraCDNSrc"
#define FUNC_MEDIAPLAYER_GETAGORACDNLINECOUNT "MediaPlayer_getAgoraCDNLineCount"
#define FUNC_MEDIAPLAYER_SWITCHAGORACDNLINEBYINDEX                             \
  "MediaPlayer_switchAgoraCDNLineByIndex"
#define FUNC_MEDIAPLAYER_GETCURRENTAGORACDNINDEX                               \
  "MediaPlayer_getCurrentAgoraCDNIndex"
#define FUNC_MEDIAPLAYER_ENABLEAUTOSWITCHAGORACDN                              \
  "MediaPlayer_enableAutoSwitchAgoraCDN"
#define FUNC_MEDIAPLAYER_RENEWAGORACDNSRCTOKEN                                 \
  "MediaPlayer_renewAgoraCDNSrcToken"
#define FUNC_MEDIAPLAYER_SWITCHAGORACDNSRC "MediaPlayer_switchAgoraCDNSrc"
#define FUNC_MEDIAPLAYER_SWITCHSRC "MediaPlayer_switchSrc"
#define FUNC_MEDIAPLAYER_PRELOADSRC "MediaPlayer_preloadSrc"
#define FUNC_MEDIAPLAYER_PLAYPRELOADEDSRC "MediaPlayer_playPreloadedSrc"
#define FUNC_MEDIAPLAYER_UNLOADSRC "MediaPlayer_unloadSrc"
#define FUNC_MEDIAPLAYER_SETSPATIALAUDIOPARAMS                                 \
  "MediaPlayer_setSpatialAudioParams"

#define FUNC_MEDIAPLAYER_SETSOUNDPOSITIONPARAMS                                \
  "MediaPlayer_setSoundPositionParams"

#define FUNC_MEDIAPLAYER_OPENWITHMEDIASOURCEPROVIDER                           \
  "MediaPlayer_openWithMediaSourceProvider"
#define FUNC_MEDIAPLAYER_OPENWITHCUSTOMSOURCEPROVIDER                          \
  "MediaPlayer_openWithCustomSourceProvider"
#define FUNC_MEDIAPLAYER_UNOPENWITHMEDIASOURCEPROVIDER                         \
  "MediaPlayer_unOpenWithMediaSourceProvider"
#define FUNC_MEDIAPLAYER_UNOPENWITHCUSTOMSOURCEPROVIDER                        \
  "MediaPlayer_unOpenWithCustomSourceProvider"

#define FUNC_MEDIAPLAYER_OPENWITHMEDIASOURCE "MediaPlayer_openWithMediaSource"
#define FUNC_MEDIAPLAYER_OPENWITHCUSTOMSOURCE "MediaPlayer_openWithCustomSource"
#define FUNC_MEDIAPLAYER_UNOPENWITHMEDIASOURCE                                 \
  "MediaPlayer_unOpenWithMediaSource"
#define FUNC_MEDIAPLAYER_UNOPENWITHCUSTOMSOURCE                                \
  "MediaPlayer_unOpenWithCustomSource"
// class IMediaPlayer end

// class IMediaPlayerCacheManager start
#define FUNC_MEDIAPLAYERCACHEMANAGER_ENABLEAUTOREMOVECACHE                     \
  "MediaPlayerCacheManager_enableAutoRemoveCache"
#define FUNC_MEDIAPLAYERCACHEMANAGER_GETCACHEDIR                               \
  "MediaPlayerCacheManager_getCacheDir"
#define FUNC_MEDIAPLAYERCACHEMANAGER_GETCACHEFILECOUNT                         \
  "MediaPlayerCacheManager_getCacheFileCount"
#define FUNC_MEDIAPLAYERCACHEMANAGER_GETMAXCACHEFILECOUNT                      \
  "MediaPlayerCacheManager_getMaxCacheFileCount"
#define FUNC_MEDIAPLAYERCACHEMANAGER_GETMAXCACHEFILESIZE                       \
  "MediaPlayerCacheManager_getMaxCacheFileSize"
#define FUNC_MEDIAPLAYERCACHEMANAGER_REMOVEALLCACHES                           \
  "MediaPlayerCacheManager_removeAllCaches"
#define FUNC_MEDIAPLAYERCACHEMANAGER_REMOVECACHEBYURI                          \
  "MediaPlayerCacheManager_removeCacheByUri"
#define FUNC_MEDIAPLAYERCACHEMANAGER_REMOVEOLDCACHE                            \
  "MediaPlayerCacheManager_removeOldCache"
#define FUNC_MEDIAPLAYERCACHEMANAGER_SETCACHEDIR                               \
  "MediaPlayerCacheManager_setCacheDir"
#define FUNC_MEDIAPLAYERCACHEMANAGER_SETMAXCACHEFILECOUNT                      \
  "MediaPlayerCacheManager_setMaxCacheFileCount"
#define FUNC_MEDIAPLAYERCACHEMANAGER_SETMAXCACHEFILESIZE                       \
  "MediaPlayerCacheManager_setMaxCacheFileSize"
//class IMediaPlayerCacheManager end

// class IAudioDeviceManager start
#define FUNC_AUDIODEVICEMANAGER_ENUMERATEPLAYBACKDEVICES                       \
  "AudioDeviceManager_enumeratePlaybackDevices"
#define FUNC_AUDIODEVICEMANAGER_ENUMERATERECORDINGDEVICES                      \
  "AudioDeviceManager_enumerateRecordingDevices"
#define FUNC_AUDIODEVICEMANAGER_SETPLAYBACKDEVICE                              \
  "AudioDeviceManager_setPlaybackDevice"
#define FUNC_AUDIODEVICEMANAGER_GETPLAYBACKDEVICE                              \
  "AudioDeviceManager_getPlaybackDevice"
#define FUNC_AUDIODEVICEMANAGER_GETPLAYBACKDEVICEINFO                          \
  "AudioDeviceManager_getPlaybackDeviceInfo"
#define FUNC_AUDIODEVICEMANAGER_SETPLAYBACKDEVICEVOLUME                        \
  "AudioDeviceManager_setPlaybackDeviceVolume"
#define FUNC_AUDIODEVICEMANAGER_GETPLAYBACKDEVICEVOLUME                        \
  "AudioDeviceManager_getPlaybackDeviceVolume"
#define FUNC_AUDIODEVICEMANAGER_SETRECORDINGDEVICE                             \
  "AudioDeviceManager_setRecordingDevice"
#define FUNC_AUDIODEVICEMANAGER_GETRECORDINGDEVICE                             \
  "AudioDeviceManager_getRecordingDevice"
#define FUNC_AUDIODEVICEMANAGER_GETRECORDINGDEVICEINFO                         \
  "AudioDeviceManager_getRecordingDeviceInfo"
#define FUNC_AUDIODEVICEMANAGER_SETRECORDINGDEVICEVOLUME                       \
  "AudioDeviceManager_setRecordingDeviceVolume"
#define FUNC_AUDIODEVICEMANAGER_GETRECORDINGDEVICEVOLUME                       \
  "AudioDeviceManager_getRecordingDeviceVolume"
#define FUNC_AUDIODEVICEMANAGER_SETPLAYBACKDEVICEMUTE                          \
  "AudioDeviceManager_setPlaybackDeviceMute"
#define FUNC_AUDIODEVICEMANAGER_GETPLAYBACKDEVICEMUTE                          \
  "AudioDeviceManager_getPlaybackDeviceMute"
#define FUNC_AUDIODEVICEMANAGER_SETRECORDINGDEVICEMUTE                         \
  "AudioDeviceManager_setRecordingDeviceMute"
#define FUNC_AUDIODEVICEMANAGER_GETRECORDINGDEVICEMUTE                         \
  "AudioDeviceManager_getRecordingDeviceMute"
#define FUNC_AUDIODEVICEMANAGER_STARTPLAYBACKDEVICETEST                        \
  "AudioDeviceManager_startPlaybackDeviceTest"
#define FUNC_AUDIODEVICEMANAGER_STOPPLAYBACKDEVICETEST                         \
  "AudioDeviceManager_stopPlaybackDeviceTest"
#define FUNC_AUDIODEVICEMANAGER_STARTRECORDINGDEVICETEST                       \
  "AudioDeviceManager_startRecordingDeviceTest"
#define FUNC_AUDIODEVICEMANAGER_STOPRECORDINGDEVICETEST                        \
  "AudioDeviceManager_stopRecordingDeviceTest"
#define FUNC_AUDIODEVICEMANAGER_STARTAUDIODEVICELOOPBACKTEST                   \
  "AudioDeviceManager_startAudioDeviceLoopbackTest"
#define FUNC_AUDIODEVICEMANAGER_STOPAUDIODEVICELOOPBACKTEST                    \
  "AudioDeviceManager_stopAudioDeviceLoopbackTest"
#define FUNC_AUDIODEVICEMANAGER_RELEASE "AudioDeviceManager_release"
#define FUNC_AUDIODEVICEMANAGER_FOLLOWSYSTEMRECORDINGDEVICE                    \
  "AudioDeviceManager_followSystemRecordingDevice"
#define FUNC_AUDIODEVICEMANAGER_FOLLOWSYSTEMPLAYBACKDEVICE                     \
  "AudioDeviceManager_followSystemPlaybackDevice"
#define FUNC_AUDIODEVICEMANAGER_FOLLOWSYSTEMLOOPBACKDEVICE                     \
  "AudioDeviceManager_followSystemLoopbackDevice"
#define FUNC_AUDIODEVICEMANAGER_GETLOOPBACKDEVICE                              \
  "AudioDeviceManager_getLoopbackDevice"
#define FUNC_AUDIODEVICEMANAGER_SETLOOPBACKDEVICE                              \
  "AudioDeviceManager_setLoopbackDevice"
#define FUNC_AUDIODEVICEMANAGER_GETPLAYBACKDEFAULTDEVICE                       \
  "AudioDeviceManager_getPlaybackDefaultDevice"
#define FUNC_AUDIODEVICEMANAGER_GETRECORDINGDEAFULTDEVICE                      \
  "AudioDeviceManager_getRecordingDefaultDevice"
#define FUNC_AUDIODEVICEMANAGER_GETPLAYBACKAUDIODEVICEINFO                     \
  "AudioDeviceManager_getPlaybackAudioDeviceInfo"
#define FUNC_AUDIODEVICEMANAGER_GETRECORDINGAUDIODEVICEINFO                    \
  "AudioDeviceManager_getRecordingAudioDeviceInfo"
// class IAudioDeviceManager end

// class ICloudSpatialAudioEngine start
#define FUNC_CLOUDSPATIALAUDIOENGINE_SETMAXAUDIORECVCOUNT                      \
  "CloudSpatialAudioEngine_setMaxAudioRecvCount"
#define FUNC_CLOUDSPATIALAUDIOENGINE_SETAUDIORECVRANGE                         \
  "CloudSpatialAudioEngine_setAudioRecvRange"
#define FUNC_CLOUDSPATIALAUDIOENGINE_SETDISTANCEUNIT                           \
  "CloudSpatialAudioEngine_setDistanceUnit"
#define FUNC_CLOUDSPATIALAUDIOENGINE_UPDATESELFPOSITION                        \
  "CloudSpatialAudioEngine_updateSelfPosition"
#define FUNC_CLOUDSPATIALAUDIOENGINE_UPDATESELFPOSITIONEX                      \
  "CloudSpatialAudioEngine_updateSelfPositionEx"
#define FUNC_CLOUDSPATIALAUDIOENGINE_UPDATEPLAYERPOSITIONINFO                  \
  "CloudSpatialAudioEngine_updatePlayerPositionInfo"
#define FUNC_CLOUDSPATIALAUDIOENGINE_SETPARAMETERS                             \
  "CloudSpatialAudioEngine_setParameters"
#define FUNC_CLOUDSPATIALAUDIOENGINE_INITIALIZE                                \
  "CloudSpatialAudioEngine_initialize"
#define FUNC_CLOUDSPATIALAUDIOENGINE_ADDEVENTHANDLER                           \
  "CloudSpatialAudioEngine_addEventHandler"
#define FUNC_CLOUDSPATIALAUDIOENGINE_REMOVEEVENTHANDLER                        \
  "CloudSpatialAudioEngine_removeEventHandler"
#define FUNC_CLOUDSPATIALAUDIOENGINE_ENABLESPATIALIZER                         \
  "CloudSpatialAudioEngine_enableSpatializer"
#define FUNC_CLOUDSPATIALAUDIOENGINE_SETTEAMID                                 \
  "CloudSpatialAudioEngine_setTeamId"
#define FUNC_CLOUDSPATIALAUDIOENGINE_SETAUDIORANGEMODE                         \
  "CloudSpatialAudioEngine_setAudioRangeMode"
#define FUNC_CLOUDSPATIALAUDIOENGINE_ENTERROOM                                 \
  "CloudSpatialAudioEngine_enterRoom"
#define FUNC_CLOUDSPATIALAUDIOENGINE_RENEWTOKEN                                \
  "CloudSpatialAudioEngine_renewToken"
#define FUNC_CLOUDSPATIALAUDIOENGINE_EXITROOM "CloudSpatialAudioEngine_exitRoom"
#define FUNC_CLOUDSPATIALAUDIOENGINE_GETTEAMMATES                              \
  "CloudSpatialAudioEngine_getTeammates"
#define FUNC_CLOUDSPATIALAUDIOENGINE_MUTELOCALAUDIOSTREAM                      \
  "CloudSpatialAudioEngine_muteLocalAudioStream"
#define FUNC_CLOUDSPATIALAUDIOENGINE_MUTEALLREMOTEAUDIOSTREAMS                 \
  "CloudSpatialAudioEngine_muteAllRemoteAudioStreams"
// class ICloudSpatialAudioEngine end

// class ILocalSpatialAudioEngine start
#define FUNC_LOCALSPATIALAUDIOENGINE_SETMAXAUDIORECVCOUNT                      \
  "LocalSpatialAudioEngine_setMaxAudioRecvCount"
#define FUNC_LOCALSPATIALAUDIOENGINE_SETAUDIORECVRANGE                         \
  "LocalSpatialAudioEngine_setAudioRecvRange"
#define FUNC_LOCALSPATIALAUDIOENGINE_SETDISTANCEUNIT                           \
  "LocalSpatialAudioEngine_setDistanceUnit"
#define FUNC_LOCALSPATIALAUDIOENGINE_UPDATESELFPOSITION                        \
  "LocalSpatialAudioEngine_updateSelfPosition"
#define FUNC_LOCALSPATIALAUDIOENGINE_UPDATESELFPOSITIONEX                      \
  "LocalSpatialAudioEngine_updateSelfPositionEx"
#define FUNC_LOCALSPATIALAUDIOENGINE_UPDATEPLAYERPOSITIONINFO                  \
  "LocalSpatialAudioEngine_updatePlayerPositionInfo"
#define FUNC_LOCALSPATIALAUDIOENGINE_SETPARAMETERS                             \
  "LocalSpatialAudioEngine_setParameters"
#define FUNC_LOCALSPATIALAUDIOENGINE_UPDATEREMOTEPOSITION                      \
  "LocalSpatialAudioEngine_updateRemotePosition"
#define FUNC_LOCALSPATIALAUDIOENGINE_REMOVEREMOTEPOSITION                      \
  "LocalSpatialAudioEngine_removeRemotePosition"
#define FUNC_LOCALSPATIALAUDIOENGINE_CLEARREMOTEPOSITIONS                      \
  "LocalSpatialAudioEngine_clearRemotePositions"
#define FUNC_LOCALSPATIALAUDIOENGINE_UPDATEREMOTEPOSITIONEX                    \
  "LocalSpatialAudioEngine_updateRemotePositionEx"
#define FUNC_LOCALSPATIALAUDIOENGINE_REMOVEREMOTEPOSITIONEX                    \
  "LocalSpatialAudioEngine_removeRemotePositionEx"
#define FUNC_LOCALSPATIALAUDIOENGINE_CLEARREMOTEPOSITIONSEX                    \
  "LocalSpatialAudioEngine_clearRemotePositionsEx"
#define FUNC_LOCALSPATIALAUDIOENGINE_MUTELOCALAUDIOSTREAM                      \
  "LocalSpatialAudioEngine_muteLocalAudioStream"
#define FUNC_LOCALSPATIALAUDIOENGINE_MUTEALLREMOTEAUDIOSTREAMS                 \
  "LocalSpatialAudioEngine_muteAllRemoteAudioStreams"
#define FUNC_LOCALSPATIALAUDIOENGINE_INITIALIZE                                \
  "LocalSpatialAudioEngine_initialize"
#define FUNC_LOCALSPATIALAUDIOENGINE_RELEASE "LocalSpatialAudioEngine_release"
#define FUNC_LOCALSPATIALAUDIOENGINE_MUTEREMOTEAUDIOSTREAM                     \
  "LocalSpatialAudioEngine_muteRemoteAudioStream"
#define FUNC_LOCALSPATIALAUDIOENGINE_SETPLAYERATTENUATION                      \
  "LocalSpatialAudioEngine_setPlayerAttenuation"
#define FUNC_LOCALSPATIALAUDIOENGINE_SETZONES "LocalSpatialAudioEngine_setZones"
#define FUNC_LOCALSPATIALAUDIOENGINE_SETREMOTEAUDIOATTENUATION                 \
  "LocalSpatialAudioEngine_setRemoteAudioAttenuation"
// class ILocalSpatialAudioEngine end

// class IMediaEngine start
#define FUNC_MEDIAENGINE_PUSHAUDIOFRAME "MediaEngine_pushAudioFrame"
#define FUNC_MEDIAENGINE_PULLAUDIOFRAME "MediaEngine_pullAudioFrame"
#define FUNC_MEDIAENGINE_SETEXTERNALVIDEOSOURCE                                \
  "MediaEngine_setExternalVideoSource"
#define FUNC_MEDIAENGINE_SETEXTERNALAUDIOSOURCE                                \
  "MediaEngine_setExternalAudioSource"
#define FUNC_MEDIAENGINE_CREATECUSTOMAUDIOTRACK                                \
  "MediaEngine_createCustomAudioTrack"
#define FUNC_MEDIAENGINE_DESTROYCUSTOMAUDIOTRACK                               \
  "MediaEngine_destroyCustomAudioTrack"
#define FUNC_MEDIAENGINE_SETEXTERNALAUDIOSINK "MediaEngine_setExternalAudioSink"
#define FUNC_MEDIAENGINE_ENABLECUSTOMAUDIOLOCALPLAYBACK                        \
  "MediaEngine_enableCustomAudioLocalPlayback"
#define FUNC_MEDIAENGINE_PUSHVIDEOFRAME "MediaEngine_pushVideoFrame"
#define FUNC_MEDIAENGINE_PUSHVIDEOFRAME2 "MediaEngine_pushVideoFrame2"
#define FUNC_MEDIAENGINE_PUSHENCODEDVIDEOIMAGE                                 \
  "MediaEngine_pushEncodedVideoImage"
#define FUNC_MEDIAENGINE_PUSHENCODEDVIDEOIMAGE2                                \
  "MediaEngine_pushEncodedVideoImage2"
#define FUNC_MEDIAENGINE_RELEASE "MediaEngine_release"
#define FUNC_MEDIAENGINE_REGISTERVIDEOFRAMEOBSERVER                            \
  "MediaEngine_registerVideoFrameObserver"
#define FUNC_MEDIAENGINE_UNREGISTERVIDEOFRAMEOBSERVER                          \
  "MediaEngine_unregisterVideoFrameObserver"
#define FUNC_MEDIAENGINE_REGISTERAUDIOFRAMEOBSERVER                            \
  "MediaEngine_registerAudioFrameObserver"
#define FUNC_MEDIAENGINE_UNREGISTERAUDIOFRAMEOBSERVER                          \
  "MediaEngine_unregisterAudioFrameObserver"
#define FUNC_MEDIAENGINE_REGISTERVIDEOENCODEDFRAMEOBSERVER                     \
  "MediaEngine_registerVideoEncodedFrameObserver"
#define FUNC_MEDIAENGINE_UNREGISTERVIDEOENCODEDFRAMEOBSERVER                   \
  "MediaEngine_unregisterVideoEncodedFrameObserver"
#define FUNC_MEDIAENGINE_ADDVIDEOFRAMERENDERER                                 \
  "MediaEngine_addVideoFrameRenderer"
#define FUNC_MEDIAENGINE_REMOVEVIDEOFRAMERENDERER                              \
  "MediaEngine_removeVideoFrameRenderer"

// class IMediaEngine end

// class IRtcEngineEx start
#define FUNC_RTCENGINEEX_JOINCHANNELEX "RtcEngineEx_joinChannelEx"
#define FUNC_RTCENGINEEX_LEAVECHANNELEX "RtcEngineEx_leaveChannelEx"
#define FUNC_RTCENGINEEX_UPDATECHANNELMEDIAOPTIONSEX                           \
  "RtcEngineEx_updateChannelMediaOptionsEx"
#define FUNC_RTCENGINEEX_SETVIDEOENCODERCONFIGURATIONEX                        \
  "RtcEngineEx_setVideoEncoderConfigurationEx"
#define FUNC_RTCENGINEEX_SETUPREMOTEVIDEOEX "RtcEngineEx_setupRemoteVideoEx"
#define FUNC_RTCENGINEEX_MUTEREMOTEAUDIOSTREAMEX                               \
  "RtcEngineEx_muteRemoteAudioStreamEx"
#define FUNC_RTCENGINEEX_MUTEREMOTEVIDEOSTREAMEX                               \
  "RtcEngineEx_muteRemoteVideoStreamEx"
#define FUNC_RTCENGINEEX_SETREMOTEVIDEOSTREAMTYPEEX                            \
  "RtcEngineEx_setRemoteVideoStreamTypeEx"
#define FUNC_RTCENGINEEX_SETREMOTEVOICEPOSITIONEX                              \
  "RtcEngineEx_setRemoteVoicePositionEx"
#define FUNC_RTCENGINEEX_SETREMOTEUSERSPATIALAUDIOPARAMSEX                     \
  "RtcEngineEx_setRemoteUserSpatialAudioParamsEx"
#define FUNC_RTCENGINEEX_SETREMOTERENDERMODEEX                                 \
  "RtcEngineEx_setRemoteRenderModeEx"
#define FUNC_RTCENGINEEX_ENABLELOOPBACKRECORDINGEX                             \
  "RtcEngineEx_enableLoopbackRecordingEx"
#define FUNC_RTCENGINEEX_GETCONNECTIONSTATEEX "RtcEngineEx_getConnectionStateEx"
#define FUNC_RTCENGINEEX_ENABLEENCRYPTIONEX "RtcEngineEx_enableEncryptionEx"
#define FUNC_RTCENGINEEX_CREATEDATASTREAMEX "RtcEngineEx_createDataStreamEx"
#define FUNC_RTCENGINEEX_CREATEDATASTREAMEX2 "RtcEngineEx_createDataStreamEx2"
#define FUNC_RTCENGINEEX_SENDSTREAMMESSAGEEX "RtcEngineEx_sendStreamMessageEx"
#define FUNC_RTCENGINEEX_ADDVIDEOWATERMARKEX "RtcEngineEx_addVideoWatermarkEx"
#define FUNC_RTCENGINEEX_CLEARVIDEOWATERMARKEX                                 \
  "RtcEngineEx_clearVideoWatermarkEx"
#define FUNC_RTCENGINEEX_SENDCUSTOMREPORTMESSAGEEX                             \
  "RtcEngineEx_sendCustomReportMessageEx"
#define FUNC_RTCENGINEEX_ENABLEAUDIOVOLUMEINDICATIONEX                         \
  "RtcEngineEx_enableAudioVolumeIndicationEx"
#define FUNC_RTCENGINEEX_GETUSERINFOBYUSERACCOUNTEX                            \
  "RtcEngineEx_getUserInfoByUserAccountEx"
#define FUNC_RTCENGINEEX_GETUSERINFOBYUIDEX "RtcEngineEx_getUserInfoByUidEx"
#define FUNC_RTCENGINEEX_ENABLEDUALSTREAMMODEEX                                \
  "RtcEngineEx_enableDualStreamModeEx"
//#define FUNC_RTCENGINEEX_ADDPUBLISHSTREAMURLEX                                 \
//  "RtcEngineEx_addPublishStreamUrlEx"
#define FUNC_RTCENGINEEX_SETSUBSCRIBEVIDEOBLOCKLISTEX                          \
  "RtcEngineEx_setSubscribeVideoBlocklistEx"

#define FUNC_RTCENGINEEX_SETSUBSCRIBEAUDIOBLOCKLISTEX                          \
  "RtcEngineEx_setSubscribeAudioBlocklistEx"
#define FUNC_RTCENGINEEX_SETSUBSCRIBEAUDIOALLOWLISTEX                          \
  "RtcEngineEx_setSubscribeAudioAllowlistEx"
#define FUNC_RTCENGINEEX_SETSUBSCRIBEVIDEOALLOWLISTEX                          \
  "RtcEngineEx_setSubscribeVideoAllowlistEx"
#define FUNC_RTCENGINEEX_SETREMOTEVIDEOSUBSCRIPTIONOPTIONSEX                   \
  "RtcEngineEx_setRemoteVideoSubscriptionOptionsEx"
#define FUNC_RTCENGINEEX_ENABLEWIRELESSACCELERATE                              \
  "RtcEngineEx_enableWirelessAccelerate"
#define FUNC_RTCENGINEEX_SETDUALSTREAMMODEEX "RtcEngineEx_setDualStreamModeEx"
#define FUNC_RTCENGINEEX_TAKESNAPSHOTEX "RtcEngineEx_takeSnapshotEx"
#define FUNC_RTCENGINEEX_ENABLECONTENTINSPECTEX                                \
  "RtcEngineEx_enableContentInspectEx"
#define FUNC_RTCENGINEEX_LEAVECHANNELEX2 "RtcEngineEx_leaveChannelEx2"
#define FUNC_RTCENGINEEX_ADJUSTUSERPLAYBACKSIGNALVOLUMEEX                      \
  "RtcEngineEx_adjustUserPlaybackSignalVolumeEx"
#define FUNC_RTCENGINEEX_MUTEALLREMOTEAUDIOSTREAMSEX                           \
  "RtcEngineEx_muteAllRemoteAudioStreamsEx"
#define FUNC_RTCENGINEEX_MUTEALLREMOTEVIDEOSTREAMSEX                           \
  "RtcEngineEx_muteAllRemoteVideoStreamsEx"
#define FUNC_RTCENGINEEX_MUTELOCALAUDIOSTREAMEX                                \
  "RtcEngineEx_muteLocalAudioStreamEx"
#define FUNC_RTCENGINEEX_MUTELOCALVIDEOSTREAMEX                                \
  "RtcEngineEx_muteLocalVideoStreamEx"
#define FUNC_RTCENGINEEX_PAUSEALLCHANNELMEDIARELAYEX                           \
  "RtcEngineEx_pauseAllChannelMediaRelayEx"
#define FUNC_RTCENGINEEX_RESUMEALLCHANNELMEDIARELAYEX                          \
  "RtcEngineEx_resumeAllChannelMediaRelayEx"
#define FUNC_RTCENGINEEX_STARTCHANNELMEDIARELAYEX                              \
  "RtcEngineEx_startChannelMediaRelayEx"
#define FUNC_RTCENGINEEX_STARTRTMPSTREAMWITHTRANSCODINGEX                      \
  "RtcEngineEx_startRtmpStreamWithTranscodingEx"
#define FUNC_RTCENGINEEX_STARTRTMPSTREAMWITHOUTTRANSCODINGEX                   \
  "RtcEngineEx_startRtmpStreamWithoutTranscodingEx"
#define FUNC_RTCENGINEEX_STOPCHANNELMEDIARELAYEX                               \
  "RtcEngineEx_stopChannelMediaRelayEx"
#define FUNC_RTCENGINEEX_STOPRTMPSTREAMEX "RtcEngineEx_stopRtmpStreamEx"
#define FUNC_RTCENGINEEX_UPDATECHANNELMEDIARELAYEX                             \
  "RtcEngineEx_updateChannelMediaRelayEx"
#define FUNC_RTCENGINEEX_UPDATERTMPTRANSCODINGEX                               \
  "RtcEngineEx_updateRtmpTranscodingEx"
#define FUNC_RTCENGINEEX_ADJUSTRECORDINGSIGNALVOLUMEEX                         \
  "RtcEngineEx_adjustRecordingSignalVolumeEx"
#define FUNC_RTCENGINEEX_MUTERECORDINGSIGNALEX                                 \
  "RtcEngineEx_muteRecordingSignalEx"
#define FUNC_RTCENGINEEX_STARTORUPDATECHANNELMEDIARELAYEX                      \
  "RtcEngineEx_startOrUpdateChannelMediaRelayEx"
#define FUNC_RTCENGINEEX_SETHIGHPRIORITYUSERLISTEX                             \
  "RtcEngineEx_setHighPriorityUserListEx"

// class IRtcEngineEx end

// class IMusicContentCenter start
#define FUNC_MUSICCONTENTCENTER_INITIALIZE "MusicContentCenter_initialize"
#define FUNC_MUSICCONTENTCENTER_REGISTEREVENTHANDLER                           \
  "MusicContentCenter_registerEventHandler"
#define FUNC_MUSICCONTENTCENTER_UNREGISTEREVENTHANDLER                         \
  "MusicContentCenter_unregisterEventHandler"
#define FUNC_MUSICCONTENTCENTER_CREATEMUSICPLAYER                              \
  "MusicContentCenter_createMusicPlayer"
#define FUNC_MUSICCONTENTCENTER_DESTROYMUSICPLAYER                             \
  "MusicContentCenter_destroyMusicPlayer"
#define FUNC_MUSICCONTENTCENTER_GETMUSICCHARTS                                 \
  "MusicContentCenter_getMusicCharts"
#define FUNC_MUSICCONTENTCENTER_GETMUSICCOLLECTIONBYMUSICCHARTID               \
  "MusicContentCenter_getMusicCollectionByMusicChartId"
#define FUNC_MUSICCONTENTCENTER_SEARCHMUSIC "MusicContentCenter_searchMusic"
#define FUNC_MUSICCONTENTCENTER_PRELOAD "MusicContentCenter_preload"
#define FUNC_MUSICCONTENTCENTER_PRELOAD2 "MusicContentCenter_preload2"
#define FUNC_MUSICCONTENTCENTER_ISPRELOADED "MusicContentCenter_isPreloaded"
#define FUNC_MUSICCONTENTCENTER_GETLYRIC "MusicContentCenter_getLyric"
#define FUNC_MUSICCONTENTCENTER_RENEWTOKEN "MusicContentCenter_renewToken"
#define FUNC_MUSICCONTENTCENTER_REMOVECACHE "MusicContentCenter_removeCache"
#define FUNC_MUSICCONTENTCENTER_GETCACHES "MusicContentCenter_getCaches"
#define FUNC_MUSICCONTENTCENTER_GETSONGSIMPLEINFO                              \
  "MusicContentCenter_getSongSimpleInfo"
#define FUNC_MUSICCONTENTCENTER_GETINTERNALSONGCODE                            \
  "MusicContentCenter_getInternalSongCode"
// class IMusicContentCenter end
// class IMusicPlayer start
#define FUNC_MUSICPLAYER_OPEN "MusicPlayer_open"
// class IMusicPlayer end
