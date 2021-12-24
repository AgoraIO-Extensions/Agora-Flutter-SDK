#include "include/agora_rtc_engine/call_api_method_call_handler.h"

#include <flutter/standard_method_codec.h>
#include <string>

using namespace flutter;

CallApiMethodCallHandler::CallApiMethodCallHandler(
    agora::iris::rtc::IrisRtcEngine *engine) : irisRtcEngine_(engine) {}

CallApiMethodCallHandler::~CallApiMethodCallHandler() {}

void CallApiMethodCallHandler::HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue> &method_call,
                                                std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
{
    auto method = method_call.method_name();
    if (!method_call.arguments())
    {
        result->Error("Bad Arguments", "Null arguments received");
        return;
    }
// #if DEBUG

// #endif
#ifdef NDEBUG
    // nondebug
#else
    if (method.compare("getIrisRtcEngineIntPtr") == 0)
    {
        result->Success((intptr_t)irisRtcEngine_);
        return;
    }
#endif
    if (method.compare("callApi") == 0 || method.compare("callApiWithBuffer") == 0)
    {
        try
        {
            auto arguments = std::get<EncodableMap>(*method_call.arguments());
            auto api_type = std::get<int32_t>(arguments[EncodableValue("apiType")]);
            auto &params = std::get<std::string>(arguments[EncodableValue("params")]);
            char res[kMaxResultLength] = "";
            int32_t ret;
            if (arguments.find(EncodableValue("buffer")) == arguments.end())
            {
                ret = CallApi(static_cast<ApiTypeEngine>(api_type),
                              params.c_str(), res);
            }
            else
            {
                auto &buffer =
                    std::get<std::vector<uint8_t>>(arguments[EncodableValue("buffer")]);
                ret = CallApi(static_cast<ApiTypeEngine>(api_type),
                              params.c_str(), buffer.data(), res);
            }

            std::printf("api type: %s, param: %s, ret: %s, res: %s", std::to_string(api_type).c_str(), params.c_str(), std::to_string(ret).c_str(), std::string(res).c_str());

            if (ret == 0)
            {
                std::string res_str(res);
                if (res_str.empty())
                {
                    result->Success();
                }
                else
                {
                    result->Success(EncodableValue(res_str));
                }
            }
            else if (ret > 0)
            {
                result->Success(EncodableValue(ret));
            }
            else
            {
                auto des = CallApiError(ret);
                result->Error(std::to_string(ret), des);
            }
        }
        catch (std::exception &e)
        {
            result->Error("-1", e.what());
        }
    }
    else
    {
        result->NotImplemented();
    }
}

int32_t CallApiMethodCallHandler::CallApi(int32_t api_type, const char *params,
                                          char *result)
{
    return irisRtcEngine_->CallApi(static_cast<ApiTypeEngine>(api_type),
                                   params, result);
}

int32_t CallApiMethodCallHandler::CallApi(int32_t api_type, const char *params, void *buffer,
                                          char *result)
{
// TODO(littlegnal): Remove this after we migrate not deprecated CallApi
#pragma warning(disable : 4996)
    return irisRtcEngine_->CallApi(static_cast<ApiTypeEngine>(api_type),
                                   params, buffer, result);
}

std::string CallApiMethodCallHandler::CallApiError(int32_t ret)
{
    char res[kMaxResultLength] = "";
    irisRtcEngine_->CallApi(ApiTypeEngine::kEngineGetErrorDescription,
                            ("{\"code\":" + std::to_string(ret) + "}").c_str(),
                            res);
    return std::string(res);
}