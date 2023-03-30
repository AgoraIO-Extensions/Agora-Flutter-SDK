import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class RtcEngineEventHandlerWrapper implements EventLoopEventHandler {
  const RtcEngineEventHandlerWrapper(this.rtcEngineEventHandler);
  final RtcEngineEventHandler rtcEngineEventHandler;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is RtcEngineEventHandlerWrapper &&
        other.rtcEngineEventHandler == rtcEngineEventHandler;
  }

  @override
  int get hashCode => rtcEngineEventHandler.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onJoinChannelSuccessEx':
        if (rtcEngineEventHandler.onJoinChannelSuccess == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnJoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnJoinChannelSuccessJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onJoinChannelSuccess!(connection, elapsed);
        return true;

      case 'onRejoinChannelSuccessEx':
        if (rtcEngineEventHandler.onRejoinChannelSuccess == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRejoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnRejoinChannelSuccessJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onRejoinChannelSuccess!(connection, elapsed);
        return true;

      case 'onProxyConnected':
        if (rtcEngineEventHandler.onProxyConnected == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnProxyConnectedJson paramJson =
            RtcEngineEventHandlerOnProxyConnectedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        ProxyType? proxyType = paramJson.proxyType;
        String? localProxyIp = paramJson.localProxyIp;
        int? elapsed = paramJson.elapsed;
        if (channel == null ||
            uid == null ||
            proxyType == null ||
            localProxyIp == null ||
            elapsed == null) {
          return true;
        }
        rtcEngineEventHandler.onProxyConnected!(
            channel, uid, proxyType, localProxyIp, elapsed);
        return true;

      case 'onError':
        if (rtcEngineEventHandler.onError == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnErrorJson paramJson =
            RtcEngineEventHandlerOnErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ErrorCodeType? err = paramJson.err;
        String? msg = paramJson.msg;
        if (err == null || msg == null) {
          return true;
        }
        rtcEngineEventHandler.onError!(err, msg);
        return true;

      case 'onAudioQualityEx':
        if (rtcEngineEventHandler.onAudioQuality == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioQualityJson paramJson =
            RtcEngineEventHandlerOnAudioQualityJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        QualityType? quality = paramJson.quality;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        if (connection == null ||
            remoteUid == null ||
            quality == null ||
            delay == null ||
            lost == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onAudioQuality!(
            connection, remoteUid, quality, delay, lost);
        return true;

      case 'onLastmileProbeResult':
        if (rtcEngineEventHandler.onLastmileProbeResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLastmileProbeResultJson paramJson =
            RtcEngineEventHandlerOnLastmileProbeResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        LastmileProbeResult? result = paramJson.result;
        if (result == null) {
          return true;
        }
        result = result.fillBuffers(buffers);
        rtcEngineEventHandler.onLastmileProbeResult!(result);
        return true;

      case 'onAudioVolumeIndicationEx':
        if (rtcEngineEventHandler.onAudioVolumeIndication == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioVolumeIndicationJson paramJson =
            RtcEngineEventHandlerOnAudioVolumeIndicationJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        List<AudioVolumeInfo>? speakers = paramJson.speakers;
        int? speakerNumber = paramJson.speakerNumber;
        int? totalVolume = paramJson.totalVolume;
        if (connection == null ||
            speakers == null ||
            speakerNumber == null ||
            totalVolume == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        speakers = speakers.map((e) => e.fillBuffers(buffers)).toList();
        rtcEngineEventHandler.onAudioVolumeIndication!(
            connection, speakers, speakerNumber, totalVolume);
        return true;

      case 'onLeaveChannelEx':
        if (rtcEngineEventHandler.onLeaveChannel == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLeaveChannelJson paramJson =
            RtcEngineEventHandlerOnLeaveChannelJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        rtcEngineEventHandler.onLeaveChannel!(connection, stats);
        return true;

      case 'onRtcStatsEx':
        if (rtcEngineEventHandler.onRtcStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRtcStatsJson paramJson =
            RtcEngineEventHandlerOnRtcStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        rtcEngineEventHandler.onRtcStats!(connection, stats);
        return true;

      case 'onAudioDeviceStateChanged':
        if (rtcEngineEventHandler.onAudioDeviceStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioDeviceStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? deviceId = paramJson.deviceId;
        MediaDeviceType? deviceType = paramJson.deviceType;
        MediaDeviceStateType? deviceState = paramJson.deviceState;
        if (deviceId == null || deviceType == null || deviceState == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioDeviceStateChanged!(
            deviceId, deviceType, deviceState);
        return true;

      case 'onAudioMixingPositionChanged':
        if (rtcEngineEventHandler.onAudioMixingPositionChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioMixingPositionChangedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingPositionChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? position = paramJson.position;
        if (position == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioMixingPositionChanged!(position);
        return true;

      case 'onAudioMixingFinished':
        if (rtcEngineEventHandler.onAudioMixingFinished == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioMixingFinishedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingFinishedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        rtcEngineEventHandler.onAudioMixingFinished!();
        return true;

      case 'onAudioEffectFinished':
        if (rtcEngineEventHandler.onAudioEffectFinished == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioEffectFinishedJson paramJson =
            RtcEngineEventHandlerOnAudioEffectFinishedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? soundId = paramJson.soundId;
        if (soundId == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioEffectFinished!(soundId);
        return true;

      case 'onVideoDeviceStateChanged':
        if (rtcEngineEventHandler.onVideoDeviceStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnVideoDeviceStateChangedJson paramJson =
            RtcEngineEventHandlerOnVideoDeviceStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? deviceId = paramJson.deviceId;
        MediaDeviceType? deviceType = paramJson.deviceType;
        MediaDeviceStateType? deviceState = paramJson.deviceState;
        if (deviceId == null || deviceType == null || deviceState == null) {
          return true;
        }
        rtcEngineEventHandler.onVideoDeviceStateChanged!(
            deviceId, deviceType, deviceState);
        return true;

      case 'onNetworkQualityEx':
        if (rtcEngineEventHandler.onNetworkQuality == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnNetworkQualityJson paramJson =
            RtcEngineEventHandlerOnNetworkQualityJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        QualityType? txQuality = paramJson.txQuality;
        QualityType? rxQuality = paramJson.rxQuality;
        if (connection == null ||
            remoteUid == null ||
            txQuality == null ||
            rxQuality == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onNetworkQuality!(
            connection, remoteUid, txQuality, rxQuality);
        return true;

      case 'onIntraRequestReceivedEx':
        if (rtcEngineEventHandler.onIntraRequestReceived == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnIntraRequestReceivedJson paramJson =
            RtcEngineEventHandlerOnIntraRequestReceivedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onIntraRequestReceived!(connection);
        return true;

      case 'onUplinkNetworkInfoUpdated':
        if (rtcEngineEventHandler.onUplinkNetworkInfoUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        UplinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          return true;
        }
        info = info.fillBuffers(buffers);
        rtcEngineEventHandler.onUplinkNetworkInfoUpdated!(info);
        return true;

      case 'onDownlinkNetworkInfoUpdated':
        if (rtcEngineEventHandler.onDownlinkNetworkInfoUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        DownlinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          return true;
        }
        info = info.fillBuffers(buffers);
        rtcEngineEventHandler.onDownlinkNetworkInfoUpdated!(info);
        return true;

      case 'onLastmileQuality':
        if (rtcEngineEventHandler.onLastmileQuality == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLastmileQualityJson paramJson =
            RtcEngineEventHandlerOnLastmileQualityJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        QualityType? quality = paramJson.quality;
        if (quality == null) {
          return true;
        }
        rtcEngineEventHandler.onLastmileQuality!(quality);
        return true;

      case 'onFirstLocalVideoFrame':
        if (rtcEngineEventHandler.onFirstLocalVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoSourceType? source = paramJson.source;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (source == null ||
            width == null ||
            height == null ||
            elapsed == null) {
          return true;
        }
        rtcEngineEventHandler.onFirstLocalVideoFrame!(
            source, width, height, elapsed);
        return true;

      case 'onFirstLocalVideoFramePublishedEx':
        if (rtcEngineEventHandler.onFirstLocalVideoFramePublished == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onFirstLocalVideoFramePublished!(
            connection, elapsed);
        return true;

      case 'onFirstRemoteVideoDecodedEx':
        if (rtcEngineEventHandler.onFirstRemoteVideoDecoded == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
            width == null ||
            height == null ||
            elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onFirstRemoteVideoDecoded!(
            connection, remoteUid, width, height, elapsed);
        return true;

      case 'onVideoSizeChangedEx':
        if (rtcEngineEventHandler.onVideoSizeChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnVideoSizeChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSizeChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        VideoSourceType? sourceType = paramJson.sourceType;
        int? uid = paramJson.uid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? rotation = paramJson.rotation;
        if (connection == null ||
            sourceType == null ||
            uid == null ||
            width == null ||
            height == null ||
            rotation == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onVideoSizeChanged!(
            connection, sourceType, uid, width, height, rotation);
        return true;

      case 'onLocalVideoStateChanged':
        if (rtcEngineEventHandler.onLocalVideoStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLocalVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoSourceType? source = paramJson.source;
        LocalVideoStreamState? state = paramJson.state;
        LocalVideoStreamError? error = paramJson.error;
        if (source == null || state == null || error == null) {
          return true;
        }
        rtcEngineEventHandler.onLocalVideoStateChanged!(source, state, error);
        return true;

      case 'onRemoteVideoStateChangedEx':
        if (rtcEngineEventHandler.onRemoteVideoStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRemoteVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        RemoteVideoState? state = paramJson.state;
        RemoteVideoStateReason? reason = paramJson.reason;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
            state == null ||
            reason == null ||
            elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onRemoteVideoStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        return true;

      case 'onFirstRemoteVideoFrameEx':
        if (rtcEngineEventHandler.onFirstRemoteVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
            width == null ||
            height == null ||
            elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onFirstRemoteVideoFrame!(
            connection, remoteUid, width, height, elapsed);
        return true;

      case 'onUserJoinedEx':
        if (rtcEngineEventHandler.onUserJoined == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserJoinedJson paramJson =
            RtcEngineEventHandlerOnUserJoinedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || remoteUid == null || elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserJoined!(connection, remoteUid, elapsed);
        return true;

      case 'onUserOfflineEx':
        if (rtcEngineEventHandler.onUserOffline == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserOfflineJson paramJson =
            RtcEngineEventHandlerOnUserOfflineJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        UserOfflineReasonType? reason = paramJson.reason;
        if (connection == null || remoteUid == null || reason == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserOffline!(connection, remoteUid, reason);
        return true;

      case 'onUserMuteAudioEx':
        if (rtcEngineEventHandler.onUserMuteAudio == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserMuteAudioJson paramJson =
            RtcEngineEventHandlerOnUserMuteAudioJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserMuteAudio!(connection, remoteUid, muted);
        return true;

      case 'onUserMuteVideoEx':
        if (rtcEngineEventHandler.onUserMuteVideo == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserMuteVideoJson paramJson =
            RtcEngineEventHandlerOnUserMuteVideoJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserMuteVideo!(connection, remoteUid, muted);
        return true;

      case 'onUserEnableVideoEx':
        if (rtcEngineEventHandler.onUserEnableVideo == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserEnableVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableVideoJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserEnableVideo!(
            connection, remoteUid, enabled);
        return true;

      case 'onUserStateChangedEx':
        if (rtcEngineEventHandler.onUserStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserStateChangedJson paramJson =
            RtcEngineEventHandlerOnUserStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? state = paramJson.state;
        if (connection == null || remoteUid == null || state == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserStateChanged!(connection, remoteUid, state);
        return true;

      case 'onUserEnableLocalVideoEx':
        if (rtcEngineEventHandler.onUserEnableLocalVideo == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserEnableLocalVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableLocalVideoJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserEnableLocalVideo!(
            connection, remoteUid, enabled);
        return true;

      case 'onApiCallExecuted':
        if (rtcEngineEventHandler.onApiCallExecuted == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnApiCallExecutedJson paramJson =
            RtcEngineEventHandlerOnApiCallExecutedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ErrorCodeType? err = paramJson.err;
        String? api = paramJson.api;
        String? result = paramJson.result;
        if (err == null || api == null || result == null) {
          return true;
        }
        rtcEngineEventHandler.onApiCallExecuted!(err, api, result);
        return true;

      case 'onLocalAudioStatsEx':
        if (rtcEngineEventHandler.onLocalAudioStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLocalAudioStatsJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        rtcEngineEventHandler.onLocalAudioStats!(connection, stats);
        return true;

      case 'onRemoteAudioStatsEx':
        if (rtcEngineEventHandler.onRemoteAudioStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRemoteAudioStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RemoteAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        rtcEngineEventHandler.onRemoteAudioStats!(connection, stats);
        return true;

      case 'onLocalVideoStatsEx':
        if (rtcEngineEventHandler.onLocalVideoStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLocalVideoStatsJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        rtcEngineEventHandler.onLocalVideoStats!(connection, stats);
        return true;

      case 'onRemoteVideoStatsEx':
        if (rtcEngineEventHandler.onRemoteVideoStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRemoteVideoStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RemoteVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        rtcEngineEventHandler.onRemoteVideoStats!(connection, stats);
        return true;

      case 'onCameraReady':
        if (rtcEngineEventHandler.onCameraReady == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnCameraReadyJson paramJson =
            RtcEngineEventHandlerOnCameraReadyJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        rtcEngineEventHandler.onCameraReady!();
        return true;

      case 'onCameraFocusAreaChanged':
        if (rtcEngineEventHandler.onCameraFocusAreaChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnCameraFocusAreaChangedJson paramJson =
            RtcEngineEventHandlerOnCameraFocusAreaChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? x = paramJson.x;
        int? y = paramJson.y;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (x == null || y == null || width == null || height == null) {
          return true;
        }
        rtcEngineEventHandler.onCameraFocusAreaChanged!(x, y, width, height);
        return true;

      case 'onCameraExposureAreaChanged':
        if (rtcEngineEventHandler.onCameraExposureAreaChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnCameraExposureAreaChangedJson paramJson =
            RtcEngineEventHandlerOnCameraExposureAreaChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? x = paramJson.x;
        int? y = paramJson.y;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (x == null || y == null || width == null || height == null) {
          return true;
        }
        rtcEngineEventHandler.onCameraExposureAreaChanged!(x, y, width, height);
        return true;

      case 'onFacePositionChanged':
        if (rtcEngineEventHandler.onFacePositionChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFacePositionChangedJson paramJson =
            RtcEngineEventHandlerOnFacePositionChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? imageWidth = paramJson.imageWidth;
        int? imageHeight = paramJson.imageHeight;
        Rectangle? vecRectangle = paramJson.vecRectangle;
        int? vecDistance = paramJson.vecDistance;
        int? numFaces = paramJson.numFaces;
        if (imageWidth == null ||
            imageHeight == null ||
            vecRectangle == null ||
            vecDistance == null ||
            numFaces == null) {
          return true;
        }
        vecRectangle = vecRectangle.fillBuffers(buffers);
        rtcEngineEventHandler.onFacePositionChanged!(
            imageWidth, imageHeight, vecRectangle, vecDistance, numFaces);
        return true;

      case 'onVideoStopped':
        if (rtcEngineEventHandler.onVideoStopped == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnVideoStoppedJson paramJson =
            RtcEngineEventHandlerOnVideoStoppedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        rtcEngineEventHandler.onVideoStopped!();
        return true;

      case 'onAudioMixingStateChanged':
        if (rtcEngineEventHandler.onAudioMixingStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioMixingStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        AudioMixingStateType? state = paramJson.state;
        AudioMixingReasonType? reason = paramJson.reason;
        if (state == null || reason == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioMixingStateChanged!(state, reason);
        return true;

      case 'onRhythmPlayerStateChanged':
        if (rtcEngineEventHandler.onRhythmPlayerStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRhythmPlayerStateChangedJson paramJson =
            RtcEngineEventHandlerOnRhythmPlayerStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RhythmPlayerStateType? state = paramJson.state;
        RhythmPlayerErrorType? errorCode = paramJson.errorCode;
        if (state == null || errorCode == null) {
          return true;
        }
        rtcEngineEventHandler.onRhythmPlayerStateChanged!(state, errorCode);
        return true;

      case 'onConnectionLostEx':
        if (rtcEngineEventHandler.onConnectionLost == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnConnectionLostJson paramJson =
            RtcEngineEventHandlerOnConnectionLostJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onConnectionLost!(connection);
        return true;

      case 'onConnectionInterruptedEx':
        if (rtcEngineEventHandler.onConnectionInterrupted == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnConnectionInterruptedJson paramJson =
            RtcEngineEventHandlerOnConnectionInterruptedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onConnectionInterrupted!(connection);
        return true;

      case 'onConnectionBannedEx':
        if (rtcEngineEventHandler.onConnectionBanned == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnConnectionBannedJson paramJson =
            RtcEngineEventHandlerOnConnectionBannedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onConnectionBanned!(connection);
        return true;

      case 'onStreamMessageEx':
        if (rtcEngineEventHandler.onStreamMessage == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnStreamMessageJson paramJson =
            RtcEngineEventHandlerOnStreamMessageJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? streamId = paramJson.streamId;
        Uint8List? data = paramJson.data;
        int? length = paramJson.length;
        int? sentTs = paramJson.sentTs;
        if (connection == null ||
            remoteUid == null ||
            streamId == null ||
            data == null ||
            length == null ||
            sentTs == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onStreamMessage!(
            connection, remoteUid, streamId, data, length, sentTs);
        return true;

      case 'onStreamMessageErrorEx':
        if (rtcEngineEventHandler.onStreamMessageError == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnStreamMessageErrorJson paramJson =
            RtcEngineEventHandlerOnStreamMessageErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? streamId = paramJson.streamId;
        ErrorCodeType? code = paramJson.code;
        int? missed = paramJson.missed;
        int? cached = paramJson.cached;
        if (connection == null ||
            remoteUid == null ||
            streamId == null ||
            code == null ||
            missed == null ||
            cached == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onStreamMessageError!(
            connection, remoteUid, streamId, code, missed, cached);
        return true;

      case 'onRequestTokenEx':
        if (rtcEngineEventHandler.onRequestToken == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRequestTokenJson paramJson =
            RtcEngineEventHandlerOnRequestTokenJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onRequestToken!(connection);
        return true;

      case 'onTokenPrivilegeWillExpireEx':
        if (rtcEngineEventHandler.onTokenPrivilegeWillExpire == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson paramJson =
            RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        String? token = paramJson.token;
        if (connection == null || token == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onTokenPrivilegeWillExpire!(connection, token);
        return true;

      case 'onLicenseValidationFailureEx':
        if (rtcEngineEventHandler.onLicenseValidationFailure == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLicenseValidationFailureJson paramJson =
            RtcEngineEventHandlerOnLicenseValidationFailureJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LicenseErrorType? reason = paramJson.reason;
        if (connection == null || reason == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onLicenseValidationFailure!(connection, reason);
        return true;

      case 'onFirstLocalAudioFramePublishedEx':
        if (rtcEngineEventHandler.onFirstLocalAudioFramePublished == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onFirstLocalAudioFramePublished!(
            connection, elapsed);
        return true;

      case 'onFirstRemoteAudioFrameEx':
        if (rtcEngineEventHandler.onFirstRemoteAudioFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? userId = paramJson.userId;
        int? elapsed = paramJson.elapsed;
        if (connection == null || userId == null || elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onFirstRemoteAudioFrame!(
            connection, userId, elapsed);
        return true;

      case 'onFirstRemoteAudioDecodedEx':
        if (rtcEngineEventHandler.onFirstRemoteAudioDecoded == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || uid == null || elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onFirstRemoteAudioDecoded!(
            connection, uid, elapsed);
        return true;

      case 'onLocalAudioStateChangedEx':
        if (rtcEngineEventHandler.onLocalAudioStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLocalAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStreamState? state = paramJson.state;
        LocalAudioStreamError? error = paramJson.error;
        if (connection == null || state == null || error == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onLocalAudioStateChanged!(
            connection, state, error);
        return true;

      case 'onRemoteAudioStateChangedEx':
        if (rtcEngineEventHandler.onRemoteAudioStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRemoteAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        RemoteAudioState? state = paramJson.state;
        RemoteAudioStateReason? reason = paramJson.reason;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            remoteUid == null ||
            state == null ||
            reason == null ||
            elapsed == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onRemoteAudioStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        return true;

      case 'onActiveSpeakerEx':
        if (rtcEngineEventHandler.onActiveSpeaker == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnActiveSpeakerJson paramJson =
            RtcEngineEventHandlerOnActiveSpeakerJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        if (connection == null || uid == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onActiveSpeaker!(connection, uid);
        return true;

      case 'onContentInspectResult':
        if (rtcEngineEventHandler.onContentInspectResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnContentInspectResultJson paramJson =
            RtcEngineEventHandlerOnContentInspectResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ContentInspectResult? result = paramJson.result;
        if (result == null) {
          return true;
        }
        rtcEngineEventHandler.onContentInspectResult!(result);
        return true;

      case 'onSnapshotTakenEx':
        if (rtcEngineEventHandler.onSnapshotTaken == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnSnapshotTakenJson paramJson =
            RtcEngineEventHandlerOnSnapshotTakenJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        String? filePath = paramJson.filePath;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? errCode = paramJson.errCode;
        if (connection == null ||
            uid == null ||
            filePath == null ||
            width == null ||
            height == null ||
            errCode == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onSnapshotTaken!(
            connection, uid, filePath, width, height, errCode);
        return true;

      case 'onClientRoleChangedEx':
        if (rtcEngineEventHandler.onClientRoleChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnClientRoleChangedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        ClientRoleType? oldRole = paramJson.oldRole;
        ClientRoleType? newRole = paramJson.newRole;
        ClientRoleOptions? newRoleOptions = paramJson.newRoleOptions;
        if (connection == null ||
            oldRole == null ||
            newRole == null ||
            newRoleOptions == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        newRoleOptions = newRoleOptions.fillBuffers(buffers);
        rtcEngineEventHandler.onClientRoleChanged!(
            connection, oldRole, newRole, newRoleOptions);
        return true;

      case 'onClientRoleChangeFailedEx':
        if (rtcEngineEventHandler.onClientRoleChangeFailed == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnClientRoleChangeFailedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangeFailedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        ClientRoleChangeFailedReason? reason = paramJson.reason;
        ClientRoleType? currentRole = paramJson.currentRole;
        if (connection == null || reason == null || currentRole == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onClientRoleChangeFailed!(
            connection, reason, currentRole);
        return true;

      case 'onAudioDeviceVolumeChanged':
        if (rtcEngineEventHandler.onAudioDeviceVolumeChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MediaDeviceType? deviceType = paramJson.deviceType;
        int? volume = paramJson.volume;
        bool? muted = paramJson.muted;
        if (deviceType == null || volume == null || muted == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioDeviceVolumeChanged!(
            deviceType, volume, muted);
        return true;

      case 'onRtmpStreamingStateChanged':
        if (rtcEngineEventHandler.onRtmpStreamingStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRtmpStreamingStateChangedJson paramJson =
            RtcEngineEventHandlerOnRtmpStreamingStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? url = paramJson.url;
        RtmpStreamPublishState? state = paramJson.state;
        RtmpStreamPublishErrorType? errCode = paramJson.errCode;
        if (url == null || state == null || errCode == null) {
          return true;
        }
        rtcEngineEventHandler.onRtmpStreamingStateChanged!(url, state, errCode);
        return true;

      case 'onRtmpStreamingEvent':
        if (rtcEngineEventHandler.onRtmpStreamingEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRtmpStreamingEventJson paramJson =
            RtcEngineEventHandlerOnRtmpStreamingEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? url = paramJson.url;
        RtmpStreamingEvent? eventCode = paramJson.eventCode;
        if (url == null || eventCode == null) {
          return true;
        }
        rtcEngineEventHandler.onRtmpStreamingEvent!(url, eventCode);
        return true;

      case 'onTranscodingUpdated':
        if (rtcEngineEventHandler.onTranscodingUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnTranscodingUpdatedJson paramJson =
            RtcEngineEventHandlerOnTranscodingUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        rtcEngineEventHandler.onTranscodingUpdated!();
        return true;

      case 'onAudioRoutingChanged':
        if (rtcEngineEventHandler.onAudioRoutingChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioRoutingChangedJson paramJson =
            RtcEngineEventHandlerOnAudioRoutingChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? routing = paramJson.routing;
        if (routing == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioRoutingChanged!(routing);
        return true;

      case 'onChannelMediaRelayStateChanged':
        if (rtcEngineEventHandler.onChannelMediaRelayStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson paramJson =
            RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ChannelMediaRelayState? state = paramJson.state;
        ChannelMediaRelayError? code = paramJson.code;
        if (state == null || code == null) {
          return true;
        }
        rtcEngineEventHandler.onChannelMediaRelayStateChanged!(state, code);
        return true;

      case 'onChannelMediaRelayEvent':
        if (rtcEngineEventHandler.onChannelMediaRelayEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnChannelMediaRelayEventJson paramJson =
            RtcEngineEventHandlerOnChannelMediaRelayEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ChannelMediaRelayEvent? code = paramJson.code;
        if (code == null) {
          return true;
        }
        rtcEngineEventHandler.onChannelMediaRelayEvent!(code);
        return true;

      case 'onLocalPublishFallbackToAudioOnly':
        if (rtcEngineEventHandler.onLocalPublishFallbackToAudioOnly == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson paramJson =
            RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        bool? isFallbackOrRecover = paramJson.isFallbackOrRecover;
        if (isFallbackOrRecover == null) {
          return true;
        }
        rtcEngineEventHandler
            .onLocalPublishFallbackToAudioOnly!(isFallbackOrRecover);
        return true;

      case 'onRemoteSubscribeFallbackToAudioOnly':
        if (rtcEngineEventHandler.onRemoteSubscribeFallbackToAudioOnly ==
            null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
            paramJson =
            RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
                .fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? uid = paramJson.uid;
        bool? isFallbackOrRecover = paramJson.isFallbackOrRecover;
        if (uid == null || isFallbackOrRecover == null) {
          return true;
        }
        rtcEngineEventHandler.onRemoteSubscribeFallbackToAudioOnly!(
            uid, isFallbackOrRecover);
        return true;

      case 'onRemoteAudioTransportStatsEx':
        if (rtcEngineEventHandler.onRemoteAudioTransportStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRemoteAudioTransportStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioTransportStatsJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (connection == null ||
            remoteUid == null ||
            delay == null ||
            lost == null ||
            rxKBitRate == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onRemoteAudioTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        return true;

      case 'onRemoteVideoTransportStatsEx':
        if (rtcEngineEventHandler.onRemoteVideoTransportStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnRemoteVideoTransportStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoTransportStatsJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? delay = paramJson.delay;
        int? lost = paramJson.lost;
        int? rxKBitRate = paramJson.rxKBitRate;
        if (connection == null ||
            remoteUid == null ||
            delay == null ||
            lost == null ||
            rxKBitRate == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onRemoteVideoTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        return true;

      case 'onConnectionStateChangedEx':
        if (rtcEngineEventHandler.onConnectionStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnConnectionStateChangedJson paramJson =
            RtcEngineEventHandlerOnConnectionStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        ConnectionStateType? state = paramJson.state;
        ConnectionChangedReasonType? reason = paramJson.reason;
        if (connection == null || state == null || reason == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onConnectionStateChanged!(
            connection, state, reason);
        return true;

      case 'onWlAccMessageEx':
        if (rtcEngineEventHandler.onWlAccMessage == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnWlAccMessageJson paramJson =
            RtcEngineEventHandlerOnWlAccMessageJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        WlaccMessageReason? reason = paramJson.reason;
        WlaccSuggestAction? action = paramJson.action;
        String? wlAccMsg = paramJson.wlAccMsg;
        if (connection == null ||
            reason == null ||
            action == null ||
            wlAccMsg == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onWlAccMessage!(
            connection, reason, action, wlAccMsg);
        return true;

      case 'onWlAccStatsEx':
        if (rtcEngineEventHandler.onWlAccStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnWlAccStatsJson paramJson =
            RtcEngineEventHandlerOnWlAccStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        WlAccStats? currentStats = paramJson.currentStats;
        WlAccStats? averageStats = paramJson.averageStats;
        if (connection == null ||
            currentStats == null ||
            averageStats == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        currentStats = currentStats.fillBuffers(buffers);
        averageStats = averageStats.fillBuffers(buffers);
        rtcEngineEventHandler.onWlAccStats!(
            connection, currentStats, averageStats);
        return true;

      case 'onNetworkTypeChangedEx':
        if (rtcEngineEventHandler.onNetworkTypeChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnNetworkTypeChangedJson paramJson =
            RtcEngineEventHandlerOnNetworkTypeChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        NetworkType? type = paramJson.type;
        if (connection == null || type == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onNetworkTypeChanged!(connection, type);
        return true;

      case 'onEncryptionErrorEx':
        if (rtcEngineEventHandler.onEncryptionError == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnEncryptionErrorJson paramJson =
            RtcEngineEventHandlerOnEncryptionErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        EncryptionErrorType? errorType = paramJson.errorType;
        if (connection == null || errorType == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onEncryptionError!(connection, errorType);
        return true;

      case 'onPermissionError':
        if (rtcEngineEventHandler.onPermissionError == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnPermissionErrorJson paramJson =
            RtcEngineEventHandlerOnPermissionErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        PermissionType? permissionType = paramJson.permissionType;
        if (permissionType == null) {
          return true;
        }
        rtcEngineEventHandler.onPermissionError!(permissionType);
        return true;

      case 'onLocalUserRegistered':
        if (rtcEngineEventHandler.onLocalUserRegistered == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnLocalUserRegisteredJson paramJson =
            RtcEngineEventHandlerOnLocalUserRegisteredJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? uid = paramJson.uid;
        String? userAccount = paramJson.userAccount;
        if (uid == null || userAccount == null) {
          return true;
        }
        rtcEngineEventHandler.onLocalUserRegistered!(uid, userAccount);
        return true;

      case 'onUserInfoUpdated':
        if (rtcEngineEventHandler.onUserInfoUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserInfoUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? uid = paramJson.uid;
        UserInfo? info = paramJson.info;
        if (uid == null || info == null) {
          return true;
        }
        info = info.fillBuffers(buffers);
        rtcEngineEventHandler.onUserInfoUpdated!(uid, info);
        return true;

      case 'onUploadLogResultEx':
        if (rtcEngineEventHandler.onUploadLogResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUploadLogResultJson paramJson =
            RtcEngineEventHandlerOnUploadLogResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        String? requestId = paramJson.requestId;
        bool? success = paramJson.success;
        UploadErrorReason? reason = paramJson.reason;
        if (connection == null ||
            requestId == null ||
            success == null ||
            reason == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUploadLogResult!(
            connection, requestId, success, reason);
        return true;

      case 'onAudioSubscribeStateChanged':
        if (rtcEngineEventHandler.onAudioSubscribeStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioSubscribeStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioSubscribeStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        StreamSubscribeState? oldState = paramJson.oldState;
        StreamSubscribeState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (channel == null ||
            uid == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioSubscribeStateChanged!(
            channel, uid, oldState, newState, elapseSinceLastState);
        return true;

      case 'onVideoSubscribeStateChanged':
        if (rtcEngineEventHandler.onVideoSubscribeStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnVideoSubscribeStateChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSubscribeStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channel = paramJson.channel;
        int? uid = paramJson.uid;
        StreamSubscribeState? oldState = paramJson.oldState;
        StreamSubscribeState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (channel == null ||
            uid == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          return true;
        }
        rtcEngineEventHandler.onVideoSubscribeStateChanged!(
            channel, uid, oldState, newState, elapseSinceLastState);
        return true;

      case 'onAudioPublishStateChanged':
        if (rtcEngineEventHandler.onAudioPublishStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnAudioPublishStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioPublishStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channel = paramJson.channel;
        StreamPublishState? oldState = paramJson.oldState;
        StreamPublishState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (channel == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          return true;
        }
        rtcEngineEventHandler.onAudioPublishStateChanged!(
            channel, oldState, newState, elapseSinceLastState);
        return true;

      case 'onVideoPublishStateChanged':
        if (rtcEngineEventHandler.onVideoPublishStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnVideoPublishStateChangedJson paramJson =
            RtcEngineEventHandlerOnVideoPublishStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoSourceType? source = paramJson.source;
        String? channel = paramJson.channel;
        StreamPublishState? oldState = paramJson.oldState;
        StreamPublishState? newState = paramJson.newState;
        int? elapseSinceLastState = paramJson.elapseSinceLastState;
        if (source == null ||
            channel == null ||
            oldState == null ||
            newState == null ||
            elapseSinceLastState == null) {
          return true;
        }
        rtcEngineEventHandler.onVideoPublishStateChanged!(
            source, channel, oldState, newState, elapseSinceLastState);
        return true;

      case 'onExtensionEvent':
        if (rtcEngineEventHandler.onExtensionEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnExtensionEventJson paramJson =
            RtcEngineEventHandlerOnExtensionEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? provider = paramJson.provider;
        String? extension = paramJson.extension;
        String? key = paramJson.key;
        String? value = paramJson.value;
        if (provider == null ||
            extension == null ||
            key == null ||
            value == null) {
          return true;
        }
        rtcEngineEventHandler.onExtensionEvent!(
            provider, extension, key, value);
        return true;

      case 'onExtensionStarted':
        if (rtcEngineEventHandler.onExtensionStarted == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnExtensionStartedJson paramJson =
            RtcEngineEventHandlerOnExtensionStartedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? provider = paramJson.provider;
        String? extension = paramJson.extension;
        if (provider == null || extension == null) {
          return true;
        }
        rtcEngineEventHandler.onExtensionStarted!(provider, extension);
        return true;

      case 'onExtensionStopped':
        if (rtcEngineEventHandler.onExtensionStopped == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnExtensionStoppedJson paramJson =
            RtcEngineEventHandlerOnExtensionStoppedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? provider = paramJson.provider;
        String? extension = paramJson.extension;
        if (provider == null || extension == null) {
          return true;
        }
        rtcEngineEventHandler.onExtensionStopped!(provider, extension);
        return true;

      case 'onExtensionError':
        if (rtcEngineEventHandler.onExtensionError == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnExtensionErrorJson paramJson =
            RtcEngineEventHandlerOnExtensionErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? provider = paramJson.provider;
        String? extension = paramJson.extension;
        int? error = paramJson.error;
        String? message = paramJson.message;
        if (provider == null ||
            extension == null ||
            error == null ||
            message == null) {
          return true;
        }
        rtcEngineEventHandler.onExtensionError!(
            provider, extension, error, message);
        return true;

      case 'onUserAccountUpdatedEx':
        if (rtcEngineEventHandler.onUserAccountUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        RtcEngineEventHandlerOnUserAccountUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserAccountUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        String? userAccount = paramJson.userAccount;
        if (connection == null || remoteUid == null || userAccount == null) {
          return true;
        }
        connection = connection.fillBuffers(buffers);
        rtcEngineEventHandler.onUserAccountUpdated!(
            connection, remoteUid, userAccount);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('RtcEngineEventHandler')) return false;
    final newEvent = eventName.replaceFirst('RtcEngineEventHandler_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

class MetadataObserverWrapper implements EventLoopEventHandler {
  const MetadataObserverWrapper(this.metadataObserver);
  final MetadataObserver metadataObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MetadataObserverWrapper &&
        other.metadataObserver == metadataObserver;
  }

  @override
  int get hashCode => metadataObserver.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onMetadataReceived':
        if (metadataObserver.onMetadataReceived == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MetadataObserverOnMetadataReceivedJson paramJson =
            MetadataObserverOnMetadataReceivedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        Metadata? metadata = paramJson.metadata;
        if (metadata == null) {
          return true;
        }
        metadata = metadata.fillBuffers(buffers);
        metadataObserver.onMetadataReceived!(metadata);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('MetadataObserver')) return false;
    final newEvent = eventName.replaceFirst('MetadataObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

class DirectCdnStreamingEventHandlerWrapper implements EventLoopEventHandler {
  const DirectCdnStreamingEventHandlerWrapper(
      this.directCdnStreamingEventHandler);
  final DirectCdnStreamingEventHandler directCdnStreamingEventHandler;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DirectCdnStreamingEventHandlerWrapper &&
        other.directCdnStreamingEventHandler == directCdnStreamingEventHandler;
  }

  @override
  int get hashCode => directCdnStreamingEventHandler.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onDirectCdnStreamingStateChanged':
        if (directCdnStreamingEventHandler.onDirectCdnStreamingStateChanged ==
            null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
            paramJson =
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
                .fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        DirectCdnStreamingState? state = paramJson.state;
        DirectCdnStreamingError? error = paramJson.error;
        String? message = paramJson.message;
        if (state == null || error == null || message == null) {
          return true;
        }
        directCdnStreamingEventHandler.onDirectCdnStreamingStateChanged!(
            state, error, message);
        return true;

      case 'onDirectCdnStreamingStats':
        if (directCdnStreamingEventHandler.onDirectCdnStreamingStats == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson paramJson =
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson
                .fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        DirectCdnStreamingStats? stats = paramJson.stats;
        if (stats == null) {
          return true;
        }
        stats = stats.fillBuffers(buffers);
        directCdnStreamingEventHandler.onDirectCdnStreamingStats!(stats);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('DirectCdnStreamingEventHandler')) return false;
    final newEvent =
        eventName.replaceFirst('DirectCdnStreamingEventHandler_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}
