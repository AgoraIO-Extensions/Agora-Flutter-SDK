//
// Created by LXH on 2021/4/29.
//

#ifndef IRIS_DELEGATE_H_
#define IRIS_DELEGATE_H_

#include "iris_event_handler.h"

namespace agora {
namespace iris {

template<typename ApiType>
class IrisDelegate {
 public:
  virtual ~IrisDelegate() = default;

 public:
  virtual void SetEventHandler(IrisEventHandler *event_handler) = 0;

  virtual IrisEventHandler *GetEventHandler() = 0;

  virtual int CallApi(ApiType api_type, const char *params,
                      char result[kBasicResultLength]) = 0;

  virtual int CallApi(ApiType api_type, const char *params, void *buffer,
                      unsigned int length, char result[kBasicResultLength]) = 0;
};

}// namespace iris
}// namespace agora

#endif//IRIS_DELEGATE_H_
