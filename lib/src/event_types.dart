import 'dart:typed_data';

import 'package:agora_rtc_engine/src/classes.dart';
import 'package:agora_rtc_engine/src/enums.dart';

// ignore_for_file: public_member_api_docs

typedef EmptyCallback = void Function();

typedef WarningCallback = void Function(WarningCode warn);

typedef ErrorCallback = void Function(ErrorCode err);

typedef ApiCallCallback = void Function(
    ErrorCode error, String api, String result);

typedef UidWithElapsedAndChannelCallback = void Function(
    String channel, int uid, int elapsed);

typedef RtcStatsCallback = void Function(RtcStats stats);

typedef UserAccountCallback = void Function(int uid, String userAccount);

typedef UserInfoCallback = void Function(int uid, UserInfo userInfo);

typedef ClientRoleCallback = void Function(
    ClientRole oldRole, ClientRole newRole);

typedef UidWithElapsedCallback = void Function(int uid, int elapsed);

typedef UserOfflineCallback = void Function(int uid, UserOfflineReason reason);

typedef ConnectionStateCallback = void Function(
    ConnectionStateType state, ConnectionChangedReason reason);

typedef NetworkTypeCallback = void Function(NetworkType type);

typedef TokenCallback = void Function(String token);

typedef AudioVolumeCallback = void Function(
    List<AudioVolumeInfo> speakers, int totalVolume);

typedef UidCallback = void Function(int uid);

typedef ElapsedCallback = void Function(int elapsed);

typedef VideoFrameCallback = void Function(int width, int height, int elapsed);

typedef UidWithMutedCallback = void Function(int uid, bool muted);

typedef VideoSizeCallback = void Function(
    int uid, int width, int height, int rotation);

typedef RemoteVideoStateCallback = void Function(int uid,
    VideoRemoteState state, VideoRemoteStateReason reason, int elapsed);

typedef LocalVideoStateCallback = void Function(
    LocalVideoStreamState localVideoState, LocalVideoStreamError error);

typedef RemoteAudioStateCallback = void Function(int uid,
    AudioRemoteState state, AudioRemoteStateReason reason, int elapsed);

typedef LocalAudioStateCallback = void Function(
    AudioLocalState state, AudioLocalError error);

typedef RequestAudioFileInfoCallback = void Function(
    AudioFileInfo info, AudioFileInfoError error);

typedef FallbackCallback = void Function(bool isFallbackOrRecover);

typedef FallbackWithUidCallback = void Function(
    int uid, bool isFallbackOrRecover);

typedef AudioRouteCallback = void Function(AudioOutputRouting routing);

typedef RectCallback = void Function(Rect rect);

typedef NetworkQualityCallback = void Function(NetworkQuality quality);

typedef NetworkQualityWithUidCallback = void Function(
    int uid, NetworkQuality txQuality, NetworkQuality rxQuality);

typedef LastmileProbeCallback = void Function(LastmileProbeResult result);

typedef LocalVideoStatsCallback = void Function(LocalVideoStats stats);

typedef LocalAudioStatsCallback = void Function(LocalAudioStats stats);

typedef RemoteVideoStatsCallback = void Function(RemoteVideoStats stats);

typedef RemoteAudioStatsCallback = void Function(RemoteAudioStats stats);

typedef AudioMixingStateCallback = void Function(
    AudioMixingStateCode state, AudioMixingReason reason);

typedef SoundIdCallback = void Function(int soundId);

typedef RtmpStreamingStateCallback = void Function(
    String url, RtmpStreamingState state, RtmpStreamingErrorCode errCode);

typedef StreamInjectedStatusCallback = void Function(
    String url, int uid, InjectStreamStatus status);

typedef StreamMessageCallback = void Function(
    int uid, int streamId, Uint8List data);

typedef StreamMessageErrorCallback = void Function(
    int uid, int streamId, ErrorCode error, int missed, int cached);

typedef MediaRelayStateCallback = void Function(
    ChannelMediaRelayState state, ChannelMediaRelayError code);

typedef MediaRelayEventCallback = void Function(ChannelMediaRelayEvent code);

typedef VideoFrameWithUidCallback = void Function(
    int uid, int width, int height, int elapsed);

typedef UrlWithErrorCallback = void Function(String url, ErrorCode error);

typedef UrlCallback = void Function(String url);

typedef TransportStatsCallback = void Function(
    int uid, int delay, int lost, int rxKBitRate);

typedef UidWithEnabledCallback = void Function(int uid, bool enabled);

typedef EnabledCallback = void Function(bool enabled);

typedef AudioQualityCallback = void Function(
    int uid, int quality, int delay, int lost);

typedef MetadataCallback = void Function(Metadata metadata);

typedef FacePositionCallback = void Function(
    int imageWidth, int imageHeight, List<FacePositionInfo> faces);

typedef StreamPublishStateCallback = void Function(
    String channel,
    StreamPublishState oldState,
    StreamPublishState newState,
    int elapseSinceLastState);

typedef StreamSubscribeStateCallback = void Function(
    String channel,
    int uid,
    StreamSubscribeState oldState,
    StreamSubscribeState newState,
    int elapseSinceLastState);

typedef RtmpStreamingEventCallback = void Function(
    String url, RtmpStreamingEvent eventCode);

typedef UserSuperResolutionEnabledCallback = void Function(
    int uid, bool enabled, SuperResolutionStateReason reason);

typedef UploadLogResultCallback = void Function(
    String requestId, bool success, UploadErrorReason reason);

typedef VirtualBackgroundSourceEnabledCallback = void Function(
    bool enabled, VirtualBackgroundSourceStateReason reason);
typedef VideoDeviceStateChanged = void Function(
  String deviceId,
  MediaDeviceType deviceType,
  MediaDeviceStateType deviceState,
);

typedef AudioDeviceVolumeChanged = void Function(
  MediaDeviceType deviceType,
  int volume,
  bool muted,
);

typedef AudioDeviceStateChanged = void Function(
  String deviceId,
  MediaDeviceType deviceType,
  MediaDeviceStateType deviceState,
);

typedef OnContentInspectResult = void Function(ContentInspectResult result);

typedef RemoteAudioMixingBegin = void Function();

typedef RemoteAudioMixingEnd = void Function();

typedef RecorderStateChangedCallback = void Function(
    RecorderState state, RecorderErrorCode error);

typedef SnapshotTakenCallback = void Function(String channel, int uid,
    String filePath, int width, int height, int errCode);

typedef OnScreenCaptureInfoUpdated = void Function(ScreenCaptureInfo info);

typedef OnClientRoleChangeFailed = void Function(
    ClientRoleChangeFailedReason reason, ClientRole currentRole);

typedef OnWlAccMessage = void Function(
    WlaccMessageReason reason, WlaccSuggestAction action, String wlAccMsg);

typedef OnWlAccStats = void Function(
    WlAccStats currentStats, WlAccStats averageStats);

typedef OnProxyConnected = void Function(String channel, int uid,
    ProxyType proxyType, String localProxyIp, int elapsed);

typedef OnAudioDeviceTestVolumeIndication = void Function(
    AudioDeviceTestVolumeType volumeType, int volume);

typedef OnRecorderStateChanged = void Function(
    RecorderState state, RecorderErrorCode error);

typedef OnRecorderInfoUpdated = void Function(RecorderInfo info);
