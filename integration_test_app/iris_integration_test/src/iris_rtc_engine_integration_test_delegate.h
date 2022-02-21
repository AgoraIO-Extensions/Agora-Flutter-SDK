#ifndef IRIS_RTC_ENGINE_INTEGRATION_TEST_DELEGATE_H_
#define IRIS_RTC_ENGINE_INTEGRATION_TEST_DELEGATE_H_

// This file is mainly used on integration test
#include "iris_delegate.h"
#include "iris_event_handler.h"
#include "iris_rtc_engine.h"
#include "iris_rtc_engine_call_api_recorder.h"
#include "fake_rtc_engine.h"
#include <string>
#include <map>
#include <vector>

class IRIS_DEBUG_CPP_API IrisRtcChannelIntegrationTestDelegate
    : public agora::iris::rtc::IIrisRtcChannel
{
private:
    agora::iris::rtc::IIrisRtcChannel *delegate_;
    IrisRtcEngineCallApiRecoder *apiChannelRecorder_;

public:
    IrisRtcChannelIntegrationTestDelegate(
        agora::iris::rtc::IIrisRtcChannel *delegate,
        IrisRtcEngineCallApiRecoder *delegateMock);

    ~IrisRtcChannelIntegrationTestDelegate();

    void Initialize(agora::rtc::IRtcEngine *engine) override;

    void Release() override;

    void SetEventHandler(agora::iris::IrisEventHandler *event_handler) override;

    agora::iris::IrisEventHandler *GetEventHandler() override;

    void
    RegisterEventHandler(const char *channel_id,
                         agora::iris::IrisEventHandler *event_handler) override;

    void UnRegisterEventHandler(const char *channel_id) override;

    int CallApi(ApiTypeChannel api_type, const char *params,
                char result[kBasicResultLength]) override;

    IRIS_DEPRECATED
    int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
                char result[kBasicResultLength]) override;

    int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
                unsigned int length, char *result) override;
};

class IRIS_DEBUG_CPP_API IrisRtcEngineIntegrationTestDelegate
    : public agora::iris::rtc::IIrisRtcEngine
{
private:
    agora::iris::rtc::IIrisRtcEngine *delegate_;
    IrisRtcEngineCallApiRecoder *apiEngineRecorder_;
    IrisRtcEngineCallApiRecoder *apiChannelRecorder_;
    agora::iris::rtc::IIrisRtcChannel *channelDelegate_;

public:
    agora::rtc::IRtcEngine *fakeRtcEngine_;
    IrisRtcEngineIntegrationTestDelegate(
        agora::iris::rtc::IIrisRtcEngine *delegate,
        IrisRtcEngineCallApiRecoder *apiEngineRecorder,
        IrisRtcEngineCallApiRecoder *apiChannelRecorder);

    ~IrisRtcEngineIntegrationTestDelegate();

    void Initialize(agora::rtc::IRtcEngine *rtc_engine) override;

    void SetEventHandler(agora::iris::IrisEventHandler *event_handler) override;

    agora::iris::IrisEventHandler *GetEventHandler() override;

    int CallApi(ApiTypeEngine api_type, const char *params,
                char result[kBasicResultLength]) override;

    IRIS_DEPRECATED
    int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
                char result[kBasicResultLength]) override;

    int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
                unsigned int length, char result[kBasicResultLength]) override;

    agora::iris::rtc::IIrisRtcDeviceManager *device_manager() override;

    agora::iris::rtc::IIrisRtcChannel *channel() override;

    agora::iris::rtc::IrisRtcRawData *raw_data() override;
};

#endif // IRIS_RTC_ENGINE_INTEGRATION_TEST_DELEGATE_H_
