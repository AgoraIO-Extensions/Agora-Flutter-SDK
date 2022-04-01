import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/classes.dart';
import 'enum_converter.dart';
import 'package:agora_rtc_engine/src/impl/event_handler_json.dart';
import 'package:agora_rtc_engine/src/rtc_channel_event_handler.dart';

// ignore_for_file: public_member_api_docs

extension RtcChannelEventHandlerExt on RtcChannelEventHandler {
  void process(String channelId, String methodName, dynamic data,
      [Uint8List? buffer]) {
    List<dynamic> newData;
    if (methodName.startsWith('on')) {
      methodName = methodName.substring(2);
    }
    final dataMap = jsonDecode(data as String);
    newData = List<dynamic>.from(Map<String, dynamic>.from(dataMap).values);
    switch (methodName) {
      case 'ChannelWarning':
        warning?.call(WarningCodeConverter.fromValue(newData[0]).e);
        break;
      case 'ChannelError':
        error?.call(ErrorCodeConverter.fromValue(newData[0]).e);
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
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(newData[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(newData[0]);
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
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            newData[0],
            AudioRemoteStateConverter.fromValue(newData[1]).e,
            AudioRemoteStateReasonConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(newData[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(newData[0], newData[1]);
        break;
      case 'RtcStats':
        rtcStats
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            newData[0],
            NetworkQualityConverter.fromValue(newData[1]).e,
            NetworkQualityConverter.fromValue(newData[2]).e);
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(newData[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(newData[0])));
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
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS || Platform.isAndroid)) {

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
      case 'MetadataReceived':
        Metadata metadata;
        // if (kIsWeb || (Platform.isWindows || Platform.isMacOS || Platform.isAndroid)) {

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
      case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            channelId,
            StreamPublishStateConverter.fromValue(newData[0]).e,
            StreamPublishStateConverter.fromValue(newData[1]).e,
            newData[2]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            channelId,
            StreamPublishStateConverter.fromValue(newData[0]).e,
            StreamPublishStateConverter.fromValue(newData[1]).e,
            newData[2]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            channelId,
            newData[0],
            StreamSubscribeStateConverter.fromValue(newData[1]).e,
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            newData[3]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            channelId,
            newData[0],
            StreamSubscribeStateConverter.fromValue(newData[1]).e,
            StreamSubscribeStateConverter.fromValue(newData[2]).e,
            newData[3]);
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
      case 'ClientRoleChangeFailed':
        if (clientRoleChangeFailed != null) {
          final json = OnClientRoleChangeFailedJson.fromJson(dataMap);
          clientRoleChangeFailed!(json.reason, json.currentRole);
        }
        break;
      default:
        // do nothing
        break;
    }
  }
}
