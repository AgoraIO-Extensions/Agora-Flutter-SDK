//
// Created by LXH on 2021/3/4.
//

#ifndef IRIS_RTC_RENDERER_H_
#define IRIS_RTC_RENDERER_H_

#include "iris_rtc_base.h"
#include "iris_rtc_raw_data.h"

namespace agora {
namespace iris {
namespace rtc {
class IrisRtcRendererDelegate {
 public:
  virtual void OnVideoFrameReceived(const IrisRtcVideoFrame &video_frame,
                                    unsigned int uid, const char *channel_id,
                                    bool resize) = 0;
};

class IRIS_CPP_API IrisRtcRendererCacheConfig : public IrisRtcVideoFrame {
 public:
  explicit IrisRtcRendererCacheConfig(
      VideoFrameType type, IrisRtcRendererDelegate *delegate = nullptr,
      int resize_width = 0, int resize_height = 0);

 public:
  IrisRtcRendererDelegate *delegate;
  int resize_width;
  int resize_height;
};

class IRIS_CPP_API IrisRtcRenderer {
 public:
  IrisRtcRenderer();
  virtual ~IrisRtcRenderer();

  void SetEventHandler(IrisEventHandler *event_handler);

  /**
   * Enable cache the video frame from user.
   * @param cache_config The cache config.
   * @param uid The user ID you want to cache.
   * @param channel_id The channel ID.
   */
  void EnableVideoFrameCache(const IrisRtcRendererCacheConfig &cache_config,
                             unsigned int uid, const char *channel_id = "");

  void DisableVideoFrameCache(const IrisRtcRendererDelegate *delegate);

  void DisableVideoFrameCache(unsigned int uid = -1,
                              const char *channel_id = "");

  bool GetVideoFrame(IrisRtcVideoFrame &video_frame, bool &is_new_frame,
                     unsigned int uid, const char *channel_id = "");

 public:
  void SetVideoFrameInternal(const IrisRtcVideoFrame &video_frame,
                             unsigned int uid, const char *channel_id = "");

  bool GetVideoFrameInternal(IrisRtcVideoFrame &video_frame, unsigned int uid,
                             const char *channel_id = "");

 private:
  class IrisRtcRendererImpl;
  IrisRtcRendererImpl *renderer_;
};
}// namespace rtc
}// namespace iris
}// namespace agora

#endif//IRIS_RTC_RENDERER_H_
