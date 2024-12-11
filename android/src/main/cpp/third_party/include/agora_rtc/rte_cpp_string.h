/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once
#include "internal/c/utils/string.h"

namespace rte {

class Config;
class PlayerConfig;

class String {
 public:

  String(){
    c_rte_string = RteStringCreate(nullptr);
    RteStringInit(c_rte_string, nullptr);
  }

  String(const char* str) {
    c_rte_string = RteStringCreate(nullptr);
    RteStringInit(c_rte_string, nullptr);
    if(nullptr != str){
      RteStringInitWithCStr(c_rte_string, str, nullptr);
    }
  }

  ~String() {
    RteStringDeinit(c_rte_string, nullptr);
    RteStringDestroy(c_rte_string, nullptr);
  }

  void Format(const char* fmt, ...) {
    va_list args;
    va_start(args, fmt);
    RteStringInitWithValue(c_rte_string, nullptr, fmt, args);
    va_end(args);
  }

  void Copy(const String &other) {
    RteStringCopy(c_rte_string, other.c_rte_string, nullptr);
  }

  const char* Cstr() const {
    return RteStringCStr(c_rte_string, nullptr);
  }

  friend class Config;
  friend class PlayerConfig;

 private:
  ::RteString* get_underlying_impl() const { return c_rte_string; }

 private:
  ::RteString *c_rte_string;
};

} // namespace rte
