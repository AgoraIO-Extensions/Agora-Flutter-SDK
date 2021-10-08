#pragma once

#include "include/IAgoraMediaEngine.h"
#include "include/IAgoraRtcEngine.h"

#include <jni.h>
#include <vector>

namespace agora {
class VideoFrameObserver : public media::IVideoFrameObserver {
public:
  VideoFrameObserver(JNIEnv *env, jobject jCaller, long long EngineHandle);
  virtual ~VideoFrameObserver();

public:
  bool onCaptureVideoFrame(VideoFrame &videoFrame) override;
  bool onRenderVideoFrame(unsigned int uid, VideoFrame &videoFrame) override;
  bool onPreEncodeVideoFrame(VideoFrame &videoFrame) override;
  VIDEO_FRAME_TYPE getVideoFormatPreference() override;
  bool getRotationApplied() override;
  bool getMirrorApplied() override;
  bool getSmoothRenderingEnabled() override;
  uint32_t getObservedFramePosition() override;
  bool isMultipleChannelFrameWanted() override;
  bool onRenderVideoFrameEx(const char *channelId, unsigned int uid,
                            VideoFrame &videoFrame) override;

private:
  std::vector<jbyteArray> NativeToJavaByteArray(JNIEnv *env,
                                                VideoFrame &videoFrame);
  jobject NativeToJavaVideoFrame(JNIEnv *env, VideoFrame &videoFrame,
                                 std::vector<jbyteArray> jByteArray);

private:
  JavaVM *jvm = nullptr;

  jobject jCallerRef;
  jmethodID jOnCaptureVideoFrame;
  jmethodID jOnRenderVideoFrame;
  jmethodID jOnPreEncodeVideoFrame;
  jmethodID jGetVideoFormatPreference;
  jmethodID jGetRotationApplied;
  jmethodID jGetMirrorApplied;
  jmethodID jGetSmoothRenderingEnabled;
  jmethodID jGetObservedFramePosition;
  jmethodID jIsMultipleChannelFrameWanted;
  jmethodID jOnRenderVideoFrameEx;

  jclass jVideoFrameClass;
  jmethodID jVideoFrameInit;

  jclass jVideoFrameTypeClass;
  jmethodID jOrdinal;

  long long engineHandle;
};
} // namespace agora
