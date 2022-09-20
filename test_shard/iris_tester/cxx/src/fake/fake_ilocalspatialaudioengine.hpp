#ifndef FAKEILOCALSPATIALAUDIOENGINE_H_
#define FAKEILOCALSPATIALAUDIOENGINE_H_

#include "fake_ilocalspatialaudioengine_internal.hpp"
#include "AgoraBase.h"

namespace agora
{
    namespace rtc
    {
        class FakeILocalSpatialAudioEngine : public FakeILocalSpatialAudioEngineInternal
        {

        public:
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
        };
    } // namespace rtc
} // namespace agora

#endif // FAKEILOCALSPATIALAUDIOENGINE_H_