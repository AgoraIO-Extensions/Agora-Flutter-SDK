import 'dart:async';

import 'package:flutter/services.dart';

import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';
import 'events.dart';
import 'rtc_engine.dart';

/// The RtcChannel class.
class RtcChannel
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
  static const MethodChannel _methodChannel =
      MethodChannel('agora_rtc_channel');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_channel/events');

  static StreamSubscription _subscription;

  static final Map<String, RtcChannel> _channels = {};

  final String _channelId;

  RtcChannelEventHandler _handler;

  RtcChannel._(this._channelId);

  Future<T> _invokeMethod<T>(String method, [Map<String, dynamic> arguments]) {
    return _methodChannel.invokeMethod(
        method,
        arguments == null
            ? {'channelId': _channelId}
            : {'channelId': _channelId, ...arguments});
  }

  /// Creates and gets an RtcChannel instance.
  /// See [RtcChannel]
  /// To join more than one channel, call this method multiple times to create as many RtcChannel instances as needed, and call the joinChannel method of each created RtcChannel object.
  /// See [RtcChannel.joinChannel]
  /// After joining multiple channels, you can simultaneously subscribe to streams of all the channels, but publish a stream in only one channel at one time.
  /// Param [channelId] The unique channel name for the AgoraRTC session in the string format. The string length must be less than 64 bytes. This parameter does not have a default value. You must set it. Do not set it as the empty string "". Otherwise, the SDK returns Refused(-5). Supported character scopes are:
  /// See [ErrorCode.Refused]
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  static Future<RtcChannel> create(String channelId) async {
    if (_channels.containsKey(channelId)) return _channels[channelId];
    await _methodChannel.invokeMethod('create', {'channelId': channelId});
    _channels[channelId] = RtcChannel._(channelId);
    return _channels[channelId];
  }

  /// Destroys all RtcChannel instance.
  /// See [RtcChannel]
  static void destroyAll() {
    _channels.forEach((key, value) async {
      await value.destroy();
    });
    _channels.clear();
  }

  /// Destroys the RtcChannel instance.
  /// See [RtcChannel]
  Future<void> destroy() {
    _channels.remove(_channelId);
    return _invokeMethod('destroy');
  }

  /// Set the channel event handler.
  /// After setting the channel event handler, you can listen for channel events and receive the statistics of the corresponding RtcChannel instance.
  /// Param [handler] The event handler.
  void setEventHandler(RtcChannelEventHandler handler) {
    _handler = handler;
    _subscription ??= _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final channelId = eventMap['channelId'];
      final methodName = eventMap['methodName'] as String;
      final data = List<dynamic>.from(eventMap['data']);
      _channels[channelId]?._handler?.process(methodName, data);
    });
  }

  /// Sets the role of a user.
  /// This method sets the role of a user, such as a host or an audience. In a Live-Broadcast channel, only a broadcaster can call the publish method in the RtcChannel class.
  /// See [RtcChannel.publish]
  /// A successful call of this method triggers the following callbacks:
  /// - The local client: onClientRoleChanged.
  /// See [RtcChannelEventHandler.clientRoleChanged]
  /// - The remote client: onUserJoined or onUserOffline(BecomeAudience).
  /// See [RtcChannelEventHandler.userJoined]
  /// See [RtcChannelEventHandler.userOffline]
  /// See [UserOfflineReason.BecomeAudience]
  /// Param [role] The role of the user.
  /// See [ClientRole]
  Future<void> setClientRole(ClientRole role) {
    return _invokeMethod(
        'setClientRole', {'role': ClientRoleConverter(role).value()});
  }

  /// Joins the channel with a user ID.
  /// Note
  /// - If you are already in a channel, you cannot rejoin it with the same uid.
  /// - We recommend using different UIDs for different channels.
  /// - If you want to join the same channel from different devices, ensure that the UIDs in all devices are different.
  /// - Ensure that the app ID you use to generate the token is the same with the app ID used when creating the RtcEngine instance.
  /// See [RtcEngine]
  /// Param [token] The token generated at your server.
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see Get a temporary token.
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see Generate a token.
  /// Param [optionalInfo] Additional information about the channel. This parameter can be set as null. Other users in the channel do not receive this information.
  /// Param [optionalUid] The user ID. A 32-bit unsigned integer with a value ranging from 1 to (232-1). This parameter must be unique. If uid is not assigned (or set as 0), the SDK assigns a uid and reports it in the onJoinChannelSuccess callback. The app must maintain this user ID.
  /// Param [options] The channel media options.
  /// See [ChannelMediaOptions]
  Future<void> joinChannel(String token, String optionalInfo, int optionalUid,
      ChannelMediaOptions options) {
    return _invokeMethod('joinChannel', {
      'token': token,
      'optionalInfo': optionalInfo,
      'optionalUid': optionalUid,
      'options': options.toJson()
    });
  }

  /// Joins a channel with the user account.
  /// Note
  /// - If you are already in a channel, you cannot rejoin it with the same uid.
  /// - We recommend using different user accounts for different channels.
  /// - If you want to join the same channel from different devices, ensure that the user accounts in all devices are different.
  /// - Ensure that the app ID you use to generate the token is the same with the app ID used when creating the RtcEngine instance.
  /// See [RtcEngine]
  /// Param [token] The token generated at your server.
  /// - In situations not requiring high security: You can use the temporary token generated at Console. For details, see Get a temporary token.
  /// - In situations requiring high security: Set it as the token generated at your server. For details, see Generate a token.
  /// Param [userAccount] The user account. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null.
  /// - All lowercase English letters: a to z.
  /// - All uppercase English letters: A to Z.
  /// - All numeric characters: 0 to 9.
  /// - The space character.
  /// - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
  /// Param [options] The channel media options.
  /// See [ChannelMediaOptions]
  Future<void> joinChannelWithUserAccount(
      String token, String userAccount, ChannelMediaOptions options) {
    return _invokeMethod('joinChannelWithUserAccount', {
      'token': token,
      'userAccount': userAccount,
      'options': options.toJson()
    });
  }

  /// Leaves the current channel.
  /// A successful leaveChannel method call triggers the following callbacks:
  /// - The local client: onLeaveChannel.
  /// See [RtcChannelEventHandler.leaveChannel]
  /// - The remote client: onUserOffline, if the user leaving the channel is in a Communication channel, or is a broadcaster in a Live-Broadcast channel.
  /// See [RtcChannelEventHandler.userOffline]
  Future<void> leaveChannel() {
    return _invokeMethod('leaveChannel');
  }

  /// Renews the token when the current token expires.
  /// In the following situations, the SDK decides that the current token has expired:
  /// - The SDK triggers the onTokenPrivilegeWillExpire callback, or
  /// See [RtcChannelEventHandler.tokenPrivilegeWillExpire]
  /// - The onConnectionStateChanged callback reports the TokenExpired(9) error.
  /// See [RtcChannelEventHandler.connectionStateChanged]
  /// See [ConnectionChangedReason.TokenExpired]
  /// You should get a new token from your server and call this method to renew it. Failure to do so results in the SDK disconnecting from the Agora server.
  /// Param [token] The new token.
  Future<void> renewToken(String token) {
    return _invokeMethod('renewToken', {'token': token});
  }

  /// Gets the connection state of the SDK.
  Future<ConnectionStateType> getConnectionState() {
    return _invokeMethod('getConnectionState').then((value) {
      return ConnectionStateTypeConverter.fromValue(value).e;
    });
  }

  /// Publishes the local stream to the channel.
  /// You must keep the following restrictions in mind when calling this method. Otherwise, the SDK returns the Refused(-5)：
  /// See [ErrorCode.Refused]
  /// - This method publishes one stream only to the channel corresponding to the current RtcChannel instance.
  /// - In a Live-Broadcast channel, only a broadcaster can call this method. To switch the client role, call setClientRole of the current RtcChannel instance.
  /// See [RtcChannel.setClientRole]
  /// - You can publish a stream to only one channel at a time. For details, see the advanced guide Join Multiple Channels.
  Future<void> publish() {
    return _invokeMethod('publish');
  }

  /// Stops publishing a stream to the channel.
  /// If you call this method in a channel where you are not publishing streams, the SDK returns Refused(-5).
  /// See [ErrorCode.Refused]
  Future<void> unpublish() {
    return _invokeMethod('unpublish');
  }

  /// Gets the current call ID.
  Future<String> getCallId() {
    return _invokeMethod('getCallId');
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    return _invokeMethod(
        'adjustUserPlaybackSignalVolume', {'uid': uid, 'volume': volume});
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteRemoteAudioStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> muteRemoteVideoStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    return _invokeMethod(
        'addInjectStreamUrl', {'url': url, 'config': config.toJson()});
  }

  @override
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled) {
    return _invokeMethod('addPublishStreamUrl',
        {'url': url, 'transcodingEnabled': transcodingEnabled});
  }

  @override
  Future<int> createDataStream(bool reliable, bool ordered) {
    return _invokeMethod(
        'createDataStream', {'reliable': reliable, 'ordered': ordered});
  }

  @override
  Future<void> registerMediaMetadataObserver() {
    return _invokeMethod('registerMediaMetadataObserver');
  }

  @override
  Future<void> removeInjectStreamUrl(String url) {
    return _invokeMethod('removeInjectStreamUrl', {'url': url});
  }

  @override
  Future<void> removePublishStreamUrl(String url) {
    return _invokeMethod('removePublishStreamUrl', {'url': url});
  }

  @override
  Future<void> sendMetadata(String metadata) {
    return _invokeMethod('sendMetadata', {'metadata': metadata});
  }

  @override
  Future<void> sendStreamMessage(int streamId, String message) {
    return _invokeMethod(
        'sendStreamMessage', {'streamId': streamId, 'message': message});
  }

  @override
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    return _invokeMethod('setEncryptionMode',
        {'encryptionMode': EncryptionModeConverter(encryptionMode).value()});
  }

  @override
  Future<void> setEncryptionSecret(String secret) {
    return _invokeMethod('setEncryptionSecret', {'secret': secret});
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod(
        'setLiveTranscoding', {'transcoding': transcoding.toJson()});
  }

  @override
  Future<void> setMaxMetadataSize(int size) {
    return _invokeMethod('setMaxMetadataSize', {'size': size});
  }

  @override
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType) {
    return _invokeMethod('setRemoteDefaultVideoStreamType',
        {'streamType': VideoStreamTypeConverter(streamType).value()});
  }

  @override
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority) {
    return _invokeMethod('setRemoteUserPriority', {
      'uid': uid,
      'userPriority': UserPriorityConverter(userPriority).value()
    });
  }

  @override
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType) {
    return _invokeMethod('setRemoteVideoStreamType', {
      'uid': uid,
      'streamType': VideoStreamTypeConverter(streamType).value()
    });
  }

  @override
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain) {
    return _invokeMethod(
        'setRemoteVoicePosition', {'uid': uid, 'pan': pan, 'gain': gain});
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('startChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> stopChannelMediaRelay() {
    return _invokeMethod('stopChannelMediaRelay');
  }

  @override
  Future<void> unregisterMediaMetadataObserver() {
    return _invokeMethod('unregisterMediaMetadataObserver');
  }

  @override
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('updateChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }
}

mixin RtcAudioInterface {
  /// Adjusts the playback volume of a specified remote user.
  /// You can call this method as many times as necessary to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.
  /// Note
  /// - Call this method after joining a channel.
  /// - The playback volume here refers to the mixed volume of a specified remote user.
  /// - This method can only adjust the playback volume of one specified remote user at a time. To adjust the playback volume of different remote users, call the method as many times, once for each remote user.
  /// Param [uid] ID of the remote user.
  /// Param [volume] The playback volume of the specified remote user. The value ranges from 0 to 100:
  /// - 0: Mute.
  /// - 100: The original volume.
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  /// Stops/Resumes receiving the audio stream of the specified user.
  /// Param [uid] ID of the remote user whose audio stream you want to mute.
  /// Param [muted] Determines whether to receive/stop receiving the audio stream of the specified user:
  /// - true: Stop receiving the audio stream of the user.
  /// - false: (Default) Receive the audio stream of the user.
  Future<void> muteRemoteAudioStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote audio streams.
  /// Param [muted] Determines
  /// whether to receive/stop receiving all remote audio streams:
  /// - true: Stop receiving all remote audio streams.
  /// - false: (Default) Receive all remote audio streams.
  Future<void> muteAllRemoteAudioStreams(bool muted);

  /// Sets whether to receive all remote audio streams by default.
  /// Param [muted] Determines whether to receive/stop receiving all remote audio streams by default:
  /// - true: Stop receiving all remote audio streams by default.
  /// - false: (Default) Receive all remote audio streams by default.
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);
}

mixin RtcVideoInterface {
  /// Stops/Resumes receiving the video stream of the specified user.
  /// Param [uid] ID of the remote user whose video stream you want to mute.
  /// Param [muted] Determines whether to receive/stop receiving the video stream of the specified user:
  /// - true: Stop receiving the video stream of the user.
  /// - false: (Default) Receive the video stream of the user.
  Future<void> muteRemoteVideoStream(int uid, bool muted);

  /// Stops/Resumes receiving all remote video streams.
  /// Param [muted] Determines whether to receive/stop receiving all remote video streams:
  /// - true: Stop receiving all remote video streams.
  /// - false: (Default) Receive all remote video streams.
  Future<void> muteAllRemoteVideoStreams(bool muted);

  /// Sets whether to receive all remote video streams by default.
  /// Param [muted] Determines whether to receive/stop receiving all remote video streams by default:
  /// - true: Stop receiving all remote video streams by default.
  /// - false: (Default) Receive all remote video streams by default.
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);
}

mixin RtcVoicePositionInterface {
  /// Sets the sound position of a remote user.
  /// When the local user calls this method to set the sound position of a remote user, the sound difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a real sense of space. This method applies to massively multiplayer online games, such as Battle Royale games.
  /// Note
  /// - For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.
  /// See [RtcEngine.enableSoundPositionIndication]
  /// - This method requires hardware support. For the best sound positioning, we recommend using a stereo headset.
  /// Param [uid] The ID of the remote user.
  /// Param [pan] The sound position of the remote user. The value ranges from -1.0 to 1.0:
  /// - 0.0: The remote sound comes from the front.
  /// - -1.0: The remote sound comes from the left.
  /// - 1.0: The remote sound comes from the right.
  /// Param [gain] Gain of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original gain of the remote user). The smaller the value, the less the gain.
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);
}

mixin RtcPublishStreamInterface {
  /// Sets the video layout and audio settings for CDN live.
  /// The SDK triggers the onTranscodingUpdated callback when you call this method to update the LiveTranscodingclass. If you call this method to set the LiveTranscoding class for the first time, the SDK does not trigger the onTranscodingUpdated callback.
  /// See [RtcChannelEventHandler.transcodingUpdated]
  /// Note
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method can only be called by a broadcaster in a Live-Broadcast channel.
  /// - Ensure that you call this method before calling the addPublishStreamUrl method.
  /// See [RtcChannel.addPublishStreamUrl]
  /// Param [transcoding] Sets the CDN live audio/video transcoding settings.
  /// See [LiveTranscoding]
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  /// Publishes the local stream to the CDN.
  /// This method call triggers the onRtmpStreamingStateChanged callback on the local client to report the state of adding a local stream to the CDN.
  /// See [RtcChannelEventHandler.rtmpStreamingStateChanged]
  /// Note
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// - Ensure that the user joins a channel before calling this method.
  /// - This method can only be called by a broadcaster in a Live-Broadcast channel.
  /// - This method adds only one stream HTTP/HTTPS URL address each time it is called.
  /// Param [url] The CDN streaming URL in the RTMP format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  /// Param [transcodingEnabled] Sets whether transcoding is enabled/disabled. If you set this parameter as true, ensure that you call the setLiveTranscoding method before this method.
  /// See [RtcChannel.setLiveTranscoding]
  /// - true: Enable transcoding. To transcode the audio or video streams when publishing them to CDN live, often used for combining the audio and video streams of multiple broadcasters in CDN live.
  /// - false: Disable transcoding.
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  /// Removes an RTMP stream from the CDN.
  /// This method removes the RTMP URL address (added by addPublishStreamUrl) from a CDN live stream. The SDK reports the result of this method call in the onRtmpStreamingStateChanged callback.
  /// See [RtcChannel.addPublishStreamUrl]
  /// See [RtcChannelEventHandler.rtmpStreamingStateChanged]
  /// Note
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// - This method can only be called by a broadcaster in a Live-Broadcast channel.
  /// - This method removes only one stream HTTP/HTTPS URL address each time it is called.
  /// Param [url] The RTMP URL address to be removed. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  Future<void> removePublishStreamUrl(String url);
}

mixin RtcMediaRelayInterface {
  /// Starts to relay media streams across channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged and onChannelMediaRelayEvent callbacks, and these callbacks report the state and events of the media stream relay.
  /// See [RtcChannelEventHandler.channelMediaRelayStateChanged]
  /// See [RtcChannelEventHandler.channelMediaRelayEvent]
  /// - If the onChannelMediaRelayStateChanged callback reports Running(2) and None(0), and the onChannelMediaRelayEvent callback reports SentToDestinationChannel(4), the SDK starts relaying media streams between the original and the destination channel.
  /// See [ChannelMediaRelayState.Running]
  /// See [ChannelMediaRelayError.None]
  /// See [ChannelMediaRelayEvent.SentToDestinationChannel]
  /// - If the onChannelMediaRelayStateChanged callback returns Failure(3), an exception occurs during the media stream relay.
  /// See [ChannelMediaRelayState.Failure]
  /// Note
  /// - Call this method after joining the channel.
  /// - This method can only be called by a broadcaster in a Live-Broadcast channel.
  /// - After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelay method to quit the current relay.
  /// See [RtcChannel.stopChannelMediaRelay]
  /// Param [channelMediaRelayConfiguration] The configuration of the media stream relay.
  /// See [ChannelMediaRelayConfiguration]
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Updates the channels for media relay.
  /// After the channel media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the updateChannelMediaRelay method.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayEvent callback with the UpdateDestinationChannel(7) state code.
  /// See [RtcChannelEventHandler.channelMediaRelayEvent]
  /// See [ChannelMediaRelayEvent.UpdateDestinationChannel]
  /// Note
  /// - Call this method after the startChannelMediaRelay method to update the destination channel.
  /// See [RtcChannel.startChannelMediaRelay]
  /// - This method supports adding at most four destination channels in the relay.
  /// Param [channelMediaRelayConfiguration] The media stream relay configuration.
  /// See [ChannelMediaRelayConfiguration]
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// Stops the media stream relay.
  /// Once the relay stops, the broadcaster quits all the destination channels.
  /// After a successful method call, the SDK triggers the onChannelMediaRelayStateChanged callback. If the callback reports Idle(0) and None(0), the broadcaster successfully stops the relay.
  /// See [RtcChannelEventHandler.channelMediaRelayStateChanged]
  /// See [ChannelMediaRelayState.Idle]
  /// See [ChannelMediaRelayError.None]
  /// Note
  /// - If the method call fails, the SDK triggers the onChannelMediaRelayStateChanged callback with the ServerNoResponse(2) or ServerConnectionLost(8) state code. You can leave the channel using leaveChannel, and the media stream relay automatically stops.
  /// See [RtcChannelEventHandler.channelMediaRelayStateChanged]
  /// See [ChannelMediaRelayError.ServerNoResponse]
  /// See [ChannelMediaRelayError.ServerConnectionLost]
  /// See [RtcChannel.leaveChannel]
  Future<void> stopChannelMediaRelay();
}

mixin RtcDualStreamInterface {
  /// Sets the video stream type of the remote video stream when the remote user sends dual streams.
  /// This method allows the app to adjust the corresponding video-stream type based on the size of the video window to reduce the bandwidth and resources.
  /// - If the remote user enables the dual-stream mode by calling the enableDualStreamMode method, the SDK receives the high-video stream by default. You can use this method to switch to the low-video stream.
  /// See [RtcEngine.enableDualStreamMode]
  /// - If dual-stream mode is not enabled, the SDK receives the high-stream video by default.
  /// By default, the aspect ratio of the low-video stream is the same as the high-video stream. Once the resolution of the high-video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-video stream.
  /// Param [uid] ID of the remote user sending the video stream.
  /// Param [streamType] Sets the video-stream type.
  /// See [RtcEngine.enableDualStreamMode]
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType);

  /// Sets the default video-stream type of the remote video stream when the remote user sends dual streams.
  /// Param [streamType] Sets the default video-stream type.
  /// See [VideoStreamType]
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);
}

mixin RtcFallbackInterface {
  /// Sets the priority of a remote user's media stream.
  /// Use this method with the setRemoteSubscribeFallbackOption method. If a remote video stream experiences the fallback, the SDK ensures the high-priority user gets the best possible stream quality.
  /// See [RtcEngine.setRemoteSubscribeFallbackOption]
  /// Note
  /// - The Agora SDK supports setting userPriority as high for one user only.
  /// Param [uid] The ID of the remote user.
  /// Param [userPriority] The priority of the remote user.
  /// See [UserPriority]
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);
}

mixin RtcMediaMetadataInterface {
  /// Registers the metadata observer.
  /// A successful call of this method triggers the getMaxMetadataSize callback.
  /// See [RtcChannel.setMaxMetadataSize]
  /// This method enables you to add synchronized metadata in the video stream for more diversified live broadcast interactions, such as sending shopping links, digital coupons, and online quizzes.
  /// Note
  /// - Call this method before the joinChannel method.
  /// See [RtcChannel.joinChannel]
  /// - This method applies to the Live-Broadcast profile only.
  /// See [ChannelProfile.LiveBroadcasting]
  Future<void> registerMediaMetadataObserver();

  /// TODO
  Future<void> unregisterMediaMetadataObserver();

  /// TODO
  /// Param [size]
  Future<void> setMaxMetadataSize(int size);

  /// TODO
  /// Param [metadata]
  Future<void> sendMetadata(String metadata);
}

mixin RtcEncryptionInterface {
  /// Enables built-in encryption with an encryption password before joining a channel.
  /// All users in a channel must set the same encryption password. The encryption password is automatically cleared once a user leaves the channel. If the encryption password is not specified or set to empty, the encryption functionality is disabled.
  /// Note
  /// - For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  /// - Do not use this method for CDN live streaming.
  /// Param [secret] The encryption password.
  Future<void> setEncryptionSecret(String secret);

  /// Sets the built-in encryption mode.
  /// The Agora SDK supports built-in encryption, which is set to aes-128-xts mode by default. Call this method to set the encryption mode to use other encryption modes. All users in the same channel must use the same encryption mode and password.
  /// Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  /// Note
  /// - Do not use this method for CDN streaming.
  /// - Before calling this method, ensure that you have called setEncryptionSecret to enable encryption.
  /// See [RtcEngine.setEncryptionSecret]
  /// Param [encryptionMode] Sets the encryption mode.
  /// See [EncryptionMode]
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);
}

mixin RtcInjectStreamInterface {
  /// Injects an online media stream to a Live-Broadcast channel.
  /// If this method call succeeds, the server pulls the voice or video stream and injects it into a live channel. This applies to scenarios where all audience members in the channel can watch a live show and interact with each other.
  /// Note
  /// - Ensure that you enable the RTMP Converter service before using this function. See Prerequisites.
  /// - This method can only be called by a broadcaster in a Live-Broadcast channel.
  /// Calling this method triggers the following callbacks:
  /// - The local client:
  /// -- onStreamInjectedStatus, with the state of injecting the media stream.
  /// See [RtcChannelEventHandler.streamInjectedStatus]
  /// -- onUserJoined(uid: 666), if the method call succeeds and the online media stream is injected into the channel.
  /// See [RtcChannelEventHandler.userJoined]
  /// - The remote client:
  /// -- onUserJoined(uid: 666), if the method call succeeds and the online media stream is injected into the channel.
  /// See [RtcChannelEventHandler.userJoined]
  /// Param [url] The URL address to be added to the ongoing live broadcast. Valid protocols are RTMP, HLS, and FLV.
  /// - Supported FLV audio codec type: AAC.
  /// - Supported FLV video codec type: H264(AVC).
  /// Param [config] The LiveInjectStreamConfig object, which contains the configuration information for the added voice or video stream.
  /// See [LiveInjectStreamConfig]
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  /// Removes the injected online media stream from a Live-Broadcast channel.
  /// This method removes the URL address added by addInjectStreamUrl.
  /// See [RtcChannel.addInjectStreamUrl]
  /// If you successfully remove the URL address from the Live-Broadcast, the SDK triggers the onUserJoined callback, with the stream uid of 666.
  /// See [RtcChannelEventHandler.userJoined]
  /// Param [url] The URL address to be removed.
  Future<void> removeInjectStreamUrl(String url);
}

mixin RtcStreamMessageInterface {
  /// Creates a data stream.
  /// Each user can create up to five data streams during the life cycle of the RtcChannel instance.
  /// See [RtcChannel]
  /// Note
  /// - Set both the reliable and ordered parameters to true or false. Do not set one as true and the other as false.
  /// Param [reliable] Sets whether or not the recipients are guaranteed to receive the data stream from the sender within five seconds.
  /// - true: The recipients receive the data from the sender within five seconds. If the recipient does not receive the data within five seconds, the SDK triggers the onStreamMessageError callback and returns an error code.
  /// See [RtcChannelEventHandler.streamMessageError]
  /// - false: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.
  /// Param [ordered] Determines whether or not the recipients receive the data stream in the sent order.
  /// - true: The recipients receive the data in the sent order.
  /// - false: The recipients do not receive the data in the sent order.
  Future<int> createDataStream(bool reliable, bool ordered);

  /// Sends the data stream message.
  /// The SDK has the following restrictions on this method:
  /// - Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.
  /// - Each client can send up to 6 KB of data per second.
  /// - Each user can have up to five data channels simultaneously.
  /// A successful sendStreamMessage method call triggers the onStreamMessage callback on the remote client, from which the remote user gets the stream message.
  /// See [RtcChannelEventHandler.streamMessage]
  /// A failed sendStreamMessage method call triggers the onStreamMessageError callback on the remote client.
  /// See [RtcChannelEventHandler.streamMessageError]
  /// Param [streamId] ID of the sent data stream returned by the createDataStream method.
  /// See [RtcChannel.createDataStream]
  /// Param [message] The message data.
  Future<void> sendStreamMessage(int streamId, String message);
}
