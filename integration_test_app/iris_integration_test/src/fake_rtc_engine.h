#ifndef FAKE_RTC_ENGINE_H_
#define FAKE_RTC_ENGINE_H_

#include "fake_rtc_engine_internal.h"

namespace agora
{
    namespace rtc
    {
        class FakeRtcChannel : public FakeChannelInternal
        {
        public:
            IChannelEventHandler *channel_event_handler_;
            FakeRtcChannel() {}
            ~FakeRtcChannel() override {}
            int release() override
            {
                return 0;
            }

            int setChannelEventHandler(IChannelEventHandler *channelEh) override
            {
                channel_event_handler_ = channelEh;
                return 0;
            }

            int createDataStream(int *streamId, bool reliable, bool ordered) override
            {
                *streamId = 100;
                return 0;
            }
            int createDataStream(int *streamId, DataStreamConfig &config) override
            {
                *streamId = 100;
                return 0;
            }
        };

        class FakeRtcEngine : public agora::rtc::FakeRtcEngineInternal
        {

        public:
            FakeRtcChannel *channel_;
            IRtcEngineEventHandler *event_handler_;

            FakeRtcEngine() : channel_(nullptr), event_handler_(nullptr) {}

            ~FakeRtcEngine() override
            {
                if (channel_)
                {
                    delete channel_;
                    channel_ = nullptr;
                }
            }

            IChannel *createChannel(const char *channelId) override
            {
                channel_ = new FakeRtcChannel();
                return channel_;
            }

            bool registerEventHandler(IRtcEngineEventHandler *eventHandler) override
            {
                event_handler_ = eventHandler;
                return 0;
            }

            int createDataStream(int *streamId, bool reliable, bool ordered) override
            {
                *streamId = 100;
                return 0;
            }
            int createDataStream(int *streamId, DataStreamConfig &config) override
            {
                *streamId = 100;
                return 0;
            }
        };
    }
}

#endif // FAKE_RTC_ENGINE_H_