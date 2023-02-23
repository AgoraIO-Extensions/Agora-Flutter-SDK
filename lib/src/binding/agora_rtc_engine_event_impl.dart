import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

extension RtcEngineEventHandlerExt on RtcEngineEventHandler {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'onJoinChannelSuccessEx':
        if (onJoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnJoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnJoinChannelSuccessJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onJoinChannelSuccess!(connection, elapsed);
        break;

      case 'onRejoinChannelSuccessEx':
        if (onRejoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnRejoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnRejoinChannelSuccessJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onRejoinChannelSuccess!(connection, elapsed);
        break;

      case 'onProxyConnected':
        if (onProxyConnected == null) break;
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
          break;
        }
        onProxyConnected!(channel, uid, proxyType, localProxyIp, elapsed);
        break;

      case 'onError':
        if (onError == null) break;
        RtcEngineEventHandlerOnErrorJson paramJson =
            RtcEngineEventHandlerOnErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ErrorCodeType? err = paramJson.err;
        String? msg = paramJson.msg;
        if (err == null || msg == null) {
          break;
        }
        onError!(err, msg);
        break;

      case 'onAudioQualityEx':
        if (onAudioQuality == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onAudioQuality!(connection, remoteUid, quality, delay, lost);
        break;

      case 'onLastmileProbeResult':
        if (onLastmileProbeResult == null) break;
        RtcEngineEventHandlerOnLastmileProbeResultJson paramJson =
            RtcEngineEventHandlerOnLastmileProbeResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        LastmileProbeResult? result = paramJson.result;
        if (result == null) {
          break;
        }
        result = result.fillBuffers(buffers);
        onLastmileProbeResult!(result);
        break;

      case 'onAudioVolumeIndicationEx':
        if (onAudioVolumeIndication == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        speakers = speakers.map((e) => e.fillBuffers(buffers)).toList();
        onAudioVolumeIndication!(
            connection, speakers, speakerNumber, totalVolume);
        break;

      case 'onLeaveChannelEx':
        if (onLeaveChannel == null) break;
        RtcEngineEventHandlerOnLeaveChannelJson paramJson =
            RtcEngineEventHandlerOnLeaveChannelJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        onLeaveChannel!(connection, stats);
        break;

      case 'onRtcStatsEx':
        if (onRtcStats == null) break;
        RtcEngineEventHandlerOnRtcStatsJson paramJson =
            RtcEngineEventHandlerOnRtcStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        onRtcStats!(connection, stats);
        break;

      case 'onAudioDeviceStateChanged':
        if (onAudioDeviceStateChanged == null) break;
        RtcEngineEventHandlerOnAudioDeviceStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? deviceId = paramJson.deviceId;
        MediaDeviceType? deviceType = paramJson.deviceType;
        MediaDeviceStateType? deviceState = paramJson.deviceState;
        if (deviceId == null || deviceType == null || deviceState == null) {
          break;
        }
        onAudioDeviceStateChanged!(deviceId, deviceType, deviceState);
        break;

      case 'onAudioMixingFinished':
        if (onAudioMixingFinished == null) break;
        RtcEngineEventHandlerOnAudioMixingFinishedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingFinishedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        onAudioMixingFinished!();
        break;

      case 'onAudioEffectFinished':
        if (onAudioEffectFinished == null) break;
        RtcEngineEventHandlerOnAudioEffectFinishedJson paramJson =
            RtcEngineEventHandlerOnAudioEffectFinishedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? soundId = paramJson.soundId;
        if (soundId == null) {
          break;
        }
        onAudioEffectFinished!(soundId);
        break;

      case 'onVideoDeviceStateChanged':
        if (onVideoDeviceStateChanged == null) break;
        RtcEngineEventHandlerOnVideoDeviceStateChangedJson paramJson =
            RtcEngineEventHandlerOnVideoDeviceStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? deviceId = paramJson.deviceId;
        MediaDeviceType? deviceType = paramJson.deviceType;
        MediaDeviceStateType? deviceState = paramJson.deviceState;
        if (deviceId == null || deviceType == null || deviceState == null) {
          break;
        }
        onVideoDeviceStateChanged!(deviceId, deviceType, deviceState);
        break;

      case 'onMediaDeviceChanged':
        if (onMediaDeviceChanged == null) break;
        RtcEngineEventHandlerOnMediaDeviceChangedJson paramJson =
            RtcEngineEventHandlerOnMediaDeviceChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MediaDeviceType? deviceType = paramJson.deviceType;
        if (deviceType == null) {
          break;
        }
        onMediaDeviceChanged!(deviceType);
        break;

      case 'onNetworkQualityEx':
        if (onNetworkQuality == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onNetworkQuality!(connection, remoteUid, txQuality, rxQuality);
        break;

      case 'onIntraRequestReceivedEx':
        if (onIntraRequestReceived == null) break;
        RtcEngineEventHandlerOnIntraRequestReceivedJson paramJson =
            RtcEngineEventHandlerOnIntraRequestReceivedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onIntraRequestReceived!(connection);
        break;

      case 'onUplinkNetworkInfoUpdated':
        if (onUplinkNetworkInfoUpdated == null) break;
        RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        UplinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        info = info.fillBuffers(buffers);
        onUplinkNetworkInfoUpdated!(info);
        break;

      case 'onDownlinkNetworkInfoUpdated':
        if (onDownlinkNetworkInfoUpdated == null) break;
        RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        DownlinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        info = info.fillBuffers(buffers);
        onDownlinkNetworkInfoUpdated!(info);
        break;

      case 'onLastmileQuality':
        if (onLastmileQuality == null) break;
        RtcEngineEventHandlerOnLastmileQualityJson paramJson =
            RtcEngineEventHandlerOnLastmileQualityJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        QualityType? quality = paramJson.quality;
        if (quality == null) {
          break;
        }
        onLastmileQuality!(quality);
        break;

      case 'onFirstLocalVideoFrameEx':
        if (onFirstLocalVideoFrame == null) break;
        RtcEngineEventHandlerOnFirstLocalVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? elapsed = paramJson.elapsed;
        if (connection == null ||
            width == null ||
            height == null ||
            elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onFirstLocalVideoFrame!(connection, width, height, elapsed);
        break;

      case 'onFirstLocalVideoFramePublishedEx':
        if (onFirstLocalVideoFramePublished == null) break;
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onFirstLocalVideoFramePublished!(connection, elapsed);
        break;

      case 'onFirstRemoteVideoDecodedEx':
        if (onFirstRemoteVideoDecoded == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onFirstRemoteVideoDecoded!(
            connection, remoteUid, width, height, elapsed);
        break;

      case 'onVideoSizeChangedEx':
        if (onVideoSizeChanged == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onVideoSizeChanged!(
            connection, sourceType, uid, width, height, rotation);
        break;

      case 'onLocalVideoStateChanged':
        if (onLocalVideoStateChanged == null) break;
        RtcEngineEventHandlerOnLocalVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoSourceType? source = paramJson.source;
        LocalVideoStreamState? state = paramJson.state;
        LocalVideoStreamError? error = paramJson.error;
        if (source == null || state == null || error == null) {
          break;
        }
        onLocalVideoStateChanged!(source, state, error);
        break;

      case 'onRemoteVideoStateChangedEx':
        if (onRemoteVideoStateChanged == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onRemoteVideoStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onFirstRemoteVideoFrameEx':
        if (onFirstRemoteVideoFrame == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onFirstRemoteVideoFrame!(connection, remoteUid, width, height, elapsed);
        break;

      case 'onUserJoinedEx':
        if (onUserJoined == null) break;
        RtcEngineEventHandlerOnUserJoinedJson paramJson =
            RtcEngineEventHandlerOnUserJoinedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || remoteUid == null || elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserJoined!(connection, remoteUid, elapsed);
        break;

      case 'onUserOfflineEx':
        if (onUserOffline == null) break;
        RtcEngineEventHandlerOnUserOfflineJson paramJson =
            RtcEngineEventHandlerOnUserOfflineJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        UserOfflineReasonType? reason = paramJson.reason;
        if (connection == null || remoteUid == null || reason == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserOffline!(connection, remoteUid, reason);
        break;

      case 'onUserMuteAudioEx':
        if (onUserMuteAudio == null) break;
        RtcEngineEventHandlerOnUserMuteAudioJson paramJson =
            RtcEngineEventHandlerOnUserMuteAudioJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserMuteAudio!(connection, remoteUid, muted);
        break;

      case 'onUserMuteVideoEx':
        if (onUserMuteVideo == null) break;
        RtcEngineEventHandlerOnUserMuteVideoJson paramJson =
            RtcEngineEventHandlerOnUserMuteVideoJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserMuteVideo!(connection, remoteUid, muted);
        break;

      case 'onUserEnableVideoEx':
        if (onUserEnableVideo == null) break;
        RtcEngineEventHandlerOnUserEnableVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableVideoJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserEnableVideo!(connection, remoteUid, enabled);
        break;

      case 'onUserStateChangedEx':
        if (onUserStateChanged == null) break;
        RtcEngineEventHandlerOnUserStateChangedJson paramJson =
            RtcEngineEventHandlerOnUserStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? state = paramJson.state;
        if (connection == null || remoteUid == null || state == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserStateChanged!(connection, remoteUid, state);
        break;

      case 'onUserEnableLocalVideoEx':
        if (onUserEnableLocalVideo == null) break;
        RtcEngineEventHandlerOnUserEnableLocalVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableLocalVideoJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserEnableLocalVideo!(connection, remoteUid, enabled);
        break;

      case 'onApiCallExecuted':
        if (onApiCallExecuted == null) break;
        RtcEngineEventHandlerOnApiCallExecutedJson paramJson =
            RtcEngineEventHandlerOnApiCallExecutedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ErrorCodeType? err = paramJson.err;
        String? api = paramJson.api;
        String? result = paramJson.result;
        if (err == null || api == null || result == null) {
          break;
        }
        onApiCallExecuted!(err, api, result);
        break;

      case 'onLocalAudioStatsEx':
        if (onLocalAudioStats == null) break;
        RtcEngineEventHandlerOnLocalAudioStatsJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        onLocalAudioStats!(connection, stats);
        break;

      case 'onRemoteAudioStatsEx':
        if (onRemoteAudioStats == null) break;
        RtcEngineEventHandlerOnRemoteAudioStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RemoteAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        onRemoteAudioStats!(connection, stats);
        break;

      case 'onLocalVideoStatsEx':
        if (onLocalVideoStats == null) break;
        RtcEngineEventHandlerOnLocalVideoStatsJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        onLocalVideoStats!(connection, stats);
        break;

      case 'onRemoteVideoStatsEx':
        if (onRemoteVideoStats == null) break;
        RtcEngineEventHandlerOnRemoteVideoStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        RemoteVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        stats = stats.fillBuffers(buffers);
        onRemoteVideoStats!(connection, stats);
        break;

      case 'onCameraReady':
        if (onCameraReady == null) break;
        RtcEngineEventHandlerOnCameraReadyJson paramJson =
            RtcEngineEventHandlerOnCameraReadyJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        onCameraReady!();
        break;

      case 'onCameraFocusAreaChanged':
        if (onCameraFocusAreaChanged == null) break;
        RtcEngineEventHandlerOnCameraFocusAreaChangedJson paramJson =
            RtcEngineEventHandlerOnCameraFocusAreaChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? x = paramJson.x;
        int? y = paramJson.y;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (x == null || y == null || width == null || height == null) {
          break;
        }
        onCameraFocusAreaChanged!(x, y, width, height);
        break;

      case 'onCameraExposureAreaChanged':
        if (onCameraExposureAreaChanged == null) break;
        RtcEngineEventHandlerOnCameraExposureAreaChangedJson paramJson =
            RtcEngineEventHandlerOnCameraExposureAreaChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? x = paramJson.x;
        int? y = paramJson.y;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (x == null || y == null || width == null || height == null) {
          break;
        }
        onCameraExposureAreaChanged!(x, y, width, height);
        break;

      case 'onFacePositionChanged':
        if (onFacePositionChanged == null) break;
        RtcEngineEventHandlerOnFacePositionChangedJson paramJson =
            RtcEngineEventHandlerOnFacePositionChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? imageWidth = paramJson.imageWidth;
        int? imageHeight = paramJson.imageHeight;
        List<Rectangle>? vecRectangle = paramJson.vecRectangle;
        List<int>? vecDistance = paramJson.vecDistance;
        int? numFaces = paramJson.numFaces;
        if (imageWidth == null ||
            imageHeight == null ||
            vecRectangle == null ||
            vecDistance == null ||
            numFaces == null) {
          break;
        }
        vecRectangle = vecRectangle.map((e) => e.fillBuffers(buffers)).toList();
        onFacePositionChanged!(
            imageWidth, imageHeight, vecRectangle, vecDistance, numFaces);
        break;

      case 'onVideoStopped':
        if (onVideoStopped == null) break;
        RtcEngineEventHandlerOnVideoStoppedJson paramJson =
            RtcEngineEventHandlerOnVideoStoppedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        onVideoStopped!();
        break;

      case 'onAudioMixingStateChanged':
        if (onAudioMixingStateChanged == null) break;
        RtcEngineEventHandlerOnAudioMixingStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        AudioMixingStateType? state = paramJson.state;
        AudioMixingReasonType? reason = paramJson.reason;
        if (state == null || reason == null) {
          break;
        }
        onAudioMixingStateChanged!(state, reason);
        break;

      case 'onRhythmPlayerStateChanged':
        if (onRhythmPlayerStateChanged == null) break;
        RtcEngineEventHandlerOnRhythmPlayerStateChangedJson paramJson =
            RtcEngineEventHandlerOnRhythmPlayerStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RhythmPlayerStateType? state = paramJson.state;
        RhythmPlayerErrorType? errorCode = paramJson.errorCode;
        if (state == null || errorCode == null) {
          break;
        }
        onRhythmPlayerStateChanged!(state, errorCode);
        break;

      case 'onConnectionLostEx':
        if (onConnectionLost == null) break;
        RtcEngineEventHandlerOnConnectionLostJson paramJson =
            RtcEngineEventHandlerOnConnectionLostJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onConnectionLost!(connection);
        break;

      case 'onConnectionInterruptedEx':
        if (onConnectionInterrupted == null) break;
        RtcEngineEventHandlerOnConnectionInterruptedJson paramJson =
            RtcEngineEventHandlerOnConnectionInterruptedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onConnectionInterrupted!(connection);
        break;

      case 'onConnectionBannedEx':
        if (onConnectionBanned == null) break;
        RtcEngineEventHandlerOnConnectionBannedJson paramJson =
            RtcEngineEventHandlerOnConnectionBannedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onConnectionBanned!(connection);
        break;

      case 'onStreamMessageEx':
        if (onStreamMessage == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onStreamMessage!(connection, remoteUid, streamId, data, length, sentTs);
        break;

      case 'onStreamMessageErrorEx':
        if (onStreamMessageError == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onStreamMessageError!(
            connection, remoteUid, streamId, code, missed, cached);
        break;

      case 'onRequestTokenEx':
        if (onRequestToken == null) break;
        RtcEngineEventHandlerOnRequestTokenJson paramJson =
            RtcEngineEventHandlerOnRequestTokenJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onRequestToken!(connection);
        break;

      case 'onTokenPrivilegeWillExpireEx':
        if (onTokenPrivilegeWillExpire == null) break;
        RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson paramJson =
            RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        String? token = paramJson.token;
        if (connection == null || token == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onTokenPrivilegeWillExpire!(connection, token);
        break;

      case 'onLicenseValidationFailureEx':
        if (onLicenseValidationFailure == null) break;
        RtcEngineEventHandlerOnLicenseValidationFailureJson paramJson =
            RtcEngineEventHandlerOnLicenseValidationFailureJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LicenseErrorType? reason = paramJson.reason;
        if (connection == null || reason == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onLicenseValidationFailure!(connection, reason);
        break;

      case 'onFirstLocalAudioFramePublishedEx':
        if (onFirstLocalAudioFramePublished == null) break;
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onFirstLocalAudioFramePublished!(connection, elapsed);
        break;

      case 'onFirstRemoteAudioFrameEx':
        if (onFirstRemoteAudioFrame == null) break;
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? userId = paramJson.userId;
        int? elapsed = paramJson.elapsed;
        if (connection == null || userId == null || elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onFirstRemoteAudioFrame!(connection, userId, elapsed);
        break;

      case 'onFirstRemoteAudioDecodedEx':
        if (onFirstRemoteAudioDecoded == null) break;
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || uid == null || elapsed == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onFirstRemoteAudioDecoded!(connection, uid, elapsed);
        break;

      case 'onLocalAudioStateChangedEx':
        if (onLocalAudioStateChanged == null) break;
        RtcEngineEventHandlerOnLocalAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStreamState? state = paramJson.state;
        LocalAudioStreamError? error = paramJson.error;
        if (connection == null || state == null || error == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onLocalAudioStateChanged!(connection, state, error);
        break;

      case 'onRemoteAudioStateChangedEx':
        if (onRemoteAudioStateChanged == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onRemoteAudioStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onActiveSpeakerEx':
        if (onActiveSpeaker == null) break;
        RtcEngineEventHandlerOnActiveSpeakerJson paramJson =
            RtcEngineEventHandlerOnActiveSpeakerJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        if (connection == null || uid == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onActiveSpeaker!(connection, uid);
        break;

      case 'onContentInspectResult':
        if (onContentInspectResult == null) break;
        RtcEngineEventHandlerOnContentInspectResultJson paramJson =
            RtcEngineEventHandlerOnContentInspectResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ContentInspectResult? result = paramJson.result;
        if (result == null) {
          break;
        }
        onContentInspectResult!(result);
        break;

      case 'onSnapshotTakenEx':
        if (onSnapshotTaken == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onSnapshotTaken!(connection, uid, filePath, width, height, errCode);
        break;

      case 'onClientRoleChangedEx':
        if (onClientRoleChanged == null) break;
        RtcEngineEventHandlerOnClientRoleChangedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        ClientRoleType? oldRole = paramJson.oldRole;
        ClientRoleType? newRole = paramJson.newRole;
        if (connection == null || oldRole == null || newRole == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onClientRoleChanged!(connection, oldRole, newRole);
        break;

      case 'onClientRoleChangeFailedEx':
        if (onClientRoleChangeFailed == null) break;
        RtcEngineEventHandlerOnClientRoleChangeFailedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangeFailedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        ClientRoleChangeFailedReason? reason = paramJson.reason;
        ClientRoleType? currentRole = paramJson.currentRole;
        if (connection == null || reason == null || currentRole == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onClientRoleChangeFailed!(connection, reason, currentRole);
        break;

      case 'onAudioDeviceVolumeChanged':
        if (onAudioDeviceVolumeChanged == null) break;
        RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MediaDeviceType? deviceType = paramJson.deviceType;
        int? volume = paramJson.volume;
        bool? muted = paramJson.muted;
        if (deviceType == null || volume == null || muted == null) {
          break;
        }
        onAudioDeviceVolumeChanged!(deviceType, volume, muted);
        break;

      case 'onRtmpStreamingStateChanged':
        if (onRtmpStreamingStateChanged == null) break;
        RtcEngineEventHandlerOnRtmpStreamingStateChangedJson paramJson =
            RtcEngineEventHandlerOnRtmpStreamingStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? url = paramJson.url;
        RtmpStreamPublishState? state = paramJson.state;
        RtmpStreamPublishErrorType? errCode = paramJson.errCode;
        if (url == null || state == null || errCode == null) {
          break;
        }
        onRtmpStreamingStateChanged!(url, state, errCode);
        break;

      case 'onRtmpStreamingEvent':
        if (onRtmpStreamingEvent == null) break;
        RtcEngineEventHandlerOnRtmpStreamingEventJson paramJson =
            RtcEngineEventHandlerOnRtmpStreamingEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? url = paramJson.url;
        RtmpStreamingEvent? eventCode = paramJson.eventCode;
        if (url == null || eventCode == null) {
          break;
        }
        onRtmpStreamingEvent!(url, eventCode);
        break;

      case 'onTranscodingUpdated':
        if (onTranscodingUpdated == null) break;
        RtcEngineEventHandlerOnTranscodingUpdatedJson paramJson =
            RtcEngineEventHandlerOnTranscodingUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        onTranscodingUpdated!();
        break;

      case 'onAudioRoutingChanged':
        if (onAudioRoutingChanged == null) break;
        RtcEngineEventHandlerOnAudioRoutingChangedJson paramJson =
            RtcEngineEventHandlerOnAudioRoutingChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? routing = paramJson.routing;
        if (routing == null) {
          break;
        }
        onAudioRoutingChanged!(routing);
        break;

      case 'onChannelMediaRelayStateChanged':
        if (onChannelMediaRelayStateChanged == null) break;
        RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson paramJson =
            RtcEngineEventHandlerOnChannelMediaRelayStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ChannelMediaRelayState? state = paramJson.state;
        ChannelMediaRelayError? code = paramJson.code;
        if (state == null || code == null) {
          break;
        }
        onChannelMediaRelayStateChanged!(state, code);
        break;

      case 'onChannelMediaRelayEvent':
        if (onChannelMediaRelayEvent == null) break;
        RtcEngineEventHandlerOnChannelMediaRelayEventJson paramJson =
            RtcEngineEventHandlerOnChannelMediaRelayEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        ChannelMediaRelayEvent? code = paramJson.code;
        if (code == null) {
          break;
        }
        onChannelMediaRelayEvent!(code);
        break;

      case 'onLocalPublishFallbackToAudioOnly':
        if (onLocalPublishFallbackToAudioOnly == null) break;
        RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson paramJson =
            RtcEngineEventHandlerOnLocalPublishFallbackToAudioOnlyJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        bool? isFallbackOrRecover = paramJson.isFallbackOrRecover;
        if (isFallbackOrRecover == null) {
          break;
        }
        onLocalPublishFallbackToAudioOnly!(isFallbackOrRecover);
        break;

      case 'onRemoteSubscribeFallbackToAudioOnly':
        if (onRemoteSubscribeFallbackToAudioOnly == null) break;
        RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
            paramJson =
            RtcEngineEventHandlerOnRemoteSubscribeFallbackToAudioOnlyJson
                .fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? uid = paramJson.uid;
        bool? isFallbackOrRecover = paramJson.isFallbackOrRecover;
        if (uid == null || isFallbackOrRecover == null) {
          break;
        }
        onRemoteSubscribeFallbackToAudioOnly!(uid, isFallbackOrRecover);
        break;

      case 'onRemoteAudioTransportStatsEx':
        if (onRemoteAudioTransportStats == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onRemoteAudioTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onRemoteVideoTransportStatsEx':
        if (onRemoteVideoTransportStats == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onRemoteVideoTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onConnectionStateChangedEx':
        if (onConnectionStateChanged == null) break;
        RtcEngineEventHandlerOnConnectionStateChangedJson paramJson =
            RtcEngineEventHandlerOnConnectionStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        ConnectionStateType? state = paramJson.state;
        ConnectionChangedReasonType? reason = paramJson.reason;
        if (connection == null || state == null || reason == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onConnectionStateChanged!(connection, state, reason);
        break;

      case 'onWlAccMessageEx':
        if (onWlAccMessage == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onWlAccMessage!(connection, reason, action, wlAccMsg);
        break;

      case 'onWlAccStatsEx':
        if (onWlAccStats == null) break;
        RtcEngineEventHandlerOnWlAccStatsJson paramJson =
            RtcEngineEventHandlerOnWlAccStatsJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        WlAccStats? currentStats = paramJson.currentStats;
        WlAccStats? averageStats = paramJson.averageStats;
        if (connection == null ||
            currentStats == null ||
            averageStats == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        currentStats = currentStats.fillBuffers(buffers);
        averageStats = averageStats.fillBuffers(buffers);
        onWlAccStats!(connection, currentStats, averageStats);
        break;

      case 'onNetworkTypeChangedEx':
        if (onNetworkTypeChanged == null) break;
        RtcEngineEventHandlerOnNetworkTypeChangedJson paramJson =
            RtcEngineEventHandlerOnNetworkTypeChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        NetworkType? type = paramJson.type;
        if (connection == null || type == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onNetworkTypeChanged!(connection, type);
        break;

      case 'onEncryptionErrorEx':
        if (onEncryptionError == null) break;
        RtcEngineEventHandlerOnEncryptionErrorJson paramJson =
            RtcEngineEventHandlerOnEncryptionErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        EncryptionErrorType? errorType = paramJson.errorType;
        if (connection == null || errorType == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onEncryptionError!(connection, errorType);
        break;

      case 'onPermissionError':
        if (onPermissionError == null) break;
        RtcEngineEventHandlerOnPermissionErrorJson paramJson =
            RtcEngineEventHandlerOnPermissionErrorJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        PermissionType? permissionType = paramJson.permissionType;
        if (permissionType == null) {
          break;
        }
        onPermissionError!(permissionType);
        break;

      case 'onLocalUserRegistered':
        if (onLocalUserRegistered == null) break;
        RtcEngineEventHandlerOnLocalUserRegisteredJson paramJson =
            RtcEngineEventHandlerOnLocalUserRegisteredJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? uid = paramJson.uid;
        String? userAccount = paramJson.userAccount;
        if (uid == null || userAccount == null) {
          break;
        }
        onLocalUserRegistered!(uid, userAccount);
        break;

      case 'onUserInfoUpdated':
        if (onUserInfoUpdated == null) break;
        RtcEngineEventHandlerOnUserInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserInfoUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? uid = paramJson.uid;
        UserInfo? info = paramJson.info;
        if (uid == null || info == null) {
          break;
        }
        info = info.fillBuffers(buffers);
        onUserInfoUpdated!(uid, info);
        break;

      case 'onUploadLogResultEx':
        if (onUploadLogResult == null) break;
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
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUploadLogResult!(connection, requestId, success, reason);
        break;

      case 'onAudioSubscribeStateChanged':
        if (onAudioSubscribeStateChanged == null) break;
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
          break;
        }
        onAudioSubscribeStateChanged!(
            channel, uid, oldState, newState, elapseSinceLastState);
        break;

      case 'onVideoSubscribeStateChanged':
        if (onVideoSubscribeStateChanged == null) break;
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
          break;
        }
        onVideoSubscribeStateChanged!(
            channel, uid, oldState, newState, elapseSinceLastState);
        break;

      case 'onAudioPublishStateChanged':
        if (onAudioPublishStateChanged == null) break;
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
          break;
        }
        onAudioPublishStateChanged!(
            channel, oldState, newState, elapseSinceLastState);
        break;

      case 'onVideoPublishStateChanged':
        if (onVideoPublishStateChanged == null) break;
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
          break;
        }
        onVideoPublishStateChanged!(
            source, channel, oldState, newState, elapseSinceLastState);
        break;

      case 'onExtensionEvent':
        if (onExtensionEvent == null) break;
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
          break;
        }
        onExtensionEvent!(provider, extension, key, value);
        break;

      case 'onExtensionStarted':
        if (onExtensionStarted == null) break;
        RtcEngineEventHandlerOnExtensionStartedJson paramJson =
            RtcEngineEventHandlerOnExtensionStartedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? provider = paramJson.provider;
        String? extension = paramJson.extension;
        if (provider == null || extension == null) {
          break;
        }
        onExtensionStarted!(provider, extension);
        break;

      case 'onExtensionStopped':
        if (onExtensionStopped == null) break;
        RtcEngineEventHandlerOnExtensionStoppedJson paramJson =
            RtcEngineEventHandlerOnExtensionStoppedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? provider = paramJson.provider;
        String? extension = paramJson.extension;
        if (provider == null || extension == null) {
          break;
        }
        onExtensionStopped!(provider, extension);
        break;

      case 'onExtensionError':
        if (onExtensionError == null) break;
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
          break;
        }
        onExtensionError!(provider, extension, error, message);
        break;

      case 'onUserAccountUpdatedEx':
        if (onUserAccountUpdated == null) break;
        RtcEngineEventHandlerOnUserAccountUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserAccountUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        String? userAccount = paramJson.userAccount;
        if (connection == null || remoteUid == null || userAccount == null) {
          break;
        }
        connection = connection.fillBuffers(buffers);
        onUserAccountUpdated!(connection, remoteUid, userAccount);
        break;
      default:
        break;
    }
  }
}

class RtcEngineEventHandlerWrapper implements IrisEventHandler {
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('RtcEngineEventHandler')) return;
    rtcEngineEventHandler.process(event, data, buffers);
  }
}

extension MetadataObserverExt on MetadataObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MetadataObserver_onMetadataReceived':
        if (onMetadataReceived == null) break;
        MetadataObserverOnMetadataReceivedJson paramJson =
            MetadataObserverOnMetadataReceivedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        Metadata? metadata = paramJson.metadata;
        if (metadata == null) {
          break;
        }
        metadata = metadata.fillBuffers(buffers);
        onMetadataReceived!(metadata);
        break;
      default:
        break;
    }
  }
}

class MetadataObserverWrapper implements IrisEventHandler {
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('MetadataObserver')) return;
    metadataObserver.process(event, data, buffers);
  }
}

extension DirectCdnStreamingEventHandlerExt on DirectCdnStreamingEventHandler {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'DirectCdnStreamingEventHandler_onDirectCdnStreamingStateChanged':
        if (onDirectCdnStreamingStateChanged == null) break;
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
            paramJson =
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStateChangedJson
                .fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        DirectCdnStreamingState? state = paramJson.state;
        DirectCdnStreamingError? error = paramJson.error;
        String? message = paramJson.message;
        if (state == null || error == null || message == null) {
          break;
        }
        onDirectCdnStreamingStateChanged!(state, error, message);
        break;

      case 'DirectCdnStreamingEventHandler_onDirectCdnStreamingStats':
        if (onDirectCdnStreamingStats == null) break;
        DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson paramJson =
            DirectCdnStreamingEventHandlerOnDirectCdnStreamingStatsJson
                .fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        DirectCdnStreamingStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        stats = stats.fillBuffers(buffers);
        onDirectCdnStreamingStats!(stats);
        break;
      default:
        break;
    }
  }
}

class DirectCdnStreamingEventHandlerWrapper implements IrisEventHandler {
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('DirectCdnStreamingEventHandler')) return;
    directCdnStreamingEventHandler.process(event, data, buffers);
  }
}
