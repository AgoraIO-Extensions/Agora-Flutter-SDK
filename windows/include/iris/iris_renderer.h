//
// Created by LXH on 2021/3/4.
//

#ifndef IRIS_INCLUDE_IRIS_IRIS_RENDERER_H_
#define IRIS_INCLUDE_IRIS_IRIS_RENDERER_H_

#include "iris_base.h"
#include "iris_raw_data.h"

namespace agora {
namespace iris {
class IrisRendererDelegate {
 public:
  virtual void
  OnVideoFrameReceived(const IrisVideoFrameObserver::VideoFrame &video_frame,
                       bool resize) = 0;
};

class IRIS_CPP_API IrisRendererCacheConfig
    : public IrisVideoFrameObserver::VideoFrame {
 public:
  explicit IrisRendererCacheConfig(IrisVideoFrameObserver::VideoFrameType type,
                                   IrisRendererDelegate *delegate = nullptr,
                                   int resize_width = 0, int resize_height = 0);

 public:
  IrisRendererDelegate *delegate;
  int resize_width;
  int resize_height;
};

class IRIS_CPP_API IrisRenderer {
 public:
  IrisRenderer();

  virtual ~IrisRenderer();

  /**
   * Enable cache the video frame from user.
   * @param cache_config The cache config.
   * @param uid The user ID you want to cache.
   * @param channel_id The channel ID.
   */
  void EnableVideoFrameCache(const IrisRendererCacheConfig &cache_config,
                             unsigned int uid, const char *channel_id = "");

  void DisableVideoFrameCache(const IrisRendererDelegate *delegate);

  void DisableVideoFrameCache(unsigned int uid = -1,
                              const char *channel_id = "");

  bool GetVideoFrame(IrisVideoFrameObserver::VideoFrame &video_frame,
                     bool &is_new_frame, unsigned int uid,
                     const char *channel_id = "");

 public:
  void
  SetVideoFrameInternal(const IrisVideoFrameObserver::VideoFrame &video_frame,
                        unsigned int uid, const char *channel_id = "");

  bool GetVideoFrameInternal(IrisVideoFrameObserver::VideoFrame &video_frame,
                             unsigned int uid, const char *channel_id = "");

 private:
  class IrisRendererImpl;
  IrisRendererImpl *iris_renderer_;
};
}// namespace iris
}// namespace agora

#endif//IRIS_INCLUDE_IRIS_IRIS_RENDERER_H_
