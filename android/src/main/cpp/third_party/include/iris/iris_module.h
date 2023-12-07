//
// Created by LXH on 2021/4/29.
//

#ifndef IRIS_DELEGATE_H_
#define IRIS_DELEGATE_H_

#include "iris_base.h"

namespace agora {
namespace iris {

class IrisEventHandler {
 public:
  virtual ~IrisEventHandler() = default;

 public:
  virtual void OnEvent(EventParam *param) {}
};

}// namespace iris
}// namespace agora

#endif//IRIS_DELEGATE_H_
