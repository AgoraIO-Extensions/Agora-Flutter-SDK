// Copyright (c) 2022 Agora.io. All rights reserved

// This program is confidential and proprietary to Agora.io.
// And may not be copied, reproduced, modified, disclosed to others, published
// or used, in whole or in part, without the express prior written permission
// of Agora.io.

#pragma once  // NOLINT(build/header_guard)

#include "IAgoraLog.h"
#include "IAgoraStreamChannel.h"
#include "AgoraBase.h"

#ifndef OPTIONAL_ENUM_CLASS
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
#define OPTIONAL_ENUM_CLASS enum class
#else
#define OPTIONAL_ENUM_CLASS enum
#endif
#endif

namespace agora {
namespace rtm {
class IRtmEventHandler;

/**
 *  Configurations for RTM Client.
 */
struct RtmConfig {
  /**
   * The App ID of your project.
   */
  const char* appId;

  /**
   * The ID of the user.
   */
  const char* userId;

  /**
   * The callbacks handler
   */
  IRtmEventHandler* eventHandler;

  /**
   * The config for customer set log path, log size and log level.
   */
  commons::LogConfig logConfig;

  RtmConfig() : appId(nullptr),
                userId(nullptr),
                eventHandler(nullptr) {}
};

/**
 *  The information of a Topic.
 */
struct TopicInfo {
  /**
   * The name of the topic.
   */
  const char* topic;

  /**
   * The number of publisher in current topic.
   */
  size_t numOfPublisher;

  /**
   * The publisher's user ids in current topic.
   */
  const char** publisherUserIds;

  /**
   * The metaData of publisher in current topic.
   */
  const char** publisherMetas;

  TopicInfo() : topic(NULL),
                numOfPublisher(0),
                publisherUserIds(NULL),
                publisherMetas(NULL) {}
};

/**
 * The error codes of rtm client.
 */
enum RTM_ERROR_CODE {
  /**
   * 10001: The topic already joined
   */
  RTM_ERR_TOPIC_ALREADY_JOINED = 10001,
  /**
   * 10002: Exceed topic limiation when try to join new topic
   */
  RTM_ERR_EXCEED_JOIN_TOPIC_LIMITATION = 10002,
  /**
   * 10003: Topic name is invalid
   */
  RTM_ERR_INVALID_TOPIC_NAME = 10003,
  /**
   * 10004: Publish topic message failed
   */
  RTM_ERR_PUBLISH_TOPIC_MESSAGE_FAILED = 10004,
  /**
   * 10005: Exceed topic limitation when try to subscribe new topic
   */
  RTM_ERR_EXCEED_SUBSCRIBE_TOPIC_LIMITATION = 10005,
  /**
   * 10006: Exceed user limitation when try to subscribe new topic
   */
  RTM_ERR_EXCEED_USER_LIMITATION = 10006,
  /**
   * 10007: Exceed channel limitation when try to join new channel
   */
  RTM_ERR_EXCEED_CHANNEL_LIMITATION = 10007,
  /**
   * 10008: The channel already joined
   */
  RTM_ERR_ALREADY_JOIN_CHANNEL = 10008,
  /**
   * 10009: Try to perform channel related operation before joining channel
   */
  RTM_ERR_NOT_JOIN_CHANNEL = 10009,
};

/**
 * Connection states between rtm sdk and agora server.
 */
enum RTM_CONNECTION_STATE {
  /**
   * 1: The SDK is disconnected with server.
   */
  RTM_CONNECTION_STATE_DISCONNECTED = 1,
  /**
   * 2: The SDK is connecting to the server.
   */
  RTM_CONNECTION_STATE_CONNECTING = 2,
  /**
   * 3: The SDK is connected to the server and has joined a channel. You can now publish or subscribe to
   * a track in the channel.
   */
  RTM_CONNECTION_STATE_CONNECTED = 3,
  /**
   * 4: The SDK keeps rejoining the channel after being disconnected from the channel, probably because of
   * network issues.
   */
  RTM_CONNECTION_STATE_RECONNECTING = 4,
  /**
   * 5: The SDK fails to connect to the server or join the channel.
   */
  RTM_CONNECTION_STATE_FAILED = 5,
};

/**
 * Reasons for connection state change.
 */
enum RTM_CONNECTION_CHANGE_REASON {
  /**
   * 0: The SDK is connecting to the server.
   */
  RTM_CONNECTION_CHANGED_CONNECTING = 0,
  /**
   * 1: The SDK has joined the channel successfully.
   */
  RTM_CONNECTION_CHANGED_JOIN_SUCCESS = 1,
  /**
   * 2: The connection between the SDK and the server is interrupted.
   */
  RTM_CONNECTION_CHANGED_INTERRUPTED = 2,
  /**
   * 3: The connection between the SDK and the server is banned by the server.
   */
  RTM_CONNECTION_CHANGED_BANNED_BY_SERVER = 3,
  /**
   * 4: The SDK fails to join the channel for more than 20 minutes and stops reconnecting to the channel.
   */
  RTM_CONNECTION_CHANGED_JOIN_FAILED = 4,
  /**
   * 5: The SDK has left the channel.
   */
  RTM_CONNECTION_CHANGED_LEAVE_CHANNEL = 5,
  /**
   * 6: The connection fails because the App ID is not valid.
   */
  RTM_CONNECTION_CHANGED_INVALID_APP_ID = 6,
  /**
   * 7: The connection fails because the channel name is not valid.
   */
  RTM_CONNECTION_CHANGED_INVALID_CHANNEL_NAME = 7,
  /**
   * 8: The connection fails because the token is not valid.
   */
  RTM_CONNECTION_CHANGED_INVALID_TOKEN = 8,
  /**
   * 9: The connection fails because the token has expired.
   */
  RTM_CONNECTION_CHANGED_TOKEN_EXPIRED = 9,
  /**
   * 10: The connection is rejected by the server.
   */
  RTM_CONNECTION_CHANGED_REJECTED_BY_SERVER = 10,
  /**
   * 11: The connection changes to reconnecting because the SDK has set a proxy server.
   */
  RTM_CONNECTION_CHANGED_SETTING_PROXY_SERVER = 11,
  /**
   * 12: When the connection state changes because the app has renewed the token.
   */
  RTM_CONNECTION_CHANGED_RENEW_TOKEN = 12,
  /**
   * 13: The IP Address of the app has changed. A change in the network type or IP/Port changes the IP
   * address of the app.
   */
  RTM_CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED = 13,
  /**
   * 14: A timeout occurs for the keep-alive of the connection between the SDK and the server.
   */
  RTM_CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT = 14,
  /**
   * 15: The SDK has rejoined the channel successfully.
   */
  RTM_CONNECTION_CHANGED_REJOIN_SUCCESS = 15,
  /**
   * 16: The connection between the SDK and the server is lost.
   */
  RTM_CONNECTION_CHANGED_LOST = 16,
  /**
   * 17: The change of connection state is caused by echo test.
   */
  RTM_CONNECTION_CHANGED_ECHO_TEST = 17,
  /**
   * 18: The local IP Address is changed by user.
   */
  RTM_CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED_BY_USER = 18,
  /**
   * 19: The connection is failed due to join the same channel on another device with the same uid.
   */
  RTM_CONNECTION_CHANGED_SAME_UID_LOGIN = 19,
  /**
   * 20: The connection is failed due to too many broadcasters in the channel.
   */
  RTM_CONNECTION_CHANGED_TOO_MANY_BROADCASTERS = 20,
};

/**
 * RTM channel type.
 */
enum RTM_CHANNEL_TYPE {
  /**
   * 0: Message channel.
   */
  RTM_CHANNEL_TYPE_MESSAGE = 0,
  /**
   * 1: Stream channel.
   */
  RTM_CHANNEL_TYPE_STREAM = 1,
};

/**
 * RTM presence type.
 */
enum RTM_PRESENCE_TYPE {
  /**
   * 0: Triggered when remote user join channel
   */
  RTM_PRESENCE_TYPE_REMOTE_JOIN_CHANNEL = 0,
  /**
   * 1: Triggered when remote leave join channel
   */
  RTM_PRESENCE_TYPE_REMOTE_LEAVE_CHANNEL = 1,
  /**
   * 2: Triggered when remote user's connection timeout
   */
  RTM_PRESENCE_TYPE_REMOTE_CONNECTION_TIMEOUT = 2,
  /**
   * 3: Triggered when remote user join a topic
   */
  RTM_PRESENCE_TYPE_REMOTE_JOIN_TOPIC = 3,
  /**
   * 4: Triggered when remote user leave a topic
   */
  RTM_PRESENCE_TYPE_REMOTE_LEAVE_TOPIC = 4,
  /**
   * 5: Triggered when local user join channel
   */
  RTM_PRESENCE_TYPE_SELF_JOIN_CHANNEL = 5,
};

/**
 * RTM error code occurs in stream channel.
 */
enum STREAM_CHANNEL_ERROR_CODE {
  /**
   * 0: No error occurs.
   */
  STREAM_CHANNEL_ERROR_OK = 0,
  /**
   * 1: Triggered when subscribe user exceed limitation
   */
  STREAM_CHANNEL_ERROR_EXCEED_LIMITATION = 1,
  /**
   * 2: Triggered when unsubscribe inexistent user
   */
  STREAM_CHANNEL_ERROR_USER_NOT_EXIST = 2,
};

/**
 * The IRtmEventHandler class.
 *
 * The SDK uses this class to send callback event notifications to the app, and the app inherits
 * the methods in this class to retrieve these event notifications.
 *
 * All methods in this class have their default (empty)  implementations, and the app can inherit
 * only some of the required events instead of all. In the callback methods, the app should avoid
 * time-consuming tasks or calling blocking APIs, otherwise the SDK may not work properly.
 */
class IRtmEventHandler {
 public:
  virtual ~IRtmEventHandler() {}

  struct MessageEvent {
    /**
     * Which channel type, RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE
     */
    RTM_CHANNEL_TYPE channelType;
    /**
     * The channel which the message was published
     */
    const char* channelName;
    /**
     * If the channelType is RTM_CHANNEL_TYPE_STREAM, which topic the message came from. only for RTM_CHANNEL_TYPE_STREAM
     */
    const char* channelTopic;
    /**
     * The payload
     */
    const char* message;
    /**
     * The payload length
     */
    size_t messageLength;
    /**
     * The publisher
     */
    const char* publisher;

    MessageEvent() : channelType(RTM_CHANNEL_TYPE_STREAM),
                     channelName(nullptr),
                     channelTopic(nullptr),
                     message(nullptr),
                     publisher(nullptr) {}
  };

  struct PresenceEvent {
    /**
     * Which channel type, RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE
     */
    RTM_CHANNEL_TYPE channelType;
    /**
     * Indicate presence type
     */
    RTM_PRESENCE_TYPE type;
    /**
     * The channel which the presence event was triggered
     */
    const char* channelName;
    /**
     * Topic information array.
     */
    TopicInfo* topicInfos;
    /**
     * The number of topicInfos.
     */
    size_t topicInfoNumber;
    /**
     * The user who triggered this event.
     */
    const char* userId;

    PresenceEvent() : channelType(RTM_CHANNEL_TYPE_STREAM),
                      type(RTM_PRESENCE_TYPE_REMOTE_JOIN_CHANNEL),
                      channelName(nullptr),
                      topicInfos(nullptr),
                      topicInfoNumber(0),
                      userId(nullptr) {}
  };

  /**
   * Occurs when receive a message.
   *
   * @param event details of message event.
   */
  virtual void onMessageEvent(MessageEvent& event) {}

  /**
   * Occurs when remote user join/leave channel, join/leave topic or local user joined channel.
   *
   * note:
   * When remote user join/leave channel will trigger this callback.
   * When remote user(in same channel) joinTopic/destroy Topic will trigger this callback.
   * When local user join channel will trigger this callback.
   *
   * For type(RTM_PRESENCE_TYPE_REMOTE_JOIN_CHANNEL/RTM_PRESENCE_TYPE_REMOTE_LEAVE_CHANNEL),
   * valid field will be channelType/type/channelName/userId
   * For type(RTM_PRESENCE_TYPE_REMOTE_JOIN_TOPIC/RTM_PRESENCE_TYPE_REMOTE_LEAVE_TOPIC)
   * valid field will be channelType/type/channelName/topicInfos/topicInfoNumber
   * For type(RTM_PRESENCE_TYPE_SELF_JOIN_CHANNEL)
   * valid field will be channelType/type/channelName/topicInfos/topicInfoNumber/userId
   * 
   * @param event details of presence event.
   */
  virtual void onPresenceEvent(PresenceEvent& event) {}

  /**
   * Occurs when user join a channel.
   *
   * @param channelName The Name of the channel.
   * @param userId The id of the user.
   * @param errorCode The error code.
   */
  virtual void onJoinResult(const char* channelName, const char* userId, STREAM_CHANNEL_ERROR_CODE errorCode) {}

  /**
   * Occurs when user leave a channel.
   *
   * @param channelName The Name of the channel.
   * @param userId The id of the user.
   * @param errorCode The error code.
   */
  virtual void onLeaveResult(const char* channelName, const char* userId, STREAM_CHANNEL_ERROR_CODE errorCode) {}

  /**
   * Occurs when user join topic.
   *
   * @param channelName The Name of the channel.
   * @param userId The id of the user.
   * @param topic The name of the topic.
   * @param meta The meta of the topic.
   * @param errorCode The error code.
   */
  virtual void onJoinTopicResult(const char* channelName, const char* userId, const char* topic, const char* meta, STREAM_CHANNEL_ERROR_CODE errorCode) {}

  /**
   * Occurs when user leave topic.
   *
   * @param channelName The Name of the channel.
   * @param userId The id of the user.
   * @param topic The name of the topic.
   * @param meta The meta of the topic.
   * @param errorCode The error code.
   */
  virtual void onLeaveTopicResult(const char* channelName, const char* userId, const char* topic, const char* meta, STREAM_CHANNEL_ERROR_CODE errorCode) {}

  /**
   * Occurs when user subscribe topic.
   *
   * @param channelName The Name of the channel.
   * @param userId The id of the user.
   * @param topic The name of the topic.
   * @param succeedUsers The subscribed users.
   * @param failedUser The failed to subscribe users.
   * @param errorCode The error code.
   */
  virtual void onTopicSubscribed(const char* channelName, const char* userId, const char* topic, UserList succeedUsers, UserList failedUsers, STREAM_CHANNEL_ERROR_CODE errorCode) {}

  /**
   * Occurs when user unsubscribe topic.
   *
   * @param channelName The Name of the channel.
   * @param userId The id of the user.
   * @param topic The name of the topic.
   * @param succeedUsers The unsubscribed users.
   * @param failedUser The failed to unsubscribe users.
   * @param errorCode The error code.
   */
  virtual void onTopicUnsubscribed(const char* channelName, const char* userId, const char* topic, UserList succeedUsers, UserList failedUsers, STREAM_CHANNEL_ERROR_CODE errorCode) {}

  /**
   * Occurs when the connection state changes between rtm sdk and agora service.
   *
   * @param channelName The Name of the channel.
   * @param state The new connection state.
   * @param reason The reason for the connection state change.
   */
  virtual void onConnectionStateChange(const char* channelName, RTM_CONNECTION_STATE state, RTM_CONNECTION_CHANGE_REASON reason) {}
};

/**
 * The IRtmClient class.
 *
 * This class provides the main methods that can be invoked by your app.
 *
 * IRtmClient is the basic interface class of the Agora RTM SDK.
 * Creating an IRtmClient object and then calling the methods of
 * this object enables you to use Agora RTM SDK's functionality.
 */
class IRtmClient {
 public:
    /**
     * Initializes the rtm client instance.
     *
     * @param [in] config The configurations for RTM Client.
     * @param [in] eventHandler .
     * @return
     * - 0: Success.
     * - < 0: Failure.
     */
  virtual int initialize(const RtmConfig& config) = 0;
  /**
   * Release the rtm client instance.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int release() = 0;

  /**
   * Create a stream channel instance.
   *
   * @param [in] channelName The Name of the channel.
   */
  virtual IStreamChannel* createStreamChannel(const char* channelName) = 0;

 protected:
  virtual ~IRtmClient() {}
};

/** Creates the rtm client object and returns the pointer.

* @return Pointer of the rtm client object.
*/
AGORA_API IRtmClient* AGORA_CALL createAgoraRtmClient();

}  // namespace rtm
}  // namespace agora
