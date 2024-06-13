/**
 *
 * Agora Real Time Engagement
 * Copyright (c) 2024 Agora IO. All rights reserved.
 *
 */
#pragma once
#include "internal/c/stream/stream.h"

namespace rte {

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