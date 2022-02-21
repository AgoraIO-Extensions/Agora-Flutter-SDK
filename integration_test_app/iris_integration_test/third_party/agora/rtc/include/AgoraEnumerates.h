//
// AgoraEnumerates.h
// AgoraRtcEngineKit
//
// Copyright (c) 2018 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Warning code.

Warning codes occur when the SDK encounters an error that may be recovered automatically. These are only notifications, and can generally be ignored. For example, when the SDK loses connection to the server, the SDK reports the AgoraWarningCodeOpenChannelTimeout(106) warning and tries to reconnect automatically.
*/
typedef NS_ENUM(NSInteger, AgoraWarningCode) {
  /** 8: The specified view is invalid. Specify a view when using the video call function. */
  AgoraWarningCodeInvalidView = 8,
  /** 16: Failed to initialize the video function, possibly caused by a lack of resources. The users cannot see the video while the voice communication is not affected. */
  AgoraWarningCodeInitVideo = 16,
  /** 20: The request is pending, usually due to some module not being ready, and the SDK postpones processing the request. */
  AgoraWarningCodePending = 20,
  /** 103: No channel resources are available. Maybe because the server cannot allocate any channel resource. */
  AgoraWarningCodeNoAvailableChannel = 103,
  /** 104: A timeout occurs when looking up the channel. When joining a channel, the SDK looks up the specified channel. The warning usually occurs when the network condition is too poor for the SDK to connect to the server. */
  AgoraWarningCodeLookupChannelTimeout = 104,
  /** 105: The server rejects the request to look up the channel. The server cannot process this request or the request is illegal.
   <p><b>DEPRECATED</b> as of v2.4.1. Use AgoraConnectionChangedRejectedByServer(10) in the `reason` parameter of [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]).</p>
   */
  AgoraWarningCodeLookupChannelRejected = 105,
  /** 106: The server rejects the request to look up the channel. The server cannot process this request or the request is illegal. */
  AgoraWarningCodeOpenChannelTimeout = 106,
  /** 107: The server rejects the request to open the channel. The server cannot process this request or the request is illegal. */
  AgoraWarningCodeOpenChannelRejected = 107,
  /** 111: A timeout occurs when switching to the live video. */
  AgoraWarningCodeSwitchLiveVideoTimeout = 111,
  /** 118: A timeout occurs when setting the client role in the interactive live streaming profile. */
  AgoraWarningCodeSetClientRoleTimeout = 118,
  /** 119: The client role is unauthorized. */
  AgoraWarningCodeSetClientRoleNotAuthorized = 119,
  /** 121: The ticket to open the channel is invalid. */
  AgoraWarningCodeOpenChannelInvalidTicket = 121,
  /** 122: Try connecting to another server. */
  AgoraWarningCodeOpenChannelTryNextVos = 122,
  /** 701: An error occurs in opening the audio mixing file. */
  AgoraWarningCodeAudioMixingOpenError = 701,
  /** 1014: Audio Device Module: a warning occurs in the playback device. */
  AgoraWarningCodeAdmRuntimePlayoutWarning = 1014,
  /** 1016: Audio Device Module: a warning occurs in the sampling device. */
  AgoraWarningCodeAdmRuntimeRecordingWarning = 1016,
  /** 1019: Audio device module: No valid audio data is sampled. */
  AgoraWarningCodeAdmRecordAudioSilence = 1019,
  /** 1020: Audio Device Module: a playback device fails. */
  AgoraWarningCodeAdmPlaybackMalfunction = 1020,
  /** 1021: Audio Device Module: a sampling device fails. */
  AgoraWarningCodeAdmRecordMalfunction = 1021,
  /** 1025: Call is interrupted by system events such as phone call or siri etc. */
  AgoraWarningCodeAdmInterruption = 1025,
  /** 1029: During a call, `AudioSessionCategory` should be set to `AVAudioSessionCategoryPlayAndRecord`, and the SDK monitors this value. If the `AudioSessionCategory` is set to other values, this warning code is triggered and the SDK will forcefully set it back to `AVAudioSessionCategoryPlayAndRecord`.*/
  AgoraWarningCodeAdmCategoryNotPlayAndRecord = 1029,
  /** 1031: Audio Device Module: the sampled audio is too low. */
  AgoraWarningCodeAdmRecordAudioLowlevel = 1031,
  /** 1032: Audio Device Module: the playback audio is too low. */
  AgoraWarningCodeAdmPlayoutAudioLowlevel = 1032,
  /** 1040: Audio device module: An error occurs in the audio driver. Solution: <li>Restart your audio device.<li>Restart your device where the app runs.<li>Upgrade the sound card drive.</li> */
  AgoraWarningCodeAdmNoDataReadyCallback = 1040,
  /** 1042: Audio device module: The audio sampling device is different from the audio playback device, which may cause echoes problem. Agora recommends using the same audio device to sample and playback audio. */
  AgoraWarningCodeAdmInconsistentDevices = 1042,
  /** 1051: (Communication profile only) Audio Processing Module: A howling sound is detected when sampling the audio data */
  AgoraWarningCodeApmHowling = 1051,
  /** 1052: Audio Device Module: the device is in the glitch state. */
  AgoraWarningCodeAdmGlitchState = 1052,
  /** 1053: Audio Processing Module: A residual echo is detected, which may be caused by the belated scheduling of system threads or the signal overflow. */
  AgoraWarningCodeApmResidualEcho = 1053,
  /** 1610: Super-resolution warning: The original resolution of the remote user's video is beyond the range where super resolution can be applied. */
  AgoraWarningCodeSuperResolutionStreamOverLimitation = 1610,
  /** 1611: Super-resolution warning: Super resolution is already being used to boost another remote user's video. */
  AgoraWarningCodeSuperResolutionUserCountOverLimitation = 1611,
  /** 1612: Super-resolution warning: The device does not support using super resolution. */
  AgoraWarningCodeSuperResolutionDeviceNotSupported = 1612,
};

/** Error code.

Error codes occur when the SDK encounters an error that cannot be recovered automatically without any app intervention. For example, the SDK reports the `AgoraErrorCodeStartCall` = `1002` error if it fails to start a call, and reminds the user to call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method.
*/
typedef NS_ENUM(NSInteger, AgoraErrorCode) {
  /** 0: No error occurs. */
  AgoraErrorCodeNoError = 0,
  /** 1: A general error occurs (no specified reason). */
  AgoraErrorCodeFailed = 1,
  /** 2: An invalid parameter is used. For example, the specific channel name includes illegal characters. */
  AgoraErrorCodeInvalidArgument = 2,
  /** 3: The SDK module is not ready.
   <p>Possible solutions：
   <ul><li>Check the audio device.</li>
   <li>Check the completeness of the app.</li>
   <li>Re-initialize the SDK.</li></ul></p>
  */
  AgoraErrorCodeNotReady = 3,
  /** 4: The current state of the SDK does not support this function. */
  AgoraErrorCodeNotSupported = 4,
  /** 5: The request is rejected. This is for internal SDK use only, and is not returned to the app through any method or callback. */
  AgoraErrorCodeRefused = 5,
  /** 6: The buffer size is not big enough to store the returned data. */
  AgoraErrorCodeBufferTooSmall = 6,
  /** 7: The SDK is not initialized before calling this method. */
  AgoraErrorCodeNotInitialized = 7,
  /** 9: No permission exists. Check if the user has granted access to the audio or video device. */
  AgoraErrorCodeNoPermission = 9,
  /** 10: An API method timeout occurs. Some API methods require the SDK to return the execution result, and this error occurs if the request takes too long (over 10 seconds) for the SDK to process. */
  AgoraErrorCodeTimedOut = 10,
  /** 11: The request is canceled. This is for internal SDK use only, and is not returned to the app through any method or callback. */
  AgoraErrorCodeCanceled = 11,
  /** 12: The method is called too often. This is for internal SDK use only, and is not returned to the app through any method or callback. */
  AgoraErrorCodeTooOften = 12,
  /** 13: The SDK fails to bind to the network socket. This is for internal SDK use only, and is not returned to the app through any method or callback. */
  AgoraErrorCodeBindSocket = 13,
  /** 14: The network is unavailable. This is for internal SDK use only, and is not returned to the app through any method or callback. */
  AgoraErrorCodeNetDown = 14,
  /** 15: No network buffers are available. This is for internal SDK use only, and is not returned to the app through any method or callback. */
  AgoraErrorCodeNoBufs = 15,
  /** 17: The request to join the channel is rejected.
   <p>Possible reasons are:
   <ul><li>The user is already in the channel, and still calls the API method to join the channel, for example, [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).</li>
   <li>The user tries to join a channel during a call test ([startEchoTestWithInterval]([AgoraRtcEngineKit startEchoTestWithInterval:successBlock:])). Once you call `startEchoTestWithInterval`, you need to call [stopEchoTest]([AgoraRtcEngineKit stopEchoTest]) before joining a channel.</li>
   <li>The user tries to join the channel with a token that is expired.</li></ul></p>
  */
  AgoraErrorCodeJoinChannelRejected = 17,
  /** 18: The request to leave the channel is rejected.
   <p>Possible reasons are:
   <ul><li>The user left the channel and still calls the API method to leave the channel, for example, [leaveChannel]([AgoraRtcEngineKit leaveChannel:]).</li>
   <li>The user has not joined the channel and calls the API method to leave the channel.</li></ul></p>
  */
  AgoraErrorCodeLeaveChannelRejected = 18,
  /** 19: The resources are occupied and cannot be used. */
  AgoraErrorCodeAlreadyInUse = 19,
  /** 20: The SDK gave up the request due to too many requests.  */
  AgoraErrorCodeAbort = 20,
  /** 21: In Windows, specific firewall settings cause the SDK to fail to initialize and crash. */
  AgoraErrorCodeInitNetEngine = 21,
  /** 22: The app uses too much of the system resources and the SDK fails to allocate the resources. */
  AgoraErrorCodeResourceLimited = 22,
  /** 101: The specified App ID is invalid. Please try to rejoin the channel with a valid App ID.*/
  AgoraErrorCodeInvalidAppId = 101,
  /** 102: The specified channel name is invalid. Please try to rejoin the channel with a valid channel name. */
  AgoraErrorCodeInvalidChannelId = 102,
  /** 103: Fails to get server resources in the specified region. Please try to specify another region when calling [sharedEngineWithConfig]([AgoraRtcEngineKit  sharedEngineWithConfig:delegate:]). */
  AgoraErrorCodeNoServerResources = 103,
  /** 109: The token expired.
   <p><b>DEPRECATED</b> as of v2.4.1. Use AgoraConnectionChangedTokenExpired(9) in the `reason` parameter of [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]).</p>
   <p>Possible reasons are:
   <ul><li>Authorized Timestamp expired: The timestamp is represented by the number of seconds elapsed since 1/1/1970. The user can use the token to access the Agora service within 24 hours after the token is generated. If the user does not access the Agora service after 24 hours, this token is no longer valid.</li>
   <li>Call Expiration Timestamp expired: The timestamp is the exact time when a user can no longer use the Agora service (for example, when a user is forced to leave an ongoing call). When a value is set for the Call Expiration Timestamp, it does not mean that the token will expire, but that the user will be banned from the channel.</li></ul></p>
   */
  AgoraErrorCodeTokenExpired = 109,
  /** 110: The token is invalid.
   <p><b>DEPRECATED</b> as of v2.4.1. Use AgoraConnectionChangedInvalidToken(8) in the `reason` parameter of [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]).</p>
   <p>Possible reasons are:
   <ul><li>The App Certificate for the project is enabled in Console, but the user is using the App ID. Once the App Certificate is enabled, the user must use a token.</li>
   <li>The uid is mandatory, and users must set the same uid as the one set in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method.</li></ul></p>
   */
  AgoraErrorCodeInvalidToken = 110,
  /** 111: The Internet connection is interrupted. This applies to the Agora Web SDK only. */
  AgoraErrorCodeConnectionInterrupted = 111,
  /** 112: The Internet connection is lost. This applies to the Agora Web SDK only. */
  AgoraErrorCodeConnectionLost = 112,
  /** 113: The user is not in the channel when calling the method. */
  AgoraErrorCodeNotInChannel = 113,
  /** 114: The size of the sent data is over 1024 bytes when the user calls the [sendStreamMessage]([AgoraRtcEngineKit sendStreamMessage:data:]) method. */
  AgoraErrorCodeSizeTooLarge = 114,
  /** 115: The bitrate of the sent data exceeds the limit of 6 Kbps when the user calls the [sendStreamMessage]([AgoraRtcEngineKit sendStreamMessage:data:]) method. */
  AgoraErrorCodeBitrateLimit = 115,
  /** 116: Too many data streams (over five streams) are created when the user calls the [createDataStream]([AgoraRtcEngineKit createDataStream:reliable:ordered:]) method. */
  AgoraErrorCodeTooManyDataStreams = 116,
  /** 120: Decryption fails. The user may have used a different encryption password to join the channel. Check your settings or try rejoining the channel. */
  AgoraErrorCodeDecryptionFailed = 120,
  /** 124: Incorrect watermark file parameter. */
  AgoraErrorCodeWatermarkParam = 124,
  /** 125: Incorrect watermark file path. */
  AgoraErrorCodeWatermarkPath = 125,
  /** 126: Incorrect watermark file format. */
  AgoraErrorCodeWatermarkPng = 126,
  /** 127: Incorrect watermark file information. */
  AgoraErrorCodeWatermarkInfo = 127,
  /** 128: Incorrect watermark file data format. */
  AgoraErrorCodeWatermarkAGRB = 128,
  /** 129: An error occurs in reading the watermark file. */
  AgoraErrorCodeWatermarkRead = 129,
  /** 130: The encrypted stream is not allowed to publish. */
  AgoraErrorCodeEncryptedStreamNotAllowedPublish = 130,
  /** 134: The user account is invalid. */
  AgoraErrorCodeInvalidUserAccount = 134,

  /** 151: CDN related errors. Remove the original URL address and add a new one by calling the [removePublishStreamUrl]([AgoraRtcEngineKit removePublishStreamUrl:]) and [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) methods. */
  AgoraErrorCodePublishStreamCDNError = 151,
  /** 152: The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones. */
  AgoraErrorCodePublishStreamNumReachLimit = 152,
  /** 153: The host manipulates other hosts' URLs. Check your app logic. */
  AgoraErrorCodePublishStreamNotAuthorized = 153,
  /** 154: An error occurs in Agora's streaming server. Call the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method to publish the stream again. */
  AgoraErrorCodePublishStreamInternalServerError = 154,
  /** 155: The server fails to find the stream. */
  AgoraErrorCodePublishStreamNotFound = 155,
  /** 156: The format of the RTMP stream URL is not supported. Check whether the URL format is correct. */
  AgoraErrorCodePublishStreamFormatNotSuppported = 156,
  /** 157: The extension library is not integrated, such as the library for enabling deep-learning noise reduction. */
  AgoraErrorCodeModuleNotFound = 157,
  /** 160: The client is already recording audio. To start a new recording, call [stopAudioRecording]([AgoraRtcEngineKit stopAudioRecording])
   to stop the current recording first, and then call [startAudioRecordingWithConfig]([AgoraRtcEngineKit startAudioRecordingWithConfig:]).

   @since v3.4.0
   */
  AgoraErrorCodeAlreadyInRecording = 160,
  /** 1001: Fails to load the media engine. */
  AgoraErrorCodeLoadMediaEngine = 1001,
  /** 1002: Fails to start the call after enabling the media engine. */
  AgoraErrorCodeStartCall = 1002,
  /** 1003: Fails to start the camera.
   <p><b>DEPRECATED</b> as of v2.4.1. Use AgoraLocalVideoStreamErrorCaptureFailure(4) in the `error` parameter of [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]).</p>
   */
  AgoraErrorCodeStartCamera = 1003,
  /** 1004: Fails to start the video rendering module. */
  AgoraErrorCodeStartVideoRender = 1004,
  /** 1005: A general error occurs in the Audio Device Module (the reason is not classified specifically). Check if the audio device is used by another app, or try rejoining the channel. */
  AgoraErrorCodeAdmGeneralError = 1005,
  /** 1006: Audio Device Module: An error occurs in using the Java resources. */
  AgoraErrorCodeAdmJavaResource = 1006,
  /** 1007: Audio Device Module: An error occurs in setting the sampling frequency. */
  AgoraErrorCodeAdmSampleRate = 1007,
  /** 1008: Audio Device Module: An error occurs in initializing the playback device. */
  AgoraErrorCodeAdmInitPlayout = 1008,
  /** 1009: Audio Device Module: An error occurs in starting the playback device. */
  AgoraErrorCodeAdmStartPlayout = 1009,
  /** 1010: Audio Device Module: An error occurs in stopping the playback device. */
  AgoraErrorCodeAdmStopPlayout = 1010,
  /** 1011: Audio Device Module: An error occurs in initializing the sampling device. */
  AgoraErrorCodeAdmInitRecording = 1011,
  /** 1012: Audio Device Module: An error occurs in starting the sampling device. */
  AgoraErrorCodeAdmStartRecording = 1012,
  /** 1013: Audio Device Module: An error occurs in stopping the sampling device. */
  AgoraErrorCodeAdmStopRecording = 1013,
  /** 1015: Audio Device Module: A playback error occurs. Check your playback device, or try rejoining the channel. */
  AgoraErrorCodeAdmRuntimePlayoutError = 1015,
  /** 1017: Audio Device Module: A sampling error occurs. */
  AgoraErrorCodeAdmRuntimeRecordingError = 1017,
  /** 1018: Audio Device Module: Fails to sample the audio data. */
  AgoraErrorCodeAdmRecordAudioFailed = 1018,
  /** 1020: Audio Device Module: The audio playback frequency is abnormal, which may cause audio freezes. This abnormality is caused by high CPU usage. Agora recommends stopping other apps. */
  AgoraErrorCodeAdmPlayAbnormalFrequency = 1020,
  /** 1021: Audio Device Module: The audio sampling frequency is abnormal, which may cause audio freezes. This abnormality is caused by high CPU usage. Agora recommends stopping other apps. */
  AgoraErrorCodeAdmRecordAbnormalFrequency = 1021,
  /** 1022: Audio Device Module: An error occurs in initializing the loopback device. */
  AgoraErrorCodeAdmInitLoopback = 1022,
  /** 1023: Audio Device Module: An error occurs in starting the loopback device. */
  AgoraErrorCodeAdmStartLoopback = 1023,
  /** 1027: Audio Device Module: An error occurs in no audio sampling permission. */
  AgoraErrorCodeAdmNoPermission = 1027,
  /** 1206: Audio device module: Cannot activate the Audio Session.*/
  AgoraErrorCodeAdmActivateSessionFail = 1206,
  /** 1359: No sampling device is available. Check whether the sampling device is connected or whether it is already in use by another app. */
  AgoraErrorCodeAdmNoRecordingDevice = 1359,
  /** 1360: No playback device exists. */
  AgoraErrorCodeAdmNoPlayoutDevice = 1360,
  /** 1501: Video Device Module: The camera is unauthorized. */
  AgoraErrorCodeVdmCameraNotAuthorized = 1501,
  /** 1600: Video Device Module: An unknown error occurs. */
  AgoraErrorCodeVcmUnknownError = 1600,
  /** 1601: Video Device Module: An error occurs in initializing the video encoder. */
  AgoraErrorCodeVcmEncoderInitError = 1601,
  /** 1602: Video Device Module: An error occurs in video encoding. */
  AgoraErrorCodeVcmEncoderEncodeError = 1602,
  /** 1603: Video Device Module: An error occurs in setting the video encoder.
  <p><b>DEPRECATED</b></p>
  */
  AgoraErrorCodeVcmEncoderSetError = 1603,
};

/** The current music file playback state. Reports in the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:]) callback. */
typedef NS_ENUM(NSInteger, AgoraAudioMixingStateCode) {
  /** 710: The music file is playing.
   <p>This state comes with one of the following associated reasons:</p>
   <li><code>AgoraAudioMixingReasonStartedByUser(720)</code></li>
   <li><code>AgoraAudioMixingReasonOneLoopCompleted(721)</code></li>
   <li><code>AgoraAudioMixingReasonStartNewLoop(722)</code></li>
   <li><code>AgoraAudioMixingReasonResumedByUser(726)</code></li>
   */
  AgoraAudioMixingStatePlaying = 710,
  /** 711: The music file pauses playing.
   <p>This state comes with <code>AgoraAudioMixingReasonPausedByUser(725)</code>.</p>
   */
  AgoraAudioMixingStatePaused = 711,
  /** 713: The music file stops playing.
   <p>This state comes with one of the following associated reasons:</p>
   <li><code>AgoraAudioMixingReasonAllLoopsCompleted(723)</code></li>
   <li><code>AgoraAudioMixingReasonStoppedByUser(724)</code></li>
   */
  AgoraAudioMixingStateStopped = 713,
  /** 714: An exception occurs during the playback of the music file.
   <p>This state comes with one of the following associated reasons:</p>
   <li><code>AgoraAudioMixingReasonCanNotOpen(701)</code></li>
   <li><code>AgoraAudioMixingReasonTooFrequentCall(702)</code></li>
   <li><code>AgoraAudioMixingReasonInterruptedEOF(703)</code></li>
   */
  AgoraAudioMixingStateFailed = 714,
};

/** Audio Mixing Error Code. <p>**Deprecated** from v3.4.0. Use AgoraAudioMixingReasonCode instead.</p> */
typedef NS_ENUM(NSInteger, AgoraAudioMixingErrorCode) {
  /** 701: The SDK cannot open the audio mixing file. */
  AgoraAudioMixingErrorCanNotOpen __deprecated_enum_msg("AgoraAudioMixingErrorCanNotOpen is deprecated.") = 701,
  /** 702: The SDK opens the audio mixing file too frequently. */
  AgoraAudioMixingErrorTooFrequentCall __deprecated_enum_msg("AgoraAudioMixingErrorTooFrequentCall is deprecated.") = 702,
  /** 703: The opening of the audio mixing file is interrupted. */
  AgoraAudioMixingErrorInterruptedEOF __deprecated_enum_msg("AgoraAudioMixingErrorInterruptedEOF is deprecated.") = 703,
  /** 0: No error. */
  AgoraAudioMixingErrorOK __deprecated_enum_msg("AgoraAudioMixingErrorOK is deprecated.") = 0,
};

/**  The reason for the change of the music file playback state. Reports in the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:reason:]) callback.

 @since 3.4.0
 */
typedef NS_ENUM(NSInteger, AgoraAudioMixingReasonCode) {
  /** 701: The SDK cannot open the music file. Possible causes include the local music file does not exist, the SDK
   does not support the file format, or the SDK cannot access the music file URL.
   */
  AgoraAudioMixingReasonCanNotOpen = 701,
  /** 702: The SDK opens the music file too frequently. If you need to call
   [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]) multiple times, ensure that the call
   interval is longer than 500 ms.
   */
  AgoraAudioMixingReasonTooFrequentCall = 702,
  /** 703: The music file playback is interrupted.
   */
  AgoraAudioMixingReasonInterruptedEOF = 703,
  /** 720: Successfully calls [startAudioMixing]([AgoraRtcEngineKit startAudioMixing:loopback:replace:cycle:startPos:]) to play a music file.
   */
  AgoraAudioMixingReasonStartedByUser = 720,
  /** 721: The music file completes a loop playback.
   */
  AgoraAudioMixingReasonOneLoopCompleted = 721,
  /** 722: The music file starts a new loop playback.
   */
  AgoraAudioMixingReasonStartNewLoop = 722,
  /** 723: The music file completes all loop playback.
   */
  AgoraAudioMixingReasonAllLoopsCompleted = 723,
  /** 724: Successfully calls [stopAudioMixing]([AgoraRtcEngineKit stopAudioMixing]) to stop playing the music file.
   */
  AgoraAudioMixingReasonStoppedByUser = 724,
  /** 725: Successfully calls [pauseAudioMixing]([AgoraRtcEngineKit pauseAudioMixing]) to pause playing the music file.
   */
  AgoraAudioMixingReasonPausedByUser = 725,
  /** 726: Successfully calls [resumeAudioMixing]([AgoraRtcEngineKit resumeAudioMixing]) to resume playing the music file.
   */
  AgoraAudioMixingReasonResumedByUser = 726,
};

/** Video profile.

**DEPRECATED**

Please use `AgoraVideoEncoderConfiguration`.

iPhones do not support resolutions above 720p.
*/
typedef NS_ENUM(NSInteger, AgoraVideoProfile) {
  /** Invalid profile. */
  AgoraVideoProfileInvalid = -1,
  /** Resolution 160 * 120, frame rate 15 fps, bitrate 65 Kbps. */
  AgoraVideoProfileLandscape120P = 0,
  /** (iOS only) Resolution 120 * 120, frame rate 15 fps, bitrate 50 Kbps. */
  AgoraVideoProfileLandscape120P_3 = 2,
  /** (iOS only) Resolution 320 * 180, frame rate 15 fps, bitrate 140 Kbps. */
  AgoraVideoProfileLandscape180P = 10,
  /** (iOS only) Resolution 180 * 180, frame rate 15 fps, bitrate 100 Kbps. */
  AgoraVideoProfileLandscape180P_3 = 12,
  /** Resolution 240 * 180, frame rate 15 fps, bitrate 120 Kbps. */
  AgoraVideoProfileLandscape180P_4 = 13,
  /** Resolution 320 * 240, frame rate 15 fps, bitrate 200 Kbps. */
  AgoraVideoProfileLandscape240P = 20,
  /** (iOS only) Resolution 240 * 240, frame rate 15 fps, bitrate 140 Kbps. */
  AgoraVideoProfileLandscape240P_3 = 22,
  /** Resolution 424 * 240, frame rate 15 fps, bitrate 220 Kbps. */
  AgoraVideoProfileLandscape240P_4 = 23,
  /** Resolution 640 * 360, frame rate 15 fps, bitrate 400 Kbps. */
  AgoraVideoProfileLandscape360P = 30,
  /** (iOS only) Resolution 360 * 360, frame rate 15 fps, bitrate 260 Kbps. */
  AgoraVideoProfileLandscape360P_3 = 32,
  /** Resolution 640 * 360, frame rate 30 fps, bitrate 600 Kbps. */
  AgoraVideoProfileLandscape360P_4 = 33,
  /** Resolution 360 * 360, frame rate 30 fps, bitrate 400 Kbps. */
  AgoraVideoProfileLandscape360P_6 = 35,
  /** Resolution 480 * 360, frame rate 15 fps, bitrate 320 Kbps. */
  AgoraVideoProfileLandscape360P_7 = 36,
  /** Resolution 480 * 360, frame rate 30 fps, bitrate 490 Kbps. */
  AgoraVideoProfileLandscape360P_8 = 37,
  /** Resolution 640 * 360, frame rate 15 fps, bitrate 800 Kbps.
   <p><b>Note:</b> This profile applies to the interactive live streaming channel profile only.</p>
   */
  AgoraVideoProfileLandscape360P_9 = 38,
  /** Resolution 640 * 360, frame rate 24 fps, bitrate 800 Kbps.
   <p>><b>Note:</b> This profile applies to the interactive live streaming channel profile only.</p>
   */
  AgoraVideoProfileLandscape360P_10 = 39,
  /** Resolution 640 * 360, frame rate 24 fps, bitrate 1000 Kbps.
   <p><b>Note:</b> This profile applies to the interactive live streaming channel profile only.</p>
   */
  AgoraVideoProfileLandscape360P_11 = 100,
  /** Resolution 640 * 480, frame rate 15 fps, bitrate 500 Kbps. */
  AgoraVideoProfileLandscape480P = 40,
  /** (iOS only) Resolution 480 * 480, frame rate 15 fps, bitrate 400 Kbps. */
  AgoraVideoProfileLandscape480P_3 = 42,
  /** Resolution 640 * 480, frame rate 30 fps, bitrate 750 Kbps. */
  AgoraVideoProfileLandscape480P_4 = 43,
  /** Resolution 480 * 480, frame rate 30 fps, bitrate 600 Kbps. */
  AgoraVideoProfileLandscape480P_6 = 45,
  /** Resolution 848 * 480, frame rate 15 fps, bitrate 610 Kbps. */
  AgoraVideoProfileLandscape480P_8 = 47,
  /** Resolution 848 * 480, frame rate 30 fps, bitrate 930 Kbps. */
  AgoraVideoProfileLandscape480P_9 = 48,
  /** Resolution 640 * 480, frame rate 10 fps, bitrate 400 Kbps. */
  AgoraVideoProfileLandscape480P_10 = 49,
  /** Resolution 1280 * 720, frame rate 15 fps, bitrate 1130 Kbps. */
  AgoraVideoProfileLandscape720P = 50,
  /** Resolution 1280 * 720, frame rate 30 fps, bitrate 1710 Kbps. */
  AgoraVideoProfileLandscape720P_3 = 52,
  /** Resolution 960 * 720, frame rate 15 fps, bitrate 910 Kbps. */
  AgoraVideoProfileLandscape720P_5 = 54,
  /** Resolution 960 * 720, frame rate 30 fps, bitrate 1380 Kbps. */
  AgoraVideoProfileLandscape720P_6 = 55,
  /** (macOS only) Resolution 1920 * 1080, frame rate 15 fps, bitrate 2080 Kbps. */
  AgoraVideoProfileLandscape1080P = 60,
  /** (macOS only) Resolution 1920 * 1080, frame rate 30 fps, bitrate 3150 Kbps. */
  AgoraVideoProfileLandscape1080P_3 = 62,
  /** (macOS only) Resolution 1920 * 1080, frame rate 60 fps, bitrate 4780 Kbps. */
  AgoraVideoProfileLandscape1080P_5 = 64,
  /** Reserved for future use. */
  AgoraVideoProfileLandscape1440P = 66,
  /** Reserved for future use. */
  AgoraVideoProfileLandscape1440P_2 = 67,
  /** Reserved for future use. */
  AgoraVideoProfileLandscape4K = 70,
  /** Reserved for future use. */
  AgoraVideoProfileLandscape4K_3 = 72,

  /** Resolution 120 * 160, frame rate 15 fps, bitrate 65 Kbps. */
  AgoraVideoProfilePortrait120P = 1000,
  /** (iOS only) Resolution 120 * 120, frame rate 15 fps, bitrate 50 Kbps. */
  AgoraVideoProfilePortrait120P_3 = 1002,
  /** (iOS only) Resolution 180 * 320, frame rate 15 fps, bitrate 140 Kbps. */
  AgoraVideoProfilePortrait180P = 1010,
  /** (iOS only) Resolution 180 * 180, frame rate 15 fps, bitrate 100 Kbps. */
  AgoraVideoProfilePortrait180P_3 = 1012,
  /** Resolution 180 * 240, frame rate 15 fps, bitrate 120 Kbps. */
  AgoraVideoProfilePortrait180P_4 = 1013,
  /** Resolution 240 * 320, frame rate 15 fps, bitrate 200 Kbps. */
  AgoraVideoProfilePortrait240P = 1020,
  /** (iOS only) Resolution 240 * 240, frame rate 15 fps, bitrate 140 Kbps. */
  AgoraVideoProfilePortrait240P_3 = 1022,
  /** Resolution 240 * 424, frame rate 15 fps, bitrate 220 Kbps. */
  AgoraVideoProfilePortrait240P_4 = 1023,
  /** Resolution 360 * 640, frame rate 15 fps, bitrate 400 Kbps. */
  AgoraVideoProfilePortrait360P = 1030,
  /** (iOS only) Resolution 360 * 360, frame rate 15 fps, bitrate 260 Kbps. */
  AgoraVideoProfilePortrait360P_3 = 1032,
  /** Resolution 360 * 640, frame rate 30 fps, bitrate 600 Kbps. */
  AgoraVideoProfilePortrait360P_4 = 1033,
  /** Resolution 360 * 360, frame rate 30 fps, bitrate 400 Kbps. */
  AgoraVideoProfilePortrait360P_6 = 1035,
  /** Resolution 360 * 480, frame rate 15 fps, bitrate 320 Kbps. */
  AgoraVideoProfilePortrait360P_7 = 1036,
  /** Resolution 360 * 480, frame rate 30 fps, bitrate 490 Kbps. */
  AgoraVideoProfilePortrait360P_8 = 1037,
  /** Resolution 360 * 640, frame rate 15 fps, bitrate 600 Kbps. */
  AgoraVideoProfilePortrait360P_9 = 1038,
  /** Resolution 360 * 640, frame rate 24 fps, bitrate 800 Kbps. */
  AgoraVideoProfilePortrait360P_10 = 1039,
  /** Resolution 360 * 640, frame rate 24 fps, bitrate 800 Kbps. */
  AgoraVideoProfilePortrait360P_11 = 1100,
  /** Resolution 480 * 640, frame rate 15 fps, bitrate 500 Kbps. */
  AgoraVideoProfilePortrait480P = 1040,
  /** (iOS only) Resolution 480 * 480, frame rate 15 fps, bitrate 400 Kbps. */
  AgoraVideoProfilePortrait480P_3 = 1042,
  /** Resolution 480 * 640, frame rate 30 fps, bitrate 750 Kbps. */
  AgoraVideoProfilePortrait480P_4 = 1043,
  /** Resolution 480 * 480, frame rate 30 fps, bitrate 600 Kbps. */
  AgoraVideoProfilePortrait480P_6 = 1045,
  /** Resolution 480 * 848, frame rate 15 fps, bitrate 610 Kbps. */
  AgoraVideoProfilePortrait480P_8 = 1047,
  /** Resolution 480 * 848, frame rate 30 fps, bitrate 930 Kbps. */
  AgoraVideoProfilePortrait480P_9 = 1048,
  /** Resolution 480 * 640, frame rate 10 fps, bitrate 400 Kbps. */
  AgoraVideoProfilePortrait480P_10 = 1049,
  /** Resolution 720 * 1280, frame rate 15 fps, bitrate 1130 Kbps. */
  AgoraVideoProfilePortrait720P = 1050,
  /** Resolution 720 * 1280, frame rate 30 fps, bitrate 1710 Kbps. */
  AgoraVideoProfilePortrait720P_3 = 1052,
  /** Resolution 720 * 960, frame rate 15 fps, bitrate 910 Kbps. */
  AgoraVideoProfilePortrait720P_5 = 1054,
  /** Resolution 720 * 960, frame rate 30 fps, bitrate 1380 Kbps. */
  AgoraVideoProfilePortrait720P_6 = 1055,
  /** (macOS only) Resolution 1080 * 1920, frame rate 15 fps, bitrate 2080 Kbps. */
  AgoraVideoProfilePortrait1080P = 1060,
  /** (macOS only) Resolution 1080 * 1920, frame rate 30 fps, bitrate 3150 Kbps. */
  AgoraVideoProfilePortrait1080P_3 = 1062,
  /** (macOS only) Resolution 1080 * 1920, frame rate 60 fps, bitrate 4780 Kbps. */
  AgoraVideoProfilePortrait1080P_5 = 1064,
  /** Reserved for future use. */
  AgoraVideoProfilePortrait1440P = 1066,
  /** Reserved for future use. */
  AgoraVideoProfilePortrait1440P_2 = 1067,
  /** Reserved for future use. */
  AgoraVideoProfilePortrait4K = 1070,
  /** Reserved for future use. */
  AgoraVideoProfilePortrait4K_3 = 1072,
  /** (Default) Resolution 640 * 360, frame rate 15 fps, bitrate 400 Kbps. */
  AgoraVideoProfileDEFAULT = AgoraVideoProfileLandscape360P,
};

/** The camera capture preference. */
typedef NS_ENUM(NSInteger, AgoraCameraCaptureOutputPreference) {
  /** (default) Self-adapts the camera output parameters to the system performance and network conditions to balance CPU consumption and video preview quality. */
  AgoraCameraCaptureOutputPreferenceAuto = 0,
  /** Prioritizes the system performance. The SDK chooses the dimension and frame rate of the local camera capture closest to those set by [setVideoEncoderConfiguration]([AgoraRtcEngineKit setVideoEncoderConfiguration:]). */
  AgoraCameraCaptureOutputPreferencePerformance = 1,
  /** Prioritizes the local preview quality. The SDK chooses higher camera output parameters to improve the local video preview quality. This option requires extra CPU and RAM usage for video pre-processing. */
  AgoraCameraCaptureOutputPreferencePreview = 2,
  /** Allows you to customize the width and height of the video image captured by the local camera. */
  AgoraCameraCaptureOutputPreferenceManual = 3,
  /** Internal use only */
  AgoraCameraCaptureOutputPreferenceUnkown = 4
};

#if defined(TARGET_OS_IOS) && TARGET_OS_IOS
/** The camera direction. */
typedef NS_ENUM(NSInteger, AgoraCameraDirection) {
  /** The rear camera. */
  AgoraCameraDirectionRear = 0,
  /** The front camera. */
  AgoraCameraDirectionFront = 1,
};
#endif

/** Video frame rate */
typedef NS_ENUM(NSInteger, AgoraVideoFrameRate) {
  /** 1 fps. */
  AgoraVideoFrameRateFps1 = 1,
  /** 7 fps. */
  AgoraVideoFrameRateFps7 = 7,
  /** 10 fps. */
  AgoraVideoFrameRateFps10 = 10,
  /** 15 fps. */
  AgoraVideoFrameRateFps15 = 15,
  /** 24 fps. */
  AgoraVideoFrameRateFps24 = 24,
  /** 30 fps. */
  AgoraVideoFrameRateFps30 = 30,
  /** 60 fps (macOS only). */
  AgoraVideoFrameRateFps60 = 60,
};

/** Video output orientation mode.

  **Note:** When a custom video source is used, if you set AgoraVideoOutputOrientationMode as AgoraVideoOutputOrientationModeFixedLandscape(1) or AgoraVideoOutputOrientationModeFixedPortrait(2), when the rotated video image has a different orientation than the specified output orientation, the video encoder first crops it and then encodes it.
 */
typedef NS_ENUM(NSInteger, AgoraVideoOutputOrientationMode) {
  /** Adaptive mode (Default).
   <p>The video encoder adapts to the orientation mode of the video input device. When you use a custom video source, the output video from the encoder inherits the orientation of the original video.
   <ul><li>If the width of the captured video from the SDK is greater than the height, the encoder sends the video in landscape mode. The encoder also sends the rotational information of the video, and the receiver uses the rotational information to rotate the received video.</li>
   <li>If the original video is in portrait mode, the output video from the encoder is also in portrait mode. The encoder also sends the rotational information of the video to the receiver.</li></ul></p>
   */
  AgoraVideoOutputOrientationModeAdaptative = 0,
  /** Landscape mode.
   <p>The video encoder always sends the video in landscape mode. The video encoder rotates the original video before sending it and the rotational information is 0. This mode applies to scenarios involving CDN live streaming.</p>
   */
  AgoraVideoOutputOrientationModeFixedLandscape = 1,
  /** Portrait mode.
   <p>The video encoder always sends the video in portrait mode. The video encoder rotates the original video before sending it and the rotational information is 0. This mode applies to scenarios involving CDN live streaming.</p>
   */
  AgoraVideoOutputOrientationModeFixedPortrait = 2,
};

/** Channel profile. */
typedef NS_ENUM(NSInteger, AgoraChannelProfile) {
  /** 0: Communication.
   <p>This profile applies to scenarios such as an audio call or video call, where all users can publish and subscribe to streams.</p>
   */
  AgoraChannelProfileCommunication = 0,
  /** 1: Interactive live streaming.
   <p>In this profile, uses have roles, namely, host and audience (default). A host both publishes and subscribes to streams, while an audience subscribes to streams only. This profile applies to scenarios such as a chat room or interactive video streaming.</p>
   */
  AgoraChannelProfileLiveBroadcasting = 1,
  /** Agora recommends not using this profile.
   */
  AgoraChannelProfileGame = 2,
};

/** The role of a user in a interactive live streaming. */
typedef NS_ENUM(NSInteger, AgoraClientRole) {
  /** 1: Host. A host can both send and receive streams.
   If you set this user role in the channel, the SDK automatically calls
   [muteLocalAudioStream(NO)]([AgoraRtcEngineKit muteLocalAudioStream:]) and
   [muteLocalVideoStream(NO)]([AgoraRtcEngineKit muteLocalVideoStream:]).
   */
  AgoraClientRoleBroadcaster = 1,
  /** 2: (Default) Audience. An audience member can only receive streams.
   If you set this user role in the channel, the SDK automatically calls
   [muteLocalAudioStream(YES)]([AgoraRtcEngineKit muteLocalAudioStream:]) and
   [muteLocalVideoStream(YES)]([AgoraRtcEngineKit muteLocalVideoStream:]).
   */
  AgoraClientRoleAudience = 2,
};

/** The latency level of an audience member in a interactive live streaming.<p>**Note**:</p><p>Takes effect only when the user role is
 `AgoraClientRoleAudience`.</p> */
typedef NS_ENUM(NSInteger, AgoraAudienceLatencyLevelType) {
  /** 1: Low latency. */
  AgoraAudienceLatencyLevelLowLatency = 1,
  /** 2: (Default) Ultra low latency. */
  AgoraAudienceLatencyLevelUltraLowLatency = 2,
};

/** The brightness level of the video image captured by the local camera. */
typedef NS_ENUM(NSInteger, AgoraCaptureBrightnessLevelType) {
  /** -1: The SDK does not detect the brightness level of the video image.
   Wait a few seconds to get the brightness level in the next callback.
   */
  AgoraCaptureBrightnessLevelInvalid = -1,
  /** 0: The brightness level of the video image is normal.
   */
  AgoraCaptureBrightnessLevelNormal = 0,
  /** 1: The brightness level of the video image is too bright.
   */
  AgoraCaptureBrightnessLevelBright = 1,
  /** 2: The brightness level of the video image is too dark.
   */
  AgoraCaptureBrightnessLevelDark = 2,
};

/** Media type. */
typedef NS_ENUM(NSInteger, AgoraMediaType) {
  /** No audio and video. */
  AgoraMediaTypeNone = 0,
  /** Audio only. */
  AgoraMediaTypeAudioOnly = 1,
  /** Video only. */
  AgoraMediaTypeVideoOnly = 2,
  /** Audio and video. */
  AgoraMediaTypeAudioAndVideo = 3,
};

/** Encryption mode. Agora recommends using either the
 `AgoraEncryptionModeAES128GCM2` or `AgoraEncryptionModeAES256GCM2` encryption
 mode, both of which support adding a salt and are more secure.
 */
typedef NS_ENUM(NSInteger, AgoraEncryptionMode) {
  /** 0: **Deprecated** as of v3.4.5. */
  AgoraEncryptionModeNone __deprecated_enum_msg("AgoraEncryptionModeNone is deprecated.") = 0,
  /** 1: 128-bit AES encryption, XTS mode. */
  AgoraEncryptionModeAES128XTS = 1,
  /** 2: 128-bit AES encryption, ECB mode. */
  AgoraEncryptionModeAES128ECB = 2,
  /** 3: 256-bit AES encryption, XTS mode. */
  AgoraEncryptionModeAES256XTS = 3,
  /** 4: Reserved parameter. */
  AgoraEncryptionModeSM4128ECB = 4,
  /** 5: 128-bit AES encryption, GCM mode.

   @since v3.3.1
   */
  AgoraEncryptionModeAES128GCM = 5,
  /** 6: 256-bit AES encryption, GCM mode.

   @since v3.3.1
   */
  AgoraEncryptionModeAES256GCM = 6,
  /** 7: (Default) 128-bit AES encryption, GCM mode. Compared to
   `AgoraEncryptionModeAES128GCM` encryption mode,
   `AgoraEncryptionModeAES128GCM2` encryption mode is more secure and requires
   you to set the salt (`encryptionKdfSalt`).

   @since v3.4.5
   */
  AgoraEncryptionModeAES128GCM2 = 7,
  /** 8: 256-bit AES encryption, GCM mode. Compared to
   `AgoraEncryptionModeAES256GCM` encryption mode,
   `AgoraEncryptionModeAES256GCM2` encryption mode is more secure and requires
   you to set the salt (`encryptionKdfSalt`).

   @since v3.4.5
   */
  AgoraEncryptionModeAES256GCM2 = 8,
  /** Enumerator boundary */
  AgoraEncryptionModeEnd,
};

/** Reason for the user being offline. */
typedef NS_ENUM(NSUInteger, AgoraUserOfflineReason) {
  /** The user left the current channel. */
  AgoraUserOfflineReasonQuit = 0,
  /** The SDK timed out and the user dropped offline because no data packet is received within a certain period of time. If a user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline. */
  AgoraUserOfflineReasonDropped = 1,
  /** (Interactive live streaming only.) The client role switched from the host to the audience. */
  AgoraUserOfflineReasonBecomeAudience = 2,
};

/** The RTMP or RTMPS streaming state. */
typedef NS_ENUM(NSUInteger, AgoraRtmpStreamingState) {
  /** The RTMP or RTMPS streaming has not started or has ended. This state is also triggered after you remove an RTMP or RTMPS stream from the CDN by calling [removePublishStreamUrl]([AgoraRtcEngineKit removePublishStreamUrl:]).*/
  AgoraRtmpStreamingStateIdle = 0,
  /** The SDK is connecting to Agora's streaming server and the CDN server. This state is triggered after you call the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method. */
  AgoraRtmpStreamingStateConnecting = 1,
  /** The RTMP or RTMPS streaming is being published. The SDK successfully publishes the RTMP or RTMPS streaming and returns this state. */
  AgoraRtmpStreamingStateRunning = 2,
  /** The RTMP or RTMPS streaming is recovering. When exceptions occur to the CDN, or the streaming is interrupted, the SDK attempts to resume RTMP or RTMPS streaming and returns this state.
<li> If the SDK successfully resumes the streaming, `AgoraRtmpStreamingStateRunning(2)` returns.
<li> If the streaming does not resume within 60 seconds or server errors occur, AgoraRtmpStreamingStateFailure(4) returns. You can also reconnect to the server by calling the [removePublishStreamUrl]([AgoraRtcEngineKit removePublishStreamUrl:]) and [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) methods. */
  AgoraRtmpStreamingStateRecovering = 3,
  /** The RTMP or RTMPS streaming fails. See the errorCode parameter for the detailed error information. You can also call the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method to publish the RTMP or RTMPS streaming again. */
  AgoraRtmpStreamingStateFailure = 4,
};

/** The detailed error information for streaming. */
typedef NS_ENUM(NSUInteger, AgoraRtmpStreamingErrorCode) {
  /** The RTMP or RTMPS streaming publishes successfully. */
  AgoraRtmpStreamingErrorCodeOK = 0,
  /** Invalid argument used. If, for example, you do not call the [setLiveTranscoding]([AgoraRtcEngineKit setLiveTranscoding:]) method to configure the LiveTranscoding parameters before calling the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method, the SDK returns this error. Check whether you set the parameters in the setLiveTranscoding method properly. */
  AgoraRtmpStreamingErrorCodeInvalidParameters = 1,
  /** The RTMP or RTMPS streaming is encrypted and cannot be published. */
  AgoraRtmpStreamingErrorCodeEncryptedStreamNotAllowed = 2,
  /** Timeout for the RTMP or RTMPS streaming. Call the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method to publish the streaming again. */
  AgoraRtmpStreamingErrorCodeConnectionTimeout = 3,
  /** An error occurs in Agora's streaming server. Call the [addPublishStreamUrl]([AgoraRtcEngineKit addPublishStreamUrl:transcodingEnabled:]) method to publish the streaming again. */
  AgoraRtmpStreamingErrorCodeInternalServerError = 4,
  /** An error occurs in the CDN server. */
  AgoraRtmpStreamingErrorCodeRtmpServerError = 5,
  /** The RTMP or RTMPS streaming publishes too frequently. */
  AgoraRtmpStreamingErrorCodeTooOften = 6,
  /** The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones. */
  AgoraRtmpStreamingErrorCodeReachLimit = 7,
  /** The host manipulates other hosts' URLs. Check your app logic. */
  AgoraRtmpStreamingErrorCodeNotAuthorized = 8,
  /** Agora's server fails to find the RTMP or RTMPS streaming. */
  AgoraRtmpStreamingErrorCodeStreamNotFound = 9,
  /** The format of the RTMP or RTMPS streaming URL is not supported. Check whether the URL format is correct. */
  AgoraRtmpStreamingErrorCodeFormatNotSupported = 10,
  /** The streaming has been stopped normally. After you call
   [removePublishStreamUrl]([AgoraRtcEngineKit removePublishStreamUrl:]) to
   stop streaming, the SDK returns this value.

   @since v3.4.5
   */
  AgoraRtmpStreamingErrorCodeUnpublishOK = 100,
};

/** Events during the RTMP or RTMPS streaming. */
typedef NS_ENUM(NSUInteger, AgoraRtmpStreamingEvent) {
  /** 1: An error occurs when you add a background image or a watermark image
   to the RTMP stream.
   */
  AgoraRtmpStreamingEventFailedLoadImage = 1,
  /** 2: The streaming URL is already being used for CDN live streaming. If you
   want to start new streaming, use a new streaming URL.

   @since v3.4.5
   */
  AgoraRtmpStreamingEventUrlAlreadyInUse = 2,
};

/** State of importing an external video stream in the interactive live streaming. */
typedef NS_ENUM(NSUInteger, AgoraInjectStreamStatus) {
  /** The external video stream imported successfully. */
  AgoraInjectStreamStatusStartSuccess = 0,
  /** The external video stream already exists. */
  AgoraInjectStreamStatusStartAlreadyExists = 1,
  /** The external video stream import is unauthorized. */
  AgoraInjectStreamStatusStartUnauthorized = 2,
  /** Import external video stream timeout. */
  AgoraInjectStreamStatusStartTimedout = 3,
  /** The external video stream failed to import. */
  AgoraInjectStreamStatusStartFailed = 4,
  /** The external video stream imports successfully. */
  AgoraInjectStreamStatusStopSuccess = 5,
  /** No external video stream is found. */
  AgoraInjectStreamStatusStopNotFound = 6,
  /** The external video stream is stopped from being unauthorized. */
  AgoraInjectStreamStatusStopUnauthorized = 7,
  /** Importing the external video stream timeout. */
  AgoraInjectStreamStatusStopTimedout = 8,
  /** Importing the external video stream failed. */
  AgoraInjectStreamStatusStopFailed = 9,
  /** The external video stream import is interrupted. */
  AgoraInjectStreamStatusBroken = 10,
};

/** Output log filter level. */
typedef NS_ENUM(NSUInteger, AgoraLogFilter) {
  /** Do not output any log information. */
  AgoraLogFilterOff = 0,
  /** Output all log information. Set your log filter as debug if you want to get the most complete log file. */
  AgoraLogFilterDebug = 0x080f,
  /** Output CRITICAL, ERROR, WARNING, and INFO level log information. We recommend setting your log filter as this level. */
  AgoraLogFilterInfo = 0x000f,
  /** Outputs CRITICAL, ERROR, and WARNING level log information. */
  AgoraLogFilterWarning = 0x000e,
  /** Outputs CRITICAL and ERROR level log information. */
  AgoraLogFilterError = 0x000c,
  /** Outputs CRITICAL level log information. */
  AgoraLogFilterCritical = 0x0008,
};

/** Audio recording quality, which is set in [startAudioRecordingWithConfig]([AgoraRtcEngineKit startAudioRecordingWithConfig:]). */
typedef NS_ENUM(NSInteger, AgoraAudioRecordingQuality) {
  /** 0: Low quality. For example, the size of an AAC file with a sample rate of 32,000 Hz and a 10-minute recording is approximately 1.2 MB. */
  AgoraAudioRecordingQualityLow = 0,
  /** 1: (Default) Medium quality. For example, the size of an AAC file with a sample rate of 32,000 Hz and a 10-minute recording is approximately 2 MB. */
  AgoraAudioRecordingQualityMedium = 1,
  /** 2: High quality. For example, the size of an AAC file with a sample rate of 32,000 Hz and a 10-minute recording is approximately 3.75 MB. */
  AgoraAudioRecordingQualityHigh = 2
};

/** Recording content, which is set in [startAudioRecordingWithConfig]([AgoraRtcEngineKit startAudioRecordingWithConfig:]). */
typedef NS_ENUM(NSInteger, AgoraAudioRecordingPosition) {
  /** 0: (Default) Records the mixed audio of the local user and all remote users. */
  AgoraAudioRecordingPositionMixedRecordingAndPlayback = 0,
  /** 1: Records the audio of the local user only. */
  AgoraAudioRecordingPositionRecording = 1,
  /** 2: Records the audio of all remote users only. */
  AgoraAudioRecordingPositionMixedPlayback = 2
};

/** Lifecycle of the CDN live video stream.

**DEPRECATED**
*/
typedef NS_ENUM(NSInteger, AgoraRtmpStreamLifeCycle) {
  /** Bound to the channel lifecycle. If all hosts leave the channel, the CDN live streaming stops after 30 seconds. */
  AgoraRtmpStreamLifeCycleBindToChannel = 1,
  /** Bound to the owner of the RTMP stream. If the owner leaves the channel, the CDN live streaming stops immediately. */
  AgoraRtmpStreamLifeCycleBindToOwnner = 2,
};

/** Network quality. */
typedef NS_ENUM(NSUInteger, AgoraNetworkQuality) {
  /** The network quality is unknown. */
  AgoraNetworkQualityUnknown = 0,
  /** The network quality is excellent. */
  AgoraNetworkQualityExcellent = 1,
  /** The network quality is quite good, but the bitrate may be slightly lower than excellent. */
  AgoraNetworkQualityGood = 2,
  /** Users can feel the communication slightly impaired. */
  AgoraNetworkQualityPoor = 3,
  /** Users can communicate only not very smoothly. */
  AgoraNetworkQualityBad = 4,
  /** The network quality is so bad that users can hardly communicate. */
  AgoraNetworkQualityVBad = 5,
  /** The network is disconnected and users cannot communicate at all. */
  AgoraNetworkQualityDown = 6,
  /** Users cannot detect the network quality. (Not in use.) */
  AgoraNetworkQualityUnsupported = 7,
  /** Detecting the network quality. */
  AgoraNetworkQualityDetecting = 8,
};

/** Quality of experience (QoE) of the local user when receiving a remote audio stream.

 @since v3.3.0
 */
typedef NS_ENUM(NSUInteger, AgoraExperienceQuality) {
  /** QoE of the local user is good. */
  AgoraExperienceQualityGood = 0,
  /** QoE of the local user is poor. */
  AgoraExperienceQualityBad = 1,
};

/** The reason for poor QoE of the local user when receiving a remote audio stream.

 @since v3.3.0
 */
typedef NS_ENUM(NSUInteger, AgoraExperiencePoorReason) {
  /** None, indicating good QoE of the local user. */
  AgoraExperienceReasonNone = 0,
  /** The remote user's network quality is poor. */
  AgoraRemoteNetworkPoor = 1,
  /** The local user's network quality is poor. */
  AgoraLocalNetworkPoor = 2,
  /** The local user's Wi-Fi or mobile network signal is weak. */
  AgoraWirelessSignalPoor = 4,
  /** he local user enables both Wi-Fi and bluetooth, and their signals interfere with each other. As a result, audio transmission quality is undermined. */
  AgoraWifiBluetoothCoexist = 8,
};

/** API for future use.
 */
typedef NS_ENUM(NSInteger, AgoraUploadErrorReason) {
  AgoraUploadErrorReasonSuccess = 0,
  AgoraUploadErrorReasonNetError = 1,
  AgoraUploadErrorReasonServerError = 2,
};

/** Video stream type. */
typedef NS_ENUM(NSInteger, AgoraVideoStreamType) {
  /** High-bitrate, high-resolution video stream. */
  AgoraVideoStreamTypeHigh = 0,
  /** Low-bitrate, low-resolution video stream. */
  AgoraVideoStreamTypeLow = 1,
};

/** The priority of the remote user. */
typedef NS_ENUM(NSInteger, AgoraUserPriority) {
  /** The user's priority is high. */
  AgoraUserPriorityHigh = 50,
  /** (Default) The user's priority is normal. */
  AgoraUserPriorityNormal = 100,
};

/**  Quality change of the local video in terms of target frame rate and target bit rate since last count. */
typedef NS_ENUM(NSInteger, AgoraVideoQualityAdaptIndication) {
  /** The quality of the local video stays the same. */
  AgoraVideoQualityAdaptNone = 0,
  /** The quality improves because the network bandwidth increases. */
  AgoraVideoQualityAdaptUpBandwidth = 1,
  /** The quality worsens because the network bandwidth decreases. */
  AgoraVideoQualityAdaptDownBandwidth = 2,
};

/** Video display mode. */
typedef NS_ENUM(NSUInteger, AgoraVideoRenderMode) {
  /** Hidden(1): Uniformly scale the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents. */
  AgoraVideoRenderModeHidden = 1,

  /** Fit(2): Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio are filled with black. */
  AgoraVideoRenderModeFit = 2,

  /** Adaptive(3)：This mode is deprecated. */
  AgoraVideoRenderModeAdaptive __deprecated_enum_msg("AgoraVideoRenderModeAdaptive is deprecated.") = 3,

  /** Fill(4): The fill mode. In this mode, the SDK stretches or zooms the video to fill the display window. */
  AgoraVideoRenderModeFill = 4,
};

/** Self-defined video codec profile. */
typedef NS_ENUM(NSInteger, AgoraVideoCodecProfileType) {
  /** 66: Baseline video codec profile. Generally used in video calls on mobile phones. */
  AgoraVideoCodecProfileTypeBaseLine = 66,
  /** 77: Main video codec profile. Generally used in mainstream electronics, such as MP4 players, portable video players, PSP, and iPads. */
  AgoraVideoCodecProfileTypeMain = 77,
  /** 100: (Default) High video codec profile. Generally used in high-resolution interactive live streaming or television. */
  AgoraVideoCodecProfileTypeHigh = 100
};

/** The video codec type. (iOS only) */
typedef NS_ENUM(NSInteger, AgoraVideoCodecType) {
  /** 1: VP8 */
  AgoraVideoCodecTypeVP8 = 1,
  /** 2: (Default) H.264 */
  AgoraVideoCodecTypeH264 = 2,
  /** 3: Enhanced VP8 */
  AgoraVideoCodecTypeEVP = 3,
  /** 4: Enhanced H.264 */
  AgoraVideoCodecTypeE264 = 4,
};

/** The video codec type of the output video stream.

 @since v3.2.0
 */
typedef NS_ENUM(NSInteger, AgoraVideoCodecTypeForStream) {
  /** 1: (Default) H.264 */
  AgoraVideoCodecTypeH264ForStream = 1,
  /** 2: H.265 */
  AgoraVideoCodecTypeH265ForStream = 2,
};

/** Video mirror mode. */
typedef NS_ENUM(NSUInteger, AgoraVideoMirrorMode) {
  /** 0: (Default) The SDK determines the mirror mode.
   */
  AgoraVideoMirrorModeAuto = 0,
  /** 1: Enables mirror mode. */
  AgoraVideoMirrorModeEnabled = 1,
  /** 2: Disables mirror mode. */
  AgoraVideoMirrorModeDisabled = 2,
};

/** The publishing state */
typedef NS_ENUM(NSUInteger, AgoraStreamPublishState) {
  /** 0: The initial publishing state after joining the channel.
   */
  AgoraStreamPublishIdle = 0,
  /** 1: Fails to publish the local stream. Possible reasons:
   <li>The local user calls [muteLocalAudioStream(YES)]([AgoraRtcEngineKit muteLocalAudioStream:]) or [muteLocalVideoStream(YES)]([AgoraRtcEngineKit muteLocalVideoStream:]) to stop sending local streams.</li>
   <li>The local user calls [disableAudio]([AgoraRtcEngineKit disableAudio]) or [disableVideo]([AgoraRtcEngineKit disableVideo]) to disable the entire audio or video module.</li>
   <li>The local user calls [enableLocalAudio(NO)]([AgoraRtcEngineKit  enableLocalAudio:]) or [enableLocalVideo(NO)]([AgoraRtcEngineKit  enableLocalVideo:]) to disable the local audio sampling or video capturing.</li>
   <li>The role of the local user is <tt>AgoraClientRoleAudience</tt>.</li>
   */
  AgoraStreamPublishNoPublished = 1,
  /** 2: Publishing.
   */
  AgoraStreamPublishPublishing = 2,
  /** 3: Publishes successfully.
   */
  AgoraStreamPublishPublished = 3,
};

/** The subscribing state. */
typedef NS_ENUM(NSUInteger, AgoraStreamSubscribeState) {
  /** 0: The initial subscribing state after joining the channel.
   */
  AgoraStreamSubscribeIdle = 0,
  /** 1: Fails to subscribe to the remote stream. Possible reasons:
   <li>The remote user:</li>
   <ul><li>Calls [muteLocalAudioStream(YES)]([AgoraRtcEngineKit muteLocalAudioStream:]) or [muteLocalVideoStream(YES)]([AgoraRtcEngineKit muteLocalVideoStream:]) to stop sending local streams.</li></ul>
   <ul><li>The local user calls [disableAudio]([AgoraRtcEngineKit disableAudio]) or [disableVideo]([AgoraRtcEngineKit disableVideo]) to disable the entire audio or video module.</li></ul>
   <ul><li>The local user calls [enableLocalAudio(NO)]([AgoraRtcEngineKit enableLocalAudio:]) or [enableLocalVideo(NO)]([AgoraRtcEngineKit enableLocalVideo:]) to disable the local audio sampling or video capturing.</li></ul>
   <ul><li>The role of the local user is <tt>AgoraClientRoleAudience</tt>.</li></ul>
   <li>The local user calls the following methods to stop receiving remote streams:</li>
   <ul><li>Calls [muteRemoteAudioStream(YES)]([AgoraRtcEngineKit muteRemoteAudioStream:mute:]), [muteAllRemoteAudioStreams(YES)]([AgoraRtcEngineKit muteAllRemoteAudioStreams:]), or [setDefaultMuteAllRemoteAudioStreams(YES)]([AgoraRtcEngineKit setDefaultMuteAllRemoteAudioStreams:]) to stop receiving remote audio streams.</li></ul>
   <ul><li></li>Calls [muteRemoteVideoStream(YES)]([AgoraRtcEngineKit muteRemoteVideoStream:mute:]), [muteAllRemoteVideoStreams(YES)]([AgoraRtcEngineKit muteAllRemoteVideoStreams:]), or [setDefaultMuteAllRemoteVideoStreams(YES)]([AgoraRtcEngineKit setDefaultMuteAllRemoteVideoStreams:]) to stop receiving remote video streams.</ul>
   */
  AgoraStreamSubscribeNoSubscribed = 1,
  /** 2: Subscribing.
   */
  AgoraStreamSubscribeSubscribing = 2,
  /** 3: Subscribes to and receives the remote stream successfully.
   */
  AgoraStreamSubscribeSubscribed = 3,
};

/** The content hint for screen sharing. */
typedef NS_ENUM(NSUInteger, AgoraVideoContentHint) {
  /** 0: (Default) No content hint. */
  AgoraVideoContentHintNone = 0,
  /** 1: Motion-intensive content. Choose this option if you prefer smoothness or when you are sharing a video clip, movie, or video game. */
  AgoraVideoContentHintMotion = 1,
  /** 2: Motionless content. Choose this option if you prefer sharpness or when you are sharing a picture, PowerPoint slide, or text. */
  AgoraVideoContentHintDetails = 2,
};

/** The state of the remote video. */
typedef NS_ENUM(NSUInteger, AgoraVideoRemoteState) {
  /** 0: The remote video is in the default state, probably due to `AgoraVideoRemoteStateReasonLocalMuted(3)`, `AgoraVideoRemoteStateReasonRemoteMuted(5)`, or `AgoraVideoRemoteStateReasonRemoteOffline(7)`.
   */
  AgoraVideoRemoteStateStopped = 0,
  /** 1: The first remote video packet is received.
   */
  AgoraVideoRemoteStateStarting = 1,
  /** 2: The remote video stream is decoded and plays normally, probably due to `AgoraVideoRemoteStateReasonNetworkRecovery(2)`, `AgoraVideoRemoteStateReasonLocalUnmuted(4)`, `AgoraVideoRemoteStateReasonRemoteUnmuted(6)`, or `AgoraVideoRemoteStateReasonAudioFallbackRecovery(9)`.
   */
  AgoraVideoRemoteStateDecoding = 2,
  /** 3: The remote video is frozen, probably due to `AgoraVideoRemoteStateReasonNetworkCongestion(1)` or `AgoraVideoRemoteStateReasonAudioFallback(8)`.
   */
  AgoraVideoRemoteStateFrozen = 3,
  /** 4: The remote video fails to start, probably due to `AgoraVideoRemoteStateReasonInternal(0)`.
   */
  AgoraVideoRemoteStateFailed = 4,
};

/** The reason for the remote video state change. */
typedef NS_ENUM(NSUInteger, AgoraVideoRemoteStateReason) {
  /** 0: The SDK reports this reason when the video state changes. */
  AgoraVideoRemoteStateReasonInternal = 0,
  /** 1: Network congestion. */
  AgoraVideoRemoteStateReasonNetworkCongestion = 1,
  /** 2: Network recovery. */
  AgoraVideoRemoteStateReasonNetworkRecovery = 2,
  /** 3: The local user stops receiving the remote video stream or disables the video module. */
  AgoraVideoRemoteStateReasonLocalMuted = 3,
  /** 4: The local user resumes receiving the remote video stream or enables the video module. */
  AgoraVideoRemoteStateReasonLocalUnmuted = 4,
  /** 5: The remote user stops sending the video stream or disables the video module. */
  AgoraVideoRemoteStateReasonRemoteMuted = 5,
  /** 6: The remote user resumes sending the video stream or enables the video module. */
  AgoraVideoRemoteStateReasonRemoteUnmuted = 6,
  /** 7: The remote user leaves the channel. */
  AgoraVideoRemoteStateReasonRemoteOffline = 7,
  /** 8: The remote audio-and-video stream falls back to the audio-only stream due to poor network conditions. */
  AgoraVideoRemoteStateReasonAudioFallback = 8,
  /** 9: The remote audio-only stream switches back to the audio-and-video stream after the network conditions improve. */
  AgoraVideoRemoteStateReasonAudioFallbackRecovery = 9,
};

/** The reason why super resolution is not successfully enabled or the message
 that confirms success.

 @since v3.5.1
 */
typedef NS_ENUM(NSUInteger, AgoraSuperResolutionStateReason) {
  /** 0: Super resolution is successfully enabled. */
  AgoraSRStateReasonSuccess = 0,
  /** 1: The original resolution of the remote video is beyond the range where
   super resolution can be applied.
   */
  AgoraSRStateReasonStreamOverLimitation = 1,
  /** 2: Super resolution is already being used to boost another remote user's video. */
  AgoraSRStateReasonUserCountOverLimitation = 2,
  /** 3: The device does not support using super resolution. */
  AgoraSRStateReasonDeviceNotSupported = 3,
};

/** The reason why the virtual background is not successfully enabled or the
 message that confirms success.
 @since v3.4.5
 */
typedef NS_ENUM(NSUInteger, AgoraVirtualBackgroundSourceStateReason) {
  /** 0: The virtual background is successfully enabled.*/
  AgoraVBSStateReasonSuccess = 0,
  /** 1: The custom background image does not exist. Please check the value of
  `source` in AgoraVirtualBackgroundSource.
   */
  AgoraVBSStateReasonImageNotExist = 1,
  /** 2: The color format of the custom background image is invalid. Please
   check the value of `color` in AgoraVirtualBackgroundSource.
   */
  AgoraVBSStateReasonColorFormatNotSupported = 2,
  /** 3: The device does not support using the virtual background.*/
  AgoraVBSStateReasonDeviceNotSupported = 3,
};

/** Stream fallback option. */
typedef NS_ENUM(NSInteger, AgoraStreamFallbackOptions) {
  /** No fallback behavior for the local/remote video stream when the uplink/downlink network condition is unreliable. The quality of the stream is not guaranteed. */
  AgoraStreamFallbackOptionDisabled = 0,
  /** Under unreliable downlink network conditions, the remote video stream falls back to the low-stream (low resolution and low bitrate) video. You can only set this option in the [setRemoteSubscribeFallbackOption]([AgoraRtcEngineKit setRemoteSubscribeFallbackOption:]) method. Nothing happens when you set this in the [setLocalPublishFallbackOption]([AgoraRtcEngineKit setLocalPublishFallbackOption:]) method. */
  AgoraStreamFallbackOptionVideoStreamLow = 1,
  /** Under unreliable uplink network conditions, the published video stream falls back to audio only. Under unreliable downlink network conditions, the remote video stream first falls back to the low-stream (low resolution and low bitrate) video; and then to an audio-only stream if the network condition deteriorates. */
  AgoraStreamFallbackOptionAudioOnly = 2,
};

/** Audio sample rate. */
typedef NS_ENUM(NSInteger, AgoraAudioSampleRateType) {
  /** 32 kHz. */
  AgoraAudioSampleRateType32000 = 32000,
  /** 44.1 kHz. */
  AgoraAudioSampleRateType44100 = 44100,
  /** 48 kHz. */
  AgoraAudioSampleRateType48000 = 48000,
};

/** Audio profile. */
typedef NS_ENUM(NSInteger, AgoraAudioProfile) {
  /** 0: Default audio profile.
   <li>In the Communication profile: A sample rate of 32 KHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
   <li>In the interactive live streaming profile: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 64 Kbps.</li> */
  AgoraAudioProfileDefault = 0,
  /** 1: A sample rate of 32 KHz, audio encoding, mono, and a bitrate of up to 18 Kbps. */
  AgoraAudioProfileSpeechStandard = 1,
  /** 2: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 64 Kbps. */
  AgoraAudioProfileMusicStandard = 2,
  /** 3: A sample rate of 48 KHz, music encoding, stereo, and a bitrate of up to 80 Kbps. */
  AgoraAudioProfileMusicStandardStereo = 3,
  /** 4: A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 96 Kbps. */
  AgoraAudioProfileMusicHighQuality = 4,
  /** 5: A sample rate of 48 KHz, music encoding, stereo, and a bitrate of up to 128 Kbps. */
  AgoraAudioProfileMusicHighQualityStereo = 5,
};

/** Audio scenario. */
typedef NS_ENUM(NSInteger, AgoraAudioScenario) {
  /** 0: Default audio scenario.
   <p><b>Note</b>: If you run the iOS app on an M1 Mac, due to the hardware
   differences between M1 Macs, iPhones, and iPads, the default audio scenario
   of the Agora iOS SDK is the same as that of the Agora macOS SDK.</p>
   */
  AgoraAudioScenarioDefault = 0,
  /** 1: Entertainment scenario where users need to frequently switch the user role. */
  AgoraAudioScenarioChatRoomEntertainment = 1,
  /** 2: Education scenario where users want smoothness and stability. */
  AgoraAudioScenarioEducation = 2,
  /** 3: High-quality audio chatroom scenario where hosts mainly play music.*/
  AgoraAudioScenarioGameStreaming = 3,
  /** 4: Showroom scenario where a single host wants high-quality audio. */
  AgoraAudioScenarioShowRoom = 4,
  /** 5: Gaming scenario for group chat that only contains the human voice. */
  AgoraAudioScenarioChatRoomGaming = 5,
  /** 6: IoT (Internet of Things) scenario where users use IoT devices with low power consumption. */
  AgoraAudioScenarioIot = 6,
  /** Communication scenario.*/
  AgoraAudioScenarioCommunication = 7,
  /** 8: Meeting scenario that mainly contains the human voice.

   @since v3.2.0
   */
  AgoraAudioScenarioMeeting = 8,
};

/** The current audio route. Reports in the [didAudioRouteChanged]([AgoraRtcEngineDelegate rtcEngine:didAudioRouteChanged:]) callback. */
typedef NS_ENUM(NSInteger, AgoraAudioOutputRouting) {
  /** -1: Default audio route. */
  AgoraAudioOutputRoutingDefault = -1,
  /** 0: The audio route is a headset with a microphone.*/
  AgoraAudioOutputRoutingHeadset = 0,
  /** 1: The audio route is an earpiece. */
  AgoraAudioOutputRoutingEarpiece = 1,
  /** 2: The audio route is a headset without a microphone. */
  AgoraAudioOutputRoutingHeadsetNoMic = 2,
  /** 3: The audio route is the speaker that comes with the device. */
  AgoraAudioOutputRoutingSpeakerphone = 3,
  /** 4: The audio route is a Bluetooth headset. */
  AgoraAudioOutputRoutingLoudspeaker = 4,
  /** 5: Bluetooth headset. */
  AgoraAudioOutputRoutingHeadsetBluetooth = 5,
  /** 6: (macOS only) The audio route is a USB peripheral device. */
  AgoraAudioOutputRoutingUsb = 6,
  /** 7: (macOS only) The audio route is an HDMI peripheral device. */
  AgoraAudioOutputRoutingHdmi = 7,
  /** 8: (macOS only) The audio route is a DisplayPort peripheral device. */
  AgoraAudioOutputRoutingDisplayPort = 8,
  /** 9: The audio route is Apple AirPlay. */
  AgoraAudioOutputRoutingAirPlay = 9
};

/** The use mode of the audio data. */
typedef NS_ENUM(NSInteger, AgoraAudioRawFrameOperationMode) {
  /** 0: (Default) Read-only mode, in which users can only read the
   AgoraAudioFrame without modifying anything. For example, this mode
   applies when users acquire data with the Agora SDK and then push the
   RTMP or RTMPS streams.
   */
  AgoraAudioRawFrameOperationModeReadOnly = 0,
  /** 1: Write-only mode, in which users replace the AgoraAudioFrame with their
   own data and then pass it to the SDK for encoding. For example, this mode
   applies when users need the Agora SDK to encode and transmit their custom
   audio data.
   */
  AgoraAudioRawFrameOperationModeWriteOnly = 1,
  /** 2: Read and write mode, in which users read the AgoraAudioFrame,
   modify it, and then play it. For example, this mode applies when users
   have their own sound-effect processing module to pre-process the audio
   (such as a voice changer).
   */
  AgoraAudioRawFrameOperationModeReadWrite = 2,
};

/** Audio equalization band frequency. */
typedef NS_ENUM(NSInteger, AgoraAudioEqualizationBandFrequency) {
  /** 31 Hz. */
  AgoraAudioEqualizationBand31 = 0,
  /** 62 Hz. */
  AgoraAudioEqualizationBand62 = 1,
  /** 125 Hz. */
  AgoraAudioEqualizationBand125 = 2,
  /** 250 Hz. */
  AgoraAudioEqualizationBand250 = 3,
  /** 500 Hz */
  AgoraAudioEqualizationBand500 = 4,
  /** 1 kHz. */
  AgoraAudioEqualizationBand1K = 5,
  /** 2 kHz. */
  AgoraAudioEqualizationBand2K = 6,
  /** 4 kHz. */
  AgoraAudioEqualizationBand4K = 7,
  /** 8 kHz. */
  AgoraAudioEqualizationBand8K = 8,
  /** 16 kHz. */
  AgoraAudioEqualizationBand16K = 9,
};

/** Audio reverberation type. */
typedef NS_ENUM(NSInteger, AgoraAudioReverbType) {
  /** The level of the dry signal (dB). The value ranges between -20 and 10. */
  AgoraAudioReverbDryLevel = 0,
  /** The level of the early reflection signal (wet signal) in dB. The value ranges between -20 and 10. */
  AgoraAudioReverbWetLevel = 1,
  /** The room size of the reverberation. A larger room size means a stronger reverberation. The value ranges between 0 and 100. */
  AgoraAudioReverbRoomSize = 2,
  /** The length of the initial delay of the wet signal (ms). The value ranges between 0 and 200. */
  AgoraAudioReverbWetDelay = 3,
  /** The reverberation strength. The value ranges between 0 and 100. */
  AgoraAudioReverbStrength = 4,
};

/** **DEPRECATED** from v3.2.0. The preset audio voice configuration used to change the voice effect. */
typedef NS_ENUM(NSInteger, AgoraAudioVoiceChanger) {
  /** Turn off the local voice changer, that is, to use the original voice. */
  AgoraAudioVoiceChangerOff __deprecated_enum_msg("AgoraAudioVoiceChangerOff is deprecated.") = 0x00000000,
  /** The voice of an old man. */
  AgoraAudioVoiceChangerOldMan __deprecated_enum_msg("AgoraAudioVoiceChangerOldMan is deprecated.") = 0x00000001,
  /** The voice of a little boy. */
  AgoraAudioVoiceChangerBabyBoy __deprecated_enum_msg("AgoraAudioVoiceChangerBabyBoy is deprecated.") = 0x00000002,
  /** The voice of a little girl. */
  AgoraAudioVoiceChangerBabyGirl __deprecated_enum_msg("AgoraAudioVoiceChangerBabyGirl is deprecated.") = 0x00000003,
  /** The voice of Zhu Bajie, a character in Journey to the West who has a voice like that of a growling bear. */
  AgoraAudioVoiceChangerZhuBaJie __deprecated_enum_msg("AgoraAudioVoiceChangerZhuBaJie is deprecated.") = 0x00000004,
  /** The ethereal voice. */
  AgoraAudioVoiceChangerEthereal __deprecated_enum_msg("AgoraAudioVoiceChangerEthereal is deprecated.") = 0x00000005,
  /** The voice of Hulk. */
  AgoraAudioVoiceChangerHulk __deprecated_enum_msg("AgoraAudioVoiceChangerHulk is deprecated.") = 0x00000006,
  /** A more vigorous voice. */
  AgoraAudioVoiceBeautyVigorous __deprecated_enum_msg("AgoraAudioVoiceBeautyVigorous is deprecated.") = 0x00100001,
  /** A deeper voice. */
  AgoraAudioVoiceBeautyDeep __deprecated_enum_msg("AgoraAudioVoiceBeautyDeep is deprecated.") = 0x00100002,
  /** A mellower voice. */
  AgoraAudioVoiceBeautyMellow __deprecated_enum_msg("AgoraAudioVoiceBeautyMellow is deprecated.") = 0x00100003,
  /** Falsetto. */
  AgoraAudioVoiceBeautyFalsetto __deprecated_enum_msg("AgoraAudioVoiceBeautyFalsetto is deprecated.") = 0x00100004,
  /** A fuller voice. */
  AgoraAudioVoiceBeautyFull __deprecated_enum_msg("AgoraAudioVoiceBeautyFull is deprecated.") = 0x00100005,
  /** A clearer voice. */
  AgoraAudioVoiceBeautyClear __deprecated_enum_msg("AgoraAudioVoiceBeautyClear is deprecated.") = 0x00100006,
  /** A more resounding voice. */
  AgoraAudioVoiceBeautyResounding __deprecated_enum_msg("AgoraAudioVoiceBeautyResounding is deprecated.") = 0x00100007,
  /** A more ringing voice. */
  AgoraAudioVoiceBeautyRinging __deprecated_enum_msg("AgoraAudioVoiceBeautyRinging is deprecated.") = 0x00100008,
  /** A more spatially resonant voice. */
  AgoraAudioVoiceBeautySpacial __deprecated_enum_msg("AgoraAudioVoiceBeautySpacial is deprecated.") = 0x00100009,
  /** (For male only) A more magnetic voice. Do not use it when the speaker is a female; otherwise, voice distortion occurs. */
  AgoraAudioGeneralBeautyVoiceMaleMagnetic __deprecated_enum_msg("AgoraAudioGeneralBeautyVoiceMaleMagnetic is deprecated.") = 0x00200001,
  /** (For female only) A fresher voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs. */
  AgoraAudioGeneralBeautyVoiceFemaleFresh __deprecated_enum_msg("AgoraAudioGeneralBeautyVoiceFemaleFresh is deprecated.") = 0x00200002,
  /** (For female only) A more vital voice. Do not use it when the speaker is a male; otherwise, voice distortion occurs. */
  AgoraAudioGeneralBeautyVoiceFemaleVitality __deprecated_enum_msg("AgoraAudioGeneralBeautyVoiceFemaleVitality is deprecated.") = 0x00200003,
};

/** **DEPRECATED** from v3.2.0. The preset local voice reverberation option. */
typedef NS_ENUM(NSInteger, AgoraAudioReverbPreset) {
  /** Turn off local voice reverberation, that is, to use the original voice. */
  AgoraAudioReverbPresetOff __deprecated_enum_msg("AgoraAudioReverbPresetOff is deprecated.") = 0x00000000,
  /** The reverberation style typical of a KTV venue (enhanced).  */
  AgoraAudioReverbPresetFxKTV __deprecated_enum_msg("AgoraAudioReverbPresetFxKTV is deprecated.") = 0x00100001,
  /** The reverberation style typical of a concert hall (enhanced). */
  AgoraAudioReverbPresetFxVocalConcert __deprecated_enum_msg("AgoraAudioReverbPresetFxVocalConcert is deprecated.") = 0x00100002,
  /** The reverberation style typical of an uncle's voice. */
  AgoraAudioReverbPresetFxUncle __deprecated_enum_msg("AgoraAudioReverbPresetFxUncle is deprecated.") = 0x00100003,
  /** The reverberation style typical of a sister's voice. */
  AgoraAudioReverbPresetFxSister __deprecated_enum_msg("AgoraAudioReverbPresetFxSister is deprecated.") = 0x00100004,
  /** The reverberation style typical of a recording studio (enhanced).  */
  AgoraAudioReverbPresetFxStudio __deprecated_enum_msg("AgoraAudioReverbPresetFxStudio is deprecated.") = 0x00100005,
  /** The reverberation style typical of popular music (enhanced). */
  AgoraAudioReverbPresetFxPopular __deprecated_enum_msg("AgoraAudioReverbPresetFxPopular is deprecated.") = 0x00100006,
  /** The reverberation style typical of R&B music (enhanced). */
  AgoraAudioReverbPresetFxRNB __deprecated_enum_msg("AgoraAudioReverbPresetFxRNB is deprecated.") = 0x00100007,
  /** The reverberation style typical of the vintage phonograph. */
  AgoraAudioReverbPresetFxPhonograph __deprecated_enum_msg("AgoraAudioReverbPresetFxPhonograph is deprecated.") = 0x00100008,
  /** The reverberation style typical of popular music. */
  AgoraAudioReverbPresetPopular __deprecated_enum_msg("AgoraAudioReverbPresetPopular is deprecated.") = 0x00000001,
  /** The reverberation style typical of R&B music. */
  AgoraAudioReverbPresetRnB __deprecated_enum_msg("AgoraAudioReverbPresetRnB is deprecated.") = 0x00000002,
  /** The reverberation style typical of rock music. */
  AgoraAudioReverbPresetRock __deprecated_enum_msg("AgoraAudioReverbPresetRock is deprecated.") = 0x00000003,
  /** The reverberation style typical of hip-hop music. */
  AgoraAudioReverbPresetHipHop __deprecated_enum_msg("AgoraAudioReverbPresetHipHop is deprecated.") = 0x00000004,
  /** The reverberation style typical of a concert hall. */
  AgoraAudioReverbPresetVocalConcert __deprecated_enum_msg("AgoraAudioReverbPresetVocalConcert is deprecated.") = 0x00000005,
  /** The reverberation style typical of a KTV venue. */
  AgoraAudioReverbPresetKTV __deprecated_enum_msg("AgoraAudioReverbPresetKTV is deprecated.") = 0x00000006,
  /** The reverberation style typical of a recording studio. */
  AgoraAudioReverbPresetStudio __deprecated_enum_msg("AgoraAudioReverbPresetStudio is deprecated.") = 0x00000007,
  /** The reverberation of the virtual stereo. The virtual stereo is an effect that renders the monophonic audio as the stereo audio, so that all users in the channel can hear the stereo voice effect. To achieve better virtual stereo reverberation, Agora recommends setting the `profile` parameter in `setAudioProfile` as `AgoraAudioProfileMusicHighQualityStereo(5)`. */
  AgoraAudioReverbPresetVirtualStereo __deprecated_enum_msg("AgoraAudioReverbPresetVirtualStereo is deprecated.") = 0x00200001,
  /** The reverberation of the Electronic Voice */
  AgoraAudioReverbPresetElectronicVoice __deprecated_enum_msg("AgoraAudioReverbPresetElectronicVoice is deprecated.") = 0x00300001,
  /** 3D Voice */
  AgoraAudioReverbPresetThreeDimVoice __deprecated_enum_msg("AgoraAudioReverbPresetThreeDimVoice is deprecated.") = 0x00400001

};

/** The options for SDK preset voice beautifier effects. */
typedef NS_ENUM(NSInteger, AgoraVoiceBeautifierPreset) {
  /** Turn off voice beautifier effects and use the original voice. */
  AgoraVoiceBeautifierOff = 0x00000000,
  /** A more magnetic voice.<p>**Note**</p><p>Agora recommends using this enumerator to process a male-sounding voice; otherwise, you
   may experience vocal distortion.</p>
   */
  AgoraChatBeautifierMagnetic = 0x01010100,
  /** A fresher voice.<p>**Note**</p><p>Agora recommends using this enumerator to process a female-sounding voice; otherwise, you
   may experience vocal distortion.</p>
   */
  AgoraChatBeautifierFresh = 0x01010200,
  /** A more vital voice.<p>**Note**</p><p>Agora recommends using this enumerator to process a female-sounding voice; otherwise, you
   may experience vocal distortion.</p>
   */
  AgoraChatBeautifierVitality = 0x01010300,
  /** Singing beautifier effect.
   <li>If you call [setVoiceBeautifierPreset(AgoraSingingBeautifier)]([AgoraRtcEngineKit setVoiceBeautifierPreset:]),
   you can beautify a male-sounding voice and add a reverberation effect that
   sounds like singing in a small room. Agora recommends not using
   <tt>setVoiceBeautifierPreset(AgoraSingingBeautifier)</tt> to process a
   female-sounding voice; otherwise, you may experience vocal distortion.</li>
   <li>If you call [setVoiceBeautifierParameters(AgoraSingingBeautifier, param1, param2)]([AgoraRtcEngineKit setVoiceBeautifierParameters:param1:param2:]),
   you can beautify a male- or female-sounding voice and add a reverberation
   effect.</li>

   @since v3.3.0
   */
  AgoraSingingBeautifier = 0x01020100,
  /** A more vigorous voice. */
  AgoraTimbreTransformationVigorous = 0x01030100,
  /** A deeper voice. */
  AgoraTimbreTransformationDeep = 0x01030200,
  /** A mellower voice. */
  AgoraTimbreTransformationMellow = 0x01030300,
  /** A falsetto voice. */
  AgoraTimbreTransformationFalsetto = 0x01030400,
  /** A fuller voice. */
  AgoraTimbreTransformationFull = 0x01030500,
  /** A clearer voice. */
  AgoraTimbreTransformationClear = 0x01030600,
  /** A more resounding voice. */
  AgoraTimbreTransformationResounding = 0x01030700,
  /** A more ringing voice. */
  AgoraTimbreTransformationRinging = 0x01030800
};

/** The options for SDK preset audio effects. */
typedef NS_ENUM(NSInteger, AgoraAudioEffectPreset) {
  /** Turn off audio effects and use the original voice. */
  AgoraAudioEffectOff = 0x00000000,
  /** An audio effect typical of a KTV venue.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraRoomAcousticsKTV = 0x02010100,
  /** An audio effect typical of a concert hall.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraRoomAcousticsVocalConcert = 0x02010200,
  /** An audio effect typical of a recording studio.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraRoomAcousticsStudio = 0x02010300,
  /** An audio effect typical of a vintage phonograph.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraRoomAcousticsPhonograph = 0x02010400,
  /** A virtual stereo effect that renders monophonic audio as stereo audio.
   <p>**Note**</p>
   <p>Call [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) and set the `profile` parameter to
   `AgoraAudioProfileMusicStandardStereo(3)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator;
   otherwise, the enumerator setting does not take effect.</p>
   */
  AgoraRoomAcousticsVirtualStereo = 0x02010500,
  /** A more spatial audio effect.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraRoomAcousticsSpacial = 0x02010600,
  /** A more ethereal audio effect.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraRoomAcousticsEthereal = 0x02010700,
  /** A 3D voice effect that makes the voice appear to be moving around the user. The default cycle period of the 3D voice effect is
   10 seconds. To change the cycle period, call [setAudioEffectParameters]([AgoraRtcEngineKit setAudioEffectParameters:param1:param2:])
   after this method.
   <p>**Note**</p>
   <li>Call [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) and set the `profile` parameter to
   `AgoraAudioProfileMusicStandardStereo(3)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator;
   otherwise, the enumerator setting does not take effect.</li>
   <li>If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.</li>
   */
  AgoraRoomAcoustics3DVoice = 0x02010800,
  /** The voice of a middle-aged man.
   <p>**Note**</p>
   <li>Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice
   effect.</li>
   <li>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</li>
   */
  AgoraVoiceChangerEffectUncle = 0x02020100,
  /** The voice of an old man.
   <p>**Note**</p>
   <li>Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice
   effect.</li>
   <li>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</li>
   */
  AgoraVoiceChangerEffectOldMan = 0x02020200,
  /** The voice of a boy.
   <p>**Note**</p>
   <li>Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may not hear the anticipated voice
   effect.</li>
   <li>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</li>
   */
  AgoraVoiceChangerEffectBoy = 0x02020300,
  /** The voice of a young woman.
   <p>**Note**</p>
   <li>Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice
   effect.</li>
   <li>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</li>
   */
  AgoraVoiceChangerEffectSister = 0x02020400,
  /** The voice of a girl.
   <p>**Note**</p>
   <li>Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may not hear the anticipated voice
   effect.</li>
   <li>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</li>
   */
  AgoraVoiceChangerEffectGirl = 0x02020500,
  /** The voice of Pig King, a character in Journey to the West who has a voice like a growling bear.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraVoiceChangerEffectPigKing = 0x02020600,
  /** The voice of Hulk.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraVoiceChangerEffectHulk = 0x02020700,
  /** An audio effect typical of R&B music.
   <p>**Note**</p>
   <p>Call [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) and set the `profile` parameter to
   `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator;
   otherwise, the enumerator setting does not take effect.</p>
   */
  AgoraStyleTransformationRnB = 0x02030100,
  /** An audio effect typical of popular music.
   <p>**Note**</p>
   <p>Call [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:]) and set the `profile` parameter to
   `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)` before setting this enumerator;
   otherwise, the enumerator setting does not take effect.</p>
   */
  AgoraStyleTransformationPopular = 0x02030200,
  /** A pitch correction effect that corrects the user's pitch based on the pitch of the natural C major scale. To change the basic
   mode and tonic pitch, call [setAudioEffectParameters]([AgoraRtcEngineKit setAudioEffectParameters:param1:param2:]) after this method.
   <p>**Note**</p>
   <p>To achieve better audio effect quality, Agora recommends calling [setAudioProfile]([AgoraRtcEngineKit setAudioProfile:scenario:])
   and setting the `profile` parameter to `AgoraAudioProfileMusicHighQuality(4)` or `AgoraAudioProfileMusicHighQualityStereo(5)`
   before setting this enumerator.</p>
   */
  AgoraPitchCorrection = 0x02040100
};

/** The options for SDK preset voice conversion effects.

 @since v3.3.1
 */
typedef NS_ENUM(NSInteger, AgoraVoiceConversionPreset) {
  /** Turn off voice conversion effects and use the original voice. */
  AgoraVoiceConversionOff = 0x00000000,
  /** A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice. */
  AgoraVoiceChangerNeutral = 0x03010100,
  /** A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice. */
  AgoraVoiceChangerSweet = 0x03010200,
  /** A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice. */
  AgoraVoiceChangerSolid = 0x03010300,
  /** A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice. */
  AgoraVoiceChangerBass = 0x03010400
};

/** The operational permission of the SDK on the audio session. */
typedef NS_OPTIONS(NSUInteger, AgoraAudioSessionOperationRestriction) {
  /** No restriction; the SDK can change the audio session. */
  AgoraAudioSessionOperationRestrictionNone = 0,
  /** The SDK cannot change the audio session category. */
  AgoraAudioSessionOperationRestrictionSetCategory = 1,
  /** The SDK cannot change the audio session category, mode, or categoryOptions. */
  AgoraAudioSessionOperationRestrictionConfigureSession = 1 << 1,
  /** The SDK keeps the audio session active when the user leaves the channel, for example, to play an audio file in the background. */
  AgoraAudioSessionOperationRestrictionDeactivateSession = 1 << 2,
  /** Completely restricts the operational permission of the SDK on the audio session; the SDK cannot change the audio session. */
  AgoraAudioSessionOperationRestrictionAll = 1 << 7
};

/** Audio codec profile. */
typedef NS_ENUM(NSInteger, AgoraAudioCodecProfileType) {
  /** (Default) LC-AAC, the low-complexity audio codec profile. */
  AgoraAudioCodecProfileLCAAC = 0,
  /** HE-AAC, the high-efficiency audio codec profile. */
  AgoraAudioCodecProfileHEAAC = 1
};

/** The state of the remote audio. */
typedef NS_ENUM(NSUInteger, AgoraAudioRemoteState) {
  /** 0: The remote audio is in the default state, probably due to `AgoraAudioRemoteReasonLocalMuted(3)`, `AgoraAudioRemoteReasonRemoteMuted(5)`, or `AgoraAudioRemoteReasonRemoteOffline(7)`. */
  AgoraAudioRemoteStateStopped = 0,
  /** 1: The first remote audio packet is received. */
  AgoraAudioRemoteStateStarting = 1,
  /** 2: The remote audio stream is decoded and plays normally, probably due to `AgoraAudioRemoteReasonNetworkRecovery(2)`, `AgoraAudioRemoteReasonLocalUnmuted(4)`, or `AgoraAudioRemoteReasonRemoteUnmuted(6)`. */
  AgoraAudioRemoteStateDecoding = 2,
  /** 3: The remote audio is frozen, probably due to `AgoraAudioRemoteReasonNetworkCongestion(1)`. */
  AgoraAudioRemoteStateFrozen = 3,
  /** 4: The remote audio fails to start, probably due to `AgoraAudioRemoteReasonInternal(0)`. */
  AgoraAudioRemoteStateFailed = 4,
};

/** The reason of the remote audio state change. */
typedef NS_ENUM(NSUInteger, AgoraAudioRemoteStateReason) {
  /** 0: The SDK reports this reason when the audio state changes. */
  AgoraAudioRemoteReasonInternal = 0,
  /** 1: Network congestion. */
  AgoraAudioRemoteReasonNetworkCongestion = 1,
  /** 2: Network recovery. */
  AgoraAudioRemoteReasonNetworkRecovery = 2,
  /** 3: The local user stops receiving the remote audio stream or disables the audio module. */
  AgoraAudioRemoteReasonLocalMuted = 3,
  /** 4: The local user resumes receiving the remote audio stream or enables the audio module. */
  AgoraAudioRemoteReasonLocalUnmuted = 4,
  /** 5: The remote user stops sending the audio stream or disables the audio module. */
  AgoraAudioRemoteReasonRemoteMuted = 5,
  /** 6: The remote user resumes sending the audio stream or enables the audio module. */
  AgoraAudioRemoteReasonRemoteUnmuted = 6,
  /** 7: The remote user leaves the channel. */
  AgoraAudioRemoteReasonRemoteOffline = 7,
};

/** The state of the local audio. */
typedef NS_ENUM(NSUInteger, AgoraAudioLocalState) {
  /** 0: The local audio is in the initial state. */
  AgoraAudioLocalStateStopped = 0,
  /** 1: The audio sampling device starts successfully.  */
  AgoraAudioLocalStateRecording = 1,
  /** 2: The first audio frame encodes successfully. */
  AgoraAudioLocalStateEncoding = 2,
  /** 3: The local audio fails to start. */
  AgoraAudioLocalStateFailed = 3,
};

/** The error information of the local audio. */
typedef NS_ENUM(NSUInteger, AgoraAudioLocalError) {
  /** 0: The local audio is normal. */
  AgoraAudioLocalErrorOk = 0,
  /** 1: No specified reason for the local audio failure. */
  AgoraAudioLocalErrorFailure = 1,
  /** 2: No permission to use the local audio sampling device. */
  AgoraAudioLocalErrorDeviceNoPermission = 2,
  /** 3: The audio sampling device is in use. */
  AgoraAudioLocalErrorDeviceBusy = 3,
  /** 4: The local audio sampling fails. Check whether the sampling device is working properly. */
  AgoraAudioLocalErrorRecordFailure = 4,
  /** 5: The local audio encoding fails. */
  AgoraAudioLocalErrorEncodeFailure = 5,
};

/** The information acquisition state. This enum is reported in
 [didRequestAudioFileInfo]([AgoraRtcEngineDelegate rtcEngine:didRequestAudioFileInfo:error:]).

 @since v3.5.1
 */
typedef NS_ENUM(NSUInteger, AgoraAudioFileInfoError) {
  /** 0: Successfully get the information of an audio file. */
  AgoraAudioFileInfoErrorOk = 0,
  /** 1: Fail to get the information of an audio file. */
  AgoraAudioFileInfoErrorFailure = 1
};

/** Media device type. */
typedef NS_ENUM(NSInteger, AgoraMediaDeviceType) {
  /** Unknown device. */
  AgoraMediaDeviceTypeAudioUnknown = -1,
  /** Audio playback device. */
  AgoraMediaDeviceTypeAudioPlayout = 0,
  /** Audio sampling device. */
  AgoraMediaDeviceTypeAudioRecording = 1,
  /** Video render device. */
  AgoraMediaDeviceTypeVideoRender = 2,
  /** Video capture device. */
  AgoraMediaDeviceTypeVideoCapture = 3,
};

/** Connection states. */
typedef NS_ENUM(NSInteger, AgoraConnectionStateType) {
  /** <p>1: The SDK is disconnected from Agora's edge server.</p>
<li>This is the initial state before [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).
<li>The SDK also enters this state when the app calls [leaveChannel]([AgoraRtcEngineKit leaveChannel:]).
  */
  AgoraConnectionStateDisconnected = 1,
  /** <p>2: The SDK is connecting to Agora's edge server.
<p>When the app calls [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]), the SDK starts to establish a connection to the specified channel, triggers the [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) callback, and switches to the `AgoraConnectionStateConnecting` state.
<p>When the SDK successfully joins the channel, the SDK triggers the [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) callback and switches to the `AgoraConnectionStateConnected` state.
<p>After the SDK joins the channel and when it finishes initializing the media engine, the SDK triggers the [didJoinChannel]([AgoraRtcEngineDelegate rtcEngine:didJoinChannel:withUid:elapsed:]) callback.
*/
  AgoraConnectionStateConnecting = 2,
  /** <p>3: The SDK is connected to Agora's edge server and joins a channel. You can now publish or subscribe to a media stream in the channel.</p>
If the connection to the channel is lost because, for example, the network is down or switched, the SDK automatically tries to reconnect and triggers:
<li> The [rtcEngineConnectionDidInterrupted]([AgoraRtcEngineDelegate rtcEngineConnectionDidInterrupted:])(deprecated) callback
<li> The [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) callback, and switches to the `AgoraConnectionStateReconnecting` state.
  */
  AgoraConnectionStateConnected = 3,
  /** <p>4: The SDK keeps rejoining the channel after being disconnected from a joined channel because of network issues.</p>
<li>If the SDK cannot rejoin the channel within 10 seconds after being disconnected from Agora's edge server, the SDK triggers the [rtcEngineConnectionDidLost]([AgoraRtcEngineDelegate rtcEngineConnectionDidLost:]) callback, stays in the `AgoraConnectionStateReconnecting` state, and keeps rejoining the channel.
<li>If the SDK fails to rejoin the channel 20 minutes after being disconnected from Agora's edge server, the SDK triggers the [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) callback, switches to the `AgoraConnectionStateFailed` state, and stops rejoining the channel.
  */
  AgoraConnectionStateReconnecting = 4,
  /** <p>5: The SDK fails to connect to Agora's edge server or join the channel.</p>
<li>You must call [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) to leave this state, and call [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) again to rejoin the channel.
<li>If the SDK is banned from joining the channel by Agora's edge server (through the RESTful API), the SDK triggers the [rtcEngineConnectionDidBanned]([AgoraRtcEngineDelegate rtcEngineConnectionDidBanned:])(deprecated) and [connectionChangedToState]([AgoraRtcEngineDelegate rtcEngine:connectionChangedToState:reason:]) callbacks.
  */
  AgoraConnectionStateFailed = 5,
};

/** Reasons for the connection state change. */
typedef NS_ENUM(NSUInteger, AgoraConnectionChangedReason) {
  /** 0: The SDK is connecting to Agora's edge server. */
  AgoraConnectionChangedConnecting = 0,
  /** 1: The SDK has joined the channel successfully. */
  AgoraConnectionChangedJoinSuccess = 1,
  /** 2: The connection between the SDK and Agora's edge server is interrupted.  */
  AgoraConnectionChangedInterrupted = 2,
  /** 3: The user is banned by the server. This error occurs when the user is kicked out the channel from the server. */
  AgoraConnectionChangedBannedByServer = 3,
  /** 4: The SDK fails to join the channel for more than 20 minutes and stops reconnecting to the channel. */
  AgoraConnectionChangedJoinFailed = 4,
  /** 5: The SDK has left the channel. */
  AgoraConnectionChangedLeaveChannel = 5,
  /** 6: The specified App ID is invalid. Try to rejoin the channel with a valid App ID. */
  AgoraConnectionChangedInvalidAppId = 6,
  /** 7: The specified channel name is invalid. Try to rejoin the channel with a valid channel name. */
  AgoraConnectionChangedInvalidChannelName = 7,
  /** 8: The generated token is invalid probably due to the following reasons:
<li>The App Certificate for the project is enabled in Console, but you do not use Token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
<li>The uid that you specify in the [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]) method is different from the uid that you pass for generating the token.
   */
  AgoraConnectionChangedInvalidToken = 8,
  /** 9: The token has expired. Generate a new token from your server. */
  AgoraConnectionChangedTokenExpired = 9,
  /** 10: The user is banned by the server. This error usually occurs in the following situations:
<li>When the user is already in the channel, and still calls the method to join the channel, for example, [joinChannelByToken]([AgoraRtcEngineKit joinChannelByToken:channelId:info:uid:joinSuccess:]).</li>
<li>When the user tries to join a channel during a call test ([startEchoTestWithInterval]([AgoraRtcEngineKit startEchoTestWithInterval:successBlock:])). Once you call `startEchoTest`, you need to call [stopEchoTest]([AgoraRtcEngineKit stopEchoTest]) before joining a channel.</li>
   */
  AgoraConnectionChangedRejectedByServer = 10,
  /** 11: The SDK tries to reconnect after setting a proxy server. */
  AgoraConnectionChangedSettingProxyServer = 11,
  /** 12: The token renews. */
  AgoraConnectionChangedRenewToken = 12,
  /** 13: The client IP address has changed, probably due to a change of the network type, IP address, or network port. */
  AgoraConnectionChangedClientIpAddressChanged = 13,
  /** 14: Timeout for the keep-alive of the connection between the SDK and Agora's edge server. The connection state changes to `AgoraConnectionStateReconnecting(4)`. */
  AgoraConnectionChangedKeepAliveTimeout = 14,
  /** 15: */
  AgoraConnectionChangedProxyServerInterrupted = 15,
};

/** The state code in AgoraChannelMediaRelayState.
 */
typedef NS_ENUM(NSInteger, AgoraChannelMediaRelayState) {
  /** 0: The initial state. After you successfully stop the channel media relay by calling
   [stopChannelMediaRelay]([AgoraRtcEngineKit stopChannelMediaRelay]), the
   [channelMediaRelayStateDidChange]([AgoraRtcEngineDelegate rtcEngine:channelMediaRelayStateDidChange:error:]) callback
   returns this state.
   */
  AgoraChannelMediaRelayStateIdle = 0,
  /** 1: The SDK tries to relay the media stream to the destination channel.
   */
  AgoraChannelMediaRelayStateConnecting = 1,
  /** 2: The SDK successfully relays the media stream to the destination channel.
   */
  AgoraChannelMediaRelayStateRunning = 2,
  /** 3: A failure occurs. See the details in `error`.
   */
  AgoraChannelMediaRelayStateFailure = 3,
};

/** The event code in AgoraChannelMediaRelayEvent.
 */
typedef NS_ENUM(NSInteger, AgoraChannelMediaRelayEvent) {
  /** 0: The user disconnects from the server due to poor network connections.
   */
  AgoraChannelMediaRelayEventDisconnect = 0,
  /** 1: The network reconnects.
   */
  AgoraChannelMediaRelayEventConnected = 1,
  /** 2: The user joins the source channel.
   */
  AgoraChannelMediaRelayEventJoinedSourceChannel = 2,
  /** 3: The user joins the destination channel.
   */
  AgoraChannelMediaRelayEventJoinedDestinationChannel = 3,
  /** 4: The SDK starts relaying the media stream to the destination channel.
   */
  AgoraChannelMediaRelayEventSentToDestinationChannel = 4,
  /** 5: The server receives the video stream from the source channel.
   */
  AgoraChannelMediaRelayEventReceivedVideoPacketFromSource = 5,
  /** 6: The server receives the audio stream from the source channel.
   */
  AgoraChannelMediaRelayEventReceivedAudioPacketFromSource = 6,
  /** 7: The destination channel is updated.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannel = 7,
  /** 8: The destination channel update fails due to internal reasons.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannelRefused = 8,
  /** 9: The destination channel does not change, which means that the destination channel fails to be updated.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannelNotChange = 9,
  /** 10: The destination channel name is `nil`.
   */
  AgoraChannelMediaRelayEventUpdateDestinationChannelIsNil = 10,
  /** 11: The video profile is sent to the server.
   */
  AgoraChannelMediaRelayEventVideoProfileUpdate = 11,
  /** 12: The SDK successfully pauses relaying the media stream to destination channels.

   @since v3.5.1
   */
  AgoraChannelMediaRelayEventPauseSendPacketToDestChannelSuccess = 12,
  /** 13: The SDK fails to pause relaying the media stream to destination channels.

   @since v3.5.1
   */
  AgoraChannelMediaRelayEventPauseSendPacketToDestChannelFailed = 13,
  /** 14: The SDK successfully resumes relaying the media stream to destination channels.

   @since v3.5.1
   */
  AgoraChannelMediaRelayEventResumeSendPacketToDestChannelSuccess = 14,
  /** 15: The SDK fails to resume relaying the media stream to destination channels.

   @since v3.5.1
   */
  AgoraChannelMediaRelayEventResumeSendPacketToDestChannelFailed = 15,

};

/** The error code in AgoraChannelMediaRelayError.
 */
typedef NS_ENUM(NSInteger, AgoraChannelMediaRelayError) {
  /** 0: The state is normal.
   */
  AgoraChannelMediaRelayErrorNone = 0,
  /** 1: An error occurs in the server response.
   */
  AgoraChannelMediaRelayErrorServerErrorResponse = 1,
  /** 2: No server response. This error can also occur if your project has not enabled co-host token authentication. Contact support@agora.io to enable the co-host token authentication service before starting a channel media relay.
   */
  AgoraChannelMediaRelayErrorServerNoResponse = 2,
  /** 3: The SDK fails to access the service, probably due to limited resources of the server.
   */
  AgoraChannelMediaRelayErrorNoResourceAvailable = 3,
  /** 4: Fails to send the relay request.
   */
  AgoraChannelMediaRelayErrorFailedJoinSourceChannel = 4,
  /** 5: Fails to accept the relay request.
   */
  AgoraChannelMediaRelayErrorFailedJoinDestinationChannel = 5,
  /** 6: The server fails to receive the media stream.
   */
  AgoraChannelMediaRelayErrorFailedPacketReceivedFromSource = 6,
  /** 7: The server fails to send the media stream.
   */
  AgoraChannelMediaRelayErrorFailedPacketSentToDestination = 7,
  /** 8: The SDK disconnects from the server due to poor network connections. You can call the [leaveChannel]([AgoraRtcEngineKit leaveChannel:]) method to leave the channel.
   */
  AgoraChannelMediaRelayErrorServerConnectionLost = 8,
  /** 9: An internal error occurs in the server.
   */
  AgoraChannelMediaRelayErrorInternalError = 9,
  /** 10: The token of the source channel has expired.
   */
  AgoraChannelMediaRelayErrorSourceTokenExpired = 10,
  /** 11: The token of the destination channel has expired.
   */
  AgoraChannelMediaRelayErrorDestinationTokenExpired = 11,
};

/** Network type. */
typedef NS_ENUM(NSInteger, AgoraNetworkType) {
  /** -1: The network type is unknown. */
  AgoraNetworkTypeUnknown = -1,
  /** 0: The SDK disconnects from the network. */
  AgoraNetworkTypeDisconnected = 0,
  /** 1: The network type is LAN. */
  AgoraNetworkTypeLAN = 1,
  /** 2: The network type is Wi-Fi (including hotspots). */
  AgoraNetworkTypeWIFI = 2,
  /** 3: The network type is mobile 2G. */
  AgoraNetworkTypeMobile2G = 3,
  /** 4: The network type is mobile 3G. */
  AgoraNetworkTypeMobile3G = 4,
  /** 5: The network type is mobile 4G. */
  AgoraNetworkTypeMobile4G = 5,
  /** 6: The network type is mobile 5G.

   @since v3.5.1
   */
  AgoraNetworkTypeMobile5G = 6,
};

/** The video encoding degradation preference under limited bandwidth. */
typedef NS_ENUM(NSInteger, AgoraDegradationPreference) {
  /** (Default) Prefers to reduce the video frame rate while maintaining video quality during video encoding under
   limited bandwidth. This degradation preference is suitable for scenarios where video quality is prioritized.

   @note In the `Communication` channel profile, the resolution of the video sent may change, so remote users need to
   handle this issue. See [videoSizeChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:videoSizeChangedOfUid:size:rotation:]).
   */
  AgoraDegradationMaintainQuality = 0,
  /** Prefers to reduce the video quality while maintaining the video frame rate during video encoding under limited
   bandwidth. This degradation preference is suitable for scenarios where smoothness is prioritized and video quality
   is allowed to be reduced.
   */
  AgoraDegradationMaintainFramerate = 1,
  /** Reduces the video frame rate and video quality simultaneously during video encoding under limited bandwidth.
   `AgoraDegradationBalanced` has a lower reduction than `AgoraDegradationMaintainQuality` and `AgoraDegradationMaintainFramerate`,
   and this preference is suitable for scenarios where both smoothness and video quality are a priority.

   @note The resolution of the video sent may change, so remote users need to handle this issue. See [videoSizeChangedOfUid]([AgoraRtcEngineDelegate rtcEngine:videoSizeChangedOfUid:size:rotation:]).
   */
  AgoraDegradationBalanced = 2,
};
/** The lightening contrast level. */
typedef NS_ENUM(NSUInteger, AgoraLighteningContrastLevel) {
  /** Low contrast level. */
  AgoraLighteningContrastLow = 0,
  /** (Default) Normal contrast level. */
  AgoraLighteningContrastNormal = 1,
  /** High contrast level. */
  AgoraLighteningContrastHigh = 2,
};

/** The type of the custom background image.
 @since v3.4.5
 */
typedef NS_ENUM(NSUInteger, AgoraVirtualBackgroundSourceType) {
  /** 1: (Default) The background image is a solid color.*/
  AgoraVirtualBackgroundColor = 1,
  /** 2: The background image is a file in PNG or JPG format.*/
  AgoraVirtualBackgroundImg = 2,
  /** 3: The background image is blurred.

   @since v3.5.1
   */
  AgoraVirtualBackgroundBlur = 3,
};

/** The degree of blurring applied to the custom background image.
 @since v3.5.1
 */
typedef NS_ENUM(NSUInteger, AgoraBlurDegree) {
  /** 1: The degree of blurring applied to the custom background image is low.
   The user can almost see the background clearly.
   */
  AgoraBlurLow = 1,
  /** 2: The degree of blurring applied to the custom background image is
   medium. It is difficult for the user to recognize details in the background.
   */
  AgoraBlurMedium = 2,
  /** 3: (Default) The degree of blurring applied to the custom background
   image is high. The user can barely see any distinguishing features in the
   background.
   */
  AgoraBlurHigh = 3,
};

/** The state of the probe test result. */
typedef NS_ENUM(NSUInteger, AgoraLastmileProbeResultState) {
  /** 1: The last-mile network probe test is complete. */
  AgoraLastmileProbeResultComplete = 1,
  /** 2: The last-mile network probe test is incomplete and the bandwidth estimation is not available, probably due to limited test resources. */
  AgoraLastmileProbeResultIncompleteNoBwe = 2,
  /** 3: The last-mile network probe test is not carried out, probably due to poor network conditions. */
  AgoraLastmileProbeResultUnavailable = 3,
};

/** The state of the local video stream. */
typedef NS_ENUM(NSInteger, AgoraLocalVideoStreamState) {
  /** 0: The local video is in the initial state. */
  AgoraLocalVideoStreamStateStopped = 0,
  /** 1: The local video capturing device starts successfully. The SDK also reports this state when you share a maximized window by calling [startScreenCaptureByWindowId]([AgoraRtcEngineKit startScreenCaptureByWindowId:rectangle:parameters:]).

   @since v3.1.0
   */
  AgoraLocalVideoStreamStateCapturing = 1,
  /** 2: The first local video frame encodes successfully. */
  AgoraLocalVideoStreamStateEncoding = 2,
  /** 3: The local video fails to start. */
  AgoraLocalVideoStreamStateFailed = 3,
};

/** The detailed error information of the local video. */
typedef NS_ENUM(NSInteger, AgoraLocalVideoStreamError) {
  /** 0: The local video is normal. */
  AgoraLocalVideoStreamErrorOK = 0,
  /** 1: No specified reason for the local video failure. */
  AgoraLocalVideoStreamErrorFailure = 1,
  /** 2: No permission to use the local video device. */
  AgoraLocalVideoStreamErrorDeviceNoPermission = 2,
  /** 3: The local video capturer is in use. */
  AgoraLocalVideoStreamErrorDeviceBusy = 3,
  /** 4: The local video capture fails. Check whether the capturer is working properly. */
  AgoraLocalVideoStreamErrorCaptureFailure = 4,
  /** 5: The local video encoding fails. */
  AgoraLocalVideoStreamErrorEncodeFailure = 5,
  /** 6: (iOS only) The application is in the background.

   @since v3.3.0
   */
  AgoraLocalVideoStreamErrorCaptureInBackGround = 6,
  /** 7: (iOS only) The application is running in Slide Over, Split View, or Picture in Picture mode.

   @since v3.3.0
   */
  AgoraLocalVideoStreamErrorCaptureMultipleForegroundApps = 7,
  /** 8: The SDK cannot find the local video capture device.

   @since v3.4.0
   */
  AgoraLocalVideoStreamErrorCaptureNoDeviceFound = 8,
  /** 9: (macOS only) The external camera currently in use is disconnected
   (such as being unplugged).

   @since v3.5.0
   */
  AgoraLocalVideoStreamErrorCaptureDeviceDisconnected = 9,
  /** 10: (macOS only) The SDK cannot find the video device in the video device list. Check whether the ID of the video device is valid.

   @since v3.5.0
   */
  AgoraLocalVideoStreamErrorCaptureDeviceInvalidId = 10,
  /** 11: (macOS only) The shared window is minimized when you call
   [startScreenCaptureByWindowId]([AgoraRtcEngineKit startScreenCaptureByWindowId:rectangle:parameters:]) to share a window.

   @since v3.1.0
   */
  AgoraLocalVideoStreamErrorScreenCaptureWindowMinimized = 11,
  /** 12: (macOS only) The error code indicates that a window shared by the window ID has been closed, or a full-screen
   window shared by the window ID has exited full-screen mode. After exiting
   full-screen mode, remote users cannot see the shared window. To prevent remote users from seeing a black screen, Agora recommends
   that you immediately stop screen sharing.
   <p>Common scenarios for reporting this error code:</p>
   <li>When the local user closes the shared window, the SDK reports this error code.</li>t
   <li>The local user shows some slides in full-screen mode first, and then shares the windows of the slides. After the user exits full-screen
   mode, the SDK reports this error code.</li>
   <li>The local user watches web video or reads web document in full-screen mode first, and then shares the window of the web video or
   document. After the user exits full-screen mode, the SDK reports this error code.</li>

   @since v3.2.0
   */
  AgoraLocalVideoStreamErrorScreenCaptureWindowClosed = 12,
};
/** Regions for connection
 */
typedef NS_ENUM(NSUInteger, AgoraAreaCode) {
  /** Mainland China
   */
  AgoraAreaCodeCN = 0x00000001,
  /** North America
   */
  AgoraAreaCodeNA = 0x00000002,
  /** Europe
   */
  AgoraAreaCodeEU = 0x00000004,
  /** Asia, excluding Mainland China
   */
  AgoraAreaCodeAS = 0x00000008,
  /** Japan
   */
  AgoraAreaCodeJP = 0x00000010,
  /** India
   */
  AgoraAreaCodeIN = 0x00000020,
  /** (Default) Global
   */
  AgoraAreaCodeGLOB = 0xFFFFFFFF
};

/** The output log level of the SDK
 */
typedef NS_ENUM(NSInteger, AgoraLogLevel) {
  /** Do not output any log.
   */
  AgoraLogLevelNone = 0x0000,
  /** (Default) Output logs of the `AgoraLogLevelFatal`, `AgoraLogLevelError`,
   `AgoraLogLevelWarn` and `AgoraLogLevelInfo` level. We recommend setting
   your log filter as this level.
   */
  AgoraLogLevelInfo = 0x0001,
  /** Output logs of the `AgoraLogLevelFatal`, `AgoraLogLevelError` and
   `AgoraLogLevelWarn` level.
   */
  AgoraLogLevelWarn = 0x0002,
  /** Output logs of the `AgoraLogLevelFatal` and `AgoraLogLevelError` level.
   */
  AgoraLogLevelError = 0x0004,
  /** Output logs of the `AgoraLogLevelFatal` level.
   */
  AgoraLogLevelFatal = 0x0008
};
/** The cloud proxy type.
 */
typedef NS_ENUM(NSUInteger, AgoraCloudProxyType) {
  /** 0: Do not use the cloud proxy.
   */
  AgoraNoneProxy = 0,
  /** 1: The cloud proxy for the UDP protocol.
   */
  AgoraUdpProxy = 1,
  /** 2: Reserved parameter.
   */
  AgoraTcpProxy = 2,
};

/** The channel mode. Set in
 [setAudioMixingDualMonoMode]([AgoraRtcEngineKit setAudioMixingDualMonoMode:]).

 @since v3.5.1
 */
typedef NS_ENUM(NSUInteger, AgoraAudioMixingDualMonoMode) {
  /** 0: Original mode.
   */
  AgoraAudioMixingDualMonoAuto,
  /** 1: Left channel mode. This mode replaces the audio of the right channel
   with the audio of the left channel, which means the user can only hear
   the audio of the left channel.
   */
  AgoraAudioMixingDualMonoL,
  /** 2: Right channel mode. This mode replaces the audio of the left channel
   with the audio of the right channel, which means the user can only hear the
   audio of the right channel.
   */
  AgoraAudioMixingDualMonoR,
  /** 3: Mixed channel mode. This mode mixes the audio of the left channel and
   the right channel, which means the user can hear the audio of the left
   channel and the right channel at the same time.
   */
  AgoraAudioMixingDualMonoMix
};

/**
 The type of the shared target.

 @since v3.5.2
 */
typedef NS_ENUM(NSInteger, AgoraScreenCaptureSourceType) {
  /** -1: Unknown type. */
  AgoraScreenCaptureSourceTypeUnknown = -1,
  /** 0: The shared target is a window. */
  AgoraScreenCaptureSourceTypeWindow = 0,
  /** 1: The shared target is a screen of a particular monitor. */
  AgoraScreenCaptureSourceTypeScreen = 1,
  /** 2: Reserved parameter. */
  AgoraScreenCaptureSourceTypeCustom = 2,
};

/** The clockwise rotation angle of the video frame. (iOS only)

 @since v3.4.5
 */
typedef NS_ENUM(NSInteger, AgoraVideoRotation) {
  /** 0: No rotation */
  AgoraVideoRotationNone = 0,
  /** 1: 90 degrees */
  AgoraVideoRotation90 = 1,
  /** 2: 180 degrees */
  AgoraVideoRotation180 = 2,
  /** 3: 270 degrees */
  AgoraVideoRotation270 = 3,
};

/** The color video format. (iOS only)

 @since v3.4.5
 */
typedef NS_ENUM(NSUInteger, AgoraVideoFrameType) {
  /** 0: (Default) YUV 420
   */
  AgoraVideoFrameTypeYUV420 = 0,  // YUV 420 format
  /** 1: YUV422
   */
  AgoraVideoFrameTypeYUV422 = 1,  // YUV 422 format
  /** 2: RGBA
   */
  AgoraVideoFrameTypeRGBA = 2,  // RGBA format
};

/** The video frame type. (iOS only)

 @since v3.4.5
 */
typedef NS_ENUM(NSUInteger, AgoraVideoEncodeType) {
  /** 0: (Default) A black frame
   */
  AgoraVideoEncodeTypeBlankFrame = 0,
  /** 3: The keyframe
   */
  AgoraVideoEncodeTypeKeyFrame = 3,
  /** 4: The delta frame
   */
  AgoraVideoEncodeTypeDetaFrame = 4,
  /** 5: The B-frame
   */
  AgoraVideoEncodeTypeBFrame = 5,

};

/** The bit mask of the observation positions. (iOS only)

 @since v3.4.5
 */
typedef NS_ENUM(NSUInteger, AgoraVideoFramePosition) {
  /** (Default) The position to observe the video data captured by the local
   camera, which corresponds to the
   [onCaptureVideoFrame]([AgoraVideoDataFrameProtocol onCaptureVideoFrame:])
   callback.
   */
  AgoraVideoFramePositionPostCapture = 1 << 0,
  /** (Default) The position to observe the incoming remote video data,
   which corresponds to the
   [onRenderVideoFrame]([AgoraVideoDataFrameProtocol onRenderVideoFrame:forUid:]) or
   [onRenderVideoFrameEx]([AgoraVideoDataFrameProtocol onRenderVideoFrameEx:forUid:inChannel:])
   callback.
   */
  AgoraVideoFramePositionPreRenderer = 1 << 1,
  /** The position to observe the local pre-encoded video data, which
   corresponds to the
   [onPreEncodeVideoFrame]([AgoraVideoDataFrameProtocol onPreEncodeVideoFrame:])
   callback.
   */
  AgoraVideoFramePositionPreEncoder = 1 << 2,
};

/** The bit mask that controls the audio observation positions. (iOS only)

 @since v3.4.5
 */
typedef NS_ENUM(NSUInteger, AgoraAudioFramePosition) {
  /** The position for observing the playback audio of all remote users after
   mixing, which enables the SDK to trigger the
   [onPlaybackAudioFrame]([AgoraAudioDataFrameProtocol onPlaybackAudioFrame:])
   callback.
   */
  AgoraAudioFramePositionPlayback = 1 << 0,
  /** The position for observing the recorded audio of the local user, which
   enables the SDK to trigger the
   [onRecordAudioFrame]([AgoraAudioDataFrameProtocol onRecordAudioFrame:])
   callback.
   */
  AgoraAudioFramePositionRecord = 1 << 1,
  /** The position for observing the mixed audio of the local user and all
   remote users, which enables the SDK to trigger the
   [onMixedAudioFrame]([AgoraAudioDataFrameProtocol onMixedAudioFrame:])
   callback.
   */
  AgoraAudioFramePositionMixed = 1 << 2,
  /** The position for observing the audio of a single remote user before
   mixing, which enables the SDK to trigger the
   [onPlaybackAudioFrameBeforeMixing]([AgoraAudioDataFrameProtocol onPlaybackAudioFrameBeforeMixing:uid:])
   callback.
   S-54718: add mutiplechannel and beforeMixingEx for audioDataFrameProtocol)
   */
  AgoraAudioFramePositionBeforeMixing = 1 << 3,
};

/** API for future use.
 */
typedef NS_ENUM(NSInteger, AgoraContentInspectType) {
  AgoraContentInspectTypeInvalid = 0,
  AgoraContentInspectTypeModeration = 1,
  AgoraContentInspectTypeSupervise = 2,
};

/** The push position of the external audio frame. Set in
 [pushExternalAudioFrameRawData]([AgoraRtcEngineKit pushExternalAudioFrameRawData:frame:]),
 [pushExternalAudioFrameSampleBuffer]([AgoraRtcEngineKit pushExternalAudioFrameSampleBuffer:sampleBuffer:]),
 or [setExternalAudioSourceVolume]([AgoraRtcEngineKit setExternalAudioSourceVolume:volume:]).

 @since v3.5.1
 */
typedef NS_ENUM(NSUInteger, AgoraAudioExternalSourcePos) {
  /** 0: The position before local playback. If you need to play the external
   audio frame on the local client, set this position.
   */
  AgoraAudioExternalPlayoutSource = 0,
  /** 1: The position after audio capture and before audio pre-processing.
   If you need the audio module of the SDK to process the external audio frame,
   set this position.
   */
  AgoraAudioExternalRecordSourcePreProcess = 1,
  /** 2: The position after audio pre-processing and before audio encoding.
   If you do not need the audio module of the SDK to process the external audio
   frame, set this position.
   */
  AgoraAudioExternalRecordSourcePostProcess = 2,
};
/** API for future use.
 */
typedef NS_ENUM(NSUInteger, AgoraContentInspectResult) {
  AgoraContentInspectNeutral = 1,
  AgoraContentInspectSexy = 2,
  AgoraContentInspectPorn = 3,
};

/**
 The current recording state.

 @since v3.5.2
 */
typedef NS_ENUM(NSInteger, AgoraMediaRecorderState) {
  /** -1: An error occurs during the recording. See `error` for the reason. */
  AgoraMediaRecorderStateError = -1,
  /** 2: The audio and video recording is started. */
  AgoraMediaRecorderStateStarted = 2,
  /** 3: The audio and video recording is stopped. */
  AgoraMediaRecorderStateStopped = 3,
};
/**
 The reason for the state change.

 @since v3.5.2
 */
typedef NS_ENUM(NSInteger, AgoraMediaRecorderErrorCode) {
  /** 0: No error occurs. */
  AgoraMediaRecorderErrorCodeNoError = 0,
  /** 1: The SDK fails to write the recorded data to a file. */
  AgoraMediaRecorderErrorCodeWriteFailed = 1,
  /** 2: The SDK does not detect audio and video streams to be recorded, or audio and video streams are interrupted for more than five seconds during recording. */
  AgoraMediaRecorderErrorCodeNoStream = 2,
  /** 3: The recording duration exceeds the upper limit. */
  AgoraMediaRecorderErrorCodeOverMaxDuration = 3,
  /** 4: The recording configuration changes. */
  AgoraMediaRecorderErrorCodeConfigChange = 4,
  /** 5: The SDK detects audio and video streams from users using versions of the SDK earlier than v3.0.0 in the `Communication` channel profile. */
  AgoraMediaRecorderErrorCustomStreamDetected = 5,
};
/**
 The recording content.

 @since v3.5.2
 */
typedef NS_ENUM(NSInteger, AgoraMediaRecorderStreamType) {
  /** 1: Only audio. */
  AgoraMediaRecorderStreamTypeAudio = 1,
  /** 2: Only video. */
  AgoraMediaRecorderStreamTypeVideo = 2,
  /** 3: (Default) Audio and video. */
  AgoraMediaRecorderStreamTypeBoth = 3,
};
/**
 The format of the recording file.

 @since v3.5.2
 */
typedef NS_ENUM(NSInteger, AgoraMediaRecorderContainerFormat) {
  /** 1: MP4 */
  AgoraMediaRecorderContainerFormatMP4 = 1,
};
