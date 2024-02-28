#pragma once

#include "iris_base.h"

class IApiEngineBase {
 public:
  virtual ~IApiEngineBase() {}
  virtual int CallIrisApi(ApiParam *apiParam) = 0;
};

IRIS_API IApiEngineBase *IRIS_CALL createIrisRtcEngine(IrisHandle rtcEngine);

IRIS_API void IRIS_CALL destroyIrisRtcEngine(IApiEngineBase *apiEngine);