//
// Created by LXH on 2021/11/30.
//

#include "rtc_event_handler_test.h"
#include "fake_rtc_engine.h"
#include "iris_rtc_channel.h"
#include "iris_rtc_engine.h"
#include "iris_rtc_engine_integration_test_delegate.h"
#include <string>

using namespace agora::rtc;
using namespace agora::iris::rtc;

void CallRtcEngineEvents(IrisRtcEnginePtr engine_ptr, const char *event_name)
{
    IrisRtcEngine *irisRtcEngine = reinterpret_cast<IrisRtcEngine *>(engine_ptr);
    IrisRtcEngineIntegrationTestDelegate *delegate = reinterpret_cast<IrisRtcEngineIntegrationTestDelegate *>(irisRtcEngine->GetDelegate());
    FakeRtcEngine *fakeRtcEngine = reinterpret_cast<FakeRtcEngine *>(delegate->fakeRtcEngine_);
    agora::rtc::IRtcEngineEventHandler *handler = fakeRtcEngine->event_handler_;

    if (event_name == nullptr || strcmp(event_name, "onWarning") == 0)
    {
        handler->onWarning(8, "123");
    }
    if (event_name == nullptr || strcmp(event_name, "onError") == 0)
    {
        handler->onError(0, "123");
    }
    if (event_name == nullptr || strcmp(event_name, "onJoinChannelSuccess") == 0)
    {
        handler->onJoinChannelSuccess("123", 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onRejoinChannelSuccess") == 0)
    {
        handler->onRejoinChannelSuccess("123", 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onLeaveChannel") == 0)
    {
        RtcStats stats;
        handler->onLeaveChannel(stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onClientRoleChanged") == 0)
    {
        handler->onClientRoleChanged(CLIENT_ROLE_TYPE::CLIENT_ROLE_AUDIENCE,
                                     CLIENT_ROLE_TYPE::CLIENT_ROLE_BROADCASTER);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserJoined") == 0)
    {
        handler->onUserJoined(123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserOffline") == 0)
    {
        handler->onUserOffline(
            123, USER_OFFLINE_REASON_TYPE::USER_OFFLINE_BECOME_AUDIENCE);
    }
    if (event_name == nullptr || strcmp(event_name, "onLastmileQuality") == 0)
    {
        handler->onLastmileQuality(0);
    }
    if (event_name == nullptr || strcmp(event_name, "onLastmileProbeResult") == 0)
    {
        LastmileProbeResult result{};
        result.state = LASTMILE_PROBE_RESULT_STATE::LASTMILE_PROBE_RESULT_COMPLETE;
        handler->onLastmileProbeResult(result);
    }
    if (event_name == nullptr || strcmp(event_name, "onConnectionInterrupted") == 0)
    {
        handler->onConnectionInterrupted();
    }
    if (event_name == nullptr || strcmp(event_name, "onConnectionLost") == 0)
    {
        handler->onConnectionLost();
    }
    if (event_name == nullptr || strcmp(event_name, "onConnectionBanned") == 0)
    {
        handler->onConnectionBanned();
    }
    if (event_name == nullptr || strcmp(event_name, "onApiCallExecuted") == 0)
    {
        handler->onApiCallExecuted(0, "", "");
    }
    if (event_name == nullptr || strcmp(event_name, "onRequestToken") == 0)
    {
        handler->onRequestToken();
    }
    if (event_name == nullptr || strcmp(event_name, "onTokenPrivilegeWillExpire") == 0)
    {
        handler->onTokenPrivilegeWillExpire("123");
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioQuality") == 0)
    {
        handler->onAudioQuality(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onRtcStats") == 0)
    {
        RtcStats stats;
        handler->onRtcStats(stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onNetworkQuality") == 0)
    {
        handler->onNetworkQuality(123, 0, 0);
    }
    if (event_name == nullptr || strcmp(event_name, "onLocalVideoStats") == 0)
    {
        LocalVideoStats stats{};
        stats.qualityAdaptIndication = QUALITY_ADAPT_INDICATION::ADAPT_NONE;
        stats.codecType = VIDEO_CODEC_TYPE::VIDEO_CODEC_H264;
        stats.captureBrightnessLevel = CAPTURE_BRIGHTNESS_LEVEL_TYPE::CAPTURE_BRIGHTNESS_LEVEL_DARK;
        handler->onLocalVideoStats(stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteVideoStats") == 0)
    {
        RemoteVideoStats stats{};
        handler->onRemoteVideoStats(stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onLocalAudioStats") == 0)
    {
        LocalAudioStats stats{};
        handler->onLocalAudioStats(stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteAudioStats") == 0)
    {
        RemoteAudioStats stats{};
        handler->onRemoteAudioStats(stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onLocalAudioStateChanged") == 0)
    {
        handler->onLocalAudioStateChanged(
            LOCAL_AUDIO_STREAM_STATE::LOCAL_AUDIO_STREAM_STATE_ENCODING,
            LOCAL_AUDIO_STREAM_ERROR::LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteAudioStateChanged") == 0)
    {
        handler->onRemoteAudioStateChanged(
            123, REMOTE_AUDIO_STATE::REMOTE_AUDIO_STATE_DECODING,
            REMOTE_AUDIO_STATE_REASON::REMOTE_AUDIO_REASON_INTERNAL, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioPublishStateChanged") == 0)
    {
        handler->onAudioPublishStateChanged(
            "123", STREAM_PUBLISH_STATE::PUB_STATE_IDLE,
            STREAM_PUBLISH_STATE::PUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoPublishStateChanged") == 0)
    {
        handler->onVideoPublishStateChanged(
            "123", STREAM_PUBLISH_STATE::PUB_STATE_IDLE,
            STREAM_PUBLISH_STATE::PUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioSubscribeStateChanged") == 0)
    {
        handler->onAudioSubscribeStateChanged(
            "123", 123, STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE,
            STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoSubscribeStateChanged") == 0)
    {
        handler->onVideoSubscribeStateChanged(
            "123", 123, STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE,
            STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioVolumeIndication") == 0)
    {
        AudioVolumeInfo info{};
        info.channelId = "123";
        info.uid = 123;
        info.vad = 123;
        info.volume = 123;
        AudioVolumeInfo speakers[1] = {info};
        handler->onAudioVolumeIndication(speakers, 1, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onActiveSpeaker") == 0)
    {
        handler->onActiveSpeaker(123);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoStopped") == 0)
    {
        handler->onVideoStopped();
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstLocalVideoFrame") == 0)
    {
        handler->onFirstLocalVideoFrame(123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstLocalVideoFramePublished") == 0)
    {
        handler->onFirstLocalVideoFramePublished(123);
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstRemoteVideoDecoded") == 0)
    {
        handler->onFirstRemoteVideoDecoded(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstRemoteVideoFrame") == 0)
    {
        handler->onFirstRemoteVideoFrame(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserMuteAudio") == 0)
    {
        handler->onUserMuteAudio(123, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserMuteVideo") == 0)
    {
        handler->onUserMuteVideo(123, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserEnableVideo") == 0)
    {
        handler->onUserEnableVideo(123, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioDeviceStateChanged") == 0)
    {
        handler->onAudioDeviceStateChanged("123", MEDIA_DEVICE_TYPE::AUDIO_PLAYOUT_DEVICE, MEDIA_DEVICE_STATE_TYPE::MEDIA_DEVICE_STATE_IDLE);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioDeviceVolumeChanged") == 0)
    {
        handler->onAudioDeviceVolumeChanged(
            MEDIA_DEVICE_TYPE::AUDIO_APPLICATION_PLAYOUT_DEVICE, 123, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onCameraReady") == 0)
    {
        handler->onCameraReady();
    }
    if (event_name == nullptr || strcmp(event_name, "onCameraFocusAreaChanged") == 0)
    {
        handler->onCameraFocusAreaChanged(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onFacePositionChanged") == 0)
    {
#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)
        Rectangle rectangle;
        Rectangle vecRectangle[1] = {rectangle};
        int vecDistance[1] = {123};
        handler->onFacePositionChanged(123, 123, vecRectangle, vecDistance, 1);
#endif
    }
    if (event_name == nullptr || strcmp(event_name, "onCameraExposureAreaChanged") == 0)
    {
        handler->onCameraExposureAreaChanged(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioMixingFinished") == 0)
    {
        handler->onAudioMixingFinished();
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioMixingStateChanged") == 0)
    {
        handler->onAudioMixingStateChanged(
            AUDIO_MIXING_STATE_TYPE::AUDIO_MIXING_STATE_FAILED,
            AUDIO_MIXING_REASON_TYPE::AUDIO_MIXING_REASON_ALL_LOOPS_COMPLETED);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteAudioMixingBegin") == 0)
    {
        handler->onRemoteAudioMixingBegin();
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteAudioMixingEnd") == 0)
    {
        handler->onRemoteAudioMixingEnd();
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioEffectFinished") == 0)
    {
        handler->onAudioEffectFinished(123);
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstRemoteAudioDecoded") == 0)
    {
        handler->onFirstRemoteAudioDecoded(123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoDeviceStateChanged") == 0)
    {
        handler->onVideoDeviceStateChanged("123", MEDIA_DEVICE_TYPE::AUDIO_PLAYOUT_DEVICE, MEDIA_DEVICE_STATE_TYPE::MEDIA_DEVICE_STATE_IDLE);
    }
    if (event_name == nullptr || strcmp(event_name, "onLocalVideoStateChanged") == 0)
    {
        handler->onLocalVideoStateChanged(
            LOCAL_VIDEO_STREAM_STATE::LOCAL_VIDEO_STREAM_STATE_CAPTURING,
            LOCAL_VIDEO_STREAM_ERROR::LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoSizeChanged") == 0)
    {
        handler->onVideoSizeChanged(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteVideoStateChanged") == 0)
    {
        handler->onRemoteVideoStateChanged(
            123, REMOTE_VIDEO_STATE::REMOTE_VIDEO_STATE_DECODING,
            REMOTE_VIDEO_STATE_REASON::REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK,
            123);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserEnableLocalVideo") == 0)
    {
        handler->onUserEnableLocalVideo(123, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamMessage") == 0)
    {
        char data[1] = {'\0'};
        handler->onStreamMessage(123, 123, data, sizeof(data));
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamMessageError") == 0)
    {
        handler->onStreamMessageError(123, 123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onMediaEngineLoadSuccess") == 0)
    {
        handler->onMediaEngineLoadSuccess();
    }
    if (event_name == nullptr || strcmp(event_name, "onMediaEngineStartCallSuccess") == 0)
    {
        handler->onMediaEngineStartCallSuccess();
    }
    if (event_name == nullptr || strcmp(event_name, "onUserSuperResolutionEnabled") == 0)
    {
        handler->onUserSuperResolutionEnabled(
            123, true,
            SUPER_RESOLUTION_STATE_REASON::SR_STATE_REASON_DEVICE_NOT_SUPPORTED);
    }
    if (event_name == nullptr || strcmp(event_name, "onChannelMediaRelayStateChanged") == 0)
    {
        handler->onChannelMediaRelayStateChanged(
            CHANNEL_MEDIA_RELAY_STATE::RELAY_STATE_CONNECTING,
            CHANNEL_MEDIA_RELAY_ERROR::RELAY_ERROR_DEST_TOKEN_EXPIRED);
    }
    if (event_name == nullptr || strcmp(event_name, "onChannelMediaRelayEvent") == 0)
    {
        handler->onChannelMediaRelayEvent(
            CHANNEL_MEDIA_RELAY_EVENT::RELAY_EVENT_NETWORK_CONNECTED);
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstLocalAudioFrame") == 0)
    {
        handler->onFirstLocalAudioFrame(123);
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstLocalAudioFramePublished") == 0)
    {
        handler->onFirstLocalAudioFramePublished(123);
    }
    if (event_name == nullptr || strcmp(event_name, "onFirstRemoteAudioFrame") == 0)
    {
        handler->onFirstRemoteAudioFrame(123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onRtmpStreamingStateChanged") == 0)
    {
        handler->onRtmpStreamingStateChanged(
            "123", RTMP_STREAM_PUBLISH_STATE::RTMP_STREAM_PUBLISH_STATE_CONNECTING,
            RTMP_STREAM_PUBLISH_ERROR_TYPE::
                RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT);
    }
    if (event_name == nullptr || strcmp(event_name, "onRtmpStreamingEvent") == 0)
    {
        handler->onRtmpStreamingEvent(
            "123", RTMP_STREAMING_EVENT::RTMP_STREAMING_EVENT_FAILED_LOAD_IMAGE);
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamPublished") == 0)
    {
        handler->onStreamPublished("123", 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamUnpublished") == 0)
    {
        handler->onStreamUnpublished("123");
    }
    if (event_name == nullptr || strcmp(event_name, "onTranscodingUpdated") == 0)
    {
        handler->onTranscodingUpdated();
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamInjectedStatus") == 0)
    {
        handler->onStreamInjectedStatus("123", 123, INJECT_STREAM_STATUS::INJECT_STREAM_STATUS_START_FAILED);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioRouteChanged") == 0)
    {
        handler->onAudioRouteChanged(AUDIO_ROUTE_TYPE::AUDIO_ROUTE_AIRPLAY);
    }
    if (event_name == nullptr || strcmp(event_name, "onLocalPublishFallbackToAudioOnly") == 0)
    {
        handler->onLocalPublishFallbackToAudioOnly(true);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteSubscribeFallbackToAudioOnly") == 0)
    {
        handler->onRemoteSubscribeFallbackToAudioOnly(123, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteAudioTransportStats") == 0)
    {
        handler->onRemoteAudioTransportStats(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onMicrophoneEnabled") == 0)
    {
        handler->onMicrophoneEnabled(true);
    }
    if (event_name == nullptr || strcmp(event_name, "onConnectionStateChanged") == 0)
    {
        handler->onConnectionStateChanged(
            CONNECTION_STATE_TYPE::CONNECTION_STATE_CONNECTED,
            CONNECTION_CHANGED_REASON_TYPE::CONNECTION_CHANGED_BANNED_BY_SERVER);
    }
    if (event_name == nullptr || strcmp(event_name, "onNetworkTypeChanged") == 0)
    {
        handler->onNetworkTypeChanged(NETWORK_TYPE::NETWORK_TYPE_DISCONNECTED);
    }
    if (event_name == nullptr || strcmp(event_name, "onLocalUserRegistered") == 0)
    {
        handler->onLocalUserRegistered(123, "123");
    }
    if (event_name == nullptr || strcmp(event_name, "onUserInfoUpdated") == 0)
    {
        UserInfo info;
        handler->onUserInfoUpdated(123, info);
    }
    if (event_name == nullptr || strcmp(event_name, "onUploadLogResult") == 0)
    {
        handler->onUploadLogResult("123", true,
                                   UPLOAD_ERROR_REASON::UPLOAD_NET_ERROR);
    }
    if (event_name == nullptr || strcmp(event_name, "onAirPlayConnected") == 0)
    {
        handler->onAirPlayConnected();
    }
    if (event_name == nullptr || strcmp(event_name, "onVirtualBackgroundSourceEnabled") == 0)
    {
        handler->onVirtualBackgroundSourceEnabled(
            true,
            VIRTUAL_BACKGROUND_SOURCE_STATE_REASON::
                VIRTUAL_BACKGROUND_SOURCE_STATE_REASON_COLOR_FORMAT_NOT_SUPPORTED);
    }
    if (event_name == nullptr || strcmp(event_name, "onRequestAudioFileInfo") == 0)
    {
        AudioFileInfo info{};
        info.filePath = "path";
        handler->onRequestAudioFileInfo(
            info, AUDIO_FILE_INFO_ERROR::AUDIO_FILE_INFO_ERROR_FAILURE);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteVideoTransportStats") == 0)
    {
        handler->onRemoteVideoTransportStats(123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAirPlayConnected") == 0)
    {
        handler->onAirPlayConnected();
    }
    if (event_name == nullptr || strcmp(event_name, "onSnapshotTaken") == 0)
    {
        handler->onSnapshotTaken("123", 123, "path", 10, 10, 0);
    }
    if (event_name == nullptr || strcmp(event_name, "onScreenCaptureInfoUpdated") == 0)
    {
#ifdef _WIN32
        ScreenCaptureInfo info;
        info.graphicsCardType = "123";
        info.errCode = EXCLUDE_WINDOW_ERROR::EXCLUDE_WINDOW_NONE;
        handler->onScreenCaptureInfoUpdated(info);
#endif
    }
    if (event_name == nullptr || strcmp(event_name, "onClientRoleChangeFailed") == 0)
    {
        handler->onClientRoleChangeFailed(
                CLIENT_ROLE_CHANGE_FAILED_REASON::CLIENT_ROLE_CHANGE_FAILED_BY_TOO_MANY_BROADCASTERS,
                CLIENT_ROLE_TYPE::CLIENT_ROLE_BROADCASTER);
    }
    if (event_name == nullptr || strcmp(event_name, "onWlAccMessage") == 0)
    {
        handler->onWlAccMessage(WLACC_MESSAGE_REASON::WLACC_MESSAGE_REASON_WEAK_SIGNAL, WLACC_SUGGEST_ACTION::WLACC_SUGGEST_ACTION_CHECK_5G, "msg");
    }
    if (event_name == nullptr || strcmp(event_name, "onWlAccStats") == 0)
    {
        WlAccStats currentStats;
        currentStats.e2eDelayPercent = 1;
        currentStats.frozenRatioPercent = 1;
        currentStats.lossRatePercent = 1;

        WlAccStats averageStats;
        averageStats.e2eDelayPercent = 1;
        averageStats.frozenRatioPercent = 1;
        averageStats.lossRatePercent = 1;

        handler->onWlAccStats(currentStats, averageStats);
    }
    if (event_name == nullptr || strcmp(event_name, "onProxyConnected") == 0)
    {
        handler->onProxyConnected("123", 100, PROXY_TYPE::LOCAL_PROXY_TYPE, "10.0.1.11", 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioDeviceTestVolumeIndication") == 0)
    {
        handler->onAudioDeviceTestVolumeIndication(AudioDeviceTestVolumeType::AudioTestPlaybackVolume, 10);
    }
    if (event_name == nullptr || strcmp(event_name, "onContentInspectResult") == 0)
    {
        handler->onContentInspectResult(CONTENT_INSPECT_RESULT::CONTENT_INSPECT_NEUTRAL);
    }
}

void CallRtcChannelEvents(IrisRtcEnginePtr engine_ptr, const char *event_name)
{
    IrisRtcEngine *irisRtcEngine = reinterpret_cast<IrisRtcEngine *>(engine_ptr);
    IrisRtcEngineIntegrationTestDelegate *delegate = reinterpret_cast<IrisRtcEngineIntegrationTestDelegate *>(irisRtcEngine->GetDelegate());
    FakeRtcEngine *fakeRtcEngine = reinterpret_cast<FakeRtcEngine *>(delegate->fakeRtcEngine_);
    agora::rtc::IChannelEventHandler *handler = fakeRtcEngine->channel_->channel_event_handler_;

    IChannel *rtcChannel = fakeRtcEngine->channel_;
    if (event_name == nullptr || strcmp(event_name, "onChannelWarning") == 0)
    {
        handler->onChannelWarning(rtcChannel, 8, "123");
    }
    if (event_name == nullptr || strcmp(event_name, "onChannelError") == 0)
    {
        handler->onChannelError(rtcChannel, 0, "123");
    }
    if (event_name == nullptr || strcmp(event_name, "onJoinChannelSuccess") == 0)
    {
        handler->onJoinChannelSuccess(rtcChannel, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onRejoinChannelSuccess") == 0)
    {
        handler->onRejoinChannelSuccess(rtcChannel, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onLeaveChannel") == 0)
    {
        RtcStats stats;
        handler->onLeaveChannel(rtcChannel, stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onClientRoleChanged") == 0)
    {
        handler->onClientRoleChanged(rtcChannel,
                                     CLIENT_ROLE_TYPE::CLIENT_ROLE_BROADCASTER,
                                     CLIENT_ROLE_TYPE::CLIENT_ROLE_AUDIENCE);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserJoined") == 0)
    {
        handler->onUserJoined(rtcChannel, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserOffline") == 0)
    {
        handler->onUserOffline(
            rtcChannel, 123,
            USER_OFFLINE_REASON_TYPE::USER_OFFLINE_BECOME_AUDIENCE);
    }
    if (event_name == nullptr || strcmp(event_name, "onConnectionLost") == 0)
    {
        handler->onConnectionLost(rtcChannel);
    }
    if (event_name == nullptr || strcmp(event_name, "onRequestToken") == 0)
    {
        handler->onRequestToken(rtcChannel);
    }
    if (event_name == nullptr || strcmp(event_name, "onTokenPrivilegeWillExpire") == 0)
    {
        handler->onTokenPrivilegeWillExpire(rtcChannel, "123");
    }
    if (event_name == nullptr || strcmp(event_name, "onRtcStats") == 0)
    {
        RtcStats stats;
        handler->onRtcStats(rtcChannel, stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onNetworkQuality") == 0)
    {
        handler->onNetworkQuality(rtcChannel, 123, 0, 0);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteVideoStats") == 0)
    {
        RemoteVideoStats stats{};
        handler->onRemoteVideoStats(rtcChannel, stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteAudioStats") == 0)
    {
        RemoteAudioStats stats{};
        handler->onRemoteAudioStats(rtcChannel, stats);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteAudioStateChanged") == 0)
    {
        handler->onRemoteAudioStateChanged(
            rtcChannel, 123, REMOTE_AUDIO_STATE::REMOTE_AUDIO_STATE_DECODING,
            REMOTE_AUDIO_STATE_REASON::REMOTE_AUDIO_REASON_INTERNAL, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioPublishStateChanged") == 0)
    {
        handler->onAudioPublishStateChanged(
            rtcChannel, STREAM_PUBLISH_STATE::PUB_STATE_IDLE,
            STREAM_PUBLISH_STATE::PUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoPublishStateChanged") == 0)
    {
        handler->onVideoPublishStateChanged(
            rtcChannel, STREAM_PUBLISH_STATE::PUB_STATE_IDLE,
            STREAM_PUBLISH_STATE::PUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onAudioSubscribeStateChanged") == 0)
    {
        handler->onAudioSubscribeStateChanged(
            rtcChannel, 123, STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE,
            STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoSubscribeStateChanged") == 0)
    {
        handler->onVideoSubscribeStateChanged(
            rtcChannel, 123, STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE,
            STREAM_SUBSCRIBE_STATE::SUB_STATE_IDLE, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onUserSuperResolutionEnabled") == 0)
    {
        handler->onUserSuperResolutionEnabled(
            rtcChannel, 123, true,
            SUPER_RESOLUTION_STATE_REASON::SR_STATE_REASON_DEVICE_NOT_SUPPORTED);
    }
    if (event_name == nullptr || strcmp(event_name, "onActiveSpeaker") == 0)
    {
        handler->onActiveSpeaker(rtcChannel, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onVideoSizeChanged") == 0)
    {
        handler->onVideoSizeChanged(rtcChannel, 123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteVideoStateChanged") == 0)
    {
        handler->onRemoteVideoStateChanged(
            rtcChannel, 123, REMOTE_VIDEO_STATE::REMOTE_VIDEO_STATE_DECODING,
            REMOTE_VIDEO_STATE_REASON::REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK,
            123);
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamMessage") == 0)
    {
        char data[1] = {'\0'};
        handler->onStreamMessage(rtcChannel, 123, 123, data, sizeof(data));
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamMessageError") == 0)
    {
        handler->onStreamMessageError(rtcChannel, 123, 123, 123, 123, 123);
    }
    if (event_name == nullptr || strcmp(event_name, "onChannelMediaRelayStateChanged") == 0)
    {
        handler->onChannelMediaRelayStateChanged(
            rtcChannel, CHANNEL_MEDIA_RELAY_STATE::RELAY_STATE_CONNECTING,
            CHANNEL_MEDIA_RELAY_ERROR::RELAY_ERROR_DEST_TOKEN_EXPIRED);
    }
    if (event_name == nullptr || strcmp(event_name, "onChannelMediaRelayEvent") == 0)
    {
        handler->onChannelMediaRelayEvent(
            rtcChannel, CHANNEL_MEDIA_RELAY_EVENT::RELAY_EVENT_NETWORK_CONNECTED);
    }
    if (event_name == nullptr || strcmp(event_name, "onRtmpStreamingStateChanged") == 0)
    {
        handler->onRtmpStreamingStateChanged(
            rtcChannel, "123",
            RTMP_STREAM_PUBLISH_STATE::RTMP_STREAM_PUBLISH_STATE_CONNECTING,
            RTMP_STREAM_PUBLISH_ERROR_TYPE::
                RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT);
    }
    if (event_name == nullptr || strcmp(event_name, "onRtmpStreamingEvent") == 0)
    {
        handler->onRtmpStreamingEvent(
            rtcChannel, "123",
            RTMP_STREAMING_EVENT::RTMP_STREAMING_EVENT_FAILED_LOAD_IMAGE);
    }
    if (event_name == nullptr || strcmp(event_name, "onTranscodingUpdated") == 0)
    {
        handler->onTranscodingUpdated(rtcChannel);
    }
    if (event_name == nullptr || strcmp(event_name, "onStreamInjectedStatus") == 0)
    {
        handler->onStreamInjectedStatus(rtcChannel, "123", 123, INJECT_STREAM_STATUS::INJECT_STREAM_STATUS_START_SUCCESS);
    }
    if (event_name == nullptr || strcmp(event_name, "onLocalPublishFallbackToAudioOnly") == 0)
    {
        handler->onLocalPublishFallbackToAudioOnly(rtcChannel, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onRemoteSubscribeFallbackToAudioOnly") == 0)
    {
        handler->onRemoteSubscribeFallbackToAudioOnly(rtcChannel, 123, true);
    }
    if (event_name == nullptr || strcmp(event_name, "onConnectionStateChanged") == 0)
    {
        handler->onConnectionStateChanged(
            rtcChannel, CONNECTION_STATE_TYPE::CONNECTION_STATE_CONNECTED,
            CONNECTION_CHANGED_REASON_TYPE::CONNECTION_CHANGED_BANNED_BY_SERVER);
    }
    if (event_name == nullptr || strcmp(event_name, "onClientRoleChangeFailed") == 0)
    {
        handler->onClientRoleChangeFailed(
                rtcChannel,
                CLIENT_ROLE_CHANGE_FAILED_REASON::CLIENT_ROLE_CHANGE_FAILED_BY_TOO_MANY_BROADCASTERS,
                CLIENT_ROLE_TYPE::CLIENT_ROLE_BROADCASTER);
    }
}
