import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';
import 'events.dart';
import 'api_types.dart';

///
/// Provides methods that enable real-time communications in an RtcChannel channel.
/// Call create to create an RtcChannel object.
///
class RtcChannel with RtcChannelInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('agora_rtc_channel');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_channel/events');
  static final Stream _stream = _eventChannel.receiveBroadcastStream();
  static StreamSubscription? _subscription;

  static final Map<String, RtcChannel> _channels = {};

  /// The ID of RtcChannel
  final String channelId;

  RtcChannelEventHandler? _handler;

  RtcChannel._(this.channelId);

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
    final channel = RtcChannel._(channelId);
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
    // return _invokeMethod('resumeAllChannelMediaRelay');
    return _invokeMethod('callApi', {
      'apiType': ApiTypeChannel.kChannelResumeAllChannelMediaRelay.index,
      'params': jsonEncode({
        'channelId': channelId,
      }),
    });
  }
}

/// @nodoc
mixin RtcChannelInterface
    implements
        RtcAudioInterface,
        RtcVideoInterface,
        RtcVoicePositionInterface,
        RtcPublishStreamInterface,
        RtcMediaRelayInterface,
        RtcDualStreamInterface,
        RtcFallbackInterface,
        RtcMediaMetadataInterface,
        RtcEncryptionInterface,
        RtcInjectStreamInterface,
        RtcStreamMessageInterface {
  ///
  /// Releases the RtcChannel instance.
  ///
  ///
  Future<void> destroy();

  ///
  /// Sets the user role and level in an interactive live streaming channel.
  /// You can call this method either before or after joining the channel to set the user role as audience or host.
  /// If you call this method to switch the user role after joining the channel, the SDK triggers the following callbacks:
  /// The local client: clientRoleChanged.
  /// The remote client: userJoined or userOffline.
  ///
  ///
  ///
  /// This method only takes effect when the channel profile is live interactive streaming (when the profile parameter in setChannelProfile set as LiveBroadcasting).
  ///
  /// Param [role] The user role in the interactive live streaming. See ClientRole.
  ///
  ///
  /// Param [options] The detailed options of a user, including the user level. See ClientRoleOptions.
  ///
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]);

  ///
  /// Joins the channel with a user ID.
  /// Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the mute methods accordingly.
  ///
  ///
  ///   If you are already in a channel, you cannot rejoin it with the user ID.
  ///   We recommend using different UIDs for different channels.
  ///   If you want to join the same channel from different devices, ensure that the user IDs in all devices are different.
  ///
  /// Param [options] The channel media options. For details, see ChannelMediaOptions.
  ///
  /// Param [token] The token generated on your server for authentication. See Authenticate Your Users with Token.
  /// Ensure that the App ID used for creating the token is the same App ID used by the createWithContext method for initializing the RTC engine.
  ///
  ///
  /// Param [optionalUid] User ID. This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer with a value ranging from 1 to 232 -1. If the user ID is not assigned (or set as 0), the SDK assigns a user ID and reports it in the joinChannelSuccess callback. Your app must maintain this user ID.
  ///
  Future<void> joinChannel(String? token, String? optionalInfo, int optionalUid,
      ChannelMediaOptions options);

  ///
  /// Joins the channel with a user account.
  /// Once the user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the mute methods accordingly.
  ///
  ///
  ///   If you are already in a channel, you cannot rejoin it with the user ID.
  ///   We recommend using different user accounts for different channels.
  ///   If you want to join the same channel from different devices, ensure that the user accounts in all devices are different.
  ///
  /// Param [options] The channel media options. For details, see ChannelMediaOptions.
  ///
  /// Param [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique.The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported characters are (89 in total):
  /// The 26 lowercase English letters: a to z.
  /// The 26 uppercase English letters: A to Z.
  /// All numeric characters: 0 to 9.
  /// Space
  /// "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  ///
  ///
  /// Param [token] The token generated on your server for authentication. See Authenticate Your Users with Token.
  /// Ensure that the App ID used for creating the token is the same App ID used by the createWithContext method for initializing the RTC engine.
  ///
  ///
  Future<void> joinChannelWithUserAccount(
      String? token, String userAccount, ChannelMediaOptions options);

  ///
  /// Leaves a channel.
  /// This method lets the user leave the channel, for example, by hanging up or exiting the call. This method releases all resources related to the session. This method call is asynchronous, and the user has not left the channel when the method call returns.
  /// After calling joinChannel, you must call leaveChannel to end the call, otherwise the next call cannot be started.
  /// No matter whether you are currently in a call or not, you can call leaveChannel without side effects.
  /// A successful call of this method triggers the following callbacks:
  /// The local client: leaveChannel.
  /// The remote client: userOffline, if the user
  /// joining the channel is in the COMMUNICATION profile, or is a host in the
  /// LIVE_BROADCASTING profile.
  ///
  ///
  ///
  ///   If you call the leaveChannel method immediately after calling destroy, the SDK will not be able to trigger the leaveChannel callback.
  ///   If you call the leaveChannel method during a CDN live streaming, the SDK automatically calls the removePublishStreamUrl method.
  ///
  Future<void> leaveChannel();

  ///
  /// Gets a new token when the current token expires after a period of time.
  /// Passes a new token to the SDK. A token expires after a certain period of time. The app should get a new token and call this method to pass the token to the SDK. Failure to do so results in the SDK disconnecting from the server.
  /// The SDK triggers the tokenPrivilegeWillExpire callback.
  /// The connectionStateChanged callback reports TokenExpired(9).
  ///
  /// Param [token] The new token.
  ///
  Future<void> renewToken(String token);

  ///
  /// Gets the current connection state of the SDK.
  /// You can call this method either before or after joining a channel.
  ///
  Future<ConnectionStateType> getConnectionState();

  ///
  /// Publish local audio and video streams to the channel.
  /// The call of this method must meet the following requirements, otherwise the SDK returns -5(ERR_REFUSED):
  ///   This method only supports publishing audio and video streams to the channel corresponding to the current RtcChannel object.
  ///   In the interactive live streaming channel, only a host can call this method. To switch the client role, call setClientRole of the current RtcChannel object.
  ///   You can publish a stream to only one channel at a time. For details on joining multiple channels, see the advanced guide Join Multiple Channels.
  ///
  @Deprecated('')
  Future<void> publish();

  ///
  /// Stops publishing a stream to the channel.
  /// If you call this method in a channel where you are not publishing streams, the SDK returns
  /// -5 (ERR_REFUSED).
  ///
  @Deprecated('')
  Future<void> unpublish();

  ///
  /// Retrieves the call ID.
  /// When a user joins a channel on a client, a callId is generated to identify the call from the client. Some methods, such as rate and complain, must be called after the call ends to submit feedback to the SDK. These methods require the callId parameter.
  /// Call this method after joining a channel.
  ///
  /// **return** The current call ID.
  ///
  Future<String?> getCallId();
}

/// @nodoc
mixin RtcAudioInterface {
  ///
  /// Adjusts the playback signal volume of a specified remote user.
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
  ///
  ///
  ///   Call this method after joining a channel.
  ///   The playback volume here refers to the mixed volume of a specified remote user.
  ///
  /// Param [null]
  ///
  /// Param [uid] The ID of the remote user.
  ///
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  ///
  /// Stops or resumes publishing the local audio stream.
  ///
  ///
  /// Param [mute] Whether to stop publishing the local audio stream.
  ///
  /// true: Stop publishing the local audio stream.
  /// false: (Default) Resumes publishing the local audio stream.
  ///
  ///
  ///
  Future<void> muteLocalAudioStream(bool mute);

  ///
  /// Stops or resumes subscribing to the audio stream of a specified user.
  /// Call this method after joining a channel.
  ///   See recommended settings in Set the Subscribing State.
  ///
  /// Param [userId] The user ID of the specified user.
  ///
  /// Param [muted] Whether to stop subscribing to the audio stream of the specified user.
  ///
  ///  true: Stop subscribing to the audio stream of the specified user.
  ///  false: (Default) Subscribe to the audio stream of the specified user.
  ///
  ///
  ///
  Future<void> muteRemoteAudioStream(int userId, bool muted);

  ///
  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users.
  ///
  ///
  ///   Call this method after joining a channel.
  ///
  /// Param [muted] Whether to subscribe to the audio streams of all remote users:
  /// true: Do not subscribe to the audio streams of all remote users.
  /// false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  ///
  ///
  ///
  Future<void> muteAllRemoteAudioStreams(bool muted);

  ///
  /// Stops or resumes subscribing to the audio streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users.
  ///
  ///
  ///   Deprecated:
  ///   This method is deprecated.
  ///
  ///
  ///
  /// If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following:
  ///
  ///   If you need to resume subscribing to the audio stream of a specified user, call muteRemoteAudioStream (false), and specify the user ID.
  ///   If you need to resume subscribing to the audio streams of multiple remote users, call muteRemoteAudioStream (false) multiple times.
  ///
  /// Param [muted] Whether to stop subscribing to the audio streams of all remote users by default.
  ///  true: Stop subscribing to the audio streams of all remote users by default.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  ///
  ///
  ///
  @Deprecated('')
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);
}

/// @nodoc
mixin RtcVideoInterface {
  ///
  /// Stops or resumes publishing the local video stream.
  ///
  ///
  /// Param [mute] Whether to stop publishing the local video stream.
  /// true: Stop publishing the local video stream.
  /// false: (Default) Publish the local video stream.
  ///
  ///
  ///
  ///
  Future<void> muteLocalVideoStream(bool muted);

  ///
  /// Stops or resumes subscribing to the video stream of a specified user.
  /// Call this method after joining a channel.
  ///   See recommended settings in Set the Subscribing State.
  ///
  /// Param [userId] The ID of the specified user.
  ///
  /// Param [muted] Whether to stop subscribing to the video stream of the specified user.
  /// true: Stop subscribing to the video streams of the specified user.
  /// false: (Default) Subscribe to the video stream of the specified user.
  ///
  ///
  ///
  Future<void> muteRemoteVideoStream(int userId, bool muted);

  ///
  /// Stops or resumes subscribing to the video streams of all remote users.
  /// As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the video streams of all remote users, including all subsequent users.
  ///
  ///
  ///   Call this method after joining a channel.
  ///
  /// Param [muted] Whether to stop subscribing to the video streams of all remote users.
  /// true: Stop subscribing to the video streams of all remote users.
  /// false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  ///
  ///
  ///
  Future<void> muteAllRemoteVideoStreams(bool muted);

  ///
  /// Stops or resumes subscribing to the video streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users.
  ///
  ///
  ///   Deprecated:
  ///   This method is deprecated.
  ///
  ///
  ///
  /// If you need to resume subscribing to the video streams of remote users in the channel, do the following:
  ///
  ///   If you need to resume subscribing to a single user, call muteRemoteVideoStream(false) and specify the ID of the remote user you want to subscribe to.
  ///   If you want to resume subscribing to multiple users, call muteRemoteVideoStream(false) multiple times.
  ///
  /// Param [muted] Whether to stop subscribing to the audio streams of all remote users by default.
  /// true: Stop subscribing to the audio streams of all remote users by default.
  /// false: (Default) Resume subscribing to the audio streams of all remote users by default.
  ///
  ///
  ///
  ///
  @Deprecated('')
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);

  ///
  /// Enables/Disables the super-resolution algorithm for a remote user's video stream.
  /// This feature effectively boosts the resolution of a remote user's video seen by the local user. If the original resolution of a remote user's video is a × b, the local user's device can render the remote video at a resolution of 2a × 2b
  /// after you enable this feature.
  /// After you call this method, the SDK triggers the userSuperResolutionEnabled callback to report whether you have successfully enabled super resolution.
  /// The super resolution feature requires extra system resources. To balance the visual experience and system usage, the SDK poses the following restrictions: This feature can only be enabled for a single remote user.
  /// On Android, the original resolution of the remote video must not exceed 640 × 360 pixels. On iOS, the original resolution of the remote video must not exceed 640 × 480 pixels. If you exceed these limitations, the SDK triggers the warning callback and returns the corresponding warning codes:
  /// SuperResolutionStreamOverLimitation: 1610. The origin resolution of the remote video is beyond the range where the super resolution can be applied.
  /// SuperResolutionUserCountOverLimitation: 1611. Super resolution is already being used on another remote user's video.
  /// SuperResolutionDeviceNotSupported: 1612. The device does not support using super resolution.
  ///
  ///
  ///
  /// This method is for Android and iOS only.
  /// Before calling this method, ensure that you have integrated the following dynamic libraries:
  /// Android: libagora_super_resolution_extension.so
  /// iOS: AgoraSuperResolutionExtension.xcframework
  ///
  ///
  /// Because this method has certain system performance requirements, Agora recommends that you use the following devices or better:
  /// Android:
  /// VIVO: V1821A, NEX S, 1914A, 1916A, 1962A, 1824BA, X60, X60 Pro
  /// OPPO: PCCM00, Find X3
  /// OnePlus: A6000
  /// Xiaomi: Mi 8, Mi 9, Mi 10, Mi 11, MIX3, Redmi K20 Pro
  /// SAMSUNG: SM-G9600, SM-G9650, SM-N9600, SM-G9708, SM-G960U, SM-G9750, S20, S21
  /// HUAWEI: SEA-AL00, ELE-AL00, VOG-AL00, YAL-AL10, HMA-AL00, EVR-AN00, nova 4, nova 5 Pro, nova 6 5G, nova 7 5G, Mate 30, Mate 30 Pro, Mate 40, Mate 40 Pro, P40, P40 Pro, Huawei M6, MatePad 10.8
  ///
  /// iOS:
  /// iPhone XR
  /// iPhone XS
  /// iPhone XS Max
  /// iPhone 11
  /// iPhone 11 Pro
  /// iPhone 11 Pro Max
  /// iPhone 12
  /// iPhone 12 mini
  /// iPhone 12 Pro
  /// iPhone 12 Pro Max
  /// iPhone 12 SE (2nd generation)
  /// iPad Pro 11-inch (3rd generation)
  /// iPad Pro 12.9-inch (3rd generation)
  /// iPad Air 3 (3rd generation)
  /// iPad Air 3 (4th generation)
  ///
  /// Param [userId] The ID of the remote user.
  ///
  /// Param [enable] Whether to enable super resolution for the remote user’s video:
  /// true: Enable virtual background.
  /// false: Do not enable virtual background.
  ///
  ///
  Future<void> enableRemoteSuperResolution(int userId, bool enable);
}

/// @nodoc
mixin RtcVoicePositionInterface {
  ///
  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  /// This method sets the 2D position and volume of a remote user, so that the local user can easily hear and identify the remote user's position.
  /// When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games.
  ///
  ///
  ///   For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.
  /// For the best voice positioning, Agora recommends using a wired headset.
  ///   Call this method after joining a channel.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:
  ///  0.0: (Default) The remote voice comes from the front.
  ///  -1.0: The remote voice comes from the left.
  ///  1.0: The remote voice comes from the right.
  ///
  ///
  ///
  /// Param [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.
  ///
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);
}

/// @nodoc
mixin RtcPublishStreamInterface {
  ///
  /// Sets the transcoding configurations for CDN live streaming.
  /// This method takes effect only when you are a host in live interactive streaming.
  ///   Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in the advanced guide Push Streams to CDN.
  ///   If you call this method to set the transcoding configuration for the first time, the SDK does not trigger the transcodingUpdated callback.
  ///   Call this method after joining a channel.
  ///   Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.
  ///
  ///
  /// This method sets the video layout and audio settings for CDN live streaming. The SDK triggers the transcodingUpdated callback when you call this method to update the transcoding setting.
  ///
  /// Param [transcoding] The transcoding configurations for CDN live streaming. For details, see LiveTranscoding.
  ///
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  ///
  /// Publishes the local stream to a specified CDN live streaming URL.
  /// Call this method after joining a channel.
  /// Ensure that you enable the RTMP Converter service before using this function.
  ///   This method takes effect only when you are a host in live interactive streaming.
  ///   This method adds only one stream CDN streaming URL each time it is called. To push multiple URLs, call this method multiple times.
  ///   Agora supports pushing media streams in RTMPS protocol to the CDN only when you enable transcoding.
  ///
  ///
  /// After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The SDK triggers the rtmpStreamingStateChanged callback on the local client to report the state of adding a local stream to the CDN.
  ///
  /// Param [url] The CDN streaming URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  ///
  /// Param [transcodingEnabled] Whether to enable transcoding. Transcoding in a CDN live streaming converts the audio and video streams before pushing them to the CDN server. It applies to scenarios where a channel has multiple broadcasters and composite layout is needed
  /// true: Enable transcoding.
  /// false: Disable transcoding.
  ///
  /// If you set this parameter as true , ensure that you call the setLiveTranscoding method before this method.
  ///
  ///
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  ///
  /// Removes an RTMP or RTMPS stream from the CDN.
  /// Ensure that you enable the RTMP Converter service before using this function.
  /// This method takes effect only when you are a host in live interactive streaming.
  /// Call this method after joining a channel.
  /// This method removes only one CDN streaming URL each time it is called. To remove multiple URLs, call this method multiple times.
  ///
  ///
  /// After a successful method call, the SDK triggers rtmpStreamingStateChanged on the local client to report the result of deleting the address.
  ///
  /// Param [url] The CDN streaming URL to be removed. The maximum length of this parameter is 1024 bytes. The CDN streaming URL must not contain special characters, such as Chinese characters.
  ///
  Future<void> removePublishStreamUrl(String url);
}

/// @nodoc
mixin RtcMediaRelayInterface {
  ///
  /// Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.
  /// After a successful method call, the SDK triggers the channelMediaRelayStateChanged and channelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.
  ///   If the channelMediaRelayStateChanged callback returns Running(2) and None(0), and the channelMediaRelayEvent callback returns SentToDestinationChannel(4), it means that the SDK starts relaying media streams between the source channel and the destination channel.
  ///   If the channelMediaRelayStateChanged callback returns Failure(3), an exception occurs during the media stream relay.
  ///
  ///
  ///
  ///
  ///   Call this method after joining the channel.
  ///   This method takes effect only when you are a host in a live streaming channel.
  ///   After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelay method to quit the current relay.
  ///   Contact support@agora.io (https://agora-ticket.agora.io/) before implementing this function.
  ///   We do not support string user accounts in this API.
  ///
  /// Param [channelMediaRelayConfiguration] The configuration of the media stream relay. For details, see ChannelMediaRelayConfiguration.
  ///
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  ///
  /// Updates the channels for media stream relay.
  /// After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the updateChannelMediaRelay method.
  /// After a successful method call, the SDK triggers the channelMediaRelayEvent callback with the UpdateDestinationChannel(7) state code.
  /// Call this method after the startChannelMediaRelay method to update the destination channel.
  ///
  /// Param [channelMediaRelayConfiguration] The configuration of the media stream relay. For more details, see ChannelMediaRelayConfiguration.
  ///
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  ///
  /// Stops the media stream relay. Once the relay stops, the host quits all the destination channels.
  /// After a successful method call, the SDK triggers the channelMediaRelayStateChanged callback. If the callback reports Idle(0) and None(0), the host successfully stops the relay.
  /// If the method call fails, the SDK triggers the channelMediaRelayStateChanged callback with the ServerNoResponse(2) or ServerConnectionLost(8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  ///
  Future<void> stopChannelMediaRelay();

  ///
  /// Pauses the media stream relay to all destination channels.
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all destination channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay.
  /// After a successful method call, the SDK triggers the channelMediaRelayEvent callback to report whether the media stream relay is successfully paused.
  /// Call this method after startChannelMediaRelay.
  ///
  Future<void> pauseAllChannelMediaRelay();

  ///
  /// Resumes the media stream relay to all destination channels.
  /// After calling the pauseAllChannelMediaRelay method, you can call this method to resume relaying media streams to all destination channels.
  /// After a successful method call, the SDK triggers the channelMediaRelayEvent callback to report whether the media stream relay is successfully resumed.
  /// Call this method after the pauseAllChannelMediaRelay method.
  ///
  Future<void> resumeAllChannelMediaRelay();
}

/// @nodoc
mixin RtcDualStreamInterface {
  ///
  /// Sets the stream type of the remote video.
  /// The method result returns in the apiCallExecuted callback.
  /// By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.
  ///
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode(false), the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or the low-quality video stream (the low resolution, and low bitrate video stream). The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.
  /// Call this method after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType, the setting of setRemoteVideoStreamType takes effect.
  ///
  /// Param [streamType] The video stream type: VideoStreamType.
  ///
  ///
  Future<void> setRemoteVideoStreamType(int userId, VideoStreamType streamType);

  ///
  /// Sets the default stream type of remote video streams.
  /// The result of this method returns in the apiCallExecuted callback.
  /// By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using (),the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.enableDualStreamModefalse
  /// Call this method after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType, the setting of setRemoteVideoStreamType takes effect.
  ///
  /// Param [streamType] The default stream type of the remote video, see VideoStreamType.
  ///
  ///
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);
}

/// @nodoc
mixin RtcFallbackInterface {
  ///
  /// Prioritizes a remote user's stream.
  /// Prioritizes a remote user's stream. The SDK ensures the high-priority user gets the best possible stream quality. The SDK ensures the high-priority user gets the best possible stream quality.
  ///
  ///
  /// The SDK supports setting only one user as high priority.
  /// Ensure that you call this method before joining a channel.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [userPriority] The priority of the remote user. See UserPriority.
  ///
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);
}

/// @nodoc
mixin RtcMediaMetadataInterface {
  ///
  /// Registers the metadata observer.
  /// Call this method before joinChannel.
  ///   This method applies only to interactive live streaming.
  ///
  Future<void> registerMediaMetadataObserver();

  ///
  /// Unregisters the media metadata observer.
  ///
  ///
  Future<void> unregisterMediaMetadataObserver();

  ///
  /// Sets the maximum size of the media metadata.
  /// After calling registerMediaMetadataObserver, you can call this method to set the maximum size of the media metadata.
  ///
  /// Param [size] The maximum size of media metadata.
  ///
  Future<void> setMaxMetadataSize(int size);

  ///
  /// Sends media metadata.
  /// If the metadata is sent successfully, the SDK triggers the metadataReceived callback on the receiver.
  ///
  /// Param [metadata] Media metadata. See Metadata.
  ///
  Future<void> sendMetadata(Uint8List metadata);
}

/// @nodoc
mixin RtcEncryptionInterface {
  ///
  /// Enables built-in encryption with an encryption password before users join a channel.
  /// Do not use this method for CDN live streaming.
  ///   For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  ///
  ///
  /// Before joining the channel, you need to call this method to set the secret parameter to enable the built-in encryption. All users in the same channel should use the same secret. The secret is automatically cleared once a user leaves the channel. If you do not specify the secret or secret is set as null, the built-in encryption is disabled.
  ///
  ///
  ///   Deprecated:
  ///   Please use the enableEncryption method instead.
  ///
  /// Param [secret] The encryption password.
  ///
  @Deprecated('Please use the enableEncryption method instead.')
  Future<void> setEncryptionSecret(String secret);

  ///
  /// Sets the built-in encryption mode.
  /// The Agora SDK supports built-in encryption. The default encryption is AES-128-XTS. Call this method to use other encryption modes. All users in the same channel must use the same encryption mode and secret. Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  ///
  ///
  ///   Deprecated:
  ///   Please use the enableEncryption method instead.
  ///
  ///
  /// Before calling this method, please call setEncryptionSecret to enable the built-in encryption function.
  ///
  /// Param [encryptionMode] Encryption mode.
  /// "aes-128-xts": (Default) 128-bit AES encryption, XTS mode.
  /// "aes-128-ecb": 128-bit AES encryption, ECB mode.
  /// "aes-256-xts": 256-bit AES encryption, XTS mode.
  /// "": When setting as NULL, the encryption mode is set as "aes-128-xts" by default.
  ///
  ///
  ///
  ///
  @Deprecated('Please use the enableEncryption method instead.')
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);

  ///
  /// Enables/Disables the built-in encryption.
  /// In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
  /// All users in the same channel must use the same encryption mode and encryption key. After the user leaves the channel, the SDK automatically disables the built-in encryption. To enable the built-in encryption, call this method before the user joins the channel again.
  /// If you enable the built-in encryption, you cannot use the RTMP or RTMPS streaming function.
  ///
  /// Param [enabled] Whether to enable built-in encryption:
  /// true: Enable the built-in encryption.
  /// false: Disable the built-in encryption.
  ///
  ///
  ///
  ///
  /// Param [config] Configurations of built-in encryption. For details, see EncryptionConfig.
  ///
  Future<void> enableEncryption(bool enabled, EncryptionConfig config);
}

/// @nodoc
mixin RtcInjectStreamInterface {
  ///
  /// Injects an online media stream to a live streaming channel.
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it. For details, see Service Sunset Plans.
  ///
  ///
  /// Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in Push Streams to CDN.
  /// This method takes effect only when you are a host in a live streaming channel.
  /// Only one online media stream can be injected into the same channel at the same time.
  /// Call this method after joining a channel.
  ///
  ///
  /// This method injects the currently playing audio and video as audio and video sources into the
  /// ongoing live broadcast. This applies to scenarios where all users in the channel can
  /// watch a live show and interact with each other. After calling this method, the SDK
  /// triggers the streamInjectedStatus callback on the local client to
  /// report the state of injecting the online media stream; after successfully injecting
  /// the media stream, the stream joins the channel, and all users in the channel receive
  /// the userJoined callback, where uid is
  /// 666.
  ///
  /// Param [url] The URL address to be added to the ongoing streaming. Valid protocols are RTMP, HLS, and HTTP-FLV.
  /// Supported audio codec type: AAC.
  /// Supported video codec type: H264 (AVC).
  ///
  ///
  ///
  ///
  /// Param [config] The configuration information for the added voice or video stream: LiveInjectStreamConfig.
  ///
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  ///
  /// Removes the voice or video stream URL address from the live streaming.
  /// After a successful method, the SDK triggers the userOffline callback
  /// with the uid of 666.
  ///
  /// Param [url] The URL address of the injected stream to be removed.
  ///
  Future<void> removeInjectStreamUrl(String url);
}

/// @nodoc
mixin RtcStreamMessageInterface {
  ///
  /// Creates a data stream.
  /// Call this method after joining a channel.
  ///   Agora does not support setting reliable as true and ordered as true.
  ///
  ///
  /// Each user can create up to five data streams during the lifecycle of RtcEngine.
  ///
  ///
  ///   Deprecated:
  ///   Please use createDataStreamWithConfig instead.
  ///
  /// Param [ordered] Whether or not the recipients receive the data stream in the sent order:
  /// true: The recipients receive the data in the sent order.
  /// false: The recipients do not receive the data in the sent order.
  ///
  ///
  /// Param [reliable] Whether or not the data stream is reliable:
  /// true: The recipients receive the
  /// data from the sender within five seconds. If the recipient does not
  /// receive the data within five seconds, the SDK triggers the streamMessageError callback and returns an
  /// error code.
  /// false: There is no guarantee that
  /// the recipients receive the data stream within five seconds and no
  /// error message is reported for any delay or missing data stream.
  ///
  ///
  ///
  @Deprecated('Please use createDataStreamWithConfig instead.')
  Future<int?> createDataStream(bool reliable, bool ordered);

  ///
  /// Creates a data stream.
  /// Compared with createDataStream[1/2], this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.
  /// Creates a data stream. Each user can create up to five data streams in a single channel.
  ///
  /// Param [config] The configurations for the data stream. For details, see DataStreamConfig.
  ///
  /// **return** ID of the created data stream, if the method call succeeds.
  /// < 0: Failure.
  ///
  Future<int?> createDataStreamWithConfig(DataStreamConfig config);

  ///
  /// Sends data stream messages.
  /// Sends data stream messages to all users in a channel. The SDK has the following restrictions on this method:Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.Each client can send up to 6 KB of data per second.Each user can have up to five data streams simultaneously.
  /// A successful method call triggers the streamMessage callback on the remote client, from which the remote user gets the stream message. A failed method call triggers the streamMessageError callback on the remote client.
  ///
  /// Ensure that you call createDataStreamWithConfig to create a data channel before calling this method.
  /// In live streaming scenarios, this method only applies to hosts.
  ///
  /// Param [streamId] The data stream ID. You can get the data stream ID by calling createDataStreamWithConfig.
  ///
  /// Param [message] The message to be sent.
  ///
  Future<void> sendStreamMessage(int streamId, Uint8List message);
}
