import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/classes.dart';
import 'package:agora_rtc_engine/src/rtc_engine_event_handler.dart';

import 'enum_converter.dart';
import 'event_handler_json.dart';

// ignore_for_file: public_member_api_docs,deprecated_member_use_from_same_package

extension RtcEngineEventHandlerExt on RtcEngineEventHandler {
  void process(String methodName, dynamic data, [Uint8List? buffer]) {
    List<dynamic> newData;

    if (methodName.startsWith('on')) {
      methodName = methodName.substring(2);
    }

    final dataMap = jsonDecode(data as String);
    newData = List<dynamic>.from(Map<String, dynamic>.from(dataMap).values);
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter.fromValue(newData[0]).e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter.fromValue(newData[0]).e);
        break;
      case 'ApiCallExecuted':
        apiCallExecuted?.call(
            ErrorCodeConverter.fromValue(newData[0]).e, newData[1], newData[2]);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(newData[0], newData[1], newData[2]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess?.call(newData[0], newData[1], newData[2]);
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'LocalUserRegistered':
        localUserRegistered?.call(newData[0], newData[1]);
        break;
      case 'UserInfoUpdated':
        userInfoUpdated?.call(newData[0],
            UserInfo.fromJson(Map<String, dynamic>.from(newData[1])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter.fromValue(newData[0]).e,
            ClientRoleConverter.fromValue(newData[1]).e);
        break;
      case 'UserJoined':
        userJoined?.call(newData[0], newData[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            newData[0], UserOfflineReasonConverter.fromValue(newData[1]).e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter.fromValue(newData[0]).e,
            ConnectionChangedReasonConverter.fromValue(newData[1]).e);
        break;
      case 'NetworkTypeChanged':
        networkTypeChanged?.call(NetworkTypeConverter.fromValue(newData[0]).e);
        break;
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(newData[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'AudioVolumeIndication':
        final list = List<Map>.from(newData[0] ?? []);
        int totalVolume;
        totalVolume = newData[2];
        audioVolumeIndication?.call(
            List.generate(
                list.length,
                (index) => AudioVolumeInfo.fromJson(
                    Map<String, dynamic>.from(list[index]))),
            totalVolume);
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(newData[0]);
        break;
      case 'FirstLocalAudioFrame':
        firstLocalAudioFrame?.call(newData[0]);
        break;
      case 'FirstLocalVideoFrame':
        firstLocalVideoFrame?.call(newData[0], newData[1], newData[2]);
        break;
      case 'UserMuteVideo':
        userMuteVideo?.call(newData[0], newData[1]);
        break;
      case 'VideoSizeChanged':
        videoSizeChanged?.call(newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'RemoteVideoStateChanged':
        remoteVideoStateChanged?.call(
            newData[0],
            VideoRemoteStateConverter.fromValue(newData[1]).e,
            VideoRemoteStateReasonConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'LocalVideoStateChanged':
        localVideoStateChanged?.call(
            LocalVideoStreamStateConverter.fromValue(newData[0]).e,
            LocalVideoStreamErrorConverter.fromValue(newData[1]).e);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            newData[0],
            AudioRemoteStateConverter.fromValue(newData[1]).e,
            AudioRemoteStateReasonConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'LocalAudioStateChanged':
        localAudioStateChanged?.call(
            AudioLocalStateConverter.fromValue(newData[0]).e,
            AudioLocalErrorConverter.fromValue(newData[1]).e);
        break;
      case 'RequestAudioFileInfo':
        requestAudioFileInfoCallback?.call(AudioFileInfo.fromJson(newData[0]),
            AudioFileInfoErrorConverter.fromValue(newData[1]).e);

        requestAudioFileInfo?.call(AudioFileInfo.fromJson(newData[0]),
            AudioFileInfoErrorConverter.fromValue(newData[1]).e);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(newData[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(newData[0], newData[1]);
        break;
      case 'AudioRouteChanged':
        audioRouteChanged
            ?.call(AudioOutputRoutingConverter.fromValue(newData[0]).e);
        break;
      case 'CameraFocusAreaChanged':
        if (cameraFocusAreaChanged != null) {
          // TODO(littlegnal): Optimize this logic
          final rect = Rect(); // Rect.fromJson(newData[0]);
          rect.x = newData[0];
          rect.y = newData[1];
          rect.width = newData[2];
          rect.height = newData[3];
          rect.left = rect.x;
          rect.top = rect.y;
          rect.right = rect.x + rect.width;
          rect.bottom = rect.y + rect.height;
          cameraFocusAreaChanged!(rect);
        }

        break;
      case 'CameraExposureAreaChanged':
        if (cameraExposureAreaChanged != null) {
          // TODO(littlegnal): Optimize this logic
          final rect = Rect(); // Rect.fromJson(newData[0]);
          rect.x = newData[0];
          rect.y = newData[1];
          rect.width = newData[2];
          rect.height = newData[3];
          rect.left = rect.x;
          rect.top = rect.y;
          rect.right = rect.x + rect.width;
          rect.bottom = rect.y + rect.height;
          cameraExposureAreaChanged!(rect);
        }
        break;
      case 'FacePositionChanged':
        if (facePositionChanged != null) {
          final rectList = List<Map>.from(newData[2]);
          final distanceList = List<int>.from(newData[3]);
          final faceInfos = List.generate(
            rectList.length,
            (index) {
              final rect = rectList[index];
              rect['distance'] = distanceList[index];
              final info =
                  FacePositionInfo.fromJson(Map<String, dynamic>.from(rect));
              return info;
            },
          );
          facePositionChanged!(newData[0], newData[1], faceInfos);
        }

        break;
      case 'RtcStats':
        rtcStats
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'LastmileQuality':
        lastmileQuality?.call(NetworkQualityConverter.fromValue(newData[0]).e);
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            newData[0],
            NetworkQualityConverter.fromValue(newData[1]).e,
            NetworkQualityConverter.fromValue(newData[2]).e);
        break;
      case 'LastmileProbeResult':
        lastmileProbeResult?.call(LastmileProbeResult.fromJson(
            Map<String, dynamic>.from(newData[0])));
        break;
      case 'LocalVideoStats':
        localVideoStats?.call(
            LocalVideoStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'LocalAudioStats':
        localAudioStats?.call(
            LocalAudioStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'AudioMixingFinished':
        audioMixingFinished?.call();
        break;
      case 'AudioMixingStateChanged':
        audioMixingStateChanged?.call(
          AudioMixingStateCodeConverter.fromValue(newData[0]).e,
          AudioMixingReasonConverter.fromValue(newData[1]).e,
        );
        break;
      case 'AudioEffectFinished':
        audioEffectFinished?.call(newData[0]);
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          newData[0],
          RtmpStreamingStateConverter.fromValue(newData[1]).e,
          RtmpStreamingErrorCodeConverter.fromValue(newData[2]).e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(newData[0], newData[1],
            InjectStreamStatusConverter.fromValue(newData[2]).e);
        break;
      case 'StreamMessage':
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

        // } else {
        //   String data = newData[2];
        //   streamMessage?.call(
        //       newData[0], newData[1], Uint8List.fromList(data.codeUnits));
        // }
        if (buffer == null) return;
        streamMessage?.call(newData[0], newData[1], buffer);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(newData[0], newData[1],
            ErrorCodeConverter.fromValue(newData[2]).e, newData[3], newData[4]);
        break;
      case 'MediaEngineLoadSuccess':
        mediaEngineLoadSuccess?.call();
        break;
      case 'MediaEngineStartCallSuccess':
        mediaEngineStartCallSuccess?.call();
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter.fromValue(newData[0]).e,
          ChannelMediaRelayErrorConverter.fromValue(newData[1]).e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter.fromValue(newData[0]).e);
        break;
      case 'FirstRemoteVideoFrame':
        firstRemoteVideoFrame?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'FirstRemoteAudioFrame':
        firstRemoteAudioFrame?.call(newData[0], newData[1]);
        break;
      case 'FirstRemoteAudioDecoded':
        firstRemoteAudioDecoded?.call(newData[0], newData[1]);
        break;
      case 'UserMuteAudio':
        userMuteAudio?.call(newData[0], newData[1]);
        break;
      case 'StreamPublished':
        streamPublished?.call(
            newData[0], ErrorCodeConverter.fromValue(newData[1]).e);
        break;
      case 'StreamUnpublished':
        streamUnpublished?.call(newData[0]);
        break;
      case 'RemoteAudioTransportStats':
        remoteAudioTransportStats?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'RemoteVideoTransportStats':
        remoteVideoTransportStats?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'UserEnableVideo':
        userEnableVideo?.call(newData[0], newData[1]);
        break;
      case 'UserEnableLocalVideo':
        userEnableLocalVideo?.call(newData[0], newData[1]);
        break;
      case 'FirstRemoteVideoDecoded':
        firstRemoteVideoDecoded?.call(
            newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'MicrophoneEnabled':
        microphoneEnabled?.call(newData[0]);
        break;
      case 'ConnectionInterrupted':
        connectionInterrupted?.call();
        break;
      case 'ConnectionBanned':
        connectionBanned?.call();
        break;
      case 'AudioQuality':
        audioQuality?.call(newData[0], newData[1], newData[2], newData[3]);
        break;
      case 'CameraReady':
        cameraReady?.call();
        break;
      case 'VideoStopped':
        videoStopped?.call();
        break;
      case 'MetadataReceived':
        Metadata metadata;
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

        // } else {
        //   metadata = Metadata(newData[1], newData[2]);
        //   String buffer = newData[0];
        //   metadata.buffer = Uint8List.fromList(buffer.codeUnits);
        // }
        if (buffer == null) return;
        metadata = Metadata.fromJson(Map<String, dynamic>.from(newData[0]));
        metadata.buffer = buffer;
        metadataReceived?.call(metadata);
        break;
      case 'FirstLocalAudioFramePublished':
        firstLocalAudioFramePublished?.call(newData[0]);
        break;
      case 'FirstLocalVideoFramePublished':
        firstLocalVideoFramePublished?.call(newData[0]);
        break;
      case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            newData[0],
            StreamPublishStateConverter.fromValue(newData[1]).e,
            StreamPublishStateConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            newData[0],
            StreamPublishStateConverter.fromValue(newData[1]).e,
            StreamPublishStateConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            newData[0],
            newData[1],
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            StreamSubscribeStateConverter.fromValue(newData[3]).e,
            newData[4]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            newData[0],
            newData[1],
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            StreamSubscribeStateConverter.fromValue(newData[3]).e,
            newData[4]);
        break;
      case 'RtmpStreamingEvent':
        rtmpStreamingEvent?.call(
          newData[0],
          RtmpStreamingEventConverter.fromValue(newData[1]).e,
        );
        break;
      case 'UserSuperResolutionEnabled':
        userSuperResolutionEnabled?.call(newData[0], newData[1],
            SuperResolutionStateReasonConverter.fromValue(newData[2]).e);
        break;
      case 'UploadLogResult':
        uploadLogResult?.call(newData[0], newData[1],
            UploadErrorReasonConverter.fromValue(newData[2]).e);
        break;
      case 'VideoDeviceStateChanged':
        videoDeviceStateChanged?.call(
          newData[0] as String,
          MediaDeviceTypeConverter.fromValue(newData[1]).e,
          MediaDeviceStateTypeConverter.fromValue(newData[2]).e,
        );
        break;
      case 'AudioDeviceVolumeChanged':
        audioDeviceVolumeChanged?.call(
          MediaDeviceTypeConverter.fromValue(newData[0]).e,
          newData[1] as int,
          newData[2] as bool,
        );
        break;
      case 'AudioDeviceStateChanged':
        audioDeviceStateChanged?.call(
          newData[0] as String,
          MediaDeviceTypeConverter.fromValue(newData[1]).e,
          MediaDeviceStateTypeConverter.fromValue(newData[2]).e,
        );
        break;
      case 'RemoteAudioMixingBegin':
        remoteAudioMixingBegin?.call();
        break;
      case 'RemoteAudioMixingEnd':
        remoteAudioMixingEnd?.call();
        break;
      case 'AirPlayConnected':
        airPlayIsConnected?.call();

        airPlayConnected?.call();
        break;
      case 'VirtualBackgroundSourceEnabled':
        virtualBackgroundSourceEnabled?.call(
            newData[0],
            VirtualBackgroundSourceStateReasonConverter.fromValue(newData[1])
                .e);
        break;
      case 'SnapshotTaken':
        snapshotTaken?.call(newData[0], newData[1], newData[2], newData[3],
            newData[4], newData[5]);
        break;
      case 'VideoSourceFrameSizeChangedIris':
        // Internal used, do nothing
        break;
      case 'ScreenCaptureInfoUpdated':
        if (screenCaptureInfoUpdated != null) {
          final json = ScreenCaptureInfoJson.fromJson(dataMap);
          screenCaptureInfoUpdated!(json.info);
        }
        break;
      case 'ClientRoleChangeFailed':
        if (clientRoleChangeFailed != null) {
          final json = OnClientRoleChangeFailedJson.fromJson(dataMap);
          clientRoleChangeFailed!(json.reason, json.currentRole);
        }
        break;

      case 'WlAccMessage':
        if (wlAccMessage != null) {
          final json = OnWlAccMessageJson.fromJson(dataMap);
          wlAccMessage!(json.reason, json.action, json.wlAccMsg);
        }
        break;
      case 'WlAccStats':
        if (wlAccStats != null) {
          final json = OnWlAccStatsJson.fromJson(dataMap);
          wlAccStats!(json.currentStats, json.averageStats);
        }
        break;
      case 'ProxyConnected':
        if (proxyConnected != null) {
          final json = OnProxyConnectedJson.fromJson(dataMap);
          proxyConnected!(json.channel, json.uid, json.proxyType,
              json.localProxyIp, json.elapsed);
        }
        break;
      case 'AudioDeviceTestVolumeIndication':
        if (audioDeviceTestVolumeIndication != null) {
          final json = OnAudioDeviceTestVolumeIndicationJson.fromJson(dataMap);
          audioDeviceTestVolumeIndication!(json.volumeType, json.volume);
        }
        break;

      case 'ContentInspectResult':
        if (contentInspectResult != null) {
          final json = OnContentInspectResultJson.fromJson(dataMap);
          contentInspectResult!(json.result);
        }
        break;

      default:
        // do nothing
        break;
    }
  }
}
