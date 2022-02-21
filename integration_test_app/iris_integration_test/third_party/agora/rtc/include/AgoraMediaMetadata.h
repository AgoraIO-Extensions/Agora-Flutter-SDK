//
// AgoraMediaMetadata.h
// AgoraRtcEngineKit
//
// Copyright (c) 2018 Agora. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The metadata type. */
typedef NS_ENUM(NSInteger, AgoraMetadataType) {
  /** -1: the metadata type is unknown. */
  AgoraMetadataTypeUnknown = -1,
  /** 0: the metadata type is video. */
  AgoraMetadataTypeVideo = 0,
};

/** The definition of the AgoraMediaMetadataDataSource protocol.

@note Implement all the callbacks in this protocol in the critical thread. We recommend avoiding any time-consuming operation in the critical thread.
*/
@protocol AgoraMediaMetadataDataSource <NSObject>
@required

/** Occurs when the SDK requests the maximum size of the metadata.

The SDK triggers this callback after you successfully calling the [setMediaMetadataDataSource]([AgoraRtcEngineKit setMediaMetadataDataSource:withType:]) method. You need to specify the maximum size of the metadata in the return value of this callback.

This callback is returned multiple times, and you can update the maximum metadata size in the new callbacks.
@return The maximum size of the buffer of the metadata (see the return value of [readyToSendMetadataAtTimestamp]([AgoraMediaMetadataDataSource readyToSendMetadataAtTimestamp:])) that you want to use. The highest value is 1024 bytes. Ensure that you set the return value.
 */
- (NSInteger)metadataMaxSize;

/** Occurs when the SDK is ready to receive and send metadata.

You need to specify the metadata in the return value of this method.

@note  Ensure that the size of the metadata that you specify in this callback does not exceed the value set in the maxMetadataSize callback.
 @param timestamp The timestamp (ms) of the current metadata.
 @return The metadata that you want to send in the format of NSData, including the following parameters:

 - `uid`: ID of the user who sends the metadata.
 - `size`: The size of the sent or received metadata.
 - `buffer`: The sent or received metadata.
 - `timeStampMs`: The timestamp of the metadata.

 Ensure that you set the return value.
 */
- (NSData* _Nullable)readyToSendMetadataAtTimestamp:(NSTimeInterval)timestamp;

@end

/** The definition of AgoraMediaMetadataDelegate

@note  Implement the callback in this protocol in the critical thread. We recommend avoiding any time-consuming operation in the critical thread.
*/
@protocol AgoraMediaMetadataDelegate <NSObject>
@required

/** Occurs when the local user receives the metadata.

 @param data The received metadata.
 @param uid The ID of the user who sends the metadata.
 @param timestamp The timestamp (ms) of the received metadata.
 */
- (void)receiveMetadata:(NSData* _Nonnull)data fromUser:(NSInteger)uid atTimestamp:(NSTimeInterval)timestamp;

@end
