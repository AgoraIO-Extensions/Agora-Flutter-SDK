import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class RtcEngineExImpl extends RtcEngineImpl implements RtcEngineEx {
  @override
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @override
  Future<void> joinChannelEx(
      {required String token,
      required RtcConnection connection,
      required ChannelMediaOptions options}) async {
    const apiType = 'RtcEngineEx_joinChannelEx';
    final param = createParams({
      'token': token,
      'connection': connection.toJson(),
      'options': options.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> leaveChannelEx(RtcConnection connection) async {
    const apiType = 'RtcEngineEx_leaveChannelEx';
    final param = createParams({'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> updateChannelMediaOptionsEx(
      {required ChannelMediaOptions options,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_updateChannelMediaOptionsEx';
    final param = createParams(
        {'options': options.toJson(), 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setVideoEncoderConfigurationEx(
      {required VideoEncoderConfiguration config,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_setVideoEncoderConfigurationEx';
    final param = createParams(
        {'config': config.toJson(), 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setupRemoteVideoEx(
      {required VideoCanvas canvas, required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_setupRemoteVideoEx';
    final param = createParams(
        {'canvas': canvas.toJson(), 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> muteRemoteAudioStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_muteRemoteAudioStreamEx';
    final param = createParams(
        {'uid': uid, 'mute': mute, 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> muteRemoteVideoStreamEx(
      {required int uid,
      required bool mute,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_muteRemoteVideoStreamEx';
    final param = createParams(
        {'uid': uid, 'mute': mute, 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setRemoteVideoStreamTypeEx(
      {required int uid,
      required VideoStreamType streamType,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_setRemoteVideoStreamTypeEx';
    final param = createParams({
      'uid': uid,
      'streamType': streamType.value(),
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setRemoteVoicePositionEx(
      {required int uid,
      required double pan,
      required double gain,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_setRemoteVoicePositionEx';
    final param = createParams({
      'uid': uid,
      'pan': pan,
      'gain': gain,
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setRemoteUserSpatialAudioParamsEx(
      {required int uid,
      required SpatialAudioParams params,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_setRemoteUserSpatialAudioParamsEx';
    final param = createParams({
      'uid': uid,
      'params': params.toJson(),
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> setRemoteRenderModeEx(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_setRemoteRenderModeEx';
    final param = createParams({
      'uid': uid,
      'renderMode': renderMode.value(),
      'mirrorMode': mirrorMode.value(),
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> enableLoopbackRecordingEx(
      {required RtcConnection connection,
      required bool enabled,
      String? deviceName}) async {
    const apiType = 'RtcEngineEx_enableLoopbackRecordingEx';
    final param = createParams({
      'connection': connection.toJson(),
      'enabled': enabled,
      'deviceName': deviceName
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<ConnectionStateType> getConnectionStateEx(
      RtcConnection connection) async {
    const apiType = 'RtcEngineEx_getConnectionStateEx';
    final param = createParams({'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return ConnectionStateTypeExt.fromValue(result);
  }

  @override
  Future<void> enableEncryptionEx(
      {required RtcConnection connection,
      required bool enabled,
      required EncryptionConfig config}) async {
    const apiType = 'RtcEngineEx_enableEncryptionEx';
    final param = createParams({
      'connection': connection.toJson(),
      'enabled': enabled,
      'config': config.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> sendStreamMessageEx(
      {required int streamId,
      required Uint8List data,
      required int length,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_sendStreamMessageEx';
    final param = createParams({
      'streamId': streamId,
      'length': length,
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffer: data);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> addVideoWatermarkEx(
      {required String watermarkUrl,
      required WatermarkOptions options,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_addVideoWatermarkEx';
    final param = createParams({
      'watermarkUrl': watermarkUrl,
      'options': options.toJson(),
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> clearVideoWatermarkEx(RtcConnection connection) async {
    const apiType = 'RtcEngineEx_clearVideoWatermarkEx';
    final param = createParams({'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> sendCustomReportMessageEx(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_sendCustomReportMessageEx';
    final param = createParams({
      'id': id,
      'category': category,
      'event': event,
      'label': label,
      'value': value,
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> enableAudioVolumeIndicationEx(
      {required int interval,
      required int smooth,
      required bool reportVad,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_enableAudioVolumeIndicationEx';
    final param = createParams({
      'interval': interval,
      'smooth': smooth,
      'reportVad': reportVad,
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<UserInfo> getUserInfoByUserAccountEx(
      {required String userAccount, required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_getUserInfoByUserAccountEx';
    final param = createParams(
        {'userAccount': userAccount, 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final getUserInfoByUserAccountExJson =
        RtcEngineExGetUserInfoByUserAccountExJson.fromJson(rm);
    return getUserInfoByUserAccountExJson.userInfo;
  }

  @override
  Future<UserInfo> getUserInfoByUidEx(
      {required int uid, required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_getUserInfoByUidEx';
    final param = createParams({'uid': uid, 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final getUserInfoByUidExJson =
        RtcEngineExGetUserInfoByUidExJson.fromJson(rm);
    return getUserInfoByUidExJson.userInfo;
  }

  @override
  Future<void> setVideoProfileEx(
      {required int width,
      required int height,
      required int frameRate,
      required int bitrate}) async {
    const apiType = 'RtcEngineEx_setVideoProfileEx';
    final param = createParams({
      'width': width,
      'height': height,
      'frameRate': frameRate,
      'bitrate': bitrate
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> enableDualStreamModeEx(
      {required VideoSourceType sourceType,
      required bool enabled,
      required SimulcastStreamConfig streamConfig,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_enableDualStreamModeEx';
    final param = createParams({
      'sourceType': sourceType.value(),
      'enabled': enabled,
      'streamConfig': streamConfig.toJson(),
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> addPublishStreamUrlEx(
      {required String url,
      required bool transcodingEnabled,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_addPublishStreamUrlEx';
    final param = createParams({
      'url': url,
      'transcodingEnabled': transcodingEnabled,
      'connection': connection.toJson()
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<int> createDataStreamEx(
      {required DataStreamConfig config,
      required RtcConnection connection}) async {
    const apiType = 'RtcEngineEx_createDataStreamEx';
    final param = createParams(
        {'config': config.toJson(), 'connection': connection.toJson()});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final createDataStreamExJson =
        RtcEngineExCreateDataStreamExJson.fromJson(rm);
    return createDataStreamExJson.streamId;
  }
}
