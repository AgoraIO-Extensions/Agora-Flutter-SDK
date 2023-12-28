//
//  Agora Media SDK
//
//  Copyright (c) 2022 Agora IO. All rights reserved.
//

#pragma once

#include "AgoraBase.h"
#include "AgoraMediaBase.h"

namespace agora{
namespace rtc{

/**
 * The result of IH265Transcoder interface invoking.
*/
enum H265_TRANSCODE_RESULT {
  /**
   * -1: Unknown error.
  */
  H265_TRANSCODE_RESULT_UNKNOWN = -1,
  /**
   * 0: The request of operation is successfully.
  */
  H265_TRANSCODE_RESULT_SUCCESS = 0,
  /**
   * 1: This request is invalid. Possible reasons include incorrect parameters.
  */
  H265_TRANSCODE_RESULT_REQUEST_INVALID = 1,
  /**
   * 2: Authentication failed, please check for correctness of token.
  */
  H265_TRANSCODE_RESULT_UNAUTHORIZED = 2,
  /**
   * 3: The token is expired, please update token.
  */
  H265_TRANSCODE_RESULT_TOKEN_EXPIRED = 3,
  /**
   * 4: No permission to access the interface.
  */
  H265_TRANSCODE_RESULT_FORBIDDEN = 4,
  /**
   * 5: The url of request is not found.
  */
  H265_TRANSCODE_RESULT_NOT_FOUND = 5,
  /**
   * 6: The request encountered a conflict, please try again.
  */
  H265_TRANSCODE_RESULT_CONFLICTED = 6,
  /**
   * 7: Content type not supported.
  */
  H265_TRANSCODE_RESULT_NOT_SUPPORTED = 7,
  /**
   * 8: The requests are too frequent.
  */
  H265_TRANSCODE_RESULT_TOO_OFTEN = 8,
  /**
   * 9: Internal Server Error, you can try sending the request again.
  */
  H265_TRANSCODE_RESULT_SERVER_INTERNAL_ERROR = 9,
  /**
   * 10: Service is unavailable.
  */
  H265_TRANSCODE_RESULT_SERVICE_UNAVAILABLE = 10
};

/**
 * The IH265TranscoderObserver class
*/
class IH265TranscoderObserver {
 public:
  virtual ~IH265TranscoderObserver() {};

  /**
   * Use to notify the result of invoking enableTranscode interface.
   * @param result Result of invoking enableTranscode interface. There are some processing advice below of result.
   * - H265_TRANSCODE_RESULT_REQUEST_INVALID: Channel or uid param have a mistake, you need to check them for correctness.
   * - H265_TRANSCODE_RESULT_UNAUTHORIZED: Authentication failed, please check for correctness of token.
   * - H265_TRANSCODE_RESULT_TOKEN_EXPIRED: The token has expired, you need to generate a new token.
   * - H265_TRANSCODE_RESULT_FORBIDDEN: You need to contact agora staff to add the vid whitelist.
   * - H265_TRANSCODE_RESULT_NOT_FOUND: Indicates that the network may be faulty.
   * - H265_TRANSCODE_RESULT_TOO_OFTEN: Request is too often, please request again later.
   * - H265_TRANSCODE_RESULT_SERVER_INTERNAL_ERROR: The service has an internal error. A request can be made again.
  */
  virtual void onEnableTranscode(H265_TRANSCODE_RESULT result) = 0;

  /**
   * Use to notify the result of invoking queryChannel interface.
   * @param result Result of invoking queryChannel interface. There are some processing advice below of result.
   * - H265_TRANSCODE_RESULT_UNAUTHORIZED: Authentication failed, please check for correctness of token.
   * - H265_TRANSCODE_RESULT_TOKEN_EXPIRED: The token has expired, you need to generate a new token.
   * - H265_TRANSCODE_RESULT_NOT_FOUND: Indicates that the network may be faulty or the channel param may be is empty.
   * - H265_TRANSCODE_RESULT_TOO_OFTEN: Request is too often, please request again later.
   * - H265_TRANSCODE_RESULT_SERVER_INTERNAL_ERROR: The service has an internal error. A request can be made again.
   * 
   * @param originChannel Origin channel id
   * @param transcodeChannel Transcode channel id
  */
  virtual void onQueryChannel(H265_TRANSCODE_RESULT result, const char* originChannel, const char* transcodeChannel) = 0;
  
  /** Use to notify the result of invoking triggerTranscode interface.
   * @param result Result of invoking triggerTranscode interface. There are some processing advice below of result.
   * - H265_TRANSCODE_RESULT_UNAUTHORIZED: Authentication failed, please check for correctness of token.
   * - H265_TRANSCODE_RESULT_TOKEN_EXPIRED: The token has expired, you need to generate a new token.
   * - H265_TRANSCODE_RESULT_NOT_FOUND: Indicates that the network may be faulty or the channel param may be is empty.
   * - H265_TRANSCODE_RESULT_CONFLICTED: The request of trigger transcode is conflicted, please try again.
   * - H265_TRANSCODE_RESULT_TOO_OFTEN: Request is too often, please request again later
   * - H265_TRANSCODE_RESULT_SERVER_INTERNAL_ERROR: The service has an internal error. A request can be made again.
   * - H265_TRANSCODE_RESULT_SERVICE_UNAVAILABLE: May be the number of transcode service is over the limit.
  */
  virtual void onTriggerTranscode(H265_TRANSCODE_RESULT result) = 0;

};

/**
 * The IH265Transcoder class
*/
class IH265Transcoder : public RefCountInterface {
 public:
  /**
   * Enable transcoding for a channel.
   * @param token The token for authentication.
   * @param channel The unique channel name for the AgoraRTC session in the string format.
   * @param uid  User ID.
   * @return
   * -  0: Success.
   * - <0: Failure.
  */
  virtual int enableTranscode(const char *token, const char *channel, uid_t uid) = 0;

  /**
   * Query the transcoded channel of a channel.
   * @param token The token for authentication.
   * @param channel The unique channel name for the AgoraRTC session in the string format.
   * @param uid  User ID.
   * @return
   * -  0: Success.
   * - <0: Failure.
  */
  virtual int queryChannel(const char *token, const char *channel, uid_t uid) = 0;

  /**
   * Trigger channel transcoding.
   * @param token The token for authentication.
   * @param channel The unique channel name for the AgoraRTC session in the string format.
   * @param uid  User ID.
   * @return
   * -  0: Success.
   * - <0: Failure.
  */
  virtual int triggerTranscode(const char* token, const char* channel, uid_t uid) = 0;
  /**
   * Register a IH265TranscoderObserver object.
   * @param observer IH265TranscoderObserver.
   * @return
   * -  0: Success.
   * - <0: Failure.
  */
  virtual int registerTranscoderObserver(IH265TranscoderObserver *observer) = 0;
  /**
   * Unregister a IH265TranscoderObserver object.
   * @param observer IH265TranscoderObserver.
   * @return
   * -  0: Success.
   * - <0: Failure.
  */
  virtual int unregisterTranscoderObserver(IH265TranscoderObserver *observer) = 0;

 
 protected:
  virtual ~IH265Transcoder() {};

};

} // namespace rtc
} // namespace agora