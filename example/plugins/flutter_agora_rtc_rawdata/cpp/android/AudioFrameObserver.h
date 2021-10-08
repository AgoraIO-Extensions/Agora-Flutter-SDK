#pragma once

#include "include/IAgoraMediaEngine.h"
#include "include/IAgoraRtcEngine.h"

#include <jni.h>

namespace agora {
class AudioFrameObserver : public media::IAudioFrameObserver {
public:
  AudioFrameObserver(JNIEnv *env, jobject jCaller, long long engineHandle);
  virtual ~AudioFrameObserver();

public:
  bool onRecordAudioFrame(AudioFrame &audioFrame) override;
  bool onPlaybackAudioFrame(AudioFrame &audioFrame) override;
  bool onMixedAudioFrame(AudioFrame &audioFrame) override;
  bool onPlaybackAudioFrameBeforeMixing(unsigned int uid,
                                        AudioFrame &audioFrame) override;
  bool isMultipleChannelFrameWanted() override;
  bool onPlaybackAudioFrameBeforeMixingEx(const char *channelId,
                                          unsigned int uid,
                                          AudioFrame &audioFrame) override;

private:
  jbyteArray NativeToJavaByteArray(JNIEnv *env, AudioFrame &audioFrame);
  jobject NativeToJavaAudioFrame(JNIEnv *env, AudioFrame &audioFrame,
                                 jbyteArray jByteArray);

private:
  JavaVM *jvm = nullptr;

  jobject jCallerRef;
  jmethodID jOnRecordAudioFrame;
  jmethodID jOnPlaybackAudioFrame;
  jmethodID jOnMixedAudioFrame;
  jmethodID jOnPlaybackAudioFrameBeforeMixing;
  jmethodID jIsMultipleChannelFrameWanted;
  jmethodID jOnPlaybackAudioFrameBeforeMixingEx;

  jclass jAudioFrameClass;
  jmethodID jAudioFrameInit;

  long long engineHandle;
};
} // namespace agora
