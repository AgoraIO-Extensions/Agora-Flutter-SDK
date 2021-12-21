//
//  AgoraLogWriter.h
//  AgoraRtcEngineKit
//
//  Copyright © 2020 Agora. All rights reserved.
//

#ifndef AgoraLogWriter_h
#define AgoraLogWriter_h

/** The definition of AgoraLogWriterDelegate

@note  Implement the callback in this protocol in the critical thread. We recommend avoiding any time-consuming operation in the critical thread.
*/
@protocol AgoraLogWriterDelegate <NSObject>
@required

/** user defined log Write function

@param message log message of agorasdk,encrypted by xxtea

@param length length of message

@return
 - 0: success

 - <0: failure
 */
- (NSInteger)writeLog:(const NSData*)message Length:(unsigned short)length;

@end

#endif /* AgoraLogWriter_h */
