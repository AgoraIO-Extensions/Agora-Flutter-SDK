//
// Created by LXH on 2021/3/4.
//

#ifndef IRIS_VIDEO_PROCESSOR_H_
#define IRIS_VIDEO_PROCESSOR_H_

#include "iris_event_handler.h"
#include "iris_media_base.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct IrisVideoFrameBufferConfig {
  IrisVideoSourceType type;
  unsigned int id;
  char key[kBasicResultLength];
} IrisVideoFrameBufferConfig;

#ifdef __cplusplus
}
#endif

namespace agora {
namespace iris {

class IrisVideoFrameBufferDelegate {
 public:
  virtual void OnVideoFrameReceived(const IrisVideoFrame &video_frame,
                                    const IrisVideoFrameBufferConfig *config,
                                    bool resize) = 0;
};

class IRIS_CPP_API IrisVideoFrameBuffer : public IrisVideoFrame {
 public:
  explicit IrisVideoFrameBuffer(
      IrisVideoFrameType type, IrisVideoFrameBufferDelegate *delegate = nullptr,
      int resize_width = 0, int resize_height = 0);

 public:
  IrisVideoFrameBufferDelegate *delegate;
  int resize_width;
  int resize_height;
};

class IRIS_CPP_API IrisVideoFrameBufferManager {
 public:
  IrisVideoFrameBufferManager();
  virtual ~IrisVideoFrameBufferManager();

  void SetEventHandler(IrisEventHandler *event_handler);

  /**
   * Enable buffer the video frame from user.
   * @param buffer The video frame buffer.
   * @param uid The user ID you want to cache.
   * @param channel_id The channel ID.
   */
  void EnableVideoFrameBuffer(const IrisVideoFrameBuffer &buffer,
                              unsigned int uid,
                              const char *channel_id = "") IRIS_DEPRECATED;

  void DisableVideoFrameBuffer(const IrisVideoFrameBufferDelegate *delegate);

  void DisableVideoFrameBuffer(const unsigned int *uid = nullptr,
                               const char *channel_id = "") IRIS_DEPRECATED;

  bool GetVideoFrame(IrisVideoFrame &video_frame, bool &is_new_frame,
                     unsigned int uid,
                     const char *channel_id = "") IRIS_DEPRECATED;

 public:
  /**
   * Enable buffer the video frame from user.
   * @param buffer The video frame buffer.
   * @param uid The user ID you want to cache.
   * @param channel_id The channel ID.
   */
  void EnableVideoFrameBuffer(const IrisVideoFrameBuffer &buffer,
                              const IrisVideoFrameBufferConfig *config);

  void
  DisableVideoFrameBuffer(const IrisVideoFrameBufferConfig *config = nullptr);

  bool GetVideoFrame(IrisVideoFrame &video_frame, bool &is_new_frame,
                     const IrisVideoFrameBufferConfig *config);

 public:
  bool SetVideoFrameInternal(const IrisVideoFrame &video_frame,
                             const IrisVideoFrameBufferConfig *config);

  bool GetVideoFrameInternal(IrisVideoFrame &video_frame,
                             const IrisVideoFrameBufferConfig *config);

 private:
  class Impl;
  Impl *impl_;
};

}// namespace iris
}// namespace agora

#ifdef __cplusplus
extern "C" {
#endif

typedef void(IRIS_CALL *Func_VideoFrame)(
    const IrisVideoFrame *video_frame, const IrisVideoFrameBufferConfig *config,
    bool resize);
typedef struct IrisCVideoFrameBuffer {
  IrisVideoFrameType type;
  Func_VideoFrame OnVideoFrameReceived;
  int resize_width;
  int resize_height;
} IrisCVideoFrameBuffer;
typedef void *IrisVideoFrameBufferDelegateHandle;

typedef void *IrisVideoFrameBufferManagerPtr;

IRIS_API IrisVideoFrameBufferManagerPtr CreateIrisVideoFrameBufferManager();

IRIS_API void
FreeIrisVideoFrameBufferManager(IrisVideoFrameBufferManagerPtr manager_ptr);

IRIS_API IrisEventHandlerHandle SetIrisVideoFrameBufferManagerEventHandler(
    IrisVideoFrameBufferManagerPtr manager_ptr,
    IrisCEventHandler *event_handler);

IRIS_API void UnsetIrisVideoFrameBufferManagerEventHandler(
    IrisVideoFrameBufferManagerPtr manager_ptr, IrisEventHandlerHandle handle);

IRIS_API IrisVideoFrameBufferDelegateHandle EnableVideoFrameBuffer(
    IrisVideoFrameBufferManagerPtr manager_ptr, IrisCVideoFrameBuffer *buffer,
    unsigned int uid, const char *channel_id = "") IRIS_DEPRECATED;

IRIS_API IrisVideoFrameBufferDelegateHandle EnableVideoFrameBufferByConfig(
    IrisVideoFrameBufferManagerPtr manager_ptr, IrisCVideoFrameBuffer *buffer,
    const IrisVideoFrameBufferConfig *config);

IRIS_API void DisableVideoFrameBufferByDelegate(
    IrisVideoFrameBufferManagerPtr manager_ptr,
    IrisVideoFrameBufferDelegateHandle handle = nullptr);

IRIS_API void
DisableVideoFrameBufferByUid(IrisVideoFrameBufferManagerPtr manager_ptr,
                             unsigned int uid,
                             const char *channel_id = "") IRIS_DEPRECATED;

IRIS_API void
DisableVideoFrameBufferByConfig(IrisVideoFrameBufferManagerPtr manager_ptr,
                                const IrisVideoFrameBufferConfig *config);

IRIS_API void
DisableAllVideoFrameBuffer(IrisVideoFrameBufferManagerPtr manager_ptr);

IRIS_API bool GetVideoFrame(IrisVideoFrameBufferManagerPtr manager_ptr,
                            IrisVideoFrame *video_frame, bool *is_new_frame,
                            unsigned int uid,
                            const char *channel_id = "") IRIS_DEPRECATED;

IRIS_API bool GetVideoFrameByConfig(IrisVideoFrameBufferManagerPtr manager_ptr,
                                    IrisVideoFrame *video_frame,
                                    bool *is_new_frame,
                                    const IrisVideoFrameBufferConfig *config);

#ifdef __cplusplus
}
#endif

#endif//IRIS_VIDEO_PROCESSOR_H_
