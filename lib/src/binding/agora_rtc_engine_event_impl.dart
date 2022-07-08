import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

extension RtcEngineEventHandlerExt on RtcEngineEventHandler {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'onJoinChannelSuccessEx':
        if (onJoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnJoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnJoinChannelSuccessJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onJoinChannelSuccess!(connection, elapsed);
        break;

      case 'onRejoinChannelSuccessEx':
        if (onRejoinChannelSuccess == null) break;
        RtcEngineEventHandlerOnRejoinChannelSuccessJson paramJson =
            RtcEngineEventHandlerOnRejoinChannelSuccessJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onRejoinChannelSuccess!(connection, elapsed);
        break;

      case 'onWarning':
        if (onWarning == null) break;
        RtcEngineEventHandlerOnWarningJson paramJson =
            RtcEngineEventHandlerOnWarningJson.fromJson(jsonMap);
        WarnCodeType? warn = paramJson.warn;
        String? msg = paramJson.msg;
        if (warn == null || msg == null) {
          break;
        }
        onWarning!(warn, msg);
        break;

      case 'onError':
        if (onError == null) break;
        RtcEngineEventHandlerOnErrorJson paramJson =
            RtcEngineEventHandlerOnErrorJson.fromJson(jsonMap);
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
        onAudioQuality!(connection, remoteUid, quality, delay, lost);
        break;

      case 'onLastmileProbeResult':
        if (onLastmileProbeResult == null) break;
        RtcEngineEventHandlerOnLastmileProbeResultJson paramJson =
            RtcEngineEventHandlerOnLastmileProbeResultJson.fromJson(jsonMap);
        LastmileProbeResult? result = paramJson.result;
        if (result == null) {
          break;
        }
        onLastmileProbeResult!(result);
        break;

      case 'onAudioVolumeIndicationEx':
        if (onAudioVolumeIndication == null) break;
        RtcEngineEventHandlerOnAudioVolumeIndicationJson paramJson =
            RtcEngineEventHandlerOnAudioVolumeIndicationJson.fromJson(jsonMap);
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
        onAudioVolumeIndication!(
            connection, speakers, speakerNumber, totalVolume);
        break;

      case 'onLeaveChannelEx':
        if (onLeaveChannel == null) break;
        RtcEngineEventHandlerOnLeaveChannelJson paramJson =
            RtcEngineEventHandlerOnLeaveChannelJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLeaveChannel!(connection, stats);
        break;

      case 'onRtcStatsEx':
        if (onRtcStats == null) break;
        RtcEngineEventHandlerOnRtcStatsJson paramJson =
            RtcEngineEventHandlerOnRtcStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RtcStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRtcStats!(connection, stats);
        break;

      case 'onAudioDeviceStateChanged':
        if (onAudioDeviceStateChanged == null) break;
        RtcEngineEventHandlerOnAudioDeviceStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceStateChangedJson.fromJson(
                jsonMap);
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
        onAudioMixingFinished!();
        break;

      case 'onAudioEffectFinished':
        if (onAudioEffectFinished == null) break;
        RtcEngineEventHandlerOnAudioEffectFinishedJson paramJson =
            RtcEngineEventHandlerOnAudioEffectFinishedJson.fromJson(jsonMap);
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
        onNetworkQuality!(connection, remoteUid, txQuality, rxQuality);
        break;

      case 'onIntraRequestReceivedEx':
        if (onIntraRequestReceived == null) break;
        RtcEngineEventHandlerOnIntraRequestReceivedJson paramJson =
            RtcEngineEventHandlerOnIntraRequestReceivedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onIntraRequestReceived!(connection);
        break;

      case 'onUplinkNetworkInfoUpdated':
        if (onUplinkNetworkInfoUpdated == null) break;
        RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnUplinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        UplinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        onUplinkNetworkInfoUpdated!(info);
        break;

      case 'onDownlinkNetworkInfoUpdated':
        if (onDownlinkNetworkInfoUpdated == null) break;
        RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson paramJson =
            RtcEngineEventHandlerOnDownlinkNetworkInfoUpdatedJson.fromJson(
                jsonMap);
        DownlinkNetworkInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        onDownlinkNetworkInfoUpdated!(info);
        break;

      case 'onLastmileQuality':
        if (onLastmileQuality == null) break;
        RtcEngineEventHandlerOnLastmileQualityJson paramJson =
            RtcEngineEventHandlerOnLastmileQualityJson.fromJson(jsonMap);
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
        onFirstLocalVideoFrame!(connection, width, height, elapsed);
        break;

      case 'onFirstLocalVideoFramePublishedEx':
        if (onFirstLocalVideoFramePublished == null) break;
        RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalVideoFramePublishedJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onFirstLocalVideoFramePublished!(connection, elapsed);
        break;

      case 'onVideoSourceFrameSizeChangedEx':
        if (onVideoSourceFrameSizeChanged == null) break;
        RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSourceFrameSizeChangedJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        VideoSourceType? sourceType = paramJson.sourceType;
        int? width = paramJson.width;
        int? height = paramJson.height;
        if (connection == null ||
            sourceType == null ||
            width == null ||
            height == null) {
          break;
        }
        onVideoSourceFrameSizeChanged!(connection, sourceType, width, height);
        break;

      case 'onFirstRemoteVideoDecodedEx':
        if (onFirstRemoteVideoDecoded == null) break;
        RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteVideoDecodedJson.fromJson(
                jsonMap);
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
        onFirstRemoteVideoDecoded!(
            connection, remoteUid, width, height, elapsed);
        break;

      case 'onVideoSizeChangedEx':
        if (onVideoSizeChanged == null) break;
        RtcEngineEventHandlerOnVideoSizeChangedJson paramJson =
            RtcEngineEventHandlerOnVideoSizeChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? rotation = paramJson.rotation;
        if (connection == null ||
            uid == null ||
            width == null ||
            height == null ||
            rotation == null) {
          break;
        }
        onVideoSizeChanged!(connection, uid, width, height, rotation);
        break;

      case 'onLocalVideoStateChangedEx':
        if (onLocalVideoStateChanged == null) break;
        RtcEngineEventHandlerOnLocalVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStreamState? state = paramJson.state;
        LocalVideoStreamError? errorCode = paramJson.errorCode;
        if (connection == null || state == null || errorCode == null) {
          break;
        }
        onLocalVideoStateChanged!(connection, state, errorCode);
        break;

      case 'onRemoteVideoStateChangedEx':
        if (onRemoteVideoStateChanged == null) break;
        RtcEngineEventHandlerOnRemoteVideoStateChangedJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStateChangedJson.fromJson(
                jsonMap);
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
        onRemoteVideoStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onFirstRemoteVideoFrameEx':
        if (onFirstRemoteVideoFrame == null) break;
        RtcEngineEventHandlerOnFirstRemoteVideoFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteVideoFrameJson.fromJson(jsonMap);
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
        onFirstRemoteVideoFrame!(connection, remoteUid, width, height, elapsed);
        break;

      case 'onUserJoinedEx':
        if (onUserJoined == null) break;
        RtcEngineEventHandlerOnUserJoinedJson paramJson =
            RtcEngineEventHandlerOnUserJoinedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || remoteUid == null || elapsed == null) {
          break;
        }
        onUserJoined!(connection, remoteUid, elapsed);
        break;

      case 'onUserOfflineEx':
        if (onUserOffline == null) break;
        RtcEngineEventHandlerOnUserOfflineJson paramJson =
            RtcEngineEventHandlerOnUserOfflineJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        UserOfflineReasonType? reason = paramJson.reason;
        if (connection == null || remoteUid == null || reason == null) {
          break;
        }
        onUserOffline!(connection, remoteUid, reason);
        break;

      case 'onUserMuteAudioEx':
        if (onUserMuteAudio == null) break;
        RtcEngineEventHandlerOnUserMuteAudioJson paramJson =
            RtcEngineEventHandlerOnUserMuteAudioJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        onUserMuteAudio!(connection, remoteUid, muted);
        break;

      case 'onUserMuteVideoEx':
        if (onUserMuteVideo == null) break;
        RtcEngineEventHandlerOnUserMuteVideoJson paramJson =
            RtcEngineEventHandlerOnUserMuteVideoJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? muted = paramJson.muted;
        if (connection == null || remoteUid == null || muted == null) {
          break;
        }
        onUserMuteVideo!(connection, remoteUid, muted);
        break;

      case 'onUserEnableVideoEx':
        if (onUserEnableVideo == null) break;
        RtcEngineEventHandlerOnUserEnableVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableVideoJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        onUserEnableVideo!(connection, remoteUid, enabled);
        break;

      case 'onUserStateChangedEx':
        if (onUserStateChanged == null) break;
        RtcEngineEventHandlerOnUserStateChangedJson paramJson =
            RtcEngineEventHandlerOnUserStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        int? state = paramJson.state;
        if (connection == null || remoteUid == null || state == null) {
          break;
        }
        onUserStateChanged!(connection, remoteUid, state);
        break;

      case 'onUserEnableLocalVideoEx':
        if (onUserEnableLocalVideo == null) break;
        RtcEngineEventHandlerOnUserEnableLocalVideoJson paramJson =
            RtcEngineEventHandlerOnUserEnableLocalVideoJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        bool? enabled = paramJson.enabled;
        if (connection == null || remoteUid == null || enabled == null) {
          break;
        }
        onUserEnableLocalVideo!(connection, remoteUid, enabled);
        break;

      case 'onApiCallExecuted':
        if (onApiCallExecuted == null) break;
        RtcEngineEventHandlerOnApiCallExecutedJson paramJson =
            RtcEngineEventHandlerOnApiCallExecutedJson.fromJson(jsonMap);
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
        RtcConnection? connection = paramJson.connection;
        LocalAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLocalAudioStats!(connection, stats);
        break;

      case 'onRemoteAudioStatsEx':
        if (onRemoteAudioStats == null) break;
        RtcEngineEventHandlerOnRemoteAudioStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RemoteAudioStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRemoteAudioStats!(connection, stats);
        break;

      case 'onLocalVideoStatsEx':
        if (onLocalVideoStats == null) break;
        RtcEngineEventHandlerOnLocalVideoStatsJson paramJson =
            RtcEngineEventHandlerOnLocalVideoStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onLocalVideoStats!(connection, stats);
        break;

      case 'onRemoteVideoStatsEx':
        if (onRemoteVideoStats == null) break;
        RtcEngineEventHandlerOnRemoteVideoStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoStatsJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        RemoteVideoStats? stats = paramJson.stats;
        if (connection == null || stats == null) {
          break;
        }
        onRemoteVideoStats!(connection, stats);
        break;

      case 'onCameraReady':
        if (onCameraReady == null) break;
        RtcEngineEventHandlerOnCameraReadyJson paramJson =
            RtcEngineEventHandlerOnCameraReadyJson.fromJson(jsonMap);
        onCameraReady!();
        break;

      case 'onCameraFocusAreaChanged':
        if (onCameraFocusAreaChanged == null) break;
        RtcEngineEventHandlerOnCameraFocusAreaChangedJson paramJson =
            RtcEngineEventHandlerOnCameraFocusAreaChangedJson.fromJson(jsonMap);
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
          break;
        }
        onFacePositionChanged!(
            imageWidth, imageHeight, vecRectangle, vecDistance, numFaces);
        break;

      case 'onVideoStopped':
        if (onVideoStopped == null) break;
        RtcEngineEventHandlerOnVideoStoppedJson paramJson =
            RtcEngineEventHandlerOnVideoStoppedJson.fromJson(jsonMap);
        onVideoStopped!();
        break;

      case 'onAudioMixingStateChanged':
        if (onAudioMixingStateChanged == null) break;
        RtcEngineEventHandlerOnAudioMixingStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioMixingStateChangedJson.fromJson(
                jsonMap);
        AudioMixingStateType? state = paramJson.state;
        AudioMixingErrorType? errorCode = paramJson.errorCode;
        if (state == null || errorCode == null) {
          break;
        }
        onAudioMixingStateChanged!(state, errorCode);
        break;

      case 'onRhythmPlayerStateChanged':
        if (onRhythmPlayerStateChanged == null) break;
        RtcEngineEventHandlerOnRhythmPlayerStateChangedJson paramJson =
            RtcEngineEventHandlerOnRhythmPlayerStateChangedJson.fromJson(
                jsonMap);
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
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionLost!(connection);
        break;

      case 'onConnectionInterruptedEx':
        if (onConnectionInterrupted == null) break;
        RtcEngineEventHandlerOnConnectionInterruptedJson paramJson =
            RtcEngineEventHandlerOnConnectionInterruptedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionInterrupted!(connection);
        break;

      case 'onConnectionBannedEx':
        if (onConnectionBanned == null) break;
        RtcEngineEventHandlerOnConnectionBannedJson paramJson =
            RtcEngineEventHandlerOnConnectionBannedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onConnectionBanned!(connection);
        break;

      case 'onStreamMessageEx':
        if (onStreamMessage == null) break;
        RtcEngineEventHandlerOnStreamMessageJson paramJson =
            RtcEngineEventHandlerOnStreamMessageJson.fromJson(jsonMap);
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
        onStreamMessage!(connection, remoteUid, streamId, data, length, sentTs);
        break;

      case 'onStreamMessageErrorEx':
        if (onStreamMessageError == null) break;
        RtcEngineEventHandlerOnStreamMessageErrorJson paramJson =
            RtcEngineEventHandlerOnStreamMessageErrorJson.fromJson(jsonMap);
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
        onStreamMessageError!(
            connection, remoteUid, streamId, code, missed, cached);
        break;

      case 'onRequestTokenEx':
        if (onRequestToken == null) break;
        RtcEngineEventHandlerOnRequestTokenJson paramJson =
            RtcEngineEventHandlerOnRequestTokenJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        if (connection == null) {
          break;
        }
        onRequestToken!(connection);
        break;

      case 'onTokenPrivilegeWillExpireEx':
        if (onTokenPrivilegeWillExpire == null) break;
        RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson paramJson =
            RtcEngineEventHandlerOnTokenPrivilegeWillExpireJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        String? token = paramJson.token;
        if (connection == null || token == null) {
          break;
        }
        onTokenPrivilegeWillExpire!(connection, token);
        break;

      case 'onFirstLocalAudioFramePublishedEx':
        if (onFirstLocalAudioFramePublished == null) break;
        RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson paramJson =
            RtcEngineEventHandlerOnFirstLocalAudioFramePublishedJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? elapsed = paramJson.elapsed;
        if (connection == null || elapsed == null) {
          break;
        }
        onFirstLocalAudioFramePublished!(connection, elapsed);
        break;

      case 'onFirstRemoteAudioFrameEx':
        if (onFirstRemoteAudioFrame == null) break;
        RtcEngineEventHandlerOnFirstRemoteAudioFrameJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioFrameJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? userId = paramJson.userId;
        int? elapsed = paramJson.elapsed;
        if (connection == null || userId == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioFrame!(connection, userId, elapsed);
        break;

      case 'onFirstRemoteAudioDecodedEx':
        if (onFirstRemoteAudioDecoded == null) break;
        RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson paramJson =
            RtcEngineEventHandlerOnFirstRemoteAudioDecodedJson.fromJson(
                jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        int? elapsed = paramJson.elapsed;
        if (connection == null || uid == null || elapsed == null) {
          break;
        }
        onFirstRemoteAudioDecoded!(connection, uid, elapsed);
        break;

      case 'onLocalAudioStateChangedEx':
        if (onLocalAudioStateChanged == null) break;
        RtcEngineEventHandlerOnLocalAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnLocalAudioStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        LocalAudioStreamState? state = paramJson.state;
        LocalAudioStreamError? error = paramJson.error;
        if (connection == null || state == null || error == null) {
          break;
        }
        onLocalAudioStateChanged!(connection, state, error);
        break;

      case 'onRemoteAudioStateChangedEx':
        if (onRemoteAudioStateChanged == null) break;
        RtcEngineEventHandlerOnRemoteAudioStateChangedJson paramJson =
            RtcEngineEventHandlerOnRemoteAudioStateChangedJson.fromJson(
                jsonMap);
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
        onRemoteAudioStateChanged!(
            connection, remoteUid, state, reason, elapsed);
        break;

      case 'onActiveSpeakerEx':
        if (onActiveSpeaker == null) break;
        RtcEngineEventHandlerOnActiveSpeakerJson paramJson =
            RtcEngineEventHandlerOnActiveSpeakerJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? uid = paramJson.uid;
        if (connection == null || uid == null) {
          break;
        }
        onActiveSpeaker!(connection, uid);
        break;

      case 'onContentInspectResultEx':
        if (onContentInspectResult == null) break;
        RtcEngineEventHandlerOnContentInspectResultJson paramJson =
            RtcEngineEventHandlerOnContentInspectResultJson.fromJson(jsonMap);
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
        RtcConnection? connection = paramJson.connection;
        String? filePath = paramJson.filePath;
        int? width = paramJson.width;
        int? height = paramJson.height;
        int? errCode = paramJson.errCode;
        if (connection == null ||
            filePath == null ||
            width == null ||
            height == null ||
            errCode == null) {
          break;
        }
        onSnapshotTaken!(connection, filePath, width, height, errCode);
        break;

      case 'onClientRoleChangedEx':
        if (onClientRoleChanged == null) break;
        RtcEngineEventHandlerOnClientRoleChangedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        ClientRoleType? oldRole = paramJson.oldRole;
        ClientRoleType? newRole = paramJson.newRole;
        if (connection == null || oldRole == null || newRole == null) {
          break;
        }
        onClientRoleChanged!(connection, oldRole, newRole);
        break;

      case 'onClientRoleChangeFailedEx':
        if (onClientRoleChangeFailed == null) break;
        RtcEngineEventHandlerOnClientRoleChangeFailedJson paramJson =
            RtcEngineEventHandlerOnClientRoleChangeFailedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        ClientRoleChangeFailedReason? reason = paramJson.reason;
        ClientRoleType? currentRole = paramJson.currentRole;
        if (connection == null || reason == null || currentRole == null) {
          break;
        }
        onClientRoleChangeFailed!(connection, reason, currentRole);
        break;

      case 'onAudioDeviceVolumeChanged':
        if (onAudioDeviceVolumeChanged == null) break;
        RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson paramJson =
            RtcEngineEventHandlerOnAudioDeviceVolumeChangedJson.fromJson(
                jsonMap);
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
        String? url = paramJson.url;
        RtmpStreamingEvent? eventCode = paramJson.eventCode;
        if (url == null || eventCode == null) {
          break;
        }
        onRtmpStreamingEvent!(url, eventCode);
        break;

      case 'onStreamPublished':
        if (onStreamPublished == null) break;
        RtcEngineEventHandlerOnStreamPublishedJson paramJson =
            RtcEngineEventHandlerOnStreamPublishedJson.fromJson(jsonMap);
        String? url = paramJson.url;
        ErrorCodeType? error = paramJson.error;
        if (url == null || error == null) {
          break;
        }
        onStreamPublished!(url, error);
        break;

      case 'onStreamUnpublished':
        if (onStreamUnpublished == null) break;
        RtcEngineEventHandlerOnStreamUnpublishedJson paramJson =
            RtcEngineEventHandlerOnStreamUnpublishedJson.fromJson(jsonMap);
        String? url = paramJson.url;
        if (url == null) {
          break;
        }
        onStreamUnpublished!(url);
        break;

      case 'onTranscodingUpdated':
        if (onTranscodingUpdated == null) break;
        RtcEngineEventHandlerOnTranscodingUpdatedJson paramJson =
            RtcEngineEventHandlerOnTranscodingUpdatedJson.fromJson(jsonMap);
        onTranscodingUpdated!();
        break;

      case 'onAudioRoutingChanged':
        if (onAudioRoutingChanged == null) break;
        RtcEngineEventHandlerOnAudioRoutingChangedJson paramJson =
            RtcEngineEventHandlerOnAudioRoutingChangedJson.fromJson(jsonMap);
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
        onRemoteAudioTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onRemoteVideoTransportStatsEx':
        if (onRemoteVideoTransportStats == null) break;
        RtcEngineEventHandlerOnRemoteVideoTransportStatsJson paramJson =
            RtcEngineEventHandlerOnRemoteVideoTransportStatsJson.fromJson(
                jsonMap);
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
        onRemoteVideoTransportStats!(
            connection, remoteUid, delay, lost, rxKBitRate);
        break;

      case 'onConnectionStateChangedEx':
        if (onConnectionStateChanged == null) break;
        RtcEngineEventHandlerOnConnectionStateChangedJson paramJson =
            RtcEngineEventHandlerOnConnectionStateChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        ConnectionStateType? state = paramJson.state;
        ConnectionChangedReasonType? reason = paramJson.reason;
        if (connection == null || state == null || reason == null) {
          break;
        }
        onConnectionStateChanged!(connection, state, reason);
        break;

      case 'onNetworkTypeChangedEx':
        if (onNetworkTypeChanged == null) break;
        RtcEngineEventHandlerOnNetworkTypeChangedJson paramJson =
            RtcEngineEventHandlerOnNetworkTypeChangedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        NetworkType? type = paramJson.type;
        if (connection == null || type == null) {
          break;
        }
        onNetworkTypeChanged!(connection, type);
        break;

      case 'onEncryptionErrorEx':
        if (onEncryptionError == null) break;
        RtcEngineEventHandlerOnEncryptionErrorJson paramJson =
            RtcEngineEventHandlerOnEncryptionErrorJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        EncryptionErrorType? errorType = paramJson.errorType;
        if (connection == null || errorType == null) {
          break;
        }
        onEncryptionError!(connection, errorType);
        break;

      case 'onPermissionError':
        if (onPermissionError == null) break;
        RtcEngineEventHandlerOnPermissionErrorJson paramJson =
            RtcEngineEventHandlerOnPermissionErrorJson.fromJson(jsonMap);
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
        int? uid = paramJson.uid;
        UserInfo? info = paramJson.info;
        if (uid == null || info == null) {
          break;
        }
        onUserInfoUpdated!(uid, info);
        break;

      case 'onUploadLogResultEx':
        if (onUploadLogResult == null) break;
        RtcEngineEventHandlerOnUploadLogResultJson paramJson =
            RtcEngineEventHandlerOnUploadLogResultJson.fromJson(jsonMap);
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
        onUploadLogResult!(connection, requestId, success, reason);
        break;

      case 'onAudioSubscribeStateChanged':
        if (onAudioSubscribeStateChanged == null) break;
        RtcEngineEventHandlerOnAudioSubscribeStateChangedJson paramJson =
            RtcEngineEventHandlerOnAudioSubscribeStateChangedJson.fromJson(
                jsonMap);
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
        onVideoPublishStateChanged!(
            channel, oldState, newState, elapseSinceLastState);
        break;

      case 'onExtensionEvent':
        if (onExtensionEvent == null) break;
        RtcEngineEventHandlerOnExtensionEventJson paramJson =
            RtcEngineEventHandlerOnExtensionEventJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        String? key = paramJson.key;
        String? value = paramJson.value;
        if (provider == null ||
            extName == null ||
            key == null ||
            value == null) {
          break;
        }
        onExtensionEvent!(provider, extName, key, value);
        break;

      case 'onExtensionStarted':
        if (onExtensionStarted == null) break;
        RtcEngineEventHandlerOnExtensionStartedJson paramJson =
            RtcEngineEventHandlerOnExtensionStartedJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        if (provider == null || extName == null) {
          break;
        }
        onExtensionStarted!(provider, extName);
        break;

      case 'onExtensionStopped':
        if (onExtensionStopped == null) break;
        RtcEngineEventHandlerOnExtensionStoppedJson paramJson =
            RtcEngineEventHandlerOnExtensionStoppedJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        if (provider == null || extName == null) {
          break;
        }
        onExtensionStopped!(provider, extName);
        break;

      case 'onExtensionErrored':
        if (onExtensionErrored == null) break;
        RtcEngineEventHandlerOnExtensionErroredJson paramJson =
            RtcEngineEventHandlerOnExtensionErroredJson.fromJson(jsonMap);
        String? provider = paramJson.provider;
        String? extName = paramJson.extName;
        int? error = paramJson.error;
        String? msg = paramJson.msg;
        if (provider == null ||
            extName == null ||
            error == null ||
            msg == null) {
          break;
        }
        onExtensionErrored!(provider, extName, error, msg);
        break;

      case 'onUserAccountUpdatedEx':
        if (onUserAccountUpdated == null) break;
        RtcEngineEventHandlerOnUserAccountUpdatedJson paramJson =
            RtcEngineEventHandlerOnUserAccountUpdatedJson.fromJson(jsonMap);
        RtcConnection? connection = paramJson.connection;
        int? remoteUid = paramJson.remoteUid;
        String? userAccount = paramJson.userAccount;
        if (connection == null || remoteUid == null || userAccount == null) {
          break;
        }
        onUserAccountUpdated!(connection, remoteUid, userAccount);
        break;
      default:
        break;
    }
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
        Metadata? metadata = paramJson.metadata;
        if (metadata == null) {
          break;
        }
        onMetadataReceived!(metadata);
        break;
      default:
        break;
    }
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
        DirectCdnStreamingStats? stats = paramJson.stats;
        if (stats == null) {
          break;
        }
        onDirectCdnStreamingStats!(stats);
        break;
      default:
        break;
    }
  }
}
