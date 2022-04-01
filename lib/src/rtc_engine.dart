import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/src/impl/rtc_engine_impl.dart';
import 'package:agora_rtc_engine/src/rtc_engine_event_handler.dart';

import 'package:meta/meta.dart';

import 'classes.dart';
import 'enums.dart';
import 'rtc_device_manager.dart';

// ignore_for_file: non_constant_identifier_names

///
/// The basic interface of the Agora SDK that implements the core functions of real-time communication.
/// RtcEngine provides the main methods that your app can call.
///
abstract class RtcEngine {
  ///
  /// Gets the RtcDeviceManager class.
  ///
  ///
  /// **return** The RtcDeviceManager class.
  ///
  RtcDeviceManager get deviceManager;

  ///
  /// Creates the RtcEngine object.
  /// Deprecated:
  ///  This method is deprecated. Use createWithContext instead.
  ///
  /// Param [appId] The Agora App ID of your Agora project.
  ///
  /// **return** The RtcEngine instance, if the method call succeeds.
  ///  An error code, if the call fails.
  ///
  static Future<RtcEngine> create(String appId) {
    return createWithContext(RtcEngineContext(appId));
  }

  ///
  /// Initializes the RtcEngine object.
  /// Deprecated:
  ///  This method is deprecated. Use createWithContext instead.
  ///
  /// Param [appId] The App ID of your Agora project.
  ///
  /// Param [areaCode] The area code.
  ///
  /// **return** The RtcEngine instance, if the method call succeeds.
  ///  An error code, if the call fails.
  ///
  @Deprecated('This method is deprecated. Use createWithContext instead.')
  static Future<RtcEngine> createWithAreaCode(
      String appId, List<AreaCode> areaCode) {
    return createWithContext(RtcEngineContext(appId, areaCode: areaCode));
  }

  ///
  /// Initializes the RtcEngine object.
  /// Deprecated:
  ///  This method is deprecated. Use createWithContext instead.
  ///
  /// Param [config] The RtcEngine configuraiton.
  ///
  @Deprecated('This method is deprecated. Use createWithContext instead.')
  static Future<RtcEngine> createWithConfig(RtcEngineConfig config) async {
    return createWithContext(config);
  }

  ///
  /// Initializes RtcEngine.
  /// All called methods provided by the RtcEngine class are executed asynchronously. Agora recommends calling these methods in the same thread. Before calling other APIs, you must call create and createWithContext to create and initialize the RtcEngine object.
  ///  The SDK supports creating only one RtcEngineinstance for an app.
  ///
  /// Param [config] Configurations for the RtcEngine instance. See RtcEngineContext .
  ///
  ///
  static Future<RtcEngine> createWithContext(RtcEngineContext config) async {
    return RtcEngineImpl.createWithContext(config);
  }

  ///
  /// Gets a child process object.
  ///
  ///
  /// Param [appGroup] The app group.
  ///
  /// **return** A child process object, which can be used in scenarios such as screen sharing.
  ///
  Future<RtcEngine> getScreenShareHelper({String? appGroup});

  /// @nodoc
  @protected
  Future<void> initialize(RtcEngineContext config);

  ///
  /// Gets the SDK version.
  ///
  ///
  /// **return** The SDK version number. The format is a string.
  ///
  Future<String?> getSdkVersion();

  ///
  /// Gets the warning or error description.
  ///
  ///
  /// Param [error] The error code or warning code reported by the SDK.
  ///
  /// **return** The specific error or warning description.
  ///
  Future<String?> getErrorDescription(int error);

  ///
  /// Releases the RtcEngine instance.
  /// This method releases all resources used by the Agora SDK. Use this method for apps in which users occasionally make voice or video calls. When users do not make calls, you can free up resources for other operations.
  ///  If you want to create a new RtcEngine instance after destroying the current one, ensure that you wait till the destroy method execution to complete.
  ///
  Future<void> destroy();

  ///
  /// Adds event handlers
  /// The SDK uses the RtcEngineEventHandler class to send callbacks to the app. The app inherits the methods of this class to receive these callbacks. All methods in this interface class have default (empty) implementations. Therefore, the application can only inherit some required events. In the callbacks, avoid time-consuming tasks or calling APIs that can block the thread, such as the sendStreamMessage method. Otherwise, the SDK may not work properly.
  ///
  /// Param [handler] Callback events to be added.
  ///
  void setEventHandler(RtcEngineEventHandler handler);

  ///
  /// Sets the channel profile.
  /// After initializing the SDK, the default channel profile is the communication profile. After initializing the SDK, the default channel profile is the live streaming profile. You can call this method to set the usage scenario of Agora channel. The Agora SDK differentiates channel profiles and applies optimization algorithms accordingly. For example, it prioritizes smoothness and low latency for a video call and prioritizes video quality for interactive live video streaming. To ensure the quality of real-time communication, Agora recommends that all users in a channel use the same channel profile.
  ///  This method must be called and set before joinChannel, and cannot be set again after joining the channel.
  ///
  /// Param [profile] The channel profile. See ChannelProfile for details.
  ///
  ///
  Future<void> setChannelProfile(ChannelProfile profile);

  ///
  /// Sets the user role and level in an interactive live streaming channel.
  /// In the interactive live streaming profile, the SDK sets the user role as audience by default. You can call this method to set the user role as host.
  ///  You can call this method either before or after joining a channel. If you call this method to switch the user role after joining a channel, the SDK automatically does the following:
  ///  Calls muteLocalAudioStream and muteLocalVideoStream to change the publishing state.
  ///  Triggers clientRoleChanged on the local client.
  ///  Triggers userJoined or userOffline on the remote client. This method applies to the interactive live streaming profile (the profile parameter of setChannelProfile is LiveBroadcasting) only.
  ///
  /// Param [role] The user role in the interactive live streaming. See ClientRole .
  ///
  /// Param [options] The detailed options of a user, including the user level. See ClientRoleOptions for details.
  ///
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions? options]);

  ///
  /// Joins a channel with the user ID, and configures whether to automatically subscribe to the audio or video streams.
  /// This method enables the local user to join a real-time audio and video interaction channel. With the same App ID, users in the same channel can talk to each other, and multiple users in the same channel can start a group chat.
  ///  A successful call of this method triggers the following callbacks:
  ///  The local client: The joinChannelSuccess and connectionStateChanged callbacks.
  ///  The remote client: userJoined , if the user joining the channel is in the Communication profile or is a host in the Live-broadcasting profile. When the connection between the client and Agora's server is interrupted due to poor network conditions, the SDK tries reconnecting to the server. When the local client successfully rejoins the channel, the SDK triggers the rejoinChannelSuccess callback on the local client.
  ///
  /// Param [token] The token generated on your server for authentication. See Authenticate Your Users with Token.
  ///  Ensure that the App ID used for creating the token is the same App ID used by the createWithContext method for initializing the RTC engine.
  ///
  /// Param [channelName] The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  The 10 numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  /// Param [optionalInfo] Reserved for future use.
  ///
  ///
  /// Param [optionalUid] User ID This parameter is used to identify the user in the channel for real-time audio and video interaction. You need to set and manage user IDs yourself, and ensure that each user ID in the same channel is unique. This parameter is a 32-bit unsigned integer. The value range is 1 to
  ///  232-1. If the user ID is not assigned (or set to 0), the SDK assigns a random user ID and returns it in the joinChannelSuccess callback. Your app must maintain the returned user ID, because the SDK
  ///  does not do so.
  ///
  /// Param [options] The channel media options.
  ///
  ///
  Future<void> joinChannel(
      String? token, String channelName, String? optionalInfo, int optionalUid,
      [ChannelMediaOptions? options]);

  ///
  /// Switches to a different channel, and configures whether to automatically subscribe to audio or video streams in the target channel.
  /// This method allows the audience of a LIVE_BROADCASTING channel to switch to a different channel.
  ///  After the user successfully switches to another channel, the leaveChannel and joinChannelSuccess callbacks are triggered to indicate that the user has left the original channel and joined a new one.
  ///  Once the user switches to another channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. If you do not want to subscribe to a specified stream or all remote streams, call the mute methods accordingly.
  ///
  /// Param [token] The token generated at your server.
  ///  In scenarios with low security requirements, token is optional and can be set as null.
  ///  In scenarios with high security requirements, set the value to the token generated from your server. If you enable the App Certificate, you must use a token to join the channel. Ensure that the App ID used for creating the token is the same App ID used by the createWithContext method for initializing the RTC engine.
  ///
  ///
  /// Param [channelName] The name of the channel. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channelId enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  ///  All lowercase English letters: a to z.
  ///  All uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!"、"#"、"$"、"%"、"&"、"("、")"、"+"、"-"、":"、";"、"<"、"="、"."、">"、"?"、"@"、"["、"]"、"^"、"_"、"{"、"}"、"|"、"~"、","
  ///
  /// Param [options] The channel media options. See ChannelMediaOptions.
  ///
  Future<void> switchChannel(String? token, String channelName,
      [ChannelMediaOptions? options]);

  ///
  /// Leaves a channel.
  /// This method releases all resources related to the session. This method call is asynchronous. When this method returns, it does not necessarily mean that the user has left the channel.
  ///  After joining the channel, you must call this method to end the call; otherwise, you cannot join the next call.
  ///  After joining the channel, you must call this method or to end the call; otherwise, you cannot join the next call.
  ///  A successful call of this method triggers the following callbacks:
  ///  The local client: leaveChannel .
  ///  The remote client: userOffline , if the user joining the channel is in the Communication profile, or is a host in the Live-broadcasting profile.
  ///  If you call destroy immediately after calling this method, the SDK does not trigger the leaveChannel callback.
  ///  If you call this method during a CDN live streaming, the SDK automatically calls the removePublishStreamUrl method.
  ///
  Future<void> leaveChannel();

  ///
  /// Gets a new token when the current token expires after a period of time.
  /// Passes a new token to the SDK. A token expires after a certain period of time. In the following two cases, the app should call this method to pass in a new token. Failure to do so will result in the SDK disconnecting from the server.
  ///  The SDK triggers the tokenPrivilegeWillExpire callback.
  ///  The connectionStateChanged callback reports TokenExpired(9).
  ///
  /// Param [token] The new token.
  ///
  Future<void> renewToken(String token);

  ///
  /// Enables interoperability with the Agora Web SDK (applicable only in the live streaming scenarios).
  /// Deprecated:
  ///  The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method. This method enables or disables interoperability with the Agora Web SDK. If the channel has Web SDK users, ensure that you call this method, or the video of the Native user will be a black screen for the Web user.
  ///  This method is only applicable in live streaming scenarios, and interoperability is enabled by default in communication scenarios.
  ///
  /// Param [enabled] Whether to enable interoperability with the Agora Web SDK.
  ///  true: Enable interoperability.
  ///  false: (Default) Disable interoperability.
  ///
  ///
  @Deprecated(
      'The SDK automatically enables interoperability with the Web SDK, so you no longer need to call this method.')
  Future<void> enableWebSdkInteroperability(bool enabled);

  ///
  /// Gets the current connection state of the SDK.
  /// You can call this method either before or after joining a channel.
  ///
  /// **return** The current connection state.
  ///
  Future<ConnectionStateType> getConnectionState();

  ///
  /// Reports customized messages.
  /// Agora supports reporting and analyzing customized messages. This function is in the beta stage with a free trial. The ability provided in its beta test version is reporting a maximum of 10 message pieces within 6 seconds, with each message piece not exceeding 256 bytes and each string not exceeding 100 bytes. To try out this function, contact and discuss the format of customized messages with us.
  ///
  Future<void> sendCustomReportMessage(
      String id, String category, String event, String label, int value);

  ///
  /// Retrieves the call ID.
  /// When a user joins a channel on a client, a callId is generated to identify the call from the client. Some methods, such as rate and complain , must be called after the call ends to submit feedback to the SDK. These methods require the callId parameter.
  ///  Call this method after joining a channel.
  ///
  /// **return** The current call ID.
  ///
  Future<String?> getCallId();

  ///
  /// Allows a user to rate a call after the call ends.
  /// Ensure that you call this method after leaving a channel.
  ///
  /// Param [callId] The current call ID. You can get the call ID by calling getCallId .
  ///
  /// Param [rating] The rating of the call. The value is between 1 (lowest score) and 5 (highest score). If you set a value out of this range, the SDK returns the -2 (ERR_INVALID_ARGUMENT) error.
  ///
  /// Param [description] (Optional) A description of the call. The string length should be less than 800 bytes.
  ///
  Future<void> rate(String callId, int rating, {String? description});

  ///
  /// Allows a user to complain about the call quality after a call ends.
  /// This method allows users to complain about the quality of the call. Call this method after the user leaves the channel.
  ///
  /// Param [callId] The current call ID. You can get the call ID by calling getCallId .
  ///
  /// Param [description] (Optional) A description of the call. The string length should be less than 800 bytes.
  ///
  Future<void> complain(String callId, String description);

  ///
  /// Sets the log files that the SDK outputs.
  /// By default, the SDK outputs five log files: agorasdk.log, agorasdk_1.log, agorasdk_2.log, agorasdk_3.log, and agorasdk_4.log. Each log file has a default size of 512 KB. These log files are encoded in UTF-8. The SDK writes the latest log in agorasdk.log. When agorasdk.log is full, the SDK deletes the log file with the earliest modification time among the other four, renames agorasdk.log to the name of the deleted log file, and create a new agorasdk.log to record the latest logs.
  ///  Ensure that you call this method immediately after initializing RtcEngine , otherwise, the output log may not be complete.
  ///
  /// Param [filePath] The absolute path of the log files. The default file path is C: \Users\<user_name>\AppData\Local\Agora\<process_name>\agorasdk.log. Ensure that the directory for the log files exists and is writable. You can use this parameter to rename the log files.
  ///
  ///
  @Deprecated('')
  Future<void> setLogFile(String filePath);

  ///
  /// Sets the log output level of the SDK.
  /// This method sets the output log level of the SDK. You can use one or a combination of the log filter levels. The log level follows the sequence of OFF, CRITICAL, ERROR, WARNING, INFO, and DEBUG. Choose a level to see the logs preceding that level.
  ///  If, for example, you set the log level to WARNING, you see the logs within levels CRITICAL, ERROR, and WARNING.
  ///
  /// Param [filter] The output log level of the SDK.
  ///
  @Deprecated('')
  Future<void> setLogFilter(LogFilter filter);

  ///
  /// Sets the size of a log file that the SDK outputs.
  /// By default, the SDK outputs five log files: agorasdk.log, agorasdk_1.log, agorasdk_2.log, agorasdk_3.log, and agorasdk_4.log. Each log file has a default size of 512 KB. These log files are encoded in UTF-8. The SDK writes the latest log in agorasdk.log. When agorasdk.log is full, the SDK deletes the log file with the earliest modification time among the other four, renames agorasdk.log to the name of the deleted log file, and create a new agorasdk.log to record the latest logs.
  ///  If you want to set the size of the log file, you need to call this method before setLogFile , otherwise, the log will be cleared.
  ///
  /// Param [fileSizeInKBytes] The size (KB) of a log file. The default value is 1024 KB. If you set fileSizeInKByte to 1024 KB, the maximum aggregate size of the log files output by the SDK is 5 MB. if you set fileSizeInKByte to less than 1024 KB, the setting is invalid, and the maximum size of a log file is still 1024 KB.
  ///
  @Deprecated('')
  Future<void> setLogFileSize(int fileSizeInKBytes);

  ///
  /// Provides technical preview functionalities or special customizations by configuring the SDK with JSON options.
  /// The JSON options are not public by default. Agora is working on making commonly used JSON options public in a standard way.
  ///
  /// Param [parameters] Sets the parameter as a JSON string in the specified format.
  ///
  Future<void> setParameters(String parameters);

  ///
  /// Gets the C++ handle of the Native SDK.
  /// This method is used to retrieve the native C++ handle of the SDK engine used in special scenarios, such as registering the audio and video frame observer.
  ///
  /// **return** The native handle of the SDK.
  ///
  Future<int?> getNativeHandle();

  ///
  /// Enables/Disables deep-learning noise reduction.
  /// The SDK enables traditional noise reduction mode by default to reduce most of the stationary background noise. If you need to reduce most of the non-stationary background noise, Agora recommends enabling deep-learning noise reduction as follows:
  ///  Ensure that the dynamic library is integrated in your project: libagora_ai_denoise_extension.dll
  ///  Call enableDeepLearningDenoise(true). Deep-learning noise reduction requires high-performance devices. The deep-learning noise reduction is enabled only when the device supports this function. For example, the following devices and later models are known to support deep-learning noise reduction:
  ///  iPhone 6S
  ///  MacBook Pro 2015
  ///  iPad Pro (2nd generation)
  ///  iPad mini (5th generation)
  ///  iPad Air (3rd generation) After successfully enabling deep-learning noise reduction, if the SDK detects that the device performance is not sufficient, it automatically disables deep-learning noise reduction and enables traditional noise reduction.
  ///  If you call enableDeepLearningDenoise(true) or the SDK automatically disables deep-learning noise reduction in the channel, when you need to re-enable deep-learning noise reduction, you need to call leaveChannel first, and then call enableDeepLearningDenoise(true). This method dynamically loads the library, so Agora recommends calling this method before joining a channel.
  ///  This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  ///
  /// Param [enable] Whether to enable deep-learning noise reduction.
  ///  true: (Default) Enable deep-learning noise reduction.
  ///  false: Disable deep-learning noise reduction.
  ///
  ///
  Future<void> enableDeepLearningDenoise(bool enable);

  ///
  /// Sets the Agora cloud proxy service.
  /// When users' network access is restricted by a firewall, configure the firewall to allow specific IP addresses and ports provided by Agora; then, call this method to enable the cloud proxy and set the cloud proxy type with the proxyType parameter.
  ///  After successfully connecting to the cloud proxy, the SDK triggers the connectionStateChanged (Connecting, SettingProxyServer) callback.
  ///  As of v3.6.2, when a user calls this method and then joins a channel successfully, the SDK triggers the proxyConnected callback to report the user ID, the proxy type connected, and the time elapsed from the user calling until this callback is triggered.
  ///  To disable the cloud proxy that has been set, call setCloudProxy(None).
  ///  To change the cloud proxy type that has been set, call setCloudProxy(None) first, and then call setCloudProxy with the desired proxyType. Agora recommends that you call this method before joining the channel or after leaving the channel.
  ///  For the SDK v3.3.x, when users use the Force UDP cloud proxy, the services for Media Push and cohosting across channels are not available; for the SDK v3.4.0 or later, when users behind a firewall use the Force UDP cloud proxy, the services for Media Push and cohosting across channels are not available.
  ///  When you use the Force TCP cloud proxy, note the following: An error occurs when calling to play online music files in the HTTP protocol.
  ///  The services for Media Push and cohosting across channels use the cloud proxy with the TCP protocol.
  ///
  /// Param [proxyType] The type of the cloud proxy. See CloudProxyType . This parameter is required. The SDK reports an error if you do not pass in a value.
  ///
  Future<void> setCloudProxy(CloudProxyType proxyType);

  ///
  /// Uploads all SDK log files.
  /// Since
  ///  v3.3.0 Uploads all SDK log files from the client to the Agora server. After calling this method successfully, the SDK triggers the uploadLogResult callback to report whether the log file is successfully uploaded to the Agora server.
  ///  For easier debugging, Agora recommends that you bind the uploadLogFile method to the UI element of your app, to instruct the user to upload a log file when a quality issue occurs.
  ///
  /// **return** The method call succeeds: Return the request ID. The request ID is the same as the requestId in the uploadLogResult callback. You can use the requestId to match a specific upload with a callback.
  ///  The method callI fails: Returns null. Probably because the method call frequency exceeds the limit.
  ///
  Future<String?> uploadLogFile();

  /// @nodoc
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config);

  ///
  /// Enables/Disables the virtual background. (beta feature)
  /// The virtual background function allows you to replace the original background image of the local user or to blur the background. After successfully enabling the virtual background function, all users in the channel can see the customized background.
  ///  You can find out from the virtualBackgroundSourceEnabled callback whether the virtual background is successfully enabled or the cause of any errors.
  ///  Enabling the virtual background function involves a series of method calls. The calling sequence is as follows:
  ///  Call (agora_segmentation, PortraitSegmentation, true) to enable the extension.
  ///  Call enableVideo to enable the video module.
  ///  Call this method to enable the virtual background function.
  ///  Before calling this method, ensure that you have integrated the dynamic library.
  ///  Android: libagora_segmentation_extension.so
  ///  iOS: AgoraVideoSegmentationExtension.xcframework Call this method after enableVideo .
  ///  This function requires a high-performance device. Agora recommends that you use this function on devices with the following chips:
  ///  Snapdragon 700 series 750G and later
  ///  Snapdragon 800 series 835 and later
  ///  Dimensity 700 series 720 and later
  ///  Kirin 800 series 810 and later
  ///  Kirin 900 series 980 and later
  ///  Devices with an A9 chip and better, as follows:
  ///  iPhone 6S and later
  ///  iPad Air 3rd generation and later
  ///  iPad 5th generation and later
  ///  iPad Pro 2nd generation and later
  ///  iPad mini 5th generation and later Agora recommends that you use this function in scenarios that meet the following conditions:
  ///  A high-definition camera device is used, and the environment is uniformly lit.
  ///  There are few objects in the captured video. Portraits are half-length and unobstructed. Ensure that the background is a solid color that is different from the color of the user's clothing.
  ///
  /// Param [enabled] Whether to enable virtual background:
  ///  true: Enable virtual background.
  ///  false: Disable virtual background.
  ///
  ///
  /// Param [backgroundSource] The custom background image. See VirtualBackgroundSource for details. To adapt the resolution of the custom background image to that of the video captured by the SDK, the SDK scales and crops the custom background image while ensuring that the content of the custom background image is not distorted.
  ///
  Future<void> enableVirtualBackground(
      bool enabled, VirtualBackgroundSource backgroundSource);

  ///
  /// Takes a snapshot of a video stream.
  /// This method takes a snapshot of a video stream from the specified user, generates a JPG image, and saves it to the specified path.
  ///  The method is asynchronous, and the SDK has not taken the snapshot when the method call returns. After a successful method call, the SDK triggers snapshotTaken callback to report whether the snapshot is successfully taken as well as the details for the snapshot taken.
  ///  Call this method after joining a channel.
  ///  If the video of the specified user is pre-processed, for example, added with watermarks or image enhancement effects, the generated snapshot also includes the pre-processing effects.
  ///
  /// Param [channel] The channel name.
  ///
  /// Param [uid] The user ID. Set uid as 0 if you want to take a snapshot of the local user's video.
  ///
  /// Param [filePath] The local path (including the filename extensions) of the snapshot. For example, Windows: C:\Users\<user_name>\AppData\Local\Agora\<process_name>\example.jpg
  ///  iOS: /App Sandbox/Library/Caches/example.jpg
  ///  macOS: ～/Library/Logs/example.jpg
  ///  Android: /storage/emulated/0/Android/data/<package name>/files/example.jpg
  ///  Ensure that the path you specify exists and is writable.
  ///
  ///
  Future<void> takeSnapshot(String channel, int uid, String filePath);

  ///
  /// Registers a user account.
  /// Once registered, the user account can be used to identify the local user when the user joins the channel. After the registration is successful, the user account can identify the identity of the local user, and the user can use it to join the channel.
  ///  After the user successfully registers a user account, the SDK triggers the localUserRegistered callback on the local client, reporting the user ID and user account of the local user.
  ///  This method is optional. To join a channel with a user account, you can choose either of the following ways:
  ///  Call registerLocalUserAccount to to create a user account, and then call joinChannelWithUserAccount to join the channel.
  ///  Call the joinChannelWithUserAccount method to join the channel. The difference between the two ways is that the time elapsed between calling the registerLocalUserAccount method and joining the channel is shorter than directly calling joinChannelWithUserAccount. Ensure that you set the userAccount parameter; otherwise, this method does not take effect.
  ///  Ensure that the userAccount is unique in the channel.
  ///  To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///
  /// Param [appId] The App ID of your project on Agora Console.
  ///
  /// Param [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported characters are (89 in total):
  ///  The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  ///
  Future<void> registerLocalUserAccount(String appId, String userAccount);

  ///
  /// Joins the channel with a user account, and configures whether to automatically subscribe to audio or video streams after joining the channel.
  /// This method allows a user to join the channel with the user account. After the user successfully joins the channel, the SDK triggers the following callbacks: The local client: localUserRegistered , joinChannelSuccess and connectionStateChanged callbacks.
  ///  The remote client: The userJoined callback if the user is in the COMMUNICATION profile, and the userInfoUpdated callback if the user is a host in the LIVE_BROADCASTING profile. Once a user joins the channel, the user subscribes to the audio and video streams of all the other users in the channel by default, giving rise to usage and billing calculation. To stop subscribing to a specified stream or all remote streams, call the corresponding mute methods.
  ///  To ensure smooth communication, use the same parameter type to identify the user. For example, if a user joins the channel with a user ID, then ensure all the other users use the user ID too. The same applies to the user account. If a user joins the channel with the Agora Web SDK, ensure that the ID of the user is set to the same parameter type.
  ///
  /// Param [options] The channel media options.
  ///
  ///
  /// Param [token]
  ///
  /// Param [userAccount] The user account. This parameter is used to identify the user in the channel for real-time audio and video engagement. You need to set and manage user accounts yourself and ensure that each user account in the same channel is unique. The maximum length of this parameter is 255 bytes. Ensure that you set this parameter and do not set it as null. Supported characters are (89 in total): The 26 lowercase English letters: a to z.
  ///  The 26 uppercase English letters: A to Z.
  ///  All numeric characters: 0 to 9.
  ///  Space
  ///  "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  Future<void> joinChannelWithUserAccount(
      String? token, String channelName, String userAccount,
      [ChannelMediaOptions? options]);

  ///
  /// Gets the user information by passing in the user account.
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers the userInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// Param [userAccount] The user account.
  ///
  /// **return** The UserInfo object that identifies the user information. Not null: Success.
  ///  Null: Failure.
  ///
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  ///
  /// Gets the user information by passing in the user ID.
  /// After a remote user joins the channel, the SDK gets the UID and user account of the remote user, caches them in a mapping table object, and triggers the userInfoUpdated callback on the local client. After receiving the callback, you can call this method to get the user account of the remote user from the UserInfo object by passing in the user ID.
  ///
  /// Param [uid]
  ///
  /// **return** The UserInfo object that identifies the user information. Not null: Success.
  ///  Null: Failure.
  ///
  Future<UserInfo> getUserInfoByUid(int uid);

  ///
  /// Enables the audio module.
  /// The audio mode is enabled by default. This method enables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.
  ///  This method enables the audio module and takes some time to take effect. Agora recommends using the following API methods to control the audio module separately:
  ///  enableLocalAudio : Whether to enable the microphone to create the local audio stream.
  ///  muteLocalAudioStream : Whether to publish the local audio stream.
  ///  muteRemoteAudioStream : Whether to subscribe and play the remote audio stream.
  ///  muteAllRemoteAudioStreams : Whether to subscribe to and play all remote audio streams.
  ///
  Future<void> enableAudio();

  ///
  /// Disables the audio module.
  /// This method disables the internal engine and can be called anytime after initialization. It is still valid after one leaves channel.
  ///  This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the audio modules separately:
  ///  enableLocalAudio : Whether to enable the microphone to create the local audio stream.
  ///  muteLocalAudioStream : Whether to publish the local audio stream.
  ///  muteRemoteAudioStream : Whether to subscribe and play the remote audio stream.
  ///  muteAllRemoteAudioStreams : Whether to subscribe to and play all remote audio streams.
  ///
  Future<void> disableAudio();

  ///
  /// Sets the audio profile and audio scenario.
  /// You can call this method either before or after joining a channel.
  ///  Ensure that you call this method before joining a channel.
  ///  In scenarios requiring high-quality audio, such as online music tutoring, Agora recommends you set profile as MusicHighQuality (4), and scenario as GameStreaming (3) or (6).
  ///
  /// Param [profile] The audio profile, including the sampling rate, bitrate, encoding mode, and the number of channels. See AudioProfile .
  ///
  ///
  /// Param [scenario] The audio scenario. See AudioScenario . Under different audio scenarios, the device uses different volume types.
  ///
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario);

  ///
  /// Adjusts the capturing signal volume.
  /// You can call this method either before or after joining a channel.
  ///
  /// Param [volume] Integer only. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  ///
  Future<void> adjustRecordingSignalVolume(int volume);

  ///
  /// Adjusts the playback signal volume of a specified remote user.
  /// You can call this method to adjust the playback volume of a specified remote user. To adjust the playback volume of different remote users, call the method as many times, once for each remote user. Call this method after joining a channel.
  ///  The playback volume here refers to the mixed volume of a specified remote user.
  ///
  /// Param [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  ///
  /// Enables loopback audio capturing.
  /// If you enable loopback audio capturing, the output of the sound card is mixed into the audio stream sent to the other end. This method applies to macOS and Windows only.
  ///  macOS does not support loopback capturing of the default sound card. To use this method, use a virtual sound card and pass its name
  ///  to the SDK as the value of thedeviceName parameter. Based on tests, Agora recommends using soundflower
  ///  as the virtual sound card.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [enabled] Sets whether to enable loopback capturing.
  ///  true: Enable loopback audio capturing.
  ///  false: (Default) Disable loopback capturing.
  ///
  ///
  /// Param [deviceName] The device name of the sound card. The default value is null (the default sound card). If you use a virtual sound card like "Soundflower", set this parameter as the name of the sound card, "Soundflower". The SDK will find the corresponding sound card and start capturing.
  ///
  Future<void> enableLoopbackRecording(bool enabled, {String? deviceName});

  ///
  /// Adjusts the playback signal volume of all remote users.
  /// This method adjusts the playback volume that is the mixed volume of all remote users.
  ///  As of v2.3.2, to mute the local audio, you need to call the adjustPlaybackSignalVolume and adjustAudioMixingPlayoutVolume methods at the same time, and set volume to 0.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [volume] Integer only. The value range is [0,400].
  ///  0: Mute.
  ///  100: (Default) The original volume.
  ///  400: Four times the original volume (amplifying the audio signals by four times).
  ///
  Future<void> adjustPlaybackSignalVolume(int volume);

  ///
  /// Enables/Disables the local audio capture.
  /// The audio function is enabled by default. This method disables or re-enables the local audio function to stop or restart local audio capturing.
  ///  This method does not affect receiving or playing the remote audio streams, and enableLocalAudio (false) applies to scenarios where the user wants to receive remote audio streams without sending any audio stream to other users in the channel.
  ///  Once the local audio function is disabled or re-enabled, the SDK triggers the localAudioStateChanged callback, which reports Stopped(0) or Recording(1).
  ///  This method is different from the muteLocalAudioStream method:
  ///  enableLocalVideo: Disables/Re-enables the local audio capturing and processing. If you disable or re-enable local audio capturing using the enableLocalAudio method, the local user might hear a pause in the remote audio playback.
  ///  muteLocalAudioStream: Sends/Stops sending the local audio streams. You can call this method either before or after joining a channel.
  ///
  /// Param [enabled] true: (Default) Re-enable the local audio function, that is, to start the local audio capturing device (for example, the microphone).
  ///  false: Disable the local audio function, that is, to stop local audio capturing.
  ///
  Future<void> enableLocalAudio(bool enabled);

  ///
  /// Stops or resumes publishing the local audio stream.
  /// A successful call of this method triggers the userMuteAudio callback on the remote client. This method does not affect any ongoing audio recording, because it does not disable the microphone.
  ///  You can call this method either before or after joining a channel. If you call the setChannelProfile method after this method, the SDK resets whether or not to stop publishing the local audio according to the channel profile and user role. Therefore, Agora recommends calling this method after the setChannelProfile method.
  ///
  /// Param [muted] Whether to stop publishing the local audio stream. true: Stop publishing the local audio stream.
  ///  false: (Default) Resumes publishing the local audio stream.
  ///
  Future<void> muteLocalAudioStream(bool muted);

  ///
  /// Stops or resumes subscribing to the audio stream of a specified user.
  /// Call this method after joining a channel.
  ///  See recommended settings in Set the Subscribing State.
  ///
  /// Param [uid] The user ID of the specified user.
  ///
  /// Param [muted] Whether to stop subscribing to the audio stream of the specified user. true: Stop subscribing to the audio stream of the specified user.
  ///  false: (Default) Subscribe to the audio stream of the specified user.
  ///
  Future<void> muteRemoteAudioStream(int uid, bool muted);

  ///
  /// Stops or resumes subscribing to the audio streams of all remote users.
  /// As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the audio streams of all remote users, including all subsequent users. Call this method after joining a channel.
  ///
  /// Param [muted] Whether to subscribe to the audio streams of all remote users:
  ///  true: Do not subscribe to the audio streams of all remote users.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  Future<void> muteAllRemoteAudioStreams(bool muted);

  ///
  /// Stops or resumes subscribing to the audio streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users. If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following:
  ///  To resume subscribing to the audio stream of a specified user, call muteRemoteAudioStream (false), and specify the user ID.
  ///  To resume subscribing to the audio streams of multiple remote users, call muteRemoteAudioStream (false)multiple times.
  ///
  /// Param [muted] Whether to stop subscribing to the audio streams of all remote users by default.
  ///  true: Stop subscribing to the audio streams of all remote users by default.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  @Deprecated('')
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);

  ///
  /// Enables the reporting of users' volume indication.
  /// This method enables the SDK to regularly report the volume information of the local user who sends a stream and remote users (up to three) whose instantaneous volumes are the highest to the app. Once you call this method and users send streams in the channel, the SDK triggers the audioVolumeIndication callback at the time interval set in this method.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [interval] Sets the time interval between two consecutive volume indications:
  ///  ≤ 0: Disables the volume indication.
  ///  > 0: Time interval (ms) between two consecutive volume indications. We recommend a setting greater than 200 ms. Do not set this parameter to less than 10 milliseconds, otherwise the audioVolumeIndication callback will not be triggered.
  ///
  ///
  /// Param [smooth] The smoothing factor sets the sensitivity of the audio volume indicator. The value ranges between 0 and 10. The recommended value is 3. The greater the value, the more sensitive the indicator.
  ///
  /// Param [report_vad] true: Enable the voice activity detection of the local user. Once it is enabled, the vad parameter of the audioVolumeIndication callback reports the voice activity status of the local user.
  ///  false: (Default) Disable the voice activity detection of the local user. Once it is disabled, the vad parameter of the audioVolumeIndication callback does not report the voice activity status of the local user, except for the scenario where the engine automatically detects the voice activity of the local user.
  ///
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad);

  ///
  /// Enables the video module.
  /// Call this method either before joining a channel or during a call. If this method is called before joining a channel, the call starts in the video mode. Call disableVideo to disable the video mode.A successful call of this method triggers the remoteVideoStateChanged callback on the remote client. This method enables the internal engine and is valid after leaving the channel.
  ///  This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  ///  enableLocalVideo : Whether to enable the camera to create the local video stream.
  ///  muteLocalVideoStream : Whether to publish the local video stream.
  ///  muteRemoteVideoStream : Whether to subscribe to and play the remote video stream.
  ///  muteAllRemoteVideoStreams : Whether to subscribe to and play all remote video streams.
  ///
  Future<void> enableVideo();

  ///
  /// Disables the video module.
  /// This method disables video. You can call this method either before or after joining a channel. If you call it before joining a channel, an audio call starts when you join the channel. If you call it after joining a channel, a video call switches to an audio call. Call enableVideo to enable video.A successful call of this method triggers the userEnableVideo (false) callback on the remote client. This method affects the internal engine and can be called after leaving the channel.
  ///  This method resets the internal engine and takes some time to take effect. Agora recommends using the following API methods to control the video engine modules separately:
  ///  enableLocalVideo : Whether to enable the camera to create the local video stream.
  ///  muteLocalVideoStream : Whether to publish the local video stream.
  ///  muteRemoteVideoStream : Whether to subscribe to and play the remote video stream.
  ///  muteAllRemoteVideoStreams : Whether to subscribe to and play all remote video streams.
  ///
  Future<void> disableVideo();

  ///
  /// Sets the video encoder configuration.
  /// Sets the encoder configuration for the local video.
  ///  You can call this method either before or after joining a channel. If you don't need to set the video encoder configuration after joining a channel,
  ///  Agora recommends you calling this method before the enableVideo method to reduce the rendering time of the first video frame.
  ///
  /// Param [config] Video profile. See VideoEncoderConfiguration .
  ///
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  ///
  /// Enables the local video preview.
  /// This method starts the local video preview before joining the channel. Before calling this method, ensure that you do the following: Call enableVideo to enable the video.
  ///  The local preview enables the mirror mode by default.
  ///  After the local video preview is enabled, if you call leaveChannel to exit the channel, the local preview remains until you call stopPreview to disable it.
  ///
  Future<void> startPreview();

  ///
  /// Stops the local video preview.
  ///
  ///
  Future<void> stopPreview();

  ///
  /// Enables/Disables the local video capture.
  /// This method disables or re-enables the local video capturer, and does not affect receiving the remote video stream.
  ///  After calling enableVideo , the local video capturer is enabled by default. You can call enableLocalVideo (false) to disable the local video capturer. If you want to re-enable the local video, call enableLocalVideo(true).
  ///  After the local video capturer is successfully disabled or re-enabled, the SDK triggers the callback on the remote client remoteVideoStateChanged . You can call this method either before or after joining a channel.
  ///  This method enables the internal engine and is valid after .
  ///
  /// Param [enabled] Whether to enable the local video capture. true: (Default) Enable the local video capture.
  ///  false: Disables the local video capture. Once the local video is disabled, the remote users can no longer receive the video stream of this user, while this user can still receive the video streams of the other remote users. When set to false, this method does not require a local camera.
  ///
  Future<void> enableLocalVideo(bool enabled);

  ///
  /// Stops or resumes publishing the local video stream.
  /// A successful call of this method triggers the userMuteVideo callback on the remote client. This method executes faster than the enableLocalVideo (false) method, which controls the sending of the local video stream.
  ///  This method does not affect any ongoing video recording, because it does not disable the camera.
  ///  You can call this method either before or after joining a channel. If you call setChannelProfile after this method, the SDK resets whether or not to stop publishing the local video according to the channel profile and user role. Therefore, Agora recommends calling this method after the setChannelProfile method.
  ///
  /// Param [muted] Whether to stop publishing the local video stream.
  ///  true: Stop publishing the local video stream.
  ///  false: (Default) Publish the local video stream.
  ///
  Future<void> muteLocalVideoStream(bool muted);

  ///
  /// Stops or resumes subscribing to the video stream of a specified user.
  /// Call this method after joining a channel.
  ///  See recommended settings in Set the Subscribing State.
  ///
  /// Param [userId] The ID of the specified user.
  ///
  /// Param [muted] Whether to stop subscribing to the video stream of the specified user.
  ///  true: Stop subscribing to the video streams of the specified user.
  ///  false: (Default) Subscribe to the video stream of the specified user.
  ///
  Future<void> muteRemoteVideoStream(int uid, bool muted);

  ///
  /// Stops or resumes subscribing to the video streams of all remote users.
  /// As of v3.3.0, after successfully calling this method, the local user stops or resumes subscribing to the video streams of all remote users, including all subsequent users. Call this method after joining a channel.
  ///  See recommended settings in Set the Subscribing State.
  ///
  /// Param [muted] Whether to stop subscribing to the video streams of all remote users.
  ///  true: Stop subscribing to the video streams of all remote users.
  ///  false: (Default) Subscribe to the audio streams of all remote users by default.
  ///
  Future<void> muteAllRemoteVideoStreams(bool muted);

  ///
  /// Stops or resumes subscribing to the video streams of all remote users by default.
  /// Call this method after joining a channel. After successfully calling this method, the local user stops or resumes subscribing to the audio streams of all subsequent users.
  ///  If you need to resume subscribing to the audio streams of remote users in the channel after calling this method, do the following:To resume subscribing to the audio stream of a specified user, call muteRemoteVideoStream (false), and specify the user ID.
  ///  To resume subscribing to the audio streams of multiple remote users, call muteRemoteVideoStream(false)multiple times.
  ///
  /// Param [muted] Whether to stop subscribing to the audio streams of all remote users by default.
  ///  true: Stop subscribing to the audio streams of all remote users by default.
  ///  false: (Default) Resume subscribing to the audio streams of all remote users by default.
  ///
  @Deprecated('')
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);

  ///
  /// Sets the image enhancement options.
  /// Enables or disables image enhancement, and sets the options.
  ///  Enabling the image enhancement function involves a series of method calls. The calling sequence is as follows:
  ///  Call (agora, beauty, true) to enable the extension.
  ///  Call enableVideo to enable the video module.
  ///  Call this method to enable the image enhancement function.
  ///  Call this method after enableVideo .
  ///
  /// Param [enabled] Whether to enable the image enhancement function:
  ///  true: Enable the image enhancement function.
  ///  false: (Default) Disable the image enhancement function.
  ///
  ///
  /// Param [options] The image enhancement options. See BeautyOptions .
  ///
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options);

  ///
  /// Enables/Disables the super-resolution algorithm for a remote user's video stream.
  /// This feature effectively boosts the resolution of a remote user's video seen by the local user. If the original resolution of a remote user's video is a × b, the local user's device can render the remote video at a resolution of 2a × 2b
  ///  after you enable this feature.
  ///  After you call this method, the SDK triggers the userSuperResolutionEnabled callback to report whether you have successfully enabled super resolution.
  ///  The super resolution feature requires extra system resources. To balance the visual experience and system usage, the SDK poses the following restrictions: This feature can only be enabled for a single remote user.
  ///  On Android, the original resolution of the remote video must not exceed 640 × 360 pixels. On iOS, the original resolution of the remote video must not exceed 640 × 480 pixels. If you exceed these limitations, the SDK triggers the warning callback and returns the corresponding warning codes:
  ///  SuperResolutionStreamOverLimitation: 1610. The origin resolution of the remote video is beyond the range where the super resolution can be applied.
  ///  SuperResolutionUserCountOverLimitation: 1611. Super resolution is already being used on another remote user's video.
  ///  SuperResolutionDeviceNotSupported: 1612. The device does not support using super resolution.
  ///  This method is for Android and iOS only.
  ///  Before calling this method, ensure that you have integrated the following dynamic libraries:
  ///  Android: libagora_super_resolution_extension.so
  ///  iOS: AgoraSuperResolutionExtension.xcframework Because this method has certain system performance requirements, Agora recommends that you use the following devices or better:
  ///  Android:
  ///  VIVO: V1821A, NEX S, 1914A, 1916A, 1962A, 1824BA, X60, X60 Pro
  ///  OPPO: PCCM00, Find X3
  ///  OnePlus: A6000
  ///  Xiaomi: Mi 8, Mi 9, Mi 10, Mi 11, MIX3, Redmi K20 Pro
  ///  SAMSUNG: SM-G9600, SM-G9650, SM-N9600, SM-G9708, SM-G960U, SM-G9750, S20, S21
  ///  HUAWEI: SEA-AL00, ELE-AL00, VOG-AL00, YAL-AL10, HMA-AL00, EVR-AN00, nova 4, nova 5 Pro, nova 6 5G, nova 7 5G, Mate 30, Mate 30 Pro, Mate 40, Mate 40 Pro, P40, P40 Pro, Huawei M6, MatePad 10.8 iOS:
  ///  iPhone XR
  ///  iPhone XS
  ///  iPhone XS Max
  ///  iPhone 11
  ///  iPhone 11 Pro
  ///  iPhone 11 Pro Max
  ///  iPhone 12
  ///  iPhone 12 mini
  ///  iPhone 12 Pro
  ///  iPhone 12 Pro Max
  ///  iPhone 12 SE (2nd generation)
  ///  iPad Pro 11-inch (3rd generation)
  ///  iPad Pro 12.9-inch (3rd generation)
  ///  iPad Air 3 (3rd generation)
  ///  iPad Air 3 (4th generation)
  ///
  /// Param [userId] The ID of the remote user.
  ///
  /// Param [enable] Whether to enable super resolution for the remote user’s video:
  ///  true: Enable virtual background.
  ///  false: Do not enable virtual background.
  ///
  ///
  Future<void> enableRemoteSuperResolution(int userId, bool enable);

  ///
  /// Starts playing the music file.
  /// This method mixes the specified local or online audio file with the audio from the microphone, or replaces the microphone's audio with the specified local or remote audio file. A successful method call triggers the audioMixingStateChanged (PLAY) callback. When the audio mixing file playback finishes, the SDK triggers the audioMixingStateChanged (STOPPED) callback on the local client. Call this method after joining a channel. If you need to call startAudioMixing multiple times, ensure that the time interval between calling this method is more than 500 ms.
  ///  If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns WARN_AUDIO_MIXING_OPEN_ERROR (701).
  ///
  /// Param [filePath] The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: Android: /sdcard/emulated/0/audio.mp4, iOS: /var/mobile/Containers/Data/audio.mp4. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See supported audio formats.
  ///
  /// Param [loopcount] Whether to only play music files on the local client:
  ///  true: Only play music files on the local client so that only the local user can hear the music.
  ///  false: Publish music files to remote clients so that both the local user and remote users can hear the music.
  ///
  ///
  /// Param [replace] Whether to replace the audio captured by the microphone with a music file:
  ///  true: Replace the audio captured by the microphone with a music file. Users can only hear the music.
  ///  false: Do not replace the audio captured by the microphone with a music file. Users can hear both music and audio captured by the microphone.
  ///
  ///
  /// Param [cycle] The number of times the music file plays.
  ///  ≥ 0: The number of playback times. For example, 0 means that the SDK does not play the music file while 1 means that the SDK plays once.
  ///  -1: Play the music effect in an infinite loop.
  ///
  ///
  /// Param [startPos] The playback position (ms) of the music file.
  ///
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle,
      [int? startPos]);

  ///
  /// Stops playing and mixing the music file.
  /// This method stops the audio mixing. Call this method when you are in a channel.
  ///
  Future<void> stopAudioMixing();

  ///
  /// Pauses playing and mixing the music file.
  /// Call this method when you are in a channel.
  ///
  Future<void> pauseAudioMixing();

  ///
  /// Resumes playing and mixing the music file.
  /// This method resumes playing and mixing the music file. Call this method when you are in a channel.
  ///
  Future<void> resumeAudioMixing();

  ///
  /// Adjusts the volume during audio mixing.
  /// This method adjusts the audio mixing volume on both the local client and remote clients. Call this method after startAudioMixing .
  ///  Calling this method does not affect the volume of audio effect file playback invoked by the playEffect method.
  ///
  /// Param [volume] Audio mixing volume. The value ranges between 0 and 100. The default value is 100, the original volume.
  ///
  Future<void> adjustAudioMixingVolume(int volume);

  ///
  /// Adjusts the volume of audio mixing for local playback.
  /// You need to call this method after calling startAudioMixing and receiving the audioMixingStateChanged(PLAY) callback.
  ///
  /// Param [volume] Audio mixing volume for local playback. The value range is [0,100]. The default value is 100, the original volume.
  ///
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  ///
  /// Adjusts the volume of audio mixing for publishing.
  /// This method adjusts the volume of audio mixing for publishing (sending to other users).
  ///  You need to call this method after calling startAudioMixing and receiving the audioMixingStateChanged(PLAY) callback.
  ///
  /// Param [volume] Audio mixing volume. The value range is [0,100]. The default value is 100, the original volume.
  ///
  Future<void> adjustAudioMixingPublishVolume(int volume);

  ///
  /// Retrieves the audio mixing volume for local playback.
  /// This method helps troubleshoot audio volume‑related issues.
  ///  You need to call this method after calling startAudioMixing and receiving the audioMixingStateChanged(PLAY) callback.
  ///
  /// **return** ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
  ///  < 0: Failure.
  ///
  Future<int?> getAudioMixingPlayoutVolume();

  ///
  /// Retrieves the audio mixing volume for publishing.
  /// This method helps troubleshoot audio volume‑related issues.
  ///  You need to call this method after calling startAudioMixing and receiving the audioMixingStateChanged(PLAY) callback.
  ///
  /// **return** ≥ 0: The audio mixing volume, if this method call succeeds. The value range is [0,100].
  ///  < 0: Failure.
  ///
  Future<int?> getAudioMixingPublishVolume();

  ///
  /// Retrieves the duration (ms) of the music file.
  /// Call this method after joining a channel.
  ///
  /// Param [filePath] The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: Android: /sdcard/emulated/0/audio.mp4, iOS: /var/mobile/Containers/Data/audio.mp4. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See supported audio formats.
  ///
  /// **return** ≥ 0: A successful method call. Returns the total duration (ms) of the specified music file.
  ///  < 0: Failure.
  ///
  @Deprecated(
      'This method is deprecated as of v4.1.0. Use getAudioFileInfo instead.')
  Future<int?> getAudioMixingDuration([String? filePath]);

  ///
  /// Gets the information of a specified audio file.
  /// After calling this method successfully, the SDK triggers the requestAudioFileInfo callback to report the information of an audio file, such as audio duration. You can call this method multiple times to get the information of multiple audio files. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  ///  Call this method after joining a channel.
  ///
  /// Param [filePath] The file path: Android: The file path, including the filename extensions. To access an online file, Agora
  ///  supports using a URL address; to access a local file, Agora supports using a URI address, an absolute path, or a path that starts
  ///  with /assets/. You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends
  ///  using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%3A14441.
  ///  Windows: The absolute path or URL address (including the filename extensions) of the audio file.
  ///  For example: C:\music\audio.mp4.
  ///  iOS or macOS: The absolute path or URL address (including the filename extensions) of the audio file. For example: /var/mobile/Containers/Data/audio.mp4.
  ///
  ///
  /// **return** 0: Success.
  ///  < 0: Failure.
  ///
  Future<int?> getAudioFileInfo(String filePath);

  ///
  /// Retrieves the playback position (ms) of the music file.
  /// Retrieves the playback position (ms) of the audio.
  ///  You need to call this method after calling startAudioMixing and receiving the audioMixingStateChanged(PLAY) callback.
  ///
  /// **return** ≥ 0: The current playback position of the audio mixing, if this method call succeeds.
  ///  < 0: Failure.
  ///
  Future<int?> getAudioMixingCurrentPosition();

  ///
  /// Sets the audio mixing position.
  /// Call this method to set the playback position of the music file to a different starting position (the default plays from the beginning).
  ///  You need to call this method after calling startAudioMixing and receiving the audioMixingStateChanged(PLAY) callback.
  ///
  /// Param [pos] Integer. The playback position (ms).
  ///
  Future<void> setAudioMixingPosition(int pos);

  ///
  /// Sets the pitch of the local music file.
  /// When a local music file is mixed with a local human voice, call this method to set the pitch of the local music file only.
  ///  You need to call this method after calling startAudioMixing and receiving the audioMixingStateChanged(Playing) callback.
  ///
  /// Param [pitch] Sets the pitch of the local music file by the chromatic scale. The default value is 0, which means keeping the original pitch. The value ranges from -12 to 12, and the pitch value between consecutive values is a chromatic value. The greater the absolute value of this parameter, the higher or lower the pitch of the local music file.
  ///
  Future<void> setAudioMixingPitch(int pitch);

  ///
  /// Sets the channel mode of the current music file.
  /// Call this method after calling startAudioMixing and receiving the audioMixingStateChanged (Playing) callback.
  ///
  /// Param [speed] The playback speed. Agora recommends that you limit this value to between 50 and 400, defined as follows:
  ///  50: Half the original speed.
  ///  100: The original speed.
  ///  400: 4 times the original speed.
  ///
  ///
  Future<void> setAudioMixingPlaybackSpeed(int speed);

  ///
  /// Gets the audio track index of the current music file.
  /// For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  ///  This method is for Android, iOS, and Windows only.
  ///  Call this method after calling startAudioMixing and receiving the audioMixingStateChanged (AUDIO_MIXING_STATE_PLAYING)
  ///  callback.
  ///
  /// **return** ≥ 0: The audio track index of the current music file, if this method call
  ///  succeeds.
  ///  < 0: Failure.
  ///
  Future<int?> getAudioTrackCount();

  ///
  /// Selects the audio track used during playback.
  /// If the media file has multiple audio tracks, you can call this method to select the audio track used during playback.
  ///
  /// Param [index] The index of the audio track.
  ///
  Future<void> selectAudioTrack(int index);

  ///
  /// Sets the channel mode of the current audio file.
  /// In a stereo music file, the left and right channels can store different audio data. According to your needs, you can set the channel mode to original mode, left channel mode, right channel mode, or mixed channel mode. For example, in the KTV scenario, the left channel of the music file stores the musical accompaniment, and the right channel stores the singing voice. If you only need to listen to the accompaniment, call this method to set the channel mode of the music file to left channel mode; if you need to listen to the accompaniment and the singing voice at the same time, call this method to set the channel mode to mixed channel mode. Call this method after calling startAudioMixing and receiving the audioMixingStateChanged (Playing) callback.
  ///  This method only applies to stereo audio files.
  ///
  /// Param [mode] The channel mode.
  ///
  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode);

  ///
  /// Retrieves the volume of the audio effects.
  /// The volume is an integer ranging from 0 to 100. The default value is 100, the original volume.
  ///  Call this method after playEffect .
  ///
  /// **return** Volume of the audio effects, if this method call succeeds.
  ///  < 0: Failure.
  ///
  Future<double?> getEffectsVolume();

  ///
  /// Sets the volume of the audio effects.
  /// Call this method after playEffect .
  ///
  /// Param [volume] The playback volume. The value ranges from 0 to 100. The default value is 100, which represents the original volume.
  ///
  Future<void> setEffectsVolume(int volume);

  ///
  /// Sets the volume of a specified audio effect.
  /// Call this method after playEffect .
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// Param [volume] The playback volume. The value ranges from 0 to 100. The default value is 100, which represents the original volume.
  ///
  Future<void> setVolumeOfEffect(int soundId, int volume);

  ///
  /// Plays the specified local or online audio effect file.
  /// To play multiple audio effect files at the same time, call this method multiple times with different soundId and filePath. For the best user experience, Agora recommends playing no more than three audio effect files at the same time. After the playback of an audio effect file completes, the SDK triggers the audioEffectFinished callback.Call this method after joining a channel.
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.If you have preloaded an audio effect into memory by calling preloadEffect , ensure that this parameter is set to the same value as soundId in preloadEffect.
  ///
  ///
  /// Param [filePath] The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: Android: /sdcard/emulated/0/audio.mp4, iOS: /var/mobile/Containers/Data/audio.mp4. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See supported audio formats.
  ///  If you have preloaded an audio effect into memory by calling preloadEffect , ensure that this parameter is set to the same value as filePath in preloadEffect.
  ///
  ///
  /// Param [loopCount] The number of times the audio effect loops:
  ///  ≥ 0: The number of playback times. For example, 1 means loop one time, which means play the audio effect two times in total.
  ///  -1: Play the music effect in an infinite loop.
  ///
  /// Param [pitch] The pitch of the audio effect. The value range is 0.5 to 2.0. The default value is 1.0, which means the original pitch. The lower the value, the lower the pitch.
  ///
  /// Param [pan] The spatial position of the audio effect. The value range is 1 to10000.
  ///  -1.0: The audio effect displays to the left.
  ///  0.0: The audio effect displays ahead.
  ///  1.0: The audio effect displays to the right.
  ///
  /// Param [gain] The volume of the audio effect. The value range is 1 to10000. The default value is 100.0, which means the original volume. The smaller the value, the lower the volume.
  ///
  /// Param [publish] Whether to publish the audio effect to the remote users.
  ///  true: Publish the audio effect to the remote users. Both the local user and remote users can hear the audio effect.
  ///  false: Do not publish the audio effect to the remote users. Only the local user can hear the audio effect.
  ///
  /// Param [startPos] The playback position (ms) of the audio effect file.
  ///
  ///
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, int gain, bool publish,
      [int? startPos]);

  ///
  /// Sets the playback position of an audio effect file.
  /// After a successful setting, the local audio effect file starts playing at the specified position.
  ///  Call this method after playEffect.
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// Param [pos] The playback position (ms) of the audio effect file.
  ///
  Future<void> setEffectPosition(int soundId, int pos);

  ///
  /// Retrieves the duration of the audio effect file.
  /// Call this method after joining a channel.
  ///
  /// Param [filePath] The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: Android: /sdcard/emulated/0/audio.mp4, iOS: /var/mobile/Containers/Data/audio.mp4. Supported audio formats include MP3, AAC, M4A, MP4, WAV, and 3GP. See supported audio formats.
  ///
  ///
  /// **return** ≥ 0: A successful method call. Returns the total duration (ms) of the specified audio effect file.
  ///  < 0: Failure.
  ///
  Future<int?> getEffectDuration(String filePath);

  ///
  /// Retrieves the playback position of the audio effect file.
  /// Call this method after playEffect.
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// **return** ≥ 0: A successful method call. Returns the playback position (ms) of the specified audio effect file.
  ///  < 0: Failure.
  ///
  Future<int?> getEffectCurrentPosition(int soundId);

  ///
  /// Stops playing a specified audio effect.
  ///
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  Future<void> stopEffect(int soundId);

  ///
  /// Stops playing all audio effects.
  ///
  ///
  Future<void> stopAllEffects();

  ///
  /// Preloads a specified audio effect file into the memory.
  /// To ensure smooth communication, limit the size of the audio effect file. We recommend using this method to preload the audio effect before calling joinChannel. This method does not support online audio effect files.
  ///  For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  /// Param [filePath] File path:
  ///  Android: The file path, which needs to be accurate to the file name and suffix. Agora supports using a URI address, an absolute path, or a path that starts with /assets/.
  ///  You might encounter permission issues if you use an absolute path to access a local file, so Agora recommends using a URI address instead. For example: content://com.android.providers.media.documents/document/audio%203A14441
  ///  Windows: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: C:\music\audio.mp4.
  ///  iOS or macOS: The absolute path or URL address (including the suffixes of the filename) of the audio effect file. For example: /var/mobile/Containers/Data/audio.mp4.
  ///
  ///
  Future<void> preloadEffect(int soundId, String filePath);

  ///
  /// Releases a specified preloaded audio effect from the memory.
  ///
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  Future<void> unloadEffect(int soundId);

  ///
  /// Pauses a specified audio effect.
  ///
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  Future<void> pauseEffect(int soundId);

  ///
  /// Pauses all audio effects.
  ///
  ///
  Future<void> pauseAllEffects();

  ///
  /// Resumes playing a specified audio effect.
  ///
  ///
  /// Param [soundId] The audio effect ID. The ID of each audio effect file is unique.
  ///
  Future<void> resumeEffect(int soundId);

  ///
  /// Resumes playing all audio effects.
  ///
  ///
  Future<void> resumeAllEffects();

  ///
  /// Sets the operational permission of the SDK on the audio session.
  /// The SDK and the app can both configure the audio session by default. If you need to only use the app to configure the audio session, this method restricts the operational permission of the SDK on the audio session.
  ///  You can call this method either before or after joining a channel. Once you call this method to restrict the operational permission of the SDK on the audio session, the restriction takes effect when the SDK needs to change the audio session. This method is for iOS only.
  ///  This method does not restrict the operational permission of the app on the audio session.
  ///
  /// Param [restriction] The operational permission of the SDK on the audio session. See AudioSessionOperationRestriction . This parameter is in bit mask format, and each bit corresponds to a permission.
  ///
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);

  ///
  /// Sets the local voice changer option.
  /// Deprecated:
  ///  Deprecated from v3.2.0. Use the following methods instead:
  ///  setAudioEffectPreset : Audio effects.
  ///  setVoiceBeautifierPreset : Voice beautifier effects.
  ///  setVoiceConversionPreset : Voice conversion effects. This method can be used to set the local voice effect for users in a COMMUNICATION channel or hosts in a LIVE_BROADCASTING channel. After successfully calling this method, all users in the channel can hear the voice with reverberation.
  ///  VOICE_CHANGER_XXX: Changes the local voice to an old man, a little boy, or the Hulk. Applies to the voice talk scenario.
  ///  VOICE_BEAUTY_XXX: Beautifies the local voice by making it sound more vigorous, resounding, or adding spacial resonance. Applies to the voice talk and singing scenario.
  ///  GENERAL_VOICE_BEAUTY_XXX: Adds gender-based beautification effect to the local voice. Applies to the voice talk scenario. For a male voice: Adds magnetism to the voice. For a male voice: Adds magnetism to the voice. For a female voice: Adds freshness or vitality to the voice. To achieve better voice effect quality, Agora recommends setting the setAudioProfile profile parameter in asMusicHighQuality (4) orMusicHighQualityStereo (5).
  ///  This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
  ///  Do not use this method with setLocalVoiceReverbPreset , because the method called later overrides the one called earlier. For detailed considerations, see the advanced guide Set the Voice Effect.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [voiceChanger] The local voice changer option. The default value is Off , which means the original voice.  The gender-based beatification effect works best only when assigned a proper gender. Use GENERAL_BEAUTY_VOICE_MALE_MAGNETIC for male and use GENERAL_BEAUTY_VOICE_FEMALE_FRESH and GENERAL_BEAUTY_VOICE_FEMALE_VITALITY for female. Failure to do so can lead to voice distortion.
  ///
  ///
  @Deprecated('')
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger);

  ///
  /// Sets the local voice reverberation option, including the virtual stereo.
  /// This method sets the local voice reverberation for users in a COMMUNICATION channel or hosts in a LIVE_BROADCASTING channel. After successfully calling this method, all users in the channel can hear the voice with reverberation. When using the enumeration value prefixed with AUDIO_REVERB_FX, ensure that you set the profile parameter in setAudioProfile toMusicHighQuality(4) or MusicHighQualityStereo(5) before calling this method. Otherwise, the method setting is invalid.
  ///  When calling the VIRTUAL_STEREO method, Agora recommends setting the profile parameter in setAudioProfile as MusicHighQualityStereo(5).
  ///  This method works best with the human voice, and Agora does not recommend using it for audio containing music and a human voice.
  ///  Do not use this method with setLocalVoiceChanger , because the method called later overrides the one called earlier. For detailed considerations, see the advanced guide Set the Voice Effect.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [preset] The local voice reverberation option. The default value is Off, which means the original voice.  To achieve better voice effects, Agora recommends the enumeration whose name begins with AUDIO_REVERB_FX.
  ///
  @Deprecated('')
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset);

  ///
  /// Changes the voice pitch of the local speaker.
  /// You can call this method either before or after joining a channel.
  ///
  /// Param [pitch] The local voice pitch. The value range is [0.5,2.0]. The lower the value, the lower the pitch. The default value is 1 (no change to the pitch).
  ///
  Future<void> setLocalVoicePitch(double pitch);

  ///
  /// Sets the local voice equalization effect.
  /// You can call this method either before or after joining a channel.
  ///
  /// Param [bandFrequency] The band frequency. The value ranges between 0 and 9; representing the respective 10-band center frequencies of the voice effects, including 31, 62, 125, 250, 500, 1k, 2k, 4k, 8k, and 16k Hz.
  ///
  /// Param [bandGain] The gain of each band in dB. The value ranges between -15 and 15. The default value is 0.
  ///
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain);

  ///
  /// Sets the local voice reverberation.
  /// You can call this method either before or after joining a channel.
  ///
  /// Param [reverbKey] The reverberation key. Agora provides 5 reverberation keys: AudioReverbType .
  ///
  /// Param [value] The value of the reverberation key.
  ///
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value);

  ///
  /// Sets an SDK preset audio effect.
  /// Call this method to set an SDK preset audio effect for the local user who sends an audio stream. This audio effect does not change the gender characteristics of the original voice. After setting an audio effect, all users in the channel can hear the effect.
  ///  You can set different audio effects for different scenarios. See Set the Voice Beautifier and Audio Effects.
  ///  To get better audio effect quality, Agora recommends calling setAudioProfile and setting the scenario parameter as GameStreaming (3) before calling this method. You can call this method either before or after joining a channel.
  ///  Do not set the profile parameter in setAudioProfile to SpeechStandard (1), or the method does not take effect.
  ///  This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  ///  If you call setAudioEffectPreset and set enumerators except for RoomAcoustics3DVoice or PitchCorrection, do not call setAudioEffectParameters ; otherwise, setAudioEffectPreset is overridden.
  ///  After calling setAudioEffectPreset, Agora recommends not calling the following methods, because they can override setAudioEffectPreset:
  ///  setVoiceBeautifierPreset
  ///  setLocalVoiceReverbPreset
  ///  setLocalVoiceChanger
  ///  setLocalVoicePitch
  ///  setLocalVoiceEqualization
  ///  setLocalVoiceReverb
  ///  setVoiceBeautifierParameters
  ///  setVoiceConversionPreset
  ///
  /// Param [preset] The options for SDK preset audio effects. See AudioEffectPreset .
  ///
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  ///
  /// Sets a preset voice beautifier effect.
  /// Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting a voice beautifier effect, all users in the channel can hear the effect. You can set different voice beautifier effects for different scenarios.
  ///  For better voice effects, Agora recommends that you call setAudioProfile and set scenario to GameStreaming (3) and profile to MusicHighQuality (4) or MusicHighQualityStereo (5) before calling this method. You can call this method either before or after joining a channel.
  ///  Do not set the profile parameter in setAudioProfile to SpeechStandard(1), or the method does not take effect.
  ///  This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  ///  After calling setVoiceBeautifierPreset, Agora recommends not calling the following methods, because they can override setVoiceBeautifierPreset:
  ///  setAudioEffectPreset
  ///  setAudioEffectParameters
  ///  setLocalVoiceReverbPreset
  ///  setLocalVoiceChanger
  ///  setLocalVoicePitch
  ///  setLocalVoiceEqualization
  ///  setLocalVoiceReverb
  ///  setVoiceBeautifierParameters
  ///  setVoiceConversionPreset
  ///
  /// Param [preset] The preset voice beautifier effect options: VoiceBeautifierPreset .
  ///
  ///
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  ///
  /// Sets a preset voice beautifier effect.
  /// Call this method to set a preset voice beautifier effect for the local user who sends an audio stream. After setting an audio effect, all users in the channel can hear the effect. You can set different audio effects for different scenarios. See Set the Voice Beautifier and Audio Effects.
  ///  To achieve better audio effect quality, Agora recommends that you call setAudioProfile and set the profile to MusicHighQuality(4) or MusicHighQualityStereo(5) and scenario to GameStreaming(3) before calling this method. You can call this method either before or after joining a channel.
  ///  Do not setsetAudioProfile the profile parameter in to SpeechStandard(1)
  ///  This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  ///  After calling setVoiceConversionPreset, Agora recommends not calling the following methods, or the settings in setVoiceConversionPreset are overridden :
  ///  setAudioEffectPreset
  ///  setAudioEffectParameters
  ///  setVoiceBeautifierPreset
  ///  setVoiceBeautifierParameters
  ///  setLocalVoiceReverbPreset
  ///  setLocalVoiceChanger
  ///  setLocalVoicePitch
  ///  setLocalVoiceEqualization
  ///  setLocalVoiceReverb
  ///
  /// Param [preset] The options for the preset voice beautifier effects: VoiceConversionPreset .
  ///
  ///
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset);

  ///
  /// Sets parameters for SDK preset audio effects.
  /// Since
  ///  v3.2.0 Call this method to set the following parameters for the local user who sends an audio stream:
  ///  3D voice effect: Sets the cycle period of the 3D voice effect.
  ///  Pitch correction effect: Sets the basic mode and tonic pitch of the pitch correction effect. Different songs have different modes and tonic pitches. Agora recommends bounding this method with interface elements to enable users to adjust the pitch correction interactively. After setting the audio parameters, all users in the channel can hear the effect. You can call this method either before or after joining a channel.
  ///  To get better audio effect quality, Agora recommends calling and setting scenario in setAudioProfile as GameStreaming(3) before calling this method.
  ///  Do not set the profile parameter in setAudioProfile to SpeechStandard (1), or the method does not take effect.
  ///  This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  ///  After calling setAudioEffectParameters, Agora recommends not calling the following methods, or the settings in setAudioEffectParameters are overridden :
  ///  setAudioEffectPreset
  ///  setVoiceBeautifierPreset
  ///  setLocalVoiceReverbPreset
  ///  setLocalVoiceChanger
  ///  setLocalVoicePitch
  ///  setLocalVoiceEqualization
  ///  setLocalVoiceReverb
  ///  setVoiceBeautifierParameters
  ///  setVoiceConversionPreset
  ///
  /// Param [preset] The options for SDK preset audio effects:
  ///  RoomAcoustics3DVoice, 3D voice effect:
  ///  Call and set the profile parameter in setAudioProfile to MusicStandardStereo (3) or MusicHighQualityStereo(5) before setting this enumerator; otherwise, the enumerator setting does not take effect.
  ///  If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear the anticipated voice effect. PitchCorrection, Pitch correction effect: To achieve better audio effect quality, Agora recommends calling setAudioProfile and setting the profile parameter to MusicHighQuality (4) or MusicHighQualityStereo(5) before setting this enumerator.
  ///
  /// Param [param1] If you set preset to RoomAcoustics3DVoice , param1 sets the cycle period of the 3D voice effect. The value range is [1,60] and the unit is seconds. The default value is 10, indicating that the voice moves around you every 10 seconds.
  ///  If you set preset to PitchCorrection , param1 sets the basic mode of the pitch correction effect:
  /// 1: (Default) Natural major scale.
  /// 2: Natural minor scale.
  /// 3: Japanese pentatonic scale.
  ///
  ///
  /// Param [param2] If you set preset to RoomAcoustics3DVoice, you need to set param2 to 0.
  ///  If you set preset to PitchCorrection, param2 sets the tonic pitch of the pitch correction effect:
  /// 1: A
  /// 2: A#
  /// 3: B
  /// 4: (Default) C
  /// 5: C#
  /// 6: D
  /// 7: D#
  /// 8: E
  /// 9: F
  /// 10: F#
  /// 11: G
  /// 12: G#
  ///
  ///
  Future<void> setAudioEffectParameters(
      AudioEffectPreset preset, int param1, int param2);

  ///
  /// Sets parameters for the preset voice beautifier effects.
  /// Since
  ///  v3.3.0 Call this method to set a gender characteristic and a reverberation effect for the singing beautifier effect. This method sets parameters for the local user who sends an audio stream. After setting the audio parameters, all users in the channel can hear the effect.
  ///  For better voice effects, Agora recommends that you call setAudioProfile and setscenario to GameStreaming(3) and profile to MusicHighQuality(4) or MusicHighQualityStereo(5) before calling this method. You can call this method either before or after joining a channel.
  ///  Do not set the profile parameter of setAudioProfile to SpeechStandard(1). Otherwise, the method does not take effect.
  ///  This method works best with the human voice. Agora does not recommend using this method for audio containing music.
  ///  After calling setVoiceBeautifierParameters, Agora recommends not calling the following methods, because they can override settings in setVoiceBeautifierParameters:
  ///  setAudioEffectPreset
  ///  setAudioEffectParameters
  ///  setVoiceBeautifierPreset
  ///  setLocalVoiceReverbPreset
  ///  setLocalVoiceChanger
  ///  setLocalVoicePitch
  ///  setLocalVoiceEqualization
  ///  setLocalVoiceReverb
  ///  setVoiceConversionPreset
  ///
  /// Param [preset] The option for the preset audio effect:
  ///  SINGING_BEAUTIFIER: The singing beautifier effect.
  ///
  /// Param [param1] The gender characteristics options for the singing voice:
  ///  1: A male-sounding voice.
  ///  2: A female-sounding voice.
  ///
  /// Param [param2] The reverberation effect options for the singing voice:
  ///  1: The reverberation effect sounds like singing in a small room.
  ///  2: The reverberation effect sounds like singing in a large room.
  ///  3: The reverberation effect sounds like singing in a hall.
  ///
  Future<void> setVoiceBeautifierParameters(
      VoiceBeautifierPreset preset, int param1, int param2);

  ///
  /// Enables/Disables stereo panning for remote users.
  /// Ensure that you call this method before joining a channel to enable stereo panning for remote users so that the local user can track the position of a remote user by calling setRemoteVoicePosition.
  ///
  /// Param [enabled] Whether to enable stereo panning for remote users:
  ///  true: Enable stereo panning.
  ///  false: Disable stereo panning.
  ///
  Future<void> enableSoundPositionIndication(bool enabled);

  ///
  /// Sets the 2D position (the position on the horizontal plane) of the remote user's voice.
  /// This method sets the 2D position and volume of a remote user, so that the local user can easily hear and identify the remote user's position.
  ///  When the local user calls this method to set the voice position of a remote user, the voice difference between the left and right channels allows the local user to track the real-time position of the remote user, creating a sense of space. This method applies to massive multiplayer online games, such as Battle Royale games. For this method to work, enable stereo panning for remote users by calling the enableSoundPositionIndication method before joining a channel.
  ///  For the best voice positioning, Agora recommends using a wired headset.
  ///  Call this method after joining a channel.
  ///
  /// Param [uid] The user ID of the remote user.
  ///
  /// Param [pan] The voice position of the remote user. The value ranges from -1.0 to 1.0:
  ///  0.0: (Default) The remote voice comes from the front.
  ///  -1.0: The remote voice comes from the left.
  ///  1.0: The remote voice comes from the right.
  ///
  /// Param [gain] The volume of the remote user. The value ranges from 0.0 to 100.0. The default value is 100.0 (the original volume of the remote user). The smaller the value, the lower the volume.
  ///
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);

  ///
  /// Sets the transcoding configurations for media push.
  /// Deprecated: This method is deprecated. See Release Notes for an alternative solution.
  ///  This method sets the video layout and audio settings for media push. The SDK triggers the transcodingUpdated callback when you call this method to update the transcoding settings. This method takes effect only when you are a host in live interactive streaming.
  ///  Ensure that you enable the Media Push service before using this function. See Prerequisites in the advanced guide Media Push.
  ///  If you call this method to set the transcoding configuration for the first time, the SDK does not trigger the transcodingUpdated callback.
  ///  Call this method after joining a channel.
  ///  Agora only supports pushing media streams to the CDN in RTMPS protocol when you enable transcoding.
  ///
  /// Param [transcoding] The transcoding configurations for the media push. See LiveTranscoding for details.
  ///
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  ///
  ///  Publishes the local stream to a specified CDN live streaming URL.
  /// Deprecated: This method is deprecated. See Release Notes for an alternative solution.
  ///  After calling this method, you can push media streams in RTMP or RTMPS protocol to the CDN. The SDK triggers the rtmpStreamingStateChanged callback on the local client to report the state of adding a local stream to the CDN. Call this method after joining a channel.
  ///  Ensure that the media push function is enabled.
  ///  This method takes effect only when you are a host in live interactive streaming.
  ///  This method adds only one streaming URL to the CDN each time it is called. To push multiple URLs, call this method multiple times.
  ///  Agora only supports pushing media streams to the CDN in RTMPS protocol when you enable transcoding.
  ///
  /// Param [url] The media push URL in the RTMP or RTMPS format. The maximum length of this parameter is 1024 bytes. The URL address must not contain special characters, such as Chinese language characters.
  ///
  /// Param [transcodingEnabled] Whether to enable transcoding. Transcoding in a CDN live streaming converts the audio and video streams before pushing them to the CDN server. It applies to scenarios where a channel has multiple broadcasters and composite layout is needed.
  ///  true: Enable transcoding.
  ///  false: Disable transcoding. If you set this parameter as true, ensure that you call the setLiveTranscoding method before calling this method.
  ///
  ///
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  ///
  ///  Removes an RTMP or RTMPS stream from the CDN.
  /// Deprecated: This method is deprecated. See Release Notes for an alternative solution.
  ///  After a successful method call, the SDK triggers rtmpStreamingStateChanged on the local client to report the result of deleting the URL. Before calling this method, make sure that the media push function has been enabled.
  ///  This method takes effect only when you are a host in live interactive streaming.
  ///  Call this method after joining a channel.
  ///  This method removes only one media push URL each time it is called. To remove multiple URLs, call this method multiple times.
  ///
  /// Param [url] The media push URL to be removed. The maximum length of this parameter is 1024 bytes. The media push URL must not contain special characters, such as Chinese characters.
  ///
  Future<void> removePublishStreamUrl(String url);

  ///
  /// Starts relaying media streams across channels. This method can be used to implement scenarios such as co-host across channels.
  /// After a successful method call, the SDK triggers channelMediaRelayStateChanged the and channelMediaRelayEvent callbacks, and these callbacks return the state and events of the media stream relay.
  ///  If the channelMediaRelayStateChanged callback returns Running (2) and None (0), and the channelMediaRelayEvent callback returns SentToDestinationChannel (4), it means that the SDK starts relaying media streams between the source channel and the destination channel.
  ///  If the channelMediaRelayStateChanged callback returns Failure (3), an exception occurs during the media stream relay.
  ///  Call this method after joining the channel.
  ///  This method takes effect only when you are a host in a live streaming channel.
  ///  After a successful method call, if you want to call this method again, ensure that you call the stopChannelMediaRelay method to quit the current relay.
  ///  You need to before implementing this function.
  ///  We do not support string user accounts in this API.
  ///
  /// Param [channelMediaRelayConfiguration] The configuration of the media stream relay. See ChannelMediaRelayConfiguration for details.
  ///
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  ///
  /// Updates the channels for media stream relay.
  /// After the media relay starts, if you want to relay the media stream to more channels, or leave the current relay channel, you can call the updateChannelMediaRelay method.
  ///  After a successful method call, the SDK triggers the channelMediaRelayEvent callback with the UpdateDestinationChannel (7) state code.
  ///  Call this method after the startChannelMediaRelay method to update the destination channel.
  ///
  /// Param [channelMediaRelayConfiguration] The configuration of the media stream relay.
  ///
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  ///
  /// Stops the media stream relay. Once the relay stops, the host quits all the destination channels.
  /// After a successful method call, the SDK triggers the channelMediaRelayStateChanged callback. If the callback reports Idle (0) and None (0), the host successfully stops the relay.
  ///  If the method call fails, the SDK triggers the channelMediaRelayStateChanged callback with the ServerNoResponse (2) or ServerConnectionLost (8) status code. You can call the leaveChannel method to leave the channel, and the media stream relay automatically stops.
  ///
  Future<void> stopChannelMediaRelay();

  ///
  /// Pauses the media stream relay to all destination channels.
  /// After the cross-channel media stream relay starts, you can call this method to pause relaying media streams to all destination channels; after the pause, if you want to resume the relay, call resumeAllChannelMediaRelay .
  ///  After a successful method call, the SDK triggers the channelMediaRelayEvent callback to report whether the media stream relay is successfully paused.
  ///  Call this method after startChannelMediaRelay .
  ///
  Future<void> pauseAllChannelMediaRelay();

  ///
  /// Resumes the media stream relay to all destination channels.
  /// After calling the pauseAllChannelMediaRelay method, you can call this method to resume relaying media streams to all destination channels.
  ///  After a successful method call, the SDK triggers the channelMediaRelayEvent callback to report whether the media stream relay is successfully resumed.
  ///  Call this method after the pauseAllChannelMediaRelay method.
  ///
  Future<void> resumeAllChannelMediaRelay();

  ///
  /// Sets the default audio playback route.
  /// This method sets whether the received audio is routed to the earpiece or speakerphone by default before joining a channel. If a user does not call this method, the audio is routed to the earpiece by default.
  ///  The default settings for each profile:
  ///  For the communication profile:
  ///  In a voice call, the default audio route is the earpiece.
  ///  In a video call, the default audio route is the speakerphone. If a user calls the disableVideo , muteLocalVideoStream , or muteAllRemoteVideoStreams method, the default audio route switches back to the earpiece automatically. For the live broadcasting profile: Speakerphone. This method applies to Android and iOS only.
  ///  This method needs to be set before , otherwise, it will not take effect.
  ///
  /// Param [defaultToSpeaker] The default audio playback route.
  ///  true: The audio routing is speakerphone. If the device connects to the earpiece or Bluetooth, the audio cannot be routed to the speakerphone.
  ///  false: (Default) Route the audio to the earpiece. If a headset is plugged in, the audio is routed to the headset.
  ///
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker);

  ///
  /// Enables/Disables the audio playback route to the speakerphone.
  /// This method sets whether the audio is routed to the speakerphone or earpiece. After a successful method call, the SDK triggers the audioRouteChanged callback. Ensure that you have joined a channel before calling this method.
  ///
  /// Param [speakerOn] Whether the audio is routed to the speakerphone or earpiece.
  ///  true: Route the audio to the speakerphone. If the device connects to the earpiece or Bluetooth, the audio cannot be routed to the speakerphone.
  ///  false: Route the audio to the earpiece. If a headset is plugged in, the audio is routed to the headset.
  ///
  Future<void> setEnableSpeakerphone(bool speakerOn);

  ///
  /// Checks whether the speakerphone is enabled.
  /// This method is for Android and iOS only.
  ///
  /// **return** true: The speakerphone is enabled, and the audio plays from the speakerphone.
  ///  false: The speakerphone is not enabled, and the audio plays from devices other than the speakerphone. For example, the headset or earpiece.
  ///
  Future<bool?> isSpeakerphoneEnabled();

  ///
  /// Enables in-ear monitoring.
  /// This method enables or disables in-ear monitoring.
  ///  This method is for Android and iOS only.
  ///  Users must use wired earphones to hear their own voices.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [enabled] Enables in-ear monitoring.
  ///  true: Enables in-ear monitoring.
  ///  false: (Default) Disables in-ear monitoring.
  ///
  Future<void> enableInEarMonitoring(bool enabled);

  ///
  /// Sets the volume of the in-ear monitor.
  /// This method is for Android and iOS only.
  ///  Users must use wired earphones to hear their own voices.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [volume] The volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100.
  ///
  Future<void> setInEarMonitoringVolume(int volume);

  ///
  /// Enables/Disables dual-stream mode.
  /// You can call this method to enable or disable the dual-stream mode on the publisher side. Dual streams are a hybrid of a high-quality video stream and a low-quality video stream:
  ///  High-quality video stream: High bitrate, high resolution.
  ///  Low-quality video stream: Low bitrate, low resolution.
  ///  After you enable the dual-stream mode, you can call setRemoteVideoStreamType to choose to receive the high-quality video stream or low-quality video stream on the subscriber side. This method only takes effect for the video stream captured by the SDK through the camera. If you use video streams from the custom video source or captured by the SDK through the screen, you need to call or to enable dual-stream mode.
  ///  You can call this method either before or after joining a channel.
  ///
  /// Param [enabled] Whether to enable dual-stream mode.
  ///  true: Enable dual-stream mode.
  ///  false: Disable dual-stream mode.
  ///
  Future<void> enableDualStreamMode(bool enabled);

  ///
  ///  Sets the stream type of the remote video.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using enableDualStreamMode (false), the receiver can choose to receive either the high-quality video stream (the high resolution, and high bitrate video stream) or the low-quality video stream (the low resolution, and low bitrate video stream). The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate.
  ///  By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream. The method result returns in the apiCallExecuted callback. You can call this method either before or after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType , the setting of setRemoteVideoStreamType takes effect.
  ///
  /// Param [uid] User ID.
  ///
  /// Param [userId] User ID.
  ///
  /// Param [streamType] The video stream type: VideoStreamType .
  ///
  ///
  Future<void> setRemoteVideoStreamType(int userId, VideoStreamType streamType);

  ///
  /// Sets the default stream type of remote video streams.
  /// Under limited network conditions, if the publisher has not disabled the dual-stream mode using (),the receiver can choose to receive either the high-quality video stream or the low-quality video stream. The high-quality video stream has a higher resolution and bitrate, and the low-quality video stream has a lower resolution and bitrate. enableDualStreamMode false
  ///  By default, users receive the high-quality video stream. Call this method if you want to switch to the low-quality video stream. This method allows the app to adjust the corresponding video stream type based on the size of the video window to reduce the bandwidth and resources. The aspect ratio of the low-quality video stream is the same as the high-quality video stream. Once the resolution of the high-quality video stream is set, the system automatically sets the resolution, frame rate, and bitrate of the low-quality video stream.
  ///  The result of this method returns in the apiCallExecuted callback.
  ///  You can call this method either before or after joining a channel. If you call both setRemoteVideoStreamType and setRemoteDefaultVideoStreamType , the settings in setRemoteVideoStreamType take effect.
  ///
  /// Param [streamType] The default stream type of the remote video, see VideoStreamType .
  ///
  ///
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);

  ///
  /// Sets the fallback option for the published video stream based on the network conditions.
  /// An unstable network affects the audio and video quality in a video call or interactive live video streaming. If option is set as AudioOnly(2), the SDK disables the upstream video but enables audio only when the network conditions deteriorate and cannot support both video and audio. The SDK monitors the network quality and restores the video stream when the network conditions improve. When the published video stream falls back to audio-only or when the audio-only stream switches back to the video, the SDK triggers the localPublishFallbackToAudioOnly callback. Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the published video stream falls back to AudioOnly(2).
  ///  Ensure that you call this method before joining a channel.
  ///
  /// Param [option] The stream fallback option.
  ///
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  ///
  /// Sets the fallback option for the remotely subscribed video stream based on the network conditions.
  /// Unreliable network conditions affect the overall quality of the interactive live streaming. If option is set as VideoStreamLow(1) or AudioOnly(2), the SDK automatically switches the video from a high-quality stream to a low-quality stream or disables the video when the downlink network conditions cannot support both audio and video to guarantee the quality of the audio. The SDK monitors the network quality and restores the video stream when the network conditions improve. When the remote video stream falls back to audio-only or when the audio-only stream switches back to the video, the SDK triggers the remoteSubscribeFallbackToAudioOnly callback.
  ///  Ensure that you call this method before joining a channel.
  ///
  /// Param [option] The fallback option for the remotely subscribed video stream. The default value is VideoStreamLow(1). See StreamFallbackOptions .
  ///
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  ///
  /// Prioritizes a remote user's stream.
  /// Prioritizes a remote user's stream. The SDK ensures the high-priority user gets the best possible stream quality. The SDK ensures the high-priority user gets the best possible stream quality. The SDK supports setting only one user as high priority.
  ///  Ensure that you call this method before joining a channel.
  ///
  /// Param [uid] The ID of the remote user.
  ///
  /// Param [userPriority] The priority of the remote user. See UserPriority .
  ///
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);

  ///
  /// Starts an audio call test.
  /// This method starts an audio call test to determine whether the audio devices (for example, headset and speaker) and the network connection are working properly. To conduct the test, let the user speak for a while, and the recording is played back within the set interval. If the user can hear the recording within the interval, the audio devices and network connection are working properly. Call this method before joining a channel.
  ///  After calling stopEchoTest , you must call startEchoTest to end the test. Otherwise, the app cannot perform the next echo test, and you cannot join the channel.
  ///  In the live streaming channels, only a host can call this method.
  ///
  /// Param [intervalInSeconds] The time interval (s) between when you speak and when the recording plays back.
  ///
  Future<void> startEchoTest(
      {int? intervalInSeconds, EchoTestConfiguration? config});

  ///
  /// Stops the audio call test.
  ///
  ///
  Future<void> stopEchoTest();

  ///
  /// Enables the network connection quality test.
  /// This method tests the quality of the users' network connections. By default, this function is disabled. This method applies to the following scenarios:
  ///  Before a user joins a channel, call this method to check the uplink network quality.
  ///  Before an audience switches to a host, call this method to check the uplink network quality. Regardless of the scenario, enabling this method consumes extra network traffic and affects the call quality. After receiving the lastmileQuality callback, call disableLastmileTest to stop the test, and then join the channel or switch to the host. Do not use this method together with startLastmileProbeTest .
  ///  Do not call any other methods before receiving the lastmileQuality callback. Otherwise, the callback may be interrupted by other methods, and hence may not be triggered.
  ///  A host should not call this method after joining a channel (when in a call).
  ///  If you call this method to test the last mile network quality, the SDK consumes the bandwidth of a video stream, whose bitrate corresponds to the bitrate you set in setVideoEncoderConfiguration . After joining a channel, whether you have called disableLastmileTest or not, the SDK automatically stops consuming the bandwidth.
  ///
  Future<void> enableLastmileTest();

  ///
  /// Disables the network connection quality test.
  ///
  ///
  Future<void> disableLastmileTest();

  ///
  /// Starts the last mile network probe test.
  /// This method starts the last-mile network probe test before joining a channel to get the uplink and downlink last mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).
  ///  Once this method is enabled, the SDK returns the following callbacks:
  ///  lastmileQuality : The SDK triggers this callback within two seconds depending on the network conditions. This callback rates the network conditions and is more closely linked to the user experience.
  ///  lastmileProbeResult : The SDK triggers this callback within 30 seconds depending on the network conditions. This callback returns the real-time statistics of the network conditions and is more objective. This method applies to the following scenarios:
  ///  Before a user joins a channel, call this method to check the uplink network quality.
  ///  In a live streaming channel, call this method to check the uplink network quality before an audience member switches to a host. This method consumes extra network traffic and may affect communication quality. We do not recommend calling this method and enableLastmileTest at the same time.
  ///  Do not call other methods before receiving the lastmileQuality and lastmileProbeResult callbacks. Otherwise, the callbacks may be interrupted.
  ///  A host should not call this method after joining a channel (when in a call).
  ///
  /// Param [config] The configurations of the last-mile network probe test. See LastmileProbeConfig .
  ///
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  ///
  /// Stops the last mile network probe test.
  ///
  ///
  Future<void> stopLastmileProbeTest();

  ///
  /// Registers the metadata observer.
  /// Call this method before joinChannel.
  ///  This method applies only to interactive live streaming.
  ///
  Future<void> registerMediaMetadataObserver();

  ///
  /// Unregisters the specified metadata observer.
  ///
  ///
  Future<void> unregisterMediaMetadataObserver();

  ///
  /// Sets the maximum size of the media metadata.
  /// After calling registerMediaMetadataObserver , you can call this method to set the maximum size of the media metadata.
  ///
  /// Param [size] The maximum size of media metadata.
  ///
  Future<void> setMaxMetadataSize(int size);

  ///
  /// Sends media metadata.
  /// If the metadata is sent successfully, the SDK triggers the metadataReceived callback on the receiver.
  ///
  /// Param [metadata] Media metadata See Metadata .
  ///
  Future<void> sendMetadata(Uint8List metadata);

  ///
  /// Adds a watermark image to the local video.
  /// This method adds a PNG watermark image to the local video in the live streaming. Once the watermark image is added, all the audience in the channel (CDN audience included), and the capturing device can see and capture it. Agora supports adding only one watermark image onto the local video, and the newly watermark image replaces the previous one.
  ///  The watermark coordinates are dependent on the settings in the setVideoEncoderConfiguration method:
  ///  If the orientation mode of the encoding video ( VideoOutputOrientationMode ) is fixed landscape mode or the adaptive landscape mode, the watermark uses the landscape orientation.
  ///  If the orientation mode of the encoding video (VideoOutputOrientationMode) is fixed portrait mode or the adaptive portrait mode, the watermark uses the portrait orientation.
  ///  When setting the watermark position, the region must be less than the dimensions set in the setVideoEncoderConfiguration method; otherwise, the watermark image will be cropped. Ensure that call this method after enableVideo .
  ///  If you only want to add a watermark to the media push, you can call this method or the setLiveTranscoding method.
  ///  This method supports adding a watermark image in the PNG file format only. Supported pixel formats of the PNG image are RGBA, RGB, Palette, Gray, and Alpha_gray.
  ///  If the dimensions of the PNG image differ from your settings in this method, the image will be cropped or zoomed to conform to your settings.
  ///  If you have enabled the local video preview by calling the startPreview method, you can use the visibleInPreview member to set whether or not the watermark is visible in the preview.
  ///  If you have enabled the mirror mode for the local video, the watermark on the local video is also mirrored. To avoid mirroring the watermark, Agora recommends that you do not use the mirror and watermark functions for the local video at the same time. You can implement the watermark function in your application layer.
  ///
  /// Param [watermarkUrl] The local file path of the watermark image to be added. This method supports adding a watermark image from the local absolute or relative file path.
  ///
  /// Param [options] The options of the watermark image to be added.
  ///
  Future<void> addVideoWatermark(String watermarkUrl, WatermarkOptions options);

  ///
  /// Removes the watermark image from the video stream.
  ///
  ///
  Future<void> clearVideoWatermarks();

  ///
  /// Enables built-in encryption with an encryption password before users join a channel.
  /// Deprecated:
  ///  This method is deprecated from v3.2.0. Please use enableEncryption instead. Before joining the channel, you need to call this method to set the secret parameter to enable the built-in encryption. All users in the same channel should use the same secret. The secret is automatically cleared once a user leaves the channel. If you do not specify the secret or secret is set as null, the built-in encryption is disabled. Do not use this method for CDN live streaming.
  ///  For optimal transmission, ensure that the encrypted data size does not exceed the original data size + 16 bytes. 16 bytes is the maximum padding size for AES encryption.
  ///
  /// Param [secret] The encryption password.
  ///
  @Deprecated(
      'This method is deprecated from v3.2.0. Please use enableEncryption instead.')
  Future<void> setEncryptionSecret(String secret);

  ///
  /// Sets the built-in encryption mode.
  /// Deprecated:
  ///  Use enableEncryption instead. The Agora SDK supports built-in encryption, which is set to the AES-128-GCM mode by default. The Agora SDK supports built-in encryption, which is set to the AES-128-XTS mode by default. Call this method to use other encryption modes. All users in the same channel must use the same encryption mode and secret. Refer to the information related to the AES encryption algorithm on the differences between the encryption modes.
  ///  Before calling this method, please call setEncryptionSecret to enable the built-in encryption function.
  ///
  /// Param [encryptionMode] Encryption mode.
  ///  "aes-128-xts": 128-bit AES encryption, XTS mode.
  ///  "aes-128-ecb": 128-bit AES encryption, ECB mode.
  ///  "aes-256-xts": 256-bit AES encryption, XTS mode.
  ///  "sm4-128-ecb": 128-bit SM4 encryption, ECB mode.
  ///  "aes-128-gcm": 128-bit AES encryption, GCM mode.
  ///  "aes-256-gcm": 256-bit AES encryption, GCM mode.
  ///  "": When this parameter is set as null, the encryption mode is set as "aes-128-gcm" by default.
  ///  "": When setting as NULL, the encryption mode is set as "aes-128-xts" by default.
  ///
  @Deprecated(
      'This method is deprecated from v3.2.0. Please use enableEncryption instead.')
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);

  ///
  /// Enables/Disables the built-in encryption.
  /// In scenarios requiring high security, Agora recommends calling this method to enable the built-in encryption before joining a channel.
  ///  All users in the same channel must use the same encryption mode and encryption key. After the user leaves the channel, the SDK automatically disables the built-in encryption. To enable the built-in encryption, call this method before the user joins the channel again.
  ///  If you enable the built-in encryption, you cannot use the media push function.
  ///
  /// Param [enabled] Whether to enable built-in encryption:
  ///  true: Enable the built-in encryption.
  ///  false: Disable the built-in encryption.
  ///
  /// Param [config] Built-in encryption configurations. See EncryptionConfig for details.
  ///
  Future<void> enableEncryption(bool enabled, EncryptionConfig config);

  ///
  /// Starts audio recording on the client.
  /// Deprecated:
  ///  This method is deprecated as of v3.4.0. Please use startAudioRecordingWithConfig instead. The Agora SDK allows recording during a call. After successfully calling this method, you can record the audio of all the users in the channel and get an audio recording file. Supported formats of the recording file are as follows:
  ///  .wav: Large file size with high fidelity.
  ///  .aac: Small file size with low fidelity. Ensure that the directory you use to save the recording file exists and is writable.
  ///  This method should be called after the joinChannel method. The recording automatically stops when you call the leaveChannel method.
  ///  For better recording effects, set quality to Medium or High when sampleRate is 44.1 kHz or 48 kHz.
  ///
  /// Param [filePath] The absolute path (including the filename extensions) of the recording file. For example: C:\music\audio.aac . Ensure that the directory for the log files exists and is writable.
  ///
  ///
  /// Param [sampleRate] The sample rate (kHz) of the recording file. Supported values are as follows:
  ///  16000
  ///  (Default) 32000
  ///  44100
  ///  48000
  ///
  /// Param [quality] Recording quality.
  ///
  @Deprecated(
      'This method is deprecated as of v3.4.0. Please use startAudioRecordingWithConfig instead.')
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality);

  ///
  /// Starts audio recording on the client.
  /// The Agora SDK allows recording during a call. After successfully calling this method, you can record the audio of users in the channel and get an audio recording file. Supported formats of the recording file are as follows:
  ///  WAV: Large file size with high fidelity. For example, if the sample rate is 32,000 Hz, the file size for a recording duration of 10 minutes is around 73 M.
  ///  AAC: Small file size with low fidelity. For example, if the sample rate is 32,000 Hz and the recording quality is Medium, the file size for a recording duration of 10 minutes is around 2 M. Once the user leaves the channel, the recording automatically stops.
  ///  Call this method after joining a channel.
  ///
  /// Param [config] Recording configuration. See AudioRecordingConfiguration .
  ///
  Future<void> startAudioRecordingWithConfig(
      AudioRecordingConfiguration config);

  ///
  /// Enables the virtual metronome.
  /// In music education, physical education and other scenarios, teachers usually need to use a metronome so that students can practice with the correct beat. The meter is composed of a downbeat and upbeats. The first beat of each measure is called a downbeat, and the rest are called upbeats.
  ///  In this method, you need to set the paths of the upbeat and downbeat files, the number of beats per measure, the tempo, and whether to send the sound of the metronome to remote users. After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in RhythmPlayerConfig . For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///
  /// Param [sound1] The absolute path or URL address (including the filename extensions) of the file for the downbeat. For example: Android: /sdcard/emulated/0/audio.mp4, iOS: /var/mobile/Containers/Data/audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  ///
  /// Param [sound2] The absolute path or URL address (including the filename extensions) of the file for the upbeats. For example: Android: /sdcard/emulated/0/audio.mp4, iOS: /var/mobile/Containers/Data/audio.mp4. For the audio file formats supported by this method, see What formats of audio files does the Agora RTC SDK support.
  ///
  /// Param [config] The metronome configuration. See RhythmPlayerConfig .
  ///
  Future<void> startRhythmPlayer(
      String sound1, String sound2, RhythmPlayerConfig config);

  ///
  /// Disables the virtual metronome.
  /// After calling startRhythmPlayer , you can call this method to disable the virtual metronome.
  ///
  Future<void> stopRhythmPlayer();

  ///
  /// Configures the virtual metronome.
  /// After enabling the virtual metronome, the SDK plays the specified audio effect file from the beginning, and controls the playback duration of each file according to beatsPerMinute you set in RhythmPlayerConfig . For example, if you set beatsPerMinute as 60, the SDK plays one beat every second. If the file duration exceeds the beat duration, the SDK only plays the audio within the beat duration.
  ///  After calling startRhythmPlayer , you can call this method to reconfigure the virtual metronome.
  ///
  /// Param [config] The metronome configuration. See RhythmPlayerConfig .
  ///
  Future<void> configRhythmPlayer(RhythmPlayerConfig config);

  ///
  /// Stops the audio recording on the client.
  /// If you call startAudioRecordingWithConfig to start recording, you can call this method to stop the recording.
  ///  Once the user leaves the channel, the recording automatically stops.
  ///
  Future<void> stopAudioRecording();

  ///
  /// Injects an online media stream to a live streaming channel.
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.  Ensure that you enable the Media Push service before using this function. See Prerequisites in Media Push.
  ///  This method takes effect only when you are a host in a live streaming channel.
  ///  Only one online media stream can be injected into the same channel at the same time.
  ///  Call this method after joining a channel. This method injects the currently playing audio and video as audio and video sources into the ongoing live broadcast. This applies to scenarios where all users in the channel can watch a live show and interact with each other. After calling this method, the SDK triggers the streamInjectedStatus callback on the local client to report the state of injecting the online media stream; after successfully injecting the media stream, the stream joins the channel, and all users in the channel receive the userJoined callback, where uid is 666.
  ///
  /// Param [url] The URL address to be added to the ongoing streaming. Valid protocols are RTMP, HLS, and HTTP-FLV.
  ///  Supported audio codec type: AAC.
  ///  Supported video codec type: H264 (AVC).
  ///
  /// Param [config] The configuration information for the added video stream: LiveInjectStreamConfig .
  ///
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  ///
  /// Removes the voice or video stream URL address from the live streaming.
  /// Agora will soon stop the service for injecting online media streams on the client. If you have not implemented this service, Agora recommends that you do not use it.
  ///  After a successful method, the SDK triggers the userOffline callback
  ///  with the uid of 666.
  ///
  /// Param [url] The URL address of the injected stream to be removed.
  ///
  Future<void> removeInjectStreamUrl(String url);

  ///
  /// Switches between front and rear cameras.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel ).
  ///
  Future<void> switchCamera();

  ///
  /// Checks whether the device supports camera zoom.
  /// Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// **return** true: The device supports camera zoom.
  ///  false: The device does not support camera zoom.
  ///
  Future<bool?> isCameraZoomSupported();

  ///
  /// Checks whether the device supports camera flash.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel ). The app enables the front camera by default. If your front camera does not support flash, this method returns false.
  ///  If you want to check whether the rear camera supports flash, call switchCamera before this method.
  ///
  /// **return** true: The device supports camera flash.
  ///  false: The device does not support camera flash.
  ///
  Future<bool?> isCameraTorchSupported();

  ///
  /// Check whether the device supports the manual focus function.
  /// Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// **return** true: The device supports the manual focus function.
  ///  false: The device does not support the manual focus function.
  ///
  Future<bool?> isCameraFocusSupported();

  ///
  /// Checks whether the device supports manual exposure.
  /// Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// **return** true: The device supports manual exposure.
  ///  false: The device does not support manual exposure.
  ///
  Future<bool?> isCameraExposurePositionSupported();

  ///
  /// Checks whether the device supports the face auto-focus function.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel ).
  ///
  /// **return** true: The device supports the face auto-focus function.
  ///  false: The device does not support the face auto-focus function.
  ///
  Future<bool?> isCameraAutoFocusFaceModeSupported();

  ///
  /// Sets the camera zoom ratio.
  /// Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// Param [factor] The camera zoom ratio. The value ranges between 1.0 and the maximum zoom supported by the device. You can get the maximum zoom ratio supported by the device by calling the getCameraMaxZoomFactor method.
  ///
  Future<void> setCameraZoomFactor(double factor);

  ///
  /// Gets the maximum zoom ratio supported by the camera.
  /// Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// **return** The maximum zoom factor.
  ///
  Future<double?> getCameraMaxZoomFactor();

  ///
  /// Sets the camera manual focus position.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel ).
  ///  After a successful method call, the SDK triggers the cameraFocusAreaChanged callback.
  ///  This method is for Android and iOS only.
  ///
  /// Param [positionX] The horizontal coordinate of the touchpoint in the view.
  ///
  /// Param [positionY] The vertical coordinate of the touchpoint in the view.
  ///
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY);

  ///
  /// Sets the camera exposure position.
  /// This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel ).
  ///  After a successful method call, the SDK triggers the cameraExposureAreaChanged callback.
  ///  This method is for Android and iOS only.
  ///
  /// Param [positionXinView] The horizontal coordinate of the touchpoint in the view.
  ///
  /// Param [positionYinView] The vertical coordinate of the touchpoint in the view.
  ///
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView);

  ///
  /// Enables/Disables face detection for the local user.
  /// Since
  ///  v3.0.1 You can call this method either before or after joining a channel.
  ///  This method is for Android and iOS only.
  ///  Once face detection is enabled, the SDK triggers the facePositionChanged callback to report the face information of the local user:
  ///  The width and height of the local video.
  ///  The position of the human face in the local video.
  ///  The distance between the human face and the screen. This method needs to be called after the camera is started (for example, by calling startPreview or joinChannel).
  ///
  /// Param [enable] Whether to enable face detection:
  ///  true: Enable face detection.
  ///  false: (Default) Disable face detection.
  ///
  Future<void> enableFaceDetection(bool enable);

  ///
  /// Enables the camera flash.
  /// Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// Param [isOn] Whether to turn on the camera flash:
  ///  true: Turn on the flash.
  ///  false: (Default) Turn off the flash.
  ///
  ///
  /// **return** 0: Success.
  ///  < 0: Failure.
  ///
  Future<void> setCameraTorchOn(bool isOn);

  ///
  /// Enables the camera auto-face focus function.
  /// Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// Param [enabled] Whether to enable the camera auto-face focus function:
  ///  true: Enable the camera auto-face focus function.
  ///  false: (Default) Disable the camera auto-face focus function.
  ///
  ///
  /// **return** 0: Success.
  ///  < 0: Failure.
  ///
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  ///
  /// Sets the camera capture configuration.
  /// For a video call or the interactive live video streaming, generally the SDK controls the camera output parameters. When the default camera capturer settings do not meet special requirements or cause performance problems, we recommend using this method to set the camera capturer configuration:
  ///  If the resolution or frame rate of the captured raw video data are higher than those set by setVideoEncoderConfiguration , processing video frames requires extra CPU and RAM usage and degrades performance. Agora recommends setting the camera capture configuration to Performance(1) to avoid such problems.
  ///  If you do not need a local video preview or are willing to sacrifice preview quality, we recommend setting the preference as Performance(1) to optimize CPU and RAM usage.
  ///  If you want better quality for the local video preview, we recommend setting config as Preview(2).
  ///  To customize the width and height of the video image captured by the local camera, set the camera capture configuration as Manual(3).
  ///  Call this method before calling joinChannel , enableVideo , or enableLocalVideo , depending on which method you use to turn on your local camera.
  ///
  /// Param [config] The camera capturer configuration. See CameraCapturerConfiguration .
  ///
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);

  ///
  /// Creates a data stream.
  /// Each user can create up to five data streams during the lifecycle of RtcEngine . Call this method after joining a channel.
  ///  Agora does not support setting reliable as true and ordered as true.
  ///
  /// Param [reliable] Whether or not the data stream is reliable:
  ///  true: The recipients receive the data from the sender within five seconds. If the recipient does not receive the data within five seconds, the SDK triggers the streamMessageError callback and returns an error code.
  ///  false: There is no guarantee that the recipients receive the data stream within five seconds and no error message is reported for any delay or missing data stream.
  ///
  ///
  /// Param [ordered] Whether or not the recipients receive the data stream in the sent order:
  ///  true: The recipients receive the data in the sent order.
  ///  false: The recipients do not receive the data in the sent order.
  ///
  ///
  /// **return** ID of the created data stream, if the method call succeeds.
  ///  < 0: Failure. You can refer to Error Codes and Warning Codes for troubleshooting.
  ///
  Future<int?> createDataStream(bool reliable, bool ordered);

  ///
  /// Creates a data stream.
  /// Creates a data stream. Each user can create up to five data streams in a single channel.
  ///  Compared with createDataStream [1/2], this method does not support data reliability. If a data packet is not received five seconds after it was sent, the SDK directly discards the data.
  ///
  /// Param [config] The configurations for the data stream.
  ///
  /// **return** ID of the created data stream, if the method call succeeds.
  ///  < 0: Failure. You can refer to Error Codes and Warning Codes for troubleshooting.
  ///
  Future<int?> createDataStreamWithConfig(DataStreamConfig config);

  ///
  /// Sends data stream messages.
  /// Sends data stream messages to all users in a channel. The SDK has the following restrictions on this method:Up to 30 packets can be sent per second in a channel with each packet having a maximum size of 1 KB.Each client can send up to 6 KB of data per second.Each user can have up to five data streams simultaneously.
  ///  A successful method call triggers the streamMessage callback on the remote client, from which the remote user gets the stream message. A failed method call triggers the streamMessageError callback on the remote client. Ensure that you call createDataStreamWithConfig to create a data channel before calling this method.
  ///  In live streaming scenarios, this method only applies to hosts.
  ///
  /// Param [streamId] The data stream ID. You can get the data stream ID by calling createDataStreamWithConfig.
  ///
  /// Param [message] The message to be sent.
  ///
  Future<void> sendStreamMessage(int streamId, Uint8List message);

  ///
  /// Shares the screen by specifying the display ID.
  /// This method shares a screen or part of the screen. You need to specify the ID of the screen to be shared in this method. This method applies to macOS only.
  ///  Call this method after joining a channel.
  ///  On Windows platforms, if the user device is connected to another display, to avoid screen sharing issues, use startScreenCaptureByDisplayId to start sharing instead of using startScreenCaptureByScreenRect .
  ///
  /// Param [displayId] The display ID of the screen to be shared. Use this parameter to specify which screen you want to share.
  ///
  /// Param [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen.  If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
  ///
  /// Param [captureParams] Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges.
  ///
  Future<void> startScreenCaptureByDisplayId(int displayId,
      [Rectangle? regionRect, ScreenCaptureParameters? captureParams]);

  ///
  /// Shares the whole or part of a screen by specifying the screen rect.
  /// This method shares a screen or part of the screen. You need to specify the area of the screen to be shared.
  ///  This method applies to the Windows platform only.Call this method after joining a channel.
  ///
  /// Param [screenRect] Sets the relative location of the screen to the virtual screen.
  ///
  /// Param [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen. See Rectangle . If the specified region overruns the screen, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen.
  ///
  /// Param [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges. See ScreenCaptureParameters .
  ///
  Future<void> startScreenCaptureByScreenRect(Rectangle screenRect,
      [Rectangle? regionRect, ScreenCaptureParameters? captureParams]);

  ///
  /// Shares the whole or part of a window by specifying the window ID.
  /// This method shares a window or part of the window. You need to specify the ID of the window to be shared. Call this method after joining a channel.
  ///  This method applies to macOS and Windows only.
  ///
  /// Param [windowId] The ID of the window to be shared.
  ///
  /// Param [regionRect] (Optional) Sets the relative location of the region to the screen. If you do not set this parameter, the SDK shares the whole screen.  If the specified region overruns the window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole window.
  ///
  /// Param [captureParams] Screen sharing configurations. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges.
  ///
  Future<void> startScreenCaptureByWindowId(int windowId,
      [Rectangle? regionRect, ScreenCaptureParameters? captureParams]);

  ///
  /// Sets the content hint for screen sharing.
  /// A content hint suggests the type of the content being shared, so that the SDK applies different optimization algorithms to different types of content. If you don't call this method, the default content hint is None.
  ///  You can call this method either before or after you start screen sharing.
  ///
  /// Param [contentHint] The content hint for screen sharing.
  ///
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint);

  ///
  /// Updates the screen sharing parameters.
  ///
  ///
  /// Param [captureParams] The screen sharing encoding parameters. The default video dimension is 1920 x 1080, that is, 2,073,600 pixels. Agora uses the value of this parameter to calculate the charges.
  ///
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams);

  ///
  /// Updates the screen sharing region.
  ///
  ///
  /// Param [regionRect] The relative location of the screen-shared area to the screen or window. If you do not set this parameter, the SDK shares the whole screen or window. See Rectangle . If the specified region overruns the screen or window, the SDK shares only the region within it; if you set width or height as 0, the SDK shares the whole screen or window.
  ///
  Future<void> updateScreenCaptureRegion(Rectangle regionRect);

  ///
  /// Stops screen sharing.
  ///
  ///
  Future<void> stopScreenCapture();

  ///
  /// Starts screen sharing.
  /// Deprecated:
  ///  This method is deprecated as of v2.4.0. See the following methods instead:
  ///  startScreenCaptureByDisplayId
  ///  startScreenCaptureByWindowId
  ///  This method shares the whole screen, a specified window, or the specified region:
  ///  Whole screen: Set windowId as 0 and rect as null.
  ///  A specified window: Set windowId as a value other than 0. Each window has a windowId that is not 0.
  ///  The specified region: Set windowId as 0 and rect as a value other than null. In this case, you can share the specified region, for example by dragging the mouse or implementing your own logic. The specified region is a region on the whole screen. Currently, sharing a specified region in a specific window is not supported. captureFreq is the captured frame rate once the screen-sharing function is enabled. The mandatory value ranges between 1 fps and 15 fps. No matter which of the above functions you enable, the SDK returns 0 when the execution succeeds, and an error code when the execution fails.
  ///
  /// Param [windowId] The screen sharing area.
  ///
  /// Param [captureFreq] (Mandatory) The captured frame rate. The value ranges between 1 fps and 15 fps.
  ///
  /// Param [rect] Specifies the screen-sharing region: Rect . This parameter is valid when windowsId is set as 0. When rect is set as null, the whole screen is shared.
  ///
  /// Param [bitrate] The bitrate of the screen share.
  ///
  Future<void> startScreenCapture(int windowId,
      [int captureFreq, Rect? rect, int bitrate]);

  /// @nodoc
  Future<void> setAVSyncSource(String channelId, int uid);

  ///
  /// Starts pushing media streams to a CDN without transcoding.
  /// This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times. This method can push media streams to only one CDN address at a time, so if you need to push streams to multiple addresses, call this method multiple times.
  ///  After you call this method, the SDK triggers the rtmpStreamingStateChanged callback on the local client to report the state of the streaming. Ensure that you enable the RTMP Converter service before using this function. See Prerequisites in Push Streams to CDN.
  ///  Call this method after joining a channel.
  ///  Only hosts in the LIVE_BROADCASTING profile can call this method.
  ///  If you want to retry pushing streams after a failed push, make sure to call stopRtmpStream first, then call this method to retry pushing streams; otherwise, the SDK returns the same error code as the last failed push.
  ///
  /// Param [url] The address of the CDN live streaming. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  Future<void> startRtmpStreamWithoutTranscoding(String url);

  ///
  /// Updates the transcoding configuration.
  /// After you start pushing media streams to CDN with transcoding, you can dynamically update the transcoding configuration according to the scenario. The SDK triggers the transcodingUpdated callback after the transcoding configuration is updated.
  ///
  /// Param [transcoding] The transcoding configuration for CDN live streaming. See LiveTranscoding .
  ///
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding);

  ///
  /// Stops pushing media streams to a CDN.
  /// You can call this method to stop the live stream on the specified CDN address. This method can stop pushing media streams to only one CDN address at a time, so if you need to stop pushing streams to multiple addresses, call this method multiple times.
  ///  After you call this method, the SDK triggers the rtmpStreamingStateChanged callback on the local client to report the state of the streaming.
  ///
  /// Param [url] CDN streaming address. The format is RTMP or RTMPS. The character length cannot exceed 1024 bytes. Special characters such as Chinese characters are not supported.
  ///
  Future<void> stopRtmpStream(String url);

  ///
  /// Sets low-light enhancement.
  /// The low-light enhancement feature can adaptively adjust the brightness value of the video captured in situations with low or uneven lighting, such as backlit, cloudy, or dark scenes. It restores or highlights the image details and improves the overall visual effect of the video.
  ///  You can call this method to enable the color enhancement feature and set the options of the color enhancement effect.You can call this method to enable the low-light enhancement feature and set the options of the low-light enhancement effect. Call this method after calling enableVideo .
  ///  Dark light enhancement has certain requirements for equipment performance. The low-light enhancement feature has certain performance requirements on devices. If your device overheats after you enable low-light enhancement, Agora recommends modifying the low-light enhancement options to a less performance-consuming level or disabling low-light enhancement entirely.
  ///
  /// Param [enabled] Sets whether to enable low-light enhancement:
  ///  true: Enable.
  ///  false: (Default) Disable.
  ///
  ///
  /// Param [option] The low-light enhancement options.
  ///
  Future<void> setLowlightEnhanceOptions(
      bool enabled, LowLightEnhanceOptions option);

  ///
  /// Sets video noise reduction.
  /// Underlit environments and low-end video capture devices can cause video images to contain significant noise, which affects video quality. In real-time interactive scenarios, video noise also consumes bitstream resources and reduces encoding efficiency during encoding.
  ///  You can call this method to enable the video noise reduction feature and set the options of the video noise reduction effect. Call this method after calling enableVideo .
  ///  Video noise reduction has certain requirements for equipment performance. If your device overheats after you enable video noise reduction, Agora recommends modifying the video noise reduction options to a less performance-consuming level or disabling video noise reduction entirely.
  ///
  /// Param [enabled] Sets whether to enable video noise reduction:
  ///  true: Enable.
  ///  false: (Default) Disable.
  ///
  ///
  /// Param [options] The video noise reduction options.
  ///
  Future<void> setVideoDenoiserOptions(
      bool enabled, VideoDenoiserOptions option);

  ///
  /// Sets color enhancement.
  /// The video images captured by the camera can have color distortion. The color enhancement feature intelligently adjusts video characteristics such as saturation and contrast to enhance the video color richness and color reproduction, making the video more vivid.
  ///  You can call this method to enable the color enhancement feature and set the options of the color enhancement effect. Call this method after calling enableVideo .
  ///  The color enhancement feature has certain performance requirements on devices. With Color Enhancement turned on, Agora recommends that you change the Color Enhancement Level to one that consumes less performance or turn off Color Enhancement if your device is experiencing severe heat problems.
  ///
  /// Param [enabled] Whether to turn on color enhancement:
  ///  true: Enable.
  ///  false: (Default) Disable.
  ///
  ///
  /// Param [option] The color enhancement options.
  ///
  Future<void> setColorEnhanceOptions(bool enabled, ColorEnhanceOptions option);

  /// @nodoc
  Future<void> enableWirelessAccelerate(bool enabled);
}
