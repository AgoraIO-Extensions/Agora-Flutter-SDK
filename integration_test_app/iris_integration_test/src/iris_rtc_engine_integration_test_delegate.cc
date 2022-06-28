#include "iris_rtc_engine_integration_test_delegate.h"
#include "iris_rtc_engine.h"
#include <string>
#include <map>
#include <vector>

using namespace agora::iris::rtc;

IrisRtcChannelIntegrationTestDelegate::IrisRtcChannelIntegrationTestDelegate(
    agora::iris::rtc::IIrisRtcChannel *delegate,
    IrisRtcEngineCallApiRecoder *apiChannelRecorder)
    : delegate_(delegate), apiChannelRecorder_(apiChannelRecorder) {}

IrisRtcChannelIntegrationTestDelegate::
    ~IrisRtcChannelIntegrationTestDelegate() {}

void IrisRtcChannelIntegrationTestDelegate::Initialize(
    agora::rtc::IRtcEngine *engine)
{

  delegate_->Initialize(engine);
}

void IrisRtcChannelIntegrationTestDelegate::Release() { delegate_->Release(); }

void IrisRtcChannelIntegrationTestDelegate::SetEventHandler(
    agora::iris::IrisEventHandler *event_handler)
{
  delegate_->SetEventHandler(event_handler);
}

agora::iris::IrisEventHandler *
IrisRtcChannelIntegrationTestDelegate::GetEventHandler()
{
  return delegate_->GetEventHandler();
}

void IrisRtcChannelIntegrationTestDelegate::RegisterEventHandler(
    const char *channel_id, agora::iris::IrisEventHandler *event_handler)
{
  delegate_->RegisterEventHandler(channel_id, event_handler);
}

void IrisRtcChannelIntegrationTestDelegate::UnRegisterEventHandler(
    const char *channel_id)
{
  delegate_->UnRegisterEventHandler(channel_id);
}

int IrisRtcChannelIntegrationTestDelegate::CallApi(
    ApiTypeChannel api_type, const char *params,
    char result[kBasicResultLength])
{
  int ret = 0;
  int mockReturn = 0;
  ret = delegate_->CallApi(api_type, params, result);

  if (apiChannelRecorder_)
  {
    mockReturn = apiChannelRecorder_->CallApi(api_type, params, result);
  }
  // We always make the ApiTypeChannel::kChannelCreateChannel api call success
  if (ret < 0 && api_type != ApiTypeChannel::kChannelCreateChannel)
    return ret;

  return mockReturn;
}

IRIS_DEPRECATED
int IrisRtcChannelIntegrationTestDelegate::CallApi(
    ApiTypeChannel api_type, const char *params, void *buffer,
    char result[kBasicResultLength])
{
  int ret = 0;
  ret = delegate_->CallApi(api_type, params, buffer, result);
  if (ret < 0)
    return ret;

  if (apiChannelRecorder_)
  {
    ret = apiChannelRecorder_->CallApi(api_type, params, buffer, 0, result);
  }
  return ret;
}

int IrisRtcChannelIntegrationTestDelegate::CallApi(ApiTypeChannel api_type,
                                                   const char *params,
                                                   void *buffer,
                                                   unsigned int length,
                                                   char *result)
{
  int ret = 0;
  ret = delegate_->CallApi(api_type, params, buffer, length, result);
  if (ret < 0)
    return ret;

  if (apiChannelRecorder_)
  {
    ret =
        apiChannelRecorder_->CallApi(api_type, params, buffer, length, result);
  }

  return ret;
}

////////////////////////////////////////////////////////////////////////
/// IrisRtcEngineIntegrationTestDelegate

IrisRtcEngineIntegrationTestDelegate::IrisRtcEngineIntegrationTestDelegate(
    agora::iris::rtc::IIrisRtcEngine *delegate,
    IrisRtcEngineCallApiRecoder *apiEngineRecorder,
    IrisRtcEngineCallApiRecoder *apiChannelRecorder)
    : delegate_(delegate), apiEngineRecorder_(apiEngineRecorder),
      apiChannelRecorder_(apiChannelRecorder)
{
  IrisRtcChannel *originChannel =
      reinterpret_cast<IrisRtcChannel *>(delegate_->channel());

  channelDelegate_ = new IrisRtcChannelIntegrationTestDelegate(
      originChannel, apiChannelRecorder_);
}

IrisRtcEngineIntegrationTestDelegate::~IrisRtcEngineIntegrationTestDelegate()
{
  if (apiEngineRecorder_)
  {
    delete apiEngineRecorder_;
  }
  if (apiChannelRecorder_)
  {
    delete apiChannelRecorder_;
  }
}

void IrisRtcEngineIntegrationTestDelegate::Initialize(
    agora::rtc::IRtcEngine *rtc_engine)
{
  delegate_->Initialize(rtc_engine);
  fakeRtcEngine_ = rtc_engine;
}

void IrisRtcEngineIntegrationTestDelegate::SetEventHandler(
    agora::iris::IrisEventHandler *event_handler)
{
  delegate_->SetEventHandler(event_handler);
}

agora::iris::IrisEventHandler *
IrisRtcEngineIntegrationTestDelegate::GetEventHandler()
{
  return delegate_->GetEventHandler();
}

int IrisRtcEngineIntegrationTestDelegate::CallApi(
    ApiTypeEngine api_type, const char *params,
    char result[kBasicResultLength])
{
  int ret = 0;
  int mockReturn = 0;
  ret = delegate_->CallApi(api_type, params, result);

  if (apiEngineRecorder_)
  {
    mockReturn = apiEngineRecorder_->CallApi(api_type, params, result);
  }

  // We always make the ApiTypeEngine::kEngineInitialize api call success
  if (ret < 0 && api_type != ApiTypeEngine::kEngineInitialize)
  {
    return ret;
  }

  return mockReturn;
}

IRIS_DEPRECATED
int IrisRtcEngineIntegrationTestDelegate::CallApi(
    ApiTypeEngine api_type, const char *params, void *buffer,
    char result[kBasicResultLength])
{
  int ret = 0;
  ret = delegate_->CallApi(api_type, params, buffer, result);
  if (ret < 0)
    return ret;
  if (apiEngineRecorder_)
  {
    ret = apiEngineRecorder_->CallApi(api_type, params, buffer, 0, result);
  }

  return ret;
}

int IrisRtcEngineIntegrationTestDelegate::CallApi(
    ApiTypeEngine api_type, const char *params, void *buffer,
    unsigned int length, char result[kBasicResultLength])
{
  int ret = 0;
  ret = delegate_->CallApi(api_type, params, buffer, length, result);
  if (ret < 0)
    return ret;
  if (apiEngineRecorder_)
  {
    ret = apiEngineRecorder_->CallApi(api_type, params, buffer, length, result);
  }
  return ret;
}

int IrisRtcEngineIntegrationTestDelegate::CallApiMaxResult(ApiTypeEngine api_type, const char *params,
                                                           char result[64 * 1024])
{
  int ret = 0;
  ret = delegate_->CallApiMaxResult(api_type, params, result);
  if (ret < 0)
    return ret;
  if (apiEngineRecorder_)
  {
    ret = apiEngineRecorder_->CallApi(api_type, params, result);
  }
  return ret;
}

IIrisRtcDeviceManager *IrisRtcEngineIntegrationTestDelegate::device_manager()
{
  return delegate_->device_manager();
}

IIrisRtcChannel *IrisRtcEngineIntegrationTestDelegate::channel()
{
  return channelDelegate_;
}

IrisRtcRawData *IrisRtcEngineIntegrationTestDelegate::raw_data()
{
  return delegate_->raw_data();
}