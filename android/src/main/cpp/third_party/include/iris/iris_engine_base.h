#pragma once

#include "iris_module.h"

class IApiEngineBase {
 public:
  virtual ~IApiEngineBase() {}
  virtual int CallIrisApi(ApiParam *apiParam) = 0;
};

IRIS_API IApiEngineBase *IRIS_CALL createIrisRtcEngine(void *engine);

IRIS_API void IRIS_CALL destroyIrisRtcEngine(IApiEngineBase *engine);