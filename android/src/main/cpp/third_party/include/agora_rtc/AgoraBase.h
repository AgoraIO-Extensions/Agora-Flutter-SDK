//
//  Agora Engine SDK
//
//  Created by Sting Feng in 2017-11.
//  Copyright (c) 2017 Agora.io. All rights reserved.
//

// This header file is included by both high level and low level APIs,
#pragma once  // NOLINT(build/header_guard)

#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <cassert>

#include "IAgoraParameter.h"
#include "AgoraMediaBase.h"
#include "AgoraRefPtr.h"
#include "AgoraOptional.h"

#define MAX_PATH_260 (260)

#if defined(_WIN32)

#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif  // !WIN32_LEAN_AND_MEAN
#if defined(__aarch64__)
#include <arm64intr.h>
#endif
#include <Windows.h>

#if defined(AGORARTC_EXPORT)
#define AGORA_API extern "C" __declspec(dllexport)
#define AGORA_CPP_API __declspec(dllexport)
#else
#define AGORA_API extern "C" __declspec(dllimport)
#define AGORA_CPP_API __declspec(dllimport)
#endif  // AGORARTC_EXPORT

#define AGORA_CALL __cdecl

#define __deprecated

#define AGORA_CPP_INTERNAL_API extern

#elif defined(__APPLE__)

#include <TargetConditionals.h>

#define AGORA_API extern "C" __attribute__((visibility("default")))
#define AGORA_CPP_API __attribute__((visibility("default")))
#define AGORA_CALL

#define AGORA_CPP_INTERNAL_API __attribute__((visibility("hidden")))

#elif defined(__ANDROID__) || defined(__linux__)

#define AGORA_API extern "C" __attribute__((visibility("default")))
#define AGORA_CPP_API __attribute__((visibility("default")))
#define AGORA_CALL

#define __deprecated

#define AGORA_CPP_INTERNAL_API __attribute__((visibility("hidden")))

#else  // !_WIN32 && !__APPLE__ && !(__ANDROID__ || __linux__)

#define AGORA_API extern "C"
#define AGORA_CPP_API
#define AGORA_CALL

#define __deprecated

#endif  // _WIN32

#ifndef OPTIONAL_ENUM_SIZE_T
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
#define OPTIONAL_ENUM_SIZE_T enum : size_t
#else
#define OPTIONAL_ENUM_SIZE_T enum
#endif
#endif

#ifndef OPTIONAL_NULLPTR
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
#define OPTIONAL_NULLPTR nullptr
#else
#define OPTIONAL_NULLPTR NULL
#endif
#endif

#define INVALID_DISPLAY_ID (-2)

namespace agora {
namespace util {

template <class T>
class AutoPtr {
 protected:
  typedef T value_type;
  typedef T* pointer_type;

 public:
  explicit AutoPtr(pointer_type p = OPTIONAL_NULLPTR) : ptr_(p) {}

  ~AutoPtr() {
    if (ptr_) {
      ptr_->release();
      ptr_ = OPTIONAL_NULLPTR;
    }
  }

  operator bool() const { return (ptr_ != OPTIONAL_NULLPTR); }

  value_type& operator*() const { return *get(); }

  pointer_type operator->() const { return get(); }

  pointer_type get() const { return ptr_; }

  pointer_type release() {
    pointer_type ret = ptr_;
    ptr_ = 0;
    return ret;
  }

  void reset(pointer_type ptr = OPTIONAL_NULLPTR) {
    if (ptr != ptr_ && ptr_) {
      ptr_->release();
    }

    ptr_ = ptr;
  }

  template <class C1, class C2>
  bool queryInterface(C1* c, C2 iid) {
    pointer_type p = OPTIONAL_NULLPTR;
    if (c && !c->queryInterface(iid, reinterpret_cast<void**>(&p))) {
      reset(p);
    }

    return (p != OPTIONAL_NULLPTR);
  }

 private:
  AutoPtr(const AutoPtr&);
  AutoPtr& operator=(const AutoPtr&);

 private:
  pointer_type ptr_;
};

template <class T>
class CopyableAutoPtr : public AutoPtr<T> {
  typedef typename AutoPtr<T>::pointer_type pointer_type;

 public:
  explicit CopyableAutoPtr(pointer_type p = 0) : AutoPtr<T>(p) {}
  CopyableAutoPtr(const CopyableAutoPtr& rhs) { this->reset(rhs.clone()); }
  CopyableAutoPtr& operator=(const CopyableAutoPtr& rhs) {
    if (this != &rhs) this->reset(rhs.clone());
    return *this;
  }
  pointer_type clone() const {
    if (!this->get()) return OPTIONAL_NULLPTR;
    return this->get()->clone();
  }
};

class IString {
 public:
  virtual bool empty() const = 0;
  virtual const char* c_str() = 0;
  virtual const char* data() = 0;
  virtual size_t length() = 0;
  virtual IString* clone() = 0;
  virtual void release() = 0;
  virtual ~IString() {}
};
typedef CopyableAutoPtr<IString> AString;

class IIterator {
 public:
  virtual void* current() = 0;
  virtual const void* const_current() const = 0;
  virtual bool next() = 0;
  virtual void release() = 0;
  virtual ~IIterator() {}
};

class IContainer {
 public:
  virtual IIterator* begin() = 0;
  virtual size_t size() const = 0;
  virtual void release() = 0;
  virtual ~IContainer() {}
};

template <class T>
class AOutputIterator {
  IIterator* p;

 public:
  typedef T value_type;
  typedef value_type& reference;
  typedef const value_type& const_reference;
  typedef value_type* pointer;
  typedef const value_type* const_pointer;
  explicit AOutputIterator(IIterator* it = OPTIONAL_NULLPTR) : p(it) {}
  ~AOutputIterator() {
    if (p) p->release();
  }
  AOutputIterator(const AOutputIterator& rhs) : p(rhs.p) {}
  AOutputIterator& operator++() {
    p->next();
    return *this;
  }
  bool operator==(const AOutputIterator& rhs) const {
    if (p && rhs.p)
      return p->current() == rhs.p->current();
    else
      return valid() == rhs.valid();
  }
  bool operator!=(const AOutputIterator& rhs) const { return !this->operator==(rhs); }
  reference operator*() { return *reinterpret_cast<pointer>(p->current()); }
  const_reference operator*() const { return *reinterpret_cast<const_pointer>(p->const_current()); }
  bool valid() const { return p && p->current() != OPTIONAL_NULLPTR; }
};

template <class T>
class AList {
  IContainer* container;
  bool owner;

 public:
  typedef T value_type;
  typedef value_type& reference;
  typedef const value_type& const_reference;
  typedef value_type* pointer;
  typedef const value_type* const_pointer;
  typedef size_t size_type;
  typedef AOutputIterator<value_type> iterator;
  typedef const AOutputIterator<value_type> const_iterator;

 public:
  AList() : container(OPTIONAL_NULLPTR), owner(false) {}
  AList(IContainer* c, bool take_ownership) : container(c), owner(take_ownership) {}
  ~AList() { reset(); }
  void reset(IContainer* c = OPTIONAL_NULLPTR, bool take_ownership = false) {
    if (owner && container) container->release();
    container = c;
    owner = take_ownership;
  }
  iterator begin() { return container ? iterator(container->begin()) : iterator(OPTIONAL_NULLPTR); }
  iterator end() { return iterator(OPTIONAL_NULLPTR); }
  size_type size() const { return container ? container->size() : 0; }
  bool empty() const { return size() == 0; }
};

}  // namespace util

/**
 * The channel profile.
 */
enum CHANNEL_PROFILE_TYPE {
  /**
   * 0: Communication.
   *
   * This profile prioritizes smoothness and applies to the one-to-one scenario.
   */
  CHANNEL_PROFILE_COMMUNICATION = 0,
  /**
   * 1: (Default) Live Broadcast.
   *
   * This profile prioritizes supporting a large audience in a live broadcast channel.
   */
  CHANNEL_PROFILE_LIVE_BROADCASTING = 1,
  /**
   * 2: Gaming.
   * @deprecated This profile is deprecated.
   */
  CHANNEL_PROFILE_GAME __deprecated = 2,
  /**
   * 3: Cloud Gaming.
   *
   * @deprecated This profile is deprecated.
   */
  CHANNEL_PROFILE_CLOUD_GAMING __deprecated = 3,

  /**
   * 4: Communication 1v1.
   * @deprecated This profile is deprecated.
   */
  CHANNEL_PROFILE_COMMUNICATION_1v1 __deprecated = 4,
};

/**
 * The warning codes.
 */
enum WARN_CODE_TYPE {
  /**
   * 8: The specified view is invalid. To use the video function, you need to specify
   * a valid view.
   */
  WARN_INVALID_VIEW = 8,
  /**
   * 16: Fails to initialize the video function, probably due to a lack of
   * resources. Users fail to see each other, but can still communicate with voice.
   */
  WARN_INIT_VIDEO = 16,
  /**
   * 20: The request is pending, usually because some module is not ready,
   * and the SDK postpones processing the request.
   */
  WARN_PENDING = 20,
  /**
   * 103: No channel resources are available, probably because the server cannot
   * allocate any channel resource.
   */
  WARN_NO_AVAILABLE_CHANNEL = 103,
  /**
   * 104: A timeout occurs when looking for the channel. When joining a channel,
   * the SDK looks up the specified channel. This warning usually occurs when the
   * network condition is too poor to connect to the server.
   */
  WARN_LOOKUP_CHANNEL_TIMEOUT = 104,
  /**
   * 105: The server rejects the request to look for the channel. The server
   * cannot process this request or the request is illegal.
   */
  WARN_LOOKUP_CHANNEL_REJECTED = 105,
  /**
   * 106: A timeout occurs when opening the channel. Once the specific channel
   * is found, the SDK opens the channel. This warning usually occurs when the
   * network condition is too poor to connect to the server.
   */
  WARN_OPEN_CHANNEL_TIMEOUT = 106,
  /**
   * 107: The server rejects the request to open the channel. The server
   * cannot process this request or the request is illegal.
   */
  WARN_OPEN_CHANNEL_REJECTED = 107,

  // sdk: 100~1000
  /**
   * 111: A timeout occurs when switching the live video.
   */
  WARN_SWITCH_LIVE_VIDEO_TIMEOUT = 111,
  /**
   * 118: A timeout occurs when setting the user role.
   */
  WARN_SET_CLIENT_ROLE_TIMEOUT = 118,
  /**
   * 121: The ticket to open the channel is invalid.
   */
  WARN_OPEN_CHANNEL_INVALID_TICKET = 121,
  /**
   * 122: The SDK is trying connecting to another server.
   */
  WARN_OPEN_CHANNEL_TRY_NEXT_VOS = 122,
  /**
   * 131: The channel connection cannot be recovered.
   */
  WARN_CHANNEL_CONNECTION_UNRECOVERABLE = 131,
  /**
   * 132: The SDK connection IP has changed.
   */
  WARN_CHANNEL_CONNECTION_IP_CHANGED = 132,
  /**
   * 133: The SDK connection port has changed.
   */
  WARN_CHANNEL_CONNECTION_PORT_CHANGED = 133,
  /** 134: The socket error occurs, try to rejoin channel.
   */
  WARN_CHANNEL_SOCKET_ERROR = 134,
  /**
   * 701: An error occurs when opening the file for audio mixing.
   */
  WARN_AUDIO_MIXING_OPEN_ERROR = 701,
  /**
   * 1014: Audio Device Module: An exception occurs in the playback device.
   */
  WARN_ADM_RUNTIME_PLAYOUT_WARNING = 1014,
  /**
   * 1016: Audio Device Module: A warning occurs in the recording device.
   */
  WARN_ADM_RUNTIME_RECORDING_WARNING = 1016,
  /**
   * 1019: Audio Device Module: No valid audio data is collected.
   */
  WARN_ADM_RECORD_AUDIO_SILENCE = 1019,
  /**
   * 1020: Audio Device Module: The playback device fails to start.
   */
  WARN_ADM_PLAYOUT_MALFUNCTION = 1020,
  /**
   * 1021: Audio Device Module: The recording device fails to start.
   */
  WARN_ADM_RECORD_MALFUNCTION = 1021,
  /**
   * 1031: Audio Device Module: The recorded audio volume is too low.
   */
  WARN_ADM_RECORD_AUDIO_LOWLEVEL = 1031,
  /**
   * 1032: Audio Device Module: The playback audio volume is too low.
   */
  WARN_ADM_PLAYOUT_AUDIO_LOWLEVEL = 1032,
  /**
   * 1040: Audio device module: An exception occurs with the audio drive.
   * Choose one of the following solutions:
   * - Disable or re-enable the audio device.
   * - Re-enable your device.
   * - Update the sound card drive.
   */
  WARN_ADM_WINDOWS_NO_DATA_READY_EVENT = 1040,
  /**
   * 1051: Audio Device Module: The SDK detects howling.
   */
  WARN_APM_HOWLING = 1051,
  /**
   * 1052: Audio Device Module: The audio device is in a glitching state.
   */
  WARN_ADM_GLITCH_STATE = 1052,
  /**
   * 1053: Audio Device Module: The settings are improper.
   */
  WARN_ADM_IMPROPER_SETTINGS = 1053,
  /**
   * 1322: No recording device.
   */
  WARN_ADM_WIN_CORE_NO_RECORDING_DEVICE = 1322,
  /**
   * 1323: Audio device module: No available playback device.
   * You can try plugging in the audio device.
   */
  WARN_ADM_WIN_CORE_NO_PLAYOUT_DEVICE = 1323,
  /**
   * 1324: Audio device module: The capture device is released improperly.
   * Choose one of the following solutions:
   * - Disable or re-enable the audio device.
   * - Re-enable your audio device.
   * - Update the sound card drive.
   */
  WARN_ADM_WIN_CORE_IMPROPER_CAPTURE_RELEASE = 1324,
};

/**
 * The error codes.
 */
enum ERROR_CODE_TYPE {
  /**
   * 0: No error occurs.
   */
  ERR_OK = 0,
  // 1~1000
  /**
   * 1: A general error occurs (no specified reason).
   */
  ERR_FAILED = 1,
  /**
   * 2: The argument is invalid. For example, the specific channel name
   * includes illegal characters.
   */
  ERR_INVALID_ARGUMENT = 2,
  /**
   * 3: The SDK module is not ready. Choose one of the following solutions:
   * - Check the audio device.
   * - Check the completeness of the app.
   * - Reinitialize the RTC engine.
   */
  ERR_NOT_READY = 3,
  /**
   * 4: The SDK does not support this function.
   */
  ERR_NOT_SUPPORTED = 4,
  /**
   * 5: The request is rejected.
   */
  ERR_REFUSED = 5,
  /**
   * 6: The buffer size is not big enough to store the returned data.
   */
  ERR_BUFFER_TOO_SMALL = 6,
  /**
   * 7: The SDK is not initialized before calling this method.
   */
  ERR_NOT_INITIALIZED = 7,
  /**
   * 8: The state is invalid.
   */
  ERR_INVALID_STATE = 8,
  /**
   * 9: No permission. This is for internal use only, and does
   * not return to the app through any method or callback.
   */
  ERR_NO_PERMISSION = 9,
  /**
   * 10: An API timeout occurs. Some API methods require the SDK to return the
   * execution result, and this error occurs if the request takes too long
   * (more than 10 seconds) for the SDK to process.
   */
  ERR_TIMEDOUT = 10,
  /**
   * 11: The request is cancelled. This is for internal use only,
   * and does not return to the app through any method or callback.
   */
  ERR_CANCELED = 11,
  /**
   * 12: The method is called too often. This is for internal use
   * only, and does not return to the app through any method or
   * callback.
   */
  ERR_TOO_OFTEN = 12,
  /**
   * 13: The SDK fails to bind to the network socket. This is for internal
   * use only, and does not return to the app through any method or
   * callback.
   */
  ERR_BIND_SOCKET = 13,
  /**
   * 14: The network is unavailable. This is for internal use only, and
   * does not return to the app through any method or callback.
   */
  ERR_NET_DOWN = 14,
  /**
   * 17: The request to join the channel is rejected. This error usually occurs
   * when the user is already in the channel, and still calls the method to join
   * the channel, for example, \ref agora::rtc::IRtcEngine::joinChannel "joinChannel()".
   */
  ERR_JOIN_CHANNEL_REJECTED = 17,
  /**
   * 18: The request to leave the channel is rejected. This error usually
   * occurs when the user has already left the channel, and still calls the
   * method to leave the channel, for example, \ref agora::rtc::IRtcEngine::leaveChannel
   * "leaveChannel".
   */
  ERR_LEAVE_CHANNEL_REJECTED = 18,
  /**
   * 19: The resources have been occupied and cannot be reused.
   */
  ERR_ALREADY_IN_USE = 19,
  /**
   * 20: The SDK gives up the request due to too many requests. This is for
   * internal use only, and does not return to the app through any method or callback.
   */
  ERR_ABORTED = 20,
  /**
   * 21: On Windows, specific firewall settings can cause the SDK to fail to
   * initialize and crash.
   */
  ERR_INIT_NET_ENGINE = 21,
  /**
   * 22: The app uses too much of the system resource and the SDK
   * fails to allocate any resource.
   */
  ERR_RESOURCE_LIMITED = 22,
  /**
   * 101: The App ID is invalid, usually because the data format of the App ID is incorrect.
   *
   * Solution: Check the data format of your App ID. Ensure that you use the correct App ID to initialize the Agora service.
   */
  ERR_INVALID_APP_ID = 101,
  /**
   * 102: The specified channel name is invalid. Please try to rejoin the
   * channel with a valid channel name.
   */
  ERR_INVALID_CHANNEL_NAME = 102,
  /**
   * 103: Fails to get server resources in the specified region. Please try to
   * specify another region when calling \ref agora::rtc::IRtcEngine::initialize
   *  "initialize".
   */
  ERR_NO_SERVER_RESOURCES = 103,
  /**
   * 109: The token has expired, usually for the following reasons:
   * - Timeout for token authorization: Once a token is generated, you must use it to access the
   * Agora service within 24 hours. Otherwise, the token times out and you can no longer use it.
   * - The token privilege expires: To generate a token, you need to set a timestamp for the token
   * privilege to expire. For example, If you set it as seven days, the token expires seven days after
   * its usage. In that case, you can no longer access the Agora service. The users cannot make calls,
   * or are kicked out of the channel.
   *
   * Solution: Regardless of whether token authorization times out or the token privilege expires,
   * you need to generate a new token on your server, and try to join the channel.
   */
  ERR_TOKEN_EXPIRED = 109,
  /**
   * 110: The token is invalid, usually for one of the following reasons:
   * - Did not provide a token when joining a channel in a situation where the project has enabled the
   * App Certificate.
   * - Tried to join a channel with a token in a situation where the project has not enabled the App
   * Certificate.
   * - The App ID, user ID and channel name that you use to generate the token on the server do not match
   * those that you use when joining a channel.
   *
   * Solution:
   * - Before joining a channel, check whether your project has enabled the App certificate. If yes, you
   * must provide a token when joining a channel; if no, join a channel without a token.
   * - When using a token to join a channel, ensure that the App ID, user ID, and channel name that you
   * use to generate the token is the same as the App ID that you use to initialize the Agora service, and
   * the user ID and channel name that you use to join the channel.
   */
  ERR_INVALID_TOKEN = 110,
  /**
   * 111: The internet connection is interrupted. This applies to the Agora Web
   * SDK only.
   */
  ERR_CONNECTION_INTERRUPTED = 111,  // only used in web sdk
  /**
   * 112: The internet connection is lost. This applies to the Agora Web SDK
   * only.
   */
  ERR_CONNECTION_LOST = 112,  // only used in web sdk
  /**
   * 113: The user is not in the channel when calling the
   * \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage()" method.
   */
  ERR_NOT_IN_CHANNEL = 113,
  /**
   * 114: The data size is over 1024 bytes when the user calls the
   * \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage()" method.
   */
  ERR_SIZE_TOO_LARGE = 114,
  /**
   * 115: The bitrate of the sent data exceeds the limit of 6 Kbps when the
   * user calls the \ref agora::rtc::IRtcEngine::sendStreamMessage "sendStreamMessage()".
   */
  ERR_BITRATE_LIMIT = 115,
  /**
   * 116: Too many data streams (over 5) are created when the user
   * calls the \ref agora::rtc::IRtcEngine::createDataStream "createDataStream()" method.
   */
  ERR_TOO_MANY_DATA_STREAMS = 116,
  /**
   * 117: A timeout occurs for the data stream transmission.
   */
  ERR_STREAM_MESSAGE_TIMEOUT = 117,
  /**
   * 119: Switching the user role fails. Please try to rejoin the channel.
   */
  ERR_SET_CLIENT_ROLE_NOT_AUTHORIZED = 119,
  /**
   * 120: MediaStream decryption fails. The user may have tried to join the channel with a wrong
   * password. Check your settings or try rejoining the channel.
   */
  ERR_DECRYPTION_FAILED = 120,
  /**
   * 121: The user ID is invalid.
   */
  ERR_INVALID_USER_ID = 121,
  /**
   * 122: DataStream decryption fails. The peer may have tried to join the channel with a wrong
   * password, or did't enable datastream encryption
   */
  ERR_DATASTREAM_DECRYPTION_FAILED = 122,
  /**
   * 123: The app is banned by the server.
   */
  ERR_CLIENT_IS_BANNED_BY_SERVER = 123,
  /**
   * 130: Encryption is enabled when the user calls the
   * \ref agora::rtc::IRtcEngine::addPublishStreamUrl "addPublishStreamUrl()" method
   * (CDN live streaming does not support encrypted streams).
   */
  ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH = 130,

  /**
   * 131: License credential is invalid
   */
  ERR_LICENSE_CREDENTIAL_INVALID = 131,

  /**
   * 134: The user account is invalid, usually because the data format of the user account is incorrect.
   */
  ERR_INVALID_USER_ACCOUNT = 134,

  /** 157: The necessary dynamical library is not integrated. For example, if you call
   * the \ref agora::rtc::IRtcEngine::enableDeepLearningDenoise "enableDeepLearningDenoise" but do not integrate the dynamical
   * library for the deep-learning noise reduction into your project, the SDK reports this error code.
   *
   */
  ERR_MODULE_NOT_FOUND = 157,

  // Licensing, keep the license error code same as the main version
  ERR_CERT_RAW = 157,
  ERR_CERT_JSON_PART = 158,
  ERR_CERT_JSON_INVAL = 159,
  ERR_CERT_JSON_NOMEM = 160,
  ERR_CERT_CUSTOM = 161,
  ERR_CERT_CREDENTIAL = 162,
  ERR_CERT_SIGN = 163,
  ERR_CERT_FAIL = 164,
  ERR_CERT_BUF = 165,
  ERR_CERT_NULL = 166,
  ERR_CERT_DUEDATE = 167,
  ERR_CERT_REQUEST = 168,

  // PcmSend Error num
  ERR_PCMSEND_FORMAT = 200,           // unsupport pcm format
  ERR_PCMSEND_BUFFEROVERFLOW = 201,  // buffer overflow, the pcm send rate too quickly

  /// @cond
  // signaling: 400~600
  ERR_LOGIN_ALREADY_LOGIN = 428,

  /// @endcond
  // 1001~2000
  /**
   * 1001: Fails to load the media engine.
   */
  ERR_LOAD_MEDIA_ENGINE = 1001,
  /**
   * 1005: Audio device module: A general error occurs in the Audio Device Module (no specified
   * reason). Check if the audio device is used by another app, or try
   * rejoining the channel.
   */
  ERR_ADM_GENERAL_ERROR = 1005,
  /**
   * 1008: Audio Device Module: An error occurs in initializing the playback
   * device.
   */
  ERR_ADM_INIT_PLAYOUT = 1008,
  /**
   * 1009: Audio Device Module: An error occurs in starting the playback device.
   */
  ERR_ADM_START_PLAYOUT = 1009,
  /**
   * 1010: Audio Device Module: An error occurs in stopping the playback device.
   */
  ERR_ADM_STOP_PLAYOUT = 1010,
  /**
   * 1011: Audio Device Module: An error occurs in initializing the recording
   * device.
   */
  ERR_ADM_INIT_RECORDING = 1011,
  /**
   * 1012: Audio Device Module: An error occurs in starting the recording device.
   */
  ERR_ADM_START_RECORDING = 1012,
  /**
   * 1013: Audio Device Module: An error occurs in stopping the recording device.
   */
  ERR_ADM_STOP_RECORDING = 1013,
  /**
   * 1501: Video Device Module: The camera is not authorized.
   */
  ERR_VDM_CAMERA_NOT_AUTHORIZED = 1501,
};

enum LICENSE_ERROR_TYPE {
  /**
   * 1: Invalid license
  */
  LICENSE_ERR_INVALID = 1,
  /**
   * 2: License expired
  */
  LICENSE_ERR_EXPIRE = 2,
  /**
   * 3: Exceed license minutes limit
  */
  LICENSE_ERR_MINUTES_EXCEED = 3,
  /**
   * 4: License use in limited period
  */
  LICENSE_ERR_LIMITED_PERIOD = 4,
  /**
   * 5: Same license used in different devices at the same time
  */
  LICENSE_ERR_DIFF_DEVICES = 5,
  /**
   * 99: SDK internal error
  */
  LICENSE_ERR_INTERNAL = 99,
};

/**
 * The operational permission of the SDK on the audio session.
 */
enum AUDIO_SESSION_OPERATION_RESTRICTION {
  /**
   * 0: No restriction; the SDK can change the audio session.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_NONE = 0,
  /**
   * 1: The SDK cannot change the audio session category.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_SET_CATEGORY = 1,
  /**
   * 2: The SDK cannot change the audio session category, mode, or categoryOptions.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_CONFIGURE_SESSION = 1 << 1,
  /**
   * 4: The SDK keeps the audio session active when the user leaves the
   * channel, for example, to play an audio file in the background.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_DEACTIVATE_SESSION = 1 << 2,
  /**
   * 128: Completely restricts the operational permission of the SDK on the
   * audio session; the SDK cannot change the audio session.
   */
  AUDIO_SESSION_OPERATION_RESTRICTION_ALL = 1 << 7,
};

typedef const char* user_id_t;
typedef void* view_t;

/**
 * The definition of the UserInfo struct.
 */
struct UserInfo {
  /**
   * ID of the user.
   */
  util::AString userId;
  /**
   * Whether the user has enabled audio:
   * - true: The user has enabled audio.
   * - false: The user has disabled audio.
   */
  bool hasAudio;
  /**
   * Whether the user has enabled video:
   * - true: The user has enabled video.
   * - false: The user has disabled video.
   */
  bool hasVideo;

  UserInfo() : hasAudio(false), hasVideo(false) {}
};

typedef util::AList<UserInfo> UserList;

// Shared between Agora Service and Rtc Engine
namespace rtc {

/**
 * Reasons for a user being offline.
 */
enum USER_OFFLINE_REASON_TYPE {
  /**
   * 0: The user leaves the current channel.
   */
  USER_OFFLINE_QUIT = 0,
  /**
   * 1: The SDK times out and the user drops offline because no data packet was received within a certain
   * period of time. If a user quits the call and the message is not passed to the SDK (due to an
   * unreliable channel), the SDK assumes that the user drops offline.
   */
  USER_OFFLINE_DROPPED = 1,
  /**
   * 2: The user switches the client role from the host to the audience.
   */
  USER_OFFLINE_BECOME_AUDIENCE = 2,
};

enum INTERFACE_ID_TYPE {
  AGORA_IID_AUDIO_DEVICE_MANAGER = 1,
  AGORA_IID_VIDEO_DEVICE_MANAGER = 2,
  AGORA_IID_PARAMETER_ENGINE = 3,
  AGORA_IID_MEDIA_ENGINE = 4,
  AGORA_IID_AUDIO_ENGINE = 5,
  AGORA_IID_VIDEO_ENGINE = 6,
  AGORA_IID_RTC_CONNECTION = 7,
  AGORA_IID_SIGNALING_ENGINE = 8,
  AGORA_IID_MEDIA_ENGINE_REGULATOR = 9,
  AGORA_IID_LOCAL_SPATIAL_AUDIO = 11,
  AGORA_IID_STATE_SYNC = 13,
  AGORA_IID_META_SERVICE = 14,
  AGORA_IID_MUSIC_CONTENT_CENTER = 15,
  AGORA_IID_H265_TRANSCODER = 16,  
};

/**
 * The network quality types.
 */
enum QUALITY_TYPE {
  /**
   * 0: The network quality is unknown.
   * @deprecated This member is deprecated.
   */
  QUALITY_UNKNOWN __deprecated = 0,
  /**
   * 1: The quality is excellent.
   */
  QUALITY_EXCELLENT = 1,
  /**
   * 2: The quality is quite good, but the bitrate may be slightly
   * lower than excellent.
   */
  QUALITY_GOOD = 2,
  /**
   * 3: Users can feel the communication slightly impaired.
   */
  QUALITY_POOR = 3,
  /**
   * 4: Users cannot communicate smoothly.
   */
  QUALITY_BAD = 4,
  /**
   * 5: Users can barely communicate.
   */
  QUALITY_VBAD = 5,
  /**
   * 6: Users cannot communicate at all.
   */
  QUALITY_DOWN = 6,
  /**
   * 7: (For future use) The network quality cannot be detected.
   */
  QUALITY_UNSUPPORTED = 7,
  /**
   * 8: Detecting the network quality.
   */
  QUALITY_DETECTING = 8,
};

/**
 * Content fit modes.
 */
enum FIT_MODE_TYPE {
  /**
   * 1: Uniformly scale the video until it fills the visible boundaries (cropped).
   * One dimension of the video may have clipped contents.
   */
  MODE_COVER = 1,

  /**
   * 2: Uniformly scale the video until one of its dimension fits the boundary
   * (zoomed to fit). Areas that are not filled due to disparity in the aspect
   * ratio are filled with black.
   */
  MODE_CONTAIN = 2,
};

/**
 * The rotation information.
 */
enum VIDEO_ORIENTATION {
  /**
   * 0: Rotate the video by 0 degree clockwise.
   */
  VIDEO_ORIENTATION_0 = 0,
  /**
   * 90: Rotate the video by 90 degrees clockwise.
   */
  VIDEO_ORIENTATION_90 = 90,
  /**
   * 180: Rotate the video by 180 degrees clockwise.
   */
  VIDEO_ORIENTATION_180 = 180,
  /**
   * 270: Rotate the video by 270 degrees clockwise.
   */
  VIDEO_ORIENTATION_270 = 270
};

/**
 * The video frame rate.
 */
enum FRAME_RATE {
  /**
   * 1: 1 fps.
   */
  FRAME_RATE_FPS_1 = 1,
  /**
   * 7: 7 fps.
   */
  FRAME_RATE_FPS_7 = 7,
  /**
   * 10: 10 fps.
   */
  FRAME_RATE_FPS_10 = 10,
  /**
   * 15: 15 fps.
   */
  FRAME_RATE_FPS_15 = 15,
  /**
   * 24: 24 fps.
   */
  FRAME_RATE_FPS_24 = 24,
  /**
   * 30: 30 fps.
   */
  FRAME_RATE_FPS_30 = 30,
  /**
   * 60: 60 fps. Applies to Windows and macOS only.
   */
  FRAME_RATE_FPS_60 = 60,
};

enum FRAME_WIDTH {
  FRAME_WIDTH_960 = 960,
};

enum FRAME_HEIGHT {
  FRAME_HEIGHT_540 = 540,
};


/**
 * Types of the video frame.
 */
enum VIDEO_FRAME_TYPE {
  /** 0: A black frame. */
  VIDEO_FRAME_TYPE_BLANK_FRAME = 0,
  /** 3: Key frame. */
  VIDEO_FRAME_TYPE_KEY_FRAME = 3,
  /** 4: Delta frame. */
  VIDEO_FRAME_TYPE_DELTA_FRAME = 4,
  /** 5: The B frame.*/
  VIDEO_FRAME_TYPE_B_FRAME = 5,
  /** 6: A discarded frame. */
  VIDEO_FRAME_TYPE_DROPPABLE_FRAME = 6,
  /** Unknown frame. */
  VIDEO_FRAME_TYPE_UNKNOW
};

/**
 * Video output orientation modes.
 */
enum ORIENTATION_MODE {
  /**
   * 0: The output video always follows the orientation of the captured video. The receiver takes
   * the rotational information passed on from the video encoder. This mode applies to scenarios
   * where video orientation can be adjusted on the receiver:
   * - If the captured video is in landscape mode, the output video is in landscape mode.
   * - If the captured video is in portrait mode, the output video is in portrait mode.
   */
  ORIENTATION_MODE_ADAPTIVE = 0,
  /**
   * 1: Landscape mode. In this mode, the SDK always outputs videos in landscape (horizontal) mode.
   * If the captured video is in portrait mode, the video encoder crops it to fit the output. Applies
   * to situations where the receiving end cannot process the rotational information. For example,
   * CDN live streaming.
   */
  ORIENTATION_MODE_FIXED_LANDSCAPE = 1,
  /**
   * 2: Portrait mode. In this mode, the SDK always outputs video in portrait (portrait) mode. If
   * the captured video is in landscape mode, the video encoder crops it to fit the output. Applies
   * to situations where the receiving end cannot process the rotational information. For example,
   * CDN live streaming.
   */
  ORIENTATION_MODE_FIXED_PORTRAIT = 2,
};

/**
 * (For future use) Video degradation preferences under limited bandwidth.
 */
enum DEGRADATION_PREFERENCE {
  /**
   * 0: (Default) Prefers to reduce the video frame rate while maintaining video quality during video
   * encoding under limited bandwidth. This degradation preference is suitable for scenarios where
   * video quality is prioritized.
   * @note In the COMMUNICATION channel profile, the resolution of the video sent may change, so
   * remote users need to handle this issue.
   */
  MAINTAIN_QUALITY = 0,
  /**
   * 1: Prefers to reduce the video quality while maintaining the video frame rate during video
   * encoding under limited bandwidth. This degradation preference is suitable for scenarios where
   * smoothness is prioritized and video quality is allowed to be reduced.
   */
  MAINTAIN_FRAMERATE = 1,
  /**
   * 2: Reduces the video frame rate and video quality simultaneously during video encoding under
   * limited bandwidth. MAINTAIN_BALANCED has a lower reduction than MAINTAIN_QUALITY and MAINTAIN_FRAMERATE,
   * and this preference is suitable for scenarios where both smoothness and video quality are a
   * priority.
   */
  MAINTAIN_BALANCED = 2,
  /**
   * 3: Degrade framerate in order to maintain resolution.
   */
  MAINTAIN_RESOLUTION = 3,
  /**
   * 4: Disable VQC adjustion.
   */
  DISABLED = 100,
};

/**
 * The definition of the VideoDimensions struct.
 */
struct VideoDimensions {
  /**
   * The width of the video, in pixels.
   */
  int width;
  /**
   * The height of the video, in pixels.
   */
  int height;
  VideoDimensions() : width(640), height(480) {}
  VideoDimensions(int w, int h) : width(w), height(h) {}
  bool operator==(const VideoDimensions& rhs) const {
    return width == rhs.width && height == rhs.height;
  }
};

/**
 * (Recommended) 0: Standard bitrate mode.
 *
 * In this mode, the video bitrate is twice the base bitrate.
 */
const int STANDARD_BITRATE = 0;

/**
 * -1: Compatible bitrate mode.
 *
 * In this mode, the video bitrate is the same as the base bitrate.. If you choose
 * this mode in the live-broadcast profile, the video frame rate may be lower
 * than the set value.
 */
const int COMPATIBLE_BITRATE = -1;

/**
 * -1: (For future use) The default minimum bitrate.
 */
const int DEFAULT_MIN_BITRATE = -1;

/**
 * -2: (For future use) Set minimum bitrate the same as target bitrate.
 */
const int DEFAULT_MIN_BITRATE_EQUAL_TO_TARGET_BITRATE = -2;

/**
 * screen sharing supported capability level.
 */
enum SCREEN_CAPTURE_FRAMERATE_CAPABILITY {
  SCREEN_CAPTURE_FRAMERATE_CAPABILITY_15_FPS = 0,
  SCREEN_CAPTURE_FRAMERATE_CAPABILITY_30_FPS = 1,
  SCREEN_CAPTURE_FRAMERATE_CAPABILITY_60_FPS = 2,
};

/**
 * Video codec capability levels.
 */
enum VIDEO_CODEC_CAPABILITY_LEVEL {
  /** No specified level */
  CODEC_CAPABILITY_LEVEL_UNSPECIFIED = -1,
  /** Only provide basic support for the codec type */
  CODEC_CAPABILITY_LEVEL_BASIC_SUPPORT = 5,
  /** Can process 1080p video at a rate of approximately 30 fps. */
  CODEC_CAPABILITY_LEVEL_1080P30FPS = 10,
  /** Can process 1080p video at a rate of approximately 60 fps. */
  CODEC_CAPABILITY_LEVEL_1080P60FPS = 20,
  /** Can process 4k video at a rate of approximately 30 fps. */
  CODEC_CAPABILITY_LEVEL_4K60FPS = 30,
};

/**
 * The video codec types.
 */
enum VIDEO_CODEC_TYPE {
  VIDEO_CODEC_NONE = 0,
  /**
   * 1: Standard VP8.
   */
  VIDEO_CODEC_VP8 = 1,
  /**
   * 2: Standard H.264.
   */
  VIDEO_CODEC_H264 = 2,
  /**
   * 3: Standard H.265.
   */
  VIDEO_CODEC_H265 = 3,
  /**
   * 6: Generic. This type is used for transmitting raw video data, such as encrypted video frames.
   * The SDK returns this type of video frames in callbacks, and you need to decode and render the frames yourself.
   */
  VIDEO_CODEC_GENERIC = 6,
  /**
   * 7: Generic H264.
   */
  VIDEO_CODEC_GENERIC_H264 = 7,
  /**
   * 12: AV1.
   * @technical preview
   */
  VIDEO_CODEC_AV1 = 12,
  /**
   * 13: VP9.
   */
  VIDEO_CODEC_VP9 = 13,
  /**
   * 20: Generic JPEG. This type consumes minimum computing resources and applies to IoT devices.
   */
  VIDEO_CODEC_GENERIC_JPEG = 20,
};

/**
 * Camera focal length type.
 */
enum CAMERA_FOCAL_LENGTH_TYPE {
  /**
   * By default, there are no wide-angle and ultra-wide-angle properties.
   */
  CAMERA_FOCAL_LENGTH_DEFAULT = 0,
  /**
   * Lens with focal length from 24mm to 35mm.
   */
  CAMERA_FOCAL_LENGTH_WIDE_ANGLE = 1,
  /**
   * Lens with focal length of less than 24mm.
   */
  CAMERA_FOCAL_LENGTH_ULTRA_WIDE = 2,
  /**
   * Telephoto lens.
   */
  CAMERA_FOCAL_LENGTH_TELEPHOTO = 3,
};

/**
 * The CC (Congestion Control) mode options.
 */
enum TCcMode {
  /**
   * Enable CC mode.
   */
  CC_ENABLED,
  /**
   * Disable CC mode.
   */
  CC_DISABLED,
};

/**
 * The configuration for creating a local video track with an encoded image sender.
 */
struct SenderOptions {
  /**
   * Whether to enable CC mode. See #TCcMode.
   */
  TCcMode ccMode;
  /**
   * The codec type used for the encoded images: \ref agora::rtc::VIDEO_CODEC_TYPE "VIDEO_CODEC_TYPE".
   */
  VIDEO_CODEC_TYPE codecType;

  /**
   * Target bitrate (Kbps) for video encoding.
   *
   * Choose one of the following options:
   *
   * - \ref agora::rtc::STANDARD_BITRATE "STANDARD_BITRATE": (Recommended) Standard bitrate.
   *   - Communication profile: The encoding bitrate equals the base bitrate.
   *   - Live-broadcast profile: The encoding bitrate is twice the base bitrate.
   * - \ref agora::rtc::COMPATIBLE_BITRATE "COMPATIBLE_BITRATE": Compatible bitrate. The bitrate stays the same
   * regardless of the profile.
   *
   * The Communication profile prioritizes smoothness, while the Live Broadcast
   * profile prioritizes video quality (requiring a higher bitrate). Agora
   * recommends setting the bitrate mode as \ref agora::rtc::STANDARD_BITRATE "STANDARD_BITRATE" or simply to
   * address this difference.
   *
   * The following table lists the recommended video encoder configurations,
   * where the base bitrate applies to the communication profile. Set your
   * bitrate based on this table. If the bitrate you set is beyond the proper
   * range, the SDK automatically sets it to within the range.

   | Resolution             | Frame Rate (fps) | Base Bitrate (Kbps, for Communication) | Live Bitrate (Kbps, for Live Broadcast)|
   |------------------------|------------------|----------------------------------------|----------------------------------------|
   | 160 &times; 120        | 15               | 65                                     | 130 |
   | 120 &times; 120        | 15               | 50                                     | 100 |
   | 320 &times; 180        | 15               | 140                                    | 280 |
   | 180 &times; 180        | 15               | 100                                    | 200 |
   | 240 &times; 180        | 15               | 120                                    | 240 |
   | 320 &times; 240        | 15               | 200                                    | 400 |
   | 240 &times; 240        | 15               | 140                                    | 280 |
   | 424 &times; 240        | 15               | 220                                    | 440 |
   | 640 &times; 360        | 15               | 400                                    | 800 |
   | 360 &times; 360        | 15               | 260                                    | 520 |
   | 640 &times; 360        | 30               | 600                                    | 1200 |
   | 360 &times; 360        | 30               | 400                                    | 800 |
   | 480 &times; 360        | 15               | 320                                    | 640 |
   | 480 &times; 360        | 30               | 490                                    | 980 |
   | 640 &times; 480        | 15               | 500                                    | 1000 |
   | 480 &times; 480        | 15               | 400                                    | 800 |
   | 640 &times; 480        | 30               | 750                                    | 1500 |
   | 480 &times; 480        | 30               | 600                                    | 1200 |
   | 848 &times; 480        | 15               | 610                                    | 1220 |
   | 848 &times; 480        | 30               | 930                                    | 1860 |
   | 640 &times; 480        | 10               | 400                                    | 800 |
   | 1280 &times; 720       | 15               | 1130                                   | 2260 |
   | 1280 &times; 720       | 30               | 1710                                   | 3420 |
   | 960 &times; 720        | 15               | 910                                    | 1820 |
   | 960 &times; 720        | 30               | 1380                                   | 2760 |
   | 1920 &times; 1080      | 15               | 2080                                   | 4160 |
   | 1920 &times; 1080      | 30               | 3150                                   | 6300 |
   | 1920 &times; 1080      | 60               | 4780                                   | 6500 |
   | 2560 &times; 1440      | 30               | 4850                                   | 6500 |
   | 2560 &times; 1440      | 60               | 6500                                   | 6500 |
   | 3840 &times; 2160      | 30               | 6500                                   | 6500 |
   | 3840 &times; 2160      | 60               | 6500                                   | 6500 |
   */
  int targetBitrate;

  SenderOptions()
  : ccMode(CC_ENABLED),
    codecType(VIDEO_CODEC_H265),
    targetBitrate(6500) {}
};

/**
 * Audio codec types.
 */
enum AUDIO_CODEC_TYPE {
  /**
   * 1: OPUS.
   */
  AUDIO_CODEC_OPUS = 1,
  // kIsac = 2,
  /**
   * 3: PCMA.
   */
  AUDIO_CODEC_PCMA = 3,
  /**
   * 4: PCMU.
   */
  AUDIO_CODEC_PCMU = 4,
  /**
   * 5: G722.
   */
  AUDIO_CODEC_G722 = 5,
  // kIlbc = 6,
  /** 7: AAC. */
  // AUDIO_CODEC_AAC = 7,
  /**
   * 8: AAC LC.
   */
  AUDIO_CODEC_AACLC = 8,
  /**
   * 9: HE AAC.
   */
  AUDIO_CODEC_HEAAC = 9,
  /**
   * 10: JC1.
   */
  AUDIO_CODEC_JC1 = 10,
  /**
   * 11: HE-AAC v2.
   */
  AUDIO_CODEC_HEAAC2 = 11,
  /**
   * 12: LPCNET.
   */
  AUDIO_CODEC_LPCNET = 12,
  /**
   * 13: Opus codec, supporting 3 to 8 channels audio.
   */
  AUDIO_CODEC_OPUSMC = 13,
};

/**
 * Audio encoding types of the audio encoded frame observer.
 */
enum AUDIO_ENCODING_TYPE {
  /**
   * AAC encoding format, 16000 Hz sampling rate, bass quality. A file with an audio duration of 10
   * minutes is approximately 1.2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_AAC_16000_LOW = 0x010101,
  /**
   * AAC encoding format, 16000 Hz sampling rate, medium sound quality. A file with an audio duration
   * of 10 minutes is approximately 2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_AAC_16000_MEDIUM = 0x010102,
  /**
   * AAC encoding format, 32000 Hz sampling rate, bass quality. A file with an audio duration of 10
   * minutes is approximately 1.2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_AAC_32000_LOW = 0x010201,
  /**
   * AAC encoding format, 32000 Hz sampling rate, medium sound quality. A file with an audio duration
   * of 10 minutes is approximately 2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_AAC_32000_MEDIUM = 0x010202,
  /**
   * AAC encoding format, 32000 Hz sampling rate, high sound quality. A file with an audio duration of
   * 10 minutes is approximately 3.5 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_AAC_32000_HIGH = 0x010203,
  /**
   * AAC encoding format, 48000 Hz sampling rate, medium sound quality. A file with an audio duration
   * of 10 minutes is approximately 2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_AAC_48000_MEDIUM = 0x010302,
  /**
   * AAC encoding format, 48000 Hz sampling rate, high sound quality. A file with an audio duration
   * of 10 minutes is approximately 3.5 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_AAC_48000_HIGH = 0x010303,
  /**
   * OPUS encoding format, 16000 Hz sampling rate, bass quality. A file with an audio duration of 10
   * minutes is approximately 2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_OPUS_16000_LOW = 0x020101,
  /**
   * OPUS encoding format, 16000 Hz sampling rate, medium sound quality. A file with an audio duration
   * of 10 minutes is approximately 2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_OPUS_16000_MEDIUM = 0x020102,
  /**
   * OPUS encoding format, 48000 Hz sampling rate, medium sound quality. A file with an audio duration
   * of 10 minutes is approximately 2 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_OPUS_48000_MEDIUM = 0x020302,
  /**
   * OPUS encoding format, 48000 Hz sampling rate, high sound quality. A file with an audio duration of
   * 10 minutes is approximately 3.5 MB after encoding.
   */
  AUDIO_ENCODING_TYPE_OPUS_48000_HIGH = 0x020303,
};

/**
 * The adaptation mode of the watermark.
 */
enum WATERMARK_FIT_MODE {
  /**
   * Use the `positionInLandscapeMode` and `positionInPortraitMode` values you set in #WatermarkOptions.
   * The settings in `WatermarkRatio` are invalid.
   */
  FIT_MODE_COVER_POSITION,
  /**
   * Use the value you set in `WatermarkRatio`. The settings in `positionInLandscapeMode` and `positionInPortraitMode`
   * in `WatermarkOptions` are invalid.
   */
  FIT_MODE_USE_IMAGE_RATIO
};

/**
 * The advanced settings of encoded audio frame.
 */
struct EncodedAudioFrameAdvancedSettings {
  EncodedAudioFrameAdvancedSettings()
    : speech(true),
      sendEvenIfEmpty(true) {}

  /**
   * Determines whether the audio source is speech.
   * - true: (Default) The audio source is speech.
   * - false: The audio source is not speech.
   */
  bool speech;
  /**
   * Whether to send the audio frame even when it is empty.
   * - true: (Default) Send the audio frame even when it is empty.
   * - false: Do not send the audio frame when it is empty.
   */
  bool sendEvenIfEmpty;
};

/**
 * The definition of the EncodedAudioFrameInfo struct.
 */
struct EncodedAudioFrameInfo {
  EncodedAudioFrameInfo()
    : codec(AUDIO_CODEC_AACLC),
      sampleRateHz(0),
      samplesPerChannel(0),
      numberOfChannels(0),
      captureTimeMs(0) {}

  EncodedAudioFrameInfo(const EncodedAudioFrameInfo& rhs)
    : codec(rhs.codec),
      sampleRateHz(rhs.sampleRateHz),
      samplesPerChannel(rhs.samplesPerChannel),
      numberOfChannels(rhs.numberOfChannels),
      advancedSettings(rhs.advancedSettings),
      captureTimeMs(rhs.captureTimeMs) {}
  /**
   * The audio codec: #AUDIO_CODEC_TYPE.
   */
  AUDIO_CODEC_TYPE codec;
  /**
   * The sample rate (Hz) of the audio frame.
   */
  int sampleRateHz;
  /**
   * The number of samples per audio channel.
   *
   * If this value is not set, it is 1024 for AAC, or 960 for OPUS by default.
   */
  int samplesPerChannel;
  /**
   * The number of audio channels of the audio frame.
   */
  int numberOfChannels;
  /**
   * The advanced settings of the audio frame.
   */
  EncodedAudioFrameAdvancedSettings advancedSettings;

  /**
   * This is a input parameter which means the timestamp for capturing the audio frame.
   */
  int64_t captureTimeMs;
};
/**
 * The definition of the AudioPcmDataInfo struct.
 */
struct AudioPcmDataInfo {
  AudioPcmDataInfo() : samplesPerChannel(0), channelNum(0), samplesOut(0), elapsedTimeMs(0), ntpTimeMs(0) {}

  AudioPcmDataInfo(const AudioPcmDataInfo& rhs)
    : samplesPerChannel(rhs.samplesPerChannel),
      channelNum(rhs.channelNum),
      samplesOut(rhs.samplesOut),
      elapsedTimeMs(rhs.elapsedTimeMs),
      ntpTimeMs(rhs.ntpTimeMs) {}

  /**
   * The sample count of the PCM data that you expect.
   */
  size_t samplesPerChannel;

  int16_t channelNum;

  // Output
  /**
   * The number of output samples.
   */
  size_t samplesOut;
  /**
   * The rendering time (ms).
   */
  int64_t elapsedTimeMs;
  /**
   * The NTP (Network Time Protocol) timestamp (ms).
   */
  int64_t ntpTimeMs;
};
/**
 * Packetization modes. Applies to H.264 only.
 */
enum H264PacketizeMode {
  /**
   * Non-interleaved mode. See RFC 6184.
   */
  NonInterleaved = 0,  // Mode 1 - STAP-A, FU-A is allowed
  /**
   * Single NAL unit mode. See RFC 6184.
   */
  SingleNalUnit,       // Mode 0 - only single NALU allowed
};

/**
 * Video stream types.
 */
enum VIDEO_STREAM_TYPE {
  /**
   * 0: The high-quality video stream, which has the highest resolution and bitrate.
   */
  VIDEO_STREAM_HIGH = 0,
  /**
   * 1: The low-quality video stream, which has the lowest resolution and bitrate.
   */
  VIDEO_STREAM_LOW = 1,
  /**
   * 4: The video stream of layer_1, which has a lower resolution and bitrate than VIDEO_STREAM_HIGH.
   */
  VIDEO_STREAM_LAYER_1 = 4,
  /**
   * 5: The video stream of layer_2, which has a lower resolution and bitrate than VIDEO_STREAM_LAYER_1.
   */
  VIDEO_STREAM_LAYER_2 = 5,
  /**
   * 6: The video stream of layer_3, which has a lower resolution and bitrate than VIDEO_STREAM_LAYER_2.
   */
  VIDEO_STREAM_LAYER_3 = 6,
  /**
   * 7: The video stream of layer_4, which has a lower resolution and bitrate than VIDEO_STREAM_LAYER_3.
   */
  VIDEO_STREAM_LAYER_4 = 7,
  /**
   * 8: The video stream of layer_5, which has a lower resolution and bitrate than VIDEO_STREAM_LAYER_4.
   */
  VIDEO_STREAM_LAYER_5 = 8,
  /**
   * 9: The video stream of layer_6, which has a lower resolution and bitrate than VIDEO_STREAM_LAYER_5.
   */
  VIDEO_STREAM_LAYER_6 = 9,

};

struct VideoSubscriptionOptions {
    /**
     * The type of the video stream to subscribe to.
     *
     * The default value is `VIDEO_STREAM_HIGH`, which means the high-quality
     * video stream.
     */
    Optional<VIDEO_STREAM_TYPE> type;
    /**
     * Whether to subscribe to encoded video data only:
     * - `true`: Subscribe to encoded video data only.
     * - `false`: (Default) Subscribe to decoded video data.
     */
    Optional<bool> encodedFrameOnly;

    VideoSubscriptionOptions() {}
};


/** The maximum length of the user account.
 */
enum MAX_USER_ACCOUNT_LENGTH_TYPE
{
  /** The maximum length of the user account is 256 bytes.
   */
  MAX_USER_ACCOUNT_LENGTH = 256
};

/**
 * The definition of the EncodedVideoFrameInfo struct, which contains the information of the external encoded video frame.
 */
struct EncodedVideoFrameInfo {
  EncodedVideoFrameInfo()
    : uid(0),
      codecType(VIDEO_CODEC_H264),
      width(0),
      height(0),
      framesPerSecond(0),
      frameType(VIDEO_FRAME_TYPE_BLANK_FRAME),
      rotation(VIDEO_ORIENTATION_0),
      trackId(0),
      captureTimeMs(0),
      decodeTimeMs(0),
      streamType(VIDEO_STREAM_HIGH),
      presentationMs(-1) {}

  EncodedVideoFrameInfo(const EncodedVideoFrameInfo& rhs)
    : uid(rhs.uid),
      codecType(rhs.codecType),
      width(rhs.width),
      height(rhs.height),
      framesPerSecond(rhs.framesPerSecond),
      frameType(rhs.frameType),
      rotation(rhs.rotation),
      trackId(rhs.trackId),
      captureTimeMs(rhs.captureTimeMs),
      decodeTimeMs(rhs.decodeTimeMs),
      streamType(rhs.streamType),
      presentationMs(rhs.presentationMs) {}

  EncodedVideoFrameInfo& operator=(const EncodedVideoFrameInfo& rhs) {
    if (this == &rhs) return *this;
    uid = rhs.uid;
    codecType = rhs.codecType;
    width = rhs.width;
    height = rhs.height;
    framesPerSecond = rhs.framesPerSecond;
    frameType = rhs.frameType;
    rotation = rhs.rotation;
    trackId = rhs.trackId;
    captureTimeMs = rhs.captureTimeMs;
    decodeTimeMs = rhs.decodeTimeMs;
    streamType = rhs.streamType;
    presentationMs = rhs.presentationMs;
    return *this;
  }

  /**
   * ID of the user that pushes the the external encoded video frame..
   */
  uid_t uid;
  /**
   * The codec type of the local video stream. See #VIDEO_CODEC_TYPE. The default value is `VIDEO_CODEC_H265 (3)`.
   */
  VIDEO_CODEC_TYPE codecType;
  /**
   * The width (px) of the video frame.
   */
  int width;
  /**
   * The height (px) of the video frame.
   */
  int height;
  /**
   * The number of video frames per second.
   * When this parameter is not 0, you can use it to calculate the Unix timestamp of the external
   * encoded video frames.
   */
  int framesPerSecond;
  /**
   * The video frame type: #VIDEO_FRAME_TYPE.
   */
  VIDEO_FRAME_TYPE frameType;
  /**
   * The rotation information of the video frame: #VIDEO_ORIENTATION.
   */
  VIDEO_ORIENTATION rotation;
  /**
   * The track ID of the video frame.
   */
  int trackId;  // This can be reserved for multiple video tracks, we need to create different ssrc
                // and additional payload for later implementation.
  /**
   * This is a input parameter which means the timestamp for capturing the video.
   */
  int64_t captureTimeMs;
  /**
   * The timestamp for decoding the video.
   */
  int64_t decodeTimeMs;
  /**
   * The stream type of video frame.
   */
  VIDEO_STREAM_TYPE streamType;

  // @technical preview
  int64_t presentationMs;
};

/**
* Video compression preference.
*/
enum COMPRESSION_PREFERENCE {
  /**
  * (Default) Low latency is preferred, usually used in real-time communication where low latency is the number one priority.
  */
  PREFER_LOW_LATENCY,
  /**
  * Prefer quality in sacrifice of a degree of latency, usually around 30ms ~ 150ms, depends target fps
  */
  PREFER_QUALITY,
};

/**
* The video encoder type preference.
*/
enum ENCODING_PREFERENCE {
  /**
  *Default .
   */
  PREFER_AUTO = -1,
  /**
  *  Software encoding.
  */
  PREFER_SOFTWARE = 0,
  /**
  * Hardware encoding
   */
  PREFER_HARDWARE = 1,
};

/**
 * The definition of the AdvanceOptions struct.
 */
struct AdvanceOptions {

  /**
   * The video encoder type preference..
   */
  ENCODING_PREFERENCE encodingPreference;

  /**
  * Video compression preference.
  */
  COMPRESSION_PREFERENCE compressionPreference;

  /**
  * Whether to encode and send the alpha data to the remote when alpha data is present.
  * The default value is false.
  */
  bool encodeAlpha;

  AdvanceOptions() : encodingPreference(PREFER_AUTO), 
                     compressionPreference(PREFER_LOW_LATENCY),
                     encodeAlpha(false) {}

  AdvanceOptions(ENCODING_PREFERENCE encoding_preference, 
                 COMPRESSION_PREFERENCE compression_preference,
                 bool encode_alpha) : 
                 encodingPreference(encoding_preference),
                 compressionPreference(compression_preference),
                 encodeAlpha(encode_alpha) {}

  bool operator==(const AdvanceOptions& rhs) const {
    return encodingPreference == rhs.encodingPreference && 
           compressionPreference == rhs.compressionPreference &&
           encodeAlpha == rhs.encodeAlpha;
  }

};

/**
 * Video mirror mode types.
 */
enum VIDEO_MIRROR_MODE_TYPE {
  /**
   * 0: The mirror mode determined by the SDK.
   */
  VIDEO_MIRROR_MODE_AUTO = 0,
  /**
   * 1: Enable the mirror mode.
   */
  VIDEO_MIRROR_MODE_ENABLED = 1,
  /**
   * 2: Disable the mirror mode.
   */
  VIDEO_MIRROR_MODE_DISABLED = 2,
};

#if defined(__APPLE__) && TARGET_OS_IOS
/**
 * Camera capturer configuration for format type.
 */
enum CAMERA_FORMAT_TYPE {
  /** 0: (Default) NV12. */
  CAMERA_FORMAT_NV12,
  /** 1: BGRA. */
  CAMERA_FORMAT_BGRA,
};
#endif

/** Supported codec type bit mask. */
enum CODEC_CAP_MASK {
  /** 0: No codec support. */
  CODEC_CAP_MASK_NONE = 0,

  /** bit 1: Hardware decoder support flag. */
  CODEC_CAP_MASK_HW_DEC = 1 << 0,

  /** bit 2: Hardware encoder support flag. */
  CODEC_CAP_MASK_HW_ENC = 1 << 1,

  /** bit 3: Software decoder support flag. */
  CODEC_CAP_MASK_SW_DEC = 1 << 2,

  /** bit 4: Software encoder support flag. */
  CODEC_CAP_MASK_SW_ENC = 1 << 3,
};

struct CodecCapLevels {
  VIDEO_CODEC_CAPABILITY_LEVEL hwDecodingLevel;
  VIDEO_CODEC_CAPABILITY_LEVEL swDecodingLevel;

  CodecCapLevels(): hwDecodingLevel(CODEC_CAPABILITY_LEVEL_UNSPECIFIED), swDecodingLevel(CODEC_CAPABILITY_LEVEL_UNSPECIFIED) {}
};

/** The codec support information. */
struct CodecCapInfo {
  /** The codec type: #VIDEO_CODEC_TYPE. */
  VIDEO_CODEC_TYPE codecType;
  /** The codec support flag. */
  int codecCapMask;
  /** The codec capability level, estimated based on the device hardware.*/
  CodecCapLevels codecLevels;

  CodecCapInfo(): codecType(VIDEO_CODEC_NONE), codecCapMask(0) {}
};

/** FocalLengthInfo contains the IDs of the front and rear cameras, along with the wide-angle types. */
struct FocalLengthInfo {
  /** The camera direction. */
  int cameraDirection;
  /** Camera focal segment type. */
  CAMERA_FOCAL_LENGTH_TYPE focalLengthType;
};

/**
 * The definition of the VideoEncoderConfiguration struct.
 */
struct VideoEncoderConfiguration {
  /**
   * The video encoder code type: #VIDEO_CODEC_TYPE.
   */
  VIDEO_CODEC_TYPE codecType;
  /**
   * The video dimension: VideoDimensions.
   */
  VideoDimensions dimensions;
  /**
   * The frame rate of the video. You can set it manually, or choose one from #FRAME_RATE.
   */
  int frameRate;
  /**
   * The bitrate (Kbps) of the video.
   *
   * Refer to the **Video Bitrate Table** below and set your bitrate. If you set a bitrate beyond the
   * proper range, the SDK automatically adjusts it to a value within the range. You can also choose
   * from the following options:
   *
   * - #STANDARD_BITRATE: (Recommended) Standard bitrate mode. In this mode, the bitrates differ between
   * the Live Broadcast and Communication profiles:
   *   - In the Communication profile, the video bitrate is the same as the base bitrate.
   *   - In the Live Broadcast profile, the video bitrate is twice the base bitrate.
   * - #COMPATIBLE_BITRATE: Compatible bitrate mode. The compatible bitrate mode. In this mode, the bitrate
   * stays the same regardless of the profile. If you choose this mode for the Live Broadcast profile,
   * the video frame rate may be lower than the set value.
   *
   * Agora uses different video codecs for different profiles to optimize the user experience. For example,
   * the communication profile prioritizes the smoothness while the live-broadcast profile prioritizes the
   * video quality (a higher bitrate). Therefore, We recommend setting this parameter as #STANDARD_BITRATE.
   *
   * | Resolution             | Frame Rate (fps) | Base Bitrate (Kbps) | Live Bitrate (Kbps)|
   * |------------------------|------------------|---------------------|--------------------|
   * | 160 * 120              | 15               | 65                  | 110                |
   * | 120 * 120              | 15               | 50                  | 90                 |
   * | 320 * 180              | 15               | 140                 | 240                |
   * | 180 * 180              | 15               | 100                 | 160                |
   * | 240 * 180              | 15               | 120                 | 200                |
   * | 320 * 240              | 15               | 200                 | 300                |
   * | 240 * 240              | 15               | 140                 | 240                |
   * | 424 * 240              | 15               | 220                 | 370                |
   * | 640 * 360              | 15               | 400                 | 680                |
   * | 360 * 360              | 15               | 260                 | 440                |
   * | 640 * 360              | 30               | 600                 | 1030               |
   * | 360 * 360              | 30               | 400                 | 670                |
   * | 480 * 360              | 15               | 320                 | 550                |
   * | 480 * 360              | 30               | 490                 | 830                |
   * | 640 * 480              | 15               | 500                 | 750                |
   * | 480 * 480              | 15               | 400                 | 680                |
   * | 640 * 480              | 30               | 750                 | 1130               |
   * | 480 * 480              | 30               | 600                 | 1030               |
   * | 848 * 480              | 15               | 610                 | 920                |
   * | 848 * 480              | 30               | 930                 | 1400               |
   * | 640 * 480              | 10               | 400                 | 600                |
   * | 960 * 540              | 15               | 750                 | 1100               |
   * | 960 * 540              | 30               | 1110                | 1670               |
   * | 1280 * 720             | 15               | 1130                | 1600               |
   * | 1280 * 720             | 30               | 1710                | 2400               |
   * | 960 * 720              | 15               | 910                 | 1280               |
   * | 960 * 720              | 30               | 1380                | 2000               |
   * | 1920 * 1080            | 15               | 2080                | 2500               |
   * | 1920 * 1080            | 30               | 3150                | 3780               |
   * | 1920 * 1080            | 60               | 4780                | 5730               |
   * | 2560 * 1440            | 30               | 4850                | 4850               |
   * | 2560 * 1440            | 60               | 7350                | 7350               |
   * | 3840 * 2160            | 30               | 8910                | 8910               |
   * | 3840 * 2160            | 60               | 13500               | 13500              |
   */
  int bitrate;

  /**
   * The minimum encoding bitrate (Kbps).
   *
   * The Agora SDK automatically adjusts the encoding bitrate to adapt to the
   * network conditions.
   *
   * Using a value greater than the default value forces the video encoder to
   * output high-quality images but may cause more packet loss and hence
   * sacrifice the smoothness of the video transmission. That said, unless you
   * have special requirements for image quality, Agora does not recommend
   * changing this value.
   *
   * @note
   * This parameter applies to the live-broadcast profile only.
   */
  int minBitrate;
  /**
   * The video orientation mode: #ORIENTATION_MODE.
   */
  ORIENTATION_MODE orientationMode;
  /**
   * The video degradation preference under limited bandwidth: #DEGRADATION_PREFERENCE.
   */
  DEGRADATION_PREFERENCE degradationPreference;

  /**
   * The mirror mode is disabled by default
   * If mirror_type is set to VIDEO_MIRROR_MODE_ENABLED, then the video frame would be mirrored before encoding.
   */
  VIDEO_MIRROR_MODE_TYPE mirrorMode;

  /**
   * The advanced options for the video encoder configuration. See AdvanceOptions.
   */
  AdvanceOptions advanceOptions;

  VideoEncoderConfiguration(const VideoDimensions& d, int f, int b, ORIENTATION_MODE m, VIDEO_MIRROR_MODE_TYPE mirror = VIDEO_MIRROR_MODE_DISABLED)
    : codecType(VIDEO_CODEC_NONE),
      dimensions(d),
      frameRate(f),
      bitrate(b),
      minBitrate(DEFAULT_MIN_BITRATE),
      orientationMode(m),
      degradationPreference(MAINTAIN_QUALITY),
      mirrorMode(mirror),
      advanceOptions(PREFER_AUTO, PREFER_LOW_LATENCY, false) {}
  VideoEncoderConfiguration(int width, int height, int f, int b, ORIENTATION_MODE m, VIDEO_MIRROR_MODE_TYPE mirror = VIDEO_MIRROR_MODE_DISABLED)
    : codecType(VIDEO_CODEC_NONE),
      dimensions(width, height),
      frameRate(f),
      bitrate(b),
      minBitrate(DEFAULT_MIN_BITRATE),
      orientationMode(m),
      degradationPreference(MAINTAIN_QUALITY),
      mirrorMode(mirror),
      advanceOptions(PREFER_AUTO, PREFER_LOW_LATENCY, false) {}
  VideoEncoderConfiguration(const VideoEncoderConfiguration& config)
    : codecType(config.codecType),
      dimensions(config.dimensions),
      frameRate(config.frameRate),
      bitrate(config.bitrate),
      minBitrate(config.minBitrate),
      orientationMode(config.orientationMode),
      degradationPreference(config.degradationPreference),
      mirrorMode(config.mirrorMode),
      advanceOptions(config.advanceOptions) {}
  VideoEncoderConfiguration()
    : codecType(VIDEO_CODEC_NONE),
      dimensions(FRAME_WIDTH_960, FRAME_HEIGHT_540),
      frameRate(FRAME_RATE_FPS_15),
      bitrate(STANDARD_BITRATE),
      minBitrate(DEFAULT_MIN_BITRATE),
      orientationMode(ORIENTATION_MODE_ADAPTIVE),
      degradationPreference(MAINTAIN_QUALITY),
      mirrorMode(VIDEO_MIRROR_MODE_DISABLED),
      advanceOptions(PREFER_AUTO, PREFER_LOW_LATENCY, false) {}

  VideoEncoderConfiguration& operator=(const VideoEncoderConfiguration& rhs) {
    if (this == &rhs) return *this;
    codecType = rhs.codecType;
    dimensions = rhs.dimensions;
    frameRate = rhs.frameRate;
    bitrate = rhs.bitrate;
    minBitrate = rhs.minBitrate;
    orientationMode = rhs.orientationMode;
    degradationPreference = rhs.degradationPreference;
    mirrorMode = rhs.mirrorMode;
    advanceOptions = rhs.advanceOptions;
    return *this;
  }
};

/**
 * The configurations for the data stream.
 */
struct DataStreamConfig {
  /**
   * Whether to synchronize the data packet with the published audio packet.
   * - `true`: Synchronize the data packet with the audio packet.
   * - `false`: Do not synchronize the data packet with the audio packet.
   *
   * When you set the data packet to synchronize with the audio, then if the data packet delay is
   * within the audio delay, the SDK triggers the `onStreamMessage` callback when the synchronized
   * audio packet is played out. Do not set this parameter as true if you need the receiver to receive
   * the data packet immediately. Agora recommends that you set this parameter to `true` only when you
   * need to implement specific functions, for example lyric synchronization.
   */
  bool syncWithAudio;
  /**
   * Whether the SDK guarantees that the receiver receives the data in the sent order.
   * - `true`: Guarantee that the receiver receives the data in the sent order.
   * - `false`: Do not guarantee that the receiver receives the data in the sent order.
   *
   * Do not set this parameter as `true` if you need the receiver to receive the data packet immediately.
   */
  bool ordered;
};

/**
 * The definition of SIMULCAST_STREAM_MODE
 */
enum SIMULCAST_STREAM_MODE {
  /*
  * disable simulcast stream until receive request for enable simulcast stream by other broadcaster
  */
  AUTO_SIMULCAST_STREAM = -1,
  /*
  * disable simulcast stream
  */
  DISABLE_SIMULCAST_STREAM = 0,
  /*
  * always enable simulcast stream
  */
  ENABLE_SIMULCAST_STREAM = 1,
};

/**
 * The configuration of the low-quality video stream.
 */
struct SimulcastStreamConfig {
  /**
   * The video frame dimension: VideoDimensions. The default value is 160 × 120.
   */
  VideoDimensions dimensions;
  /**
   * The video bitrate (Kbps), represented by an instantaneous value. The default value of the log level is 5.
   */
  int kBitrate;
  /**
   * The capture frame rate (fps) of the local video. The default value is 5.
   */
  int framerate;
  SimulcastStreamConfig() : dimensions(160, 120), kBitrate(65), framerate(5) {}
  SimulcastStreamConfig(const SimulcastStreamConfig& other) : dimensions(other.dimensions), kBitrate(other.kBitrate), framerate(other.framerate) {}
  bool operator==(const SimulcastStreamConfig& rhs) const {
    return dimensions == rhs.dimensions && kBitrate == rhs.kBitrate && framerate == rhs.framerate;
  }
};

/**
 * The configuration of the multi-layer video stream.
 */
struct SimulcastConfig {
  /**
   * The index of multi-layer video stream
   */
  enum StreamLayerIndex {
   /**
    * 0: video stream index of layer_1
    */
   STREAM_LAYER_1 = 0,
   /**
    * 1: video stream index of layer_2
    */
   STREAM_LAYER_2 = 1,
   /**
    * 2: video stream index of layer_3
    */
   STREAM_LAYER_3 = 2,
   /**
    * 3: video stream index of layer_4
    */
   STREAM_LAYER_4 = 3,
   /**
    * 4: video stream index of layer_5
    */
   STREAM_LAYER_5 = 4,
   /**
    * 5: video stream index of layer_6
    */
   STREAM_LAYER_6 = 5,
   /**
    * 6: video stream index of low
    */
   STREAM_LOW = 6,
   /**
    * 7: max count of video stream layers
    */
   STREAM_LAYER_COUNT_MAX = 7
  };
  struct StreamLayerConfig {
    /**
     * The video frame dimension. The default value is 0.
     */
    VideoDimensions dimensions;
    /**
     * The capture frame rate (fps) of the local video. The default value is 0.
     */
    int framerate;
    /**
     * Whether to enable the corresponding layer of video stream. The default value is false.
     */
    bool enable;
    StreamLayerConfig() : dimensions(0, 0), framerate(0), enable(false) {}
  };

  /**
   * The array of StreamLayerConfig, which contains STREAM_LAYER_COUNT_MAX layers of video stream at most.
   */
  StreamLayerConfig configs[STREAM_LAYER_COUNT_MAX];
};
/**
 * The location of the target area relative to the screen or window. If you do not set this parameter,
 * the SDK selects the whole screen or window.
 */
struct Rectangle {
  /**
   * The horizontal offset from the top-left corner.
   */
  int x;
  /**
   * The vertical offset from the top-left corner.
   */
  int y;
  /**
   * The width of the region.
   */
  int width;
  /**
   * The height of the region.
   */
  int height;

  Rectangle() : x(0), y(0), width(0), height(0) {}
  Rectangle(int xx, int yy, int ww, int hh) : x(xx), y(yy), width(ww), height(hh) {}
};

/**
 * The position and size of the watermark on the screen.
 *
 * The position and size of the watermark on the screen are determined by `xRatio`, `yRatio`, and `widthRatio`:
 * - (`xRatio`, `yRatio`) refers to the coordinates of the upper left corner of the watermark, which determines
 *  the distance from the upper left corner of the watermark to the upper left corner of the screen.
 * The `widthRatio` determines the width of the watermark.
 */
struct WatermarkRatio {
  /**
   * The x-coordinate of the upper left corner of the watermark. The horizontal position relative to
   * the origin, where the upper left corner of the screen is the origin, and the x-coordinate is the
   * upper left corner of the watermark. The value range is [0.0,1.0], and the default value is 0.
   */
  float xRatio;
  /**
   * The y-coordinate of the upper left corner of the watermark. The vertical position relative to the
   * origin, where the upper left corner of the screen is the origin, and the y-coordinate is the upper
   * left corner of the screen. The value range is [0.0,1.0], and the default value is 0.
   */
  float yRatio;
  /**
   * The width of the watermark. The SDK calculates the height of the watermark proportionally according
   * to this parameter value to ensure that the enlarged or reduced watermark image is not distorted.
   * The value range is [0,1], and the default value is 0, which means no watermark is displayed.
   */
  float widthRatio;

  WatermarkRatio() : xRatio(0.0), yRatio(0.0), widthRatio(0.0) {}
  WatermarkRatio(float x, float y, float width) : xRatio(x), yRatio(y), widthRatio(width) {}
};

/**
 * Configurations of the watermark image.
 */
struct WatermarkOptions {
  /**
   * Whether or not the watermark image is visible in the local video preview:
   * - true: (Default) The watermark image is visible in preview.
   * - false: The watermark image is not visible in preview.
   */
  bool visibleInPreview;
  /**
   * When the adaptation mode of the watermark is `FIT_MODE_COVER_POSITION`, it is used to set the
   * area of the watermark image in landscape mode. See #FIT_MODE_COVER_POSITION for details.
   */
  Rectangle positionInLandscapeMode;
  /**
   * When the adaptation mode of the watermark is `FIT_MODE_COVER_POSITION`, it is used to set the
   * area of the watermark image in portrait mode. See #FIT_MODE_COVER_POSITION for details.
   */
  Rectangle positionInPortraitMode;
  /**
   * When the watermark adaptation mode is `FIT_MODE_USE_IMAGE_RATIO`, this parameter is used to set
   * the watermark coordinates. See WatermarkRatio for details.
   */
  WatermarkRatio watermarkRatio;
  /**
   * The adaptation mode of the watermark. See #WATERMARK_FIT_MODE for details.
   */
  WATERMARK_FIT_MODE mode;

  WatermarkOptions()
    : visibleInPreview(true),
      positionInLandscapeMode(0, 0, 0, 0),
      positionInPortraitMode(0, 0, 0, 0),
      mode(FIT_MODE_COVER_POSITION) {}
};

/**
 * The definition of the RtcStats struct.
 */
struct RtcStats {
  /**
   * The call duration (s), represented by an aggregate value.
   */
  unsigned int duration;
  /**
   * The total number of bytes transmitted, represented by an aggregate value.
   */
  unsigned int txBytes;
  /**
   * The total number of bytes received, represented by an aggregate value.
   */
  unsigned int rxBytes;
  /**
   * The total number of audio bytes sent (bytes), represented by an aggregate value.
   */
  unsigned int txAudioBytes;
  /**
   * The total number of video bytes sent (bytes), represented by an aggregate value.
   */
  unsigned int txVideoBytes;
  /**
   * The total number of audio bytes received (bytes), represented by an aggregate value.
   */
  unsigned int rxAudioBytes;
  /**
   * The total number of video bytes received (bytes), represented by an aggregate value.
   */
  unsigned int rxVideoBytes;
  /**
   * The transmission bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short txKBitRate;
  /**
   * The receiving bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short rxKBitRate;
  /**
   * Audio receiving bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short rxAudioKBitRate;
  /**
   * The audio transmission bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short txAudioKBitRate;
  /**
   * The video receive bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short rxVideoKBitRate;
  /**
   * The video transmission bitrate (Kbps), represented by an instantaneous value.
   */
  unsigned short txVideoKBitRate;
  /**
   * The VOS client-server latency (ms).
   */
  unsigned short lastmileDelay;
  /**
   * The number of users in the channel.
   */
  unsigned int userCount;
  /**
   * The app CPU usage (%).
   * @note
   * - The value of `cpuAppUsage` is always reported as 0 in the `onLeaveChannel` callback.
   * - As of Android 8.1, you cannot get the CPU usage from this attribute due to system limitations.
   */
  double cpuAppUsage;
  /**
   * The system CPU usage (%).
   *
   * For Windows, in the multi-kernel environment, this member represents the average CPU usage. The
   * value = (100 - System Idle Progress in Task Manager)/100.
   * @note
   * - The value of `cpuTotalUsage` is always reported as 0 in the `onLeaveChannel` callback.
   * - As of Android 8.1, you cannot get the CPU usage from this attribute due to system limitations.
   */
  double cpuTotalUsage;
  /**
   * The round-trip time delay from the client to the local router.
   * @note On Android, to get `gatewayRtt`, ensure that you add the `android.permission.ACCESS_WIFI_STATE`
   * permission after `</application>` in the `AndroidManifest.xml` file in your project.
   */
  int gatewayRtt;
  /**
   * The memory usage ratio of the app (%).
   * @note This value is for reference only. Due to system limitations, you may not get this value.
   */
  double memoryAppUsageRatio;
  /**
   * The memory usage ratio of the system (%).
   * @note This value is for reference only. Due to system limitations, you may not get this value.
   */
  double memoryTotalUsageRatio;
  /**
   * The memory usage of the app (KB).
   * @note This value is for reference only. Due to system limitations, you may not get this value.
   */
  int memoryAppUsageInKbytes;
  /**
   * The time elapsed from the when the app starts connecting to an Agora channel
   * to when the connection is established. 0 indicates that this member does not apply.
   */
  int connectTimeMs;
  /**
   * The duration (ms) between the app starting connecting to an Agora channel
   * and the first audio packet is received. 0 indicates that this member does not apply.
   */
  int firstAudioPacketDuration;
  /**
   * The duration (ms) between the app starting connecting to an Agora channel
   * and the first video packet is received. 0 indicates that this member does not apply.
   */
  int firstVideoPacketDuration;
  /**
   * The duration (ms) between the app starting connecting to an Agora channel
   * and the first video key frame is received. 0 indicates that this member does not apply.
   */
  int firstVideoKeyFramePacketDuration;
  /**
   * The number of video packets before the first video key frame is received.
   * 0 indicates that this member does not apply.
   */
  int packetsBeforeFirstKeyFramePacket;
  /**
   * The duration (ms) between the last time unmute audio and the first audio packet is received.
   * 0 indicates that this member does not apply.
   */
  int firstAudioPacketDurationAfterUnmute;
  /**
   * The duration (ms) between the last time unmute video and the first video packet is received.
   * 0 indicates that this member does not apply.
   */
  int firstVideoPacketDurationAfterUnmute;
  /**
   * The duration (ms) between the last time unmute video and the first video key frame is received.
   * 0 indicates that this member does not apply.
   */
  int firstVideoKeyFramePacketDurationAfterUnmute;
  /**
   * The duration (ms) between the last time unmute video and the first video key frame is decoded.
   * 0 indicates that this member does not apply.
   */
  int firstVideoKeyFrameDecodedDurationAfterUnmute;
  /**
   * The duration (ms) between the last time unmute video and the first video key frame is rendered.
   * 0 indicates that this member does not apply.
   */
  int firstVideoKeyFrameRenderedDurationAfterUnmute;
  /**
   * The packet loss rate of sender(broadcaster).
   */
  int txPacketLossRate;
  /**
   * The packet loss rate of receiver(audience).
   */
  int rxPacketLossRate;
  RtcStats()
    : duration(0),
      txBytes(0),
      rxBytes(0),
      txAudioBytes(0),
      txVideoBytes(0),
      rxAudioBytes(0),
      rxVideoBytes(0),
      txKBitRate(0),
      rxKBitRate(0),
      rxAudioKBitRate(0),
      txAudioKBitRate(0),
      rxVideoKBitRate(0),
      txVideoKBitRate(0),
      lastmileDelay(0),
      userCount(0),
      cpuAppUsage(0.0),
      cpuTotalUsage(0.0),
      gatewayRtt(0),
      memoryAppUsageRatio(0.0),
      memoryTotalUsageRatio(0.0),
      memoryAppUsageInKbytes(0),
      connectTimeMs(0),
      firstAudioPacketDuration(0),
      firstVideoPacketDuration(0),
      firstVideoKeyFramePacketDuration(0),
      packetsBeforeFirstKeyFramePacket(0),
      firstAudioPacketDurationAfterUnmute(0),
      firstVideoPacketDurationAfterUnmute(0),
      firstVideoKeyFramePacketDurationAfterUnmute(0),
      firstVideoKeyFrameDecodedDurationAfterUnmute(0),
      firstVideoKeyFrameRenderedDurationAfterUnmute(0),
      txPacketLossRate(0),
      rxPacketLossRate(0) {}
};

/**
 * User role types.
 */
enum CLIENT_ROLE_TYPE {
  /**
   * 1: Broadcaster. A broadcaster can both send and receive streams.
   */
  CLIENT_ROLE_BROADCASTER = 1,
  /**
   * 2: Audience. An audience member can only receive streams.
   */
  CLIENT_ROLE_AUDIENCE = 2,
};

/**
 * Quality change of the local video in terms of target frame rate and target bit rate since last count.
 */
enum QUALITY_ADAPT_INDICATION {
  /**
   * 0: The quality of the local video stays the same.
   */
  ADAPT_NONE = 0,
  /**
   * 1: The quality improves because the network bandwidth increases.
   */
  ADAPT_UP_BANDWIDTH = 1,
  /**
   * 2: The quality worsens because the network bandwidth decreases.
   */
  ADAPT_DOWN_BANDWIDTH = 2,
};

/**
 * The latency level of an audience member in interactive live streaming. This enum takes effect only
 * when the user role is set to `CLIENT_ROLE_AUDIENCE`.
 */
enum AUDIENCE_LATENCY_LEVEL_TYPE
{
  /**
   * 1: Low latency.
   */
  AUDIENCE_LATENCY_LEVEL_LOW_LATENCY = 1,
  /**
   * 2: Ultra low latency.
   */
  AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY = 2,
};

/**
 * The detailed options of a user.
 */
struct ClientRoleOptions
{
  /**
   * The latency level of an audience member in interactive live streaming. See `AUDIENCE_LATENCY_LEVEL_TYPE`.
   */
  AUDIENCE_LATENCY_LEVEL_TYPE audienceLatencyLevel;

  ClientRoleOptions()
    : audienceLatencyLevel(AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY) {}
};

/**
 * Quality of experience (QoE) of the local user when receiving a remote audio stream.
 */
enum EXPERIENCE_QUALITY_TYPE {
  /** 0: QoE of the local user is good.  */
  EXPERIENCE_QUALITY_GOOD = 0,
  /** 1: QoE of the local user is poor.  */
  EXPERIENCE_QUALITY_BAD = 1,
};

/**
 * Reasons why the QoE of the local user when receiving a remote audio stream is poor.
 */
enum EXPERIENCE_POOR_REASON {
  /**
   * 0: No reason, indicating good QoE of the local user.
   */
  EXPERIENCE_REASON_NONE = 0,
  /**
   * 1: The remote user's network quality is poor.
   */
  REMOTE_NETWORK_QUALITY_POOR = 1,
  /**
   * 2: The local user's network quality is poor.
   */
  LOCAL_NETWORK_QUALITY_POOR = 2,
  /**
   * 4: The local user's Wi-Fi or mobile network signal is weak.
   */
  WIRELESS_SIGNAL_POOR = 4,
  /**
   * 8: The local user enables both Wi-Fi and bluetooth, and their signals interfere with each other.
   * As a result, audio transmission quality is undermined.
   */
  WIFI_BLUETOOTH_COEXIST = 8,
};

/**
 * Audio AINS mode
 */
enum AUDIO_AINS_MODE {
    /**
     * AINS mode with soft suppression level.
     */
    AINS_MODE_BALANCED = 0,
    /**
     * AINS mode with high suppression level.
     */
    AINS_MODE_AGGRESSIVE = 1,
    /**
     * AINS mode with high suppression level and ultra-low-latency
     */
    AINS_MODE_ULTRALOWLATENCY = 2
};

/**
 * Audio profile types.
 */
enum AUDIO_PROFILE_TYPE {
  /**
   * 0: The default audio profile.
   * - For the Communication profile:
   *   - Windows: A sample rate of 16 kHz, audio encoding, mono, and a bitrate of up to 16 Kbps.
   *   - Android/macOS/iOS: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
   * of up to 16 Kbps.
   * - For the Live-broadcast profile: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
   */
  AUDIO_PROFILE_DEFAULT = 0,
  /**
   * 1: A sample rate of 32 kHz, audio encoding, mono, and a bitrate of up to 18 Kbps.
   */
  AUDIO_PROFILE_SPEECH_STANDARD = 1,
  /**
   * 2: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 64 Kbps.
   */
  AUDIO_PROFILE_MUSIC_STANDARD = 2,
  /**
   * 3: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 80 Kbps.
   *
   * To implement stereo audio, you also need to call `setAdvancedAudioOptions` and set `audioProcessingChannels`
   * to `AUDIO_PROCESSING_STEREO` in `AdvancedAudioOptions`.
   */
  AUDIO_PROFILE_MUSIC_STANDARD_STEREO = 3,
  /**
   * 4: A sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 96 Kbps.
   */
  AUDIO_PROFILE_MUSIC_HIGH_QUALITY = 4,
  /**
   * 5: A sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 128 Kbps.
   *
   * To implement stereo audio, you also need to call `setAdvancedAudioOptions` and set `audioProcessingChannels`
   * to `AUDIO_PROCESSING_STEREO` in `AdvancedAudioOptions`.
   */
  AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO = 5,
  /**
   * 6: A sample rate of 16 kHz, audio encoding, mono, and Acoustic Echo Cancellation (AES) enabled.
   */
  AUDIO_PROFILE_IOT = 6,
  AUDIO_PROFILE_NUM = 7
};

/**
 * The audio scenario.
 */
enum AUDIO_SCENARIO_TYPE {
  /**
   * 0: Automatic scenario, where the SDK chooses the appropriate audio quality according to the
   * user role and audio route.
   */
  AUDIO_SCENARIO_DEFAULT = 0,
  /**
   * 3: (Recommended) The live gaming scenario, which needs to enable gaming
   * audio effects in the speaker. Choose this scenario to achieve high-fidelity
   * music playback.
   */
  AUDIO_SCENARIO_GAME_STREAMING = 3,
  /**
   * 5: The chatroom scenario, which needs to keep recording when setClientRole to audience.
   * Normally, app developer can also use mute api to achieve the same result,
   * and we implement this 'non-orthogonal' behavior only to make API backward compatible.
   */
  AUDIO_SCENARIO_CHATROOM = 5,
  /**
   * 7: Real-time chorus scenario, where users have good network conditions and require ultra-low latency.
   */
  AUDIO_SCENARIO_CHORUS = 7,
  /**
   * 8: Meeting
   */
  AUDIO_SCENARIO_MEETING = 8,
  /**
   * 9: The number of enumerations.
   */
  AUDIO_SCENARIO_NUM = 9,
};

/**
 * The format of the video frame.
 */
struct VideoFormat {
  OPTIONAL_ENUM_SIZE_T {
    /** The maximum value (px) of the width. */
    kMaxWidthInPixels = 3840,
    /** The maximum value (px) of the height. */
    kMaxHeightInPixels = 2160,
    /** The maximum value (fps) of the frame rate. */
    kMaxFps = 60,
  };

  /**
   * The width (px) of the video.
   */
  int width;   // Number of pixels.
  /**
   * The height (px) of the video.
   */
  int height;  // Number of pixels.
  /**
   * The video frame rate (fps).
   */
  int fps;
  VideoFormat() : width(FRAME_WIDTH_960), height(FRAME_HEIGHT_540), fps(FRAME_RATE_FPS_15) {}
  VideoFormat(int w, int h, int f) : width(w), height(h), fps(f) {}

  bool operator<(const VideoFormat& fmt) const {
    if (height != fmt.height) {
      return height < fmt.height;
    } else if (width != fmt.width) {
      return width < fmt.width;
    } else {
      return fps < fmt.fps;
    }
  }
  bool operator==(const VideoFormat& fmt) const {
    return width == fmt.width && height == fmt.height && fps == fmt.fps;
  }
  bool operator!=(const VideoFormat& fmt) const {
    return !operator==(fmt);
  }
};

/**
 * Video content hints.
 */
enum VIDEO_CONTENT_HINT {
  /**
   * (Default) No content hint. In this case, the SDK balances smoothness with sharpness.
   */
  CONTENT_HINT_NONE,
  /**
   * Choose this option if you prefer smoothness or when
   * you are sharing motion-intensive content such as a video clip, movie, or video game.
   *
   *
   */
  CONTENT_HINT_MOTION,
  /**
   * Choose this option if you prefer sharpness or when you are
   * sharing montionless content such as a picture, PowerPoint slide, ot text.
   *
   */
  CONTENT_HINT_DETAILS
};
/**
 * The screen sharing scenario.
 */
enum SCREEN_SCENARIO_TYPE {
  /**
   * 1: Document. This scenario prioritizes the video quality of screen sharing and reduces the
   * latency of the shared video for the receiver. If you share documents, slides, and tables,
   * you can set this scenario.
   */
  SCREEN_SCENARIO_DOCUMENT = 1,
  /**
   * 2: Game. This scenario prioritizes the smoothness of screen sharing. If you share games, you
   * can set this scenario.
   */
  SCREEN_SCENARIO_GAMING = 2,
  /**
   * 3: Video. This scenario prioritizes the smoothness of screen sharing. If you share movies or
   * live videos, you can set this scenario.
   */
  SCREEN_SCENARIO_VIDEO = 3,
  /**
   * 4: Remote control. This scenario prioritizes the video quality of screen sharing and reduces
   * the latency of the shared video for the receiver. If you share the device desktop being
   * remotely controlled, you can set this scenario.
   */
  SCREEN_SCENARIO_RDC = 4,
};


/**
 * The video application scenario type.
 */
enum VIDEO_APPLICATION_SCENARIO_TYPE {
  /**
   * 0: Default Scenario.
   */
  APPLICATION_SCENARIO_GENERAL = 0,
  /**
   * 1: Meeting Scenario. This scenario is the best QoE practice of meeting application.
   */
  APPLICATION_SCENARIO_MEETING = 1,
  /**
   * 2: Video Call Scenario. This scenario is used to optimize the video experience in video application, like 1v1 video call.
   */
  APPLICATION_SCENARIO_1V1 = 2,
};

/**
 * The video QoE preference type.
 */
enum VIDEO_QOE_PREFERENCE_TYPE {
  /**
   * 1: Default QoE type, balance the delay, picture quality and fluency.
   */
  VIDEO_QOE_PREFERENCE_BALANCE = 1,
  /**
   * 2: lower the e2e delay.
   */
  VIDEO_QOE_PREFERENCE_DELAY_FIRST = 2,
  /**
   * 3: picture quality.
   */
  VIDEO_QOE_PREFERENCE_PICTURE_QUALITY_FIRST = 3,
  /**
   * 4: more fluency.
   */
  VIDEO_QOE_PREFERENCE_FLUENCY_FIRST = 4,

};

/**
 * The brightness level of the video image captured by the local camera.
 */
enum CAPTURE_BRIGHTNESS_LEVEL_TYPE {
  /** -1: The SDK does not detect the brightness level of the video image.
   * Wait a few seconds to get the brightness level from `CAPTURE_BRIGHTNESS_LEVEL_TYPE` in the next callback.
   */
  CAPTURE_BRIGHTNESS_LEVEL_INVALID = -1,
  /** 0: The brightness level of the video image is normal.
   */
  CAPTURE_BRIGHTNESS_LEVEL_NORMAL = 0,
  /** 1: The brightness level of the video image is too bright.
   */
  CAPTURE_BRIGHTNESS_LEVEL_BRIGHT = 1,
  /** 2: The brightness level of the video image is too dark.
   */
  CAPTURE_BRIGHTNESS_LEVEL_DARK = 2,
};

enum CAMERA_STABILIZATION_MODE {
  /** The camera stabilization mode is disabled. 
  */
  CAMERA_STABILIZATION_MODE_OFF = -1,
  /** device choose stabilization mode automatically. 
  */
  CAMERA_STABILIZATION_MODE_AUTO = 0,
  /** stabilization mode level 1. 
  */
  CAMERA_STABILIZATION_MODE_LEVEL_1 = 1,
  /** stabilization mode level 2. 
  */
  CAMERA_STABILIZATION_MODE_LEVEL_2 = 2,
  /** stabilization mode level 3. 
  */
  CAMERA_STABILIZATION_MODE_LEVEL_3 = 3,
  /** The maximum level of the camera stabilization mode.
   */
  CAMERA_STABILIZATION_MODE_MAX_LEVEL = CAMERA_STABILIZATION_MODE_LEVEL_3,
};

/**
 * Local audio states.
 */
enum LOCAL_AUDIO_STREAM_STATE {
  /**
   * 0: The local audio is in the initial state.
   */
  LOCAL_AUDIO_STREAM_STATE_STOPPED = 0,
  /**
   * 1: The capturing device starts successfully.
   */
  LOCAL_AUDIO_STREAM_STATE_RECORDING = 1,
  /**
   * 2: The first audio frame encodes successfully.
   */
  LOCAL_AUDIO_STREAM_STATE_ENCODING = 2,
  /**
   * 3: The local audio fails to start.
   */
  LOCAL_AUDIO_STREAM_STATE_FAILED = 3
};

/**
 * Local audio state error codes.
 */
enum LOCAL_AUDIO_STREAM_REASON {
  /**
   * 0: The local audio is normal.
   */
  LOCAL_AUDIO_STREAM_REASON_OK = 0,
  /**
   * 1: No specified reason for the local audio failure. Remind your users to try to rejoin the channel.
   */
  LOCAL_AUDIO_STREAM_REASON_FAILURE = 1,
  /**
   * 2: No permission to use the local audio device. Remind your users to grant permission.
   */
  LOCAL_AUDIO_STREAM_REASON_DEVICE_NO_PERMISSION = 2,
  /**
   * 3: (Android and iOS only) The local audio capture device is used. Remind your users to check
   * whether another application occupies the microphone. Local audio capture automatically resume
   * after the microphone is idle for about five seconds. You can also try to rejoin the channel
   * after the microphone is idle.
   */
  LOCAL_AUDIO_STREAM_REASON_DEVICE_BUSY = 3,
  /**
   * 4: The local audio capture failed.
   */
  LOCAL_AUDIO_STREAM_REASON_RECORD_FAILURE = 4,
  /**
   * 5: The local audio encoding failed.
   */
  LOCAL_AUDIO_STREAM_REASON_ENCODE_FAILURE = 5,
  /** 6: The SDK cannot find the local audio recording device.
   */
  LOCAL_AUDIO_STREAM_REASON_NO_RECORDING_DEVICE = 6,
  /** 7: The SDK cannot find the local audio playback device.
   */
  LOCAL_AUDIO_STREAM_REASON_NO_PLAYOUT_DEVICE = 7,
  /**
   * 8: The local audio capturing is interrupted by the system call.
   */
  LOCAL_AUDIO_STREAM_REASON_INTERRUPTED = 8,
  /** 9: An invalid audio capture device ID.
   */
  LOCAL_AUDIO_STREAM_REASON_RECORD_INVALID_ID = 9,
  /** 10: An invalid audio playback device ID.
   */
  LOCAL_AUDIO_STREAM_REASON_PLAYOUT_INVALID_ID = 10,
};

/** Local video state types.
 */
enum LOCAL_VIDEO_STREAM_STATE {
  /**
   * 0: The local video is in the initial state.
   */
  LOCAL_VIDEO_STREAM_STATE_STOPPED = 0,
  /**
   * 1: The local video capturing device starts successfully. The SDK also reports this state when
   * you call `startScreenCaptureByWindowId` to share a maximized window.
   */
  LOCAL_VIDEO_STREAM_STATE_CAPTURING = 1,
  /**
   * 2: The first video frame is successfully encoded.
   */
  LOCAL_VIDEO_STREAM_STATE_ENCODING = 2,
  /**
   * 3: Fails to start the local video.
   */
  LOCAL_VIDEO_STREAM_STATE_FAILED = 3
};

/**
 * Local video state error codes.
 */
enum LOCAL_VIDEO_STREAM_REASON {
  /**
   * 0: The local video is normal.
   */
  LOCAL_VIDEO_STREAM_REASON_OK = 0,
  /**
   * 1: No specified reason for the local video failure.
   */
  LOCAL_VIDEO_STREAM_REASON_FAILURE = 1,
  /**
   * 2: No permission to use the local video capturing device. Remind the user to grant permission
   * and rejoin the channel.
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_NO_PERMISSION = 2,
  /**
   * 3: The local video capturing device is in use. Remind the user to check whether another
   * application occupies the camera.
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_BUSY = 3,
  /**
   * 4: The local video capture fails. Remind the user to check whether the video capture device
   * is working properly or the camera is occupied by another application, and then to rejoin the
   * channel.
   */
  LOCAL_VIDEO_STREAM_REASON_CAPTURE_FAILURE = 4,
  /**
   * 5: The local video encoder is not supported.
   */
  LOCAL_VIDEO_STREAM_REASON_CODEC_NOT_SUPPORT = 5,
  /**
   * 6: (iOS only) The app is in the background. Remind the user that video capture cannot be
   * performed normally when the app is in the background.
   */
  LOCAL_VIDEO_STREAM_REASON_CAPTURE_INBACKGROUND = 6,
  /**
   * 7: (iOS only) The current application window is running in Slide Over, Split View, or Picture
   * in Picture mode, and another app is occupying the camera. Remind the user that the application
   * cannot capture video properly when the app is running in Slide Over, Split View, or Picture in
   * Picture mode and another app is occupying the camera.
   */
  LOCAL_VIDEO_STREAM_REASON_CAPTURE_MULTIPLE_FOREGROUND_APPS = 7,
  /**
   * 8: Fails to find a local video capture device. Remind the user to check whether the camera is
   * connected to the device properly or the camera is working properly, and then to rejoin the
   * channel.
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_NOT_FOUND = 8,
  /**
   *  9: (macOS only) The video capture device currently in use is disconnected (such as being
   * unplugged).
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_DISCONNECTED = 9,
  /**
   * 10: (macOS and Windows only) The SDK cannot find the video device in the video device list.
   * Check whether the ID of the video device is valid.
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_INVALID_ID = 10,
  /**
   * 14: (Android only) Video capture was interrupted, possibly due to the camera being occupied
   * or some policy reasons such as background termination.
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_INTERRUPT = 14,
  /**
   * 15: (Android only) The device may need to be shut down and restarted to restore camera function, 
   * or there may be a persistent hardware problem.
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_FATAL_ERROR = 15,
  /**
   * 101: The current video capture device is unavailable due to excessive system pressure.
   */
  LOCAL_VIDEO_STREAM_REASON_DEVICE_SYSTEM_PRESSURE = 101,
  /**
   * 11: (macOS only) The shared window is minimized when you call `startScreenCaptureByWindowId`
   * to share a window. The SDK cannot share a minimized window. You can cancel the minimization
   * of this window at the application layer, for example by maximizing this window.
   */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_WINDOW_MINIMIZED = 11,
  /**
   * 12: (macOS and Windows only) The error code indicates that a window shared by the window ID
   * has been closed or a full-screen window shared by the window ID has exited full-screen mode.
   * After exiting full-screen mode, remote users cannot see the shared window. To prevent remote
   * users from seeing a black screen, Agora recommends that you immediately stop screen sharing.
   *
   * Common scenarios for reporting this error code:
   * - When the local user closes the shared window, the SDK reports this error code.
   * - The local user shows some slides in full-screen mode first, and then shares the windows of
   * the slides. After the user exits full-screen mode, the SDK reports this error code.
   * - The local user watches a web video or reads a web document in full-screen mode first, and
   * then shares the window of the web video or document. After the user exits full-screen mode,
   * the SDK reports this error code.
   */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_WINDOW_CLOSED = 12,
  /** 13: The local screen capture window is occluded. */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_WINDOW_OCCLUDED = 13,
  /** 20: The local screen capture window is not supported. */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_WINDOW_NOT_SUPPORTED = 20,
  /** 21: The screen capture fails. */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_FAILURE = 21,
  /** 22: No permision to capture screen. */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_NO_PERMISSION = 22,
  /**
   * 24: (Windows Only) An unexpected error (possibly due to window block failure) occurs during the screen 
   * sharing process, resulting in performance degradation. However, the screen sharing process itself is 
   * functioning normally.
   */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_AUTO_FALLBACK = 24,
  /** 25: (Windows only) The local screen capture window is currently hidden and not visible on the desktop. */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_WINDOW_HIDDEN = 25,
  /** 26: (Windows only) The local screen capture window is recovered from its hidden state. */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN = 26,
  /** 27: (Windows and macOS only) The window is recovered from miniminzed */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED = 27,
    /** 
   * 28: The screen capture paused.
   * 
   * Common scenarios for reporting this error code:
   * - When the desktop switch to the secure desktop such as UAC dialog or the Winlogon desktop on
   * Windows platform, the SDK reports this error code.
   */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_PAUSED = 28,
  /** 29: The screen capture is resumed. */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_RESUMED = 29,
  /** 30: The shared display has been disconnected */
  LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_DISPLAY_DISCONNECTED = 30,

};

/**
 * Remote audio states.
 */
enum REMOTE_AUDIO_STATE
{
  /**
   * 0: The remote audio is in the default state. The SDK reports this state in the case of
   * `REMOTE_AUDIO_REASON_LOCAL_MUTED(3)`, `REMOTE_AUDIO_REASON_REMOTE_MUTED(5)`, or
   * `REMOTE_AUDIO_REASON_REMOTE_OFFLINE(7)`.
   */
  REMOTE_AUDIO_STATE_STOPPED = 0,  // Default state, audio is started or remote user disabled/muted audio stream
  /**
   * 1: The first remote audio packet is received.
   */
  REMOTE_AUDIO_STATE_STARTING = 1,  // The first audio frame packet has been received
  /**
   * 2: The remote audio stream is decoded and plays normally. The SDK reports this state in the case of
   * `REMOTE_AUDIO_REASON_NETWORK_RECOVERY(2)`, `REMOTE_AUDIO_REASON_LOCAL_UNMUTED(4)`, or
   * `REMOTE_AUDIO_REASON_REMOTE_UNMUTED(6)`.
   */
  REMOTE_AUDIO_STATE_DECODING = 2,  // The first remote audio frame has been decoded or fronzen state ends
  /**
   * 3: The remote audio is frozen. The SDK reports this state in the case of
   * `REMOTE_AUDIO_REASON_NETWORK_CONGESTION(1)`.
   */
  REMOTE_AUDIO_STATE_FROZEN = 3,    // Remote audio is frozen, probably due to network issue
  /**
   * 4: The remote audio fails to start. The SDK reports this state in the case of
   * `REMOTE_AUDIO_REASON_INTERNAL(0)`.
   */
  REMOTE_AUDIO_STATE_FAILED = 4,    // Remote audio play failed
};

/**
 * Reasons for the remote audio state change.
 */
enum REMOTE_AUDIO_STATE_REASON
{
  /**
   * 0: The SDK reports this reason when the video state changes.
   */
  REMOTE_AUDIO_REASON_INTERNAL = 0,
  /**
   * 1: Network congestion.
   */
  REMOTE_AUDIO_REASON_NETWORK_CONGESTION = 1,
  /**
   * 2: Network recovery.
   */
  REMOTE_AUDIO_REASON_NETWORK_RECOVERY = 2,
  /**
   * 3: The local user stops receiving the remote audio stream or
   * disables the audio module.
   */
  REMOTE_AUDIO_REASON_LOCAL_MUTED = 3,
  /**
   * 4: The local user resumes receiving the remote audio stream or
   * enables the audio module.
   */
  REMOTE_AUDIO_REASON_LOCAL_UNMUTED = 4,
  /**
   * 5: The remote user stops sending the audio stream or disables the
   * audio module.
   */
  REMOTE_AUDIO_REASON_REMOTE_MUTED = 5,
  /**
   * 6: The remote user resumes sending the audio stream or enables the
   * audio module.
   */
  REMOTE_AUDIO_REASON_REMOTE_UNMUTED = 6,
  /**
   * 7: The remote user leaves the channel.
   */
  REMOTE_AUDIO_REASON_REMOTE_OFFLINE = 7,
  /**
   * 8: The local user does not receive any audio packet from remote user.
   */
  REMOTE_AUDIO_REASON_NO_PACKET_RECEIVE = 8,
  /**
   * 9: The local user receives remote audio packet but fails to play.
   */
  REMOTE_AUDIO_REASON_LOCAL_PLAY_FAILED = 9,
};

/**
 * The state of the remote video.
 */
enum REMOTE_VIDEO_STATE {
  /**
   * 0: The remote video is in the default state. The SDK reports this state in the case of
   * `REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED (3)`, `REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED (5)`,
   * `REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE (7)`, or `REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK (8)`.
   */
  REMOTE_VIDEO_STATE_STOPPED = 0,
  /**
   * 1: The first remote video packet is received.
   */
  REMOTE_VIDEO_STATE_STARTING = 1,
  /**
   * 2: The remote video stream is decoded and plays normally. The SDK reports this state in the case of
   * `REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY (2)`, `REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED (4)`,
   * `REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED (6)`, or `REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY (9)`.
   */
  REMOTE_VIDEO_STATE_DECODING = 2,
  /** 3: The remote video is frozen, probably due to
   * #REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION (1).
   */
  REMOTE_VIDEO_STATE_FROZEN = 3,
  /** 4: The remote video fails to start. The SDK reports this state in the case of
   * `REMOTE_VIDEO_STATE_REASON_INTERNAL (0)`.
   */
  REMOTE_VIDEO_STATE_FAILED = 4,
};
/**
 * The reason for the remote video state change.
 */
enum REMOTE_VIDEO_STATE_REASON {
  /**
  * 0: The SDK reports this reason when the video state changes.
  */
  REMOTE_VIDEO_STATE_REASON_INTERNAL = 0,
  /**
  * 1: Network congestion.
  */
  REMOTE_VIDEO_STATE_REASON_NETWORK_CONGESTION = 1,
  /**
  * 2: Network recovery.
  */
  REMOTE_VIDEO_STATE_REASON_NETWORK_RECOVERY = 2,
  /**
  * 3: The local user stops receiving the remote video stream or disables the video module.
  */
  REMOTE_VIDEO_STATE_REASON_LOCAL_MUTED = 3,
  /**
  * 4: The local user resumes receiving the remote video stream or enables the video module.
  */
  REMOTE_VIDEO_STATE_REASON_LOCAL_UNMUTED = 4,
  /**
  * 5: The remote user stops sending the video stream or disables the video module.
  */
  REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED = 5,
  /**
  * 6: The remote user resumes sending the video stream or enables the video module.
  */
  REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED = 6,
  /**
  * 7: The remote user leaves the channel.
  */
  REMOTE_VIDEO_STATE_REASON_REMOTE_OFFLINE = 7,
  /** 8: The remote audio-and-video stream falls back to the audio-only stream
   * due to poor network conditions.
   */
  REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK = 8,
  /** 9: The remote audio-only stream switches back to the audio-and-video
   * stream after the network conditions improve.
   */
  REMOTE_VIDEO_STATE_REASON_AUDIO_FALLBACK_RECOVERY = 9,
  /** (Internal use only) 10: The remote video stream type change to low stream type
   */
  REMOTE_VIDEO_STATE_REASON_VIDEO_STREAM_TYPE_CHANGE_TO_LOW = 10,
  /** (Internal use only)  11: The remote video stream type change to high stream type
   */
  REMOTE_VIDEO_STATE_REASON_VIDEO_STREAM_TYPE_CHANGE_TO_HIGH = 11,
    /** (iOS only) 12: The app of the remote user is in background.
   */
  REMOTE_VIDEO_STATE_REASON_SDK_IN_BACKGROUND = 12,

  /** 13: The remote video stream is not supported by the decoder
   */
  REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT = 13,

};

/**
 * The remote user state information.
 */
enum REMOTE_USER_STATE {
  /**
   * The remote user has muted the audio.
   */
  USER_STATE_MUTE_AUDIO = (1 << 0),
  /**
   * The remote user has muted the video.
   */
  USER_STATE_MUTE_VIDEO = (1 << 1),
  /**
   * The remote user has enabled the video, which includes video capturing and encoding.
   */
  USER_STATE_ENABLE_VIDEO = (1 << 4),
  /**
   * The remote user has enabled the local video capturing.
   */
  USER_STATE_ENABLE_LOCAL_VIDEO = (1 << 8),
};

/**
 * The definition of the VideoTrackInfo struct, which contains information of
 * the video track.
 */
struct VideoTrackInfo {
  VideoTrackInfo()
  : isLocal(false), ownerUid(0), trackId(0), channelId(OPTIONAL_NULLPTR)
  , codecType(VIDEO_CODEC_H265)
  , encodedFrameOnly(false), sourceType(VIDEO_SOURCE_CAMERA_PRIMARY)
  , observationPosition(agora::media::base::POSITION_POST_CAPTURER) {}
  /**
   * Whether the video track is local or remote.
   * - true: The video track is local.
   * - false: The video track is remote.
   */
  bool isLocal;
  /**
   * ID of the user who publishes the video track.
   */
  uid_t ownerUid;
  /**
   * ID of the video track.
   */
  track_id_t trackId;
  /**
   * The channel ID of the video track.
   */
  const char* channelId;
  /**
   * The video codec type: #VIDEO_CODEC_TYPE.
   */
  VIDEO_CODEC_TYPE codecType;
  /**
   * Whether the video track contains encoded video frame only.
   * - true: The video track contains encoded video frame only.
   * - false: The video track does not contain encoded video frame only.
   */
  bool encodedFrameOnly;
  /**
   * The video source type: #VIDEO_SOURCE_TYPE
   */
  VIDEO_SOURCE_TYPE sourceType;
  /**
   * the frame position for the video observer: #VIDEO_MODULE_POSITION
   */
  uint32_t observationPosition;
};

/**
 * The downscale level of the remote video stream . The higher the downscale level, the more the video downscales.
 */
enum REMOTE_VIDEO_DOWNSCALE_LEVEL {
  /**
   * No downscale.
   */
  REMOTE_VIDEO_DOWNSCALE_LEVEL_NONE,
  /**
   * Downscale level 1.
   */
  REMOTE_VIDEO_DOWNSCALE_LEVEL_1,
  /**
   * Downscale level 2.
   */
  REMOTE_VIDEO_DOWNSCALE_LEVEL_2,
  /**
   * Downscale level 3.
   */
  REMOTE_VIDEO_DOWNSCALE_LEVEL_3,
  /**
   * Downscale level 4.
   */
  REMOTE_VIDEO_DOWNSCALE_LEVEL_4,
};

/**
 * The volume information of users.
 */
struct AudioVolumeInfo {
  /**
   * User ID of the speaker.
   * - In the local user's callback, `uid` = 0.
   * - In the remote users' callback, `uid` is the user ID of a remote user whose instantaneous
   * volume is one of the three highest.
   */
  uid_t uid;
  /**
   * The volume of the user. The value ranges between 0 (the lowest volume) and 255 (the highest
   * volume). If the user calls `startAudioMixing`, the value of volume is the volume after audio
   * mixing.
   */
  unsigned int volume;  // [0,255]
  /**
   * Voice activity status of the local user.
   * - 0: The local user is not speaking.
   * - 1: The local user is speaking.
   * @note
   * - The `vad` parameter does not report the voice activity status of remote users. In a remote
   * user's callback, the value of `vad` is always 1.
   * - To use this parameter, you must set `reportVad` to true when calling `enableAudioVolumeIndication`.
   */
  unsigned int vad;
  /**
   * The voice pitch (Hz) of the local user. The value ranges between 0.0 and 4000.0.
   * @note The `voicePitch` parameter does not report the voice pitch of remote users. In the
   * remote users' callback, the value of `voicePitch` is always 0.0.
   */
  double voicePitch;

  AudioVolumeInfo() : uid(0), volume(0), vad(0), voicePitch(0.0) {}
};

/**
 * The audio device information.
 */
struct DeviceInfo {
  /*
   * Whether the audio device supports ultra-low-latency capture and playback:
   * - `true`: The device supports ultra-low-latency capture and playback.
   * - `false`: The device does not support ultra-low-latency capture and playback.
   */
  bool isLowLatencyAudioSupported;

  DeviceInfo() : isLowLatencyAudioSupported(false) {}
};

/**
 * The definition of the IPacketObserver struct.
 */
class IPacketObserver {
 public:
  virtual ~IPacketObserver() {}
  /**
   * The definition of the Packet struct.
   */
  struct Packet {
    /**
     * The buffer address of the sent or received data.
     * @note Agora recommends setting `buffer` to a value larger than 2048 bytes. Otherwise, you
     * may encounter undefined behaviors (such as crashes).
     */
    const unsigned char* buffer;
    /**
     * The buffer size of the sent or received data.
     */
    unsigned int size;

    Packet() : buffer(OPTIONAL_NULLPTR), size(0) {}
  };
  /**
   * Occurs when the SDK is ready to send the audio packet.
   * @param packet The audio packet to be sent: Packet.
   * @return Whether to send the audio packet:
   * - true: Send the packet.
   * - false: Do not send the packet, in which case the audio packet will be discarded.
   */
  virtual bool onSendAudioPacket(Packet& packet) = 0;
  /**
   * Occurs when the SDK is ready to send the video packet.
   * @param packet The video packet to be sent: Packet.
   * @return Whether to send the video packet:
   * - true: Send the packet.
   * - false: Do not send the packet, in which case the audio packet will be discarded.
   */
  virtual bool onSendVideoPacket(Packet& packet) = 0;
  /**
   * Occurs when the audio packet is received.
   * @param packet The received audio packet: Packet.
   * @return Whether to process the audio packet:
   * - true: Process the packet.
   * - false: Do not process the packet, in which case the audio packet will be discarded.
   */
  virtual bool onReceiveAudioPacket(Packet& packet) = 0;
  /**
   * Occurs when the video packet is received.
   * @param packet The received video packet: Packet.
   * @return Whether to process the audio packet:
   * - true: Process the packet.
   * - false: Do not process the packet, in which case the video packet will be discarded.
   */
  virtual bool onReceiveVideoPacket(Packet& packet) = 0;
};

/**
 * Audio sample rate types.
 */
enum AUDIO_SAMPLE_RATE_TYPE {
  /**
   * 32000: 32 KHz.
   */
  AUDIO_SAMPLE_RATE_32000 = 32000,
  /**
   * 44100: 44.1 KHz.
   */
  AUDIO_SAMPLE_RATE_44100 = 44100,
  /**
   * 48000: 48 KHz.
   */
  AUDIO_SAMPLE_RATE_48000 = 48000,
};
/**
 * The codec type of the output video.
 */
enum VIDEO_CODEC_TYPE_FOR_STREAM {
  /**
   * 1: H.264.
   */
  VIDEO_CODEC_H264_FOR_STREAM = 1,
  /**
   * 2: H.265.
   */
  VIDEO_CODEC_H265_FOR_STREAM = 2,
};

/**
 * Video codec profile types.
 */
enum VIDEO_CODEC_PROFILE_TYPE {
  /**
   * 66: Baseline video codec profile. Generally used in video calls on mobile phones.
   */
  VIDEO_CODEC_PROFILE_BASELINE = 66,
  /**
   * 77: Main video codec profile. Generally used in mainstream electronics, such as MP4 players, portable video players, PSP, and iPads.
   */
  VIDEO_CODEC_PROFILE_MAIN = 77,
  /**
   * 100: High video codec profile. Generally used in high-resolution broadcasts or television.
   */
  VIDEO_CODEC_PROFILE_HIGH = 100,
};


/**
 * Self-defined audio codec profile.
 */
enum AUDIO_CODEC_PROFILE_TYPE {
  /**
   * 0: LC-AAC.
   */
  AUDIO_CODEC_PROFILE_LC_AAC = 0,
  /**
   * 1: HE-AAC.
   */
  AUDIO_CODEC_PROFILE_HE_AAC = 1,
  /**
   *  2: HE-AAC v2.
   */
  AUDIO_CODEC_PROFILE_HE_AAC_V2 = 2,
};

/**
 * Local audio statistics.
 */
struct LocalAudioStats
{
  /**
   * The number of audio channels.
   */
  int numChannels;
  /**
   * The sampling rate (Hz) of sending the local user's audio stream.
   */
  int sentSampleRate;
  /**
   * The average bitrate (Kbps) of sending the local user's audio stream.
   */
  int sentBitrate;
  /**
   * The internal payload codec.
   */
  int internalCodec;
  /**
   * The packet loss rate (%) from the local client to the Agora server before applying the anti-packet loss strategies.
   */
  unsigned short txPacketLossRate;
  /**
   * The audio delay of the device, contains record and playout delay
   */
  int audioDeviceDelay;
  /**
   * The playout delay of the device
   */
  int audioPlayoutDelay;
  /**
   * The signal delay estimated from audio in-ear monitoring (ms).
   */
  int earMonitorDelay;
  /**
   * The signal delay estimated during the AEC process from nearin and farin (ms).
   */
  int aecEstimatedDelay;
};


/**
 * States of the Media Push.
 */
enum RTMP_STREAM_PUBLISH_STATE {
  /**
   * 0: The Media Push has not started or has ended. This state is also triggered after you remove a RTMP or RTMPS stream from the CDN by calling `removePublishStreamUrl`.
   */
  RTMP_STREAM_PUBLISH_STATE_IDLE = 0,
  /**
   * 1: The SDK is connecting to Agora's streaming server and the CDN server. This state is triggered after you call the `addPublishStreamUrl` method.
   */
  RTMP_STREAM_PUBLISH_STATE_CONNECTING = 1,
  /**
   * 2: The RTMP or RTMPS streaming publishes. The SDK successfully publishes the RTMP or RTMPS streaming and returns this state.
   */
  RTMP_STREAM_PUBLISH_STATE_RUNNING = 2,
  /**
   * 3: The RTMP or RTMPS streaming is recovering. When exceptions occur to the CDN, or the streaming is interrupted, the SDK tries to resume RTMP or RTMPS streaming and returns this state.
   * - If the SDK successfully resumes the streaming, #RTMP_STREAM_PUBLISH_STATE_RUNNING (2) returns.
   * - If the streaming does not resume within 60 seconds or server errors occur, #RTMP_STREAM_PUBLISH_STATE_FAILURE (4) returns. You can also reconnect to the server by calling the `removePublishStreamUrl` and `addPublishStreamUrl` methods.
   */
  RTMP_STREAM_PUBLISH_STATE_RECOVERING = 3,
  /**
   * 4: The RTMP or RTMPS streaming fails. See the `errCode` parameter for the detailed error information. You can also call the `addPublishStreamUrl` method to publish the RTMP or RTMPS streaming again.
   */
  RTMP_STREAM_PUBLISH_STATE_FAILURE = 4,
  /**
   * 5: The SDK is disconnecting to Agora's streaming server and the CDN server. This state is triggered after you call the `removePublishStreamUrl` method.
   */
  RTMP_STREAM_PUBLISH_STATE_DISCONNECTING = 5,
};

/**
 * Error codes of the RTMP or RTMPS streaming.
 */
enum RTMP_STREAM_PUBLISH_REASON {
  /**
   * 0: The RTMP or RTMPS streaming publishes successfully.
   */
  RTMP_STREAM_PUBLISH_REASON_OK = 0,
  /**
   * 1: Invalid argument used. If, for example, you do not call the `setLiveTranscoding` method to configure the LiveTranscoding parameters before calling the addPublishStreamUrl method,
   * the SDK returns this error. Check whether you set the parameters in the `setLiveTranscoding` method properly.
   */
  RTMP_STREAM_PUBLISH_REASON_INVALID_ARGUMENT = 1,
  /**
   * 2: The RTMP or RTMPS streaming is encrypted and cannot be published.
   */
  RTMP_STREAM_PUBLISH_REASON_ENCRYPTED_STREAM_NOT_ALLOWED = 2,
  /**
   * 3: Timeout for the RTMP or RTMPS streaming. Call the `addPublishStreamUrl` method to publish the streaming again.
   */
  RTMP_STREAM_PUBLISH_REASON_CONNECTION_TIMEOUT = 3,
  /**
   * 4: An error occurs in Agora's streaming server. Call the `addPublishStreamUrl` method to publish the streaming again.
   */
  RTMP_STREAM_PUBLISH_REASON_INTERNAL_SERVER_ERROR = 4,
  /**
   * 5: An error occurs in the CDN server.
   */
  RTMP_STREAM_PUBLISH_REASON_RTMP_SERVER_ERROR = 5,
  /**
   * 6: The RTMP or RTMPS streaming publishes too frequently.
   */
  RTMP_STREAM_PUBLISH_REASON_TOO_OFTEN = 6,
  /**
   * 7: The host publishes more than 10 URLs. Delete the unnecessary URLs before adding new ones.
   */
  RTMP_STREAM_PUBLISH_REASON_REACH_LIMIT = 7,
  /**
   * 8: The host manipulates other hosts' URLs. Check your app logic.
   */
  RTMP_STREAM_PUBLISH_REASON_NOT_AUTHORIZED = 8,
  /**
   * 9: Agora's server fails to find the RTMP or RTMPS streaming.
   */
  RTMP_STREAM_PUBLISH_REASON_STREAM_NOT_FOUND = 9,
  /**
   * 10: The format of the RTMP or RTMPS streaming URL is not supported. Check whether the URL format is correct.
   */
  RTMP_STREAM_PUBLISH_REASON_FORMAT_NOT_SUPPORTED = 10,
  /**
   * 11: The user role is not host, so the user cannot use the CDN live streaming function. Check your application code logic.
   */
  RTMP_STREAM_PUBLISH_REASON_NOT_BROADCASTER = 11,  // Note: match to ERR_PUBLISH_STREAM_NOT_BROADCASTER in AgoraBase.h
  /**
   * 13: The `updateRtmpTranscoding` or `setLiveTranscoding` method is called to update the transcoding configuration in a scenario where there is streaming without transcoding. Check your application code logic.
   */
  RTMP_STREAM_PUBLISH_REASON_TRANSCODING_NO_MIX_STREAM = 13,  // Note: match to ERR_PUBLISH_STREAM_TRANSCODING_NO_MIX_STREAM in AgoraBase.h
  /**
   * 14: Errors occurred in the host's network.
   */
  RTMP_STREAM_PUBLISH_REASON_NET_DOWN = 14,  // Note: match to ERR_NET_DOWN in AgoraBase.h
  /**
   * 15: Your App ID does not have permission to use the CDN live streaming function.
   */
  RTMP_STREAM_PUBLISH_REASON_INVALID_APPID = 15,  // Note: match to ERR_PUBLISH_STREAM_APPID_INVALID in AgoraBase.h
  /** invalid privilege. */
  RTMP_STREAM_PUBLISH_REASON_INVALID_PRIVILEGE = 16,
  /**
   * 100: The streaming has been stopped normally. After you call `removePublishStreamUrl` to stop streaming, the SDK returns this value.
   */
  RTMP_STREAM_UNPUBLISH_REASON_OK = 100,
};

/** Events during the RTMP or RTMPS streaming. */
enum RTMP_STREAMING_EVENT {
  /**
   * 1: An error occurs when you add a background image or a watermark image to the RTMP or RTMPS stream.
   */
  RTMP_STREAMING_EVENT_FAILED_LOAD_IMAGE = 1,
  /**
   * 2: The streaming URL is already being used for CDN live streaming. If you want to start new streaming, use a new streaming URL.
   */
  RTMP_STREAMING_EVENT_URL_ALREADY_IN_USE = 2,
  /**
   * 3: The feature is not supported.
   */
  RTMP_STREAMING_EVENT_ADVANCED_FEATURE_NOT_SUPPORT = 3,
  /**
   * 4: Client request too frequently.
   */
  RTMP_STREAMING_EVENT_REQUEST_TOO_OFTEN = 4,
};

/**
 * Image properties.
 */
typedef struct RtcImage {
  /**
   *The HTTP/HTTPS URL address of the image in the live video. The maximum length of this parameter is 1024 bytes.
   */
  const char* url;
  /**
   * The x coordinate (pixel) of the image on the video frame (taking the upper left corner of the video frame as the origin).
   */
  int x;
  /**
   * The y coordinate (pixel) of the image on the video frame (taking the upper left corner of the video frame as the origin).
   */
  int y;
  /**
   * The width (pixel) of the image on the video frame.
   */
  int width;
  /**
   * The height (pixel) of the image on the video frame.
   */
  int height;
  /**
   * The layer index of the watermark or background image. When you use the watermark array to add
   * a watermark or multiple watermarks, you must pass a value to `zOrder` in the range [1,255];
   * otherwise, the SDK reports an error. In other cases, zOrder can optionally be passed in the
   * range [0,255], with 0 being the default value. 0 means the bottom layer and 255 means the top
   * layer.
   */
  int zOrder;
  /** The transparency level of the image. The value ranges between 0.0 and 1.0:
   *
   * - 0.0: Completely transparent.
   * - 1.0: (Default) Opaque.
   */
  double alpha;

  RtcImage() : url(OPTIONAL_NULLPTR), x(0), y(0), width(0), height(0), zOrder(0), alpha(1.0) {}
} RtcImage;
/**
 * The configuration for advanced features of the RTMP or RTMPS streaming with transcoding.
 *
 * If you want to enable the advanced features of streaming with transcoding, contact support@agora.io.
 */
struct LiveStreamAdvancedFeature {
  LiveStreamAdvancedFeature() : featureName(OPTIONAL_NULLPTR), opened(false) {}
  LiveStreamAdvancedFeature(const char* feat_name, bool open) : featureName(feat_name), opened(open) {}
  /** The advanced feature for high-quality video with a lower bitrate. */
  // static const char* LBHQ = "lbhq";
  /** The advanced feature for the optimized video encoder. */
  // static const char* VEO = "veo";

  /**
   * The feature names, including LBHQ (high-quality video with a lower bitrate) and VEO (optimized video encoder).
   */
  const char* featureName;

  /**
   * Whether to enable the advanced features of streaming with transcoding:
   * - `true`: Enable the advanced feature.
   * - `false`: (Default) Disable the advanced feature.
   */
  bool opened;
} ;

/**
 * Connection state types.
 */
enum CONNECTION_STATE_TYPE
{
  /**
   * 1: The SDK is disconnected from the Agora edge server. The state indicates the SDK is in one of the following phases:
   * - The initial state before calling the `joinChannel` method.
   * - The app calls the `leaveChannel` method.
   */
  CONNECTION_STATE_DISCONNECTED = 1,
  /**
   * 2: The SDK is connecting to the Agora edge server. This state indicates that the SDK is
   * establishing a connection with the specified channel after the app calls `joinChannel`.
   * - If the SDK successfully joins the channel, it triggers the `onConnectionStateChanged`
   * callback and the connection state switches to `CONNECTION_STATE_CONNECTED`.
   * - After the connection is established, the SDK also initializes the media and triggers
   * `onJoinChannelSuccess` when everything is ready.
   */
  CONNECTION_STATE_CONNECTING = 2,
  /**
   * 3: The SDK is connected to the Agora edge server. This state also indicates that the user
   * has joined a channel and can now publish or subscribe to a media stream in the channel.
   * If the connection to the Agora edge server is lost because, for example, the network is down
   * or switched, the SDK automatically tries to reconnect and triggers `onConnectionStateChanged`
   * that indicates the connection state switches to `CONNECTION_STATE_RECONNECTING`.
   */
  CONNECTION_STATE_CONNECTED = 3,
  /**
   * 4: The SDK keeps reconnecting to the Agora edge server. The SDK keeps rejoining the channel
   * after being disconnected from a joined channel because of network issues.
   * - If the SDK cannot rejoin the channel within 10 seconds, it triggers `onConnectionLost`,
   * stays in the `CONNECTION_STATE_RECONNECTING` state, and keeps rejoining the channel.
   * - If the SDK fails to rejoin the channel 20 minutes after being disconnected from the Agora
   * edge server, the SDK triggers the `onConnectionStateChanged` callback, switches to the
   * `CONNECTION_STATE_FAILED` state, and stops rejoining the channel.
   */
  CONNECTION_STATE_RECONNECTING = 4,
  /**
   * 5: The SDK fails to connect to the Agora edge server or join the channel. This state indicates
   * that the SDK stops trying to rejoin the channel. You must call `leaveChannel` to leave the
   * channel.
   * - You can call `joinChannel` to rejoin the channel.
   * - If the SDK is banned from joining the channel by the Agora edge server through the RESTful
   * API, the SDK triggers the `onConnectionStateChanged` callback.
   */
  CONNECTION_STATE_FAILED = 5,
};

/**
 * Transcoding configurations of each host.
 */
struct TranscodingUser {
  /**
   * The user ID of the host.
   */
  uid_t uid;
  /**
   * The x coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, width], where width is the `width` set in `LiveTranscoding`.
   */
  int x;
  /**
   * The y coordinate (pixel) of the host's video on the output video frame (taking the upper left corner of the video frame as the origin). The value range is [0, height], where height is the `height` set in `LiveTranscoding`.
   */
  int y;
  /**
   * The width (pixel) of the host's video.
   */
  int width;
  /**
   * The height (pixel) of the host's video.
   */
  int height;
  /**
   * The layer index number of the host's video. The value range is [0, 100].
   * - 0: (Default) The host's video is the bottom layer.
   * - 100: The host's video is the top layer.
   *
   * If the value is beyond this range, the SDK reports the error code `ERR_INVALID_ARGUMENT`.
  */
  int zOrder;
  /**
   * The transparency of the host's video. The value range is [0.0, 1.0].
   * - 0.0: Completely transparent.
   * - 1.0: (Default) Opaque.
   */
  double alpha;
  /**
   * The audio channel used by the host's audio in the output audio. The default value is 0, and the value range is [0, 5].
   * - `0`: (Recommended) The defaut setting, which supports dual channels at most and depends on the upstream of the host.
   * - `1`: The host's audio uses the FL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
   * - `2`: The host's audio uses the FC audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
   * - `3`: The host's audio uses the FR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
   * - `4`: The host's audio uses the BL audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
   * - `5`: The host's audio uses the BR audio channel. If the host's upstream uses multiple audio channels, the Agora server mixes them into mono first.
   * - `0xFF` or a value greater than 5: The host's audio is muted, and the Agora server removes the host's audio.
   *
   * @note If the value is not `0`, a special player is required.
   */
  int audioChannel;

  TranscodingUser()
      : uid(0),
        x(0),
        y(0),
        width(0),
        height(0),
        zOrder(0),
        alpha(1.0),
        audioChannel(0) {}
};

/**
 * Transcoding configurations for Media Push.
 */
struct LiveTranscoding {
  /** The width of the video in pixels. The default value is 360.
   * - When pushing video streams to the CDN, the value range of `width` is [64,1920].
   * If the value is less than 64, Agora server automatically adjusts it to 64; if the
   * value is greater than 1920, Agora server automatically adjusts it to 1920.
   * - When pushing audio streams to the CDN, set `width` and `height` as 0.
   */
  int width;
  /** The height of the video in pixels. The default value is 640.
   * - When pushing video streams to the CDN, the value range of `height` is [64,1080].
   * If the value is less than 64, Agora server automatically adjusts it to 64; if the
   * value is greater than 1080, Agora server automatically adjusts it to 1080.
   * - When pushing audio streams to the CDN, set `width` and `height` as 0.
   */
  int height;
  /** Bitrate of the CDN live output video stream. The default value is 400 Kbps.

  Set this parameter according to the Video Bitrate Table. If you set a bitrate beyond the proper range, the SDK automatically adapts it to a value within the range.
  */
  int videoBitrate;
  /** Frame rate of the output video stream set for the CDN live streaming. The default value is 15 fps, and the value range is (0,30].

  @note The Agora server adjusts any value over 30 to 30.
  */
  int videoFramerate;

  /** **DEPRECATED** Latency mode:

   - true: Low latency with unassured quality.
   - false: (Default) High latency with assured quality.
   */
  bool lowLatency;

  /** Video GOP in frames. The default value is 30 fps.
   */
  int videoGop;
  /** Self-defined video codec profile: #VIDEO_CODEC_PROFILE_TYPE.

  @note If you set this parameter to other values, Agora adjusts it to the default value of 100.
  */
  VIDEO_CODEC_PROFILE_TYPE videoCodecProfile;
  /** The background color in RGB hex value. Value only. Do not include a preceeding #. For example, 0xFFB6C1 (light pink). The default value is 0x000000 (black).
   */
  unsigned int backgroundColor;
  /** Video codec profile types for Media Push. See VIDEO_CODEC_TYPE_FOR_STREAM. */
  VIDEO_CODEC_TYPE_FOR_STREAM videoCodecType;
  /** The number of users in the live interactive streaming.
   *  The value range is [0, 17].
   */
  unsigned int userCount;
  /** Manages the user layout configuration in the Media Push. Agora supports a maximum of 17 transcoding users in a Media Push channel. See `TranscodingUser`.
   */
  TranscodingUser* transcodingUsers;
  /** Reserved property. Extra user-defined information to send SEI for the H.264/H.265 video stream to the CDN live client. Maximum length: 4096 Bytes.

   For more information on SEI frame, see [SEI-related questions](https://docs.agora.io/en/faq/sei).
   */
  const char* transcodingExtraInfo;

  /** **DEPRECATED** The metadata sent to the CDN live client.
   */
  const char* metadata;
  /** The watermark on the live video. The image format needs to be PNG. See `RtcImage`.

  You can add one watermark, or add multiple watermarks using an array. This parameter is used with `watermarkCount`.
  */
  RtcImage* watermark;
  /**
   * The number of watermarks on the live video. The total number of watermarks and background images can range from 0 to 10. This parameter is used with `watermark`.
   */
  unsigned int watermarkCount;

  /** The number of background images on the live video. The image format needs to be PNG. See `RtcImage`.
   *
   * You can add a background image or use an array to add multiple background images. This parameter is used with `backgroundImageCount`.
   */
  RtcImage* backgroundImage;
  /**
   * The number of background images on the live video. The total number of watermarks and background images can range from 0 to 10. This parameter is used with `backgroundImage`.
   */
  unsigned int backgroundImageCount;

  /** The audio sampling rate (Hz) of the output media stream. See #AUDIO_SAMPLE_RATE_TYPE.
   */
  AUDIO_SAMPLE_RATE_TYPE audioSampleRate;
  /** Bitrate (Kbps) of the audio output stream for Media Push. The default value is 48, and the highest value is 128.
   */
  int audioBitrate;
  /** The number of audio channels for Media Push. Agora recommends choosing 1 (mono), or 2 (stereo) audio channels. Special players are required if you choose 3, 4, or 5.
   * - 1: (Default) Mono.
   * - 2: Stereo.
   * - 3: Three audio channels.
   * - 4: Four audio channels.
   * - 5: Five audio channels.
   */
  int audioChannels;
  /** Audio codec profile type for Media Push. See #AUDIO_CODEC_PROFILE_TYPE.
   */
  AUDIO_CODEC_PROFILE_TYPE audioCodecProfile;
  /** Advanced features of the RTMP or RTMPS streaming with transcoding. See LiveStreamAdvancedFeature.
   */
  LiveStreamAdvancedFeature* advancedFeatures;

  /** The number of enabled advanced features. The default value is 0. */
  unsigned int advancedFeatureCount;

  LiveTranscoding()
      : width(360),
        height(640),
        videoBitrate(400),
        videoFramerate(15),
        lowLatency(false),
        videoGop(30),
        videoCodecProfile(VIDEO_CODEC_PROFILE_HIGH),
        backgroundColor(0x000000),
        videoCodecType(VIDEO_CODEC_H264_FOR_STREAM),
        userCount(0), 
        transcodingUsers(OPTIONAL_NULLPTR),
        transcodingExtraInfo(OPTIONAL_NULLPTR),
        metadata(OPTIONAL_NULLPTR),
        watermark(OPTIONAL_NULLPTR),
        watermarkCount(0),
        backgroundImage(OPTIONAL_NULLPTR),
        backgroundImageCount(0),
        audioSampleRate(AUDIO_SAMPLE_RATE_48000),
        audioBitrate(48),
        audioChannels(1),
        audioCodecProfile(AUDIO_CODEC_PROFILE_LC_AAC),
        advancedFeatures(OPTIONAL_NULLPTR),
        advancedFeatureCount(0) {}
};

/**
 * The video streams for the video mixing on the local client.
 */
struct TranscodingVideoStream {
  /**
   * The source type of video for the video mixing on the local client. See #VIDEO_SOURCE_TYPE.
   */
  VIDEO_SOURCE_TYPE sourceType;
  /**
   * The ID of the remote user.
   * @note Use this parameter only when the source type of the video for the video mixing on the local client is `VIDEO_SOURCE_REMOTE`.
   */
  uid_t remoteUserUid;
  /**
   * The URL of the image.
   * @note Use this parameter only when the source type of the video for the video mixing on the local client is `RTC_IMAGE`.
   */
  const char* imageUrl;
  /**
   * MediaPlayer id if sourceType is MEDIA_PLAYER_SOURCE.
   */
  int mediaPlayerId;
  /**
   * The horizontal displacement of the top-left corner of the video for the video mixing on the client relative to the top-left corner (origin) of the canvas for this video mixing.
   */
  int x;
  /**
   * The vertical displacement of the top-left corner of the video for the video mixing on the client relative to the top-left corner (origin) of the canvas for this video mixing.
   */
  int y;
  /**
   * The width (px) of the video for the video mixing on the local client.
   */
  int width;
  /**
   * The height (px) of the video for the video mixing on the local client.
   */
  int height;
  /**
   * The number of the layer to which the video for the video mixing on the local client belongs. The value range is [0,100].
   * - 0: (Default) The layer is at the bottom.
   * - 100: The layer is at the top.
   */
  int zOrder;
  /**
   * The transparency of the video for the video mixing on the local client. The value range is [0.0,1.0]. 0.0 means the transparency is completely transparent. 1.0 means the transparency is opaque.
   */
  double alpha;
  /**
   * Whether to mirror the video for the video mixing on the local client.
   * - true: Mirroring.
   * - false: (Default) Do not mirror.
   * @note The paramter only works for videos with the source type `CAMERA`.
   */
  bool mirror;

  TranscodingVideoStream()
    : sourceType(VIDEO_SOURCE_CAMERA_PRIMARY),
      remoteUserUid(0),
      imageUrl(OPTIONAL_NULLPTR),
      x(0),
      y(0),
      width(0),
      height(0),
      zOrder(0),
      alpha(1.0),
      mirror(false) {}
};

/**
 * The configuration of the video mixing on the local client.
 */
struct LocalTranscoderConfiguration {
  /**
   * The number of the video streams for the video mixing on the local client.
   */
  unsigned int streamCount;
  /**
   * The video streams for the video mixing on the local client. See TranscodingVideoStream.
   */
  TranscodingVideoStream* videoInputStreams;
  /**
   * The encoding configuration of the mixed video stream after the video mixing on the local client. See VideoEncoderConfiguration.
   */
  VideoEncoderConfiguration videoOutputConfiguration;
  /**
   * Whether to use the timestamp when the primary camera captures the video frame as the timestamp of the mixed video frame.
   * - true: (Default) Use the timestamp of the captured video frame as the timestamp of the mixed video frame.
   * - false: Do not use the timestamp of the captured video frame as the timestamp of the mixed video frame. Instead, use the timestamp when the mixed video frame is constructed.
   */
  bool syncWithPrimaryCamera;

  LocalTranscoderConfiguration() : streamCount(0), videoInputStreams(OPTIONAL_NULLPTR), videoOutputConfiguration(), syncWithPrimaryCamera(true) {}
};

enum VIDEO_TRANSCODER_ERROR {
  /**
   * The video track of the video source is not started.
   */
  VT_ERR_VIDEO_SOURCE_NOT_READY = 1,
  /**
   * The video source type is not supported.
   */
  VT_ERR_INVALID_VIDEO_SOURCE_TYPE = 2,
  /**
   * The image url is not correctly of image source.
   */
  VT_ERR_INVALID_IMAGE_PATH = 3,
  /**
   * The image format not the type png/jpeg/gif of image source.
   */
  VT_ERR_UNSUPPORT_IMAGE_FORMAT = 4,
  /**
   * The layout is invalid such as width is zero.
   */
  VT_ERR_INVALID_LAYOUT = 5,
  /**
   * Internal error.
   */
  VT_ERR_INTERNAL = 20
};

/**
 * Configurations of the last-mile network test.
 */
struct LastmileProbeConfig {
  /**
   * Determines whether to test the uplink network. Some users, for example,
   * the audience in a live broadcast channel, do not need such a test:
   * - true: Test.
   * - false: Do not test.
   */
  bool probeUplink;
  /**
   * Determines whether to test the downlink network:
   * - true: Test.
   * - false: Do not test.
   */
  bool probeDownlink;
  /**
   * The expected maximum sending bitrate (bps) of the local user. The value range is [100000, 5000000]. We recommend setting this parameter
   * according to the bitrate value set by `setVideoEncoderConfiguration`.
   */
  unsigned int expectedUplinkBitrate;
  /**
   * The expected maximum receiving bitrate (bps) of the local user. The value range is [100000,5000000].
   */
  unsigned int expectedDownlinkBitrate;
};

/**
 * The status of the last-mile network tests.
 */
enum LASTMILE_PROBE_RESULT_STATE {
  /**
   * 1: The last-mile network probe test is complete.
   */
  LASTMILE_PROBE_RESULT_COMPLETE = 1,
  /**
   * 2: The last-mile network probe test is incomplete because the bandwidth estimation is not available due to limited test resources.
   */
  LASTMILE_PROBE_RESULT_INCOMPLETE_NO_BWE = 2,
  /**
   * 3: The last-mile network probe test is not carried out, probably due to poor network conditions.
   */
  LASTMILE_PROBE_RESULT_UNAVAILABLE = 3
};

/**
 * Results of the uplink or downlink last-mile network test.
 */
struct LastmileProbeOneWayResult {
  /**
   * The packet loss rate (%).
   */
  unsigned int packetLossRate;
  /**
   * The network jitter (ms).
   */
  unsigned int jitter;
  /**
   * The estimated available bandwidth (bps).
   */
  unsigned int availableBandwidth;

  LastmileProbeOneWayResult() : packetLossRate(0),
                                jitter(0),
                                availableBandwidth(0) {}
};

/**
 * Results of the uplink and downlink last-mile network tests.
 */
struct LastmileProbeResult {
  /**
   * The status of the last-mile network tests. See #LASTMILE_PROBE_RESULT_STATE.
   */
  LASTMILE_PROBE_RESULT_STATE state;
  /**
   * Results of the uplink last-mile network test. For details, see LastmileProbeOneWayResult.
   */
  LastmileProbeOneWayResult uplinkReport;
  /**
   * Results of the downlink last-mile network test. For details, see LastmileProbeOneWayResult.
   */
  LastmileProbeOneWayResult downlinkReport;
  /**
   * The round-trip time (ms).
   */
  unsigned int rtt;

  LastmileProbeResult()
    : state(LASTMILE_PROBE_RESULT_UNAVAILABLE),
      rtt(0) {}
};

/**
 * Reasons causing the change of the connection state.
 */
enum CONNECTION_CHANGED_REASON_TYPE
{
  /**
   * 0: The SDK is connecting to the server.
   */
  CONNECTION_CHANGED_CONNECTING = 0,
  /**
   * 1: The SDK has joined the channel successfully.
   */
  CONNECTION_CHANGED_JOIN_SUCCESS = 1,
  /**
   * 2: The connection between the SDK and the server is interrupted.
   */
  CONNECTION_CHANGED_INTERRUPTED = 2,
  /**
   * 3: The connection between the SDK and the server is banned by the server. This error occurs when the user is kicked out of the channel by the server.
   */
  CONNECTION_CHANGED_BANNED_BY_SERVER = 3,
  /**
   * 4: The SDK fails to join the channel. When the SDK fails to join the channel for more than 20 minutes, this error occurs and the SDK stops reconnecting to the channel.
   */
  CONNECTION_CHANGED_JOIN_FAILED = 4,
  /**
   * 5: The SDK has left the channel.
   */
  CONNECTION_CHANGED_LEAVE_CHANNEL = 5,
  /**
   * 6: The connection fails because the App ID is not valid.
   */
  CONNECTION_CHANGED_INVALID_APP_ID = 6,
  /**
   * 7: The connection fails because the channel name is not valid. Please rejoin the channel with a valid channel name.
   */
  CONNECTION_CHANGED_INVALID_CHANNEL_NAME = 7,
  /**
   * 8: The connection fails because the token is not valid. Typical reasons include:
   * - The App Certificate for the project is enabled in Agora Console, but you do not use a token when joining the channel. If you enable the App Certificate, you must use a token to join the channel.
   * - The `uid` specified when calling `joinChannel` to join the channel is inconsistent with the `uid` passed in when generating the token.
   */
  CONNECTION_CHANGED_INVALID_TOKEN = 8,
  /**
   * 9: The connection fails because the token has expired.
   */
  CONNECTION_CHANGED_TOKEN_EXPIRED = 9,
  /**
   * 10: The connection is rejected by the server. Typical reasons include:
   * - The user is already in the channel and still calls a method, for example, `joinChannel`, to join the channel. Stop calling this method to clear this error.
   * - The user tries to join the channel when conducting a pre-call test. The user needs to call the channel after the call test ends.
   */
  CONNECTION_CHANGED_REJECTED_BY_SERVER = 10,
  /**
   * 11: The connection changes to reconnecting because the SDK has set a proxy server.
   */
  CONNECTION_CHANGED_SETTING_PROXY_SERVER = 11,
  /**
   * 12: The connection state changed because the token is renewed.
   */
  CONNECTION_CHANGED_RENEW_TOKEN = 12,
  /**
   * 13: The IP address of the client has changed, possibly because the network type, IP address, or port has been changed.
   */
  CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED = 13,
  /**
   * 14: Timeout for the keep-alive of the connection between the SDK and the Agora edge server. The connection state changes to CONNECTION_STATE_RECONNECTING.
   */
  CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT = 14,
  /**
   * 15: The SDK has rejoined the channel successfully.
   */
  CONNECTION_CHANGED_REJOIN_SUCCESS = 15,
  /**
   * 16: The connection between the SDK and the server is lost.
   */
  CONNECTION_CHANGED_LOST = 16,
  /**
   * 17: The change of connection state is caused by echo test.
   */
  CONNECTION_CHANGED_ECHO_TEST = 17,
  /**
   * 18: The local IP Address is changed by user.
   */
  CONNECTION_CHANGED_CLIENT_IP_ADDRESS_CHANGED_BY_USER = 18,
  /**
   * 19: The connection is failed due to join the same channel on another device with the same uid.
   */
  CONNECTION_CHANGED_SAME_UID_LOGIN = 19,
  /**
   * 20: The connection is failed due to too many broadcasters in the channel.
   */
  CONNECTION_CHANGED_TOO_MANY_BROADCASTERS = 20,

  /**
   * 21: The connection is failed due to license validation failure.
   */
  CONNECTION_CHANGED_LICENSE_VALIDATION_FAILURE = 21,
  /*
   * 22: The connection is failed due to certification verify failure.
   */
  CONNECTION_CHANGED_CERTIFICATION_VERYFY_FAILURE = 22,
  /**
   * 23: The connection is failed due to the lack of granting permission to the stream channel.
   */
  CONNECTION_CHANGED_STREAM_CHANNEL_NOT_AVAILABLE = 23,
  /**
   * 24: The connection is failed due to join channel with an inconsistent appid.
   */
  CONNECTION_CHANGED_INCONSISTENT_APPID = 24,
};

/**
 * The reason of changing role's failure.
 */
enum CLIENT_ROLE_CHANGE_FAILED_REASON {
  /**
   * 1: Too many broadcasters in the channel.
   */
  CLIENT_ROLE_CHANGE_FAILED_TOO_MANY_BROADCASTERS = 1,
  /**
   * 2: The operation of changing role is not authorized.
   */
  CLIENT_ROLE_CHANGE_FAILED_NOT_AUTHORIZED = 2,
  /**
   * 3: The operation of changing role is timeout.
   * @deprecated This reason is deprecated.
   */
  CLIENT_ROLE_CHANGE_FAILED_REQUEST_TIME_OUT __deprecated = 3,
  /**
   * 4: The operation of changing role is interrupted since we lost connection with agora service.
   * @deprecated This reason is deprecated.
   */
  CLIENT_ROLE_CHANGE_FAILED_CONNECTION_FAILED __deprecated = 4,
};

/**
 * The reason of notifying the user of a message.
 */
enum WLACC_MESSAGE_REASON {
  /**
   * WIFI signal is weak.
   */
  WLACC_MESSAGE_REASON_WEAK_SIGNAL = 0,
  /**
   * Channel congestion.
   */
  WLACC_MESSAGE_REASON_CHANNEL_CONGESTION = 1,
};

/**
 * Suggest an action for the user.
 */
enum WLACC_SUGGEST_ACTION {
  /**
   * Please get close to AP.
   */
  WLACC_SUGGEST_ACTION_CLOSE_TO_WIFI = 0,
  /**
   * The user is advised to connect to the prompted SSID.
   */
  WLACC_SUGGEST_ACTION_CONNECT_SSID = 1,
  /**
   * The user is advised to check whether the AP supports 5G band and enable 5G band (the aciton link is attached), or purchases an AP that supports 5G. AP does not support 5G band.
   */
  WLACC_SUGGEST_ACTION_CHECK_5G = 2,
  /**
   * The user is advised to change the SSID of the 2.4G or 5G band (the aciton link is attached). The SSID of the 2.4G band AP is the same as that of the 5G band.
   */
  WLACC_SUGGEST_ACTION_MODIFY_SSID = 3,
};

/**
 * Indicator optimization degree.
 */
struct WlAccStats {
  /**
   * End-to-end delay optimization percentage.
   */
  unsigned short e2eDelayPercent;
  /**
   * Frozen Ratio optimization percentage.
   */
  unsigned short frozenRatioPercent;
  /**
   * Loss Rate optimization percentage.
   */
  unsigned short lossRatePercent;
};

/**
 * The network type.
 */
enum NETWORK_TYPE {
  /**
   * -1: The network type is unknown.
   */
  NETWORK_TYPE_UNKNOWN = -1,
  /**
   * 0: The SDK disconnects from the network.
   */
  NETWORK_TYPE_DISCONNECTED = 0,
  /**
   * 1: The network type is LAN.
   */
  NETWORK_TYPE_LAN = 1,
  /**
   * 2: The network type is Wi-Fi (including hotspots).
   */
  NETWORK_TYPE_WIFI = 2,
  /**
   * 3: The network type is mobile 2G.
   */
  NETWORK_TYPE_MOBILE_2G = 3,
  /**
   * 4: The network type is mobile 3G.
   */
  NETWORK_TYPE_MOBILE_3G = 4,
  /**
   * 5: The network type is mobile 4G.
   */
  NETWORK_TYPE_MOBILE_4G = 5,
  /**
   * 6: The network type is mobile 5G.
   */
  NETWORK_TYPE_MOBILE_5G = 6,
};

/**
 * The mode of setting up video views.
 */
enum VIDEO_VIEW_SETUP_MODE {
  /**
   * 0: replace one view
   */
  VIDEO_VIEW_SETUP_REPLACE = 0,
  /**
   * 1: add one view
   */
  VIDEO_VIEW_SETUP_ADD = 1,
  /**
   * 2: remove one view
   */
  VIDEO_VIEW_SETUP_REMOVE = 2,
};

/**
 * Attributes of video canvas object.
 */
struct VideoCanvas {
  /**
   * The user id of local video.
   */
  uid_t uid;

  /**
  * The uid of video stream composing the video stream from transcoder which will be drawn on this video canvas. 
  */
  uid_t subviewUid;
  /**
   * Video display window.
   */
  view_t view;
  /**
   * A RGBA value indicates background color of the render view. Defaults to 0x00000000.
   */
  uint32_t backgroundColor;
  /**
   * The video render mode. See \ref agora::media::base::RENDER_MODE_TYPE "RENDER_MODE_TYPE".
   * The default value is RENDER_MODE_HIDDEN.
   */
  media::base::RENDER_MODE_TYPE renderMode;
  /**
   * The video mirror mode. See \ref VIDEO_MIRROR_MODE_TYPE "VIDEO_MIRROR_MODE_TYPE".
   * The default value is VIDEO_MIRROR_MODE_AUTO.
   * @note
   * - For the mirror mode of the local video view: 
   * If you use a front camera, the SDK enables the mirror mode by default;
   * if you use a rear camera, the SDK disables the mirror mode by default.
   * - For the remote user: The mirror mode is disabled by default.
   */
  VIDEO_MIRROR_MODE_TYPE mirrorMode;
  /**
   * The mode of setting up video view. See \ref VIDEO_VIEW_SETUP_MODE "VIDEO_VIEW_SETUP_MODE"
   * The default value is VIDEO_VIEW_SETUP_REPLACE.
   */
  VIDEO_VIEW_SETUP_MODE setupMode;
  /**
   * The video source type. See \ref VIDEO_SOURCE_TYPE "VIDEO_SOURCE_TYPE".
   * The default value is VIDEO_SOURCE_CAMERA_PRIMARY.
   */
  VIDEO_SOURCE_TYPE sourceType;
  /**
   * The media player id of AgoraMediaPlayer. It should set this parameter when the 
   * sourceType is VIDEO_SOURCE_MEDIA_PLAYER to show the video that AgoraMediaPlayer is playing.
   * You can get this value by calling the method \ref getMediaPlayerId().
   */
  int mediaPlayerId;
  /**
   * If you want to display a certain part of a video frame, you can set 
   * this value to crop the video frame to show. 
   * The default value is empty(that is, if it has zero width or height), which means no cropping.
   */
  Rectangle cropArea;
  /**
   * Whether to apply alpha mask to the video frame if exsit:
   * true: Apply alpha mask to video frame.
   * false: (Default) Do not apply alpha mask to video frame.
   */
  bool enableAlphaMask;
  /**
   * The video frame position in pipeline. See \ref VIDEO_MODULE_POSITION "VIDEO_MODULE_POSITION".
   * The default value is POSITION_POST_CAPTURER.
   */
  media::base::VIDEO_MODULE_POSITION position;

  VideoCanvas()
    : uid(0), subviewUid(0), view(NULL), backgroundColor(0x00000000), renderMode(media::base::RENDER_MODE_HIDDEN), mirrorMode(VIDEO_MIRROR_MODE_AUTO),
      setupMode(VIDEO_VIEW_SETUP_REPLACE), sourceType(VIDEO_SOURCE_CAMERA_PRIMARY), mediaPlayerId(-ERR_NOT_READY),
      cropArea(0, 0, 0, 0), enableAlphaMask(false), position(media::base::POSITION_POST_CAPTURER) {}

  VideoCanvas(view_t v, media::base::RENDER_MODE_TYPE m, VIDEO_MIRROR_MODE_TYPE mt)
    : uid(0), subviewUid(0), view(v), backgroundColor(0x00000000), renderMode(m), mirrorMode(mt), setupMode(VIDEO_VIEW_SETUP_REPLACE),
      sourceType(VIDEO_SOURCE_CAMERA_PRIMARY), mediaPlayerId(-ERR_NOT_READY),
      cropArea(0, 0, 0, 0), enableAlphaMask(false), position(media::base::POSITION_POST_CAPTURER) {}

  VideoCanvas(view_t v, media::base::RENDER_MODE_TYPE m, VIDEO_MIRROR_MODE_TYPE mt, uid_t u)
    : uid(u), subviewUid(0), view(v), backgroundColor(0x00000000), renderMode(m), mirrorMode(mt), setupMode(VIDEO_VIEW_SETUP_REPLACE),
      sourceType(VIDEO_SOURCE_CAMERA_PRIMARY), mediaPlayerId(-ERR_NOT_READY),
      cropArea(0, 0, 0, 0), enableAlphaMask(false), position(media::base::POSITION_POST_CAPTURER) {}

  VideoCanvas(view_t v, media::base::RENDER_MODE_TYPE m, VIDEO_MIRROR_MODE_TYPE mt, uid_t u, uid_t subu)
    : uid(u), subviewUid(subu), view(v), backgroundColor(0x00000000), renderMode(m), mirrorMode(mt), setupMode(VIDEO_VIEW_SETUP_REPLACE),
      sourceType(VIDEO_SOURCE_CAMERA_PRIMARY), mediaPlayerId(-ERR_NOT_READY),
      cropArea(0, 0, 0, 0), enableAlphaMask(false), position(media::base::POSITION_POST_CAPTURER) {}
};

/** Image enhancement options.
 */
struct BeautyOptions {
  /** The contrast level.
    */
  enum LIGHTENING_CONTRAST_LEVEL {
      /** Low contrast level. */
      LIGHTENING_CONTRAST_LOW = 0,
      /** (Default) Normal contrast level. */
      LIGHTENING_CONTRAST_NORMAL = 1,
      /** High contrast level. */
      LIGHTENING_CONTRAST_HIGH = 2,
  };

  /** The contrast level, used with the `lighteningLevel` parameter. The larger the value, the greater the contrast between light and dark. See #LIGHTENING_CONTRAST_LEVEL.
    */
  LIGHTENING_CONTRAST_LEVEL lighteningContrastLevel;

  /** The brightness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The greater the value, the greater the degree of whitening. */
  float lighteningLevel;

  /** The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The greater the value, the greater the degree of skin grinding.
    */
  float smoothnessLevel;

  /** The redness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The larger the value, the greater the rosy degree.
    */
  float rednessLevel;

  /** The sharpness level. The value ranges from 0.0 (original) to 1.0. The default value is 0.0. The larger the value, the greater the sharpening degree.
  */
  float sharpnessLevel;

  BeautyOptions(LIGHTENING_CONTRAST_LEVEL contrastLevel, float lightening, float smoothness, float redness, float sharpness) : lighteningContrastLevel(contrastLevel), lighteningLevel(lightening), smoothnessLevel(smoothness), rednessLevel(redness), sharpnessLevel(sharpness) {}

  BeautyOptions() : lighteningContrastLevel(LIGHTENING_CONTRAST_NORMAL), lighteningLevel(0), smoothnessLevel(0), rednessLevel(0), sharpnessLevel(0) {}
};

/** Face shape area options. This structure defines options for facial adjustments on different facial areas.
 *
 * @technical preview
 */
struct FaceShapeAreaOptions {
  /** The specific facial area to be adjusted.
    */
  enum FACE_SHAPE_AREA {
    /** (Default) Invalid area. */
    FACE_SHAPE_AREA_NONE = -1,
    /** Head Scale, reduces the size of head. */
    FACE_SHAPE_AREA_HEADSCALE = 0,
    /** Forehead, adjusts the size of forehead. */
    FACE_SHAPE_AREA_FOREHEAD = 1,
    /** Face Contour, slims the facial contour. */
    FACE_SHAPE_AREA_FACECONTOUR = 2,
    /** Face Length, adjusts the length of face. */
    FACE_SHAPE_AREA_FACELENGTH = 3,
    /** Face Width, narrows the width of face. */
    FACE_SHAPE_AREA_FACEWIDTH = 4,
    /** Cheekbone, adjusts the size of cheekbone. */
    FACE_SHAPE_AREA_CHEEKBONE = 5,
    /** Cheek, adjusts the size of cheek. */
    FACE_SHAPE_AREA_CHEEK = 6,
    /** Chin, adjusts the length of chin. */
    FACE_SHAPE_AREA_CHIN = 7,
    /** Eye Scale, adjusts the size of eyes. */
    FACE_SHAPE_AREA_EYESCALE = 8,
    /** Nose Length, adjusts the length of nose. */
    FACE_SHAPE_AREA_NOSELENGTH = 9,
    /** Nose Width, adjusts the width of nose. */
    FACE_SHAPE_AREA_NOSEWIDTH = 10,
    /** Mouth Scale, adjusts the size of mouth. */
    FACE_SHAPE_AREA_MOUTHSCALE = 11,
  };
  
  /** The specific facial area to be adjusted, See #FACE_SHAPE_AREA.
    */
  FACE_SHAPE_AREA shapeArea;
  
  /** The intensity of the pinching effect applied to the specified facial area.
   * For the following area values: #FACE_SHAPE_AREA_FOREHEAD, #FACE_SHAPE_AREA_FACELENGTH, #FACE_SHAPE_AREA_CHIN, #FACE_SHAPE_AREA_NOSELENGTH, #FACE_SHAPE_AREA_NOSEWIDTH, #FACE_SHAPE_AREA_MOUTHSCALE, the value ranges from -100 to 100.
   * The default value is 0. The greater the absolute value, the stronger the intensity applied to the specified facial area, and negative values indicate the opposite direction.
   * For enumeration values other than the above, the value ranges from 0 to 100. The default value is 0. The greater the value, the stronger the intensity applied to the specified facial area.
    */
  int shapeIntensity;
  
  FaceShapeAreaOptions(FACE_SHAPE_AREA shapeArea, int areaIntensity) : shapeArea(shapeArea), shapeIntensity(areaIntensity) {}

  FaceShapeAreaOptions() : shapeArea(FACE_SHAPE_AREA_NONE), shapeIntensity(0) {}
};

/** Face shape beauty options. This structure defines options for facial adjustments of different facial styles.
 *
 * @technical preview
 */
struct FaceShapeBeautyOptions {
  /** The face shape style.
    */
  enum FACE_SHAPE_BEAUTY_STYLE {
    /** (Default) Female face shape style. */
    FACE_SHAPE_BEAUTY_STYLE_FEMALE = 0,
    /** Male face shape style. */
    FACE_SHAPE_BEAUTY_STYLE_MALE = 1,
  };
  
  /** The face shape style, See #FACE_SHAPE_BEAUTY_STYLE.
    */
  FACE_SHAPE_BEAUTY_STYLE shapeStyle;
  
  /** The intensity of the pinching effect applied to the specified facial style. The value ranges from 0 (original) to 100. The default value is 0. The greater the value, the stronger the intensity applied to face pinching.
    */
  int styleIntensity;
  
  FaceShapeBeautyOptions(FACE_SHAPE_BEAUTY_STYLE shapeStyle, int styleIntensity) : shapeStyle(shapeStyle), styleIntensity(styleIntensity) {}

  FaceShapeBeautyOptions() : shapeStyle(FACE_SHAPE_BEAUTY_STYLE_FEMALE), styleIntensity(50) {}
};

struct LowlightEnhanceOptions {
  /**
   * The low-light enhancement mode.
   */
  enum LOW_LIGHT_ENHANCE_MODE {
    /** 0: (Default) Automatic mode. The SDK automatically enables or disables the low-light enhancement feature according to the ambient light to compensate for the lighting level or prevent overexposure, as necessary. */
    LOW_LIGHT_ENHANCE_AUTO = 0,
    /** Manual mode. Users need to enable or disable the low-light enhancement feature manually. */
    LOW_LIGHT_ENHANCE_MANUAL = 1,
  };
  /**
   * The low-light enhancement level.
   */
  enum LOW_LIGHT_ENHANCE_LEVEL {
    /**
     * 0: (Default) Promotes video quality during low-light enhancement. It processes the brightness, details, and noise of the video image. The performance consumption is moderate, the processing speed is moderate, and the overall video quality is optimal.
     */
    LOW_LIGHT_ENHANCE_LEVEL_HIGH_QUALITY = 0,
    /**
     * Promotes performance during low-light enhancement. It processes the brightness and details of the video image. The processing speed is faster.
     */
    LOW_LIGHT_ENHANCE_LEVEL_FAST = 1,
  };

  /** The low-light enhancement mode. See #LOW_LIGHT_ENHANCE_MODE.
   */
  LOW_LIGHT_ENHANCE_MODE mode;

  /** The low-light enhancement level. See #LOW_LIGHT_ENHANCE_LEVEL.
   */
  LOW_LIGHT_ENHANCE_LEVEL level;

  LowlightEnhanceOptions(LOW_LIGHT_ENHANCE_MODE lowlightMode, LOW_LIGHT_ENHANCE_LEVEL lowlightLevel) : mode(lowlightMode), level(lowlightLevel) {}

  LowlightEnhanceOptions() : mode(LOW_LIGHT_ENHANCE_AUTO), level(LOW_LIGHT_ENHANCE_LEVEL_HIGH_QUALITY) {}
};
/**
 * The video noise reduction options.
 *
 * @since v4.0.0
 */
struct VideoDenoiserOptions {
  /** The video noise reduction mode.
   */
  enum VIDEO_DENOISER_MODE {
    /** 0: (Default) Automatic mode. The SDK automatically enables or disables the video noise reduction feature according to the ambient light. */
    VIDEO_DENOISER_AUTO = 0,
    /** Manual mode. Users need to enable or disable the video noise reduction feature manually. */
    VIDEO_DENOISER_MANUAL = 1,
  };
  /**
   * The video noise reduction level.
   */
  enum VIDEO_DENOISER_LEVEL {
    /**
     * 0: (Default) Promotes video quality during video noise reduction. `HIGH_QUALITY` balances performance consumption and video noise reduction quality.
     * The performance consumption is moderate, the video noise reduction speed is moderate, and the overall video quality is optimal.
     */
    VIDEO_DENOISER_LEVEL_HIGH_QUALITY = 0,
    /**
     * Promotes reducing performance consumption during video noise reduction. `FAST` prioritizes reducing performance consumption over video noise reduction quality.
     * The performance consumption is lower, and the video noise reduction speed is faster. To avoid a noticeable shadowing effect (shadows trailing behind moving objects) in the processed video, Agora recommends that you use `FAST` when the camera is fixed.
     */
    VIDEO_DENOISER_LEVEL_FAST = 1,
    /**
     * Enhanced video noise reduction. `STRENGTH` prioritizes video noise reduction quality over reducing performance consumption.
     * The performance consumption is higher, the video noise reduction speed is slower, and the video noise reduction quality is better.
     * If `HIGH_QUALITY` is not enough for your video noise reduction needs, you can use `STRENGTH`.
     */
    VIDEO_DENOISER_LEVEL_STRENGTH = 2,
  };
  /** The video noise reduction mode. See #VIDEO_DENOISER_MODE.
   */
  VIDEO_DENOISER_MODE mode;

  /** The video noise reduction level. See #VIDEO_DENOISER_LEVEL.
   */
  VIDEO_DENOISER_LEVEL level;

  VideoDenoiserOptions(VIDEO_DENOISER_MODE denoiserMode, VIDEO_DENOISER_LEVEL denoiserLevel) : mode(denoiserMode), level(denoiserLevel) {}

  VideoDenoiserOptions() : mode(VIDEO_DENOISER_AUTO), level(VIDEO_DENOISER_LEVEL_HIGH_QUALITY) {}
};

/** The color enhancement options.
 *
 * @since v4.0.0
 */
struct ColorEnhanceOptions {
  /** The level of color enhancement. The value range is [0.0,1.0]. `0.0` is the default value, which means no color enhancement is applied to the video. The higher the value, the higher the level of color enhancement.
   */
  float strengthLevel;

  /** The level of skin tone protection. The value range is [0.0,1.0]. `0.0` means no skin tone protection. The higher the value, the higher the level of skin tone protection.
   * The default value is `1.0`. When the level of color enhancement is higher, the portrait skin tone can be significantly distorted, so you need to set the level of skin tone protection; when the level of skin tone protection is higher, the color enhancement effect can be slightly reduced.
   * Therefore, to get the best color enhancement effect, Agora recommends that you adjust `strengthLevel` and `skinProtectLevel` to get the most appropriate values.
   */
  float skinProtectLevel;

  ColorEnhanceOptions(float stength, float skinProtect) : strengthLevel(stength), skinProtectLevel(skinProtect) {}

  ColorEnhanceOptions() : strengthLevel(0), skinProtectLevel(1) {}
};

/**
 * The custom background image.
 */
struct VirtualBackgroundSource {
  /** The type of the custom background source.
   */
  enum BACKGROUND_SOURCE_TYPE {
    /**
     * 0: Enable segementation with the captured video frame without replacing the background.
     */
    BACKGROUND_NONE = 0,
    /**
     * 1: (Default) The background source is a solid color.
     */
    BACKGROUND_COLOR = 1,
    /**
     * The background source is a file in PNG or JPG format.
     */
    BACKGROUND_IMG = 2,
    /** 
     * The background source is the blurred original video frame.
     * */
    BACKGROUND_BLUR = 3,
    /** 
     * The background source is a file in MP4, AVI, MKV, FLV format. 
     * */
    BACKGROUND_VIDEO = 4,
  };

  /** The degree of blurring applied to the background source.
   */
  enum BACKGROUND_BLUR_DEGREE {
    /** 1: The degree of blurring applied to the custom background image is low. The user can almost see the background clearly. */
    BLUR_DEGREE_LOW = 1,
    /** 2: The degree of blurring applied to the custom background image is medium. It is difficult for the user to recognize details in the background. */
    BLUR_DEGREE_MEDIUM = 2,
    /** 3: (Default) The degree of blurring applied to the custom background image is high. The user can barely see any distinguishing features in the background. */
    BLUR_DEGREE_HIGH = 3,
  };

  /** The type of the custom background image. See #BACKGROUND_SOURCE_TYPE.
   */
  BACKGROUND_SOURCE_TYPE background_source_type;

  /**
   * The color of the custom background image. The format is a hexadecimal integer defined by RGB, without the # sign,
   * such as 0xFFB6C1 for light pink. The default value is 0xFFFFFF, which signifies white. The value range
   * is [0x000000,0xFFFFFF]. If the value is invalid, the SDK replaces the original background image with a white
   * background image.
   *
   * @note This parameter takes effect only when the type of the custom background image is `BACKGROUND_COLOR`.
   */
  unsigned int color;

  /**
   * The local absolute path of the custom background image. PNG and JPG formats are supported. If the path is invalid,
   * the SDK replaces the original background image with a white background image.
   *
   * @note This parameter takes effect only when the type of the custom background image is `BACKGROUND_IMG`.
   */
  const char* source;

  /** The degree of blurring applied to the custom background image. See BACKGROUND_BLUR_DEGREE.
   * @note This parameter takes effect only when the type of the custom background image is `BACKGROUND_BLUR`.
   */
  BACKGROUND_BLUR_DEGREE blur_degree;

  VirtualBackgroundSource() : background_source_type(BACKGROUND_COLOR), color(0xffffff), source(OPTIONAL_NULLPTR),  blur_degree(BLUR_DEGREE_HIGH) {}
};

struct SegmentationProperty {

    enum SEG_MODEL_TYPE {

    SEG_MODEL_AI = 1,
    SEG_MODEL_GREEN = 2
  };

  SEG_MODEL_TYPE modelType;

  float greenCapacity;


  SegmentationProperty() : modelType(SEG_MODEL_AI), greenCapacity(0.5){}
};

/** The type of custom audio track
*/
enum AUDIO_TRACK_TYPE {
  /** 
   * -1: Invalid audio track
   */
  AUDIO_TRACK_INVALID = -1,
  /** 
   * 0: Mixable audio track
   * You can push more than one mixable Audio tracks into one RTC connection(channel id + uid), 
   * and SDK will mix these tracks into one audio track automatically.
   * However, compare to direct audio track, mixable track might cause extra 30ms+ delay.
   */
  AUDIO_TRACK_MIXABLE = 0,
  /**
   * 1: Direct audio track
   * You can only push one direct (non-mixable) audio track into one RTC connection(channel id + uid). 
   * Compare to mixable stream, you can have lower lantency using direct audio track.
   */
  AUDIO_TRACK_DIRECT = 1,
};

/** The configuration of custom audio track
*/
struct AudioTrackConfig {
  /**
   * Enable local playback, enabled by default
   * true: (Default) Enable local playback
   * false: Do not enable local playback
   */
  bool enableLocalPlayback;

  AudioTrackConfig()
    : enableLocalPlayback(true) {}
};

/**
 * Preset local voice reverberation options.
 * bitmap allocation:
 * |  bit31  |    bit30 - bit24   |        bit23 - bit16        | bit15 - bit8 |  bit7 - bit0   |
 * |---------|--------------------|-----------------------------|--------------|----------------|
 * |reserved | 0x1: voice beauty  | 0x1: chat beautification    | effect types | effect settings|
 * |         |                    | 0x2: singing beautification |              |                |
 * |         |                    | 0x3: timbre transform       |              |                |
 * |         |                    | 0x4: ultra high_quality     |              |                |
 * |         |--------------------|-----------------------------|              |                |
 * |         | 0x2: audio effect  | 0x1: space construction     |              |                |
 * |         |                    | 0x2: voice changer effect   |              |                |
 * |         |                    | 0x3: style transform        |              |                |
 * |         |                    | 0x4: electronic sound       |              |                |
 * |         |                    | 0x5: magic tone             |              |                |
 * |         |--------------------|-----------------------------|              |                |
 * |         | 0x3: voice changer | 0x1: voice transform        |              |                |
 */
/** The options for SDK preset voice beautifier effects.
 */
enum VOICE_BEAUTIFIER_PRESET {
  /** Turn off voice beautifier effects and use the original voice.
   */
  VOICE_BEAUTIFIER_OFF = 0x00000000,
  /** A more magnetic voice.
   *
   * @note Agora recommends using this enumerator to process a male-sounding voice; otherwise, you
   * may experience vocal distortion.
   */
  CHAT_BEAUTIFIER_MAGNETIC = 0x01010100,
  /** A fresher voice.
   *
   * @note Agora recommends using this enumerator to process a female-sounding voice; otherwise, you
   * may experience vocal distortion.
   */
  CHAT_BEAUTIFIER_FRESH = 0x01010200,
  /** A more vital voice.
   *
   * @note Agora recommends using this enumerator to process a female-sounding voice; otherwise, you
   * may experience vocal distortion.
   */
  CHAT_BEAUTIFIER_VITALITY = 0x01010300,
  /**
   * Singing beautifier effect.
   * - If you call `setVoiceBeautifierPreset`(SINGING_BEAUTIFIER), you can beautify a male-sounding voice and add a reverberation effect
   * that sounds like singing in a small room. Agora recommends not using `setVoiceBeautifierPreset`(SINGING_BEAUTIFIER) to process
   * a female-sounding voice; otherwise, you may experience vocal distortion.
   * - If you call `setVoiceBeautifierParameters`(SINGING_BEAUTIFIER, param1, param2), you can beautify a male- or
   * female-sounding voice and add a reverberation effect.
   */
  SINGING_BEAUTIFIER = 0x01020100,
  /** A more vigorous voice.
   */
  TIMBRE_TRANSFORMATION_VIGOROUS = 0x01030100,
  /** A deeper voice.
   */
  TIMBRE_TRANSFORMATION_DEEP = 0x01030200,
  /** A mellower voice.
   */
  TIMBRE_TRANSFORMATION_MELLOW = 0x01030300,
  /** A falsetto voice.
   */
  TIMBRE_TRANSFORMATION_FALSETTO = 0x01030400,
  /** A fuller voice.
   */
  TIMBRE_TRANSFORMATION_FULL = 0x01030500,
  /** A clearer voice.
   */
  TIMBRE_TRANSFORMATION_CLEAR = 0x01030600,
  /** A more resounding voice.
   */
  TIMBRE_TRANSFORMATION_RESOUNDING = 0x01030700,
  /** A more ringing voice.
   */
  TIMBRE_TRANSFORMATION_RINGING = 0x01030800,
  /**
   * A ultra-high quality voice, which makes the audio clearer and restores more details.
   * - To achieve better audio effect quality, Agora recommends that you call `setAudioProfile`
   * and set the `profile` to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`
   * and `scenario` to `AUDIO_SCENARIO_HIGH_DEFINITION(6)` before calling `setVoiceBeautifierPreset`.
   * - If you have an audio capturing device that can already restore audio details to a high
   * degree, Agora recommends that you do not enable ultra-high quality; otherwise, the SDK may
   * over-restore audio details, and you may not hear the anticipated voice effect.
   */
  ULTRA_HIGH_QUALITY_VOICE = 0x01040100
};

/** Preset voice effects.
 *
 * For better voice effects, Agora recommends setting the `profile` parameter of `setAudioProfile` to `AUDIO_PROFILE_MUSIC_HIGH_QUALITY` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO` before using the following presets:
 *
 * - `ROOM_ACOUSTICS_KTV`
 * - `ROOM_ACOUSTICS_VOCAL_CONCERT`
 * - `ROOM_ACOUSTICS_STUDIO`
 * - `ROOM_ACOUSTICS_PHONOGRAPH`
 * - `ROOM_ACOUSTICS_SPACIAL`
 * - `ROOM_ACOUSTICS_ETHEREAL`
 * - `ROOM_ACOUSTICS_CHORUS`
 * - `VOICE_CHANGER_EFFECT_UNCLE`
 * - `VOICE_CHANGER_EFFECT_OLDMAN`
 * - `VOICE_CHANGER_EFFECT_BOY`
 * - `VOICE_CHANGER_EFFECT_SISTER`
 * - `VOICE_CHANGER_EFFECT_GIRL`
 * - `VOICE_CHANGER_EFFECT_PIGKING`
 * - `VOICE_CHANGER_EFFECT_HULK`
 * - `PITCH_CORRECTION`
 */
enum AUDIO_EFFECT_PRESET {
  /** Turn off voice effects, that is, use the original voice.
   */
  AUDIO_EFFECT_OFF = 0x00000000,
  /** The voice effect typical of a KTV venue.
   */
  ROOM_ACOUSTICS_KTV = 0x02010100,
  /** The voice effect typical of a concert hall.
   */
  ROOM_ACOUSTICS_VOCAL_CONCERT = 0x02010200,
  /** The voice effect typical of a recording studio.
   */
  ROOM_ACOUSTICS_STUDIO = 0x02010300,
  /** The voice effect typical of a vintage phonograph.
   */
  ROOM_ACOUSTICS_PHONOGRAPH = 0x02010400,
  /** The virtual stereo effect, which renders monophonic audio as stereo audio.
   *
   * @note Before using this preset, set the `profile` parameter of `setAudioProfile`
   * to `AUDIO_PROFILE_MUSIC_STANDARD_STEREO(3)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)`;
   * otherwise, the preset setting is invalid.
   */
  ROOM_ACOUSTICS_VIRTUAL_STEREO = 0x02010500,
  /** A more spatial voice effect.
   */
  ROOM_ACOUSTICS_SPACIAL = 0x02010600,
  /** A more ethereal voice effect.
   */
  ROOM_ACOUSTICS_ETHEREAL = 0x02010700,
  /** A 3D voice effect that makes the voice appear to be moving around the user. The default cycle
   * period of the 3D voice effect is 10 seconds. To change the cycle period, call `setAudioEffectParameters`
   * after this method.
   *
   * @note
   * - Before using this preset, set the `profile` parameter of `setAudioProfile` to
   * `AUDIO_PROFILE_MUSIC_STANDARD_STEREO` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO`; otherwise,
   * the preset setting is invalid.
   * - If the 3D voice effect is enabled, users need to use stereo audio playback devices to hear
   * the anticipated voice effect.
   */
  ROOM_ACOUSTICS_3D_VOICE = 0x02010800,
  /** virtual suround sound.
   *
   * @note
   * - Agora recommends using this enumerator to process virtual suround sound; otherwise, you may
   * not hear the anticipated voice effect.
   * - To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
   */
  ROOM_ACOUSTICS_VIRTUAL_SURROUND_SOUND = 0x02010900,
  /** The voice effect for chorus.
   * 
   * @note: To achieve better audio effect quality, Agora recommends calling \ref
   * IRtcEngine::setAudioProfile "setAudioProfile" and setting the `profile` parameter to
   * `AUDIO_PROFILE_MUSIC_HIGH_QUALITY(4)` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO(5)` before
   * setting this enumerator.
  */
  ROOM_ACOUSTICS_CHORUS = 0x02010D00,
  /** A middle-aged man's voice.
   *
   * @note
   * Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   */
  VOICE_CHANGER_EFFECT_UNCLE = 0x02020100,
  /** A senior man's voice.
   *
   * @note Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   */
  VOICE_CHANGER_EFFECT_OLDMAN = 0x02020200,
  /** A boy's voice.
   *
   * @note Agora recommends using this enumerator to process a male-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   */
  VOICE_CHANGER_EFFECT_BOY = 0x02020300,
  /** A young woman's voice.
   *
   * @note
   * - Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   */
  VOICE_CHANGER_EFFECT_SISTER = 0x02020400,
  /** A girl's voice.
   *
   * @note Agora recommends using this enumerator to process a female-sounding voice; otherwise, you may
   * not hear the anticipated voice effect.
   */
  VOICE_CHANGER_EFFECT_GIRL = 0x02020500,
  /** The voice of Pig King, a character in Journey to the West who has a voice like a growling
   * bear.
   */
  VOICE_CHANGER_EFFECT_PIGKING = 0x02020600,
  /** The Hulk's voice.
   */
  VOICE_CHANGER_EFFECT_HULK = 0x02020700,
  /** An audio effect typical of R&B music.
   *
   * @note Before using this preset, set the `profile` parameter of `setAudioProfile` to
   - `AUDIO_PROFILE_MUSIC_HIGH_QUALITY` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO`; otherwise,
   * the preset setting is invalid.
   */
  STYLE_TRANSFORMATION_RNB = 0x02030100,
  /** The voice effect typical of popular music.
   *
   * @note Before using this preset, set the `profile` parameter of `setAudioProfile` to
   - `AUDIO_PROFILE_MUSIC_HIGH_QUALITY` or `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO`; otherwise,
   * the preset setting is invalid.
   */
  STYLE_TRANSFORMATION_POPULAR = 0x02030200,
  /** A pitch correction effect that corrects the user's pitch based on the pitch of the natural C
  * major scale. After setting this voice effect, you can call `setAudioEffectParameters` to adjust
  * the basic mode of tuning and the pitch of the main tone.
   */
  PITCH_CORRECTION = 0x02040100,

  /** Todo:  Electronic sound, Magic tone haven't been implemented.
   *
   */
};

/** The options for SDK preset voice conversion.
 */
enum VOICE_CONVERSION_PRESET {
  /** Turn off voice conversion and use the original voice.
   */
  VOICE_CONVERSION_OFF = 0x00000000,
  /** A gender-neutral voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
   */
  VOICE_CHANGER_NEUTRAL = 0x03010100,
  /** A sweet voice. To avoid audio distortion, ensure that you use this enumerator to process a female-sounding voice.
   */
  VOICE_CHANGER_SWEET = 0x03010200,
  /** A steady voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
   */
  VOICE_CHANGER_SOLID = 0x03010300,
  /** A deep voice. To avoid audio distortion, ensure that you use this enumerator to process a male-sounding voice.
   */
  VOICE_CHANGER_BASS = 0x03010400,
  /** A voice like a cartoon character.
   */
  VOICE_CHANGER_CARTOON = 0x03010500,
  /** A voice like a child.
   */
  VOICE_CHANGER_CHILDLIKE = 0x03010600,
  /** A voice like a phone operator.
   */
  VOICE_CHANGER_PHONE_OPERATOR = 0x03010700,
  /** A monster voice.
   */
  VOICE_CHANGER_MONSTER = 0x03010800,
  /** A voice like Transformers.
   */
  VOICE_CHANGER_TRANSFORMERS = 0x03010900,
  /** A voice like Groot.
   */
  VOICE_CHANGER_GROOT = 0x03010A00,
  /** A voice like Darth Vader.
   */
  VOICE_CHANGER_DARTH_VADER = 0x03010B00,
  /** A rough female voice.
   */
  VOICE_CHANGER_IRON_LADY = 0x03010C00,
  /** A voice like Crayon Shin-chan.
   */
  VOICE_CHANGER_SHIN_CHAN = 0x03010D00,
  /** A voice like a castrato.
   */
  VOICE_CHANGER_GIRLISH_MAN = 0x03010E00,
  /** A voice like chipmunk.
   */
  VOICE_CHANGER_CHIPMUNK = 0x03010F00,

};

/** The options for SDK preset headphone equalizer.
 */
enum HEADPHONE_EQUALIZER_PRESET {
  /** Turn off headphone EQ and use the original voice.
   */
  HEADPHONE_EQUALIZER_OFF = 0x00000000,
  /** For over-ear headphones.
   */
  HEADPHONE_EQUALIZER_OVEREAR = 0x04000001,
  /** For in-ear headphones.
   */
  HEADPHONE_EQUALIZER_INEAR = 0x04000002
};

/** The options for SDK voice AI tuner.
 */
enum VOICE_AI_TUNER_TYPE {
  /** Uncle, deep and magnetic male voice.
   */
  VOICE_AI_TUNER_MATURE_MALE,
  /** Fresh male, refreshing and sweet male voice.
   */
  VOICE_AI_TUNER_FRESH_MALE,
  /** Big sister, deep and charming female voice.
   */
  VOICE_AI_TUNER_ELEGANT_FEMALE,
  /** Lolita, high-pitched and cute female voice.
   */
  VOICE_AI_TUNER_SWEET_FEMALE,
  /** Warm man singing, warm and melodic male voice that is suitable for male lyrical songs.
   */
  VOICE_AI_TUNER_WARM_MALE_SINGING,
  /** Gentle female singing, soft and delicate female voice that is suitable for female lyrical songs.
   */
  VOICE_AI_TUNER_GENTLE_FEMALE_SINGING,
  /** Smoky uncle singing, unique husky male voice that is suitable for rock or blues songs.
   */
  VOICE_AI_TUNER_HUSKY_MALE_SINGING,
  /** Warm big sister singing, warm and mature female voice that is suitable for emotionally powerful songs.
   */
  VOICE_AI_TUNER_WARM_ELEGANT_FEMALE_SINGING,
  /** Forceful male singing, strong and powerful male voice that is suitable for passionate songs.
   */
  VOICE_AI_TUNER_POWERFUL_MALE_SINGING,
  /** Dreamy female singing, dreamlike and soft female voice that is suitable for airy and dream-like songs.
   */
  VOICE_AI_TUNER_DREAMY_FEMALE_SINGING,
};

/**
 * Screen sharing configurations.
 */
struct ScreenCaptureParameters {
  /**
   * On Windows and macOS, it represents the video encoding resolution of the shared screen stream.
   * See `VideoDimensions`. The default value is 1920 x 1080, that is, 2,073,600 pixels. Agora uses
   * the value of this parameter to calculate the charges.
   *
   * If the aspect ratio is different between the encoding dimensions and screen dimensions, Agora
   * applies the following algorithms for encoding. Suppose dimensions are 1920 x 1080:
   * - If the value of the screen dimensions is lower than that of dimensions, for example,
   * 1000 x 1000 pixels, the SDK uses 1000 x 1000 pixels for encoding.
   * - If the value of the screen dimensions is higher than that of dimensions, for example,
   * 2000 x 1500, the SDK uses the maximum value under dimensions with the aspect ratio of
   * the screen dimension (4:3) for encoding, that is, 1440 x 1080.
   */
  VideoDimensions dimensions;
  /**
   * On Windows and macOS, it represents the video encoding frame rate (fps) of the shared screen stream.
   * The frame rate (fps) of the shared region. The default value is 5. We do not recommend setting
   * this to a value greater than 15.
   */
  int frameRate;
  /**
   * On Windows and macOS, it represents the video encoding bitrate of the shared screen stream.
   * The bitrate (Kbps) of the shared region. The default value is 0 (the SDK works out a bitrate
   * according to the dimensions of the current screen).
   */
  int bitrate;
  /** Whether to capture the mouse in screen sharing:
   * - `true`: (Default) Capture the mouse.
   * - `false`: Do not capture the mouse.
   */
  bool captureMouseCursor;
  /**
   * Whether to bring the window to the front when calling the `startScreenCaptureByWindowId` method to share it:
   * - `true`: Bring the window to the front.
   * - `false`: (Default) Do not bring the window to the front.
  */
  bool windowFocus;
  /**
   * A list of IDs of windows to be blocked. When calling `startScreenCaptureByDisplayId` to start screen sharing,
   * you can use this parameter to block a specified window. When calling `updateScreenCaptureParameters` to update
   * screen sharing configurations, you can use this parameter to dynamically block the specified windows during
   * screen sharing.
   */
  view_t *excludeWindowList;
  /**
   * The number of windows to be blocked.
   */
  int excludeWindowCount;

  /** The width (px) of the border. Defaults to 0, and the value range is [0,50].
    *
    */
  int highLightWidth;
  /** The color of the border in RGBA format. The default value is 0xFF8CBF26.
    *
    */
  unsigned int highLightColor;
  /** Whether to place a border around the shared window or screen:
    * - true: Place a border.
    * - false: (Default) Do not place a border.
    *
    * @note When you share a part of a window or screen, the SDK places a border around the entire window or screen if you set `enableHighLight` as true.
    *
    */
  bool enableHighLight;

  ScreenCaptureParameters()
    : dimensions(1920, 1080), frameRate(5), bitrate(STANDARD_BITRATE), captureMouseCursor(true), windowFocus(false), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0), highLightWidth(0), highLightColor(0), enableHighLight(false)  {}
  ScreenCaptureParameters(const VideoDimensions& d, int f, int b)
    : dimensions(d), frameRate(f), bitrate(b), captureMouseCursor(true), windowFocus(false), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0), highLightWidth(0), highLightColor(0), enableHighLight(false) {}
  ScreenCaptureParameters(int width, int height, int f, int b)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(true), windowFocus(false), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0), highLightWidth(0), highLightColor(0), enableHighLight(false){}
  ScreenCaptureParameters(int width, int height, int f, int b, bool cur, bool fcs)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(cur), windowFocus(fcs), excludeWindowList(OPTIONAL_NULLPTR), excludeWindowCount(0), highLightWidth(0), highLightColor(0), enableHighLight(false) {}
  ScreenCaptureParameters(int width, int height, int f, int b, view_t *ex, int cnt)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(true), windowFocus(false), excludeWindowList(ex), excludeWindowCount(cnt), highLightWidth(0), highLightColor(0), enableHighLight(false) {}
  ScreenCaptureParameters(int width, int height, int f, int b, bool cur, bool fcs, view_t *ex, int cnt)
    : dimensions(width, height), frameRate(f), bitrate(b), captureMouseCursor(cur), windowFocus(fcs), excludeWindowList(ex), excludeWindowCount(cnt), highLightWidth(0), highLightColor(0), enableHighLight(false) {}
};

/**
 * Audio recording quality.
 */
enum AUDIO_RECORDING_QUALITY_TYPE {
  /**
   * 0: Low quality. The sample rate is 32 kHz, and the file size is around 1.2 MB after 10 minutes of recording.
   */
  AUDIO_RECORDING_QUALITY_LOW = 0,
  /**
   * 1: Medium quality. The sample rate is 32 kHz, and the file size is around 2 MB after 10 minutes of recording.
   */
  AUDIO_RECORDING_QUALITY_MEDIUM = 1,
  /**
   * 2: High quality. The sample rate is 32 kHz, and the file size is around 3.75 MB after 10 minutes of recording.
   */
  AUDIO_RECORDING_QUALITY_HIGH = 2,
  /**
   * 3: Ultra high audio recording quality.
   */
  AUDIO_RECORDING_QUALITY_ULTRA_HIGH = 3,
};

/**
 * Recording content. Set in `startAudioRecording`.
 */
enum AUDIO_FILE_RECORDING_TYPE {
  /**
   * 1: Only records the audio of the local user.
   */
  AUDIO_FILE_RECORDING_MIC = 1,
  /**
   * 2: Only records the audio of all remote users.
   */
  AUDIO_FILE_RECORDING_PLAYBACK = 2,
  /**
   * 3: Records the mixed audio of the local and all remote users.
   */
  AUDIO_FILE_RECORDING_MIXED = 3,
};

/**
 * Audio encoded frame observer position.
 */
enum AUDIO_ENCODED_FRAME_OBSERVER_POSITION {
  /**
  * 1: Only records the audio of the local user.
  */
  AUDIO_ENCODED_FRAME_OBSERVER_POSITION_RECORD = 1,
  /**
  * 2: Only records the audio of all remote users.
  */
  AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK = 2,
  /**
  * 3: Records the mixed audio of the local and all remote users.
  */
  AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIXED = 3,
};

/**
 * Recording configuration.
 */
struct AudioRecordingConfiguration {
  /**
   * The absolute path (including the filename extensions) of the recording file. For example: `C:\music\audio.mp4`.
   * @note Ensure that the directory for the log files exists and is writable.
   */
  const char* filePath;
  /**
   * Whether to encode the audio data:
   * - `true`: Encode audio data in AAC.
   * - `false`: (Default) Do not encode audio data, but save the recorded audio data directly.
   */
  bool encode;
  /**
   * Recording sample rate (Hz).
   * - 16000
   * - (Default) 32000
   * - 44100
   * - 48000
   * @note If you set this parameter to 44100 or 48000, Agora recommends recording WAV files, or AAC files with quality
   * to be `AUDIO_RECORDING_QUALITY_MEDIUM` or `AUDIO_RECORDING_QUALITY_HIGH` for better recording quality.
   */
  int sampleRate;
  /**
   * The recording content. See `AUDIO_FILE_RECORDING_TYPE`.
   */
  AUDIO_FILE_RECORDING_TYPE fileRecordingType;
  /**
   * Recording quality. See `AUDIO_RECORDING_QUALITY_TYPE`.
   * @note This parameter applies to AAC files only.
   */
  AUDIO_RECORDING_QUALITY_TYPE quality;

  /**
   * Recording channel. The following values are supported:
   * - (Default) 1
   * - 2
   */
  int recordingChannel;

  AudioRecordingConfiguration()
    : filePath(OPTIONAL_NULLPTR),
      encode(false),
      sampleRate(32000),
      fileRecordingType(AUDIO_FILE_RECORDING_MIXED),
      quality(AUDIO_RECORDING_QUALITY_LOW),
      recordingChannel(1) {}

  AudioRecordingConfiguration(const char* file_path, int sample_rate, AUDIO_RECORDING_QUALITY_TYPE quality_type, int channel)
    : filePath(file_path),
      encode(false),
      sampleRate(sample_rate),
      fileRecordingType(AUDIO_FILE_RECORDING_MIXED),
      quality(quality_type),
      recordingChannel(channel) {}

  AudioRecordingConfiguration(const char* file_path, bool enc, int sample_rate, AUDIO_FILE_RECORDING_TYPE type, AUDIO_RECORDING_QUALITY_TYPE quality_type, int channel)
    : filePath(file_path),
      encode(enc),
      sampleRate(sample_rate),
      fileRecordingType(type),
      quality(quality_type),
      recordingChannel(channel) {}

  AudioRecordingConfiguration(const AudioRecordingConfiguration &rhs)
    : filePath(rhs.filePath),
      encode(rhs.encode),
      sampleRate(rhs.sampleRate),
      fileRecordingType(rhs.fileRecordingType),
      quality(rhs.quality),
      recordingChannel(rhs.recordingChannel) {}
};

/**
 * Observer settings for the encoded audio.
 */
struct AudioEncodedFrameObserverConfig {
    /**
     * Audio profile. For details, see `AUDIO_ENCODED_FRAME_OBSERVER_POSITION`.
     */
    AUDIO_ENCODED_FRAME_OBSERVER_POSITION postionType;
    /**
     * Audio encoding type. For details, see `AUDIO_ENCODING_TYPE`.
     */
    AUDIO_ENCODING_TYPE encodingType;

    AudioEncodedFrameObserverConfig()
    : postionType(AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK),
      encodingType(AUDIO_ENCODING_TYPE_OPUS_48000_MEDIUM){}

};
/**
 * The encoded audio observer.
 */
class IAudioEncodedFrameObserver {
public:
/**
* Gets the encoded audio data of the local user.
*
* After calling `registerAudioEncodedFrameObserver` and setting the encoded audio as `AUDIO_ENCODED_FRAME_OBSERVER_POSITION_RECORD`,
* you can get the encoded audio data of the local user from this callback.
*
* @param frameBuffer The pointer to the audio frame buffer.
* @param length The data length (byte) of the audio frame.
* @param audioEncodedFrameInfo Audio information after encoding. For details, see `EncodedAudioFrameInfo`.
*/
virtual void onRecordAudioEncodedFrame(const uint8_t* frameBuffer,  int length, const EncodedAudioFrameInfo& audioEncodedFrameInfo) = 0;

/**
* Gets the encoded audio data of all remote users.
*
* After calling `registerAudioEncodedFrameObserver` and setting the encoded audio as `AUDIO_ENCODED_FRAME_OBSERVER_POSITION_PLAYBACK`,
* you can get encoded audio data of all remote users through this callback.
*
* @param frameBuffer The pointer to the audio frame buffer.
* @param length The data length (byte) of the audio frame.
* @param audioEncodedFrameInfo Audio information after encoding. For details, see `EncodedAudioFrameInfo`.
*/
virtual void onPlaybackAudioEncodedFrame(const uint8_t* frameBuffer,  int length, const EncodedAudioFrameInfo& audioEncodedFrameInfo) = 0;

/**
* Gets the mixed and encoded audio data of the local and all remote users.
*
* After calling `registerAudioEncodedFrameObserver` and setting the audio profile as `AUDIO_ENCODED_FRAME_OBSERVER_POSITION_MIXED`,
* you can get the mixed and encoded audio data of the local and all remote users through this callback.
*
* @param frameBuffer The pointer to the audio frame buffer.
* @param length The data length (byte) of the audio frame.
* @param audioEncodedFrameInfo Audio information after encoding. For details, see `EncodedAudioFrameInfo`.
*/
virtual void onMixedAudioEncodedFrame(const uint8_t* frameBuffer,  int length, const EncodedAudioFrameInfo& audioEncodedFrameInfo) = 0;

virtual ~IAudioEncodedFrameObserver () {}
};

/** The region for connection, which is the region where the server the SDK connects to is located.
 */
enum AREA_CODE {
    /**
     * Mainland China.
     */
    AREA_CODE_CN = 0x00000001,
    /**
     * North America.
     */
    AREA_CODE_NA = 0x00000002,
    /**
     * Europe.
     */
    AREA_CODE_EU = 0x00000004,
    /**
     * Asia, excluding Mainland China.
     */
    AREA_CODE_AS = 0x00000008,
    /**
     * Japan.
     */
    AREA_CODE_JP = 0x00000010,
    /**
     * India.
     */
    AREA_CODE_IN = 0x00000020,
    /**
     * (Default) Global.
     */
    AREA_CODE_GLOB = (0xFFFFFFFF)
};

/**
  Extra region code
  @technical preview
*/
enum AREA_CODE_EX {
    /**
     * Oceania
    */
    AREA_CODE_OC = 0x00000040,
    /**
     * South-American
    */
    AREA_CODE_SA = 0x00000080,
    /**
     * Africa
    */
    AREA_CODE_AF = 0x00000100,
    /**
     * South Korea
     */
    AREA_CODE_KR = 0x00000200,
    /**
     * Hong Kong and Macou
     */
    AREA_CODE_HKMC = 0x00000400,
    /**
     * United States
     */
    AREA_CODE_US = 0x00000800,
    /**
     * Russia
     */
    AREA_CODE_RU = 0x00001000,
    /**
     * The global area (except China)
     */
    AREA_CODE_OVS = 0xFFFFFFFE
};

/**
 * The error code of the channel media replay.
 */
enum CHANNEL_MEDIA_RELAY_ERROR {
  /** 0: No error.
   */
  RELAY_OK = 0,
  /** 1: An error occurs in the server response.
   */
  RELAY_ERROR_SERVER_ERROR_RESPONSE = 1,
  /** 2: No server response. You can call the `leaveChannel` method to leave the channel.
   *
   * This error can also occur if your project has not enabled co-host token authentication. You can contact technical
   * support to enable the service for cohosting across channels before starting a channel media relay.
   */
  RELAY_ERROR_SERVER_NO_RESPONSE = 2,
  /** 3: The SDK fails to access the service, probably due to limited resources of the server.
   */
  RELAY_ERROR_NO_RESOURCE_AVAILABLE = 3,
  /** 4: Fails to send the relay request.
   */
  RELAY_ERROR_FAILED_JOIN_SRC = 4,
  /** 5: Fails to accept the relay request.
   */
  RELAY_ERROR_FAILED_JOIN_DEST = 5,
  /** 6: The server fails to receive the media stream.
   */
  RELAY_ERROR_FAILED_PACKET_RECEIVED_FROM_SRC = 6,
  /** 7: The server fails to send the media stream.
   */
  RELAY_ERROR_FAILED_PACKET_SENT_TO_DEST = 7,
  /** 8: The SDK disconnects from the server due to poor network connections. You can call the `leaveChannel` method to
   * leave the channel.
   */
  RELAY_ERROR_SERVER_CONNECTION_LOST = 8,
  /** 9: An internal error occurs in the server.
   */
  RELAY_ERROR_INTERNAL_ERROR = 9,
  /** 10: The token of the source channel has expired.
   */
  RELAY_ERROR_SRC_TOKEN_EXPIRED = 10,
  /** 11: The token of the destination channel has expired.
   */
  RELAY_ERROR_DEST_TOKEN_EXPIRED = 11,
};

/**
 * The state code of the channel media relay.
 */
enum CHANNEL_MEDIA_RELAY_STATE {
  /** 0: The initial state. After you successfully stop the channel media relay by calling `stopChannelMediaRelay`,
   * the `onChannelMediaRelayStateChanged` callback returns this state.
   */
  RELAY_STATE_IDLE = 0,
  /** 1: The SDK tries to relay the media stream to the destination channel.
   */
  RELAY_STATE_CONNECTING = 1,
  /** 2: The SDK successfully relays the media stream to the destination channel.
   */
  RELAY_STATE_RUNNING = 2,
  /** 3: An error occurs. See `code` in `onChannelMediaRelayStateChanged` for the error code.
   */
  RELAY_STATE_FAILURE = 3,
};

/** The definition of ChannelMediaInfo.
 */
struct ChannelMediaInfo {
  /** The user ID.
     */
  uid_t uid;
  /** The channel name. The default value is NULL, which means that the SDK
    * applies the current channel name.
    */
  const char* channelName;
  /** The token that enables the user to join the channel. The default value
    * is NULL, which means that the SDK applies the current token.
    */
  const char* token;

  ChannelMediaInfo() : uid(0), channelName(NULL), token(NULL) {}
  ChannelMediaInfo(const char* c, const char* t, uid_t u) : uid(u), channelName(c), token(t) {}
};

/** The definition of ChannelMediaRelayConfiguration.
 */
struct ChannelMediaRelayConfiguration {
  /** The information of the source channel `ChannelMediaInfo`. It contains the following members:
   * - `channelName`: The name of the source channel. The default value is `NULL`, which means the SDK applies the name
   * of the current channel.
   * - `uid`: The unique ID to identify the relay stream in the source channel. The default value is 0, which means the
   * SDK generates a random UID. You must set it as 0.
   * - `token`: The token for joining the source channel. It is generated with the `channelName` and `uid` you set in
   * `srcInfo`.
   *   - If you have not enabled the App Certificate, set this parameter as the default value `NULL`, which means the
   * SDK applies the App ID.
   *   - If you have enabled the App Certificate, you must use the token generated with the `channelName` and `uid`, and
   * the `uid` must be set as 0.
   */
  ChannelMediaInfo* srcInfo;
  /** The information of the destination channel `ChannelMediaInfo`. It contains the following members:
   * - `channelName`: The name of the destination channel.
   * - `uid`: The unique ID to identify the relay stream in the destination channel. The value
   * ranges from 0 to (2^32-1). To avoid UID conflicts, this `UID` must be different from any
   * other `UID` in the destination channel. The default value is 0, which means the SDK generates
   * a random `UID`. Do not set this parameter as the `UID` of the host in the destination channel,
   * and ensure that this `UID` is different from any other `UID` in the channel.
   * - `token`: The token for joining the destination channel. It is generated with the `channelName`
   * and `uid` you set in `destInfos`.
   *   - If you have not enabled the App Certificate, set this parameter as the default value NULL,
   * which means the SDK applies the App ID.
   * If you have enabled the App Certificate, you must use the token generated with the `channelName`
   * and `uid`.
   */
  ChannelMediaInfo* destInfos;
  /** The number of destination channels. The default value is 0, and the value range is from 0 to
   * 6. Ensure that the value of this parameter corresponds to the number of `ChannelMediaInfo`
   * structs you define in `destInfo`.
   */
  int destCount;

  ChannelMediaRelayConfiguration() : srcInfo(OPTIONAL_NULLPTR), destInfos(OPTIONAL_NULLPTR), destCount(0) {}
};

/**
 * The uplink network information.
 */
struct UplinkNetworkInfo {
  /**
   * The target video encoder bitrate (bps).
   */
  int video_encoder_target_bitrate_bps;

  UplinkNetworkInfo() : video_encoder_target_bitrate_bps(0) {}

  bool operator==(const UplinkNetworkInfo& rhs) const {
    return (video_encoder_target_bitrate_bps == rhs.video_encoder_target_bitrate_bps);
  }
};

struct DownlinkNetworkInfo {
  struct PeerDownlinkInfo {
    /**
     * The ID of the user who owns the remote video stream.
     */
    const char* userId;
    /**
     * The remote video stream type: #VIDEO_STREAM_TYPE.
     */
    VIDEO_STREAM_TYPE stream_type;
    /**
     * The remote video downscale type: #REMOTE_VIDEO_DOWNSCALE_LEVEL.
     */
    REMOTE_VIDEO_DOWNSCALE_LEVEL current_downscale_level;
    /**
     * The expected bitrate in bps.
     */
    int expected_bitrate_bps;

    PeerDownlinkInfo()
        : userId(OPTIONAL_NULLPTR),
          stream_type(VIDEO_STREAM_HIGH),
          current_downscale_level(REMOTE_VIDEO_DOWNSCALE_LEVEL_NONE),
          expected_bitrate_bps(-1) {}

    PeerDownlinkInfo(const PeerDownlinkInfo& rhs)
         : stream_type(rhs.stream_type),
          current_downscale_level(rhs.current_downscale_level),
          expected_bitrate_bps(rhs.expected_bitrate_bps) {
      if (rhs.userId != OPTIONAL_NULLPTR) {
        const int len = std::strlen(rhs.userId);
        char* buf = new char[len + 1];
        std::memcpy(buf, rhs.userId, len);
        buf[len] = '\0';
        userId = buf;
      }
    }

    PeerDownlinkInfo& operator=(const PeerDownlinkInfo& rhs) {
      if (this == &rhs) return *this;
      userId = OPTIONAL_NULLPTR;
      stream_type = rhs.stream_type;
      current_downscale_level = rhs.current_downscale_level;
      expected_bitrate_bps = rhs.expected_bitrate_bps;
      if (rhs.userId != OPTIONAL_NULLPTR) {
        const int len = std::strlen(rhs.userId);
        char* buf = new char[len + 1];
        std::memcpy(buf, rhs.userId, len);
        buf[len] = '\0';
        userId = buf;
      }
      return *this;
    }

    ~PeerDownlinkInfo() { delete[] userId; }
  };

  /**
   * The lastmile buffer delay queue time in ms.
   */
  int lastmile_buffer_delay_time_ms;
  /**
   * The current downlink bandwidth estimation(bps) after downscale.
   */
  int bandwidth_estimation_bps;
  /**
   * The total video downscale level count.
   */
  int total_downscale_level_count;
  /**
   * The peer video downlink info array.
   */
  PeerDownlinkInfo* peer_downlink_info;
  /**
   * The total video received count.
   */
  int total_received_video_count;

  DownlinkNetworkInfo()
    : lastmile_buffer_delay_time_ms(-1),
      bandwidth_estimation_bps(-1),
      total_downscale_level_count(-1),
      peer_downlink_info(OPTIONAL_NULLPTR),
      total_received_video_count(-1) {}

  DownlinkNetworkInfo(const DownlinkNetworkInfo& info)
    : lastmile_buffer_delay_time_ms(info.lastmile_buffer_delay_time_ms),
      bandwidth_estimation_bps(info.bandwidth_estimation_bps),
      total_downscale_level_count(info.total_downscale_level_count),
      peer_downlink_info(OPTIONAL_NULLPTR),
      total_received_video_count(info.total_received_video_count) {
    if (total_received_video_count <= 0) return;
    peer_downlink_info = new PeerDownlinkInfo[total_received_video_count];
    for (int i = 0; i < total_received_video_count; ++i)
      peer_downlink_info[i] = info.peer_downlink_info[i];
  }

  DownlinkNetworkInfo& operator=(const DownlinkNetworkInfo& rhs) {
    if (this == &rhs) return *this;
    lastmile_buffer_delay_time_ms = rhs.lastmile_buffer_delay_time_ms;
    bandwidth_estimation_bps = rhs.bandwidth_estimation_bps;
    total_downscale_level_count = rhs.total_downscale_level_count;
    peer_downlink_info = OPTIONAL_NULLPTR;
    total_received_video_count = rhs.total_received_video_count;
    if (total_received_video_count > 0) {
      peer_downlink_info = new PeerDownlinkInfo[total_received_video_count];
      for (int i = 0; i < total_received_video_count; ++i)
        peer_downlink_info[i] = rhs.peer_downlink_info[i];
    }
    return *this;
  }

  ~DownlinkNetworkInfo() { delete[] peer_downlink_info; }
};

/**
 * The built-in encryption mode.
 *
 * Agora recommends using AES_128_GCM2 or AES_256_GCM2 encrypted mode. These two modes support the
 * use of salt for higher security.
 */
enum ENCRYPTION_MODE {
  /** 1: 128-bit AES encryption, XTS mode.
   */
  AES_128_XTS = 1,
  /** 2: 128-bit AES encryption, ECB mode.
   */
  AES_128_ECB = 2,
  /** 3: 256-bit AES encryption, XTS mode.
   */
  AES_256_XTS = 3,
  /** 4: 128-bit SM4 encryption, ECB mode.
   */
  SM4_128_ECB = 4,
  /** 5: 128-bit AES encryption, GCM mode.
   */
  AES_128_GCM = 5,
  /** 6: 256-bit AES encryption, GCM mode.
   */
  AES_256_GCM = 6,
  /** 7: (Default) 128-bit AES encryption, GCM mode. This encryption mode requires the setting of
   * salt (`encryptionKdfSalt`).
   */
  AES_128_GCM2 = 7,
  /** 8: 256-bit AES encryption, GCM mode. This encryption mode requires the setting of salt (`encryptionKdfSalt`).
   */
  AES_256_GCM2 = 8,
  /** Enumerator boundary.
   */
  MODE_END,
};

/** Built-in encryption configurations. */
struct EncryptionConfig {
  /**
   * The built-in encryption mode. See #ENCRYPTION_MODE. Agora recommends using `AES_128_GCM2`
   * or `AES_256_GCM2` encrypted mode. These two modes support the use of salt for higher security.
   */
  ENCRYPTION_MODE encryptionMode;
  /**
   * Encryption key in string type with unlimited length. Agora recommends using a 32-byte key.
   *
   * @note If you do not set an encryption key or set it as NULL, you cannot use the built-in encryption, and the SDK returns #ERR_INVALID_ARGUMENT (-2).
   */
  const char* encryptionKey;
  /**
   * Salt, 32 bytes in length. Agora recommends that you use OpenSSL to generate salt on the server side.
   *
   * @note This parameter takes effect only in `AES_128_GCM2` or `AES_256_GCM2` encrypted mode.
   * In this case, ensure that this parameter is not 0.
   */
  uint8_t encryptionKdfSalt[32];
    
  bool datastreamEncryptionEnabled;

  EncryptionConfig()
    : encryptionMode(AES_128_GCM2),
      encryptionKey(OPTIONAL_NULLPTR),
      datastreamEncryptionEnabled(false)
  {
    memset(encryptionKdfSalt, 0, sizeof(encryptionKdfSalt));
  }

  /// @cond
  const char* getEncryptionString() const {
    switch(encryptionMode) {
      case AES_128_XTS:
        return "aes-128-xts";
      case AES_128_ECB:
        return "aes-128-ecb";
      case AES_256_XTS:
        return "aes-256-xts";
      case SM4_128_ECB:
        return "sm4-128-ecb";
      case AES_128_GCM:
        return "aes-128-gcm";
      case AES_256_GCM:
        return "aes-256-gcm";
      case AES_128_GCM2:
        return "aes-128-gcm-2";
      case AES_256_GCM2:
        return "aes-256-gcm-2";
      default:
        return "aes-128-gcm-2";
    }
    return "aes-128-gcm-2";
  }
  /// @endcond
};

/** Encryption error type.
 */
enum ENCRYPTION_ERROR_TYPE {
    /**
     * 0: Internal reason.
     */
    ENCRYPTION_ERROR_INTERNAL_FAILURE = 0,
    /**
     * 1: MediaStream decryption errors. Ensure that the receiver and the sender use the same encryption mode and key.
     */
    ENCRYPTION_ERROR_DECRYPTION_FAILURE = 1,
    /**
     * 2: MediaStream encryption errors.
     */
    ENCRYPTION_ERROR_ENCRYPTION_FAILURE = 2,
    /**
     * 3: DataStream decryption errors. Ensure that the receiver and the sender use the same encryption mode and key.
     */
    ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE = 3,
    /**
     * 4: DataStream encryption errors.
     */
    ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE = 4,
};

enum UPLOAD_ERROR_REASON
{
  UPLOAD_SUCCESS = 0,
  UPLOAD_NET_ERROR = 1,
  UPLOAD_SERVER_ERROR = 2,
};

/** The type of the device permission.
 */
enum PERMISSION_TYPE {
  /**
   * 0: Permission for the audio capture device.
   */
  RECORD_AUDIO = 0,
  /**
   * 1: Permission for the camera.
   */
  CAMERA = 1,

  SCREEN_CAPTURE = 2,
};

/**
 * The subscribing state.
 */
enum STREAM_SUBSCRIBE_STATE {
  /**
   * 0: The initial subscribing state after joining the channel.
   */
  SUB_STATE_IDLE = 0,
  /**
   * 1: Fails to subscribe to the remote stream. Possible reasons:
   * - The remote user:
   *   - Calls `muteLocalAudioStream(true)` or `muteLocalVideoStream(true)` to stop sending local
   * media stream.
   *   - Calls `disableAudio` or `disableVideo `to disable the local audio or video module.
   *   - Calls `enableLocalAudio(false)` or `enableLocalVideo(false)` to disable the local audio or video capture.
   *   - The role of the remote user is audience.
   * - The local user calls the following methods to stop receiving remote streams:
   *   - Calls `muteRemoteAudioStream(true)`, `muteAllRemoteAudioStreams(true)` to stop receiving the remote audio streams.
   *   - Calls `muteRemoteVideoStream(true)`, `muteAllRemoteVideoStreams(true)` to stop receiving the remote video streams.
   */
  SUB_STATE_NO_SUBSCRIBED = 1,
  /**
   * 2: Subscribing.
   */
  SUB_STATE_SUBSCRIBING = 2,
  /**
   * 3: Subscribes to and receives the remote stream successfully.
   */
  SUB_STATE_SUBSCRIBED = 3
};

/**
 * The publishing state.
 */
enum STREAM_PUBLISH_STATE {
  /**
   * 0: The initial publishing state after joining the channel.
   */
  PUB_STATE_IDLE = 0,
  /**
   * 1: Fails to publish the local stream. Possible reasons:
   * - The local user calls `muteLocalAudioStream(true)` or `muteLocalVideoStream(true)` to stop sending the local media stream.
   * - The local user calls `disableAudio` or `disableVideo` to disable the local audio or video module.
   * - The local user calls `enableLocalAudio(false)` or `enableLocalVideo(false)` to disable the local audio or video capture.
   * - The role of the local user is audience.
   */
  PUB_STATE_NO_PUBLISHED = 1,
  /**
   * 2: Publishing.
   */
  PUB_STATE_PUBLISHING = 2,
  /**
   * 3: Publishes successfully.
   */
  PUB_STATE_PUBLISHED = 3
};

/**
 * The EchoTestConfiguration struct.
 */
struct EchoTestConfiguration {
  view_t view;
  bool enableAudio;
  bool enableVideo;
  const char* token;
  const char* channelId;
  int intervalInSeconds;

  EchoTestConfiguration(view_t v, bool ea, bool ev, const char* t, const char* c, const int is)
   : view(v), enableAudio(ea), enableVideo(ev), token(t), channelId(c), intervalInSeconds(is) {}

  EchoTestConfiguration()
   : view(OPTIONAL_NULLPTR), enableAudio(true), enableVideo(true), token(OPTIONAL_NULLPTR), channelId(OPTIONAL_NULLPTR), intervalInSeconds(2) {}
};

/**
 * The information of the user.
 */
struct UserInfo {
  /**
   * The user ID.
   */
  uid_t uid;
  /**
   * The user account. The maximum data length is `MAX_USER_ACCOUNT_LENGTH_TYPE`.
   */
  char userAccount[MAX_USER_ACCOUNT_LENGTH];

  UserInfo() : uid(0) {
    userAccount[0] = '\0';
  }
};

/**
 * The audio filter of in-ear monitoring.
 */
enum EAR_MONITORING_FILTER_TYPE {
  /**
   * 1: Do not add an audio filter to the in-ear monitor.
   */
  EAR_MONITORING_FILTER_NONE = (1<<0),
  /**
   * 2: Enable audio filters to the in-ear monitor. If you implement functions such as voice
   * beautifier and audio effect, users can hear the voice after adding these effects.
   */
  EAR_MONITORING_FILTER_BUILT_IN_AUDIO_FILTERS = (1<<1),
  /**
   * 4: Enable noise suppression to the in-ear monitor.
   */
  EAR_MONITORING_FILTER_NOISE_SUPPRESSION = (1<<2),
  /**
   * 32768: Enable audio filters by reuse post-processing filter to the in-ear monitor.
   * This bit is intended to be used in exclusive mode, which means, if this bit is set, all other bits will be disregarded.
   */
  EAR_MONITORING_FILTER_REUSE_POST_PROCESSING_FILTER = (1<<15),
};

/**
 * Thread priority type.
 */
enum THREAD_PRIORITY_TYPE {
  /**
   * 0: Lowest priority.
   */
  LOWEST = 0,
  /**
   * 1: Low priority.
   */
  LOW = 1,
  /**
   * 2: Normal priority.
   */
  NORMAL = 2,
  /**
   * 3: High priority.
   */
  HIGH = 3,
  /**
   * 4. Highest priority.
   */
  HIGHEST = 4,
  /**
   * 5. Critical priority.
   */
  CRITICAL = 5,
};

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)

/**
 * The video configuration for the shared screen stream.
 */
struct ScreenVideoParameters {
  /**
   * The dimensions of the video encoding resolution. The default value is `1280` x `720`.
   * For recommended values, see [Recommended video
   * profiles](https://docs.agora.io/en/Interactive%20Broadcast/game_streaming_video_profile?platform=Android#recommended-video-profiles).
   * If the aspect ratio is different between width and height and the screen, the SDK adjusts the
   * video encoding resolution according to the following rules (using an example where `width` ×
   * `height` is 1280 × 720):
   * - When the width and height of the screen are both lower than `width` and `height`, the SDK
   * uses the resolution of the screen for video encoding. For example, if the screen is 640 ×
   * 360, The SDK uses 640 × 360 for video encoding.
   * - When either the width or height of the screen is higher than `width` or `height`, the SDK
   * uses the maximum values that do not exceed those of `width` and `height` while maintaining
   * the aspect ratio of the screen for video encoding. For example, if the screen is 2000 × 1500,
   * the SDK uses 960 × 720 for video encoding.
   *
   * @note
   * - The billing of the screen sharing stream is based on the values of width and height.
   * When you do not pass in these values, Agora bills you at 1280 × 720;
   * when you pass in these values, Agora bills you at those values.
   * For details, see [Pricing for Real-time
   * Communication](https://docs.agora.io/en/Interactive%20Broadcast/billing_rtc).
   * - This value does not indicate the orientation mode of the output ratio.
   * For how to set the video orientation, see `ORIENTATION_MODE`.
   * - Whether the SDK can support a resolution at 720P depends on the performance of the device.
   * If you set 720P but the device cannot support it, the video frame rate can be lower.
   */
  VideoDimensions dimensions;
  /**
   * The video encoding frame rate (fps). The default value is `15`.
   * For recommended values, see [Recommended video
   * profiles](https://docs.agora.io/en/Interactive%20Broadcast/game_streaming_video_profile?platform=Android#recommended-video-profiles).
   */
  int frameRate = 15;
   /**
   * The video encoding bitrate (Kbps). For recommended values, see [Recommended video
   * profiles](https://docs.agora.io/en/Interactive%20Broadcast/game_streaming_video_profile?platform=Android#recommended-video-profiles).
   */
  int bitrate;
  /*
   * The content hint of the screen sharing:
   */
  VIDEO_CONTENT_HINT contentHint = VIDEO_CONTENT_HINT::CONTENT_HINT_MOTION;

  ScreenVideoParameters() : dimensions(1280, 720) {}
};

/**
 * The audio configuration for the shared screen stream.
 */
struct ScreenAudioParameters {
  /**
   * The audio sample rate (Hz). The default value is `16000`.
   */
  int sampleRate = 16000;
  /**
   * The number of audio channels. The default value is `2`, indicating dual channels.
   */
  int channels = 2;
  /**
   * The volume of the captured system audio. The value range is [0,100]. The default value is
   * `100`.
   */
  int captureSignalVolume = 100;
};

/**
 * The configuration of the screen sharing
 */
struct ScreenCaptureParameters2 {
  /**
   * Determines whether to capture system audio during screen sharing:
   * - `true`: Capture.
   * - `false`: (Default)  Do not capture.
   *
   * **Note**
   * Due to system limitations, capturing system audio is only available for Android API level 29
   * and later (that is, Android 10 and later).
   */
  bool captureAudio = false;
  /**
   * The audio configuration for the shared screen stream.
   */
  ScreenAudioParameters audioParams;
  /**
   * Determines whether to capture the screen during screen sharing:
   * - `true`: (Default) Capture.
   * - `false`: Do not capture.
   *
   * **Note**
   * Due to system limitations, screen capture is only available for Android API level 21 and later
   * (that is, Android 5 and later).
   */
  bool captureVideo = true;
  /**
   * The video configuration for the shared screen stream.
   */
  ScreenVideoParameters videoParams;
};
#endif

/**
 * The tracing event of media rendering.
 */
enum MEDIA_TRACE_EVENT {
  /**
   * 0: The media frame has been rendered.
   */
  MEDIA_TRACE_EVENT_VIDEO_RENDERED = 0,
  /**
   * 1: The media frame has been decoded.
   */
  MEDIA_TRACE_EVENT_VIDEO_DECODED,
};

/**
 * The video rendering tracing result
 */
struct VideoRenderingTracingInfo {
  /**
   * Elapsed time from the start tracing time to the time when the tracing event occurred.
   */
  int elapsedTime;
  /**
   * Elapsed time from the start tracing time to the time when join channel.
   * 
   * **Note**
   * If the start tracing time is behind the time when join channel, this value will be negative.
   */
  int start2JoinChannel;
  /**
   * Elapsed time from joining channel to finishing joining channel.
   */
  int join2JoinSuccess;
  /**
   * Elapsed time from finishing joining channel to remote user joined.
   * 
   * **Note**
   * If the start tracing time is after the time finishing join channel, this value will be
   * the elapsed time from the start tracing time to remote user joined. The minimum value is 0.
   */
  int joinSuccess2RemoteJoined;
  /**
   * Elapsed time from remote user joined to set the view.
   * 
   * **Note**
   * If the start tracing time is after the time when remote user joined, this value will be
   * the elapsed time from the start tracing time to set the view. The minimum value is 0.
   */
  int remoteJoined2SetView;
  /**
   * Elapsed time from remote user joined to the time subscribing remote video stream.
   * 
   * **Note**
   * If the start tracing time is after the time when remote user joined, this value will be
   * the elapsed time from the start tracing time to the time subscribing remote video stream.
   * The minimum value is 0.
   */
  int remoteJoined2UnmuteVideo;
  /**
   * Elapsed time from remote user joined to the remote video packet received.
   * 
   * **Note**
   * If the start tracing time is after the time when remote user joined, this value will be
   * the elapsed time from the start tracing time to the time subscribing remote video stream.
   * The minimum value is 0.
   */
  int remoteJoined2PacketReceived;
};

enum CONFIG_FETCH_TYPE {
  /**
   * 1: Fetch config when initializing RtcEngine, without channel info.
   */
  CONFIG_FETCH_TYPE_INITIALIZE = 1,
  /**
   * 2: Fetch config when joining channel with channel info, such as channel name and uid.
   */
  CONFIG_FETCH_TYPE_JOIN_CHANNEL = 2,
};


/** The local  proxy mode type. */
enum LOCAL_PROXY_MODE {
  /** 0: Connect local proxy with high priority, if not connected to local proxy, fallback to sdrtn.
   */
  ConnectivityFirst = 0,
  /** 1: Only connect local proxy
   */
  LocalOnly = 1,
};

struct LogUploadServerInfo {
  /** Log upload server domain
   */
  const char* serverDomain;
  /** Log upload server path
   */
  const char* serverPath;
  /** Log upload server port
   */
  int serverPort;
  /** Whether to use HTTPS request:
    - true: Use HTTPS request
    - fasle: Use HTTP request
   */
  bool serverHttps;

  LogUploadServerInfo() : serverDomain(NULL), serverPath(NULL), serverPort(0), serverHttps(true) {}

  LogUploadServerInfo(const char* domain, const char* path, int port, bool https) : serverDomain(domain), serverPath(path), serverPort(port), serverHttps(https) {}
};

struct AdvancedConfigInfo {
  /** Log upload server
   */
  LogUploadServerInfo logUploadServer;
};

struct LocalAccessPointConfiguration {
  /** Local access point IP address list.
   */
  const char** ipList;
  /** The number of local access point IP address.
   */
  int ipListSize;
  /** Local access point domain list.
   */
  const char** domainList;
  /** The number of local access point domain.
   */
  int domainListSize;
  /** Certificate domain name installed on specific local access point. pass "" means using sni domain on specific local access point
   *  SNI(Server Name Indication) is an extension to the TLS protocol.
   */
  const char* verifyDomainName;
  /** Local proxy connection mode, connectivity first or local only.
   */
  LOCAL_PROXY_MODE mode;
  /** Local proxy connection, advanced Config info.
   */
  AdvancedConfigInfo advancedConfig;
  /**
    * Whether to disable vos-aut:
    - true: (Default)disable vos-aut.
    - false: not disable vos-aut
  */
  bool disableAut;
  LocalAccessPointConfiguration() : ipList(NULL), ipListSize(0), domainList(NULL), domainListSize(0), verifyDomainName(NULL), mode(ConnectivityFirst), disableAut(true) {}
};

/**
 * The information about recorded media streams.
 */
struct RecorderStreamInfo {
    const char* channelId;
    /**
     * The user ID.
     */
    uid_t uid;
    /**
     * The channel ID of the audio/video stream needs to be recorded.
     */
    RecorderStreamInfo() : channelId(NULL), uid(0) {}
    RecorderStreamInfo(const char* channelId, uid_t uid) : channelId(channelId), uid(uid) {}
};
}  // namespace rtc

namespace base {

class IEngineBase {
 public:
  virtual int queryInterface(rtc::INTERFACE_ID_TYPE iid, void** inter) = 0;
  virtual ~IEngineBase() {}
};

class AParameter : public agora::util::AutoPtr<IAgoraParameter> {
 public:
  AParameter(IEngineBase& engine) { initialize(&engine); }
  AParameter(IEngineBase* engine) { initialize(engine); }
  AParameter(IAgoraParameter* p) : agora::util::AutoPtr<IAgoraParameter>(p) {}

 private:
  bool initialize(IEngineBase* engine) {
    IAgoraParameter* p = OPTIONAL_NULLPTR;
    if (engine && !engine->queryInterface(rtc::AGORA_IID_PARAMETER_ENGINE, (void**)&p)) reset(p);
    return p != OPTIONAL_NULLPTR;
  }
};

class LicenseCallback {
  public:
    virtual ~LicenseCallback() {}
    virtual void onCertificateRequired() = 0;
    virtual void onLicenseRequest() = 0;
    virtual void onLicenseValidated() = 0;
    virtual void onLicenseError(int result) = 0;
};

}  // namespace base

/**
 * Spatial audio parameters
 */
struct SpatialAudioParams {
  /**
   * Speaker azimuth in a spherical coordinate system centered on the listener.
   */
  Optional<double> speaker_azimuth;
  /**
   * Speaker elevation in a spherical coordinate system centered on the listener.
   */
  Optional<double> speaker_elevation;
  /**
   * Distance between speaker and listener.
   */
  Optional<double> speaker_distance;
  /**
   * Speaker orientation [0-180], 0 degree is the same with listener orientation.
   */
  Optional<int> speaker_orientation;
  /**
   * Enable blur or not for the speaker.
   */
  Optional<bool> enable_blur;
  /**
   * Enable air absorb or not for the speaker.
   */
  Optional<bool> enable_air_absorb;
  /**
   * Speaker attenuation factor.
   */
  Optional<double> speaker_attenuation;
  /**
   * Enable doppler factor.
   */
  Optional<bool> enable_doppler;
};
/**
 * Layout info of video stream which compose a transcoder video stream.
*/
struct VideoLayout
{
  /**
   * Channel Id from which this video stream come from.
  */
  const char* channelId;
  /**
   * User id of video stream.
  */
  rtc::uid_t uid;
  /**
   * User account of video stream.
  */
  user_id_t strUid;
  /**
   * x coordinate of video stream on a transcoded video stream canvas.
  */
  uint32_t x;
  /**
   * y coordinate of video stream on a transcoded video stream canvas.
  */
  uint32_t y;
  /**
   * width of video stream on a transcoded video stream canvas.
  */
  uint32_t width;
  /**
   * height of video stream on a transcoded video stream canvas.
  */
  uint32_t height;
  /**
   * video state  of video stream on a transcoded video stream canvas.
   * 0 for normal video , 1 for placeholder image showed , 2 for black image.
  */ 
  uint32_t videoState; 

  VideoLayout() : channelId(OPTIONAL_NULLPTR), uid(0), strUid(OPTIONAL_NULLPTR), x(0), y(0), width(0), height(0), videoState(0) {}
};
}  // namespace agora

/**
 * Gets the version of the SDK.
 * @param [out] build The build number of Agora SDK.
 * @return The string of the version of the SDK.
 */
AGORA_API const char* AGORA_CALL getAgoraSdkVersion(int* build);

/**
 * Gets error description of an error code.
 * @param [in] err The error code.
 * @return The description of the error code.
 */
AGORA_API const char* AGORA_CALL getAgoraSdkErrorDescription(int err);

AGORA_API int AGORA_CALL setAgoraSdkExternalSymbolLoader(void* (*func)(const char* symname));

/**
 * Generate credential
 * @param [in, out] credential The content of the credential.
 * @return The description of the error code.
 * @note For license only, everytime will generate a different credential.
 * So, just need to call once for a device, and then save the credential
 */
AGORA_API int AGORA_CALL createAgoraCredential(agora::util::AString &credential);

/**
 * Verify given certificate and return the result
 * When you receive onCertificateRequired event, you must validate the certificate by calling
 * this function. This is sync call, and if validation is success, it will return ERR_OK. And
 * if failed to pass validation, you won't be able to joinChannel and ERR_CERT_FAIL will be
 * returned.
 * @param [in] credential_buf pointer to the credential's content.
 * @param [in] credential_len the length of the credential's content.
 * @param [in] certificate_buf pointer to the certificate's content.
 * @param [in] certificate_len the length of the certificate's content.
 * @return The description of the error code.
 * @note For license only.
 */
AGORA_API int AGORA_CALL getAgoraCertificateVerifyResult(const char *credential_buf, int credential_len,
    const char *certificate_buf, int certificate_len);

/**
 * @brief Implement the agora::base::LicenseCallback,
 * create a LicenseCallback object to receive callbacks of license.
 *
 * @param [in] callback The object of agora::LiceseCallback,
 *                      set the callback to null before delete it.
 */
AGORA_API void setAgoraLicenseCallback(agora::base::LicenseCallback *callback);

/**
 * @brief Get the LicenseCallback pointer if already setup,
 *  otherwise, return null.
 *
 * @return a pointer of agora::base::LicenseCallback
 */

AGORA_API agora::base::LicenseCallback* getAgoraLicenseCallback();

/*
 * Get monotonic time in ms which can be used by capture time,
 * typical scenario is as follows:
 *
 *  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 *  |  // custom audio/video base capture time, e.g. the first audio/video capture time.             |
 *  |  int64_t custom_capture_time_base;                                                             |
 *  |                                                                                                |
 *  |  int64_t agora_monotonic_time = getAgoraCurrentMonotonicTimeInMs();                            |
 *  |                                                                                                |
 *  |  // offset is fixed once calculated in the begining.                                           |
 *  |  const int64_t offset = agora_monotonic_time - custom_capture_time_base;                       |
 *  |                                                                                                |
 *  |  // realtime_custom_audio/video_capture_time is the origin capture time that customer provided.|
 *  |  // actual_audio/video_capture_time is the actual capture time transfered to sdk.              |
 *  |  int64_t actual_audio_capture_time = realtime_custom_audio_capture_time + offset;              |
 *  |  int64_t actual_video_capture_time = realtime_custom_video_capture_time + offset;              |
 *  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 *
 * @return
 * - >= 0: Success.
 * - < 0: Failure.
 */
AGORA_API int64_t AGORA_CALL getAgoraCurrentMonotonicTimeInMs();
