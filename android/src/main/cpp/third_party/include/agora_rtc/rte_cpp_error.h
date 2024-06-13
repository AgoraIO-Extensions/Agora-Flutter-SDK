/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once

#include <cassert>
#include <functional>

#include "internal/c/c_error.h"
#include "internal/c/utils/string.h"

namespace rte {


class Rte;
class Player;
class Canvas;
class Config;
class PlayerConfig;
class CanvasConfig;

class Error {
 public:

  using ErrorCode = ::RteErrorCode;

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
    RteErrorSet(c_error, code, "%s", message);
  }

  ErrorCode Code() const { return c_error != nullptr ? c_error->code : kRteErrorDefault; }

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
