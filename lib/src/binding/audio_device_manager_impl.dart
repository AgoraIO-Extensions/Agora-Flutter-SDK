import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class AudioDeviceManagerImpl implements AudioDeviceManager {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'AudioDeviceManager';

  @override
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_enumeratePlaybackDevices';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<AudioDeviceInfo>;
  }

  @override
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_enumerateRecordingDevices';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<AudioDeviceInfo>;
  }

  @override
  Future<void> setPlaybackDevice(String deviceId) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_setPlaybackDevice';
    final param = createParams({'deviceId': deviceId});
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
  Future<String> getPlaybackDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getPlaybackDevice';
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
    final getPlaybackDeviceJson =
        AudioDeviceManagerGetPlaybackDeviceJson.fromJson(rm);
    return getPlaybackDeviceJson.deviceId;
  }

  @override
  Future<AudioDeviceInfo> getPlaybackDeviceInfo() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getPlaybackDeviceInfo';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }

  @override
  Future<void> setPlaybackDeviceVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_setPlaybackDeviceVolume';
    final param = createParams({'volume': volume});
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
  Future<int> getPlaybackDeviceVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getPlaybackDeviceVolume';
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
    final getPlaybackDeviceVolumeJson =
        AudioDeviceManagerGetPlaybackDeviceVolumeJson.fromJson(rm);
    return getPlaybackDeviceVolumeJson.volume;
  }

  @override
  Future<void> setRecordingDevice(String deviceId) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_setRecordingDevice';
    final param = createParams({'deviceId': deviceId});
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
  Future<String> getRecordingDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getRecordingDevice';
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
    final getRecordingDeviceJson =
        AudioDeviceManagerGetRecordingDeviceJson.fromJson(rm);
    return getRecordingDeviceJson.deviceId;
  }

  @override
  Future<AudioDeviceInfo> getRecordingDeviceInfo() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getRecordingDeviceInfo';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }

  @override
  Future<void> setRecordingDeviceVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_setRecordingDeviceVolume';
    final param = createParams({'volume': volume});
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
  Future<int> getRecordingDeviceVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getRecordingDeviceVolume';
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
    final getRecordingDeviceVolumeJson =
        AudioDeviceManagerGetRecordingDeviceVolumeJson.fromJson(rm);
    return getRecordingDeviceVolumeJson.volume;
  }

  @override
  Future<void> setLoopbackDevice(String deviceId) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_setLoopbackDevice';
    final param = createParams({'deviceId': deviceId});
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
  Future<String> getLoopbackDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getLoopbackDevice';
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
    final getLoopbackDeviceJson =
        AudioDeviceManagerGetLoopbackDeviceJson.fromJson(rm);
    return getLoopbackDeviceJson.deviceId;
  }

  @override
  Future<void> setPlaybackDeviceMute(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_setPlaybackDeviceMute';
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
  Future<bool> getPlaybackDeviceMute() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getPlaybackDeviceMute';
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
    final getPlaybackDeviceMuteJson =
        AudioDeviceManagerGetPlaybackDeviceMuteJson.fromJson(rm);
    return getPlaybackDeviceMuteJson.mute;
  }

  @override
  Future<void> setRecordingDeviceMute(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_setRecordingDeviceMute';
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
  Future<bool> getRecordingDeviceMute() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getRecordingDeviceMute';
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
    final getRecordingDeviceMuteJson =
        AudioDeviceManagerGetRecordingDeviceMuteJson.fromJson(rm);
    return getRecordingDeviceMuteJson.mute;
  }

  @override
  Future<void> startPlaybackDeviceTest(String testAudioFilePath) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_startPlaybackDeviceTest';
    final param = createParams({'testAudioFilePath': testAudioFilePath});
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
  Future<void> stopPlaybackDeviceTest() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_stopPlaybackDeviceTest';
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
  Future<void> startRecordingDeviceTest(int indicationInterval) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_startRecordingDeviceTest';
    final param = createParams({'indicationInterval': indicationInterval});
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
  Future<void> stopRecordingDeviceTest() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_stopRecordingDeviceTest';
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
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_startAudioDeviceLoopbackTest';
    final param = createParams({'indicationInterval': indicationInterval});
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
  Future<void> stopAudioDeviceLoopbackTest() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_stopAudioDeviceLoopbackTest';
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
  Future<void> followSystemPlaybackDevice(bool enable) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_followSystemPlaybackDevice';
    final param = createParams({'enable': enable});
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
  Future<void> followSystemRecordingDevice(bool enable) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_followSystemRecordingDevice';
    final param = createParams({'enable': enable});
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
  Future<void> followSystemLoopbackDevice(bool enable) async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_followSystemLoopbackDevice';
    final param = createParams({'enable': enable});
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
  Future<void> release() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_release';
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
  Future<AudioDeviceInfo> getPlaybackDefaultDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getPlaybackDefaultDevice';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }

  @override
  Future<AudioDeviceInfo> getRecordingDefaultDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getRecordingDefaultDevice';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }
}
