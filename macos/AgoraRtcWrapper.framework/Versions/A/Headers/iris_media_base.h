//
// Created by LXH on 2021/7/20.
//

#ifndef IRIS_MEDIA_BASE_H_
#define IRIS_MEDIA_BASE_H_

#include "iris_base.h"
#include <cstdint>

#ifdef __cplusplus
extern "C" {
#endif

enum AudioFrameType {
  kAudioFrameTypePCM16,
};

typedef struct IrisAudioFrame {
  AudioFrameType type;
  int samples;
  int bytes_per_sample;
  int channels;
  int samples_per_sec;
  void *buffer;
  unsigned int buffer_length;
  int64_t render_time_ms;
  int av_sync_type;
} IrisAudioFrame;

IRIS_API const struct IrisAudioFrame IrisAudioFrame_default;

IRIS_API void ResizeAudioFrame(IrisAudioFrame *audio_frame);

IRIS_API void ClearAudioFrame(IrisAudioFrame *audio_frame);

IRIS_API void CopyAudioFrame(IrisAudioFrame *dst, const IrisAudioFrame *src);

enum IrisVideoFrameType {
  kVideoFrameTypeYUV420,
  kVideoFrameTypeYUV422,
  kVideoFrameTypeRGBA,
  kVideoFrameTypeBGRA,
};

enum IrisVideoSourceType {
  kVideoSourceTypeCameraPrimary,
  kVideoSourceTypeCameraSecondary,
  kVideoSourceTypeScreenPrimary,
  kVideoSourceTypeScreenSecondary,
  kVideoSourceTypeCustom,
  kVideoSourceTypeMediaPlayer,
  kVideoSourceTypeRtcImagePng,
  kVideoSourceTypeRtcImageJpeg,
  kVideoSourceTypeRtcImageGif,
  kVideoSourceTypeRemote,
  kVideoSourceTypeTranscoded,
  kVideoSourceTypeUnknown,
};

typedef struct IrisVideoFrame {
  IrisVideoFrameType type;
  int width;
  int height;
  int y_stride;
  int u_stride;
  int v_stride;
  void *y_buffer;
  void *u_buffer;
  void *v_buffer;
  unsigned int y_buffer_length;
  unsigned int u_buffer_length;
  unsigned int v_buffer_length;
  int rotation;
  int64_t render_time_ms;
  int av_sync_type;
} IrisVideoFrame;

IRIS_API const struct IrisVideoFrame IrisVideoFrame_default;

IRIS_API void ResizeVideoFrame(IrisVideoFrame *video_frame);

IRIS_API void ClearVideoFrame(IrisVideoFrame *video_frame);

IRIS_API void CopyVideoFrame(IrisVideoFrame *dst, const IrisVideoFrame *src);

IRIS_API IrisVideoFrame ConvertVideoFrame(const IrisVideoFrame *src,
                                          IrisVideoFrameType format);

typedef struct IrisPacket {
  const unsigned char *buffer;
  unsigned int size;
} IrisPacket;

#ifdef __cplusplus
}
#endif

namespace agora {
namespace iris {

class IrisVideoFrameBufferManager;

class IrisAudioFrameObserver {
 public:
  virtual bool OnRecordAudioFrame(IrisAudioFrame &audio_frame) = 0;
};

class IrisVideoFrameObserver {
 public:
  virtual bool OnCaptureVideoFrame(IrisVideoFrame &video_frame) = 0;
};

class IrisPacketObserver {
 public:
  virtual bool OnSendAudioPacket(IrisPacket &packet) = 0;
  virtual bool OnSendVideoPacket(IrisPacket &packet) = 0;
  virtual bool OnReceiveAudioPacket(IrisPacket &packet) = 0;
  virtual bool OnReceiveVideoPacket(IrisPacket &packet) = 0;
};

class IRIS_CPP_API IrisAudioFrameObserverManager {
 public:
  IrisAudioFrameObserverManager();
  ~IrisAudioFrameObserverManager();

 public:
  void RegisterAudioFrameObserver(IrisAudioFrameObserver *observer, int order,
                                  const char *identifier);

  void UnRegisterAudioFrameObserver(const char *identifier = nullptr);

  unsigned int GetAudioFrameObserverCount();

  IrisAudioFrameObserver *GetAudioFrameObserver(unsigned int index);

 private:
  class Impl;
  Impl *impl_;
};

class IRIS_CPP_API IrisVideoFrameObserverManager {
 public:
  IrisVideoFrameObserverManager();
  ~IrisVideoFrameObserverManager();

 public:
  void RegisterVideoFrameObserver(IrisVideoFrameObserver *observer, int order,
                                  const char *identifier);

  void UnRegisterVideoFrameObserver(const char *identifier = nullptr);

  unsigned int GetVideoFrameObserverCount();

  IrisVideoFrameObserver *GetVideoFrameObserver(unsigned int index);

  void Attach(IrisVideoFrameBufferManager *manager);

  IrisVideoFrameBufferManager *buffer_manager();

 private:
  class Impl;
  Impl *impl_;
};

class IRIS_CPP_API IrisPacketObserverManager {
 public:
  IrisPacketObserverManager();
  ~IrisPacketObserverManager();

 public:
  void RegisterPacketObserver(IrisPacketObserver *observer, int order,
                              const char *identifier);

  void UnRegisterPacketObserver(const char *identifier = nullptr);

  unsigned int GetPacketObserverCount();

  IrisPacketObserver *GetPacketObserver(unsigned int index);

 private:
  class Impl;
  Impl *impl_;
};

class IRIS_CPP_API IrisCommonObserverManager
    : public IrisAudioFrameObserverManager,
      public IrisVideoFrameObserverManager,
      public IrisPacketObserverManager {
 public:
  IrisCommonObserverManager();
  virtual ~IrisCommonObserverManager();
};

}// namespace iris
}// namespace agora

#endif//IRIS_MEDIA_BASE_H_
