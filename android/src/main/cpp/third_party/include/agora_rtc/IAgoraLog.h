//
//  Agora Media SDK
//
//  Copyright (c) 2015 Agora IO. All rights reserved.
//
#pragma once

#include <cstdlib>
#include <stdint.h>

#ifndef OPTIONAL_ENUM_CLASS
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
#define OPTIONAL_ENUM_CLASS enum class
#else
#define OPTIONAL_ENUM_CLASS enum
#endif
#endif

#ifndef OPTIONAL_LOG_LEVEL_SPECIFIER
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
#define OPTIONAL_LOG_LEVEL_SPECIFIER LOG_LEVEL::
#else
#define OPTIONAL_LOG_LEVEL_SPECIFIER
#endif
#endif

namespace agora {
namespace commons {

/**
 * Supported logging severities of SDK
 */
OPTIONAL_ENUM_CLASS LOG_LEVEL {
  LOG_LEVEL_NONE = 0x0000,
  LOG_LEVEL_INFO = 0x0001,
  LOG_LEVEL_WARN = 0x0002,
  LOG_LEVEL_ERROR = 0x0004,
  LOG_LEVEL_FATAL = 0x0008,
  LOG_LEVEL_API_CALL = 0x0010,
  LOG_LEVEL_DEBUG = 0x0020,
};

/*
The SDK uses ILogWriter class Write interface to write logs as application
The application inherits the methods Write() to implentation their own  log writ

Write has default implementation, it writes logs to files.
Application can use setLogFile() to change file location, see description of set
*/
class ILogWriter {
 public:
  /** user defined log Write function
  @param level log level
  @param message log message content
  @param length log message length
  @return
   - 0: success
   - <0: failure
  */
  virtual int32_t writeLog(LOG_LEVEL level, const char* message, uint16_t length) = 0;

  virtual ~ILogWriter() {}
};

enum LOG_FILTER_TYPE {
  LOG_FILTER_OFF = 0,
  LOG_FILTER_DEBUG = 0x080f,
  LOG_FILTER_INFO = 0x000f,
  LOG_FILTER_WARN = 0x000e,
  LOG_FILTER_ERROR = 0x000c,
  LOG_FILTER_CRITICAL = 0x0008,
  LOG_FILTER_MASK = 0x80f,
};

const uint32_t MAX_LOG_SIZE = 20 * 1024 * 1024;  // 20MB
const uint32_t MIN_LOG_SIZE = 128 * 1024;        // 128KB
/** The default log size in kb
 */
const uint32_t DEFAULT_LOG_SIZE_IN_KB = 2048;

/** Definition of LogConfiguration
 */
struct LogConfig {
  /**The log file path, default is NULL for default log path
   */
  const char* filePath;
  /** The log file size, KB , set 2048KB to use default log size
   */
  uint32_t fileSizeInKB;
  /** The log level, set LOG_LEVEL_INFO to use default log level
   */
  LOG_LEVEL level;

  LogConfig() : filePath(NULL), fileSizeInKB(DEFAULT_LOG_SIZE_IN_KB), level(OPTIONAL_LOG_LEVEL_SPECIFIER LOG_LEVEL_INFO) {}
};
}  // namespace commons
}  // namespace agora

#undef OPTIONAL_LOG_LEVEL_SPECIFIER
