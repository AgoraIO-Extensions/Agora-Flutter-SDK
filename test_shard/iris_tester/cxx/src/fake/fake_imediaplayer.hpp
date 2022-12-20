#pragma once

#include "fake_imediaplayer_internal.hpp"

namespace agora
{
    namespace rtc
    {

        class FakeIMediaPlayer : public FakeIMediaPlayerInternal
        {
        public:
            FakeIMediaPlayer(int media_player_id) : media_player_id_(media_player_id) {}

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

            int getMediaPlayerId() const override { return media_player_id_; }

        private:
            int media_player_id_;
        };

    } // namespace rtc
} // namespace agora