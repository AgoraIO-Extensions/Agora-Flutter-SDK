//  Agora SDK
//
//  Copyright (c) 2019 Agora.io. All rights reserved.
//

#ifndef AGORA_SERVICE_H
#define AGORA_SERVICE_H
#include "AgoraBase.h"

namespace agora {
namespace rtc {
class IRtcEngine;
}
namespace rtm {
class IRtmService;
}
namespace base {

struct AgoraServiceContext {};

class IAgoraService {
 protected:
  virtual ~IAgoraService() {}

 public:
  AGORA_CPP_API static void release();

  /** Initializes the engine.

@param context RtcEngine context.
@return
- 0: Success.
- < 0: Failure.
*/
  virtual int initialize(const AgoraServiceContext& context) = 0;

  /** Gets the SDK version number.
   * @param build Build number.
   * @return The current SDK version in the string format. For example, 2.4.0
   */
  virtual const char* getVersion(int* build) = 0;

  virtual rtm::IRtmService* createRtmService() = 0;
};

}  // namespace base
}  // namespace agora

/** Gets the SDK version number.

 @param build Build number of the Agora SDK.
 @return
 - 0: Success.
 - < 0: Failure.
*/
AGORA_API const char* AGORA_CALL getAgoraSdkVersion(int* build);

/**
 * Creates the RtcEngine object and returns the pointer.
 * @param err Error code
 * @return returns Description of the error code
 */
AGORA_API const char* AGORA_CALL getAgoraSdkErrorDescription(int err);

/**
 * Creates the Agora Service object and returns the pointer.
 * @return returns Pointer of the Agora Service object
 */
AGORA_API agora::base::IAgoraService* AGORA_CALL createAgoraService();

AGORA_API int AGORA_CALL setAgoraSdkExternalSymbolLoader(void* (*func)(const char* symname));

#endif
