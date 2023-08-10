//
//  Agora SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//

#pragma once  // NOLINT(build/header_guard)

#include "AgoraBase.h"
#include "AgoraRefPtr.h"

namespace agora {
namespace base {
class IAgoraService;
}

namespace rtc {
class ILocalAudioTrack;
class IRtcEngineEventHandler;

/**
 The states of the rhythm player.
 */
enum RHYTHM_PLAYER_STATE_TYPE {
  /** 810: The rhythm player is idle. */
  RHYTHM_PLAYER_STATE_IDLE = 810,
  /** 811: The rhythm player is opening files. */
  RHYTHM_PLAYER_STATE_OPENING,
  /** 812: Files opened successfully, the rhythm player starts decoding files. */
  RHYTHM_PLAYER_STATE_DECODING,
  /** 813: Files decoded successfully, the rhythm player starts mixing the two files and playing back them locally. */
  RHYTHM_PLAYER_STATE_PLAYING,
  /** 814: The rhythm player is starting to fail, and you need to check the error code for detailed failure reasons. */
  RHYTHM_PLAYER_STATE_FAILED,
};

/**
 The error codes of the rhythm player.
 */
enum RHYTHM_PLAYER_ERROR_TYPE {
  /** 0: The rhythm player works well. */
  RHYTHM_PLAYER_ERROR_OK = 0,
  /** 1: The rhythm player occurs a internal error. */
  RHYTHM_PLAYER_ERROR_FAILED = 1,
  /** 801: The rhythm player can not open the file. */
  RHYTHM_PLAYER_ERROR_CAN_NOT_OPEN = 801,
  /** 802: The rhythm player can not play the file. */
  RHYTHM_PLAYER_ERROR_CAN_NOT_PLAY,
  /** 803: The file duration over the limit. The file duration limit is 1.2 seconds */
  RHYTHM_PLAYER_ERROR_FILE_OVER_DURATION_LIMIT,
};

/**
 * The configuration of rhythm player,
 * which is set in startRhythmPlayer or configRhythmPlayer.
 */
struct AgoraRhythmPlayerConfig {
  /**
   * The number of beats per measure. The range is 1 to 9.
   * The default value is 4,
   * which means that each measure contains one downbeat and three upbeats.
   */
  int beatsPerMeasure;
  /*
   * The range is 60 to 360.
   * The default value is 60,
   * which means that the rhythm player plays 60 beats in one minute.
   */
  int beatsPerMinute;

  AgoraRhythmPlayerConfig() : beatsPerMeasure(4), beatsPerMinute(60) {}
};

/**
 * The IRhythmPlayer class provides access to a rhythm player entity.
 * A rhythm player synthesizes beats, plays them locally, and pushes them remotely.
 */
class IRhythmPlayer : public RefCountInterface {
protected:
  virtual ~IRhythmPlayer() {}
  
public:
  static agora_refptr<IRhythmPlayer> Create();
  virtual int initialize(base::IAgoraService* agora_service, IRtcEngineEventHandler* event_handler, bool is_pass_thru_mode) = 0;
  virtual int playRhythm(const char* sound1, const char* sound2, const AgoraRhythmPlayerConfig& config) = 0;
  virtual int stopRhythm() = 0;
  virtual int configRhythmPlayer(const AgoraRhythmPlayerConfig& config) = 0;
  virtual agora_refptr<ILocalAudioTrack> getRhythmPlayerTrack() = 0;
};

} //namespace rtc
} // namespace agora
