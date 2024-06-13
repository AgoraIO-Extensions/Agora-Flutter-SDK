/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include "handle.h"
#include "common.h"
#include "metadata.h"
#include "observer.h"
#include "utils/string.h"
#include "track/track.h"
#include "utils/buf.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

typedef struct RteTrack RteTrack;
typedef struct RteUser RteUser;
typedef struct RteStream RteStream;
typedef struct Rte Rte;
typedef struct RteLocalStream RteLocalStream;
typedef struct RteLocalStreamInfo RteLocalStreamInfo;
typedef struct RteRemoteStream RteRemoteStream;
typedef struct RteRemoteStreamInfo RteRemoteStreamInfo;

typedef enum RteChannelType {
  kRteChannelTypeDefault,
} RteChannelType;

typedef enum RteLocalUserRtcRole {
  kRteLocalUserRtcRoleBroadcaster,
  kRteLocalUserRtcRoleAudience,
} RteLocalUserRtcRole;

typedef enum RteChannelConnectionState {
  kRteChannelConnectionStateDisconnected,
  kRteChannelConnectionStateDisconnecting,
  kRteChannelConnectionStateConnecting,
  kRteChannelConnectionStateConnected,
  kRteChannelConnectionStateReconnecting,
  kRteChannelConnectionStateFailed
} RteChannelConnectionState;

typedef enum RteChannelConnectionStateChangedReason {
  kRteChannelConnectionStateChangedReasonConnecting,
  kRteChannelConnectionStateChangedReasonSuccess,
  kRteChannelConnectionStateChangedReasonInterrupted,
  kRteChannelConnectionStateChangedReasonBannedByServer,
  kRteChannelConnectionStateChangedReasonJoinFailed,
  kRteChannelConnectionStateChangedReasonLeaveChannel,
  kRteChannelConnectionStateChangedReasonInvalidAppId,
  kRteChannelConnectionStateChangedReasonInvalidChannelName,
  kRteChannelConnectionStateChangedReasonInvalidToken,
  kRteChannelConnectionStateChangedReasonTokenExpired,
  kRteChannelConnectionStateChangedReasonRejectedByServer,
  kRteChannelConnectionStateChangedReasonSettingProxyServer,
  kRteChannelConnectionStateChangedReasonRenewToken,
  kRteChannelConnectionStateChangedReasonClientIpChanged,
  kRteChannelConnectionStateChangedReasonKeepAliveTimeout,
  kRteChannelConnectionStateChangedReasonRejoinSuccess,
  kRteChannelConnectionStateChangedReasonLost,
  kRteChannelConnectionStateChangedReasonEchoTest,
  kRteChannelConnectionStateChangedReasonClientIpChangedByUser,
  kRteChannelConnectionStateChangedReasonSameUidLogin,
  kRteChannelConnectionStateChangedReasonTooManyBroadcasters,
  kRteChannelConnectionStateChangedReasonLicenseValidationFailure,
  kRteChannelConnectionStateChangedReasonCertificationVerifyFailure,
  kRteChannelConnectionStateChangedReasonStreamChannelNotAvailable,
  kRteChannelConnectionStateChangedReasonInconsistentAppId
} RteChannelConnectionStateChangedReason;

typedef enum RteTrackSubState {
  kRteTrackSubStateSubscribing,
  kRteTrackSubStateSubscribed,
  kRteTrackSubStateNotSubscribed
} RteTrackSubState;

typedef enum RteTrackSubStateChangedReason {
  kRteTrackSubStateChangedReasonRemotePublished,
  kRteTrackSubStateChangedReasonRemoteUnpublished,
  kRteTrackSubStateChangedReasonLocalSubscribed,
  kRteTrackSubStateChangedReasonLocalUnsubscribed
} RteTrackSubStateChangedReason;

typedef enum RteTrackPubState {
  kRteTrackPubStatePublishing,
  kRteTrackPubStatePublished,
  kRteTrackPubStateNotPublished
} RteTrackPubState;

typedef enum RteTrackPubStateChangedReason {
  kRteTrackPubStateChangedReasonLocalPublished,
  kRteTrackPubStateChangedReasonLocalUnpublished
} RteTrackPubStateChangedReason;

typedef struct RteStateItem {
  RteString *key;
  RteString *value;
} RteStateItem;

typedef struct RteState {
  RteString *name;
  RteStateItem *items;
  size_t items_cnt;
} RteState;

typedef struct RteLock {
  RteString *lock_name;
  RteString *owner;
  uint32_t ttl;
} RteLock;

typedef enum RteLockChangedEvent {
  kRteLockChangedEventSet,
  kRteLockChangedEventRemoved,
  kRteLockChangedEventAcquired,
  kRteLockChangedEventReleased,
  kRteLockChangedEventExpired
} RteLockChangedEvent;

typedef struct RteChannelConfig {
  RteString *channel_id;
  bool has_channel_id;

  RteChannelType type;
  bool has_type;

  bool is_user_id_integer_only;
  bool has_is_user_id_integer_only;

  bool is_user_id_same_as_stream_id;
  bool has_is_useR_id_same_as_stream_id;

  RteLocalUserRtcRole local_user_rtc_role;
  bool has_local_user_rtc_role;

  bool auto_subscribe_audio;
  bool has_auto_subscribe_audio;

  bool auto_subscribe_video;
  bool has_auto_subscribe_video;

  RteString *json_parameter;
  bool has_json_parameter;
} RteChannelConfig;

typedef struct RteChannelObserver RteChannelObserver;
struct RteChannelObserver {
  RteBaseObserver base_observer;

  void (*on_remote_stream_added)(RteChannelObserver *self,
                                 RteRemoteStream *stream, RteRemoteUser *user);
  void (*on_local_stream_info)(RteChannelObserver *self, RteLocalStream *stream,
                               RteLocalStreamInfo *info);
  void (*on_remote_stream_info)(RteChannelObserver *self,
                                RteRemoteStream *stream,
                                RteRemoteStreamInfo *info);
  void (*on_channel_message_received)(RteChannelObserver *self,
                                      RteString publisher, RteBuf *message);
};

typedef struct RteSubscribeOptions {
  RteTrackMediaType track_media_type;
  RteString *data_track_topic;
} RteSubscribeOptions;

AGORA_RTE_API_C void RteStateItemInit(RteStateItem *self, RteError *err);
AGORA_RTE_API_C void RteStateItemDeinit(RteStateItem *self, RteError *err);
// @}

// @{
// Config
AGORA_RTE_API_C void RteChannelConfigInit(RteChannelConfig *config,
                                         RteError *err);
AGORA_RTE_API_C void RteChannelConfigDeinit(RteChannelConfig *config,
                                           RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetChannelId(RteChannelConfig *self,
                                                 const char *channel_id,
                                                 RteError *err);
AGORA_RTE_API_C void RteChannelConfigGetChannelId(RteChannelConfig *self,
                                                 RteString *channel_id,
                                                 RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetChannelType(RteChannelConfig *self,
                                                   RteChannelType type,
                                                   RteError *err);
AGORA_RTE_API_C void RteChannelConfigGetChannelType(RteChannelConfig *self,
                                                   RteChannelType *type,
                                                   RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetIsUserIdIntegerOnly(
    RteChannelConfig *self, bool is_user_id_integer_only, RteError *err);

AGORA_RTE_API_C void RteChannelConfigGetIsUserIdIntegerOnly(
    RteChannelConfig *self, bool *is_user_id_integer_only, RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetIsUserIdSameAsStreamId(
    RteChannelConfig *self, bool is_user_id_same_as_stream_id, RteError *err);
AGORA_RTE_API_C void RteChannelConfigGetIsUserIdSameAsStreamId(
    RteChannelConfig *self, bool *is_user_id_same_as_stream_id, RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetLocalUserRtcRole(
    RteChannelConfig *self, RteLocalUserRtcRole local_user_rtc_role,
    RteError *err);
AGORA_RTE_API_C void RteChannelConfigGetLocalUserRtcRole(
    RteChannelConfig *self, RteLocalUserRtcRole *local_user_rtc_role,
    RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetAutoSubscribeAudio(
    RteChannelConfig *self, bool auto_subscribe_audio, RteError *err);
AGORA_RTE_API_C void RteChannelConfigGetAutoSubscribeAudio(
    RteChannelConfig *self, bool *auto_subscribe_audio, RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetAutoSubscribeVideo(
    RteChannelConfig *self, bool auto_subscribe_video, RteError *err);
AGORA_RTE_API_C void RteChannelConfigGetAutoSubscribeVideo(
    RteChannelConfig *self, bool *auto_subscribe_video, RteError *err);

AGORA_RTE_API_C void RteChannelConfigSetJsonParameter(RteChannelConfig *self,
                                                     RteString *json_parameter,
                                                     RteError *err);
AGORA_RTE_API_C void RteChannelConfigGetJsonParameter(RteChannelConfig *self,
                                                     RteString *json_parameter,
                                                     RteError *err);
// @}

// @{
// Observer
AGORA_RTE_API_C RteChannelObserver *RteChannelObserverCreate(RteError *err);
AGORA_RTE_API_C void RteChannelObserverDestroy(RteChannelObserver *self,
                                              RteError *err);
AGORA_RTE_API_C RteChannel
RteChannelObserverGetEventSrc(RteChannelObserver *self, RteError *err);
// @}

AGORA_RTE_API_C RteChannel RteChannelCreate(Rte *self, RteChannelConfig *config,
                                           RteError *err);
AGORA_RTE_API_C void RteChannelDestroy(RteChannel *channel, RteError *err);

AGORA_RTE_API_C void RteChannelGetConfigs(RteChannel *self,
                                         RteChannelConfig *config,
                                         RteError *err);
AGORA_RTE_API_C void RteChannelSetConfigs(
    RteChannel *self, RteChannelConfig *config,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RteChannelPublishStream(
    RteChannel *self, RteLocalUser *user, RteLocalStream *stream,
    void (*cb)(RteChannel *self, RteLocalStream *stream, void *cb_data,
               RteError *err),
    void *cb_data);
AGORA_RTE_API_C void RteChannelUnpublishStream(
    RteChannel *self, RteLocalStream *stream,
    void (*cb)(RteChannel *self, RteLocalStream *stream, void *cb_data,
               RteError *err),
    void *cb_data);

AGORA_RTE_API_C void RteChannelSubscribeTrack(
    RteChannel *self, RteRemoteStream *stream, RteSubscribeOptions *options,
    void (*cb)(RteChannel *self, RteTrack *track, void *cb_data, RteError *err),
    void *cb_data);

AGORA_RTE_API_C bool RteChannelRegisterObserver(
    RteChannel *self, RteChannelObserver *observer, RteError *err);

AGORA_RTE_API_C RteUser RteChannelGetLocalUser(RteChannel *self, RteError *err);
AGORA_RTE_API_C size_t RteChannelGetRemoteUsersCount(RteChannel *self,
                                                    RteError *err);
AGORA_RTE_API_C void RteChannelGetRemoteUsers(RteChannel *self,
                                             RteRemoteUser *remote_users,
                                             size_t start_idx,
                                             size_t remote_users_cnt,
                                             RteError *err);

AGORA_RTE_API_C void RteChannelJoin(RteChannel *self, RteLocalUser *user,
                                   RteString *channel_token,
                                   void (*cb)(RteChannel *self,
                                              RteLocalUser *user, void *cb_data,
                                              RteError *err),
                                   void *cb_data);
AGORA_RTE_API_C void RteChannelLeave(RteChannel *self, RteLocalUser *user,
                                    void (*cb)(RteChannel *self,
                                               RteLocalUser *user,
                                               void *cb_data, RteError *err),
                                    void *cb_data);

AGORA_RTE_API_C void RteChannelRenewToken(
    RteChannel *self, RteString *channel_token,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RteChannelPublishMessage(
    RteChannel *self, RteBuf *message,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelSubscribeMessage(
    RteChannel *self,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelUnsubscribeMessage(
    RteChannel *self,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RteChannelGetMetadata(RteChannel *self,
                                          void (*cb)(RteChannel *self,
                                                     RteMetadata *items,
                                                     void *cb_data,
                                                     RteError *err),
                                          void *cb_data);
AGORA_RTE_API_C void RteChannelSubscribeMetadata(
    RteChannel *self,
    void (*cb)(RteChannel *self, RteMetadata *items, size_t items_cnt,
               void *cb_data, RteError *err),
    void *cb_data);
AGORA_RTE_API_C void RteChannelUnsubscribeMetadata(
    RteChannel *self,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelRemoveMetadata(
    RteChannel *self, RteMetadata *items,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RteChannelGetUserState(
    RteChannel *self, RteString *user_name,
    void (*cb)(RteChannel *self, RteState *state, void *cb_data, RteError *err),
    void *cb_data);
AGORA_RTE_API_C void RteChannelSetUserState(
    RteChannel *self, RteState *state,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelRemoveUserState(
    RteChannel *self, RteString *key,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelSubscribeUserState(
    RteChannel *self,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelUnsubscribeUserState(
    RteChannel *self,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C void RteChannelSetLock(
    RteChannel *self, RteString *lock_name, uint32_t ttl,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelRemoveLock(
    RteChannel *self, RteString *lock_name,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelGetLocks(RteChannel *self,
                                       void (*cb)(RteChannel *self,
                                                  RteLock *locks,
                                                  size_t locks_cnt,
                                                  void *cb_data, RteError *err),
                                       void *cb_data);
AGORA_RTE_API_C void RteChannelSubscribeLocks(
    RteChannel *self,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelUnsubscribeLocks(
    RteChannel *self,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);
AGORA_RTE_API_C void RteChannelAcquireLock(
    RteChannel *self, RteString *lock_name, bool retry,
    void (*cb)(RteChannel *self, RteString owner, void *cb_data, RteError *err),
    void *cb_data);
AGORA_RTE_API_C void RteChannelReleaseLock(
    RteChannel *self, RteString *lock_name,
    void (*cb)(RteChannel *self, void *cb_data, RteError *err), void *cb_data);

AGORA_RTE_API_C size_t RteChannelGetLocalStreamsCount(RteChannel *self,
                                                     RteError *err);
AGORA_RTE_API_C void RteChannelGetLocalStreams(RteChannel *self,
                                              RteLocalStream *streams,
                                              size_t start_idx,
                                              size_t streams_cnt,
                                              RteError *err);

AGORA_RTE_API_C size_t RteChannelGetRemoteStreamsCount(RteChannel *self,
                                                      RteError *err);
AGORA_RTE_API_C void RteChannelGetRemoteStreams(
    RteChannel *self, RteRemoteUser *user, RteRemoteStream *streams,
    size_t start_idx, size_t streams_cnt, RteError *err);

#ifdef __cplusplus
}
#endif  // __cplusplus
