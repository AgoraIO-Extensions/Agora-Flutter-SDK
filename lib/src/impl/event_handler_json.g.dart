// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'event_handler_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenCaptureInfoJson _$ScreenCaptureInfoJsonFromJson(
        Map<String, dynamic> json) =>
    ScreenCaptureInfoJson(
      ScreenCaptureInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScreenCaptureInfoJsonToJson(
        ScreenCaptureInfoJson instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

OnClientRoleChangeFailedJson _$OnClientRoleChangeFailedJsonFromJson(
        Map<String, dynamic> json) =>
    OnClientRoleChangeFailedJson(
      $enumDecode(_$ClientRoleChangeFailedReasonEnumMap, json['reason']),
      $enumDecode(_$ClientRoleEnumMap, json['currentRole']),
    );

Map<String, dynamic> _$OnClientRoleChangeFailedJsonToJson(
        OnClientRoleChangeFailedJson instance) =>
    <String, dynamic>{
      'reason': _$ClientRoleChangeFailedReasonEnumMap[instance.reason],
      'currentRole': _$ClientRoleEnumMap[instance.currentRole],
    };

const _$ClientRoleChangeFailedReasonEnumMap = {
  ClientRoleChangeFailedReason.TooManyBroadcasters: 1,
  ClientRoleChangeFailedReason.NotAuthorized: 2,
  ClientRoleChangeFailedReason.RequestTimeOut: 3,
  ClientRoleChangeFailedReason.ConnectionFailed: 4,
};

const _$ClientRoleEnumMap = {
  ClientRole.Broadcaster: 1,
  ClientRole.Audience: 2,
};

OnFirstRemoteVideoFrameJson _$OnFirstRemoteVideoFrameJsonFromJson(
        Map<String, dynamic> json) =>
    OnFirstRemoteVideoFrameJson(
      json['uid'] as int,
      json['width'] as int,
      json['height'] as int,
      json['elapsed'] as int,
    );

Map<String, dynamic> _$OnFirstRemoteVideoFrameJsonToJson(
        OnFirstRemoteVideoFrameJson instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'width': instance.width,
      'height': instance.height,
      'elapsed': instance.elapsed,
    };

OnWlAccMessageJson _$OnWlAccMessageJsonFromJson(Map<String, dynamic> json) =>
    OnWlAccMessageJson(
      $enumDecode(_$WlaccMessageReasonEnumMap, json['reason']),
      $enumDecode(_$WlaccSuggestActionEnumMap, json['action']),
      json['wlAccMsg'] as String,
    );

Map<String, dynamic> _$OnWlAccMessageJsonToJson(OnWlAccMessageJson instance) =>
    <String, dynamic>{
      'reason': _$WlaccMessageReasonEnumMap[instance.reason],
      'action': _$WlaccSuggestActionEnumMap[instance.action],
      'wlAccMsg': instance.wlAccMsg,
    };

const _$WlaccMessageReasonEnumMap = {
  WlaccMessageReason.WeakSignal: 0,
  WlaccMessageReason.ChannelCongestion: 1,
};

const _$WlaccSuggestActionEnumMap = {
  WlaccSuggestAction.CloseToWifi: 0,
  WlaccSuggestAction.ConnectSsid: 1,
  WlaccSuggestAction.Check5g: 2,
  WlaccSuggestAction.ModifySsid: 3,
};

OnWlAccStatsJson _$OnWlAccStatsJsonFromJson(Map<String, dynamic> json) =>
    OnWlAccStatsJson(
      WlAccStats.fromJson(json['currentStats'] as Map<String, dynamic>),
      WlAccStats.fromJson(json['averageStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OnWlAccStatsJsonToJson(OnWlAccStatsJson instance) =>
    <String, dynamic>{
      'currentStats': instance.currentStats,
      'averageStats': instance.averageStats,
    };

OnProxyConnectedJson _$OnProxyConnectedJsonFromJson(
        Map<String, dynamic> json) =>
    OnProxyConnectedJson(
      json['channel'] as String,
      json['uid'] as int,
      $enumDecode(_$ProxyTypeEnumMap, json['proxyType']),
      json['localProxyIp'] as String,
      json['elapsed'] as int,
    );

Map<String, dynamic> _$OnProxyConnectedJsonToJson(
        OnProxyConnectedJson instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'uid': instance.uid,
      'proxyType': _$ProxyTypeEnumMap[instance.proxyType],
      'localProxyIp': instance.localProxyIp,
      'elapsed': instance.elapsed,
    };

const _$ProxyTypeEnumMap = {
  ProxyType.None: 0,
  ProxyType.UDP: 1,
  ProxyType.TCP: 2,
  ProxyType.Local: 3,
  ProxyType.TCPProxyAutoFallbackType: 4,
};

OnAudioDeviceTestVolumeIndicationJson
    _$OnAudioDeviceTestVolumeIndicationJsonFromJson(
            Map<String, dynamic> json) =>
        OnAudioDeviceTestVolumeIndicationJson(
          $enumDecode(_$AudioDeviceTestVolumeTypeEnumMap, json['volumeType']),
          json['volume'] as int,
        );

Map<String, dynamic> _$OnAudioDeviceTestVolumeIndicationJsonToJson(
        OnAudioDeviceTestVolumeIndicationJson instance) =>
    <String, dynamic>{
      'volumeType': _$AudioDeviceTestVolumeTypeEnumMap[instance.volumeType],
      'volume': instance.volume,
    };

const _$AudioDeviceTestVolumeTypeEnumMap = {
  AudioDeviceTestVolumeType.AudioTestRecordingVolume: 0,
  AudioDeviceTestVolumeType.AudioTestPlaybackVolume: 1,
};

OnRecorderStateChangedJson _$OnRecorderStateChangedJsonFromJson(
        Map<String, dynamic> json) =>
    OnRecorderStateChangedJson(
      $enumDecode(_$RecorderStateEnumMap, json['state']),
      $enumDecode(_$RecorderErrorCodeEnumMap, json['error']),
    );

Map<String, dynamic> _$OnRecorderStateChangedJsonToJson(
        OnRecorderStateChangedJson instance) =>
    <String, dynamic>{
      'state': _$RecorderStateEnumMap[instance.state],
      'error': _$RecorderErrorCodeEnumMap[instance.error],
    };

const _$RecorderStateEnumMap = {
  RecorderState.Error: -1,
  RecorderState.Start: 2,
  RecorderState.Stop: 3,
};

const _$RecorderErrorCodeEnumMap = {
  RecorderErrorCode.None: 0,
  RecorderErrorCode.WriteFailed: 1,
  RecorderErrorCode.NoStream: 2,
  RecorderErrorCode.OverMaxDuration: 3,
  RecorderErrorCode.ConfigChanged: 4,
  RecorderErrorCode.CustomStreamDetected: 5,
};

OnRecorderInfoUpdatedJson _$OnRecorderInfoUpdatedJsonFromJson(
        Map<String, dynamic> json) =>
    OnRecorderInfoUpdatedJson(
      RecorderInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OnRecorderInfoUpdatedJsonToJson(
        OnRecorderInfoUpdatedJson instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

OnContentInspectResultJson _$OnContentInspectResultJsonFromJson(
        Map<String, dynamic> json) =>
    OnContentInspectResultJson(
      $enumDecode(_$ContentInspectResultEnumMap, json['result']),
    );

Map<String, dynamic> _$OnContentInspectResultJsonToJson(
        OnContentInspectResultJson instance) =>
    <String, dynamic>{
      'result': _$ContentInspectResultEnumMap[instance.result],
    };

const _$ContentInspectResultEnumMap = {
  ContentInspectResult.ContentInspectNeutral: 1,
  ContentInspectResult.ContentInspectSexy: 2,
  ContentInspectResult.ContentInspectPorn: 3,
};
