
// Copyright (c) 2022 Agora.io. All rights reserved

// This program is confidential and proprietary to Agora.io.
// And may not be copied, reproduced, modified, disclosed to others, published
// or used, in whole or in part, without the express prior written permission
// of Agora.io.

#pragma once  // NOLINT(build/header_guard)

#include "AgoraBase.h"

namespace agora {
namespace rtm {
/**
 * The qos of rtm message.
 */
enum RTM_MESSAGE_QOS {
  /**
   * Will not ensure that messages arrive in order.
   */
  RTM_MESSAGE_QOS_UNORDERED = 0,
  /**
   * Will ensure that messages arrive in order.
   */
  RTM_MESSAGE_QOS_ORDERED = 1,
};

/**
 * Join channel options.
 */
struct JoinChannelOptions {
  /**
  * Token used to join channel.
  */
  const char* token;

  JoinChannelOptions() : token(NULL) {}
};

/**
 * Create topic options.
 */
struct JoinTopicOptions {
  /**
   * The qos of rtm message.
   */
  RTM_MESSAGE_QOS qos;

  /**
   * The metaData of topic.
   */
  const char* meta;

  /**
   * The length of meta.
   */
  size_t metaLength;

  JoinTopicOptions() : qos(RTM_MESSAGE_QOS_UNORDERED), meta(NULL), metaLength(0) {}
};

/**
 * Topic options.
 */
struct TopicOptions {
  /**
   * The list of users to subscribe.
   */
  const char** users;
  /**
   * The number of users.
   */
  size_t userCount;

  TopicOptions() : users(NULL), userCount(0) {}
};

/**
 * User list.
 */
struct UserList {
  /**
   * The list of users.
   */
  const char** users;
  /**
   * The number of users.
   */
  size_t userCount;

  UserList() : users(NULL), userCount(0) {}
};

/**
 * The IStreamChannel class.
 *
 * This class provides the stream channel methods that can be invoked by your app.
 */
class IStreamChannel {
 public:
  /**
   * Join the channel.
   *
   * @param [in] options join channel options.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int join(const JoinChannelOptions& options) = 0;

  /**
   * Leave the channel.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int leave() = 0;

  /**
   * Return the channel name of this stream channel.
   *
   * @return The channel name.
   */
  virtual const char* getChannelName() = 0;

  /**
   * Join a topic.
   *
   * @param [in] topic The name of the topic.
   * @param [in] options The options of the topic.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int joinTopic(const char* topic, const JoinTopicOptions& options) = 0;

  /**
   * Publish a message in the topic.
   *
   * @param [in] topic The name of the topic.
   * @param [in] message The content of the message.
   * @param [in] length The length of the message.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int publishTopicMessage(const char* topic, const char* message, size_t length) = 0;

  /**
   * Leave the topic.
   *
   * @param [in] topic The name of the topic.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int leaveTopic(const char* topic) = 0;

  /**
   * Subscribe a topic.
   *
   * @param [in] topic The name of the topic.
   * @param [in] options The options of subscribe the topic.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int subscribeTopic(const char* topic, const TopicOptions& options) = 0;

  /**
   * Unsubscribe a topic.
   *
   * @param [in] topic The name of the topic.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int unsubscribeTopic(const char* topic, const TopicOptions& options) = 0;

  /**
   * Get subscribed user list
   *
   * @param [in] topic The name of the topic.
   * @param [out] users The list of subscribed users.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getSubscribedUserList(const char* topic, UserList* users) = 0;

  /**
   * Release the stream channel instance.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int release() = 0;

 protected:
  ~IStreamChannel() {}
};

}  // namespace rtm
}  // namespace agora
