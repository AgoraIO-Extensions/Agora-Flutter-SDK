//
//  Agora Media SDK
//
//  Copyright (c) 2021 Agora IO. All rights reserved.
//

#pragma once
#include <stdint.h>

namespace agora {
namespace base {

class NtpTime {
 public:
  static const uint64_t ntpFracPerSecond = 4294967296;

  NtpTime() : ms_(0) {}

  NtpTime(uint64_t ms) : ms_(ms) {}

  NtpTime(uint32_t seconds, uint32_t fractions) {
    const double fracMs = fractions * 1000.0 / static_cast<double>(ntpFracPerSecond);
    ms_ = static_cast<uint64_t>(seconds) * 1000 + static_cast<uint64_t>(0.5 + fracMs);
  }

  operator uint64_t() const { return ms_; }

  /** Gets the NTP time.
   *
   * @return
   * - The wallclock time which is in milliseconds relative to 0h UTC on 1 January 1900.
   */
  uint64_t Ms() const {
    return ms_;
  }

   /** Check that whether the NtpTime object is valid
   *
   * - `true`: the NtpTime object is valid.
   * - `false`: the NtpTime object is invalid.
   */
  bool Valid() const { return ms_ != 0; }

   /** Gets the integer part of the NTP timestamp.
   *
   * @return
   * - An uint32_t value.
   */
  uint32_t ToSeconds() const {
    return static_cast<uint32_t>(ms_ / 1000);
  }

   /** Gets the fractional part of the NTP timestamp.
   *
   * @return
   * - An uint32_t value.
   */
  uint32_t ToFractions() const {
    return static_cast<uint32_t>((ms_ % 1000) * static_cast<double>(ntpFracPerSecond) / 1000.0);
  }

   /** Gets the NTP timestamp.
   *
   * @note
   * - The full resolution NTP timestamp is a 64-bit unsigned fixed-point number with the integer part in the first 32 bits and the fractional part in the last 32 bits.
   *
   * @return
   * - An uint64_t value.
   */
  uint64_t ToTimestamp() const {
    return ToSeconds() * ntpFracPerSecond + ToFractions();
  }

 private:
  uint64_t ms_;
};

inline bool operator==(const NtpTime& n1, const NtpTime& n2) {
  return static_cast<uint64_t>(n1) == static_cast<uint64_t>(n2);
}

inline bool operator!=(const NtpTime& n1, const NtpTime& n2) { return !(n1 == n2); }

}  // namespace base
}  // namespace agora
