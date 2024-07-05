#ifndef IRIS_RTC_RENDERING_C_H_
#define IRIS_RTC_RENDERING_C_H_

#include "iris_base.h"

typedef IrisHandle IrisRtcRenderingHandle;

/// The agora::media::base::VideoFrame C projection but remove some unsupported property in C,
/// e.g., agora::media::base::VideoFrame.sharedContext, agora::media::base::VideoFrame.textureId, etc.
///
/// NOTE: If the agora::media::base::VideoFrame is updated, make sure this struct be up to date.
/// TODO(littlegnal): maybe we can use terra to generate the C projection.
typedef struct IrisCVideoFrame {

  /// The agora::media::base::VideoFrame.type, but convert it to int type
  int type;
  int width;
  int height;
  int yStride;
  int uStride;
  int vStride;
  uint8_t *yBuffer;
  uint8_t *uBuffer;
  uint8_t *vBuffer;

  int rotation;
  int64_t renderTimeMs;
  int avsync_type;
  uint8_t *metadata_buffer;
  int metadata_size;
  float matrix[16];
  uint8_t *alphaBuffer;
} IrisCVideoFrame;

typedef struct IrisRtcVideoFrameConfig {
  /// int value of agora::rtc::VIDEO_SOURCE_TYPE
  int video_source_type;

  /// int value of agora::media::base::VIDEO_PIXEL_FORMAT. use in convertFrame()
  int video_frame_format;

  unsigned int uid;
  char channelId[kBasicStringLength];

  /// int value of agora::rtc::VIDEO_VIEW_SETUP_MODE.
  int video_view_setup_mode;

  /// int value of agora::media::base::VIDEO_MODULE_POSITION.
  /// Default value is
  /// `agora::media::base::VIDEO_MODULE_POSITION::POSITION_PRE_ENCODER | agora::media::base::VIDEO_MODULE_POSITION::POSITION_PRE_RENDERER`
  uint32_t observed_frame_position;
} IrisRtcVideoFrameConfig;

/// Export an empty `IrisRtcVideoFrameConfig` with initialized value.
IRIS_API const IrisRtcVideoFrameConfig EmptyIrisRtcVideoFrameConfig;

typedef enum GET_VIDEO_FRAME_CACHE_RETURN_TYPE {
  OK = 0,
  RESIZED = 1,
  NO_CACHE = 2,
} GET_VIDEO_FRAME_CACHE_RETURN_TYPE;

IRIS_API IrisRtcRenderingHandle
CreateIrisRtcRendering(IrisApiEnginePtr iris_api_engine_handle);

IRIS_API void FreeIrisRtcRendering(IrisRtcRenderingHandle handle);

/// See `IrisRtcRendering::AddVideoFrameCacheKey`
IRIS_API void AddVideoFrameCacheKey(IrisRtcRenderingHandle handle,
                                    const IrisRtcVideoFrameConfig &config);

IRIS_API void RemoveVideoFrameCacheKey(IrisRtcRenderingHandle handle,
                                       const IrisRtcVideoFrameConfig &config);

/// See `IrisRtcRendering::GetVideoFrameCache`
IRIS_API GET_VIDEO_FRAME_CACHE_RETURN_TYPE GetVideoFrameCache(
    IrisRtcRenderingHandle handle, const IrisRtcVideoFrameConfig &config,
    IrisCVideoFrame *out_frame, bool &is_new_frame);

#endif// IRIS_RTC_RENDERING_C_H_