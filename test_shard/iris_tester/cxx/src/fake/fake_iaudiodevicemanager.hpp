#pragma once

#include "fake_iaudiodevicemanager_internal.hpp"
#include "AgoraBase.h"
#include "fake_iaudiodevicecollection_internal.hpp"
#include <memory>
#include <stdlib.h>
#include "IAudioDeviceManager.h"
#include <vector>

namespace agora
{
    namespace rtc
    {

        class FakeIAudioDeviceManager : public FakeIAudioDeviceManagerInternal
        {
        public:
            FakeIAudioDeviceManager() = default;

            void AddRef() const override
            {
            }
            RefCountReleaseStatus Release() const override
            {
                return RefCountReleaseStatus::kOtherRefsRemained;
            }
            bool HasOneRef() const override
            {
                return 0;
            }

            agora::rtc::IAudioDeviceCollection *
            enumeratePlaybackDevices() override
            {
                auto audioDeviceCollection = std::make_unique<agora::rtc::FakeIAudioDeviceCollectionInternal>();

                agora::rtc::IAudioDeviceCollection *ptr = audioDeviceCollection.get();

                audioDeviceCollections_.push_back(std::move(audioDeviceCollection));

                return ptr;
            }

            agora::rtc::IAudioDeviceCollection *
            enumerateRecordingDevices() override
            {
                auto audioDeviceCollection = std::make_unique<agora::rtc::FakeIAudioDeviceCollectionInternal>();

                agora::rtc::IAudioDeviceCollection *ptr = audioDeviceCollection.get();

                audioDeviceCollections_.push_back(std::move(audioDeviceCollection));

                return ptr;
            }

        private:
            std::vector<std::unique_ptr<agora::rtc::IAudioDeviceCollection>> audioDeviceCollections_;
        };

    } // namespace rtc
} // namespace agora