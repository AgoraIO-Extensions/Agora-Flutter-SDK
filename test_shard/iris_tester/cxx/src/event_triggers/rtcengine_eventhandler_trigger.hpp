#ifndef RTCENGINE_EVENTHANDLER_TRIGGER_
#define RTCENGINE_EVENTHANDLER_TRIGGER_

#include "IAgoraRtcEngine.h"
#include "IAgoraRtcEngineEx.h"

using namespace agora::rtc;

namespace agora
{
    namespace rtc
    {
        namespace event
        {
            class RtcEngineEventHandlerTrigger
            {
            public:
                RtcEngineEventHandlerTrigger(IRtcEngineEventHandlerEx *eventHandler) : eventHandler_(eventHandler) {}
                ~RtcEngineEventHandlerTrigger() = default;

                void TriggerEvent()
                {
                    eventHandler_->onJoinChannelSuccess(RtcConnection("testonaction", 10), 100);
                    eventHandler_->onRejoinChannelSuccess(RtcConnection("testonaction", 10), 100);
                }

            private:
                IRtcEngineEventHandlerEx *eventHandler_;
            };
        } // event

    } // rtc
} // agora

#endif // RTCENGINE_EVENTHANDLER_TRIGGER_