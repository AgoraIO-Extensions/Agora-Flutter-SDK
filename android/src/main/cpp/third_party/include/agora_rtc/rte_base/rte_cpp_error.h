/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <cassert>
#include <functional>

#include "rte_base/c/c_error.h"
#include "rte_base/c/utils/string.h"

namespace rte {


class Rte;
class Player;
class Canvas;
class Config;
class PlayerConfig;
class CanvasConfig;

using ErrorCode = ::RteErrorCode;

/**
 * Error class. Used to record the execution result of an interface call.
 * @since v4.4.0
 */
class Error {
 public:

  Error() : c_error(RteErrorCreate()) {}
  explicit Error(::RteError *error) : c_error(error), c_error_owned(false) {}

  ~Error() {
    if (c_error != nullptr && c_error_owned) {
      RteErrorDestroy(c_error);
    }
  }

  // @{
  Error(Error &other) = delete;
  Error(Error &&other) = delete;
  Error &operator=(const Error &cmd) = delete;
  Error &operator=(Error &&cmd) = delete;
  // @}

  void Set(ErrorCode code, const char *message) { 
    if(c_error != nullptr){
      RteErrorSet(c_error, code, "%s", message ? message : "");
    }
  }

  /**
   * This interface is used to get the specific error code.
   * @since v4.4.0
   * @return ErrorCode Error code,Refer to the ErrorCode type for details.
   */
  ErrorCode Code() const { return c_error != nullptr ? c_error->code : kRteErrorDefault; }

  /**
   * This interface is used to get the specific error description.
   * @since v4.4.0
   * @return const char* Error description
   */
  const char *Message() const { 
    if(c_error != nullptr && c_error->message != nullptr){
      return RteStringCStr(c_error->message, nullptr);
    }
    return "";
  }

  ::RteError *get_underlying_impl() const { return c_error; }

 private:

  ::RteError *c_error;
  bool c_error_owned = true;
};

}  // namespace rte
