//
//  Agora Media SDK
//
//  Copyright (c) 2015 Agora IO. All rights reserved.
//

#pragma once

#include <stdint.h>

namespace agora {
namespace commons {
/*
The SDK uses ILogWriter class Write interface to write logs as application
The application inherits the methods Write() to implentation their own  log writ

Write has default implementation, it writes logs to files.
Application can use setLogFile() to change file location, see description of set
*/
class ILogWriter {
 public:
  /** user defined log Write function
  @param message message content
  @param length message length
  @return
   - 0: success
   - <0: failure
  */
  virtual int32_t writeLog(const char* message, uint16_t length) = 0;
  virtual ~ILogWriter() {}
};

}  // namespace commons
}  // namespace agora
