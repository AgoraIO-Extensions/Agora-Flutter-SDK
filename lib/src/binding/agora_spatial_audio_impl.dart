import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class BaseSpatialAudioEngineImpl implements BaseSpatialAudioEngine {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'BaseSpatialAudioEngine';

  @override
  Future<void> release() async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_release';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> setMaxAudioRecvCount(int maxCount) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_setMaxAudioRecvCount';
    final param = createParams({'maxCount': maxCount});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> setAudioRecvRange(double range) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_setAudioRecvRange';
    final param = createParams({'range': range});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> setDistanceUnit(double unit) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_setDistanceUnit';
    final param = createParams({'unit': unit});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> updateSelfPosition(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp}) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_updateSelfPosition';
    final param = createParams({
      'position': position,
      'axisForward': axisForward,
      'axisRight': axisRight,
      'axisUp': axisUp
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> updateSelfPositionEx(
      {required List<double> position,
      required List<double> axisForward,
      required List<double> axisRight,
      required List<double> axisUp,
      required RtcConnection connection}) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_updateSelfPositionEx';
    final param = createParams({
      'position': position,
      'axisForward': axisForward,
      'axisRight': axisRight,
      'axisUp': axisUp,
      'connection': connection.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> updatePlayerPositionInfo(
      {required int playerId,
      required RemoteVoicePositionInfo positionInfo}) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_updatePlayerPositionInfo';
    final param = createParams(
        {'playerId': playerId, 'positionInfo': positionInfo.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(positionInfo.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> setParameters(String params) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_setParameters';
    final param = createParams({'params': params});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> muteLocalAudioStream(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_muteLocalAudioStream';
    final param = createParams({'mute': mute});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> muteAllRemoteAudioStreams(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_muteAllRemoteAudioStreams';
    final param = createParams({'mute': mute});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> setZones(
      {required SpatialAudioZone zones, required int zoneCount}) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_setZones';
    final param =
        createParams({'zones': zones.toJson(), 'zoneCount': zoneCount});
    final List<Uint8List> buffers = [];
    buffers.addAll(zones.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> setPlayerAttenuation(
      {required int playerId,
      required double attenuation,
      required bool forceSet}) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_setPlayerAttenuation';
    final param = createParams({
      'playerId': playerId,
      'attenuation': attenuation,
      'forceSet': forceSet
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> muteRemoteAudioStream(
      {required int uid, required bool mute}) async {
    final apiType =
        '${isOverrideClassName ? className : 'BaseSpatialAudioEngine'}_muteRemoteAudioStream';
    final param = createParams({'uid': uid, 'mute': mute});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }
}

class LocalSpatialAudioEngineImpl extends BaseSpatialAudioEngineImpl
    implements LocalSpatialAudioEngine {
  @override
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @override
  @protected
  bool get isOverrideClassName => false;

  @override
  @protected
  String get className => 'LocalSpatialAudioEngine';

  @override
  Future<void> initialize() async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_initialize';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> updateRemotePosition(
      {required int uid, required RemoteVoicePositionInfo posInfo}) async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_updateRemotePosition';
    final param = createParams({'uid': uid, 'posInfo': posInfo.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(posInfo.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> updateRemotePositionEx(
      {required int uid,
      required RemoteVoicePositionInfo posInfo,
      required RtcConnection connection}) async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_updateRemotePositionEx';
    final param = createParams({
      'uid': uid,
      'posInfo': posInfo.toJson(),
      'connection': connection.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(posInfo.collectBufferList());
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> removeRemotePosition(int uid) async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_removeRemotePosition';
    final param = createParams({'uid': uid});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> removeRemotePositionEx(
      {required int uid, required RtcConnection connection}) async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_removeRemotePositionEx';
    final param = createParams({'uid': uid, 'connection': connection.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> clearRemotePositions() async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_clearRemotePositions';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
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
  Future<void> clearRemotePositionsEx(RtcConnection connection) async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_clearRemotePositionsEx';
    final param = createParams({'connection': connection.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(connection.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
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
  Future<void> setRemoteAudioAttenuation(
      {required int uid,
      required double attenuation,
      required bool forceSet}) async {
    final apiType =
        '${isOverrideClassName ? className : 'LocalSpatialAudioEngine'}_setRemoteAudioAttenuation';
    final param = createParams(
        {'uid': uid, 'attenuation': attenuation, 'forceSet': forceSet});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }
}
