import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';
import 'events.dart';
import 'rtc_channel.dart';

enum _ApiTypeEngine {
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
}

/// RtcEngine is the main class of the Agora SDK.
class RtcEngine with RtcEngineInterface {
  static const MethodChannel _methodChannel = MethodChannel('agora_rtc_engine');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_engine/events');
  static final Stream _stream = _eventChannel.receiveBroadcastStream();
  static StreamSubscription? _subscription;

  /// Exposing methodChannel to other files
  static MethodChannel get methodChannel => _methodChannel;

  static RtcEngine? _engine;

  RtcEngineEventHandler? _handler;

  RtcEngine._();

  static Future<T?> _invokeMethod<T>(String method,
      [Map<String, dynamic>? arguments]) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  /// Retrieves the SDK version.
  ///
  /// Since v3.3.1
  ///
  /// This method returns the string of the version number.
  ///
  /// **Note**
  ///
  /// You can call this method either before or after joining a channel.
  ///
  /// **Returns**
  ///
  /// The version of the current SDK in the string format. For example, 2.3.0.
  static Future<String?> getSdkVersion() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetVersion.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('getSdkVersion');
  }

  /// Retrieves the description of a warning or error code.
  ///
  /// Since v3.3.1
  ///
  /// **Parameter** [code] The warning or error code that the `Warning` or `Error` callback returns.
  ///
  /// **Returns**
  ///
  /// [WarningCode] or [ErrorCode].
  static Future<String?> getErrorDescription(int error) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetErrorDescription.index,
        'params': jsonEncode({'code': error})
      });
    }
    return _invokeMethod('getErrorDescription', {'error': error});
  }

  /// Creates an [RtcEngine] instance.
  ///
  /// Unless otherwise specified, all the methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread.
  ///
  /// **Note**
  /// - You must create an [RtcEngine] instance before calling any other method.
  /// - You can create an [RtcEngine] instance either by calling this method or by calling [RtcEngine.createWithAreaCode]. The difference between [RtcEngine.createWithAreaCode] and this method is that [RtcEngine.createWithAreaCode] enables you to specify the connection area.
  /// - The RTC Flutter SDK supports creating only one [RtcEngine] instance for an app for now.
  ///
  /// **Parameter** [appId] The App ID issued to you by Agora. See How to get the App ID. Only users in apps with the same App ID can join the same channel and communicate with each other. Use an App ID to create only one [RtcEngine] instance. To change your App ID, call destroy to destroy the current [RtcEngine] instance, and after destroy returns 0, call create to create an [RtcEngine] instance with the new App ID.
  ///
  /// **Returns**
  /// - An [RtcEngine] instance if the method call succeeds.
  /// - The error code, if this method call fails:
  ///   - [ErrorCode.InvalidAppId]
  static Future<RtcEngine> create(String appId) {
    return createWithConfig(RtcEngineConfig(appId));
  }

  /// Creates an [RtcEngine] instance.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated since v3.3.1.
  ///
  /// Unless otherwise specified, all the methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread.
  ///
  /// **Note**
  /// - You must create an [RtcEngine] instance before calling any other method.
  /// - You can create an [RtcEngine] instance either by calling this method or by calling [RtcEngine.create]. The difference between [RtcEngine.create] and this method is that this method enables you to specify the connection area.
  /// - The Agora RTC Native SDK supports creating only one [RtcEngine] instance for an app for now.
  ///
  /// **Parameter** [appId] The App ID issued to you by Agora. See How to get the App ID. Only users in apps with the same App ID can join the same channel and communicate with each other. Use an App ID to create only one [RtcEngine] instance. To change your App ID, call destroy to destroy the current [RtcEngine] instance and after destroy returns 0, call create to create an [RtcEngine] instance with the new App ID.
  ///
  /// **Parameter** [areaCode] The area of connection. This advanced feature applies to scenarios that have regional restrictions.
  ///
  /// For details, see [IPAreaCode].
  ///
  /// After specifying the area of connection:
  /// - When the app that integrates the Agora SDK is used within the specified area, it connects to the Agora servers within the specified area under normal circumstances.
  /// - When the app that integrates the Agora SDK is used out of the specified area, it connects to the Agora servers either in the specified area or in the area where the app is located.
  ///
  /// **Returns**
  /// - An [RtcEngine] instance if the method call succeeds.
  /// - The error code, if this method call fails:
  ///   - [ErrorCode.InvalidAppId]
  @deprecated
  static Future<RtcEngine> createWithAreaCode(String appId, AreaCode areaCode) {
    return createWithConfig(RtcEngineConfig(appId, areaCode: areaCode));
  }

  /// Creates an [RtcEngine] instance.
  ///
  /// Since v3.3.1
  ///
  /// Unless otherwise specified, all the methods provided by the [RtcEngine] instance are executed asynchronously. Agora recommends calling these methods in the same thread.
  ///
  /// **Note**
  /// - You must create the [RtcEngine] instance before calling any other method.
  /// - You can create an [RtcEngine] instance either by calling this method or by calling [create]. The difference between [create] and this method is that this method enables you to specify the region for connection.
  /// - The Agora RTC Native SDK supports creating only one [RtcEngine] instance for an app for now.
  ///
  /// **Parameter**[config] Configurations for the [RtcEngine] instance. For details, see [RtcEngineConfig].
  ///
  /// **Returns**
  /// - An [RtcEngine] instance if the method call succeeds.
  /// - The error code, if this method call fails:
  ///   - [ErrorCode.InvalidAppId]
  static Future<RtcEngine> createWithConfig(RtcEngineConfig config) async {
    if (_engine != null) return _engine!;
    if (!kIsWeb && Platform.isWindows) {
      await _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineInitialize.index,
        'params': jsonEncode({'context': config.toJson()})
      });
      await _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetAppType.index,
        'params': jsonEncode({'appType': 4})
      });
    } else {
      await _invokeMethod('create', {'config': config.toJson(), 'appType': 4});
    }
    _engine = RtcEngine._();
    return _engine!;
  }

  @override
  Future<void> destroy() {
    RtcChannel.destroyAll();
    _engine?._handler = null;
    _engine = null;
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineRelease.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('destroy');
  }

  /// Sets the engine event handler.
  ///
  /// After setting the engine event handler, you can listen for engine events and receive the statistics of the corresponding [RtcEngine] instance.
  ///
  /// **Parameter** [handler] The event handler.
  void setEventHandler(RtcEngineEventHandler handler) {
    _engine?._handler = handler;
    _subscription ??= _stream.listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String;
      final data = eventMap['data'];
      _engine?._handler?.process(methodName, data);
    });
  }

  @override
  Future<void> setChannelProfile(ChannelProfile profile) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetChannelProfile.index,
        'params':
            jsonEncode({'profile': ChannelProfileConverter(profile).value()})
      });
    }
    return _invokeMethod('setChannelProfile',
        {'profile': ChannelProfileConverter(profile).value()});
  }

  @override
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetClientRole.index,
        'params': jsonEncode({
          'role': ClientRoleConverter(role).value(),
          'options': options?.toJson()
        })
      });
    }
    return _invokeMethod('setClientRole', {
      'role': ClientRoleConverter(role).value(),
      'options': options?.toJson()
    });
  }

  @override
  Future<void> joinChannel(
      String? token, String channelName, String? optionalInfo, int optionalUid,
      [ChannelMediaOptions? options]) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineJoinChannel.index,
        'params': jsonEncode({
          'token': token,
          'channelId': channelName,
          'info': optionalInfo,
          'uid': optionalUid,
          'options': options?.toJson()
        })
      });
    }
    return _invokeMethod('joinChannel', {
      'token': token,
      'channelName': channelName,
      'optionalInfo': optionalInfo,
      'optionalUid': optionalUid,
      'options': options?.toJson()
    });
  }

  @override
  Future<void> switchChannel(String? token, String channelName,
      [ChannelMediaOptions? options]) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSwitchChannel.index,
        'params': jsonEncode({
          'token': token,
          'channelId': channelName,
          'options': options?.toJson()
        })
      });
    }
    return _invokeMethod('switchChannel', {
      'token': token,
      'channelName': channelName,
      'options': options?.toJson()
    });
  }

  @override
  Future<void> leaveChannel() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineLeaveChannel.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('leaveChannel');
  }

  @override
  Future<void> renewToken(String token) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineRenewToken.index,
        'params': jsonEncode({'token': token})
      });
    }
    return _invokeMethod('renewToken', {'token': token});
  }

  @override
  @deprecated
  Future<void> enableWebSdkInteroperability(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableWebSdkInteroperability.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('enableWebSdkInteroperability', {'enabled': enabled});
  }

  @override
  Future<ConnectionStateType> getConnectionState() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetConnectionState.index,
        'params': jsonEncode({})
      }).then((value) {
        return ConnectionStateTypeConverter.fromValue(value).e;
      });
    }
    return _invokeMethod('getConnectionState').then((value) {
      return ConnectionStateTypeConverter.fromValue(value).e;
    });
  }

  @override
  Future<String?> getCallId() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetCallId.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('getCallId');
  }

  @override
  Future<void> rate(String callId, int rating, {String? description}) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineRate.index,
        'params': jsonEncode(
            {'callId': callId, 'rating': rating, 'description': description})
      });
    }
    return _invokeMethod('rate',
        {'callId': callId, 'rating': rating, 'description': description});
  }

  @override
  Future<void> complain(String callId, String description) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineComplain.index,
        'params': jsonEncode({'callId': callId, 'description': description})
      });
    }
    return _invokeMethod(
        'complain', {'callId': callId, 'description': description});
  }

  @override
  @deprecated
  Future<void> setLogFile(String filePath) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLogFile.index,
        'params': jsonEncode({'filePath': filePath})
      });
    }
    return _invokeMethod('setLogFile', {'filePath': filePath});
  }

  @override
  @deprecated
  Future<void> setLogFilter(LogFilter filter) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLogFilter.index,
        'params': jsonEncode({'filter': LogFilterConverter(filter).value()})
      });
    }
    return _invokeMethod(
        'setLogFilter', {'filter': LogFilterConverter(filter).value()});
  }

  @override
  @deprecated
  Future<void> setLogFileSize(int fileSizeInKBytes) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLogFileSize.index,
        'params': jsonEncode({'fileSizeInKBytes': fileSizeInKBytes})
      });
    }
    return _invokeMethod(
        'setLogFileSize', {'fileSizeInKBytes': fileSizeInKBytes});
  }

  @override
  Future<void> setParameters(String parameters) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetParameters.index,
        'params': jsonEncode({'parameters': parameters})
      });
    }
    return _invokeMethod('setParameters', {'parameters': parameters});
  }

  @override
  Future<UserInfo> getUserInfoByUid(int uid) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetUserInfoByUid.index,
        'params': jsonEncode({'uid': uid})
      }).then((value) {
        return UserInfo.fromJson(Map<String, dynamic>.from(jsonDecode(value)));
      });
    }
    return _invokeMethod('getUserInfoByUid', {'uid': uid}).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(value));
    });
  }

  @override
  Future<UserInfo> getUserInfoByUserAccount(String userAccount) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetUserInfoByUserAccount.index,
        'params': jsonEncode({'userAccount': userAccount})
      }).then((value) {
        return UserInfo.fromJson(Map<String, dynamic>.from(jsonDecode(value)));
      });
    }
    return _invokeMethod(
        'getUserInfoByUserAccount', {'userAccount': userAccount}).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(value));
    });
  }

  @override
  Future<void> joinChannelWithUserAccount(
      String? token, String channelName, String userAccount,
      [ChannelMediaOptions? options]) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineJoinChannelWithUserAccount.index,
        'params': jsonEncode({
          'token': token,
          'channelId': channelName,
          'userAccount': userAccount,
          'options': options?.toJson()
        })
      });
    }
    return _invokeMethod('joinChannelWithUserAccount', {
      'token': token,
      'channelName': channelName,
      'userAccount': userAccount,
      'options': options?.toJson()
    });
  }

  @override
  Future<void> registerLocalUserAccount(String appId, String userAccount) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineRegisterLocalUserAccount.index,
        'params': jsonEncode({'appId': appId, 'userAccount': userAccount})
      });
    }
    return _invokeMethod('registerLocalUserAccount',
        {'appId': appId, 'userAccount': userAccount});
  }

  @override
  Future<void> adjustPlaybackSignalVolume(int volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAdjustPlaybackSignalVolume.index,
        'params': jsonEncode({'volume': volume})
      });
    }
    return _invokeMethod('adjustPlaybackSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustRecordingSignalVolume(int volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAdjustRecordingSignalVolume.index,
        'params': jsonEncode({'volume': volume})
      });
    }
    return _invokeMethod('adjustRecordingSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAdjustUserPlaybackSignalVolume.index,
        'params': jsonEncode({'uid': uid, 'volume': volume})
      });
    }
    return _invokeMethod(
        'adjustUserPlaybackSignalVolume', {'uid': uid, 'volume': volume});
  }

  @override
  Future<void> disableAudio() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineDisableAudio.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('disableAudio');
  }

  @override
  Future<void> enableAudio() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableAudio.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('enableAudio');
  }

  @override
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableAudioVolumeIndication.index,
        'params': jsonEncode(
            {'interval': interval, 'smooth': smooth, 'report_vad': report_vad})
      });
    }
    return _invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth, 'report_vad': report_vad});
  }

  @override
  Future<void> enableLocalAudio(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableLocalAudio.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('enableLocalAudio', {'enabled': enabled});
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineMuteAllRemoteAudioStreams.index,
        'params': jsonEncode({'mute': muted})
      });
    }
    return _invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalAudioStream(bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineMuteLocalAudioStream.index,
        'params': jsonEncode({'mute': muted})
      });
    }
    return _invokeMethod('muteLocalAudioStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteAudioStream(int uid, bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineMuteRemoteAudioStream.index,
        'params': jsonEncode({'userId': uid, 'mute': muted})
      });
    }
    return _invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetAudioProfile.index,
        'params': jsonEncode({
          'profile': AudioProfileConverter(profile).value(),
          'scenario': AudioScenarioConverter(scenario).value()
        })
      });
    }
    return _invokeMethod('setAudioProfile', {
      'profile': AudioProfileConverter(profile).value(),
      'scenario': AudioScenarioConverter(scenario).value()
    });
  }

  @override
  @deprecated
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType':
            _ApiTypeEngine.kEngineSetDefaultMuteAllRemoteAudioStreams.index,
        'params': jsonEncode({'mute': muted})
      });
    }
    return _invokeMethod(
        'setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> disableVideo() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineDisableVideo.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('disableVideo');
  }

  @override
  Future<void> enableLocalVideo(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableLocalVideo.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('enableLocalVideo', {'enabled': enabled});
  }

  @override
  Future<void> enableVideo() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableVideo.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('enableVideo');
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineMuteAllRemoteVideoStreams.index,
        'params': jsonEncode({'mute': muted})
      });
    }
    return _invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalVideoStream(bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineMuteLocalVideoStream.index,
        'params': jsonEncode({'mute': muted})
      });
    }
    return _invokeMethod('muteLocalVideoStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteVideoStream(int uid, bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineMuteRemoteVideoStream.index,
        'params': jsonEncode({'userId': uid, 'mute': muted})
      });
    }
    return _invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetBeautyEffectOptions.index,
        'params': jsonEncode({'enabled': enabled, 'options': options.toJson()})
      });
    }
    return _invokeMethod('setBeautyEffectOptions',
        {'enabled': enabled, 'options': options.toJson()});
  }

  @override
  @deprecated
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType':
            _ApiTypeEngine.kEngineSetDefaultMuteAllRemoteVideoStreams.index,
        'params': jsonEncode({'mute': muted})
      });
    }
    return _invokeMethod(
        'setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetVideoEncoderConfiguration.index,
        'params': jsonEncode({'config': config.toJson()})
      });
    }
    return _invokeMethod(
        'setVideoEncoderConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> startPreview() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStartPreview.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('startPreview');
  }

  @override
  Future<void> stopPreview() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopPreview.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('stopPreview');
  }

  @override
  Future<void> adjustAudioMixingPlayoutVolume(int volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAdjustAudioMixingPlayoutVolume.index,
        'params': jsonEncode({'volume': volume})
      });
    }
    return _invokeMethod('adjustAudioMixingPlayoutVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingPublishVolume(int volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAdjustAudioMixingPublishVolume.index,
        'params': jsonEncode({'volume': volume})
      });
    }
    return _invokeMethod('adjustAudioMixingPublishVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingVolume(int volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAdjustAudioMixingVolume.index,
        'params': jsonEncode({'volume': volume})
      });
    }
    return _invokeMethod('adjustAudioMixingVolume', {'volume': volume});
  }

  @override
  Future<int?> getAudioMixingCurrentPosition() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetAudioMixingCurrentPosition.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('getAudioMixingCurrentPosition');
  }

  @override
  Future<int?> getAudioMixingDuration([String? filePath]) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetAudioMixingDuration.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('getAudioMixingDuration', {
      'filePath': filePath,
    });
  }

  @override
  Future<int?> getAudioMixingPlayoutVolume() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetAudioMixingPlayoutVolume.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('getAudioMixingPlayoutVolume');
  }

  @override
  Future<int?> getAudioMixingPublishVolume() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetAudioMixingPublishVolume.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('getAudioMixingPublishVolume');
  }

  @override
  Future<void> pauseAudioMixing() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEnginePauseAudioMixing.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('pauseAudioMixing');
  }

  @override
  Future<void> resumeAudioMixing() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineResumeAudioMixing.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('resumeAudioMixing');
  }

  @override
  Future<void> setAudioMixingPosition(int pos) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetAudioMixingPosition.index,
        'params': jsonEncode({'pos': pos})
      });
    }
    return _invokeMethod('setAudioMixingPosition', {'pos': pos});
  }

  @override
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle,
      [int? startPos]) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStartAudioMixing.index,
        'params': jsonEncode({
          'filePath': filePath,
          'loopback': loopback,
          'replace': replace,
          'cycle': cycle
        })
      });
    }
    return _invokeMethod('startAudioMixing', {
      'filePath': filePath,
      'loopback': loopback,
      'replace': replace,
      'cycle': cycle,
      'startPos': startPos
    });
  }

  @override
  Future<void> stopAudioMixing() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopAudioMixing.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('stopAudioMixing');
  }

  @override
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAddInjectStreamUrl.index,
        'params': jsonEncode({'url': url, 'config': config.toJson()})
      });
    }
    return _invokeMethod(
        'addInjectStreamUrl', {'url': url, 'config': config.toJson()});
  }

  @override
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAddPublishStreamUrl.index,
        'params':
            jsonEncode({'url': url, 'transcodingEnabled': transcodingEnabled})
      });
    }
    return _invokeMethod('addPublishStreamUrl',
        {'url': url, 'transcodingEnabled': transcodingEnabled});
  }

  @override
  Future<void> addVideoWatermark(
      String watermarkUrl, WatermarkOptions options) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineAddVideoWaterMark.index,
        'params': jsonEncode(
            {'watermarkUrl': watermarkUrl, 'options': options.toJson()})
      });
    }
    return _invokeMethod('addVideoWatermark',
        {'watermarkUrl': watermarkUrl, 'options': options.toJson()});
  }

  @override
  Future<void> clearVideoWatermarks() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineClearVideoWaterMarks.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('clearVideoWatermarks');
  }

  @override
  Future<int?> createDataStream(bool reliable, bool ordered) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineCreateDataStream.index,
        'params': jsonEncode({'reliable': reliable, 'ordered': ordered})
      });
    }
    return _invokeMethod(
        'createDataStream', {'reliable': reliable, 'ordered': ordered});
  }

  @override
  Future<void> disableLastmileTest() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineDisableLastMileTest.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('disableLastmileTest');
  }

  @override
  Future<void> enableDualStreamMode(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableDualStreamMode.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('enableDualStreamMode', {'enabled': enabled});
  }

  @override
  Future<void> enableInEarMonitoring(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableInEarMonitoring.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('enableInEarMonitoring', {'enabled': enabled});
  }

  @override
  Future<void> enableLastmileTest() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableLastMileTest.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('enableLastmileTest');
  }

  @override
  Future<void> enableSoundPositionIndication(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableSoundPositionIndication.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('enableSoundPositionIndication', {'enabled': enabled});
  }

  @override
  Future<double?> getCameraMaxZoomFactor() {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('getCameraMaxZoomFactor');
  }

  @override
  Future<double?> getEffectsVolume() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineGetEffectsVolume.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('getEffectsVolume');
  }

  @override
  Future<bool?> isCameraAutoFocusFaceModeSupported() {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('isCameraAutoFocusFaceModeSupported');
  }

  @override
  Future<bool?> isCameraExposurePositionSupported() {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('isCameraExposurePositionSupported');
  }

  @override
  Future<bool?> isCameraFocusSupported() {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('isCameraFocusSupported');
  }

  @override
  Future<bool?> isCameraTorchSupported() {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('isCameraTorchSupported');
  }

  @override
  Future<bool?> isCameraZoomSupported() {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('isCameraZoomSupported');
  }

  @override
  Future<bool?> isSpeakerphoneEnabled() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineIsSpeakerPhoneEnabled.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('isSpeakerphoneEnabled');
  }

  @override
  Future<void> pauseAllEffects() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEnginePauseAllEffects.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('pauseAllEffects');
  }

  @override
  Future<void> pauseEffect(int soundId) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEnginePauseEffect.index,
        'params': jsonEncode({'soundId': soundId})
      });
    }
    return _invokeMethod('pauseEffect', {'soundId': soundId});
  }

  @override
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish,
      [int? startPos]) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEnginePlayEffect.index,
        'params': jsonEncode({
          'soundId': soundId,
          'filePath': filePath,
          'loopCount': loopCount,
          'pitch': pitch,
          'pan': pan,
          'gain': gain,
          'publish': publish
        })
      });
    }
    return _invokeMethod('playEffect', {
      'soundId': soundId,
      'filePath': filePath,
      'loopCount': loopCount,
      'pitch': pitch,
      'pan': pan,
      'gain': gain,
      'publish': publish,
      'startPos': startPos
    });
  }

  @override
  Future<void> setEffectPosition(int soundId, int pos) {
    return _invokeMethod('setEffectPosition', {'soundId': soundId, 'pos': pos});
  }

  @override
  Future<int?> getEffectDuration(String filePath) {
    return _invokeMethod('getEffectDuration', {'filePath': filePath});
  }

  @override
  Future<int?> getEffectCurrentPosition(int soundId) {
    return _invokeMethod('getEffectCurrentPosition', {'soundId': soundId});
  }

  @override
  Future<void> preloadEffect(int soundId, String filePath) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEnginePreloadEffect.index,
        'params': jsonEncode({'soundId': soundId, 'filePath': filePath})
      });
    }
    return _invokeMethod(
        'preloadEffect', {'soundId': soundId, 'filePath': filePath});
  }

  @override
  Future<void> registerMediaMetadataObserver() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineRegisterMediaMetadataObserver.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('registerMediaMetadataObserver');
  }

  @override
  Future<void> removeInjectStreamUrl(String url) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineRemoveInjectStreamUrl.index,
        'params': jsonEncode({'url': url})
      });
    }
    return _invokeMethod('removeInjectStreamUrl', {'url': url});
  }

  @override
  Future<void> removePublishStreamUrl(String url) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineRemovePublishStreamUrl.index,
        'params': jsonEncode({'url': url})
      });
    }
    return _invokeMethod('removePublishStreamUrl', {'url': url});
  }

  @override
  Future<void> resumeAllEffects() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineResumeAllEffects.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('resumeAllEffects');
  }

  @override
  Future<void> resumeEffect(int soundId) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineResumeEffect.index,
        'params': jsonEncode({'soundId': soundId})
      });
    }
    return _invokeMethod('resumeEffect', {'soundId': soundId});
  }

  @override
  Future<void> sendMetadata(String metadata) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApiWithBuffer', {
        'apiType': _ApiTypeEngine.kEngineSendMetadata.index,
        'params': jsonEncode({
          'metadata': {'size': metadata.length}
        }),
        'buffer': metadata
      });
    }
    return _invokeMethod('sendMetadata', {'metadata': metadata});
  }

  @override
  Future<void> sendStreamMessage(int streamId, String message) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApiWithBuffer', {
        'apiType': _ApiTypeEngine.kEngineSendStreamMessage.index,
        'params': jsonEncode({'streamId': streamId, 'length': message.length}),
        'buffer': message
      });
    }
    return _invokeMethod(
        'sendStreamMessage', {'streamId': streamId, 'message': message});
  }

  @override
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod(
        'setCameraAutoFocusFaceModeEnabled', {'enabled': enabled});
  }

  @override
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetCameraCapturerConfiguration.index,
        'params': jsonEncode({'config': config.toJson()})
      });
    }
    return _invokeMethod(
        'setCameraCapturerConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView) {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('setCameraExposurePosition', {
      'positionXinView': positionXinView,
      'positionYinView': positionYinView
    });
  }

  @override
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY) {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('setCameraFocusPositionInPreview',
        {'positionX': positionX, 'positionY': positionY});
  }

  @override
  Future<void> setCameraTorchOn(bool isOn) {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('setCameraTorchOn', {'isOn': isOn});
  }

  @override
  Future<void> setCameraZoomFactor(double factor) {
    if (!kIsWeb && Platform.isWindows) {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
    return _invokeMethod('setCameraZoomFactor', {'factor': factor});
  }

  @override
  Future<void> setDefaultAudioRoutetoSpeakerphone(bool defaultToSpeaker) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType':
            _ApiTypeEngine.kEngineSetDefaultAudioRouteToSpeakerPhone.index,
        'params': jsonEncode({'defaultToSpeaker': defaultToSpeaker})
      });
    }
    return _invokeMethod('setDefaultAudioRoutetoSpeakerphone',
        {'defaultToSpeaker': defaultToSpeaker});
  }

  @override
  Future<void> setEffectsVolume(double volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetEffectsVolume.index,
        'params': jsonEncode({'volume': volume})
      });
    }
    return _invokeMethod('setEffectsVolume', {'volume': volume});
  }

  @override
  Future<void> setEnableSpeakerphone(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetEnableSpeakerPhone.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('setEnableSpeakerphone', {'enabled': enabled});
  }

  @override
  @deprecated
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetEncryptionMode.index,
        'params': jsonEncode({'encryptionMode': encryptionMode})
      });
    }
    return _invokeMethod('setEncryptionMode',
        {'encryptionMode': EncryptionModeConverter(encryptionMode).value()});
  }

  @override
  @deprecated
  Future<void> setEncryptionSecret(String secret) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetEncryptionSecret.index,
        'params': jsonEncode({'secret': secret})
      });
    }
    return _invokeMethod('setEncryptionSecret', {'secret': secret});
  }

  @override
  Future<void> setInEarMonitoringVolume(int volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetInEarMonitoringVolume.index,
        'params': jsonEncode({'volume': volume})
      });
    }
    return _invokeMethod('setInEarMonitoringVolume', {'volume': volume});
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLiveTranscoding.index,
        'params': jsonEncode({'transcoding': transcoding.toJson()})
      });
    }
    return _invokeMethod(
        'setLiveTranscoding', {'transcoding': transcoding.toJson()});
  }

  @override
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLocalPublishFallbackOption.index,
        'params': jsonEncode(
            {'option': StreamFallbackOptionsConverter(option).value()})
      });
    }
    return _invokeMethod('setLocalPublishFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
  @deprecated
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLocalVoiceChanger.index,
        'params': jsonEncode(
            {'voiceChanger': AudioVoiceChangerConverter(voiceChanger).value()})
      });
    }
    return _invokeMethod('setLocalVoiceChanger',
        {'voiceChanger': AudioVoiceChangerConverter(voiceChanger).value()});
  }

  @override
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLocalVoiceEqualization.index,
        'params': jsonEncode({
          'bandFrequency':
              AudioEqualizationBandFrequencyConverter(bandFrequency).value(),
          'bandGain': bandGain
        })
      });
    }
    return _invokeMethod('setLocalVoiceEqualization', {
      'bandFrequency':
          AudioEqualizationBandFrequencyConverter(bandFrequency).value(),
      'bandGain': bandGain
    });
  }

  @override
  Future<void> setLocalVoicePitch(double pitch) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLocalVoicePitch.index,
        'params': jsonEncode({'pitch': pitch})
      });
    }
    return _invokeMethod('setLocalVoicePitch', {'pitch': pitch});
  }

  @override
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLocalVoiceReverb.index,
        'params': jsonEncode({
          'reverbKey': AudioReverbTypeConverter(reverbKey).value(),
          'value': value
        })
      });
    }
    return _invokeMethod('setLocalVoiceReverb', {
      'reverbKey': AudioReverbTypeConverter(reverbKey).value(),
      'value': value
    });
  }

  @override
  @deprecated
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetLocalVoiceReverbPreset.index,
        'params':
            jsonEncode({'preset': AudioReverbPresetConverter(preset).value()})
      });
    }
    return _invokeMethod('setLocalVoiceReverbPreset',
        {'preset': AudioReverbPresetConverter(preset).value()});
  }

  @override
  Future<void> setMaxMetadataSize(int size) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetMaxMetadataSize.index,
        'params': jsonEncode({'size': size})
      });
    }
    return _invokeMethod('setMaxMetadataSize', {'size': size});
  }

  @override
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetRemoteDefaultVideoStreamType.index,
        'params': jsonEncode(
            {'streamType': VideoStreamTypeConverter(streamType).value()})
      });
    }
    return _invokeMethod('setRemoteDefaultVideoStreamType',
        {'streamType': VideoStreamTypeConverter(streamType).value()});
  }

  @override
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetRemoteSubscribeFallbackOption.index,
        'params': jsonEncode(
            {'option': StreamFallbackOptionsConverter(option).value()})
      });
    }
    return _invokeMethod('setRemoteSubscribeFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetRemoteUserPriority.index,
        'params': jsonEncode({
          'uid': uid,
          'userPriority': UserPriorityConverter(userPriority).value()
        })
      });
    }
    return _invokeMethod('setRemoteUserPriority', {
      'uid': uid,
      'userPriority': UserPriorityConverter(userPriority).value()
    });
  }

  @override
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetRemoteVideoStreamType.index,
        'params': jsonEncode({
          'uid': uid,
          'streamType': VideoStreamTypeConverter(streamType).value()
        })
      });
    }
    return _invokeMethod('setRemoteVideoStreamType', {
      'uid': uid,
      'streamType': VideoStreamTypeConverter(streamType).value()
    });
  }

  @override
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetRemoteVoicePosition.index,
        'params': jsonEncode({'uid': uid, 'pan': pan, 'gain': gain})
      });
    }
    return _invokeMethod(
        'setRemoteVoicePosition', {'uid': uid, 'pan': pan, 'gain': gain});
  }

  @override
  Future<void> setVolumeOfEffect(int soundId, double volume) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetVolumeOfEffect.index,
        'params': jsonEncode({'soundId': soundId, 'volume': volume})
      });
    }
    return _invokeMethod(
        'setVolumeOfEffect', {'soundId': soundId, 'volume': volume});
  }

  @override
  @deprecated
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStartAudioRecording.index,
        'params': jsonEncode({
          'filePath': filePath,
          'sampleRate': AudioSampleRateTypeConverter(sampleRate).value(),
          'quality': AudioRecordingQualityConverter(quality).value()
        })
      });
    }
    return _invokeMethod('startAudioRecording', {
      'filePath': filePath,
      'sampleRate': AudioSampleRateTypeConverter(sampleRate).value(),
      'quality': AudioRecordingQualityConverter(quality).value()
    });
  }

  @override
  Future<void> startAudioRecordingWithConfig(
      AudioRecordingConfiguration config) {
    return _invokeMethod('startAudioRecording', {'config': config.toJson()});
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStartChannelMediaRelay.index,
        'params': jsonEncode(
            {'configuration': channelMediaRelayConfiguration.toJson()})
      });
    }
    return _invokeMethod('startChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> startRhythmPlayer(
      String sound1, String sound2, RhythmPlayerConfig config) {
    return _invokeMethod('startRhythmPlayer', {
      'sound1': sound1,
      'sound2': sound2,
      'config': config.toJson(),
    });
  }

  @override
  Future<void> stopRhythmPlayer() {
    return _invokeMethod('stopRhythmPlayer');
  }

  @override
  Future<void> configRhythmPlayer(RhythmPlayerConfig config) {
    return _invokeMethod('configRhythmPlayer', {'config': config.toJson()});
  }

  @override
  Future<void> startEchoTest(int intervalInSeconds) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStartEchoTest.index,
        'params': jsonEncode({'intervalInSeconds': intervalInSeconds})
      });
    }
    return _invokeMethod(
        'startEchoTest', {'intervalInSeconds': intervalInSeconds});
  }

  @override
  Future<void> startLastmileProbeTest(LastmileProbeConfig config) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStartLastMileProbeTest.index,
        'params': jsonEncode({'config': config.toJson()})
      });
    }
    return _invokeMethod('startLastmileProbeTest', {'config': config.toJson()});
  }

  @override
  Future<void> stopAllEffects() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopAllEffects.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('stopAllEffects');
  }

  @override
  Future<void> stopAudioRecording() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopAudioRecording.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('stopAudioRecording');
  }

  @override
  Future<void> stopChannelMediaRelay() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopChannelMediaRelay.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('stopChannelMediaRelay');
  }

  @override
  Future<void> stopEchoTest() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopEchoTest.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('stopEchoTest');
  }

  @override
  Future<void> stopEffect(int soundId) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopEffect.index,
        'params': jsonEncode({'soundId': soundId})
      });
    }
    return _invokeMethod('stopEffect', {'soundId': soundId});
  }

  @override
  Future<void> stopLastmileProbeTest() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineStopLastMileProbeTest.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('stopLastmileProbeTest');
  }

  @override
  Future<void> switchCamera() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSwitchCamera.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('switchCamera');
  }

  @override
  Future<void> unloadEffect(int soundId) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineUnloadEffect.index,
        'params': jsonEncode({'soundId': soundId})
      });
    }
    return _invokeMethod('unloadEffect', {'soundId': soundId});
  }

  @override
  Future<void> unregisterMediaMetadataObserver() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineUnRegisterMediaMetadataObserver.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('unregisterMediaMetadataObserver');
  }

  @override
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineUpdateChannelMediaRelay.index,
        'params': jsonEncode(
            {'configuration': channelMediaRelayConfiguration.toJson()})
      });
    }
    return _invokeMethod('updateChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> enableFaceDetection(bool enable) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableFaceDetection.index,
        'params': jsonEncode({'enable': enable})
      });
    }
    return _invokeMethod('enableFaceDetection', {'enable': enable});
  }

  @override
  Future<void> setAudioMixingPitch(int pitch) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetAudioMixingPitch.index,
        'params': jsonEncode({'pitch': pitch})
      });
    }
    return _invokeMethod('setAudioMixingPitch', {'pitch': pitch});
  }

  @override
  Future<void> enableEncryption(bool enabled, EncryptionConfig config) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableEncryption.index,
        'params': jsonEncode({'enabled': enabled, 'config': config.toJson()})
      });
    }
    return _invokeMethod(
        'enableEncryption', {'enabled': enabled, 'config': config.toJson()});
  }

  @override
  Future<void> sendCustomReportMessage(
      String id, String category, String event, String label, int value) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSendCustomReportMessage.index,
        'params': jsonEncode({
          'id': id,
          'category': category,
          'event': event,
          'label': label,
          'value': value
        })
      });
    }
    return _invokeMethod('sendCustomReportMessage', {
      'id': id,
      'category': category,
      'event': event,
      'label': label,
      'value': value
    });
  }

  @override
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType':
            _ApiTypeEngine.kEngineSetAudioSessionOperationRestriction.index,
        'params': jsonEncode({
          'restriction':
              AudioSessionOperationRestrictionConverter(restriction).value()
        })
      });
    }
    return _invokeMethod('setAudioSessionOperationRestriction', {
      'restriction':
          AudioSessionOperationRestrictionConverter(restriction).value()
    });
  }

  @override
  Future<int?> getNativeHandle() {
    if (!kIsWeb && Platform.isWindows) {
      // TODO
    }
    return _invokeMethod('getNativeHandle');
  }

  @override
  Future<void> setAudioEffectParameters(
      AudioEffectPreset preset, int param1, int param2) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetAudioEffectParameters.index,
        'params': jsonEncode({
          'preset': AudioEffectPresetConverter(preset).value(),
          'param1': param1,
          'param2': param2
        })
      });
    }
    return _invokeMethod('setAudioEffectParameters', {
      'preset': AudioEffectPresetConverter(preset).value(),
      'param1': param1,
      'param2': param2
    });
  }

  @override
  Future<void> setAudioEffectPreset(AudioEffectPreset preset) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetAudioEffectPreset.index,
        'params':
            jsonEncode({'preset': AudioEffectPresetConverter(preset).value()})
      });
    }
    return _invokeMethod('setAudioEffectPreset',
        {'preset': AudioEffectPresetConverter(preset).value()});
  }

  @override
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetVoiceBeautifierPreset.index,
        'params': jsonEncode(
            {'preset': VoiceBeautifierPresetConverter(preset).value()})
      });
    }
    return _invokeMethod('setVoiceBeautifierPreset',
        {'preset': VoiceBeautifierPresetConverter(preset).value()});
  }

  @override
  Future<int?> createDataStreamWithConfig(DataStreamConfig config) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineCreateDataStream.index,
        'params': jsonEncode({'config': config.toJson()})
      });
    }
    return _invokeMethod('createDataStream', {'config': config.toJson()});
  }

  @override
  Future<void> enableDeepLearningDenoise(bool enabled) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableDeepLearningDenoise.index,
        'params': jsonEncode({'enabled': enabled})
      });
    }
    return _invokeMethod('enableDeepLearningDenoise', {'enabled': enabled});
  }

  @override
  Future<void> enableRemoteSuperResolution(int uid, bool enable) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineEnableRemoteSuperResolution.index,
        'params': jsonEncode({'uid': uid, 'enable': enable})
      });
    }
    return _invokeMethod(
        'enableRemoteSuperResolution', {'uid': uid, 'enable': enable});
  }

  @override
  Future<void> setCloudProxy(CloudProxyType proxyType) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetCloudProxy.index,
        'params':
            jsonEncode({'proxyType': CloudProxyTypeConverter(proxyType).e})
      });
    }
    return _invokeMethod('enableRemoteSuperResolution',
        {'proxyType': CloudProxyTypeConverter(proxyType).e});
  }

  @override
  Future<String?> uploadLogFile() {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineUploadLogFile.index,
        'params': jsonEncode({})
      });
    }
    return _invokeMethod('uploadLogFile');
  }

  @override
  Future<void> setVoiceBeautifierParameters(
      VoiceBeautifierPreset preset, int param1, int param2) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetVoiceBeautifierParameters.index,
        'params': jsonEncode({
          'preset': VoiceBeautifierPresetConverter(preset).e,
          'param1': param1,
          'param2': param2
        })
      });
    }
    return _invokeMethod('setVoiceBeautifierParameters', {
      'preset': VoiceBeautifierPresetConverter(preset).e,
      'param1': param1,
      'param2': param2
    });
  }

  @override
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset) {
    if (!kIsWeb && Platform.isWindows) {
      return _invokeMethod('callApi', {
        'apiType': _ApiTypeEngine.kEngineSetVoiceConversionPreset.index,
        'params':
            jsonEncode({'preset': VoiceConversionPresetConverter(preset).e})
      });
    }
    return _invokeMethod('setVoiceConversionPreset',
        {'preset': VoiceConversionPresetConverter(preset).e});
  }
}

/// @nodoc
mixin RtcEngineInterface
    implements
        RtcUserInfoInterface,
        RtcAudioInterface,
        RtcVideoInterface,
        RtcAudioMixingInterface,
        RtcAudioEffectInterface,
        RtcVoiceChangerInterface,
        RtcVoicePositionInterface,
        RtcPublishStreamInterface,
        RtcMediaRelayInterface,
        RtcAudioRouteInterface,
        RtcEarMonitoringInterface,
        RtcDualStreamInterface,
        RtcFallbackInterface,
        RtcTestInterface,
        RtcMediaMetadataInterface,
        RtcWatermarkInterface,
        RtcEncryptionInterface,
        RtcAudioRecorderInterface,
        RtcInjectStreamInterface,
        RtcCameraInterface,
        RtcStreamMessageInterface {
  /// Destroys the [RtcEngine] instance and releases all resources used by the Agora SDK.
  ///
  /// This method is useful for apps that occasionally make voice or video calls, to free up resources for other operations when not making calls.
  ///
  /// **Note**
  /// - Call this method in the subthread.
  /// - Once the app calls [RtcEngine.destroy] to destroy the created [RtcEngine] instance, you cannot use any method or callback in the SDK.
  Future<void> destroy();

  /// Sets the channel profile of the Agora RtcEngine.
  ///
  /// The Agora RtcEngine differentiates channel profiles and applies different optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call, and prioritizes video quality for a video broadcast.
  ///
  /// **Parameter** [profile] The channel profile of the Agora RtcEngine. See [ChannelProfile].
  Future<void> setChannelProfile(ChannelProfile profile);

  /// Sets the role of a user in a live interactive streaming.
  ///
  /// You can call this method either before or after joining the channel to set the user role as audience or host. If you call this method to switch the user role after joining the channel, the SDK triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.clientRoleChanged].
  /// - The remote client: [RtcEngineEventHandler.userJoined] or [RtcEngineEventHandler.userOffline] ([UserOfflineReason.BecomeAudience]).
  ///
  /// **Note**
  /// - This method applies to the `LiveBroadcasting` profile only (when the `profile` parameter in `setChannelProfile` is set as `LiveBroadcasting`).
  /// - Since v3.2.1, this method can set the user level in addition to the user role.
  ///    - The user role determines the permissions that the SDK grants to a user, such as permission to send local streams, receive remote streams, and push streams to a CDN address.
  ///    - The user level determines the level of services that a user can enjoy within the permissions of the user's role. For example, an audience can choose to receive remote streams with low latency or ultra low latency. Levels affect prices.
  ///
  /// **Parameter** [role] Sets the role of a user. See [ClientRole].
  ///
  /// **Parameter** [options] The detailed options of a user, including user level. See [ClientRoleOptions].
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]);

  /// Allows a user to join a channel.
  ///
  /// Users in the same channel can talk to each other, and multiple users in the same channel can start a group chat. Users with different App IDs cannot call each other.
  /// You must call the [RtcEngine.leaveChannel] method to exit the current call before joining another channel.
  /// A successful joinChannel method call triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.joinChannelSuccess].
  /// - The remote client: [RtcEngineEventHandler.userJoined], if the user joining the channel is in the [ChannelProfile.Communication] profile, or is a [ClientRole.Broadcaster] in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the [RtcEngineEventHandler.rejoinChannelSuccess] callback on the local client.
  ///
  /// Once the user joins the channel (switches to another channel), the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the mute methods accordingly.
  ///
  /// **Note**
  /// - A channel does not accept duplicate uids, such as two users with the same uid. If you set uid as 0, the system automatically assigns a uid.
  ///
  /// **Warning**
  /// - Ensure that the App ID used for creating the token is the same App ID used in the create method for creating an [RtcEngine] object. Otherwise, CDN live streaming may fail.
  ///
  /// **Parameter** [token] The token for authentication. Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#generatetoken).
  ///
  /// **Parameter** [channelName] The unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "\[", "\]", "^", "_", " {", "}", "|", "~", ",".
  ///
  /// **Parameter** [optionalInfo] Additional information about the channel. This parameter can be set as null or contain channel related information. Other users in the channel do not receive this message.
  ///
  /// **Parameter** [optionalUid] (Optional) User ID. `optionalUid` must be unique. If `optionalUid` is not assigned (or set to 0), the SDK assigns and returns uid in the [RtcEngineEventHandler.joinChannelSuccess] callback. Your app must record and maintain the returned uid since the SDK does not do so.
  ///
  /// **Parameter** [options] The channel media options. See [ChannelMediaOptions].
  Future<void> joinChannel(
      String? token, String channelName, String? optionalInfo, int optionalUid,
      [ChannelMediaOptions? options]);

  /// Switches to a different channel.
  ///
  /// This method allows the audience of a [ChannelProfile.LiveBroadcasting] channel to switch to a different channel.
  /// After the user successfully switches to another channel, the [RtcEngineEventHandler.leaveChannel] and [RtcEngineEventHandler.joinChannelSuccess] callbacks are triggered to indicate that the user has left the original channel and joined a new one.
  ///
  /// **Note**
  /// - This method applies to the [ClientRole.Audience] role in a [ChannelProfile.LiveBroadcasting] channel only.
  ///
  /// **Parameter** [token] The token for authentication. Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#generatetoken).
  ///
  /// **Parameter** [channelName] Unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "\[", "\]", "^", "_", " {", "}", "|", "~", ",".
  ///
  /// **Parameter** [options] The channel media options: [ChannelMediaOptions].
  Future<void> switchChannel(String? token, String channelName,
      [ChannelMediaOptions? options]);

  /// Allows a user to leave a channel.
  ///
  /// After joining a channel, the user must call this method to end the call before joining another channel. This method returns 0 if the user leaves the channel and releases all resources related to the call. This method call is asynchronous, and the user has not exited the channel when the method call returns. Once the user leaves the channel, the SDK triggers the [RtcEngineEventHandler.leaveChannel] callback.
  /// A successful method call triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.leaveChannel].
  /// - The remote client: [RtcEngineEventHandler.userOffline], if the user leaving the channel is in the [ChannelProfile.Communication] profile, or is a [ClientRole.Broadcaster] in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Note**
  /// - If you call the [RtcEngine.destroy] method immediately after calling this method, the `leaveChannel` process interrupts, and the SDK does not trigger the [RtcEngineEventHandler.leaveChannel] callback.
  /// - If you call this method during CDN live streaming, the SDK triggers the [RtcEngine.removePublishStreamUrl] method.
  Future<void> leaveChannel();

  /// Renews the token when the current token expires.
  ///
  /// The token expires after a period of time once the token schema is enabled when:
  /// - The SDK triggers the [RtcEngineEventHandler.tokenPrivilegeWillExpire] callback
  /// - The [RtcEngineEventHandler.connectionStateChanged] callback reports the [ConnectionChangedReason.TokenExpired] error.
  /// The app should retrieve a new token from the server and call this method to renew it. Failure to do so results in the SDK disconnecting from the server.
  ///
  /// **Parameter** [token] The new token.
  Future<void> renewToken(String token);

  /// Enables interoperability with the Agora Web SDK (LiveBroadcasting only).
  ///
  /// The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.
  /// If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.
  /// Use this method when the channel profile is [ChannelProfile.LiveBroadcasting]. Interoperability with the Agora Web SDK is enabled by default when the channel profile is [ChannelProfile.Communication].
  ///
  /// **Parameter** [enabled] Sets whether to enable/disable interoperability with the Agora Web SDK:
  /// - `true`: Enable.
  /// - `false`: (Default) Disable.
  @deprecated
  Future<void> enableWebSdkInteroperability(bool enabled);

  /// Gets the connection state of the SDK.
  ///
  /// **Returns**
  /// - The current connection state [ConnectionStateType], if this method call succeeds.
  /// - Error code, if this method call fails.
  Future<ConnectionStateType> getConnectionState();

  /// This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes. To try out this function, contact support@agora.io and discuss the format of customized messages with us.
  Future<void> sendCustomReportMessage(
      String id, String category, String event, String label, int value);

  /// Gets the current call ID.
  ///
  /// When a user joins a channel on a client, a call ID is generated to identify the call from the client. Feedback methods, such as the [RtcEngine.rate] and [RtcEngine.complain] method, must be called after the call ends to submit feedback to the SDK.
  ///
  /// The `rate` and `complain` methods require the `callId` parameter retrieved from the [RtcEngine.getCallId] method during a call. `callId` is passed as an argument into the rate and complain methods after the call ends.
  ///
  ///  **Returns**
  /// - The current call ID, if the method call succeeds.
  /// - The empty string "", if the method call fails.
  Future<String?> getCallId();

  /// Allows the user to rate a call after the call ends.
  ///
  /// **Parameter** [callId] ID of the call retrieved from the [RtcEngine.getCallId] method.
  ///
  /// **Parameter** [rating] Rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the [ErrorCode.InvalidArgument] error occurs.
  ///
  /// **Parameter** [description] (Optional) The description of the rating. The string length must be less than 800 bytes.
  Future<void> rate(String callId, int rating, {String? description});

  /// Allows a user to complain about the call quality after a call ends.
  ///
  /// **Parameter** [callId] ID of the call retrieved from the [RtcEngine.getCallId] method.
  ///
  /// **Parameter** [description] (Optional) The description of the complaint. The string length must be less than 800 bytes.
  Future<void> complain(String callId, String description);

  /// Specifies an SDK output log file.
  ///
  /// The log file records all log data for the SDK’s operation. Ensure that the directory for the log file exists and is writable.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated from v3.3.1.
  ///
  /// **Note**
  /// - Ensure that you call this method immediately after calling the [RtcEngine.create] method, otherwise the output log may not be complete.
  ///
  /// **Parameter** [filePath] File path of the log file. The string of the log file is in UTF-8. The default file path is `/storage/emulated/0/Android/data/<package name>="">/files/agorasdk.log` for Android and `App Sandbox/Library/caches/agorasdk.log` for iOS.
  @deprecated
  Future<void> setLogFile(String filePath);

  /// Sets the output log level of the SDK.
  ///
  /// You can use one or a combination of the filters. The log level follows the sequence of `OFF`, `CRITICAL`, `ERROR`, `WARNING`, `INFO`, and `DEBUG`. Choose a level to see the logs preceding that level. For example, if you set the log level to `WARNING`, you see the logs within levels `CRITICAL`, `ERROR`, and `WARNING`.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated from v3.3.1.
  ///
  /// **Parameter** [filter] Sets the log filter level. See [LogFilter].
  @deprecated
  Future<void> setLogFilter(LogFilter filter);

  /// Sets the log file size (KB).
  ///
  /// By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`, each with a default size of 1024 KB.
  ///
  /// These log files are encoded in UTF-8. The SDK writes the latest logs in `agorasdk.log`. When agorasdk.log is full, the SDK deletes the log file with the earliest modification time among the other four, renames agorasdk.log to the name of the deleted log file, and create a new `agorasdk.log` to record latest logs.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated from v3.3.1.
  ///
  /// **Parameter** [fileSizeInKBytes] The size (KB) of a log file. The default value is 1024 KB. If you set `fileSizeInKBytes` to 1024 KB, the SDK outputs at most 5 MB log files; if you set it to less than 1024 KB, the maximum size of a log file is still 1024 KB.
  @deprecated
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// @nodoc Provides technical preview functionalities or special customizations by configuring the SDK with JSON options.
  ///
  /// The JSON options are not public by default. Agora is working on making commonly used JSON options public in a standard way.
  ///
  /// **Parameter** [parameters] Sets the parameter as a JSON string in the specified format.
  Future<void> setParameters(String parameters);

  /// Gets the native handle of the SDK engine.
  ///
  /// This interface is used to retrieve the native C++ handle of the SDK engine used in special scenarios, such as registering the audio and video frame observer.
  ///
  /// **Returns**
  /// - The native handle of the SDK, if this method call succeeds.
  /// - Error code, if this method call fails.
  Future<int?> getNativeHandle();

  ///  Enables or disables deep-learning noise reduction.
  ///
  /// Since v3.3.1.
  ///
  /// The SDK enables traditional noise reduction mode by default to reduce most of the stationary background noise.
  /// If you need to reduce most of the non-stationary background noise, Agora recommends enabling deep-learning noise reduction by calling `enableDeepLearningDenoise(true)`.
  ///
  /// Deep-learning noise reduction requires high-performance devices.
  ///
  /// After successfully enabling deep-learning noise reduction, if the SDK detects that the device performance is not sufficient, it automatically disables deep-learning noise reduction and enables traditional noise reduction.
  ///
  /// If you call `enableDeepLearningDenoise(false)` or the SDK automatically disables deep-learning noise reduction in the channel, when you need to re-enable deep-learning noise reduction, you need to call `leaveChannel` first, and then call `enableDeepLearningDenoise(true)`.
  ///
  /// **Parameter** [enabled]	Sets whether to enable deep-learning noise reduction.
  /// - true: (Default) Enables deep-learning noise reduction.
  /// - false: Disables deep-learning noise reduction.
  ///
  /// **Note**
  ///
  /// - Agora recommends calling this method before joining a channel.
  /// - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  Future<void> enableDeepLearningDenoise(bool enabled);

  ///  Sets the Agora cloud proxy service.
  ///
  /// Since v3.3.1.
  ///
  ///
  /// When the user’s firewall restricts the IP address and port, refer to *Use Cloud Proxy* to add the specific IP addresses and ports to the firewall whitelist; then, call this method to enable the cloud proxy and set the [proxyType] parameter as `UDP(1)`, which is the cloud proxy for the UDP protocol.
  ///
  /// After a successfully cloud proxy connection, the SDK triggers the `connectionStateChanged(Connecting, SettingProxyServer)` callback.
  ///
  /// To disable the cloud proxy that has been set, call `setCloudProxy(None)`. To change the cloud proxy type that has been set, call `setCloudProxy(None)` first, and then call `setCloudProxy`, and pass the value that you expect in [proxyType].
  ///
  /// **Parameter**
  ///
  /// [proxyType]	The cloud proxy type, see [CloudProxyType]. This parameter is required, and the SDK reports an error if you do not pass in a value.
  ///
  /// **Note**
  ///
  /// - Agora recommends that you call this method before joining the channel or after leaving the channel.
  /// - When you use the cloud proxy for the UDP protocol, the services for pushing streams to CDN and co-hosting across channels are not available.
  Future<void> setCloudProxy(CloudProxyType proxyType);

  ///  @nodoc
  Future<String?> uploadLogFile();
}

/// @nodoc
mixin RtcUserInfoInterface {
  /// Registers a user account.
  ///
  /// Once registered, the user account can be used to identify the local user when the user joins the channel. After the user successfully registers a user account, the SDK triggers the [RtcEngineEventHandler.localUserRegistered] callback on the local client, reporting the user ID and user account of the local user.
  ///
  /// To join a channel with a user account, you can choose either of the following:
  /// - Call the [RtcEngine.registerLocalUserAccount] method to create a user account, and then the [RtcEngine.joinChannelWithUserAccount] method to join the channel.
  /// - Call the [RtcEngine.joinChannelWithUserAccount] method to join the channel.
  /// The difference between the two is that for the former, the time elapsed between calling the [RtcEngine.joinChannelWithUserAccount] method and joining the channel is shorter than the latter.
  ///
  /// **Note**
  /// - Ensure that you set the [userAccount] parameter. Otherwise, this method does not take effect.
  /// - Ensure that the value of the userAccount parameter is unique in the channel.
  /// - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
  ///
  /// **Parameter** [appId] The App ID of your project.
  ///
  /// **Parameter** [userAccount] The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "\[", "\]", "^", "_", " {", "}", "|", "~", ",".
  Future<void> registerLocalUserAccount(String appId, String userAccount);

  /// Joins the channel with a user account.
  ///
  /// After the user successfully joins the channel, the SDK triggers the following callbacks:
  /// - The local client: [RtcEngineEventHandler.localUserRegistered] and [RtcEngineEventHandler.joinChannelSuccess].
  /// - The remote client: [RtcEngineEventHandler.userJoined] and [RtcEngineEventHandler.userInfoUpdated], if the user joining the channel is in the [ChannelProfile.Communication] profile, or is a [ClientRole.Broadcaster] in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Note**
  /// - To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the uid of the user is set to the same parameter type.
  ///
  /// **Parameter** [token] The token generated at your server. Set it as the token generated at your server. For details, see [Get a token](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms#generatetoken).
  ///
  /// **Parameter** [channelName] The channel name. The maximum length of this parameter is 64 bytes. Supported character scopes are:
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "\[", "\]", "^", "_", " {", "}", "|", "~", ",".
  ///
  /// **Parameter** [userAccount] The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null.
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "\[", "\]", "^", "_", " {", "}", "|", "~", ",".
  ///
  /// **Parameter** [options] The channel media options: [ChannelMediaOptions].
  Future<void> joinChannelWithUserAccount(
      String? token, String channelName, String userAccount,
      [ChannelMediaOptions? options]);

  /// Gets the user information by passing in the user account.
  ///
  /// After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object ([UserInfo]), and triggers the [RtcEngineEventHandler.userInfoUpdated] callback on the local client.
  ///
  /// After receiving the [RtcEngineEventHandler.userInfoUpdated] callback, you can call this method to get the user ID of the remote user from the [UserInfo] object by passing in the user account.
  ///
  /// **Parameter** [userAccount] The user account of the user. Ensure that you set this parameter.
  ///
  /// **Returns**
  /// - [UserInfo], if this method call succeeds.
  /// - Error code, if this method call fails.
  ///   - [ErrorCode.InvalidArgument]
  ///   - [ErrorCode.NotReady]
  ///   - [ErrorCode.Refused]
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// Gets the user information by passing in the user ID.
  ///
  /// After a remote user joins the channel, the SDK gets the user ID and user account of the remote user, caches them in a mapping table object ([UserInfo]), and triggers the [RtcEngineEventHandler.userInfoUpdated] callback on the local client.
  ///
  /// After receiving the [RtcEngineEventHandler.userInfoUpdated] callback, you can call this method to get the user ID of the remote user from the [UserInfo] object by passing in the user account.
  ///
  /// **Parameter** [uid] The user ID of the user. Ensure that you set this parameter.
  ///
  /// **Returns**
  /// - [UserInfo], if this method call succeeds.
  /// - Error code, if this method call fails.
  ///   - [ErrorCode.InvalidArgument]
  ///   - [ErrorCode.NotReady]
  ///   - [ErrorCode.Refused]
  Future<UserInfo> getUserInfoByUid(int uid);
}

/// @nodoc
mixin RtcAudioInterface {
  /// Enables the audio module.
  ///
  /// The audio module is enabled by default.
  ///
  /// **Note**
  /// - This method affects the audio module and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method enables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio engine modules separately:
  ///   - [RtcEngine.enableLocalAudio]: Whether to enable the microphone to create the local audio stream.
  ///   - [RtcEngine.muteLocalAudioStream]: Whether to publish the local audio stream.
  ///   - [RtcEngine.muteRemoteAudioStream]: Whether to subscribe to and play the remote audio stream.
  ///   - [RtcEngine.muteAllRemoteAudioStreams]: Whether to subscribe to and play all remote audio streams.
  Future<void> enableAudio();

  /// Disables the audio module.
  ///
  /// **Note**
  /// - This method affects the audio module and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method disables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio engine module separately:
  ///   - [RtcEngine.enableLocalAudio]: Whether to enable the microphone to create the local audio stream.
  ///   - [RtcEngine.muteLocalAudioStream]: Whether to publish the local audio stream.
  ///   - [RtcEngine.muteRemoteAudioStream]: Whether to subscribe to and play the remote audio stream.
  ///   - [RtcEngine.muteAllRemoteAudioStreams]: Whether to subscribe to and play all remote audio streams.
  Future<void> disableAudio();

  /// Sets the audio parameters and application scenarios.
  ///
  /// **Note**
  /// - You must call this method before calling the joinChannel method.
  /// See [RtcEngine.joinChannel]
  /// - In the Communication and [ChannelProfile.LiveBroadcasting] profiles, the bitrates may be different from your settings due to network self-adaptation.
  /// - In scenarios requiring high-quality audio, we recommend setting profile as [AudioScenario.ShowRoom] and scenario as [AudioScenario.GameStreaming]. For example, for music education scenarios.
  ///
  /// **Parameter** [profile] Sets the sample rate, bitrate, encoding mode, and the number of channels. See [AudioProfile].
  ///
  /// **Parameter** [scenario] Sets the audio application scenarios. Under different audio scenarios, the device uses different volume tracks, i.e. either the in-call volume or the media volume. See [AudioScenario].
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario);

  /// Adjusts the recording volume.
  ///
  /// **Note**
  /// - To avoid echoes and improve call quality, Agora recommends setting the value of volume between 0 and 100. If you need to set the value higher than 100, contact support@agora.io first.
  ///
  /// **Parameter** [volume] Recording volume. The value ranges between 0 and 400:
  /// - 0: Mute.
  /// - 100: Original volume.
  /// - 400: (Maximum) Four times the original volume with signal-clipping protection.
  Future<void> adjustRecordingSignalVolume(int volume);

  /// Adjusts the playback volume of a specified remote user.
  ///
  /// You can call this method as many times as necessary to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.
  ///
  /// **Note**
  /// - Call this method after joining a channel.
  /// - The playback volume here refers to the mixed volume of a specified remote user.
  /// - This method can only adjust the playback volume of one specified remote user at a time. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
  ///
  /// **Parameter** [uid] ID of the remote user.
  ///
  /// **Parameter** [volume] The playback volume of the specified remote user. The value ranges from 0 to 100:
  /// - 0: Mute.
  /// - 100: The original volume.
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  /// Adjusts the playback volume of all remote users.
  ///
  /// **Note**
  /// - This method adjusts the playback volume which is mixed volume of all remote users.
  /// - To mute the local audio playback, call both [RtcEngine.adjustPlaybackSignalVolume] and [RtcEngine.adjustAudioMixingVolume], and set volume as 0.
  /// - To avoid echoes and improve call quality, Agora recommends setting the value of volume between 0 and 100. If you need to set the value higher than 100, contact support@agora.io first.
  ///
  /// **Parameter** [volume] The playback volume of all remote users. The value ranges from 0 to 400:
  /// - 0: Mute.
  /// - 100: The original volume.
  /// - 400: (Maximum) Four times the original volume with signal clipping protection.
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// Enables/Disables the local audio capture.
  ///
  /// The audio function is enabled by default. This method disables/re-enables the local audio function, that is, to stop or restart local audio capture and processing.
  ///
  /// This method does not affect receiving or playing the remote audio streams, and `enableLocalAudio(false)` is applicable to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.
  ///
  /// The SDK triggers the [RtcEngineEventHandler.microphoneEnabled] callback once the local audio function is disabled or re-enabled.
  ///
  /// **Note**
  /// - This method is different from the [RtcEngine.muteLocalAudioStream] method:
  ///   - [RtcEngine.enableLocalAudio]: Disables/Re-enables the local audio capture and processing. If you disable or re-enable local audio recording using the [RtcEngine.enableLocalAudio] method, the local user may hear a pause in the remote audio playback.
  ///   - [RtcEngine.muteLocalAudioStream]: Stops/Continues sending the local audio streams.
  ///
  /// **Parameter** [enabled] Sets whether to disable/re-enable the local audio function:
  /// - `true`: (Default) Re-enable the local audio function, that is, to start local audio capture and processing.
  /// - `false`: Disable the local audio function, that is, to stop local audio capture and processing.
  Future<void> enableLocalAudio(bool enabled);

  /// Stops/Resumes sending the local audio stream.
  ///
  /// A successful [RtcEngine.muteLocalAudioStream] method call triggers the [RtcEngineEventHandler.userMuteAudio] callback on the remote client.
  ///
  /// **Note**
  /// - When muted is set as true, this method does not disable the microphone and thus does not affect any ongoing recording.
  /// - If you call [RtcEngine.setChannelProfile] after this method, the SDK resets whether or not to mute the local audio according to the channel profile and user role. Therefore, we recommend calling this method after the [RtcEngine.setChannelProfile] method.
  ///
  /// **Parameter** [muted] Sets whether to send/stop sending the local audio stream:
  /// - `true`: Stop sending the local audio stream.
  /// - `false`: (Default) Send the local audio stream.
  Future<void> muteLocalAudioStream(bool muted);

  /// Stops/Resumes receiving a specified audio stream.
  ///
  /// **Note**
  /// - If you called the [RtcEngine.muteAllRemoteAudioStreams] method and set muted as true to stop receiving all remote video streams, ensure that the [RtcEngine.muteAllRemoteAudioStreams] method is called and set muted as false before calling this method. The [RtcEngine.muteAllRemoteAudioStreams] method sets all remote audio streams, while the [RtcEngine.muteRemoteAudioStream] method sets a specified remote user's audio stream.
  ///
  /// **Parameter** [uid] ID of the specified remote user.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving the specified remote user's audio stream:
  /// - `true`: Stop receiving the specified remote user’s audio stream.
  /// - `false`: (Default) Receive the specified remote user’s audio stream.
  ///
  /// **Note**
  /// - Call this method after joining a channel.
  /// - See recommended settings in *Set the Subscribing State*.
  Future<void> muteRemoteAudioStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote audio streams.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving all remote audio streams:
  /// - `true`: Stop receiving all remote audio streams.
  /// - `false`: (Default) Receive all remote audio streams.
  Future<void> muteAllRemoteAudioStreams(bool muted);

  /// Sets whether to receive all remote audio streams by default.
  ///
  /// You can call this method either before or after joining a channel. If you call [RtcEngine.setDefaultMuteAllRemoteAudioStreams] (true) after joining a channel, you will not receive the audio streams of any subsequent user.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated from v3.3.1.
  ///
  /// **Note**
  /// - If you want to resume receiving audio streams, call [RtcEngine.muteRemoteAudioStream] (false), and specify the ID of the remote user that you want to subscribe to. To resume audio streams of multiple users, call [RtcEngine.muteRemoteAudioStream] as many times. Calling [RtcEngine.setDefaultMuteAllRemoteAudioStreams] (false) resumes receiving audio streams of the subsequent users only.
  ///
  /// **Parameter** [muted] Sets whether or not to receive/stop receiving the remote audio streams by default:
  /// - `true`: Stop receiving any audio stream by default.
  /// - `false`: (Default) Receive all remote audio streams by default.
  @deprecated
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);

  /// Enables the [RtcEngineEventHandler.audioVolumeIndication] callback at a set time interval to report on which users are speaking and the speakers' volume.
  ///
  /// Once this method is enabled, the SDK returns the volume indication in the [RtcEngineEventHandler.audioVolumeIndication] callback at the set time interval, regardless of whether any user is speaking in the channel.
  ///
  /// **Parameter** [interval] Sets the time interval between two consecutive volume indications:
  /// - ≤ 0: Disables the volume indication.
  /// - > 0: Time interval (ms) between two consecutive volume indications. We recommend setting interval ≥ 200 ms.
  ///
  /// **Parameter** [smooth] The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The greater the value, the more sensitive the indicator. The recommended value is 3.
  ///
  /// **Parameter** [report_vad]
  /// - `true`: Enable the voice activity detection of the local user. Once it is enabled, the vad parameter of the [RtcEngineEventHandler.audioVolumeIndication] callback reports the voice activity status of the local user.
  /// - `false`: (Default) Disable the voice activity detection of the local user. Once it is disabled, the vad parameter of the [RtcEngineEventHandler.audioVolumeIndication] callback does not report the voice activity status of the local user, except for scenarios where the engine automatically detects the voice activity of the local user.
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad);
}

/// @nodoc
mixin RtcVideoInterface {
  /// Enables the video module.
  ///
  /// You can call this method either before joining a channel or during a call. If you call this method before joining a channel, the service starts in the video mode. If you call this method during an audio call, the audio mode switches to the video mode.
  ///
  /// A successful enableVideo method call triggers the [RtcEngineEventHandler.userEnableVideo] (true) callback on the remote client.
  ///
  /// To disable the video, call the [RtcEngine.disableVideo] method.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the video engine modules separately:
  ///   - [RtcEngine.enableLocalVideo]: Whether to enable the camera to create the local video stream.
  ///   - [RtcEngine.muteLocalVideoStream]: Whether to publish the local video stream.
  ///   - [RtcEngine.muteRemoteVideoStream]: Whether to subscribe to and play the remote video stream.
  ///   - [RtcEngine.muteAllRemoteVideoStreams]: Whether to subscribe to and play all remote video streams.
  Future<void> enableVideo();

  /// Disables the video module.
  ///
  /// You can call this method before joining a channel or during a call. If you call this method before joining a channel, the service starts in audio mode. If you call this method during a video call, the video mode switches to the audio mode.
  /// - A successful disableVideo method call triggers the [RtcEngineEventHandler.userEnableVideo] (false) callback on the remote client.
  /// - To enable the video mode, call the [RtcEngine.enableVideo] method.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling the [RtcEngine.leaveChannel] method. You can call this method either before or after joining a channel.
  /// - This method resets the internal engine and takes some time to take effect. We recommend using the following API methods to control the video engine modules separately:
  ///   - [RtcEngine.enableLocalVideo]: Whether to enable the camera to create the local video stream.
  ///   - [RtcEngine.muteLocalVideoStream]: Whether to publish the local video stream.
  ///   - [RtcEngine.muteRemoteVideoStream]: Whether to subscribe to and play the remote video stream.
  ///   - [RtcEngine.muteAllRemoteVideoStreams]: Whether to subscribe to and play all remote video streams.
  Future<void> disableVideo();

  /// Sets the video encoder configuration.
  ///
  /// Each video encoder configuration corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation. The parameters specified in this method are the maximum values under ideal network conditions. If the video engine cannot render the video using the specified parameters due to poor network conditions, the parameters further down the list are considered until a successful configuration is found.
  /// If you do not set the video encoder configuration after joining the channel, you can call this method before calling the [RtcEngine.enableVideo] method to reduce the render time of the first video frame.
  ///
  /// **Parameter** [config] The local video encoder configuration. See [VideoEncoderConfiguration].
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// Starts the local video preview before joining a channel.
  ///
  /// Before calling this method, you must:
  /// - Create the RtcLocalView.
  ///   - (Android only) See [TextureView] and [SurfaceView].
  ///   - (iOS only) See [UIView](https://developer.apple.com/documentation/uikit/uiview).
  /// - Call the [RtcEngine.enableVideo] method to enable the video.
  ///
  /// **Note**
  /// - By default, the local preview enables the mirror mode.
  /// - Once you call this method to start the local video preview, if you leave the channel by calling the [RtcEngine.leaveChannel] method, the local video preview remains until you call the [RtcEngine.stopPreview] method to disable it.
  Future<void> startPreview();

  /// Stops the local video preview and the video.
  ///
  /// Call this method before joining a channel.
  Future<void> stopPreview();

  /// Disables/Re-enables the local video capture.
  ///
  /// This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.
  ///
  /// After you call the [RtcEngine.enableVideo] method, the local video capturer is enabled by default. You can call [RtcEngine.enableVideo] (false) to disable the local video capturer. If you want to re-enable it, call [RtcEngine.enableVideo] (true).
  ///
  /// After the local video capturer is successfully disabled or re-enabled, the SDK triggers the [RtcEngineEventHandler.userEnableLocalVideo] callback on the remote client.
  ///
  /// **Note**
  /// - This method affects the internal engine and can be called after calling  the [RtcEngine.leaveChannel] method.
  ///
  /// **Parameter** [enabled] Sets whether to disable/re-enable the local video, including the capturer, renderer, and sender:
  /// - `true`: (Default) Re-enable the local video.
  /// - `false`: Disable the local video. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of other remote users. When you set enabled as false, this method does not require a local camera.
  Future<void> enableLocalVideo(bool enabled);

  /// Stops/Resumes sending the local video stream.
  ///
  /// A successful `muteLocalVideoStream` method call triggers the [RtcEngineEventHandler.userMuteVideo] callback on the remote client.
  ///
  /// **Note**
  /// - When you set muted as true, this method does not disable the camera and thus does not affect the retrieval of the local video streams. This method responds faster than calling the [RtcEngine.enableLocalVideo] method and set muted as false, which controls sending the local video stream.
  /// - If you call [RtcEngine.setChannelProfile] after this method, the SDK resets whether or not to mute the local video according to the channel profile and user role. Therefore, we recommend calling this method after the [RtcEngine.setChannelProfile] method.
  ///
  /// **Parameter** [muted] Sets whether to send/stop sending the local video stream:
  /// - `true`: Stop sending the local video stream.
  /// - `false`: (Default) Send the local video stream.
  Future<void> muteLocalVideoStream(bool muted);

  /// Stops/Resumes receiving a specified remote user's video stream.
  ///
  /// **Note**
  /// - If you call the [RtcEngine.muteAllRemoteVideoStreams] method and set set muted as true to stop receiving all remote video streams, ensure that the [RtcEngine.muteAllRemoteVideoStreams] method is called and set muted as false before calling this method. The [RtcEngine.muteAllRemoteVideoStreams] method sets all remote streams, while this method sets a specified remote user's stream.
  ///
  /// **Parameter** [uid] User ID of the specified remote user.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving a specified remote user's video stream:
  /// - `true`: Stop receiving a specified remote user’s video stream.
  /// - `false`: (Default) Receive a specified remote user’s video stream.
  Future<void> muteRemoteVideoStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote video streams.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving all remote video streams:
  /// - `true`: Stop receiving all remote video streams.
  /// - `false`: (Default) Receive all remote video streams.
  Future<void> muteAllRemoteVideoStreams(bool muted);

  /// Sets whether to receive all remote video streams by default.
  ///
  /// You can call this method either before or after joining a channel. If you call `setDefaultMuteAllRemoteVideoStreams`(true) after joining a channel, you will not receive the video stream of any subsequent user.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated from v3.3.1.
  ///
  /// **Note**
  /// - If you want to resume receiving video streams, call [RtcEngine.muteRemoteVideoStream] (false), and specify the ID of the remote user that you want to subscribe to. To resume receiving video streams of multiple users, call [RtcEngine.muteRemoteVideoStream] as many times. Calling `setDefaultMuteAllRemoteVideoStreams`(false) resumes receiving video streams of the subsequent users only.
  ///
  /// **Parameter** [muted] Sets whether to receive/stop receiving all remote video streams by default:
  /// - `true`: Stop receiving any remote video stream by default.
  /// - `false`: (Default) Receive all remote video streams by default.
  @deprecated
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);

  /// Enables/Disables image enhancement and sets the options.
  ///
  /// **Note**
  /// - Call this method after calling [RtcEngine.enableVideo].
  /// - This method supports both Android and iOS. For Android, this method applies to Android 4.4 or later.
  ///
  /// **Parameter** [enabled] Sets whether or not to enable image enhancement:
  /// - enables image enhancement.
  /// - disables image enhancement.
  ///
  /// **Parameter** [options] The image enhancement options. See [BeautyOptions].
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options);

  ///  @nodoc
  Future<void> enableRemoteSuperResolution(int uid, bool enable);
}

/// @nodoc
mixin RtcAudioMixingInterface {
  /// Starts playing and mixing the music file.
  ///
  /// This method mixes the specified local or online audio file with the audio captured by the microphone, or replaces the audio captured by the microphone with the specified local or remote audio file. You can choose whether the other user can hear the local audio playback and specify the number of playback loops.
  ///
  /// After successfully playing the music file, the SDK triggers [RtcEngineEventHandler.audioMixingStateChanged] ([AudioMixingStateCode.Playing]).
  /// After finishing playing the music file, the SDK triggers the [RtcEngineEventHandler.audioMixingStateChanged] ([AudioMixingStateCode.Stopped]).
  ///
  /// **Note**
  /// - This method supports both Android and iOS. To use this method in Android, ensure that the Android device is v4.2 or later, and the API version is v16 or later.
  /// - Call this method when you are in the channel, otherwise it may cause issues.
  /// - If you want to play an online music file, ensure that the time interval between calling this method is more than 100 ms, or the [AudioMixingReason.TooFrequentCall] error occurs.
  /// - If you want to play an online music file, Agora does not recommend using the redirected URL address. Some Android devices may fail to open a redirected URL address.
  /// - If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns [AudioMixingReason.CanNotOpen].
  /// - If you call this method on an emulator, only the MP3 file format is supported.
  ///
  /// **Parameter** [filePath] The file path, including the filename extensions.
  /// - Android: To access an online file, Agora supports using a URL address; to access a local file, Agora supports using a URI address, an absolute path, or a path that starts with /assets/. Supported audio formats: mp3, mp4, m4a, aac, 3gp, mkv and wav. For details, see [Supported Media Formats](https://developer.android.com/guide/topics/media/media-formats).
  ///   **Note**: You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: "content://com.android.providers.media.documents/document/audio%3A14441".
  /// - iOS: To access an online file, Agora supports using a URL address; to access a local file, Agora supports using an absolute path. For example: /var/mobile/Containers/Data/audio.mp4.
  ///   Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. For details, see [Best Practices for iOS Audio](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW28).
  ///
  /// **Parameter** [loopback] Whether to only play the music file on the local client:
  /// - `true`: Only play music files on the local client so that only the local user can hear the music.
  /// - `false`: Publish music files to remote clients so that both the local user and remote users can hear the music.
  ///
  /// **Parameter** [replace] Whether to replace the audio captured by the microphone with a music file:
  /// - `true`: Replace. Users can only hear music.
  /// - `false`: Do not replace. Users can hear both music and audio captured by the microphone.
  ///
  /// **Parameter** [cycle] The number of times the music file plays.
  /// - &le; 0: The number of playback times. For example, 0 means that the SDK does not play the music file, while 1 means that the SDK plays the music file once.
  /// - -1: Play the music in an indefinite loop.
  ///
  /// **Parameter** [startPos] The playback position (ms) of the music file.
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle,
      [int? startPos]);

  /// Stops playing or mixing the music file.
  ///
  /// Call this method when you are in a channel.
  Future<void> stopAudioMixing();

  /// Pauses playing and mixing the music file.
  ///
  /// Call this method when you are in a channel.
  Future<void> pauseAudioMixing();

  /// Resumes playing and mixing the music file.
  ///
  /// Call this method when you are in a channel.
  Future<void> resumeAudioMixing();

  /// Adjusts the volume of audio mixing.
  ///
  /// **Note**
  /// - Calling this method does not affect the volume of the audio effect file playback invoked by the [RtcEngine.playEffect] method.
  /// - Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Parameter** [volume] Audio mixing volume. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingVolume(int volume);

  /// Adjusts the volume of audio mixing for local playback.
  ///
  /// **Note**
  ///
  /// Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Parameter** [volume] Audio mixing volume for local playback. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// Adjusts the volume of audio mixing for publishing (sending to other users).
  ///
  /// **Note**
  ///
  /// Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Parameter** [volume] Audio mixing volume for publishing. The value ranges between 0 and 100 (default).
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// Gets the audio mixing volume for local playback.
  ///
  /// This method helps troubleshoot audio volume related issues.
  ///
  /// **Note**
  ///
  /// Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Returns**
  /// - The audio mixing volume for local playback, if the method call is successful. The value range is [0,100].
  /// - Error code, if the method call fails.
  Future<int?> getAudioMixingPlayoutVolume();

  /// Gets the audio mixing volume for publishing.
  ///
  /// This method helps troubleshoot audio volume related issues.
  ///
  /// **Note**
  ///
  /// Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Returns**
  /// - The audio mixing volume for publishing, if the method call is successful. The value range is [0,100].
  /// - Error code, if the method call fails.
  Future<int?> getAudioMixingPublishVolume();

  /// Gets the total duration (ms) of the music file.
  ///
  /// **Note**
  /// - Call this method after joining a channel.
  ///
  /// **Parameter** [filePath] The file path, including the filename extensions.
  /// - Android: Agora supports using a URI address, an absolute path, or a path that starts with /assets/. Supported audio formats: mp3, mp4, m4a, aac, 3gp, mkv and wav. For details, see [Supported Media Formats](https://developer.android.com/guide/topics/media/media-formats).
  ///   **Note**: You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: "content://com.android.providers.media.documents/document/audio%3A14441".
  /// - iOS: Agora supports using an absolute path. For example: /var/mobile/Containers/Data/audio.mp4.
  ///   Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. For details, see [Best Practices for iOS Audio](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW28).
  ///
  /// **Returns**
  /// - The total duration (ms) of the specified music file, if this method call succeeds.
  /// - Error code, if this method call fails.
  Future<int?> getAudioMixingDuration([String? filePath]);

  /// Gets the playback position (ms) of the music file.
  ///
  /// Call this method when you are in a channel.
  ///
  /// **Note**
  ///
  /// Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Returns**
  /// - The current playback position of the audio mixing file, if this method call is successful.
  /// - Error code, if this method call fails.
  Future<int?> getAudioMixingCurrentPosition();

  /// Sets the playback position (ms) of the music file to a different starting position (the default plays from the beginning).
  ///
  /// **Note**
  ///
  /// Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Parameter** [pos] The playback starting position (ms) of the audio mixing file.
  Future<void> setAudioMixingPosition(int pos);

  /// Sets the pitch of the local music file.
  ///
  /// When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only.
  ///
  /// **Note**
  /// - Call this method after calling [RtcEngine.startAudioMixing].
  /// - Call this method after calling [startAudioMixing] and receiving the `audioMixingStateChanged(Playing)` callback.
  ///
  /// **Parameter** [pitch] Sets the pitch of the local music file by chromatic scale. The default value is 0, which means keep the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.
  Future<void> setAudioMixingPitch(int pitch);
}

/// @nodoc
mixin RtcAudioEffectInterface {
  /// Gets the volume of the audio effects.
  ///
  /// The value ranges between 0.0 and 100.0.
  ///
  /// **Returns**
  /// - Volume of the audio effects, if this method call succeeds.
  /// - Error code, if this method call fails.
  Future<double?> getEffectsVolume();

  /// Sets the volume of the audio effects.
  ///
  /// **Parameter** [volume] Volume of the audio effects. The value ranges between 0.0 and 100.0 (default).
  Future<void> setEffectsVolume(double volume);

  /// Sets the volume of a specified audio effect.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// **Parameter** [volume] Volume of the audio effect. The value ranges between 0.0 and 100.0 (default).
  Future<void> setVolumeOfEffect(int soundId, double volume);

  /// Plays a specified local or online audio effect file.
  ///
  /// With this method, you can set the loop count, pitch, pan, and gain of the audio effect file and whether the remote user can hear the audio effect.
  ///
  /// To play multiple audio effect files simultaneously, call this method multiple times with different soundIds and filePaths. We recommend playing no more than three audio effect files at the same time.
  ///
  /// After completing playing an audio effect file, the SDK triggers the [RtcEngineEventHandler.audioEffectFinished] callback.
  ///
  /// **Note**
  /// - Call this method joining a channel.
  ///
  /// **Parameter** [soundId] Audio effect ID. The ID of each audio effect file is unique. If you preloaded the audio effect into the memory through the [RtcEngine.preloadEffect] method, ensure that this parameter is set to the same value as in [RtcEngine.preloadEffect].
  ///
  /// **Parameter** [filePath] The file path, including the filename extensions.
  /// - Android: To access an online file, Agora supports using a URL address; to access a local file, Agora supports using a URI address, an absolute path, or a path that starts with /assets/. Supported audio formats: mp3, mp4, m4a, aac, 3gp, mkv and wav. For details, see [Supported Media Formats](https://developer.android.com/guide/topics/media/media-formats).
  ///   **Note**: You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: "content://com.android.providers.media.documents/document/audio%3A14441".
  /// - iOS: To access an online file, Agora supports using a URL address; to access a local file, Agora supports using an absolute path. For example: /var/mobile/Containers/Data/audio.mp4.
  ///   Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. For details, see [Best Practices for iOS Audio](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW28).
  ///
  /// **Parameter** [loopCount] The number of times the audio effect loops:
  /// - &ge; 0: The number of loops. For example, `1` means loop one time, which means play the audio effect two times in total.
  /// - -1: Play the audio effect in an indefinite loop.
  ///
  /// **Parameter** [pitch] The pitch of the audio effect. The range is [0.5,2.0]. The default value is 1.0, which means the original pitch. The lower the value, the lower the pitch.
  ///
  /// **Parameter** [pan] The spatial position of the audio effect. The range is [-1.0,1.0]. For example:
  /// - -1.0: The audio effect occurs on the left.
  /// - 0.0: The audio effect occurs in the front.
  /// - 1.0: The audio effect occurs on the right.
  ///
  /// **Parameter** [gain] The volume of the audio effect. The range is [0.0,100.0]. The default value is 100.0, which means the original volume. The smaller the value, the less the gain.
  ///
  /// **Parameter** [publish] Whether to publish the audio effect to the remote users:
  /// - `true`: Publish. Both the local user and remote users can hear the audio effect.
  /// - `false`: Do not publish. Only the local user can hear the audio effect.
  ///
  /// **Parameter** [startPos] The playback position (ms) of the audio effect file.
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish,
      [int? startPos]);

  /// Sets the playback position of an audio effect file.
  ///
  /// After a successful setting, the local audio effect file starts playing at the specified position.
  ///
  /// **Note**
  /// - Call this method after [RtcEngine.playEffect].
  ///
  /// **Parameter** [soundId] Audio effect ID. Ensure that this parameter is set to the same value as in `playEffect`.
  ///
  /// **Parameter** [pos] The playback position (ms) of the audio effect file.
  Future<void> setEffectPosition(int soundId, int pos);

  /// Gets the duration of the audio effect file.
  ///
  /// **Note**
  /// Call this method after [RtcEngine.playEffect].
  ///
  /// **Parameter** [filePath] The file path, including the filename extensions.
  /// - Android: Agora supports using a URI address, an absolute path, or a path that starts with /assets/. Supported audio formats: mp3, mp4, m4a, aac, 3gp, mkv and wav. For details, see [Supported Media Formats](https://developer.android.com/guide/topics/media/media-formats).
  ///   **Note**: You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: "content://com.android.providers.media.documents/document/audio%3A14441".
  /// - iOS: Agora supports using an absolute path. For example: /var/mobile/Containers/Data/audio.mp4.
  ///   Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. For details, see [Best Practices for iOS Audio](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW28).
  ///
  /// **Returns**
  /// - The total duration (ms) of the specified audio file, if this method call succeeds.
  /// - Error code, if this method call fails.
  ///   - -22(`ERR_RESOURCE_LIMITED`): Cannot find the audio effect file. Please set a valid `filePath`.
  Future<int?> getEffectDuration(String filePath);

  /// Gets the playback postion of the audio effect file.
  ///
  /// **Note**
  /// Call this method after [RtcEngine.playEffect].
  ///
  /// **Parameter** [soundId] Audio effect ID. Ensure that this parameter is set to the same value as in `playEffect`.
  ///
  /// **Returns**
  /// - The playback position (ms) of the specified audio effect file, if this method call succeeds.
  /// - Error code, if this method call fails.
  ///   - -22(`ERR_RESOURCE_LIMITED`):  Cannot find the audio effect file. Please set a valid `soundId`.
  Future<int?> getEffectCurrentPosition(int soundId);

  /// Stops playing a specified audio effect.
  ///
  /// **Note**
  /// If you preloaded the audio effect into the memory through the [RtcEngine.preloadEffect] method, ensure that the `soundID` value is set to the same value as in the [RtcEngine.preloadEffect] method.
  ///
  /// **Parameter** [soundId] ID of the specified audio effect. Each audio effect has a unique ID.
  Future<void> stopEffect(int soundId);

  /// Stops playing all audio effects.
  Future<void> stopAllEffects();

  /// Preloads a specified audio effect file into the memory.
  ///
  /// Supported audio formats: mp3, aac, m4a, 3gp, wav.
  ///
  /// **Note**
  /// - This method does not support online audio effect files.
  /// - To ensure smooth communication, limit the size of the audio effect file. We recommend using this method to preload the audio effect before calling the [RtcEngine.joinChannel] method.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  ///
  /// **Parameter** [filePath] The file path, including the filename extensions.
  /// - Android: Agora supports using a URI address, an absolute path, or a path that starts with /assets/. Supported audio formats: mp3, mp4, m4a, aac, 3gp, mkv and wav. For details, see [Supported Media Formats](https://developer.android.com/guide/topics/media/media-formats).
  ///   **Note**: You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: "content://com.android.providers.media.documents/document/audio%3A14441".
  /// - iOS: Agora supports using an absolute path. For example: /var/mobile/Containers/Data/audio.mp4.
  ///   Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. For details, see [Best Practices for iOS Audio](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html#//apple_ref/doc/uid/TP40009767-CH2-SW28).
  Future<void> preloadEffect(int soundId, String filePath);

  /// Releases a specified preloaded audio effect from the memory.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  Future<void> unloadEffect(int soundId);

  /// Pauses a specified audio effect.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  Future<void> pauseEffect(int soundId);

  /// Pauses all audio effects.
  Future<void> pauseAllEffects();

  /// Resumes playing a specified audio effect.
  ///
  /// **Parameter** [soundId] ID of the audio effect. Each audio effect has a unique ID.
  Future<void> resumeEffect(int soundId);

  /// Resumes playing all audio effects.
  Future<void> resumeAllEffects();

  /// Sets the operational permission of the SDK on the audio session. (iOS only)
  ///
  /// The SDK and the app can both configure the audio session by default. If you need to only use the app to configure the audio session, this method restricts the operational permission of the SDK on the audio session.
  ///
  /// You can call this method either before or after joining a channel. Once you call this method to restrict the operational permission of the SDK on the audio session, the restriction takes effect when the SDK needs to change the audio session.
  ///
  /// **Parameter** [restriction] The operational permission of the SDK on the audio session. See [AudioSessionOperationRestriction]. This parameter is in bit mask format, and each bit corresponds to a permission.
  ///
  /// **Note**
  /// This method does not restrict the operational permission of the app on the audio session.
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);
}

/// @nodoc
mixin RtcVoiceChangerInterface {
  /// Sets the local voice changer option.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated since v3.2.1. Use [RtcEngine.setAudioEffectPreset] or [RtcEngine.setVoiceBeautifierPreset] instead.
  ///
  /// **Note**
  /// - Do not use this method together with [RtcEngine.setLocalVoiceReverbPreset], or the method called earlier does not take effect.
  ///
  /// **Parameter** [voiceChanger] The local voice changer option. See [AudioVoiceChanger].
  @deprecated
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger);

  /// Sets the preset local voice reverberation effect.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated since v3.2.1. Use [RtcEngine.setAudioEffectPreset] or [RtcEngine.setVoiceBeautifierPreset] instead.
  ///
  /// **Note**
  /// - Do not use this method together with [RtcEngine.setLocalVoiceReverb].
  /// - Do not use this method together with [RtcEngine.setLocalVoiceChanger], or the method called eariler does not take effect.
  ///
  /// **Parameter** [preset] The local voice reverberation preset. See [AudioReverbPreset].
  @deprecated
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset);

  /// Changes the voice pitch of the local speaker.
  ///
  /// **Parameter** [pitch] Sets the voice pitch. The value ranges between 0.5 and 2.0. The lower the value, the lower the voice pitch. The default value is 1.0 (no change to the local voice pitch).
  Future<void> setLocalVoicePitch(double pitch);

  /// Sets the local voice equalization effect.
  ///
  /// **Parameter** [bandFrequency] Sets the band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 500, 1k, 2k, 4k, 8k, and 16k Hz.
  /// See [AudioEqualizationBandFrequency].
  ///
  /// **Parameter** [bandGain] Sets the gain of each band (dB). The value ranges between -15 and 15. The default value is 0.
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain);

  /// Sets the local voice reverberation.
  ///
  /// **Note**
  /// - Adds the [RtcEngine.setLocalVoiceReverbPreset] method, a more user-friendly method for setting the local voice reverberation. You can use this method to set the local reverberation effect, such as Popular, R&B, Rock, Hip-hop, and more.
  ///
  /// **Parameter** [reverbKey] Sets the reverberation key. This method contains five reverberation keys. For details, see the description of each value in [AudioReverbType].
  ///
  /// **Parameter** [value] Sets the local voice reverberation value.
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value);

  /// Sets an SDK preset audio effect.
  ///
  /// Since v3.2.1
  ///
  /// Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect does not change the gender characteristics of the original voice. After setting an audio effect, all users in the channel can hear the effect.
  ///
  /// You can set different audio effects for different scenarios. See *Set the Voice Beautifier and Audio Effects*.
  ///
  /// To achieve better audio effect quality, Agora recommends calling [RtcEngine.setAudioProfile] and setting the `scenario` parameter to `GameStreaming(3)` before calling this method.
  ///
  ///**Note**
  /// - You can call this method either before or after joining a channel.
  /// - Do not set the profile parameter of [RtcEngine.setAudioProfile] to `SpeechStandard(1)`; otherwise, this method call fails.
  /// - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// - If you call this method and set the preset parameter to enumerators except `RoomAcoustics3DVoice` or `PitchCorrection`, do not call [RtcEngine.setAudioEffectParameters]; otherwise, [RtcEngine.setAudioEffectParameters] overrides this method.
  /// - After calling this method, Agora recommends not calling the following methods, because they can override `setAudioEffectPreset`:
  ///     - [RtcEngine.setVoiceBeautifierPreset]
  ///     - [RtcEngine.setLocalVoiceReverbPreset]
  ///     - [RtcEngine.setLocalVoiceChanger]
  ///     - [RtcEngine.setLocalVoicePitch]
  ///     - [RtcEngine.setLocalVoiceEqualization]
  ///     - [RtcEngine.setLocalVoiceReverb]
  ///
  /// **Parameter** [preset] The options for SDK preset audio effects. See [AudioEffectPreset].
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  /// Sets an SDK preset voice beautifier effect.
  ///
  /// Since v3.2.1
  ///
  /// Call this method to set an SDK preset voice beautifier effect for the local user who sends an audio stream. After setting a voice beautifier effect, all users in the channel can hear the effect.
  ///
  /// You can set different voice beautifier effects for different scenarios. See *Set the Voice Beautifier and Audio Effects*.
  ///
  /// To achieve better audio effect quality, Agora recommends calling [RtcEngine.setAudioProfile] and setting the `scenario` parameter to `GameStreaming(3)` and the `profile` parameter to `MusicHighQuality(4)` or `MusicHighQualityStereo(5)` before calling this method.
  ///
  /// **Note**
  /// - You can call this method either before or after joining a channel.
  /// - Do not set the profile parameter of `setAudioProfile` to `SpeechStandard(1)`; otherwise, this method call fails.
  /// - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// - After calling this method, Agora recommends not calling the following methods, because they can override `setVoiceBeautifierPreset`:
  ///   - [RtcEngine.setAudioEffectPreset]
  ///   - [RtcEngine.setAudioEffectParameters]
  ///   - [RtcEngine.setLocalVoiceReverbPreset]
  ///   - [RtcEngine.setLocalVoiceChanger]
  ///   - [RtcEngine.setLocalVoicePitch]
  ///   - [RtcEngine.setLocalVoiceEqualization]
  ///   - [RtcEngine.setLocalVoiceReverb]
  ///
  /// **Parameter** [preset] The options for SDK preset voice beautifier effects. See [VoiceBeautifierPreset].
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  ///  Sets an SDK preset voice conversion effect.
  ///
  /// Call this method to set an SDK preset voice conversion effect for the local user who sends an audio stream. After setting a voice conversion effect, all users in the channel can hear the effect.
  ///
  /// You can set different voice conversion effects for different scenarios. See *Set the Voice Effect*.
  ///
  /// To achieve better voice effect quality, Agora recommends calling [RtcEngine.setAudioProfile] and setting the profile parameter to `MusicHighQuality(4)` or `MusicHighQualityStereo(5)` and the scenario parameter to `GameStreaming(3)` before calling this method.
  ///
  /// **Parameter** [preset] The options for SDK preset voice conversion effects: [VoiceConversionPreset].
  ///
  /// **Note**
  ///
  /// - You can call this method either before or after joining a channel.
  /// - Do not set the profile parameter of [RtcEngine.setAudioProfile] to `SpeechStandard(1)`; otherwise, this method call does not take effect.
  /// - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// - After calling this method, Agora recommends not calling the following methods, because they can override `setVoiceConversionPreset`:
  ///   - [RtcEngine.setAudioEffectPreset]
  ///   - [RtcEngine.setAudioEffectParameters]
  ///   - [RtcEngine.setVoiceBeautifierPreset]
  ///   - [RtcEngine.setVoiceBeautifierParameters]
  ///   - [RtcEngine.setLocalVoiceReverbPreset]
  ///   - [RtcEngine.setLocalVoiceChanger]
  ///   - [RtcEngine.setLocalVoicePitch]
  ///   - [RtcEngine.setLocalVoiceEqualization]
  ///   - [RtcEngine.setLocalVoiceReverb]
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  /// Sets parameters for SDK preset audio effects.
  ///
  /// Call this method to set the following parameters for the local user who sends an audio stream:
  /// - 3D voice effect: Sets the cycle period of the 3D voice effect.
  /// - Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively.
  ///
  /// After setting parameters, all users in the channel can hear the relevant effect.
  ///
  /// **Note**
  /// - You can call this method either before or after joining a channel.
  /// - To achieve better audio effect quality, Agora recommends calling [RtcEngine.setAudioProfile] and setting the `scenario` parameter to `GameStreaming(3)` before calling this method.
  /// - Do not set the profile parameter of `setAudioProfile` to `SpeechStandard(1)`; otherwise, this method call fails.
  /// - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// - After calling this method, Agora recommends not calling the following methods, because they can override `setAudioEffectParameters`:
  ///   - [RtcEngine.setAudioEffectPreset]
  ///   - [RtcEngine.setVoiceBeautifierPreset]
  ///   - [RtcEngine.setLocalVoiceReverbPreset]
  ///   - [RtcEngine.setLocalVoiceChanger]
  ///   - [RtcEngine.setLocalVoicePitch]
  ///   - [RtcEngine.setLocalVoiceEqualization]
  ///   - [RtcEngine.setLocalVoiceReverb]
  ///
  /// **Parameter** [preset] The options for SDK preset audio effects:
  /// - 3D voice effect: `RoomAcoustics3DVoice`
  ///   - Call `setAudioProfile` and set the `profile` parameter to `MusicStandardStereo(3)` or `MusicHighQualityStereo(5)` before setting this enumerator; otherwise, the enumerator setting does not take effect.
  ///   - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect.
  /// - Pitch correction effect: `PitchCorrection`. To achieve better audio effect quality, Agora recommends calling `setAudioProfile` and setting the `profile` parameter to `MusicHighQuality(4)` or `MusicHighQualityStereo(5)` before setting this enumerator.
  ///
  /// **Parameter** [param1]
  /// - If you set `preset` to `RoomAcoustics3DVoice`, the `param1` sets the cycle period of the 3D voice effect. The value range is [1, 60] and the unit is a second. The default value is 10 seconds, indicating that the voice moves around you every 10 seconds.
  /// - If you set `preset` to `PitchCorrection`, `param1` sets the basic mode of the pitch correction effect:
  ///   - 1: (Default) Natural major scale.
  ///   - 2: Natural minor scale.
  ///   - 3: Japanese pentatonic scale.
  ///
  /// **Parameter** [param2]
  /// - If you set `preset` to `RoomAcoustics3DVoice`, you need to set `param2` to 0.
  /// - If you set `preset` to `PitchCorrection`, `param2` sets the tonic pitch of the pitch correction effect:
  ///   - 1: A
  ///   - 2: A#
  ///   - 3: B
  ///   - 4: (Default) C
  ///   - 5: C#
  ///   - 6: D
  ///   - 7: D#
  ///   - 8: E
  ///   - 9: F
  ///   - 10: F#
  ///   - 11: G
  ///   - 12: G#
  Future<void> setAudioEffectParameters(
      AudioEffectPreset preset, int param1, int param2);

  /// Sets parameters for SDK preset voice beautifier effects.
  ///
  /// Since v3.3.1
  ///
  /// Call this method to set a gender characteristic and a reverberation effect for the singing beautifier effect. This method sets parameters for the local user who sends an audio stream.
  ///
  /// After you call this method successfully, all users in the channel can hear the relevant effect.
  ///
  /// To achieve better audio effect quality, before you call this method, Agora recommends calling [RtcEngine.setAudioProfile], and setting the scenario parameter to `GameStreaming(3)` and the profile parameter to `MusicHighQuality(4)` or `MusicHighQualityStereo(5)`.
  ///
  /// **Parameter** [preset] The options for SDK preset voice beautifier effects. You can only set it as [VoiceBeautifierPreset.SingingBeautifier].
  ///
  /// **Parameter** [param1] The gender characteristics options for the singing voice:
  /// - `1`: A male-sounding voice.
  /// - `2`: A female-sounding voice.
  ///
  /// **Parameter** [param2] The reverberation effects options:
  /// - `1`: The reverberation effect sounds like singing in a small room.
  /// - `2`: The reverberation effect sounds like singing in a large room.
  /// - `3`: The reverberation effect sounds like singing in a hall.
  ///
  /// **Note**
  ///
  /// - You can call this method either before or after joining a channel.
  /// - Do not set the `profile` parameter of [RtcEngine.setAudioProfile] to `SpeechStandard(1)`; otherwise, this method call does not take effect.
  /// - This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  /// - After calling this method, Agora recommends not calling the following methods, because they can override `setVoiceBeautifierParameters`:
  ///   - [RtcEngine.setAudioEffectPreset]
  ///   - [RtcEngine.setAudioEffectParameters]
  ///   - [RtcEngine.setVoiceBeautifierPreset]
  ///   - [RtcEngine.setVoiceConversionPreset]
  ///   - [RtcEngine.setLocalVoiceReverbPreset]
  ///   - [RtcEngine.setLocalVoiceChanger]
  ///   - [RtcEngine.setLocalVoicePitch]
  ///   - [RtcEngine.setLocalVoiceEqualization]
  ///   - [RtcEngine.setLocalVoiceReverb]
  Future<void> setVoiceBeautifierParameters(
      VoiceBeautifierPreset preset, int param1, int param2);
}

/// @nodoc
mixin RtcVoicePositionInterface {
  /// Enables/Disables stereo panning for remote users.
  ///
  /// Ensure that you call this method before [RtcEngine.joinChannel] to enable stereo panning for remote users so that the local user can track the position of a remote user by calling [RtcEngine.setRemoteVoicePosition].
  ///
  /// **Parameter** [enabled] Sets whether or not to enable stereo panning for remote users:
  /// - `true`: enables stereo panning.
  /// - `false`: disables stereo panning.
  Future<void> enableSoundPositionIndication(bool enabled);

  /// Sets the sound position of a remote user.
  /// When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games, such as Battle Royale games.
  ///
  /// **Note**
  /// - For this method to work, enable stereo panning for remote users by calling the [RtcEngine.enableSoundPositionIndication] method before joining a channel.
  /// - This method requires hardware support. For the best sound positioning, we recommend using a wired headset.
  ///
  /// **Parameter** [uid] The ID of the remote user.
  ///
  /// **Parameter** [pan] The sound position of the remote user. The value ranges from -1.0 to 1.0:
  /// - 0.0: The remote sound comes from the front.
  /// - -1.0: The remote sound comes from the left.
  /// - 1.0: The remote sound comes from the right.
  ///
  /// **Parameter** [gain] Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user). The smaller the value, the less the gain.
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);
}

/// @nodoc
mixin RtcPublishStreamInterface {
  /// Sets the video layout and audio settings for CDN live.
  ///
  /// The SDK triggers the [RtcEngineEventHandler.transcodingUpdated] callback when you call this method to update the [LiveTranscoding] class. If you call this method to set the [LiveTranscoding] class for the first time, the SDK does not trigger the [RtcEngineEventHandler.transcodingUpdated] callback.
  ///
  /// **Note**
  /// - Before calling the methods listed in this section:
  ///   - This method applies to [ChannelProfile.LiveBroadcasting] only.
  ///   - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  ///   - Ensure that you call the [RtcEngine.setClientRole] method and set the user role as the host.
  ///   - Ensure that you call the `setLiveTranscoding` method before calling the [RtcEngine.addPublishStreamUrl] method.
  ///   - Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.
  ///
  /// **Parameter** [transcoding] Sets the CDN live audio/video transcoding settings. See [LiveTranscoding].
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  /// Publishes the local stream to a specified **CDN streaming URL**.
  ///
  /// After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The `addPublishStreamUrl` method call triggers the [RtcEngineEventHandler.rtmpStreamingStateChanged] callback on the local client to report the state of adding a local stream to the CDN.
  ///
  /// **Note**
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  /// - This method applies to LiveBroadcasting only.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method adds only one **CDN streaming URL **each time it is called.
  /// - Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.
  ///
  /// **Parameter** [url] The CDN streaming URL in the **RTMP or RTMPS** format.  The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  ///
  /// **Parameter** [transcodingEnabled] Sets whether transcoding is enabled/disabled. If you set this parameter as true, ensure that you call the setLiveTranscoding method before this method.
  ///
  /// See [RtcEngine.setLiveTranscoding]
  /// - `true`: Enable transcoding. To transcode the audio or video streams when publishing them to CDN live, often used for combining the audio and video streams of multiple hosts in CDN live.
  /// - `false`: Disable transcoding.
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  /// Removes an **RTMP or RTMPS** stream from the CDN.
  ///
  /// This method removes the CDN streaming URL (added by [RtcEngine.addPublishStreamUrl]) from a CDN live stream to report the state of removing an **RTMP or RTMPS** stream from the CDN.
  ///
  /// **Note**
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method applies to LiveBroadcasting only.
  /// - This method removes only one stream CDN streaming URL each time it is called.
  ///
  /// **Parameter** [url] The CDN streaming URL to be removed. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  Future<void> removePublishStreamUrl(String url);
}

/// @nodoc
mixin RtcMediaRelayInterface {
  /// Starts to relay media streams across channels.
  ///
  /// After a successful method call, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayStateChanged] and [RtcEngineEventHandler.channelMediaRelayEvent] callbacks, and these callbacks return the state and events of the media stream relay.
  /// - If the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback returns [ChannelMediaRelayState.Running] and [ChannelMediaRelayError.None], and the [RtcEngineEventHandler.channelMediaRelayEvent] callback returns [ChannelMediaRelayEvent.SentToDestinationChannel], the SDK starts relaying media streams between the original and the destination channel.
  /// - If the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback returns [ChannelMediaRelayState.Failure], an exception occurs during the media stream relay.
  ///
  /// **Note**
  /// - Contact sales-us@agora.io before implementing this function.
  /// - We do not support string user accounts in this API.
  /// - Call this method after the [RtcEngine.joinChannel] method.
  /// - This method takes effect only when you are a [ClientRole.Broadcaster] in a [ChannelProfile.LiveBroadcasting] channel.
  /// - After a successful method call, if you want to call this method again, ensure that you call the [RtcEngine.stopChannelMediaRelay] method to quit the current relay.
  ///
  /// **Parameter** [channelMediaRelayConfiguration] The configuration of the media stream relay.
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Updates the channels for media relay.
  ///
  /// After the channel media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the `updateChannelMediaRelay` method.
  ///
  /// After a successful method call, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayEvent] callback with the [ChannelMediaRelayEvent.UpdateDestinationChannel] state code.
  ///
  /// **Note**
  /// - Call this method after the [RtcEngine.startChannelMediaRelay] method to update the destination channel.
  /// - This method supports adding at most four destination channels in the relay. If there are already four destination channels in the relay.
  ///
  /// **Parameter** [channelMediaRelayConfiguration] The media stream relay configuration. See [ChannelMediaRelayConfiguration].
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Stops the media stream relay.
  ///
  /// Once the relay stops, the broadcaster quits all the destination channels.
  ///
  /// After a successful method call, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback. If the callback returns [ChannelMediaRelayState.Idle] and [ChannelMediaRelayError.None], the [ClientRole.Broadcaster] successfully stops the relay.
  ///
  /// **Note**
  /// - If the method call fails, the SDK triggers the [RtcEngineEventHandler.channelMediaRelayStateChanged] callback with the [ChannelMediaRelayError.ServerNoResponse] or [ChannelMediaRelayError.ServerConnectionLost] error code. You can leave the channel by calling the [RtcEngine.leaveChannel] method, and the media stream relay automatically stops.
  Future<void> stopChannelMediaRelay();
}

/// @nodoc
mixin RtcAudioRouteInterface {
  /// Sets the default audio playback route.
  ///
  /// This method sets whether the received audio is routed to the earpiece or speakerphone by default before joining a channel. If a user does not call this method, the audio is routed to the earpiece by default. If you need to change the default audio route after joining a channel, call the [RtcEngine.setEnableSpeakerphone] method.
  /// The default audio route for each scenario:
  /// - In the [ChannelProfile.Communication] profile:
  ///   - For a voice call, the default audio route is the earpiece.
  ///   - For a video call, the default audio route is the speaker. If the user disables the video using [RtcEngine.disableVideo], or [RtcEngine.muteLocalVideoStream] and [RtcEngine.muteAllRemoteVideoStreams], the default audio route automatically switches back to the earpiece.
  /// - In the [ChannelProfile.LiveBroadcasting] profile: The default audio route is the speaker.
  /// See [ChannelProfile.LiveBroadcasting]
  ///
  /// **Note**
  /// - This method applies to the [ChannelProfile.Communication] profile only.
  /// - Call this method before the user joins a channel.
  ///
  /// **Parameter** [defaultToSpeaker] Sets the default audio route:
  /// - `true`: Route the audio to the speaker. If the playback device connects to the earpiece or Bluetooth, the audio cannot be routed to the earpiece.
  /// - `false`: (Default) Route the audio to the earpiece. If a headset is plugged in, the audio is routed to the headset.
  Future<void> setDefaultAudioRoutetoSpeakerphone(bool defaultToSpeaker);

  /// Enables/Disables the audio playback route to the speakerphone.
  ///
  /// This method sets whether the audio is routed to the speakerphone or earpiece. After calling this method, the SDK returns the [RtcEngineEventHandler.audioRouteChanged] callback to indicate the changes.
  ///
  /// **Note**
  /// - Ensure that you have successfully called the [RtcEngine.joinChannel] method before calling this method.
  /// - This method is invalid for audience users in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Parameter** [enabled] Sets whether to route the audio to the speakerphone or earpiece:
  /// - `true`: Route the audio to the speakerphone. If the playback device connects to the earpiece or Bluetooth, the audio cannot be routed to the speakerphone.
  /// - `false`: Route the audio to the earpiece. If the headset is plugged in, the audio is routed to the headset.
  Future<void> setEnableSpeakerphone(bool enabled);

  /// Checks whether the speakerphone is enabled.
  ///
  /// **Note**
  ///
  /// You can call this method either before or after joining a channel.
  ///
  /// **Returns**
  /// - `true`: The speakerphone is enabled, and the audio plays from the speakerphone.
  /// - `false`: The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.
  Future<bool?> isSpeakerphoneEnabled();
}

/// @nodoc
mixin RtcEarMonitoringInterface {
  /// Enables in-ear monitoring.
  ///
  /// **Parameter** [enabled] Sets whether to enable/disable in-ear monitoring:
  /// - `true`: Enable.
  /// - `false`: (Default) Disable.
  Future<void> enableInEarMonitoring(bool enabled);

  /// Sets the volume of the in-ear monitor.
  ///
  /// **Parameter** [volume] Sets the volume of the in-ear monitor. The value ranges between 0 and 100 (default).
  Future<void> setInEarMonitoringVolume(int volume);
}

/// @nodoc
mixin RtcDualStreamInterface {
  /// Enables/Disables the dual video stream mode.
  ///
  /// If dual-stream mode is enabled, the receiver can choose to receive the high stream (high-resolution high-bitrate video stream) or low stream (low-resolution low-bitrate video stream) video.
  ///
  /// **Parameter** [enabled] Sets the stream mode:
  /// - `true`: Dual-stream mode.
  /// - `false`: (Default) Single-stream mode.
  Future<void> enableDualStreamMode(bool enabled);

  /// Sets the stream type of the remote video.
  ///
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using [RtcEngine.enableDualStreamMode] (false), the receiver can choose to receive either the high-video stream (the high resolution, and high bitrate video stream) or the low-video stream (the low resolution, and low bitrate video stream).
  ///
  /// By default, users receive the high-video stream. Call this method if you want to switch to the low-video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources.
  ///
  /// The aspect ratio of the low-video stream is the same as the high-video stream. Once the resolution of the high-video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.
  ///
  /// The SDK reports the result of calling this method in the [RtcEngineEventHandler.apiCallExecuted] callback.
  ///
  /// **Parameter** [uid] ID of the remote user sending the video stream.
  ///
  /// **Parameter** [streamType] Sets the video-stream type. See [VideoStreamType].
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType);

  /// Sets the default video-stream type of the remotely subscribed video stream when the remote user sends dual streams.
  ///
  /// You can call this method either before or after joining a channel.
  /// If you call both [setRemoteVideoStreamType] and [setRemoteDefaultVideoStreamType], the SDK applies the settings in the [setRemoteVideoStreamType] method.
  ///
  /// **Parameter** [streamType] Sets the default video-stream type. See [VideoStreamType].
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);
}

/// @nodoc
mixin RtcFallbackInterface {
  /// Sets the fallback option for the locally published video stream based on the network conditions.
  ///
  /// If option is set as [StreamFallbackOptions.AudioOnly], the SDK will:
  /// - Disable the upstream video but enable audio only when the network conditions deteriorate and cannot support both video and audio.
  /// - Re-enable the video when the network conditions improve.
  ///
  /// When the locally published video stream falls back to audio only or when the audio-only stream switches back to the video, the SDK triggers the [RtcEngineEventHandler.localPublishFallbackToAudioOnly].
  ///
  /// **Note**
  /// - Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the locally published video stream falls back to audio only.
  ///
  /// **Parameter** [option] Sets the fallback option for the locally published video stream. See [StreamFallbackOptions].
  ///
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// Sets the fallback option for the remotely subscribed video stream based on the network conditions.
  ///
  /// If option is set as [StreamFallbackOptions.VideoStreamLow] or [StreamFallbackOptions.AudioOnly], the SDK automatically switches the video from a high-stream to a low-stream, or disables the video when the downlink network condition cannot support both audio and video to guarantee the quality of the audio. The SDK monitors the network quality and restores the video stream when the network conditions improve. When the remotely subscribed video stream falls back to audio only, or the audio-only stream switches back to the video, the SDK triggers the [RtcEngineEventHandler.remoteSubscribeFallbackToAudioOnly] callback.
  ///
  /// **Parameter** [option] Sets the fallback option for the remotely subscribed video stream. See [StreamFallbackOptions].
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// Sets the priority of a remote user's media stream.
  ///
  /// Use this method with the [RtcEngine.setRemoteSubscribeFallbackOption] method. If the fallback function is enabled for a subscribed stream, the SDK ensures the high-priority user gets the best possible stream quality.
  ///
  /// **Note**
  /// The Agora SDK supports setting `userPriority` as `High` for one user only.
  ///
  /// **Parameter** [uid] The ID of the remote user.
  ///
  /// **Parameter** [userPriority] The priority of the remote user. See [UserPriority].
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);
}

/// @nodoc
mixin RtcTestInterface {
  /// Starts an audio call test.
  ///
  /// In the audio call test, you record your voice. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.
  ///
  /// **Note**
  /// - Call this method before joining a channel.
  /// - After calling this method, call the [RtcEngine.stopEchoTest] method to end the test. Otherwise, the app cannot run the next echo test, or call the [RtcEngine.joinChannel] method.
  /// - In the [ChannelProfile.LiveBroadcasting] profile, only a host can call this method.
  ///
  /// **Parameter** [intervalInSeconds] The time interval (s) between when you speak and when the recording plays back.
  Future<void> startEchoTest(int intervalInSeconds);

  /// Stops the audio call test.
  Future<void> stopEchoTest();

  /// Enables the network connection quality test.
  ///
  /// This method tests the quality of the users' network connections and is disabled by default.
  ///
  /// Before users join a channel or before an audience switches to a host, call this method to check the uplink network quality. This method consumes additional network traffic, which may affect the communication quality. Call the [RtcEngine.disableLastmileTest] method to disable this test after receiving the [RtcEngineEventHandler.lastmileQuality] callback, and before the user joins a channel or switches the user role.
  ///
  /// **Note**
  /// - Do not use this method with the [RtcEngine.startLastmileProbeTest] method.
  /// - Do not call any other methods before receiving the [RtcEngineEventHandler.lastmileQuality] callback. Otherwise, the callback may be interrupted by other methods and may not execute.
  /// - In the [ChannelProfile.LiveBroadcasting] profile, a host should not call this method after joining a channel.
  /// - If you call this method to test the last-mile quality, the SDK consumes the bandwidth of a video stream, whose bitrate corresponds to the bitrate you set in the [RtcEngine.setVideoEncoderConfiguration] method. After you join the channel, whether you have called the [RtcEngine.disableLastmileTest] method or not, the SDK automatically stops consuming the bandwidth.
  Future<void> enableLastmileTest();

  /// Disables the network connection quality test.
  Future<void> disableLastmileTest();

  /// Starts the last-mile network probe test before joining a channel to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).
  ///
  /// Once this method is enabled, the SDK returns the following callbacks:
  /// - [RtcEngineEventHandler.lastmileQuality]: the SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions with a score and is more closely linked to the user experience.
  /// - [RtcEngineEventHandler.lastmileProbeResult]: the SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective.
  ///
  /// Call this method to check the uplink network quality before users join a channel or before an audience switches to a host.
  ///
  /// **Note**
  /// - This method consumes extra network traffic and may affect communication quality. We do not recommend calling this method together with [RtcEngine.enableLastmileTest].
  /// - Do not call other methods before receiving the [RtcEngineEventHandler.lastmileQuality] and [RtcEngineEventHandler.lastmileProbeResult] callbacks. Otherwise, the callbacks may be interrupted by other methods.
  /// - In the [ChannelProfile.LiveBroadcasting] profile, a host should not call this method after joining a channel.
  ///
  /// **Parameter** [config] The configurations of the last-mile network probe test. See [LastmileProbeConfig].
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// Stops the last-mile network probe test.
  Future<void> stopLastmileProbeTest();
}

/// @nodoc
mixin RtcMediaMetadataInterface {
  /// Registers the metadata observer.
  ///
  /// This method enables you to add synchronized metadata in the video stream for more diversified live broadcast interactions, such as sending shopping links, digital coupons, and online quizzes.
  ///
  /// **Note**
  /// Call this method before the [RtcEngine.joinChannel] method.
  Future<void> registerMediaMetadataObserver();

  /// Unregisters the metadata observer.
  Future<void> unregisterMediaMetadataObserver();

  /// Sets the maximum size of the metadata.
  ///
  /// **Parameter** [size] The maximum size of the buffer of the metadata that you want to use. The highest value is 1024 bytes.
  Future<void> setMaxMetadataSize(int size);

  /// Sends the metadata.
  ///
  /// **Parameter** [metadata] The metadata to be sent in the form of String.
  ///
  /// **Note**
  ///
  /// Ensure that the size of the metadata does not exceed the value set in the [setMaxMetadataSize] method.
  Future<void> sendMetadata(String metadata);
}

/// @nodoc
mixin RtcWatermarkInterface {
  /// Adds a watermark image to the local video.
  ///
  /// This method adds a PNG watermark image to the local video stream in a live broadcast. Once the watermark image is added, all the audience in the channel (CDN audience included), and the recording device can see and capture it.
  ///
  /// Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.
  ///
  /// The watermark position depends on the settings in the [RtcEngine.setVideoEncoderConfiguration] method:
  /// - If the orientation mode of the encoding video is [VideoOutputOrientationMode.FixedLandscape], or the landscape mode in [VideoOutputOrientationMode.Adaptative], the watermark uses the landscape orientation.
  /// - If the orientation mode of the encoding video is [VideoOutputOrientationMode.FixedPortrait], or the portrait mode in [VideoOutputOrientationMode.Adaptative], the watermark uses the portrait orientation.
  /// - When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfiguration method. Otherwise, the watermark image will be cropped.
  ///
  /// **Note**
  /// - Ensure that you have called the [RtcEngine.enableVideo] method to enable the video module before calling this method.
  /// - If you only want to add a watermark image to the local video for the audience in the CDN LiveBroadcasting channel to see and capture, you can call this method or the [RtcEngine.setLiveTranscoding] method.
  /// - This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
  /// - If the dimensions the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
  /// - If you have enabled the local video preview by calling the startPreview method, you can use the visibleInPreview member in the WatermarkOptions class to set whether or not the watermark is visible in preview.
  /// - If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// **Parameter** [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from either the local file path or the assets file path. If you use the assets file path, you need to start with `/assets/` when filling in this parameter.
  ///
  /// **Parameter** [options] The options of the watermark image to be added. See [WatermarkOptions].
  Future<void> addVideoWatermark(String watermarkUrl, WatermarkOptions options);

  /// Removes the watermark image from the video stream added by [RtcEngine.addVideoWatermark].
  Future<void> clearVideoWatermarks();
}

/// @nodoc
mixin RtcEncryptionInterface {
  /// Enables built-in encryption with an encryption password before joining a channel.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated. Use [RtcEngine.enableEncryption] instead.
  ///
  /// All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user leaves the channel. If the encryption password is not specified or set to empty, the encryption functionality is disabled.
  ///
  /// **Note**
  /// - For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  /// - Do not use this method for CDN live streaming.
  ///
  /// **Parameter** [secret] The encryption password.
  @deprecated
  Future<void> setEncryptionSecret(String secret);

  /// Sets the built-in encryption mode.
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated since v3.1.2. Use [RtcEngine.enableEncryption] instead.
  ///
  /// The Agora SDK supports built-in encryption, which is set to aes-128-xts mode by default. Call this method to set the encryption mode to use other encryption modes. All users in the same channel must use the same encryption mode and password.
  ///
  /// Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  ///
  /// **Note**
  /// - Call the [RtcEngine.setEncryptionSecret] method before calling this method.
  ///
  /// **Parameter** [encryptionMode] Sets the encryption mode. See [EncryptionMode].
  @deprecated
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);

  /// Enables/Disables the built-in encryption.
  ///
  /// In scenarios requiring high security, Agora recommends calling `enableEncryption` to enable the built-in encryption before joining a channel.
  ///
  /// All users in the same channel must use the same encryption mode and encryption key. Once all users leave the channel, the encryption key of this channel is automatically cleared.
  ///
  /// **Note**
  /// - If you enable the built-in encryption, you cannot use the RTMP or RTMPS streaming function.
  /// - Agora supports four encryption modes. If you choose an encryption mode (excepting `SM4128ECB` mode), you need to add an external encryption library when integrating the SDK. For details, see the advanced guide *Channel Encryption*.
  ///
  ///
  /// **Parameter** [enabled] Whether to enable the built-in encryption.
  /// - `true`: Enable the built-in encryption.
  /// - `false`: Disable the built-in encryption.
  /// **Parameter** [config] Configurations of built-in encryption schemas. See [EncryptionConfig].
  Future<void> enableEncryption(bool enabled, EncryptionConfig config);
}

/// @nodoc
mixin RtcAudioRecorderInterface {
  /// Starts an audio recording on the client.
  ///
  /// The SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file.
  ///
  /// Supported formats of the recording file are as follows:
  /// - .wav: Large file size with high fidelity.
  /// - .aac: Small file size with low fidelity.
  ///
  /// **Note**
  /// - Ensure that the directory to save the recording file exists and is writable.
  /// - This method is usually called after calling the [RtcEngine.joinChannel] method. The recording automatically stops when you call the [RtcEngine.leaveChannel] method.
  /// - For better recording effects, set quality as [AudioRecordingQuality.Medium] or [AudioRecordingQuality.High] when sampleRate is 44.1 kHz or 48 kHz.
  ///
  /// **Parameter** [filePath] Absolute file path (including the suffixes of the filename) of the recording file. The string of the file name is in UTF-8. For example, `/sdcard/emulated/0/audio/aac`.
  ///
  /// **Parameter** [sampleRate] Sample rate (Hz) of the recording file. See [AudioSampleRateType] for supported values.
  ///
  /// **Parameter** [quality] The audio recording quality. See [AudioRecordingQuality].
  @deprecated
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality);

  /// Starts an audio recording on the client.
  ///
  /// The SDK allows recording audio during a call. After successfully calling this method, you can record the audio of users in the channel and get an audio recording file. Supported file formats are as follows:
  /// - WAV: High-fidelity files with typically larger file sizes. For example, if the sample rate is 32,000 Hz, the file size for a 10-minute recording is approximately 73 MB.
  /// - AAC: Low-fidelity files with typically smaller file sizes. For example, if the sample rate is 32,000 Hz and the recording quality is `AUDIO_RECORDING_QUALITY_MEDIUM`, the file size for a 10-minute recording is approximately 2 MB.
  ///
  /// Once the user leaves the channel, the recording automatically stops.
  ///
  /// **Note**
  /// - Call this method after joining a channel.
  ///
  /// **Parameter** [config] Recording configuration. See [AudioRecordingConfiguration].
  Future<void> startAudioRecordingWithConfig(
      AudioRecordingConfiguration config);

  /// Enables the virtual metronome.
  ///
  /// In music education, physical education, and other scenarios, teachers often need to use a metronome so that students can practice
  /// at the correct tempo. A meter is composed of a downbeat and some number of upbeats (including zero). The first beat of each
  /// measure is called the downbeat, and the rest are called the upbeats. In this method, you need to set the paths of the upbeat and
  /// downbeat files, the number of beats per measure, the tempo, and whether to send the sound of the metronome to remote users.
  ///
  /// **Note**
  /// - After enabling the virtual metronome, the SDK plays the specified files from the beginning and controls the beat duration according to the value of `beatsPerMinute` in [RhythmPlayerConfig].
  /// If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///
  /// **Parameter** [sound1] The absolute path or URL address (including the filename extensions) of the file for the downbeat. For example: `/sdcard/emulated/0/audio.mp4` on Android and `/var/mobile/Containers/Data/audio.mp4` on iOS. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP.
  ///
  /// **Parameter** [sound2] The absolute path or URL address (including the filename extensions) of the file for the upbeats. For example: `/sdcard/emulated/0/audio.mp4` on Android and `/var/mobile/Containers/Data/audio.mp4` on iOS. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP.
  ///
  /// **Parameter** [config] The metronome configuration. See [RhythmPlayerConfig].
  Future<void> startRhythmPlayer(
      String sound1, String sound2, RhythmPlayerConfig config);

  /// Disables the virtual metronome.
  ///
  /// After calling [RtcEngine.startRhythmPlayer], you can call this method to disable the virtual metronome.
  Future<void> stopRhythmPlayer();

  /// Configures the virtual metronome.
  ///
  /// After calling [RtcEngine.startRhythmPlayer], you can call this method to reconfigure the virtual metronome.
  ///
  /// **Note**
  /// - After reconfiguring the virtual metronome, the SDK plays the specified files from the beginning and controls the beat duration according to the value of `beatsPerMinute` in [RhythmPlayerConfig].
  /// If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///
  /// **Parameter** [config] The metronome configuration. For details, see [RhythmPlayerConfig].
  Future<void> configRhythmPlayer(RhythmPlayerConfig config);

  /// Stops the audio recording on the client.
  ///
  /// **Note**
  /// You can call this method before calling the [RtcEngine.leaveChannel] method; else, the recording automatically stops when you call the [RtcEngine.leaveChannel] method.
  Future<void> stopAudioRecording();
}

/// @nodoc
mixin RtcInjectStreamInterface {
  /// Injects an online media stream to a live broadcast.
  ///
  /// If this method call is successful, the server pulls the voice or video stream and injects it into a live channel. This is applicable to scenarios where all audience members in the channel can watch a live show and interact with each other.
  ///
  /// **Warning**
  ///
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.
  ///
  /// **Note**
  /// - This method applies to the LiveBroadcasting profile only.
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in *Push Streams to CDN*.
  /// - You can inject only one media stream into the channel at the same time.
  ///
  /// This method call triggers the following callbacks:
  /// - The local client:
  ///   - [RtcEngineEventHandler.streamInjectedStatus], with the state of the injecting the online stream.
  ///   - [RtcEngineEventHandler.userJoined](uid: 666), if the method call is successful and the online media stream is injected into the channel.
  /// - The remote client:
  ///   - [RtcEngineEventHandler.userJoined](uid: 666), if the method call is successful and the online media stream is injected into the channel.
  ///
  /// **Parameter** [url] The URL address to be added to the ongoing live broadcast. Valid protocols are RTMP, HLS, and HTTP-FLV.
  /// - Supported audio codec type: AAC.
  /// - Supported video codec type: H264(AVC).
  ///
  /// **Parameter** [config] The [LiveInjectStreamConfig] object which contains the configuration information for the added voice or video stream.
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  /// Removes the injected online media stream from a live broadcast.
  ///
  /// This method removes the URL address (added by [RtcEngine.addInjectStreamUrl]) from a live broadcast.
  ///
  /// If this method call is successful, the SDK triggers the [RtcEngineEventHandler.userOffline] callback and returns a stream uid of 666.
  ///
  /// **Parameter** [url] HTTP/HTTPS URL address of the added stream to be removed.
  Future<void> removeInjectStreamUrl(String url);
}

/// @nodoc
mixin RtcCameraInterface {
  /// Switches between front and rear cameras.
  ///
  /// Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
  ///
  /// **Returns**
  ///
  /// - `true`: Success.
  /// - `false`: Failure.
  Future<void> switchCamera();

  /// Checks whether the camera zoom function is supported.
  ///
  /// Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
  ///
  /// **Returns**
  ///
  /// - `true`: The device supports the camera zoom function.
  /// - `false`: The device does not support the camera zoom function.
  Future<bool?> isCameraZoomSupported();

  /// Checks whether the camera flash function is supported.
  ///
  /// Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
  ///
  /// **Returns**
  ///
  /// - `true`: The device supports the camera flash function.
  /// - `false`: The device does not the support camera flash function.
  Future<bool?> isCameraTorchSupported();

  /// Checks whether the camera manual focus function is supported.
  ///
  /// Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
  ///
  /// **Note**
  ///
  /// This method is not supported for iOS.
  ///
  /// **Returns**
  ///
  /// - `true`: The device supports the camera manual focus function.
  /// - `false`: The device does not support the camera manual focus function.
  Future<bool?> isCameraFocusSupported();

  /// Checks whether the camera exposure function is supported.
  ///
  /// Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
  ///
  /// **Returns**
  ///
  /// - `true`: The device supports the camera exposure function.
  /// - `false`: The device does not support the camera exposure function.
  Future<bool?> isCameraExposurePositionSupported();

  /// Checks whether the camera auto-face focus function is supported.
  ///
  /// Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
  ///
  /// **Returns**
  ///
  /// - `true`: The device supports the camera auto-face focus function.
  /// - `false`: The device does not support the camera auto-face focus function.
  Future<bool?> isCameraAutoFocusFaceModeSupported();

  /// Sets the camera zoom ratio.
  ///
  /// **Parameter** [factor] Sets the camera zoom factor. The value ranges between 1.0 and the maximum zoom supported by the device.
  Future<void> setCameraZoomFactor(double factor);

  /// Gets the maximum zoom ratio supported by the camera.
  ///
  /// **Note**
  ///
  /// This method is only supported in iOS.
  ///
  /// Ensure that you call this method after the camera starts, for example, by calling `startPreview` or `joinChannel`.
  ///
  /// **Returns**
  ///
  /// - The maximum camera zoom factor, if this method call succeeds.
  /// - Error code, if this method call fails.
  Future<double?> getCameraMaxZoomFactor();

  /// Sets the camera manual focus position.
  /// A successful method call triggers the [RtcEngineEventHandler.cameraFocusAreaChanged] callback on the local client.
  ///
  /// **Parameter** [positionX] The horizontal coordinate of the touch point in the view.
  ///
  /// **Parameter** [positionY] The vertical coordinate of the touch point in the view.
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY);

  /// Sets the camera exposure position.
  ///
  /// A successful method call triggers the [RtcEngineEventHandler.cameraExposureAreaChanged] callback on the local client.
  /// See [RtcEngineEventHandler.cameraExposureAreaChanged]
  ///
  /// **Parameter** [positionXinView] The horizontal coordinate of the touch point in the view.
  ///
  /// **Parameter** [positionYinView] The vertical coordinate of the touch point in the view.
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView);

  /// Enables/Disables face detection for the local user.
  ///
  /// Once face detection is enabled, the SDK triggers the [RtcEngineEventHandler.facePositionChanged] callback to report the face information of the local user, which includes the following aspects:
  /// - The width and height of the local video.
  /// - The position of the human face in the local video.
  /// - The distance between the human face and the device screen.
  ///
  /// **Parameter** [enable] Determines whether to enable the face detection function for the local user:
  /// - `true`: Enable face detection.
  /// - `false`: (Default) Disable face detection.
  Future<void> enableFaceDetection(bool enable);

  /// Enables the camera flash function.
  ///
  /// **Parameter** [isOn] Sets whether to enable/disable the camera flash function:
  /// - `true`: Enable the camera flash function.
  /// - `false`: Disable the camera flash function.
  Future<void> setCameraTorchOn(bool isOn);

  /// Enables the camera auto-face focus function.
  ///
  /// **Parameter** [enabled] Sets whether to enable/disable the camera auto-face focus function:
  /// - `true`: Enable the camera auto-face focus function.
  /// - `false`: (Default) Disable the camera auto-face focus function.
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// Sets The camera capture configuration.
  ///
  /// For a video call or live broadcast, generally the SDK controls the camera output parameters. When the default camera capture settings do not meet special requirements or cause performance problems, we recommend using this method to set the camera capturer configuration:
  /// - If the resolution or frame rate of the captured raw video data are higher than those set by [RtcEngine.setVideoEncoderConfiguration], processing video frames requires extra CPU and RAM usage and degrades performance. We recommend setting config as [CameraCaptureOutputPreference.Performance] to avoid such problems.
  /// - If you do not need local video preview or are willing to sacrifice preview quality, we recommend setting config as [CameraCaptureOutputPreference.Performance] to optimize CPU and RAM usage.
  /// - If you want better quality for the local video preview, we recommend setting config as [CameraCaptureOutputPreference.Preview].
  ///
  /// **Note**
  /// - Call this method before enabling the local camera. That said, you can call this method before calling [RtcEngine.joinChannel], [RtcEngine.enableVideo], or [RtcEngine.enableLocalVideo], depending on which method you use to turn on your local camera.
  ///
  /// **Parameter** [config] The camera capture configuration. See [CameraCapturerConfiguration].
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);
}

/// @nodoc
mixin RtcStreamMessageInterface {
  /// Creates a data stream.
  ///
  /// Each user can create up to five data streams during the lifecycle of the [RtcEngine].
  ///
  /// **Deprecated**
  ///
  /// This method is deprecated from v3.3.1.
  ///
  /// **Note**
  /// - Set both the reliable and ordered parameters to true or false. Do not set one as true and the other as false.
  ///
  /// **Parameter** [reliable] Sets whether or not the recipients are guaranteed to receive the data stream from the sender within five seconds:
  /// - `true`: The recipients receive the data from the sender within five seconds. If the recipient does not receive the data within five seconds, the SDK triggers the [RtcEngineEventHandler.streamMessageError] callback and returns an error code.
  /// - `false`: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.
  ///
  /// **Parameter** [ordered] Sets whether or not the recipients receive the data stream in the sent order:
  /// - `true`: The recipients receive the data in the sent order.
  /// - `false`: The recipients do not receive the data in the sent order.
  ///
  ///
  /// **Returns**
  /// - The stream ID, if this method call succeeds.
  /// - Error code, if this method call fails.
  Future<int?> createDataStream(bool reliable, bool ordered);

  /// Creates a data stream.
  ///
  /// Since v3.3.1.
  ///
  /// Each user can create up to five data streams in a single channel.
  ///
  /// This method does not support data reliability. If the receiver receives a data packet five seconds or more after it was sent, the SDK directly discards the data.
  ///
  /// **Parameter** [config] The configurations for the data stream: [DataStreamConfig].
  ///
  /// **Returns**
  /// - The stream ID, if this method call succeeds.
  /// - Error code, if this method call fails.
  Future<int?> createDataStreamWithConfig(DataStreamConfig config);

  /// Sends data stream messages.
  ///
  /// The SDK has the following restrictions on this method:
  /// - Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 kB.
  /// - Each client can send up to 6 kB of data per second.
  /// - Each user can have up to five data channels simultaneously.
  ///
  /// A successful method call triggers the [RtcEngineEventHandler.streamMessage] callback on the remote client, from which the remote user gets the stream message.
  ///
  /// A failed method call triggers the [RtcEngineEventHandler.streamMessageError] callback on the remote client.
  ///
  /// **Note**
  /// - Ensure that you have created the data stream using [RtcEngine.createDataStream] before calling this method.
  /// - This method applies only to the [ChannelProfile.Communication] profile or to hosts in the [ChannelProfile.LiveBroadcasting] profile.
  ///
  /// **Parameter** [streamId] ID of the sent data stream returned by the [RtcEngine.createDataStream] method.
  ///
  /// **Parameter** [message] Sent data.
  Future<void> sendStreamMessage(int streamId, String message);
}
