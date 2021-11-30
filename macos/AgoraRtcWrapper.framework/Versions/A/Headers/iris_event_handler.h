//
// Created by LXH on 2021/1/14.
//

#ifndef IRIS_EVENT_HANDLER_H_
#define IRIS_EVENT_HANDLER_H_

#include "iris_base.h"

#ifdef __cplusplus
extern "C" {
#endif

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

#ifdef __cplusplus
}
#endif

namespace agora {
namespace iris {
class IrisEventHandler {
 public:
  virtual ~IrisEventHandler() = default;

 public:
  virtual void OnEvent(const char *event, const char *data) = 0;

  virtual void OnEvent(const char *event, const char *data, const void *buffer,
                       unsigned int length) = 0;
};
}// namespace iris
}// namespace agora

#endif//IRIS_EVENT_HANDLER_H_
