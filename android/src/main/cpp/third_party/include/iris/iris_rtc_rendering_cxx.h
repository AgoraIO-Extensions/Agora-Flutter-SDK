#ifndef IRIS_RTC_RENDERING_CXX_H_
#define IRIS_RTC_RENDERING_CXX_H_

#include "iris_base.h"
#include "iris_rtc_rendering_c.h"

//////// operators for IrisRtcVideoFrameConfig ///////////
IRIS_CPP_API bool operator<(const IrisRtcVideoFrameConfig &lhs,
                            const IrisRtcVideoFrameConfig &rhs);

namespace agora {
namespace iris {

const int INVALID_DELEGATE_ID = -1;

/// Delegate class for forward all the callbacks from `agora::media::IVideoFrameObserver` to
/// a single callback `OnVideoFrameReceived`
class IRIS_CPP_API VideoFrameObserverDelegate {
 public:
  virtual ~VideoFrameObserverDelegate() {}

  /// videoFrame: the agora::media::base::VideoFrame
  ///
  /// We let `videoFrame` type to void * here is to allow the c++ users to
  /// full access the `agora::media::base::VideoFrame`
  virtual void OnVideoFrameReceived(const void *videoFrame,
                                    const IrisRtcVideoFrameConfig &config,
                                    bool resize) = 0;
};

/// Class to interact with the raw data from native sdk (via `agora::media::IMediaEngine::addVideoFrameRenderer`)
class IRIS_CPP_API IrisRtcRendering {
 public:
  virtual ~IrisRtcRendering() {}

  static IrisRtcRendering *Create(IrisApiEnginePtr iris_api_engine_handle);

  /// Add `VideoFrameObserverDelegate` with `config`, return a delegate id that save inside
  /// `IrisRtcRendering`, you should save the id and pass it to `RemoveVideoFrameObserverDelegate`.
  ///
  /// Only return `INVALID_DELEGATE_ID` if `agora::rtc::VIDEO_VIEW_SETUP_MODE::VIDEO_VIEW_SETUP_REMOVE` set,
  /// since should not support this mode.
  virtual int
  AddVideoFrameObserverDelegate(const IrisRtcVideoFrameConfig &config,
                                VideoFrameObserverDelegate *delegate) = 0;

  /// Remove the `VideoFrameObserverDelegate` by the delegate id which return from the `AddVideoFrameObserverDelegate`
  virtual void RemoveVideoFrameObserverDelegate(const int &delegate_id) = 0;

  /// Add cache config to cache the `IrisCVideoFrame`, get the `IrisCVideoFrame` using
  /// `GetVideoFrameCache`
  virtual void AddVideoFrameCacheKey(const IrisRtcVideoFrameConfig &config) = 0;

  virtual void
  RemoveVideoFrameCacheKey(const IrisRtcVideoFrameConfig &config) = 0;

  /// Get cached `IrisCVideoFrame`, return `nullptr` if there's no cache key of `config`
  virtual GET_VIDEO_FRAME_CACHE_RETURN_TYPE
  GetVideoFrameCache(const IrisRtcVideoFrameConfig &config,
                     IrisCVideoFrame *out_frame, bool &is_new_frame) = 0;

  virtual void Initialize() = 0;
};

}// namespace iris
}// namespace agora

#endif// IRIS_RTC_RENDERING_CXX_H_