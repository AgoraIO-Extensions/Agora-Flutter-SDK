//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_RTC_C_API_H_
#define IRIS_RTC_C_API_H_

#include "iris_rtc_base.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef bool(IRIS_CALL *Func_Bool)();
typedef uint32_t(IRIS_CALL *Func_Uint32_t)();

typedef void(IRIS_CALL *Func_Event)(const char *event, const char *data);
typedef void(IRIS_CALL *Func_EventWithBuffer)(const char *event,
                                              const char *data,
                                              const void *buffer,
                                              unsigned int length);
typedef struct IrisCEventHandler {
  Func_Event OnEvent;
  Func_EventWithBuffer OnEventWithBuffer;
} IrisCEventHandler;
typedef void *IrisEventHandlerHandle;

typedef bool(IRIS_CALL *Func_AudioFrameLocal)(IrisRtcAudioFrame *audio_frame);
typedef bool(IRIS_CALL *Func_AudioFrameRemote)(unsigned int uid,
                                               IrisRtcAudioFrame *audio_frame);
typedef bool(IRIS_CALL *Func_AudioFrameEx)(const char *channel_id,
                                           unsigned int uid,
                                           IrisRtcAudioFrame *audio_frame);
typedef struct IrisRtcCAudioFrameObserver {
  Func_AudioFrameLocal OnRecordAudioFrame;
  Func_AudioFrameLocal OnPlaybackAudioFrame;
  Func_AudioFrameLocal OnMixedAudioFrame;
  Func_AudioFrameRemote OnPlaybackAudioFrameBeforeMixing;
  Func_Bool IsMultipleChannelFrameWanted;
  Func_AudioFrameEx OnPlaybackAudioFrameBeforeMixingEx;
} IrisRtcCAudioFrameObserver;
typedef void *IrisRtcAudioFrameObserverHandle;

typedef bool(IRIS_CALL *Func_VideoFrameLocal)(IrisRtcVideoFrame *video_frame);
typedef bool(IRIS_CALL *Func_VideoFrameRemote)(unsigned int uid,
                                               IrisRtcVideoFrame *video_frame);
typedef bool(IRIS_CALL *Func_VideoFrameEx)(const char *channel_id,
                                           unsigned int uid,
                                           IrisRtcVideoFrame *video_frame);
typedef VideoFrameType(IRIS_CALL *Func_VideoFrameType)();
typedef struct IrisRtcCVideoFrameObserver {
  Func_VideoFrameLocal OnCaptureVideoFrame;
  Func_VideoFrameLocal OnPreEncodeVideoFrame;
  Func_VideoFrameRemote OnRenderVideoFrame;
  Func_VideoFrameType GetVideoFormatPreference;
  Func_Uint32_t GetObservedFramePosition;
  Func_Bool IsMultipleChannelFrameWanted;
  Func_VideoFrameEx OnRenderVideoFrameEx;
} IrisRtcCVideoFrameObserver;
typedef void *IrisRtcVideoFrameObserverHandle;

typedef void(IRIS_CALL *Func_VideoFrame)(const IrisRtcVideoFrame *video_frame,
                                         unsigned int uid,
                                         const char *channel_id, bool resize);
typedef struct IrisRtcCRendererCacheConfig {
  VideoFrameType type;
  Func_VideoFrame OnVideoFrameReceived;
  int resize_width;
  int resize_height;
} IrisRtcCRendererCacheConfig;
typedef void *IrisRtcRendererCacheConfigHandle;

typedef void *IrisRtcEnginePtr;
typedef void *IrisRtcDeviceManagerPtr;
typedef void *IrisRtcChannelPtr;
typedef void *IrisRtcRawDataPtr;
typedef void *IrisRtcRawDataPluginManagerPtr;
typedef void *IrisRtcRendererPtr;
#if defined(IRIS_DEBUG)
typedef void *IrisRtcTesterPtr;
#endif

/// IrisRtcEngine
IRIS_API IrisRtcEnginePtr CreateIrisRtcEngine(const char *executable_path);

IRIS_API void DestroyIrisRtcEngine(IrisRtcEnginePtr engine_ptr);

IRIS_API IrisEventHandlerHandle SetIrisRtcEngineEventHandler(
    IrisRtcEnginePtr engine_ptr, IrisCEventHandler *event_handler);

IRIS_API void UnsetIrisRtcEngineEventHandler(IrisRtcEnginePtr engine_ptr,
                                             IrisEventHandlerHandle handle);

#if defined(IRIS_DEBUG)
IRIS_DEBUG_API void EnableIrisRtcEngineTest(IrisRtcEnginePtr engine_ptr,
                                            IrisRtcTesterPtr tester_ptr);
#endif

IRIS_API int CallIrisRtcEngineApi(IrisRtcEnginePtr engine_ptr,
                                  enum ApiTypeEngine api_type,
                                  const char *params, char *result);

IRIS_API int CallIrisRtcEngineApiWithBuffer(IrisRtcEnginePtr engine_ptr,
                                            enum ApiTypeEngine api_type,
                                            const char *params, void *buffer,
                                            char *result);
IRIS_API IrisRtcDeviceManagerPtr
GetIrisRtcDeviceManager(IrisRtcEnginePtr engine_ptr);

IRIS_API IrisRtcChannelPtr GetIrisRtcChannel(IrisRtcEnginePtr engine_ptr);

IRIS_API IrisRtcRawDataPtr GetIrisRtcRawData(IrisRtcEnginePtr engine_ptr);

/// IrisRtcDeviceManager
#if defined(IRIS_DEBUG)
IRIS_DEBUG_API void
EnableIrisRtcDeviceManagerTest(IrisRtcDeviceManagerPtr device_manager_ptr,
                               IrisRtcTesterPtr tester_ptr);
#endif

IRIS_API int
CallIrisRtcAudioDeviceManagerApi(IrisRtcDeviceManagerPtr device_manager_ptr,
                                 enum ApiTypeAudioDeviceManager api_type,
                                 const char *params, char *result);

IRIS_API int
CallIrisRtcVideoDeviceManagerApi(IrisRtcDeviceManagerPtr device_manager_ptr,
                                 enum ApiTypeVideoDeviceManager api_type,
                                 const char *params, char *result);

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

#if defined(IRIS_DEBUG)
IRIS_DEBUG_API void EnableIrisRtcChannelTest(IrisRtcChannelPtr channel_ptr,
                                             IrisRtcTesterPtr tester_ptr);
#endif

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

IRIS_API IrisRtcRawDataPluginManagerPtr
GetIrisRtcRawDataPluginManager(IrisRtcRawDataPtr raw_data_ptr);

IRIS_API IrisRtcRendererPtr GetIrisRtcRenderer(IrisRtcRawDataPtr raw_data_ptr);

/// IrisRtcRawDataPluginManager
IRIS_API int CallIrisRtcRawDataPluginManagerApi(
    IrisRtcRawDataPluginManagerPtr plugin_manager_ptr,
    enum ApiTypeRawDataPlugin api_type, const char *params, char *result);

/// IrisRtcRenderer
IRIS_API IrisEventHandlerHandle SetIrisRtcRendererEventHandler(
    IrisRtcRendererPtr renderer_ptr, IrisCEventHandler *event_handler);

IRIS_API void UnsetIrisRtcRendererEventHandler(IrisRtcRendererPtr renderer_ptr,
                                               IrisEventHandlerHandle handle);

IRIS_API IrisRtcRendererCacheConfigHandle EnableVideoFrameCache(
    IrisRtcRendererPtr renderer_ptr, IrisRtcCRendererCacheConfig *cache_config,
    unsigned int uid, const char *channel_id = "");

IRIS_API void
DisableVideoFrameCache(IrisRtcRendererPtr renderer_ptr,
                       IrisRtcRendererCacheConfigHandle *handle = nullptr,
                       unsigned int uid = -1, const char *channel_id = "");

IRIS_API bool GetVideoFrame(IrisRtcRendererPtr renderer_ptr,
                            IrisRtcVideoFrame *video_frame, bool *is_new_frame,
                            unsigned int uid, const char *channel_id = "");

/// IrisRtcTester
#if defined(IRIS_DEBUG)
IRIS_DEBUG_API IrisRtcTesterPtr CreateIrisRtcTester(const char *dump_file_path);

IRIS_DEBUG_API void DestroyIrisRtcTester(IrisRtcTesterPtr tester_ptr);

IRIS_DEBUG_API void BeginApiTestByFile(IrisRtcTesterPtr tester_ptr,
                                       const char *case_file_path,
                                       IrisCEventHandler *event_handler);

IRIS_DEBUG_API void BeginApiTest(IrisRtcTesterPtr tester_ptr,
                                 const char *case_content,
                                 IrisCEventHandler *event_handler);

IRIS_DEBUG_API void BeginEventTestByFile(IrisRtcTesterPtr tester_ptr,
                                         const char *case_file_path,
                                         IrisCEventHandler *event_handler);

IRIS_DEBUG_API void BeginEventTest(IrisRtcTesterPtr tester_ptr,
                                   const char *case_content,
                                   IrisCEventHandler *event_handler);

IRIS_DEBUG_API void OnEventReceived(IrisRtcTesterPtr tester_ptr,
                                    const char *event, const char *data);
#endif

#ifdef __cplusplus
}
#endif

#endif//IRIS_RTC_C_API_H_
