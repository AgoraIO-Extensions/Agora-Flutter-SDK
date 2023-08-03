//
//  Agora SDK
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
//  Created by xiaohua.lu in 2020-03.
//  CodeStyle: Google C++
//

#pragma once  // NOLINT(build/header_guard)


#include "AgoraBase.h"
#include "AgoraMediaBase.h"
#include "AgoraMediaPlayerTypes.h"
#include "AgoraRefPtr.h"

namespace agora {
namespace rtc {


class IMediaStreamingSourceObserver;


/**
 * @brief The error code of streaming source
 *
 */
enum STREAMING_SRC_ERR {
  STREAMING_SRC_ERR_NONE = 0,               ///< no error
  STREAMING_SRC_ERR_UNKNOWN = 1,            ///< unknown error
  STREAMING_SRC_ERR_INVALID_PARAM = 2,      ///< invalid parameter
  STREAMING_SRC_ERR_BAD_STATE = 3,          ///< bad status
  STREAMING_SRC_ERR_NO_MEM = 4,             ///< not enough memory
  STREAMING_SRC_ERR_BUFFER_OVERFLOW = 5,    ///< buffer overflow
  STREAMING_SRC_ERR_BUFFER_UNDERFLOW = 6,   ///< buffer underflow
  STREAMING_SRC_ERR_NOT_FOUND = 7,          ///< buffer underflow
  STREAMING_SRC_ERR_TIMEOUT = 8,            ///< buffer underflow
  STREAMING_SRC_ERR_EXPIRED = 9,            ///< expired
  STREAMING_SRC_ERR_UNSUPPORTED = 10,       ///< unsupported
  STREAMING_SRC_ERR_NOT_EXIST = 11,         ///< component not exist
  STREAMING_SRC_ERR_EXIST = 12,             ///< component already exist
  STREAMING_SRC_ERR_OPEN = 13,              ///< fail to IO open
  STREAMING_SRC_ERR_CLOSE = 14,             ///< fail to IO close
  STREAMING_SRC_ERR_READ = 15,              ///< fail to IO read
  STREAMING_SRC_ERR_WRITE = 16,             ///< fail to IO write
  STREAMING_SRC_ERR_SEEK = 17,              ///< fail to IO seek
  STREAMING_SRC_ERR_EOF = 18,               ///< reach to IO EOF, can do nothing
  STREAMING_SRC_ERR_CODECOPEN = 19,         ///< fail to codec open
  STREAMING_SRC_ERR_CODECCLOSE = 20,        ///< fail to codec close
  STREAMING_SRC_ERR_CODECPROC = 21,         ///< fail to codec process
};



/**
 * @brief The state machine of Streaming Source
 *
 */
enum STREAMING_SRC_STATE {
  STREAMING_SRC_STATE_CLOSED   = 0,  ///< streaming source still closed, can do nothing
  STREAMING_SRC_STATE_OPENING  = 1,  ///< after call open() method and start parsing streaming source
  STREAMING_SRC_STATE_IDLE     = 2,  ///< streaming source is ready waiting for play
  STREAMING_SRC_STATE_PLAYING  = 3,  ///< after call play() method, playing & pushing the AV data
  STREAMING_SRC_STATE_SEEKING  = 4,  ///< after call seek() method, start seeking poisition
  STREAMING_SRC_STATE_EOF      = 5,  ///< The position is located at end, can NOT playing
  STREAMING_SRC_STATE_ERROR    = 6,  ///< The error status and can do nothing except close
};


/**
 * @brief The input SEI data
 *
 */
struct InputSeiData {
  int32_t         type;           ///< SEI type
  int64_t         timestamp;      ///< the frame timestamp which be attached
  int64_t         frame_index;    ///< the frame index which be attached
  uint8_t*        private_data;   ///< SEI really data
  int32_t         data_size;      ///< size of really data
};



/**
 * @brief The IMediaStreamingSource class provides access to a media streaming source demuxer. 
 *        To playout multiple stream sources simultaneously,
 *        create multiple media stream source objects.
 */
class IMediaStreamingSource : public RefCountInterface {
public:
  virtual ~IMediaStreamingSource() {};


  /**
   * @brief Opens a media streaming source with a specified URL.
   * @param url The path of the media file. Both the local path and online path are supported.
   * @param startPos The starting position (ms) for pushing. Default value is 0.
   * @param auto_play whether start playing after opened
   * @return
   * - 0: Success.
   * - < 0: Failure
   */
  virtual int open(const char* url, int64_t start_pos, bool auto_play = true) = 0;

  /**
   * @brief Close current media streaming source
   * @return
   * - 0: Success.
   * - < 0: Failure
   */
  virtual int close() = 0;

  /**
   * @brief Gets the unique source ID of the streaming source.
   * @return
   * - ≧ 0: The source ID of this media player source.
   * - < 0: Failure. 
   */
  virtual int getSourceId() const = 0;

  /**
   * @brief Retrieve whether video stream is valid
   * @return: valid or invalid
   */
  virtual bool isVideoValid() = 0;

  /**
   * @brief Retrieve whether audio stream is valid
   * @return: valid or invalid
   */
  virtual bool isAudioValid() = 0;

  /**
   * @brief Gets the duration of the streaming source.
   * @param [out] duration A reference to the duration of the media file.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int getDuration(int64_t& duration) = 0;

  /**
   * @brief Gets the number of the streming source
   * @param [out] count The number of the media streams in the media source.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int getStreamCount(int64_t& count) = 0;

  /**
   * @brief Gets the detailed information of a media stream.
   * @param index The index of the media stream.
   * @param [out] out_info The detailed information of the media stream. See \ref media::base::PlayerStreamInfo "PlayerStreamInfo" for details.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int getStreamInfo(int64_t index, media::base::PlayerStreamInfo* out_info) = 0;

  /**
   * @brief Sets whether to loop the streaming source for playback.
   * @param loop_count The number of times of looping the media file.
   * - 1: Play the media file once.
   * - 2: Play the media file twice.
   * - <= 0: Play the media file in a loop indefinitely, until {@link stop} is called.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int setLoopCount(int64_t loop_count) = 0;

  /**
   * @brief Play & push the streaming source.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int play() = 0;

  /**
   * @brief Pauses the playing & pushing of the streaming source, Keep current position.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int pause() = 0;

  /**
   * @brief Stop the playing & pushing of the streaming source, set the position to 0.
   * @return
   * - 0: Success.
   * - < 0: Failure.See {@link STREAMINGSRC_ERR}.
   */
  virtual int stop() = 0;

  /**
   * @brief Sets the playback position of the streaming source.
   *        After seek done, it will return to previous status
   * @param newPos The new playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int seek(int64_t new_pos) = 0;

  /**
   * @brief Gets the current playback position of the media file.
   * @param [out] pos A reference to the current playback position (ms).
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int getCurrPosition(int64_t& pos) = 0;

  /**
   * @breif Gets the status of current streaming source.
   * @return The current state machine
   */
  virtual STREAMING_SRC_STATE getCurrState() = 0;

  /**
   * @brief append the SEI data which can be sent attached to video packet
   * @param type  SEI type
   * @param timestamp the video frame timestamp which attached to
   * @param frame_index the video frame timestamp which attached to
   * 
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int appendSeiData(const InputSeiData& inSeiData) = 0;

  /**
   * Registers a media player source observer.
   *
   * Once the media player source observer is registered, you can use the observer to monitor the state change of the media player.
   * @param observer The pointer to the IMediaStreamingSource object.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int registerObserver(IMediaStreamingSourceObserver* observer) = 0;

  /**
   * Releases the media player source observer.
   * @param observer The pointer to the IMediaStreamingSource object.
   * @return
   * - 0: Success.
   * - < 0: Failure. See {@link STREAMINGSRC_ERR}.
   */
  virtual int unregisterObserver(IMediaStreamingSourceObserver* observer) = 0;

  /**
   * @brief Parse a media information with a specified URL.
   * @param url : The path of the media file. Both the local path and online path are supported.
   * @param video_info : The output video information, It means no video track while video_info.streamIndex less than 0
   * @param audio_info : The output audio information, It means no audio track while audio_info.streamIndex less than 0
   * @return
   * - 0: Success.
   * - < 0: Failure
   */
   virtual int parseMediaInfo(const char* url, 
                              media::base::PlayerStreamInfo& video_info,
                              media::base::PlayerStreamInfo& audio_info) = 0;

};



/**
  * @brief  This observer interface of media streaming source
  */
class IMediaStreamingSourceObserver {
  public:
    virtual ~IMediaStreamingSourceObserver() {};


    /**
     * @brief Reports the playback state change.
     *     When the state of the playback changes, 
     *     the SDK triggers this callback to report the new playback state 
     *     and the reason or error for the change.
     * @param state The new playback state after change. See {@link STREAMING_SRC_STATE}.
     * @param ec The player's error code. See {@link STREAMINGSRC_ERR}.
     */
    virtual void onStateChanged(STREAMING_SRC_STATE state, STREAMING_SRC_ERR err_code) = 0;

    /**
     * @brief Triggered when file is opened
     * @param err_code The error code
     * @return None
     */
    virtual void onOpenDone(STREAMING_SRC_ERR err_code) = 0;

    /**
     * @brief Triggered when seeking is done
     * @param err_code The error code
     * @return None
     */
    virtual void onSeekDone(STREAMING_SRC_ERR err_code) = 0;

    /**
     * @brief Triggered when playing is EOF
     * @param progress_ms the progress position
     * @param repeat_count means repeated count of playing
     */
    virtual void onEofOnce(int64_t progress_ms, int64_t repeat_count) = 0;

    /**
     * @brief Reports current playback progress.
     *        The callback triggered once every one second during the playing status 
     * @param position_ms Current playback progress (millisecond).
     */
    virtual void onProgress(int64_t position_ms) = 0;

    /**
     * @brief Occurs when the metadata is received.
     *       The callback occurs when the player receives the media metadata
     *        and reports the detailed information of the media metadata.
     * @param data The detailed data of the media metadata.
     * @param length The data length (bytes).
     */
    virtual void onMetaData(const void* data, int length) = 0;

};



} //namespace rtc
} // namespace agora

