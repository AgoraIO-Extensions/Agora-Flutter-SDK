/// Generated by terra, DO NOT MODIFY BY HAND.

#ifndef FAKE_IVIDEODEVICEMANAGER_INTERNAL_H_
#define FAKE_IVIDEODEVICEMANAGER_INTERNAL_H_

#include "IAgoraRtcEngine.h"

namespace agora {
namespace rtc {
class FakeIVideoDeviceManagerInternal : public agora::rtc::IVideoDeviceManager {
  virtual agora::rtc::IVideoDeviceCollection *enumerateVideoDevices() override {
    return 0;
  }

  virtual int setDevice(const char *deviceIdUTF8) override { return 0; }

  virtual int getDevice(char *deviceIdUTF8) override { return 0; }

#if defined(_WIN32) || (defined(__linux__) && !defined(__ANDROID__)) ||        \
    (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
  virtual int numberOfCapabilities(char const *deviceIdUTF8) override {
    return 0;
  }
#endif

#if defined(_WIN32) || (defined(__linux__) && !defined(__ANDROID__)) ||        \
    (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)
  virtual int getCapability(char const *deviceIdUTF8,
                            uint32_t const deviceCapabilityNumber,
                            agora::rtc::VideoFormat &capability) override {
    return 0;
  }
#endif

  virtual int startDeviceTest(agora::view_t hwnd) override { return 0; }

  virtual int stopDeviceTest() override { return 0; }

  virtual void release() override {}
};

} // namespace rtc
} // namespace agora

#endif // FAKE_IVIDEODEVICEMANAGER_INTERNAL_H_
