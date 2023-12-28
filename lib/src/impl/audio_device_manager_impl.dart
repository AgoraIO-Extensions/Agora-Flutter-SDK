import 'dart:convert';

import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ext.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/audio_device_manager.dart';
import 'package:agora_rtc_engine/src/binding/audio_device_manager_impl.dart'
    as audio_device_manager_impl_binding;
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

extension DeviceInfoListExt on List<AudioDeviceInfo> {
  void fill(dynamic rm) {
    final devicesList = List.from(rm);
    for (final d in devicesList) {
      final dm = Map<String, dynamic>.from(d);

      add(AudioDeviceInfo.fromJson(dm));
    }
  }
}

class AudioDeviceManagerImpl
    extends audio_device_manager_impl_binding.AudioDeviceManagerImpl
    with ScopedDisposableObjectMixin
    implements AudioDeviceManager {
  AudioDeviceManagerImpl._(RtcEngine rtcEngine)
      : super(rtcEngine.irisMethodChannel);

  static AudioDeviceManager create(RtcEngine rtcEngine) {
    return rtcEngine.objectPool.putIfAbsent<AudioDeviceManagerImpl>(
        _audioDeviceManagerScopedKey,
        () => AudioDeviceManagerImpl._(rtcEngine));
  }

  static const _audioDeviceManagerScopedKey =
      TypedScopedKey(AudioDeviceManagerImpl);

  @override
  Future<List<AudioDeviceInfo>> enumeratePlaybackDevices() async {
    const apiType = 'AudioDeviceManager_enumeratePlaybackDevices';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    final List<AudioDeviceInfo> deviceInfoList = [];
    deviceInfoList.fill(result);

    return deviceInfoList;
  }

  @override
  Future<List<AudioDeviceInfo>> enumerateRecordingDevices() async {
    const apiType = 'AudioDeviceManager_enumerateRecordingDevices';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];

    final List<AudioDeviceInfo> deviceInfoList = [];
    deviceInfoList.fill(result);

    return deviceInfoList;
  }

  @override
  Future<AudioDeviceInfo> getPlaybackDeviceInfo() async {
    const apiType = 'AudioDeviceManager_getPlaybackDeviceInfo_5540658';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;

    return AudioDeviceInfo.fromJson(rm);
  }

  @override
  Future<AudioDeviceInfo> getRecordingDeviceInfo() async {
    const apiType = 'AudioDeviceManager_getRecordingDeviceInfo_5540658';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;

    return AudioDeviceInfo.fromJson(rm);
  }

  @override
  Future<void> release() async {
    markDisposed();
  }

  @override
  Future<AudioDeviceInfo> getPlaybackDefaultDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getPlaybackDefaultDevice';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;

    return AudioDeviceInfo.fromJson(rm);
  }

  @override
  Future<AudioDeviceInfo> getRecordingDefaultDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'AudioDeviceManager'}_getRecordingDefaultDevice';
    final param = createParams({});
    final callApiResult = await irisMethodChannel
        .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;

    return AudioDeviceInfo.fromJson(rm);
  }

  @override
  Future<void> dispose() async {
    return release();
  }
}
