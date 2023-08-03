//
// Created by LXH on 2021/4/29.
//

#ifndef IRIS_DELEGATE_H_
#define IRIS_DELEGATE_H_

#include "iris_base.h"
#include <string>

namespace agora {
namespace iris {

class IRIS_DEBUG_CPP_API IrisEventHandler {
 public:
  virtual ~IrisEventHandler() = default;

 public:
  virtual void OnEvent(EventParam *param){};
};

class IModule {
 public:
  virtual ~IModule(){};
  virtual void Initialize(void *rtc_engine) = 0;
  virtual void Release() = 0;
  virtual int CallApi(const char *func_name, const char *buff,
                      uint32_t buffLength, std::string &out) = 0;
};

}// namespace iris
}// namespace agora

#endif//IRIS_DELEGATE_H_
