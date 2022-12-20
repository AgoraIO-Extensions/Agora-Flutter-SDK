#ifndef FAKE_IRTCENGINE_H_
#define FAKE_IRTCENGINE_H_

#include "fake_irtcengineex_internal.hpp"
#include "fake_iagoraparameter_internal.hpp"
#include "fake_iaudiodevicemanager.hpp"
#include "fake_ilocalspatialaudioengine.hpp"
#include "fake_imediaengine_internal.hpp"
#include "fake_imediarecorder_internal.hpp"
#include "fake_ivideodevicemanager_internal.hpp"
#include <memory>
#include <stdlib.h>
#include "fake_string.hpp"
#include "fake_imediaplayer.hpp"
#include "fake_imusiccontentcenter.hpp"
#include "fake_imusiccontentcenter_internal.hpp"

namespace agora
{
    namespace rtc
    {

        class FakeIRtcEngine : public FakeIRtcEngineExInternal
        {

        public:
            FakeIRtcEngine() : media_player_id_(0),
                               fakeIAgoraParameterInternal_(std::make_unique<agora::base::FakeIAgoraParameterInternal>()),
                               fakeIAudioDeviceManagerInternal_(std::make_unique<agora::rtc::FakeIAudioDeviceManager>()),
                               fakeIVideoDeviceManagerInternal_(std::make_unique<agora::rtc::FakeIVideoDeviceManagerInternal>()),
                               fakeIMediaEngineInternal_(std::make_unique<agora::media::FakeIMediaEngineInternal>()),
                               fakeILocalSpatialAudioEngineInternal_(std::make_unique<agora::rtc::FakeILocalSpatialAudioEngine>()),
                               fakeIMediaRecorderInternal_(std::make_unique<agora::rtc::FakeIMediaRecorderInternal>()),
                               fakeIMusicContentCenterInternal_(std::make_unique<agora::rtc::FakeIMusicContentCenter>())
            {
            }
            ~FakeIRtcEngine()
            {
                this->eventHandler = nullptr;
            }

            int queryInterface(INTERFACE_ID_TYPE iid, void **inter) override
            {
                if (iid == AGORA_IID_AUDIO_DEVICE_MANAGER)
                {
                    *inter = fakeIAudioDeviceManagerInternal_.get();
                }
                else if (iid == AGORA_IID_VIDEO_DEVICE_MANAGER)
                {
                    *inter = fakeIVideoDeviceManagerInternal_.get();
                }
                else if (iid == AGORA_IID_PARAMETER_ENGINE)
                {
                    *inter = fakeIAgoraParameterInternal_.get();
                }
                else if (iid == AGORA_IID_MEDIA_ENGINE)
                {
                    *inter = fakeIMediaEngineInternal_.get();
                }
                else if (iid == AGORA_IID_AUDIO_ENGINE)
                {
                }
                else if (iid == AGORA_IID_VIDEO_ENGINE)
                {
                }
                else if (iid == AGORA_IID_RTC_CONNECTION)
                {
                }
                else if (iid == AGORA_IID_SIGNALING_ENGINE)
                {
                }
                else if (iid == AGORA_IID_MEDIA_ENGINE_REGULATOR)
                {
                }
                else if (iid == AGORA_IID_CLOUD_SPATIAL_AUDIO)
                {
                }
                else if (iid == AGORA_IID_LOCAL_SPATIAL_AUDIO)
                {
                    *inter = fakeILocalSpatialAudioEngineInternal_.get();
                }
                else if (iid == AGORA_IID_MEDIA_RECORDER)
                {
                    *inter = fakeIMediaRecorderInternal_.get();
                }
                else if (iid == AGORA_IID_STATE_SYNC)
                {
                }
                else if (iid == AGORA_IID_METACHAT_SERVICE)
                {
                }
                else if (iid == AGORA_IID_MUSIC_CONTENT_CENTER)
                {
                    *inter = fakeIMusicContentCenterInternal_.get();
                }
                return 0;
            }

            bool
            registerEventHandler(IRtcEngineEventHandler *eventHandler) override
            {
                this->eventHandler = eventHandler;
                return 0;
            }
            bool
            unregisterEventHandler(IRtcEngineEventHandler *eventHandler) override
            {
                this->eventHandler = nullptr;
                return 0;
            }

            int uploadLogFile(agora::util::AString &requestId) override
            {
                agora::util::IString *str = new agora::util::FakeString;
                requestId.reset(str);
                return 0;
            }

            int getCallId(agora::util::AString &callId) override
            {
                agora::util::IString *str = new agora::util::FakeString;
                callId.reset(str);
                return 0;
            }

            virtual agora_refptr<agora::rtc::IMediaPlayer> createMediaPlayer() override
            {
                media_player_id_++;
                agora_refptr<agora::rtc::IMediaPlayer> mp = agora_refptr<agora::rtc::IMediaPlayer>(new agora::rtc::FakeIMediaPlayer(media_player_id_));
                return mp;
            }

            virtual int destroyMediaPlayer(
                agora_refptr<agora::rtc::IMediaPlayer> media_player) override
            {
                return 0;
            }

        public:
            int media_player_id_ = 0;

            IRtcEngineEventHandler *eventHandler;

            std::unique_ptr<agora::base::FakeIAgoraParameterInternal> fakeIAgoraParameterInternal_;
            std::unique_ptr<agora::rtc::FakeIAudioDeviceManagerInternal> fakeIAudioDeviceManagerInternal_;
            std::unique_ptr<agora::rtc::FakeIVideoDeviceManagerInternal> fakeIVideoDeviceManagerInternal_;
            std::unique_ptr<agora::media::FakeIMediaEngineInternal> fakeIMediaEngineInternal_;
            std::unique_ptr<agora::rtc::FakeILocalSpatialAudioEngineInternal> fakeILocalSpatialAudioEngineInternal_;
            std::unique_ptr<agora::rtc::FakeIMediaRecorderInternal> fakeIMediaRecorderInternal_;
            std::unique_ptr<agora::rtc::FakeIMusicContentCenterInternal> fakeIMusicContentCenterInternal_;
        };

    } // namespace rtc
} // namespace agora

#endif // FAKE_IRTCENGINE_H_
