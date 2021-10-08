#include "AudioFrameObserver.h"

#include "VMUtil.h"

namespace agora {
AudioFrameObserver::AudioFrameObserver(JNIEnv *env, jobject jCaller,
                                       long long engineHandle)
    : jCallerRef(env->NewGlobalRef(jCaller)), engineHandle(engineHandle) {
  jclass jCallerClass = env->GetObjectClass(jCallerRef);
  jOnRecordAudioFrame =
      env->GetMethodID(jCallerClass, "onRecordAudioFrame",
                       "(Lio/agora/rtc/rawdata/base/AudioFrame;)Z");
  jOnPlaybackAudioFrame =
      env->GetMethodID(jCallerClass, "onPlaybackAudioFrame",
                       "(Lio/agora/rtc/rawdata/base/AudioFrame;)Z");
  jOnMixedAudioFrame =
      env->GetMethodID(jCallerClass, "onMixedAudioFrame",
                       "(Lio/agora/rtc/rawdata/base/AudioFrame;)Z");
  jOnPlaybackAudioFrameBeforeMixing =
      env->GetMethodID(jCallerClass, "onPlaybackAudioFrameBeforeMixing",
                       "(ILio/agora/rtc/rawdata/base/AudioFrame;)Z");
  jIsMultipleChannelFrameWanted =
      env->GetMethodID(jCallerClass, "isMultipleChannelFrameWanted", "()Z");
  jOnPlaybackAudioFrameBeforeMixingEx = env->GetMethodID(
      jCallerClass, "onPlaybackAudioFrameBeforeMixingEx",
      "(Ljava/lang/String;ILio/agora/rtc/rawdata/base/AudioFrame;)Z");
  env->DeleteLocalRef(jCallerClass);

  jclass jAudioFrame = env->FindClass("io/agora/rtc/rawdata/base/AudioFrame");
  jAudioFrameClass = (jclass)env->NewGlobalRef(jAudioFrame);
  jAudioFrameInit =
      env->GetMethodID(jAudioFrameClass, "<init>", "(IIIII[BJI)V");
  env->DeleteLocalRef(jAudioFrame);

  env->GetJavaVM(&jvm);

  auto rtcEngine = reinterpret_cast<rtc::IRtcEngine *>(engineHandle);
  if (rtcEngine) {
    util::AutoPtr<media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtcEngine, AGORA_IID_MEDIA_ENGINE);
    if (mediaEngine) {
      mediaEngine->registerAudioFrameObserver(this);
    }
  }
}

AudioFrameObserver::~AudioFrameObserver() {
  auto rtcEngine = reinterpret_cast<rtc::IRtcEngine *>(engineHandle);
  if (rtcEngine) {
    util::AutoPtr<media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtcEngine, AGORA_IID_MEDIA_ENGINE);
    if (mediaEngine) {
      mediaEngine->registerAudioFrameObserver(this);
    }
  }

  AttachThreadScoped ats(jvm);

  ats.env()->DeleteGlobalRef(jCallerRef);
  jOnRecordAudioFrame = nullptr;
  jOnPlaybackAudioFrame = nullptr;
  jOnMixedAudioFrame = nullptr;
  jOnPlaybackAudioFrameBeforeMixing = nullptr;
  jIsMultipleChannelFrameWanted = nullptr;
  jOnPlaybackAudioFrameBeforeMixingEx = nullptr;

  ats.env()->DeleteGlobalRef(jAudioFrameClass);
  jAudioFrameInit = nullptr;
}

bool AudioFrameObserver::onRecordAudioFrame(AudioFrame &audioFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jbyteArray arr = NativeToJavaByteArray(env, audioFrame);
  jobject obj = NativeToJavaAudioFrame(env, audioFrame, arr);
  jboolean ret = env->CallBooleanMethod(jCallerRef, jOnRecordAudioFrame, obj);
  env->GetByteArrayRegion(arr, 0, env->GetArrayLength(arr),
                          static_cast<jbyte *>(audioFrame.buffer));
  env->DeleteLocalRef(arr);
  env->DeleteLocalRef(obj);
  return ret;
}

bool AudioFrameObserver::onPlaybackAudioFrame(AudioFrame &audioFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jbyteArray arr = NativeToJavaByteArray(env, audioFrame);
  jobject obj = NativeToJavaAudioFrame(env, audioFrame, arr);
  jboolean ret = env->CallBooleanMethod(jCallerRef, jOnPlaybackAudioFrame, obj);
  env->GetByteArrayRegion(arr, 0, env->GetArrayLength(arr),
                          static_cast<jbyte *>(audioFrame.buffer));
  env->DeleteLocalRef(arr);
  env->DeleteLocalRef(obj);
  return ret;
}

bool AudioFrameObserver::onMixedAudioFrame(AudioFrame &audioFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jbyteArray arr = NativeToJavaByteArray(env, audioFrame);
  jobject obj = NativeToJavaAudioFrame(env, audioFrame, arr);
  jboolean ret = env->CallBooleanMethod(jCallerRef, jOnMixedAudioFrame, obj);
  env->GetByteArrayRegion(arr, 0, env->GetArrayLength(arr),
                          static_cast<jbyte *>(audioFrame.buffer));
  env->DeleteLocalRef(arr);
  env->DeleteLocalRef(obj);
  return ret;
}

bool AudioFrameObserver::onPlaybackAudioFrameBeforeMixing(
    unsigned int uid, AudioFrame &audioFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jbyteArray arr = NativeToJavaByteArray(env, audioFrame);
  jobject obj = NativeToJavaAudioFrame(env, audioFrame, arr);
  jboolean ret = env->CallBooleanMethod(
      jCallerRef, jOnPlaybackAudioFrameBeforeMixing, uid, obj);
  env->GetByteArrayRegion(arr, 0, env->GetArrayLength(arr),
                          static_cast<jbyte *>(audioFrame.buffer));
  env->DeleteLocalRef(arr);
  env->DeleteLocalRef(obj);
  return ret;
}

bool AudioFrameObserver::isMultipleChannelFrameWanted() {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jboolean ret =
      env->CallBooleanMethod(jCallerRef, jIsMultipleChannelFrameWanted);
  return ret;
}

bool AudioFrameObserver::onPlaybackAudioFrameBeforeMixingEx(
    const char *channelId, unsigned int uid, AudioFrame &audioFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jbyteArray arr = NativeToJavaByteArray(env, audioFrame);
  jobject obj = NativeToJavaAudioFrame(env, audioFrame, arr);
  jstring str = env->NewStringUTF(channelId);
  jboolean ret = env->CallBooleanMethod(
      jCallerRef, jOnPlaybackAudioFrameBeforeMixingEx, str, uid, obj);
  env->GetByteArrayRegion(arr, 0, env->GetArrayLength(arr),
                          static_cast<jbyte *>(audioFrame.buffer));
  env->DeleteLocalRef(arr);
  env->DeleteLocalRef(obj);
  env->DeleteLocalRef(str);
  return ret;
}

jbyteArray AudioFrameObserver::NativeToJavaByteArray(JNIEnv *env,
                                                     AudioFrame &audioFrame) {
  int length =
      audioFrame.samples * audioFrame.channels * audioFrame.bytesPerSample;

  jbyteArray jByteArray = env->NewByteArray(length);

  if (audioFrame.buffer) {
    env->SetByteArrayRegion(jByteArray, 0, length,
                            static_cast<const jbyte *>(audioFrame.buffer));
  }
  return jByteArray;
}

jobject AudioFrameObserver::NativeToJavaAudioFrame(JNIEnv *env,
                                                   AudioFrame &audioFrame,
                                                   jbyteArray jByteArray) {
  return env->NewObject(jAudioFrameClass, jAudioFrameInit, (int)audioFrame.type,
                        audioFrame.samples, audioFrame.bytesPerSample,
                        audioFrame.channels, audioFrame.samplesPerSec,
                        jByteArray, audioFrame.renderTimeMs,
                        audioFrame.avsync_type);
}
} // namespace agora
