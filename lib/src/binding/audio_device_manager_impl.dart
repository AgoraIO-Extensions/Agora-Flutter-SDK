import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class AudioDeviceManagerImpl implements AudioDeviceManager {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @override
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices() async {
    const apiType = 'AudioDeviceManager_enumeratePlaybackDevices';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<AudioDeviceInfo>;
  }

  @override
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices() async {
    const apiType = 'AudioDeviceManager_enumerateRecordingDevices';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<AudioDeviceInfo>;
  }

  @override
  Future<void> setPlaybackDevice(String deviceId) async {
    const apiType = 'AudioDeviceManager_setPlaybackDevice';
    final param = createParams({'deviceId': deviceId});
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
  Future<String> getPlaybackDevice() async {
    const apiType = 'AudioDeviceManager_getPlaybackDevice';
    final param = createParams({});
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
    final getPlaybackDeviceJson =
        AudioDeviceManagerGetPlaybackDeviceJson.fromJson(rm);
    return getPlaybackDeviceJson.deviceId;
  }

  @override
  Future<AudioDeviceInfo> getPlaybackDeviceInfo() async {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceInfo';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }

  @override
  Future<void> setPlaybackDeviceVolume(int volume) async {
    const apiType = 'AudioDeviceManager_setPlaybackDeviceVolume';
    final param = createParams({'volume': volume});
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
  Future<int> getPlaybackDeviceVolume() async {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceVolume';
    final param = createParams({});
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
    final getPlaybackDeviceVolumeJson =
        AudioDeviceManagerGetPlaybackDeviceVolumeJson.fromJson(rm);
    return getPlaybackDeviceVolumeJson.volume;
  }

  @override
  Future<void> setRecordingDevice(String deviceId) async {
    const apiType = 'AudioDeviceManager_setRecordingDevice';
    final param = createParams({'deviceId': deviceId});
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
  Future<String> getRecordingDevice() async {
    const apiType = 'AudioDeviceManager_getRecordingDevice';
    final param = createParams({});
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
    final getRecordingDeviceJson =
        AudioDeviceManagerGetRecordingDeviceJson.fromJson(rm);
    return getRecordingDeviceJson.deviceId;
  }

  @override
  Future<AudioDeviceInfo> getRecordingDeviceInfo() async {
    const apiType = 'AudioDeviceManager_getRecordingDeviceInfo';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as AudioDeviceInfo;
  }

  @override
  Future<void> setRecordingDeviceVolume(int volume) async {
    const apiType = 'AudioDeviceManager_setRecordingDeviceVolume';
    final param = createParams({'volume': volume});
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
  Future<int> getRecordingDeviceVolume() async {
    const apiType = 'AudioDeviceManager_getRecordingDeviceVolume';
    final param = createParams({});
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
    final getRecordingDeviceVolumeJson =
        AudioDeviceManagerGetRecordingDeviceVolumeJson.fromJson(rm);
    return getRecordingDeviceVolumeJson.volume;
  }

  @override
  Future<void> setPlaybackDeviceMute(bool mute) async {
    const apiType = 'AudioDeviceManager_setPlaybackDeviceMute';
    final param = createParams({'mute': mute});
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
  Future<bool> getPlaybackDeviceMute() async {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceMute';
    final param = createParams({});
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
    final getPlaybackDeviceMuteJson =
        AudioDeviceManagerGetPlaybackDeviceMuteJson.fromJson(rm);
    return getPlaybackDeviceMuteJson.mute;
  }

  @override
  Future<void> setRecordingDeviceMute(bool mute) async {
    const apiType = 'AudioDeviceManager_setRecordingDeviceMute';
    final param = createParams({'mute': mute});
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
  Future<bool> getRecordingDeviceMute() async {
    const apiType = 'AudioDeviceManager_getRecordingDeviceMute';
    final param = createParams({});
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
    final getRecordingDeviceMuteJson =
        AudioDeviceManagerGetRecordingDeviceMuteJson.fromJson(rm);
    return getRecordingDeviceMuteJson.mute;
  }

  @override
  Future<void> startPlaybackDeviceTest(String testAudioFilePath) async {
    const apiType = 'AudioDeviceManager_startPlaybackDeviceTest';
    final param = createParams({'testAudioFilePath': testAudioFilePath});
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
  Future<void> stopPlaybackDeviceTest() async {
    const apiType = 'AudioDeviceManager_stopPlaybackDeviceTest';
    final param = createParams({});
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
  Future<void> startRecordingDeviceTest(int indicationInterval) async {
    const apiType = 'AudioDeviceManager_startRecordingDeviceTest';
    final param = createParams({'indicationInterval': indicationInterval});
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
  Future<void> stopRecordingDeviceTest() async {
    const apiType = 'AudioDeviceManager_stopRecordingDeviceTest';
    final param = createParams({});
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
  Future<void> startAudioDeviceLoopbackTest(int indicationInterval) async {
    const apiType = 'AudioDeviceManager_startAudioDeviceLoopbackTest';
    final param = createParams({'indicationInterval': indicationInterval});
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
  Future<void> stopAudioDeviceLoopbackTest() async {
    const apiType = 'AudioDeviceManager_stopAudioDeviceLoopbackTest';
    final param = createParams({});
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
  Future<void> release() async {
    const apiType = 'AudioDeviceManager_release';
    final param = createParams({});
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
}
