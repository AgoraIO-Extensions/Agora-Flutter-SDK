/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <string>

#include "common.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

struct RtcStats {};

enum USER_OFFLINE_REASON_TYPE {};

struct IRtcEngineEventHandler {
  // When a local user successfully joins the channel, this callback is
  // triggered.
  virtual void onJoinChannelSuccess(const char *channel, uid_t uid,
                                    int elapsed);

  // When the local host successfully leaves the channel, this callback is
  // triggered.
  virtual void onLeaveChannel(const RtcStats &stat);

  // When a remote host successfully joins the channel, this callback is
  // triggered. Upon receiving this callback, you need to immediately call
  // setupRemoteVideo to set up the remote host's view.
  virtual void onUserJoined(uid_t uid, int elapsed);

  // When a remote host leaves the channel or disconnects, this callback is
  // triggered.
  virtual void onUserOffline(uid_t uid, USER_OFFLINE_REASON_TYPE reason);
};

// 繼承 IRtcEngineEventHandler 類中的回呼與事件
struct SampleEngineEventHandler : public IRtcEngineEventHandler {
  SampleEngineEventHandler() = default;
  virtual ~SampleEngineEventHandler() = default;

  SampleEngineEventHandler(const SampleEngineEventHandler &) = delete;
  SampleEngineEventHandler &operator=(const SampleEngineEventHandler &) =
      delete;

  SampleEngineEventHandler(SampleEngineEventHandler &&) = delete;
  SampleEngineEventHandler &operator=(SampleEngineEventHandler &&) = delete;
};

struct RtcEngineContext {
  IRtcEngineEventHandler *eventHandler;
  std::string appId;
};

enum RENDER_MODE_TYPE {
  RENDER_MODE_HIDDEN,
  RENDER_MODE_FIT,
};

struct VideoCanvas {
  uid_t uid;
  void *view;
  RENDER_MODE_TYPE renderMode;
};

enum VIDEO_CODEC_TYPE { VIDEO_CODEC_SOME };

struct VideoEncoderConfiguration {
  VIDEO_CODEC_TYPE codecType;
};

enum CHANNEL_PROFILE { CHANNEL_PROFILE_LIVE_BROADCASTING };

enum CLIENT_ROLE_TYPE { CLIENT_ROLE_TYPE_BROADCASTER };

struct ChannelMediaOptions {
  CHANNEL_PROFILE channelProfile;
  CLIENT_ROLE_TYPE clientRoleType;

  bool autoSubscribeAudio;
  bool autoSubscribeVideo;
};

struct IRtcEngine {
  void initialize(RtcEngineContext &ctx);
  void release(bool some_param);

  void enableVideo();
  void disableVideo();

  void startPreview();
  void stopPreview();

  void setupLocalVideo(VideoCanvas &canvas);
  void setupRemoteVideo(VideoCanvas &canvas);

  void setVideoEncoderConfiguration(VideoEncoderConfiguration &config);

  int joinChannel(const char *app_id, const char *channel_name, int uid,
                  ChannelMediaOptions &options);
  int leaveChannel();
};

AGORA_RTE_API_C IRtcEngine *createAgoraRtcEngine();

#ifdef __cplusplus
}
#endif  // __cplusplus
