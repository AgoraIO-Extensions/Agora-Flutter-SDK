//
//  Agora SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once  // NOLINT(build/header_guard)

#include "AgoraBase.h"
#include "AgoraRefPtr.h"

namespace agora {
namespace rtc {

class IMediaPlayer;

class IMediaComponentFactory {
public:
  /** This method creates media player.
   */
  virtual agora_refptr<IMediaPlayer> createMediaPlayer(
      agora::media::base::MEDIA_PLAYER_SOURCE_TYPE type = agora::media::base::MEDIA_PLAYER_SOURCE_DEFAULT) = 0;

protected:
 virtual ~IMediaComponentFactory() {}
};

} //namespace rtc
} // namespace agora

/** \addtogroup createMediaComponentFactory
 @{
 */
/**
 * Creates an \ref agora::rtc::IMediaComponentFactory "IMediaComponentFactory" object and returns the pointer.
 *
 * @return
 * - The pointer to \ref agora::rtc::IMediaComponentFactory "IMediaComponentFactory": Success.
 * - A null pointer: Failure.
 */
AGORA_API agora::rtc::IMediaComponentFactory* AGORA_CALL createAgoraMediaComponentFactory();
/** @} */
