//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_C_API_H_
#define IRIS_RTC_C_API_H_

#include "iris_rtc_base.h"
#include "iris_video_processor.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef bool(IRIS_CALL *Func_Bool)();
typedef uint32_t(IRIS_CALL *Func_Uint32_t)();

typedef bool(IRIS_CALL *Func_AudioFrameLocal)(IrisAudioFrame *audio_frame);
typedef bool(IRIS_CALL *Func_AudioFrameRemote)(unsigned int uid,
                                               IrisAudioFrame *audio_frame);
typedef bool(IRIS_CALL *Func_AudioFrameEx)(const char *channel_id,
                                           unsigned int uid,
                                           IrisAudioFrame *audio_frame);
typedef struct IrisRtcCAudioFrameObserver {
  Func_AudioFrameLocal OnRecordAudioFrame;
  Func_AudioFrameLocal OnPlaybackAudioFrame;
  Func_AudioFrameLocal OnMixedAudioFrame;
  Func_AudioFrameRemote OnPlaybackAudioFrameBeforeMixing;
  Func_Bool IsMultipleChannelFrameWanted;
  Func_AudioFrameEx OnPlaybackAudioFrameBeforeMixingEx;
} IrisRtcCAudioFrameObserver;
typedef void *IrisRtcAudioFrameObserverHandle;

typedef bool(IRIS_CALL *Func_VideoFrameLocal)(IrisVideoFrame *video_frame);
typedef bool(IRIS_CALL *Func_VideoFrameRemote)(unsigned int uid,
                                               IrisVideoFrame *video_frame);
typedef bool(IRIS_CALL *Func_VideoFrameEx)(const char *channel_id,
                                           unsigned int uid,
                                           IrisVideoFrame *video_frame);
typedef struct IrisRtcCVideoFrameObserver {
  Func_VideoFrameLocal OnCaptureVideoFrame;
  Func_VideoFrameLocal OnPreEncodeVideoFrame;
  Func_VideoFrameRemote OnRenderVideoFrame;
  Func_Uint32_t GetObservedFramePosition;
  Func_Bool IsMultipleChannelFrameWanted;
  Func_VideoFrameEx OnRenderVideoFrameEx;
} IrisRtcCVideoFrameObserver;
typedef void *IrisRtcVideoFrameObserverHandle;

typedef void *IrisRtcEnginePtr;
typedef void *IrisRtcDeviceManagerPtr;
typedef void *IrisRtcChannelPtr;
typedef void *IrisRtcRawDataPtr;
typedef void *IrisRtcRawDataPluginManagerPtr;

/// IrisRtcEngine
IRIS_API IrisRtcEnginePtr CreateIrisRtcEngine(
    EngineType type = kEngineTypeNormal, const char *executable_path = nullptr);

IRIS_API void DestroyIrisRtcEngine(IrisRtcEnginePtr engine_ptr);

IRIS_API IrisEventHandlerHandle SetIrisRtcEngineEventHandler(
    IrisRtcEnginePtr engine_ptr, IrisCEventHandler *event_handler);

IRIS_API void UnsetIrisRtcEngineEventHandler(IrisRtcEnginePtr engine_ptr,
                                             IrisEventHandlerHandle handle);

IRIS_API int CallIrisRtcEngineApi(IrisRtcEnginePtr engine_ptr,
                                  enum ApiTypeEngine api_type,
                                  const char *params,
                                  char result[kBasicResultLength]);

IRIS_API int CallIrisRtcEngineApiWithBuffer(IrisRtcEnginePtr engine_ptr,
                                            enum ApiTypeEngine api_type,
                                            const char *params, void *buffer,
                                            char result[kBasicResultLength]);

IRIS_API IrisRtcDeviceManagerPtr
GetIrisRtcDeviceManager(IrisRtcEnginePtr engine_ptr);

IRIS_API IrisRtcChannelPtr GetIrisRtcChannel(IrisRtcEnginePtr engine_ptr);

IRIS_API IrisRtcRawDataPtr GetIrisRtcRawData(IrisRtcEnginePtr engine_ptr);

/// IrisRtcDeviceManager
IRIS_API int
CallIrisRtcAudioDeviceManagerApi(IrisRtcDeviceManagerPtr device_manager_ptr,
                                 enum ApiTypeAudioDeviceManager api_type,
                                 const char *params,
                                 char result[kMaxResultLength]);

IRIS_API int
CallIrisRtcVideoDeviceManagerApi(IrisRtcDeviceManagerPtr device_manager_ptr,
                                 enum ApiTypeVideoDeviceManager api_type,
                                 const char *params,
                                 char result[kMaxResultLength]);

/// IrisRtcChannel
IRIS_API IrisEventHandlerHandle SetIrisRtcChannelEventHandler(
    IrisRtcChannelPtr channel_ptr, IrisCEventHandler *event_handler);

IRIS_API void UnsetIrisRtcChannelEventHandler(IrisRtcChannelPtr channel_ptr,
                                              IrisEventHandlerHandle *handle);

IRIS_API IrisEventHandlerHandle RegisterIrisRtcChannelEventHandler(
    IrisRtcChannelPtr channel_ptr, const char *channel_id,
    IrisCEventHandler *event_handler);

IRIS_API void
UnRegisterIrisRtcChannelEventHandler(IrisRtcChannelPtr channel_ptr,
                                     IrisEventHandlerHandle handle,
                                     const char *channel_id);

IRIS_API int CallIrisRtcChannelApi(IrisRtcChannelPtr channel_ptr,
                                   enum ApiTypeChannel api_type,
                                   const char *params, char *result);

IRIS_API int CallIrisRtcChannelApiWithBuffer(IrisRtcChannelPtr channel_ptr,
                                             enum ApiTypeChannel api_type,
                                             const char *params, void *buffer,
                                             char *result);

/// IrisRtcRawData
IRIS_API IrisRtcAudioFrameObserverHandle RegisterAudioFrameObserver(
    IrisRtcRawDataPtr raw_data_ptr, IrisRtcCAudioFrameObserver *observer,
    int order, const char *identifier);

IRIS_API void
UnRegisterAudioFrameObserver(IrisRtcRawDataPtr raw_data_ptr,
                             IrisRtcAudioFrameObserverHandle handle,
                             const char *identifier);

IRIS_API IrisRtcVideoFrameObserverHandle RegisterVideoFrameObserver(
    IrisRtcRawDataPtr raw_data_ptr, IrisRtcCVideoFrameObserver *observer,
    int order, const char *identifier);

IRIS_API void
UnRegisterVideoFrameObserver(IrisRtcRawDataPtr raw_data_ptr,
                             IrisRtcVideoFrameObserverHandle handle,
                             const char *identifier);

IRIS_API void Attach(IrisRtcRawDataPtr raw_data_ptr,
                     IrisVideoFrameBufferManagerPtr manager_ptr);

IRIS_API void Detach(IrisRtcRawDataPtr raw_data_ptr,
                     IrisVideoFrameBufferManagerPtr manager_ptr);

IRIS_API IrisRtcRawDataPluginManagerPtr
GetIrisRtcRawDataPluginManager(IrisRtcRawDataPtr raw_data_ptr);

/// IrisRtcRawDataPluginManager
IRIS_API int CallIrisRtcRawDataPluginManagerApi(
    IrisRtcRawDataPluginManagerPtr plugin_manager_ptr,
    enum ApiTypeRawDataPluginManager api_type, const char *params,
    char result[kBasicResultLength]);

#ifdef __cplusplus
}
#endif

#endif//IRIS_RTC_C_API_H_
