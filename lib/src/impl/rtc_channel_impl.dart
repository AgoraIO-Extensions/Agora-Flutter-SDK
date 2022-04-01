import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/api_types.dart';
import 'enum_converter.dart';
import 'package:agora_rtc_engine/src/rtc_channel_event_handler.dart';
import 'rtc_channel_event_handler_impl.dart';
import 'package:agora_rtc_engine/src/rtc_channel.dart';
import 'package:flutter/services.dart';

///
/// Provides methods that enable real-time communications in an RtcChannel channel.
/// Call create to create an RtcChannel object.
///
class RtcChannelImpl implements RtcChannel {
  static const MethodChannel _methodChannel =
      MethodChannel('agora_rtc_channel');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_channel/events');
  static final Stream _stream = _eventChannel.receiveBroadcastStream();
  static StreamSubscription? _subscription;

  static final Map<String, RtcChannelImpl> _channels = {};

  @override
  String get channelId => _channelId;

  final String _channelId;

  RtcChannelEventHandler? _handler;

  RtcChannelImpl._(this._channelId);

  Future<T?> _invokeMethod<T>(String method,
      [Map<String, dynamic>? arguments]) {
    return _methodChannel.invokeMethod(
      method,
      arguments == null
          ? {'channelId': channelId}
          : {'channelId': channelId, ...arguments},
    );
  }

  ///
  /// Creates and gets an RtcChannel object.
  /// You can call this method multiple times to create multiple RtcChannel objects,
  /// and then call the joinChannel methods of each RtcChannel to join multiple channels at the same time.
  /// After joining multiple channels, you can simultaneously subscribe to the the audio and video streams of all the channels, but publish a stream in only one channel at one time.
  ///
  /// Param [channelId]
  /// The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  /// The 26 lowercase English letters: a to z.
  /// The 26 uppercase English letters: A to Z.
  /// The 10 numeric characters: 0 to 9.
  /// Space
  /// "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  ///
  ///
  /// The parameter does not have a default value. You must set it.
  /// Do not set this parameter as the empty string "". Otherwise, the SDK returns ERR_REFUSED(5).
  ///
  ///
  ///
  ///
  /// **return** A pointer to the RtcChannel instance, if the method call succeeds.
  /// If the call fails, returns NULL.
  ///
  static Future<RtcChannel> create(String channelId) async {
    if (_channels.containsKey(channelId)) return _channels[channelId]!;

    await _methodChannel.invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelCreateChannel.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
    // TODO(littlegnal): Fill test for _channels (maybe unit test)
    final channel = RtcChannelImpl._(channelId);
    _channels[channelId] = channel;
    return channel;
  }

  ///
  /// Destroys all RtcChannel instance.
  ///
  ///
  // TODO(littlegnal): Fill test
  static void destroyAll() {
    // TODO(littlegnal): Check that if the release should call synchronously
    _channels.forEach((key, value) async {
      value._handler = null;
      await value._invokeMethod('callApi', {
        'apiType': ApiTypeChannel.kChannelRelease.index,
        'params': jsonEncode({
          'channelId': value.channelId,
        }),
      });
    });
    _channels.clear();
  }

  @override
  Future<void> destroy() {
    _handler = null;
    _channels.remove(channelId);
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelRelease.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  ///
  /// Sets the event handler for the RtcChannel object.
  /// After setting the channel event handler, you can listen for channel events and receive the statistics of the corresponding RtcChannel object.
  ///
  /// Param [handler] The event handler for the RtcChannel object. For details, see RtcChannelEventHandler.
  ///
  /// **return** 0(ERR_OK): Success.
  /// < 0: Failure.
  ///
  @override
  void setEventHandler(RtcChannelEventHandler handler) {
    _handler = handler;
    _subscription ??= _stream.listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String;
      var data = eventMap['data'];
      final buffer = eventMap['buffer'];
      String channelId;
      // if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {

      // } else {
      //   channelId = eventMap['channelId'];
      // }
      final map = Map<String, dynamic>.from(jsonDecode(data));
      channelId = map.remove('channelId');
      data = jsonEncode(map);
      _channels[channelId]
          ?._handler
          ?.process(channelId, methodName, data, buffer);
    });
  }

  @override
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetClientRole.index,
      'params': jsonEncode({
        'channelId': channelId,
        'role': ClientRoleConverter(role).value(),
        'options': options?.toJson(),
      }),
    });
  }

  @override
  Future<void> joinChannel(String? token, String? optionalInfo, int optionalUid,
      ChannelMediaOptions options) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelJoinChannel.index,
      'params': jsonEncode({
        'channelId': channelId,
        'token': token,
        'info': optionalInfo,
        'uid': optionalUid,
        'options': options.toJson(),
      }),
    });
  }

  @override
  Future<void> joinChannelWithUserAccount(
      String? token, String userAccount, ChannelMediaOptions options) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelJoinChannelWithUserAccount.index,
      'params': jsonEncode({
        'channelId': channelId,
        'token': token,
        'userAccount': userAccount,
        'options': options.toJson(),
      }),
    });
  }

  @override
  Future<void> leaveChannel() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelLeaveChannel.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<void> renewToken(String token) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelRenewToken.index,
      'params': jsonEncode({
        'channelId': channelId,
        'token': token,
      }),
    });
  }

  @override
  Future<ConnectionStateType> getConnectionState() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelGetConnectionState.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    }).then((value) {
      return ConnectionStateTypeConverter.fromValue(value).e;
    });
  }

  @override
  Future<void> publish() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelPublish.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<void> unpublish() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelUnPublish.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<String?> getCallId() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelGetCallId.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelAdjustUserPlaybackSignalVolume.index,
      'params': jsonEncode({
        'channelId': channelId,
        'uid': uid,
        'volume': volume,
      }),
    });
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelMuteAllRemoteAudioStreams.index,
      'params': jsonEncode({
        'channelId': channelId,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> muteRemoteAudioStream(int userId, bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelMuteRemoteAudioStream.index,
      'params': jsonEncode({
        'channelId': channelId,
        'userId': userId,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType':
          ApiTypeChannel.kChannelSetDefaultMuteAllRemoteAudioStreams.index,
      'params': jsonEncode({
        'channelId': channelId,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelMuteAllRemoteVideoStreams.index,
      'params': jsonEncode({
        'channelId': channelId,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> muteRemoteVideoStream(int userId, bool muted) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelMuteRemoteVideoStream.index,
      'params': jsonEncode({
        'channelId': channelId,
        'userId': userId,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('callApi', {
      'apiType':
          ApiTypeChannel.kChannelSetDefaultMuteAllRemoteVideoStreams.index,
      'params': jsonEncode({
        'channelId': channelId,
        'mute': muted,
      }),
    });
  }

  @override
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelAddInjectStreamUrl.index,
      'params': jsonEncode({
        'channelId': channelId,
        'url': url,
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelAddPublishStreamUrl.index,
      'params': jsonEncode({
        'channelId': channelId,
        'url': url,
        'transcodingEnabled': transcodingEnabled,
      }),
    });
  }

  @override
  Future<int?> createDataStream(bool reliable, bool ordered) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelCreateDataStream.index,
      'params': jsonEncode({
        'channelId': channelId,
        'reliable': reliable,
        'ordered': ordered,
      }),
    });
  }

  @override
  Future<void> registerMediaMetadataObserver() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelRegisterMediaMetadataObserver.index,
      'params': jsonEncode({
        'channelId': channelId,
        'type': 0, // VIDEO_METADATA
      }),
    });
  }

  @override
  Future<void> removeInjectStreamUrl(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelRemoveInjectStreamUrl.index,
      'params': jsonEncode({
        'channelId': channelId,
        'url': url,
      }),
    });
  }

  @override
  Future<void> removePublishStreamUrl(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelRemovePublishStreamUrl.index,
      'params': jsonEncode({
        'channelId': channelId,
        'url': url,
      }),
    });
  }

  @override
  Future<void> sendMetadata(Uint8List metadata) {
    return _invokeMethod('callApiWithBuffer', {
      'apiType': ApiTypeChannel.kChannelSendMetadata.index,
      'params': jsonEncode({
        'channelId': channelId,
        'metadata': {
          'size': metadata.length,
        },
      }),
      'buffer': metadata
    });
  }

  @override
  Future<void> sendStreamMessage(int streamId, Uint8List message) {
    return _invokeMethod('callApiWithBuffer', {
      'apiType': ApiTypeChannel.kChannelSendStreamMessage.index,
      'params': jsonEncode({
        'channelId': channelId,
        'streamId': streamId,
        'length': message.length,
      }),
      'buffer': message,
    });
  }

  @override
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetEncryptionMode.index,
      'params': jsonEncode({
        'channelId': channelId,
        'encryptionMode': EncryptionModeConverter(encryptionMode).value(),
      }),
    });
  }

  @override
  Future<void> setEncryptionSecret(String secret) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetEncryptionSecret.index,
      'params': jsonEncode({
        'channelId': channelId,
        'secret': secret,
      }),
    });
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetLiveTranscoding.index,
      'params': jsonEncode({
        'channelId': channelId,
        'transcoding': transcoding.toJson(),
      }),
    });
  }

  @override
  Future<void> setMaxMetadataSize(int size) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetMaxMetadataSize.index,
      'params': jsonEncode({
        'channelId': channelId,
        'size': size,
      }),
    });
  }

  @override
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetRemoteDefaultVideoStreamType.index,
      'params': jsonEncode({
        'channelId': channelId,
        'streamType': VideoStreamTypeConverter(streamType).value(),
      }),
    });
  }

  @override
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetRemoteUserPriority.index,
      'params': jsonEncode({
        'channelId': channelId,
        'uid': uid,
        'userPriority': UserPriorityConverter(userPriority).value(),
      }),
    });
  }

  @override
  Future<void> setRemoteVideoStreamType(
      int userId, VideoStreamType streamType) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetRemoteVideoStreamType.index,
      'params': jsonEncode({
        'channelId': channelId,
        'userId': userId,
        'streamType': VideoStreamTypeConverter(streamType).value(),
      }),
    });
  }

  @override
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetRemoteVoicePosition.index,
      'params': jsonEncode({
        'channelId': channelId,
        'uid': uid,
        'pan': pan,
        'gain': gain,
      }),
    });
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelStartChannelMediaRelay.index,
      'params': jsonEncode({
        'channelId': channelId,
        'configuration': channelMediaRelayConfiguration.toJson(),
      }),
    });
  }

  @override
  Future<void> stopChannelMediaRelay() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelStopChannelMediaRelay.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<void> unregisterMediaMetadataObserver() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelUnRegisterMediaMetadataObserver.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelUpdateChannelMediaRelay.index,
      'params': jsonEncode({
        'channelId': channelId,
        'configuration': channelMediaRelayConfiguration.toJson(),
      }),
    });
  }

  @override
  Future<void> enableEncryption(bool enabled, EncryptionConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelEnableEncryption.index,
      'params': jsonEncode({
        'channelId': channelId,
        'enabled': enabled,
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<int?> createDataStreamWithConfig(DataStreamConfig config) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelCreateDataStream.index,
      'params': jsonEncode({
        'channelId': channelId,
        'config': config.toJson(),
      }),
    });
  }

  @override
  Future<void> enableRemoteSuperResolution(int userId, bool enable) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelEnableRemoteSuperResolution.index,
      'params': jsonEncode({
        'channelId': channelId,
        'userId': userId,
        'enable': enable,
      }),
    });
  }

  @override
  Future<void> muteLocalAudioStream(bool mute) {
    // return _invokeMethod('muteLocalAudioStream', {
    //   'muted': muted,
    // });

    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelMuteLocalAudioStream.index,
      'params': jsonEncode({
        'channelId': channelId,
        'mute': mute,
      }),
    });
  }

  @override
  Future<void> muteLocalVideoStream(bool mute) {
    // return _invokeMethod('muteLocalVideoStream', {
    //   'muted': muted,
    // });

    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelMuteLocalVideoStream.index,
      'params': jsonEncode({
        'channelId': channelId,
        'mute': mute,
      }),
    });
  }

  @override
  Future<void> pauseAllChannelMediaRelay() {
    // return _invokeMethod('pauseAllChannelMediaRelay');
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelPauseAllChannelMediaRelay.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<void> resumeAllChannelMediaRelay() {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelResumeAllChannelMediaRelay.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }

  @override
  Future<void> setAVSyncSource(String channelId, int uid) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelSetAVSyncSource.index,
      'params': jsonEncode({
        'channelId': channelId,
        'uid': uid,
      }),
    });
  }

  @override
  Future<void> startRtmpStreamWithTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelStartRtmpStreamWithTranscoding.index,
      'params': jsonEncode({
        'transcoding': transcoding.toJson(),
      }),
    });
  }

  @override
  Future<void> startRtmpStreamWithoutTranscoding(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelStartRtmpStreamWithoutTranscoding.index,
      'params': jsonEncode({
        'url': url,
      }),
    });
  }

  @override
  Future<void> stopRtmpStream(String url) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelStopRtmpStream.index,
      'params': jsonEncode({
        'url': url,
      }),
    });
  }

  @override
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelUpdateRtmpTranscoding.index,
      'params': jsonEncode({
        'transcoding': transcoding.toJson(),
      }),
    });
  }
}
