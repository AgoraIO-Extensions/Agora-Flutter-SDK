#include "VideoFrameObserver.h"

#include "VMUtil.h"

namespace agora {
VideoFrameObserver::VideoFrameObserver(JNIEnv *env, jobject jCaller,
                                       long long engineHandle)
    : jCallerRef(env->NewGlobalRef(jCaller)), engineHandle(engineHandle) {
  jclass jCallerClass = env->GetObjectClass(jCallerRef);
  jOnCaptureVideoFrame =
      env->GetMethodID(jCallerClass, "onCaptureVideoFrame",
                       "(Lio/agora/rtc/rawdata/base/VideoFrame;)Z");
  jOnRenderVideoFrame =
      env->GetMethodID(jCallerClass, "onRenderVideoFrame",
                       "(ILio/agora/rtc/rawdata/base/VideoFrame;)Z");
  jOnPreEncodeVideoFrame =
      env->GetMethodID(jCallerClass, "onPreEncodeVideoFrame",
                       "(Lio/agora/rtc/rawdata/base/VideoFrame;)Z");
  jGetVideoFormatPreference = env->GetMethodID(
      jCallerClass, "getVideoFormatPreference",
      "()Lio/agora/rtc/rawdata/base/VideoFrame$VideoFrameType;");
  jGetRotationApplied =
      env->GetMethodID(jCallerClass, "getRotationApplied", "()Z");
  jGetMirrorApplied = env->GetMethodID(jCallerClass, "getMirrorApplied", "()Z");
  jGetSmoothRenderingEnabled =
      env->GetMethodID(jCallerClass, "getSmoothRenderingEnabled", "()Z");
  jGetObservedFramePosition =
      env->GetMethodID(jCallerClass, "getObservedFramePosition", "()I");
  jIsMultipleChannelFrameWanted =
      env->GetMethodID(jCallerClass, "isMultipleChannelFrameWanted", "()Z");
  jOnRenderVideoFrameEx = env->GetMethodID(
      jCallerClass, "onRenderVideoFrameEx",
      "(Ljava/lang/String;ILio/agora/rtc/rawdata/base/VideoFrame;)Z");
  env->DeleteLocalRef(jCallerClass);

  jclass jVideoFrame = env->FindClass("io/agora/rtc/rawdata/base/VideoFrame");
  jVideoFrameClass = (jclass)env->NewGlobalRef(jVideoFrame);
  jVideoFrameInit =
      env->GetMethodID(jVideoFrameClass, "<init>", "(IIIIII[B[B[BIJI)V");
  env->DeleteLocalRef(jVideoFrame);

  jclass videoFrameType =
      env->FindClass("io/agora/rtc/rawdata/base/VideoFrame$VideoFrameType");
  jVideoFrameTypeClass = (jclass)env->NewGlobalRef(videoFrameType);
  jOrdinal = env->GetMethodID(jVideoFrameTypeClass, "ordinal", "()I");
  env->DeleteLocalRef(videoFrameType);

  env->GetJavaVM(&jvm);

  auto rtcEngine = reinterpret_cast<rtc::IRtcEngine *>(engineHandle);
  if (rtcEngine) {
    util::AutoPtr<media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtcEngine, AGORA_IID_MEDIA_ENGINE);
    if (mediaEngine) {
      mediaEngine->registerVideoFrameObserver(this);
    }
  }
}

VideoFrameObserver::~VideoFrameObserver() {
  auto rtcEngine = reinterpret_cast<rtc::IRtcEngine *>(engineHandle);
  if (rtcEngine) {
    util::AutoPtr<media::IMediaEngine> mediaEngine;
    mediaEngine.queryInterface(rtcEngine, AGORA_IID_MEDIA_ENGINE);
    if (mediaEngine) {
      mediaEngine->registerVideoFrameObserver(nullptr);
    }
  }

  AttachThreadScoped ats(jvm);

  ats.env()->DeleteGlobalRef(jCallerRef);
  jOnCaptureVideoFrame = nullptr;
  jOnRenderVideoFrame = nullptr;
  jOnPreEncodeVideoFrame = nullptr;
  jGetVideoFormatPreference = nullptr;
  jGetRotationApplied = nullptr;
  jGetMirrorApplied = nullptr;
  jGetSmoothRenderingEnabled = nullptr;
  jGetObservedFramePosition = nullptr;
  jIsMultipleChannelFrameWanted = nullptr;
  jOnRenderVideoFrameEx = nullptr;

  ats.env()->DeleteGlobalRef(jVideoFrameClass);
  jVideoFrameInit = nullptr;

  ats.env()->DeleteGlobalRef(jVideoFrameTypeClass);
  jOrdinal = nullptr;
}

bool VideoFrameObserver::onCaptureVideoFrame(VideoFrame &videoFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  std::vector<jbyteArray> arr = NativeToJavaByteArray(env, videoFrame);
  jobject obj = NativeToJavaVideoFrame(env, videoFrame, arr);
  jboolean ret = env->CallBooleanMethod(jCallerRef, jOnCaptureVideoFrame, obj);
  for (int i = 0; i < arr.size(); ++i) {
    jbyteArray jByteArray = arr[i];
    void *buffer = nullptr;
    if (i == 0) {
      buffer = videoFrame.yBuffer;
    } else if (i == 1) {
      buffer = videoFrame.uBuffer;
    } else if (i == 2) {
      buffer = videoFrame.vBuffer;
    }
    env->GetByteArrayRegion(jByteArray, 0, env->GetArrayLength(jByteArray),
                            static_cast<jbyte *>(buffer));
    env->DeleteLocalRef(jByteArray);
  }
  env->DeleteLocalRef(obj);
  return ret;
}

bool VideoFrameObserver::onRenderVideoFrame(unsigned int uid,
                                            VideoFrame &videoFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  std::vector<jbyteArray> arr = NativeToJavaByteArray(env, videoFrame);
  jobject obj = NativeToJavaVideoFrame(env, videoFrame, arr);
  jboolean ret =
      env->CallBooleanMethod(jCallerRef, jOnRenderVideoFrame, uid, obj);
  for (int i = 0; i < arr.size(); ++i) {
    jbyteArray jByteArray = arr[i];
    void *buffer = nullptr;
    if (i == 0) {
      buffer = videoFrame.yBuffer;
    } else if (i == 1) {
      buffer = videoFrame.uBuffer;
    } else if (i == 2) {
      buffer = videoFrame.vBuffer;
    }
    env->GetByteArrayRegion(jByteArray, 0, env->GetArrayLength(jByteArray),
                            static_cast<jbyte *>(buffer));
    env->DeleteLocalRef(jByteArray);
  }
  env->DeleteLocalRef(obj);
  return ret;
}

bool VideoFrameObserver::onPreEncodeVideoFrame(VideoFrame &videoFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  std::vector<jbyteArray> arr = NativeToJavaByteArray(env, videoFrame);
  jobject obj = NativeToJavaVideoFrame(env, videoFrame, arr);
  jboolean ret =
      env->CallBooleanMethod(jCallerRef, jOnPreEncodeVideoFrame, obj);
  for (int i = 0; i < arr.size(); ++i) {
    jbyteArray jByteArray = arr[i];
    void *buffer = nullptr;
    if (i == 0) {
      buffer = videoFrame.yBuffer;
    } else if (i == 1) {
      buffer = videoFrame.uBuffer;
    } else if (i == 2) {
      buffer = videoFrame.vBuffer;
    }
    env->GetByteArrayRegion(jByteArray, 0, env->GetArrayLength(jByteArray),
                            static_cast<jbyte *>(buffer));
    env->DeleteLocalRef(jByteArray);
  }
  env->DeleteLocalRef(obj);
  return ret;
}

VideoFrameObserver::VIDEO_FRAME_TYPE
VideoFrameObserver::getVideoFormatPreference() {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jobject obj = env->CallObjectMethod(jCallerRef, jGetVideoFormatPreference);
  jint ret = env->CallIntMethod(obj, jOrdinal);
  env->DeleteLocalRef(obj);
  return (VIDEO_FRAME_TYPE)ret;
}

bool VideoFrameObserver::getRotationApplied() {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jboolean ret = env->CallBooleanMethod(jCallerRef, jGetRotationApplied);
  return ret;
}

bool VideoFrameObserver::getMirrorApplied() {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jboolean ret = env->CallBooleanMethod(jCallerRef, jGetMirrorApplied);
  return ret;
}

bool VideoFrameObserver::getSmoothRenderingEnabled() {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jboolean ret = env->CallBooleanMethod(jCallerRef, jGetSmoothRenderingEnabled);
  return ret;
}

uint32_t VideoFrameObserver::getObservedFramePosition() {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jint ret = env->CallIntMethod(jCallerRef, jGetObservedFramePosition);
  return ret;
}

bool VideoFrameObserver::isMultipleChannelFrameWanted() {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  jboolean ret =
      env->CallBooleanMethod(jCallerRef, jIsMultipleChannelFrameWanted);
  return ret;
}

bool VideoFrameObserver::onRenderVideoFrameEx(const char *channelId,
                                              unsigned int uid,
                                              VideoFrame &videoFrame) {
  AttachThreadScoped ats(jvm);
  JNIEnv *env = ats.env();
  std::vector<jbyteArray> arr = NativeToJavaByteArray(env, videoFrame);
  jobject obj = NativeToJavaVideoFrame(env, videoFrame, arr);
  jstring str = env->NewStringUTF(channelId);
  jboolean ret =
      env->CallBooleanMethod(jCallerRef, jOnRenderVideoFrameEx, str, uid, obj);
  for (int i = 0; i < arr.size(); ++i) {
    jbyteArray jByteArray = arr[i];
    void *buffer = nullptr;
    if (i == 0) {
      buffer = videoFrame.yBuffer;
    } else if (i == 1) {
      buffer = videoFrame.uBuffer;
    } else if (i == 2) {
      buffer = videoFrame.vBuffer;
    }
    env->GetByteArrayRegion(jByteArray, 0, env->GetArrayLength(jByteArray),
                            static_cast<jbyte *>(buffer));
    env->DeleteLocalRef(jByteArray);
  }
  env->DeleteLocalRef(obj);
  env->DeleteLocalRef(str);
  return ret;
}

std::vector<jbyteArray>
VideoFrameObserver::NativeToJavaByteArray(JNIEnv *env, VideoFrame &videoFrame) {
  int yLength, uLength, vLength;
  switch (videoFrame.type) {
  case FRAME_TYPE_YUV420: {
    yLength = videoFrame.yStride * videoFrame.height;
    uLength = videoFrame.uStride * videoFrame.height / 2;
    vLength = videoFrame.vStride * videoFrame.height / 2;
    break;
  }
  case FRAME_TYPE_YUV422: {
    yLength = videoFrame.yStride * videoFrame.height;
    uLength = videoFrame.uStride * videoFrame.height;
    vLength = videoFrame.vStride * videoFrame.height;
    break;
  }
  case FRAME_TYPE_RGBA: {
    yLength = videoFrame.width * videoFrame.height * 4;
    uLength = 0;
    vLength = 0;
    break;
  }
  }

  jbyteArray jYArray = env->NewByteArray(yLength);
  jbyteArray jUArray = env->NewByteArray(uLength);
  jbyteArray jVArray = env->NewByteArray(vLength);

  if (videoFrame.yBuffer) {
    env->SetByteArrayRegion(jYArray, 0, yLength,
                            static_cast<const jbyte *>(videoFrame.yBuffer));
  }
  if (videoFrame.uBuffer) {
    env->SetByteArrayRegion(jUArray, 0, vLength,
                            static_cast<const jbyte *>(videoFrame.uBuffer));
  }
  if (videoFrame.vBuffer) {
    env->SetByteArrayRegion(jVArray, 0, uLength,
                            static_cast<const jbyte *>(videoFrame.vBuffer));
  }

  std::vector<jbyteArray> vector;
  vector.push_back(jYArray);
  vector.push_back(jUArray);
  vector.push_back(jVArray);
  return vector;
}

jobject VideoFrameObserver::NativeToJavaVideoFrame(
    JNIEnv *env, media::IVideoFrameObserver::VideoFrame &videoFrame,
    std::vector<jbyteArray> jByteArray) {
  jbyteArray jYArray = jByteArray[0];
  jbyteArray jUArray = jByteArray[1];
  jbyteArray jVArray = jByteArray[2];
  return env->NewObject(jVideoFrameClass, jVideoFrameInit, (int)videoFrame.type,
                        videoFrame.width, videoFrame.height, videoFrame.yStride,
                        videoFrame.uStride, videoFrame.vStride, jYArray,
                        jUArray, jVArray, videoFrame.rotation,
                        videoFrame.renderTimeMs, videoFrame.avsync_type);
}
} // namespace agora
