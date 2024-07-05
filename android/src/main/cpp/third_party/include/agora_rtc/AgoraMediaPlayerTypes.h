//
//  Agora Engine SDK
//
//  Created by Sting Feng in 2020-05.
//  Copyright (c) 2017 Agora.io. All rights reserved.

#pragma once  // NOLINT(build/header_guard)

#include <cstring>
#include <stdint.h>

#include "AgoraOptional.h"

/**
 * set analyze duration for real time stream
 * @example "setPlayerOption(KEY_PLAYER_REAL_TIME_STREAM_ANALYZE_DURATION,1000000)"
 */
#define KEY_PLAYER_REAL_TIME_STREAM_ANALYZE_DURATION    "analyze_duration"

/**
 * make the player to enable audio or not
 * @example  "setPlayerOption(KEY_PLAYER_ENABLE_AUDIO,0)"
 */
#define KEY_PLAYER_ENABLE_AUDIO                  "enable_audio"

/**
 * make the player to enable video or not
 * @example  "setPlayerOption(KEY_PLAYER_ENABLE_VIDEO,0)"
 */
#define KEY_PLAYER_ENABLE_VIDEO                  "enable_video"

/**
 * set the player enable to search metadata
 * @example  "setPlayerOption(KEY_PLAYER_DISABLE_SEARCH_METADATA,0)"
 */
#define KEY_PLAYER_ENABLE_SEARCH_METADATA         "enable_search_metadata"

/**
 * set the player sei filter type
 * @example  "setPlayerOption(KEY_PLAYER_SEI_FILTER_TYPE,"5")"
 */
#define KEY_PLAYER_SEI_FILTER_TYPE         "set_sei_filter_type"

namespace agora {

namespace media {

namespace base {
static const uint8_t kMaxCharBufferLength = 50;
/**
 * @brief The playback state.
 *
 */
enum MEDIA_PLAYER_STATE {
  /** Default state.
   */
  PLAYER_STATE_IDLE = 0,
  /** Opening the media file.
   */
  PLAYER_STATE_OPENING,
  /** The media file is opened successfully.
   */
  PLAYER_STATE_OPEN_COMPLETED,
  /** Playing the media file.
   */
  PLAYER_STATE_PLAYING,
  /** The playback is paused.
   */
  PLAYER_STATE_PAUSED,
  /** The playback is completed.
   */
  PLAYER_STATE_PLAYBACK_COMPLETED,
  /** All loops are completed.
   */
  PLAYER_STATE_PLAYBACK_ALL_LOOPS_COMPLETED,
  /** The playback is stopped.
   */
  PLAYER_STATE_STOPPED,
  /** Player pausing (internal)
   */
  PLAYER_STATE_PAUSING_INTERNAL = 50,
  /** Player stopping (internal)
   */
  PLAYER_STATE_STOPPING_INTERNAL,
  /** Player seeking state (internal)
   */
  PLAYER_STATE_SEEKING_INTERNAL,
  /** Player getting state (internal)
   */
  PLAYER_STATE_GETTING_INTERNAL,
  /** None state for state machine (internal)
   */
  PLAYER_STATE_NONE_INTERNAL,
  /** Do nothing state for state machine (internal)
   */
  PLAYER_STATE_DO_NOTHING_INTERNAL,
  /** Player set track state (internal)
   */
  PLAYER_STATE_SET_TRACK_INTERNAL,
  /** The playback fails.
   */
  PLAYER_STATE_FAILED = 100,
};
/**
 * @brief Player error code
 *
 */
enum MEDIA_PLAYER_REASON {
  /** No error.
   */
  PLAYER_REASON_NONE = 0,
  /** The parameter is invalid.
   */
  PLAYER_REASON_INVALID_ARGUMENTS = -1,
  /** Internel error.
   */
  PLAYER_REASON_INTERNAL = -2,
  /** No resource.
   */
  PLAYER_REASON_NO_RESOURCE = -3,
  /** Invalid media source.
   */
  PLAYER_REASON_INVALID_MEDIA_SOURCE = -4,
  /** The type of the media stream is unknown.
   */
  PLAYER_REASON_UNKNOWN_STREAM_TYPE = -5,
  /** The object is not initialized.
   */
  PLAYER_REASON_OBJ_NOT_INITIALIZED = -6,
  /** The codec is not supported.
   */
  PLAYER_REASON_CODEC_NOT_SUPPORTED = -7,
  /** Invalid renderer.
   */
  PLAYER_REASON_VIDEO_RENDER_FAILED = -8,
  /** An error occurs in the internal state of the player.
   */
  PLAYER_REASON_INVALID_STATE = -9,
  /** The URL of the media file cannot be found.
   */
  PLAYER_REASON_URL_NOT_FOUND = -10,
  /** Invalid connection between the player and the Agora server.
   */
  PLAYER_REASON_INVALID_CONNECTION_STATE = -11,
  /** The playback buffer is insufficient.
   */
  PLAYER_REASON_SRC_BUFFER_UNDERFLOW = -12,
  /** The audio mixing file playback is interrupted.
   */
  PLAYER_REASON_INTERRUPTED = -13,
  /** The SDK does not support this function.
   */
  PLAYER_REASON_NOT_SUPPORTED = -14,
  /** The token has expired.
   */
  PLAYER_REASON_TOKEN_EXPIRED = -15,
  /** The ip has expired.
   */
  PLAYER_REASON_IP_EXPIRED = -16,
  /** An unknown error occurs.
   */
  PLAYER_REASON_UNKNOWN = -17,
};

/**
 * @brief The type of the media stream.
 *
 */
enum MEDIA_STREAM_TYPE {
  /** The type is unknown.
   */
  STREAM_TYPE_UNKNOWN = 0,
  /** The video stream.
   */
  STREAM_TYPE_VIDEO = 1,
  /** The audio stream.
   */
  STREAM_TYPE_AUDIO = 2,
  /** The subtitle stream.
   */
  STREAM_TYPE_SUBTITLE = 3,
};

/**
 * @brief The playback event.
 *
 */
enum MEDIA_PLAYER_EVENT {
  /** The player begins to seek to the new playback position.
   */
  PLAYER_EVENT_SEEK_BEGIN = 0,
  /** The seek operation completes.
   */
  PLAYER_EVENT_SEEK_COMPLETE = 1,
  /** An error occurs during the seek operation.
   */
  PLAYER_EVENT_SEEK_ERROR = 2,
  /** The player changes the audio track for playback.
   */
  PLAYER_EVENT_AUDIO_TRACK_CHANGED = 5,
  /** player buffer low
   */
  PLAYER_EVENT_BUFFER_LOW = 6,
    /** player buffer recover
   */
  PLAYER_EVENT_BUFFER_RECOVER = 7,
  /** The video or audio is interrupted
   */
  PLAYER_EVENT_FREEZE_START = 8,
  /** Interrupt at the end of the video or audio
   */
  PLAYER_EVENT_FREEZE_STOP = 9,
  /** switch source begin
  */
  PLAYER_EVENT_SWITCH_BEGIN = 10,
  /** switch source complete
  */
  PLAYER_EVENT_SWITCH_COMPLETE = 11,
  /** switch source error
  */
  PLAYER_EVENT_SWITCH_ERROR = 12,
  /** An application can render the video to less than a second
   */
  PLAYER_EVENT_FIRST_DISPLAYED = 13,
  /** cache resources exceed the maximum file count
   */
  PLAYER_EVENT_REACH_CACHE_FILE_MAX_COUNT = 14,
  /** cache resources exceed the maximum file size
   */
  PLAYER_EVENT_REACH_CACHE_FILE_MAX_SIZE = 15,
  /** Triggered when a retry is required to open the media
   */
  PLAYER_EVENT_TRY_OPEN_START = 16,
  /** Triggered when the retry to open the media is successful
   */
  PLAYER_EVENT_TRY_OPEN_SUCCEED = 17,
  /** Triggered when retrying to open media fails
   */
  PLAYER_EVENT_TRY_OPEN_FAILED = 18,
};

/**
 * @brief The play preload another source event.
 *
 */
enum PLAYER_PRELOAD_EVENT  {
  /** preload source begin
  */
  PLAYER_PRELOAD_EVENT_BEGIN = 0,
  /** preload source complete
  */
  PLAYER_PRELOAD_EVENT_COMPLETE = 1,
  /** preload source error
  */
  PLAYER_PRELOAD_EVENT_ERROR = 2,
};

/**
 * @brief The information of the media stream object.
 *
 */
struct PlayerStreamInfo {
  /** The index of the media stream. */
  int streamIndex;

  /** The type of the media stream. See {@link MEDIA_STREAM_TYPE}. */
  MEDIA_STREAM_TYPE streamType;

  /** The codec of the media stream. */
  char codecName[kMaxCharBufferLength];

  /** The language of the media stream. */
  char language[kMaxCharBufferLength];

  /** The frame rate (fps) if the stream is video. */
  int videoFrameRate;

  /** The video bitrate (bps) if the stream is video. */
  int videoBitRate;

  /** The video width (pixel) if the stream is video. */
  int videoWidth;

  /** The video height (pixel) if the stream is video. */
  int videoHeight;

  /** The rotation angle if the steam is video. */
  int videoRotation;

  /** The sample rate if the stream is audio. */
  int audioSampleRate;

  /** The number of audio channels if the stream is audio. */
  int audioChannels;

  /** The number of bits per sample if the stream is audio. */
  int audioBitsPerSample;

  /** The total duration (millisecond) of the media stream. */
  int64_t duration;

  PlayerStreamInfo() : streamIndex(0),
                       streamType(STREAM_TYPE_UNKNOWN),
                       videoFrameRate(0),
                       videoBitRate(0),
                       videoWidth(0),
                       videoHeight(0),
                       videoRotation(0),
                       audioSampleRate(0),
                       audioChannels(0),
                       audioBitsPerSample(0),
                       duration(0) {
    memset(codecName, 0, sizeof(codecName));
    memset(language, 0, sizeof(language));
  }
};

/**
 * @brief The information of the media stream object.
 *
 */
struct SrcInfo {
  /** The bitrate of the media stream. The unit of the number is kbps.
   *
   */
  int bitrateInKbps;

  /** The name of the media stream.
   *
  */
  const char* name;

};

/**
 * @brief The type of the media metadata.
 *
 */
enum MEDIA_PLAYER_METADATA_TYPE {
  /** The type is unknown.
   */
  PLAYER_METADATA_TYPE_UNKNOWN = 0,
  /** The type is SEI.
   */
  PLAYER_METADATA_TYPE_SEI = 1,
};

struct CacheStatistics {
  /**  total data size of uri
   */
  int64_t fileSize;
  /**  data of uri has cached
   */
  int64_t cacheSize;
  /**  data of uri has downloaded
   */
  int64_t downloadSize;
};

/**
 * @brief The real time statistics of the media stream being played.
 *
 */
struct PlayerPlaybackStats {
  /**  Video fps.
   */
  int videoFps;
  /**  Video bitrate (Kbps).
   */
  int videoBitrateInKbps;
  /**  Audio bitrate (Kbps).
   */
  int audioBitrateInKbps;
  /**  Total bitrate (Kbps).
   */
  int totalBitrateInKbps;
};

/**
 * @brief The updated information of media player.
 *
 */
struct PlayerUpdatedInfo {
  /** @technical preview
   */
  const char* internalPlayerUuid;
  /** The device ID of the playback device.
   */
  const char* deviceId;
  /**  Video height.
   */
  int videoHeight;
  /**  Video width.
   */
  int videoWidth;
  /**  Audio sample rate.
   */
  int audioSampleRate;
  /**  The audio channel number.
   */
  int audioChannels;
  /**  The bit number of each audio sample.
   */
  int audioBitsPerSample;

  PlayerUpdatedInfo()
      : internalPlayerUuid(NULL),
        deviceId(NULL),
        videoHeight(0),
        videoWidth(0),
        audioSampleRate(0),
        audioChannels(0),
        audioBitsPerSample(0) {}
};

/**
 * The custom data source provides a data stream input callback, and the player will continue to call back this interface, requesting the user to fill in the data that needs to be played.
 */
class IMediaPlayerCustomDataProvider {
public:
    
    /**
     * @brief The player requests to read the data callback, you need to fill the specified length of data into the buffer
     * @param buffer the buffer pointer that you need to fill data.
     * @param bufferSize the bufferSize need to fill of the buffer pointer.
     * @return you need return offset value if succeed. return 0 if failed.
     */
    virtual int onReadData(unsigned char *buffer, int bufferSize) = 0;
    
    /**
     * @brief The Player seek event callback, you need to operate the corresponding stream seek operation, You can refer to the definition of lseek() at https://man7.org/linux/man-pages/man2/lseek.2.html
     * @param offset the value of seek offset.
     * @param whence the postion of start seeking, the directive whence as follows:
     * 0 - SEEK_SET : The file offset is set to offset bytes.
     * 1 - SEEK_CUR : The file offset is set to its current location plus offset bytes.
     * 2 - SEEK_END : The file offset is set to the size of the file plus offset bytes.
     * 65536 - AVSEEK_SIZE : Optional. Passing this as the "whence" parameter to a seek function causes it to return the filesize without seeking anywhere.
     * @return
     * whence == 65536, return filesize if you need.
     * whence >= 0 && whence < 3 , return offset value if succeed. return -1 if failed.
     */
    virtual int64_t onSeek(int64_t offset, int whence) = 0;
    
    virtual ~IMediaPlayerCustomDataProvider() {}
};

struct MediaSource {
  /**
   * The URL of the media file that you want to play.
   */
  const char* url;
  /**
   * The URI of the media file
   *
   * When caching is enabled, if the url cannot distinguish the cache file name,
   * the uri must be able to ensure that the cache file name corresponding to the url is unique.
   */
  const char* uri;
  /**
   * Set the starting position for playback, in ms.
   */
  int64_t startPos;
  /**
   * Determines whether to autoplay after opening a media resource.
   * - true: (Default) Autoplay after opening a media resource.
   * - false: Do not autoplay after opening a media resource.
   */
  bool autoPlay;
  /**
   * Determines whether to enable cache streaming to local files. If enable cached, the media player will
   * use the url or uri as the cache index.
   *
   * @note
   * The local cache function only supports on-demand video/audio streams and does not support live streams.
   * Caching video and audio files based on the HLS protocol (m3u8) to your local device is not supported.
   *
   * - true: Enable cache.
   * - false: (Default) Disable cache.
   */
  bool enableCache;
  /**
   * Determines whether to enable multi-track audio stream decoding.
   * Then you can select multi audio track of the media file for playback or publish to channel
   *
   * @note
   * If you use the selectMultiAudioTrack API, you must set enableMultiAudioTrack to true.
   *
   * - true: Enable MultiAudioTrack;.
   * - false: (Default) Disable MultiAudioTrack;.
   */
  bool enableMultiAudioTrack;
  /**
   * Determines whether the opened media resource is a stream through the Agora Broadcast Streaming Network(CDN).
   * - true: It is a stream through the Agora Broadcast Streaming Network.
   * - false: (Default) It is not a stream through the Agora Broadcast Streaming Network.
   */
  Optional<bool> isAgoraSource;
  /**
   * Determines whether the opened media resource is a live stream. If is a live stream, it can speed up the opening of media resources.
   * - true: It is a live stream.
   * - false: (Default) It is not is a live stream.
   */
  Optional<bool> isLiveSource;
  /**
   * External custom data source object
   */
  IMediaPlayerCustomDataProvider* provider;

  MediaSource() : url(NULL), uri(NULL), startPos(0), autoPlay(true), enableCache(false),
                  enableMultiAudioTrack(false), provider(NULL){
  }
};

}  // namespace base
}  // namespace media
}  // namespace agora
