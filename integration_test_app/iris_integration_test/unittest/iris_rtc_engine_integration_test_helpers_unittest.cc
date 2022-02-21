#include "fake_rtc_engine.h"
#include "iris_rtc_engine_call_api_recorder.h"
#include "iris_rtc_engine_integration_test_helplers.h"
#include "AgoraBase.h"
#include "iris_event_handler.h"
#include "iris_rtc_channel.h"
#include "iris_rtc_device_manager.h"
#include "iris_rtc_engine.h"
#include "iris_rtc_raw_data.h"
#include "gmock/gmock.h"

#include "gtest/gtest.h"

using namespace agora::iris;
using namespace agora::iris::rtc;

class TestIrisEventHandler : public IrisEventHandler
{
public:
  bool callOnEvent_ = false;
  bool callOnEventWithBuffer_ = false;
  void OnEvent(const char *event, const char *data) override
  {
    callOnEvent_ = true;
  }

  void OnEvent(const char *event, const char *data, const void *buffer,
               unsigned int length) override
  {
    callOnEventWithBuffer_ = true;
  }
};

class TestIrisRtcChannelDelegate : public IrisRtcChannel
{

public:
  bool calledInitialize_ = false;
  bool calledSetDelegate_ = false;
  bool calledRelease_ = false;
  bool calledGetDelegate_ = false;

  bool calledSetEventHandler_ = false;
  bool calledGetEventHandler_ = false;
  bool calledRegisterEventHandler_ = false;
  bool calledUnRegisterEventHandler_ = false;
  bool calledCallApi1_ = false;
  bool calledCallApi2_ = false;
  bool calledCallApi3_ = false;

  IrisEventHandler *event_handler_;

  void Initialize(agora::rtc::IRtcEngine *engine) override
  {
    calledInitialize_ = true;
  }

  void Release() override { calledRelease_ = true; }

  void SetEventHandler(IrisEventHandler *event_handler) override
  {
    calledSetEventHandler_ = true;
    event_handler_ = event_handler;
  }

  IrisEventHandler *GetEventHandler() override
  {
    calledGetEventHandler_ = true;
    return event_handler_;
  }

  void RegisterEventHandler(const char *channel_id,
                            IrisEventHandler *event_handler) override
  {
    calledRegisterEventHandler_ = true;
  }

  void UnRegisterEventHandler(const char *channel_id) override
  {
    calledUnRegisterEventHandler_ = true;
  }

  int CallApi(ApiTypeChannel api_type, const char *params,
              char result[kBasicResultLength]) override
  {
    calledCallApi1_ = true;
    return 0;
  }

  IRIS_DEPRECATED
  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              char result[kBasicResultLength]) override
  {
    calledCallApi2_ = true;
    return 0;
  }

  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              unsigned int length, char *result) override
  {
    calledCallApi3_ = true;
    return 0;
  }
};

class TestIrisRtcEngineDelegate : public IrisRtcEngine
{
public:
  bool calledInitialize_ = false;
  bool calledSetDelegate_ = false;
  bool calledGetDelegate_ = false;
  bool calledSetEventHandler_ = false;
  bool calledGetEventHandler_ = false;
  bool calledCallApi1_ = false;
  bool calledCallApi2_ = false;
  bool calledCallApi3_ = false;
  bool calledDeviceManager = false;
  bool calledChannel = false;
  bool calledRawData = false;
  IIrisRtcChannel *channel_;
  IrisEventHandler *event_handler_;

  TestIrisRtcEngineDelegate(IIrisRtcChannel *channel = nullptr)
  {
    if (channel)
    {
      channel_ = channel;
    }
    else
    {
      channel_ = new TestIrisRtcChannelDelegate();
    }
  }

  void Initialize(agora::rtc::IRtcEngine *rtc_engine) override
  {
    calledInitialize_ = true;
  }

  void SetDelegate(IIrisRtcEngine *delegate) { calledSetDelegate_ = true; }

  IIrisRtcEngine *GetDelegate()
  {
    calledGetDelegate_ = true;
    return nullptr;
  }

  void SetEventHandler(IrisEventHandler *event_handler) override
  {
    calledSetEventHandler_ = true;
    event_handler_ = event_handler;
  }

  IrisEventHandler *GetEventHandler() override
  {
    calledGetEventHandler_ = true;
    return event_handler_;
  }

  int CallApi(ApiTypeEngine api_type, const char *params,
              char result[kBasicResultLength]) override
  {
    calledCallApi1_ = true;
    return 0;
  }

  IRIS_DEPRECATED
  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              char result[kBasicResultLength]) override
  {
    calledCallApi2_ = true;
    return 0;
  }

  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              unsigned int length, char result[kBasicResultLength]) override
  {
    calledCallApi3_ = true;
    return 0;
  }

  IIrisRtcDeviceManager *device_manager() override
  {
    calledDeviceManager = true;
    return nullptr;
  }

  IIrisRtcChannel *channel() override
  {
    calledChannel = true;
    return channel_;
  }

  IrisRtcRawData *raw_data() override
  {
    calledRawData = true;
    return nullptr;
  }
};

class TestIrisRtcEngineErrorCodeCallApiDelegate : public IrisRtcEngine
{
public:
  TestIrisRtcEngineErrorCodeCallApiDelegate() {}

  int CallApi(ApiTypeEngine api_type, const char *params,
              char result[kBasicResultLength]) override
  {
    return -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED;
  }

  IRIS_DEPRECATED
  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              char result[kBasicResultLength]) override
  {
    return -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED;
  }

  int CallApi(ApiTypeEngine api_type, const char *params, void *buffer,
              unsigned int length, char result[kBasicResultLength]) override
  {
    return -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED;
  }
};

class TestIrisRtcChannelCallApiErrorCodeDelegate : public IrisRtcChannel
{

public:
  int CallApi(ApiTypeChannel api_type, const char *params,
              char result[kBasicResultLength]) override
  {
    return -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED;
  }

  IRIS_DEPRECATED
  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              char result[kBasicResultLength]) override
  {
    return -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED;
  }

  int CallApi(ApiTypeChannel api_type, const char *params, void *buffer,
              unsigned int length, char *result) override
  {
    return -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED;
  }
};

class IrisProxyFlutterIntegrationTestHelpersTest : public ::testing::Test
{
private:
  /* data */
public:
  IrisProxyFlutterIntegrationTestHelpersTest(/* args */);
  ~IrisProxyFlutterIntegrationTestHelpersTest();
};

IrisProxyFlutterIntegrationTestHelpersTest::
    IrisProxyFlutterIntegrationTestHelpersTest(/* args */) {}

IrisProxyFlutterIntegrationTestHelpersTest::
    ~IrisProxyFlutterIntegrationTestHelpersTest() {}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest, CanSetIrisProxyCallApi)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);

  SetIrisRtcEngineCallApiRecorder(engine, false);

  ASSERT_EQ(delegate->calledInitialize_, true);

  engine->SetEventHandler(nullptr);
  ASSERT_EQ(delegate->calledSetEventHandler_, true);

  engine->GetEventHandler();
  ASSERT_EQ(delegate->calledGetEventHandler_, true);

  char res[kBasicResultLength] = "";
  engine->CallApi(static_cast<ApiTypeEngine>(1), "params", res);
  ASSERT_EQ(delegate->calledCallApi1_, true);

  engine->CallApi(static_cast<ApiTypeEngine>(2), "params", nullptr, res);
  ASSERT_EQ(delegate->calledCallApi3_, true);

  engine->CallApi(static_cast<ApiTypeEngine>(3), "params", nullptr, 0, res);
  ASSERT_EQ(delegate->calledCallApi3_, true);

  engine->device_manager();
  ASSERT_EQ(delegate->calledDeviceManager, true);

  engine->channel();
  ASSERT_EQ(delegate->calledChannel, true);

  engine->raw_data();
  ASSERT_EQ(delegate->calledRawData, true);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       CanSetIrisProxyCallApiForChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);

  SetIrisRtcEngineCallApiRecorder(engine, true);

  TestIrisRtcChannelDelegate *channel =
      reinterpret_cast<TestIrisRtcChannelDelegate *>(delegate->channel());

  agora::rtc::FakeRtcEngine *fakeRtcEngine = new agora::rtc::FakeRtcEngine();
  engine->channel()->Initialize(fakeRtcEngine);
  ASSERT_EQ(channel->calledInitialize_, true);
  delete fakeRtcEngine;

  engine->channel()->SetEventHandler(nullptr);
  ASSERT_EQ(channel->calledSetEventHandler_, true);

  engine->channel()->GetEventHandler();
  ASSERT_EQ(channel->calledGetEventHandler_, true);

  engine->channel()->RegisterEventHandler("1", nullptr);
  ASSERT_EQ(channel->calledRegisterEventHandler_, true);

  engine->channel()->UnRegisterEventHandler("1");
  ASSERT_EQ(channel->calledUnRegisterEventHandler_, true);

  char res[kBasicResultLength] = "";
  engine->channel()->CallApi(ApiTypeChannel::kChannelCreateChannel, "params",
                             res);
  ASSERT_EQ(channel->calledCallApi1_, true);

  engine->channel()->CallApi(ApiTypeChannel::kChannelJoinChannel, "params",
                             nullptr, res);
  ASSERT_EQ(channel->calledCallApi2_, true);

  engine->channel()->CallApi(ApiTypeChannel::kChannelLeaveChannel, "params",
                             nullptr, 0, res);
  ASSERT_EQ(channel->calledCallApi3_, true);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest, AbleToSetCallApiMockResult)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));
  MockCallApiResult(proxy, 1, "params", "returnValue");

  char res[kBasicResultLength] = "";
  engine->CallApi(ApiTypeEngine::kEngineAddVideoWaterMark, "params", res);

  ASSERT_EQ(std::string(res), std::string("returnValue"));

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToSetCallApiMockResultForChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, true));
  MockCallApiResult(proxy, ApiTypeChannel::kChannelJoinChannel, "params",
                    "returnValue");

  char res[kBasicResultLength] = "";
  engine->channel()->CallApi(ApiTypeChannel::kChannelJoinChannel, "params",
                             res);

  ASSERT_EQ(std::string(res), std::string("returnValue"));

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToSetCallApiMockReturnCode)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));
  MockCallApiReturnCode(proxy, 1, "params", -1);

  char res[kBasicResultLength] = "";
  int ret =
      engine->CallApi(ApiTypeEngine::kEngineAddVideoWaterMark, "params", res);

  ASSERT_EQ(ret, -1);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       ShouldReturnErrorCodeIfNegative)
{
  TestIrisRtcEngineErrorCodeCallApiDelegate *delegate =
      new TestIrisRtcEngineErrorCodeCallApiDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));
  MockCallApiReturnCode(proxy, 1, "params", 10);

  char res[kBasicResultLength] = "";
  int ret =
      engine->CallApi(ApiTypeEngine::kEngineAddVideoWaterMark, "params", res);

  ASSERT_EQ(ret, -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       ShouldAlwaysReturnSuccessForApiTypeEngineInitialize)
{
  TestIrisRtcEngineErrorCodeCallApiDelegate *delegate =
      new TestIrisRtcEngineErrorCodeCallApiDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));

  char res[kBasicResultLength] = "";
  int ret =
      engine->CallApi(ApiTypeEngine::kEngineInitialize, "params", res);

  ASSERT_EQ(ret, 0);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       ShouldAlwaysReturnSuccessForApiTypeChannelCreateChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate(
      new TestIrisRtcChannelCallApiErrorCodeDelegate);
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, true));

  char res[kBasicResultLength] = "";
  int ret = engine->channel()->CallApi(ApiTypeChannel::kChannelCreateChannel,
                                       "params", res);

  ASSERT_EQ(ret, 0);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       ShouldReturnErrorCodeIfNegativeForChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate(
      new TestIrisRtcChannelCallApiErrorCodeDelegate);
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, true));
  MockCallApiReturnCode(proxy, 1, "params", 10);

  char res[kBasicResultLength] = "";
  int ret = engine->channel()->CallApi(ApiTypeChannel::kChannelJoinChannel,
                                       "params", res);

  ASSERT_EQ(ret, -agora::ERROR_CODE_TYPE::ERR_NOT_INITIALIZED);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       ShouldCallDestroyIrisProxyForIntegrationTestDartFFISuccess)
{

  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));

  ClearCallApiRecorder(proxy);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToCallIrisProxyExpectCalledApi)
{

  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));

  char res[kBasicResultLength] = "";
  engine->CallApi(ApiTypeEngine::kEngineAddVideoWaterMark, "params", res);

  bool ret = ExpectCalledApi(proxy, ApiTypeEngine::kEngineAddVideoWaterMark,
                             "params", nullptr, 0);
  ASSERT_EQ(ret, true);
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToCallExpectCalledApiApiTypeEngineInitialize)
{

  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));

  char res[kBasicResultLength] = "";
  engine->CallApi(ApiTypeEngine::kEngineInitialize, "params", res);

  bool ret = ExpectCalledApi(proxy, ApiTypeEngine::kEngineInitialize,
                             "params", nullptr, 0);
  ASSERT_EQ(ret, true);
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToCallIrisProxyExpectCalledApiForChannel)
{

  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, true));

  char res[kBasicResultLength] = "";
  engine->channel()->CallApi(ApiTypeChannel::kChannelJoinChannel, "params",
                             res);

  bool ret = ExpectCalledApi(proxy, ApiTypeChannel::kChannelJoinChannel,
                             "params", nullptr, 0);
  ASSERT_EQ(ret, true);
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToCallExpectCalledApiApiTypeChannelCreateChannel)
{

  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, true));

  char res[kBasicResultLength] = "";
  engine->channel()->CallApi(ApiTypeChannel::kChannelCreateChannel, "params",
                             res);

  bool ret = ExpectCalledApi(proxy, ApiTypeChannel::kChannelCreateChannel,
                             "params", nullptr, 0);
  ASSERT_EQ(ret, true);
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToCallIrisProxyExpectCalledApiWithBuffer)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, false));

  SetExplicitBufferSize(proxy, ApiTypeEngine::kEngineAddVideoWaterMark,
                        "params", 2);

  char res[kBasicResultLength] = "";
  unsigned char buffer[2] = {0xb4, 0xaf};
  engine->CallApi(ApiTypeEngine::kEngineAddVideoWaterMark, "params", buffer,
                  res);

  unsigned char expectedBuffer[2] = {0xb4, 0xaf};
  bool ret = ExpectCalledApi(proxy, ApiTypeEngine::kEngineAddVideoWaterMark,
                             "params", expectedBuffer, 2);
  ASSERT_EQ(ret, true);
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToSetCallApiMockReturnCodeForChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, true));
  MockCallApiReturnCode(proxy, ApiTypeChannel::kChannelJoinChannel, "params",
                        -1);

  char res[kBasicResultLength] = "";
  int ret = engine->channel()->CallApi(ApiTypeChannel::kChannelJoinChannel,
                                       "params", res);

  ASSERT_EQ(ret, -1);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       AbleToCallIrisProxyExpectCalledApiWithBufferForChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  IrisRtcEngineCallApiRecoder *proxy =
      reinterpret_cast<IrisRtcEngineCallApiRecoder *>(
          SetIrisRtcEngineCallApiRecorder(engine, true));

  SetExplicitBufferSize(proxy, ApiTypeChannel::kChannelJoinChannel, "params",
                        2);

  char res[kBasicResultLength] = "";
  unsigned char buffer[2] = {0xb4, 0xaf};
  engine->channel()->CallApi(ApiTypeChannel::kChannelJoinChannel, "params",
                             buffer, res);

  unsigned char expectedBuffer[2] = {0xb4, 0xaf};
  bool ret = ExpectCalledApi(proxy, ApiTypeChannel::kChannelJoinChannel,
                             "params", expectedBuffer, 2);
  ASSERT_EQ(ret, true);
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       CanCallIrisProxyEventHandlerOnEvent)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  SetIrisRtcEngineCallApiRecorder(engine, false);

  TestIrisEventHandler *event_handler = new TestIrisEventHandler();
  engine->SetEventHandler(event_handler);

  CallIrisEventHandlerOnEvent(engine, false, "event", "data");

  ASSERT_EQ(event_handler->callOnEvent_, true);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       CanCallIrisProxyEventHandlerOnEventForChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  SetIrisRtcEngineCallApiRecorder(engine, false);

  TestIrisEventHandler *event_handler = new TestIrisEventHandler();
  engine->channel()->SetEventHandler(event_handler);

  CallIrisEventHandlerOnEvent(engine, true, "event", "data");

  ASSERT_EQ(event_handler->callOnEvent_, true);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       CanCallIrisProxyEventHandlerOnEventWithBuffer)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  SetIrisRtcEngineCallApiRecorder(engine, false);

  TestIrisEventHandler *event_handler = new TestIrisEventHandler();
  engine->SetEventHandler(event_handler);

  unsigned char buffer[2] = {0xb4, 0xaf};
  CallIrisEventHandlerOnEventWithBuffer(engine, false, "event", "data", buffer,
                                        2);

  ASSERT_EQ(event_handler->callOnEventWithBuffer_, true);

  delete engine;
}

TEST_F(IrisProxyFlutterIntegrationTestHelpersTest,
       CanCallIrisProxyEventHandlerOnEventWithBufferForChannel)
{
  TestIrisRtcEngineDelegate *delegate = new TestIrisRtcEngineDelegate();
  IrisRtcEngine *engine =
      new IrisRtcEngine(delegate, kEngineTypeNormal, nullptr);
  SetIrisRtcEngineCallApiRecorder(engine, true);

  TestIrisEventHandler *event_handler = new TestIrisEventHandler();
  engine->channel()->SetEventHandler(event_handler);

  unsigned char buffer[2] = {0xb4, 0xaf};
  CallIrisEventHandlerOnEventWithBuffer(engine, true, "event", "data", buffer,
                                        2);

  ASSERT_EQ(event_handler->callOnEventWithBuffer_, true);

  delete engine;
}
