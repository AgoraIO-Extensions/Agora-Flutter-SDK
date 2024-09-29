/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once
#include "rte_base/c/stream/stream.h"

namespace rte {

/**
 * The Stream class is used to manage the stream.
 * @since v4.4.0
 * @technical preview
 */
class Stream {

 public:
  Stream() = default;
  ~Stream() = default;

 private:
  friend class Rte;
  friend class Player;

  ::RteStream c_rte_stream;
};

}  // namespace rte