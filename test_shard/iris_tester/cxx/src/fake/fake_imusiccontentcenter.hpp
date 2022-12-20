#pragma once

#include "fake_imusiccontentcenter_internal.hpp"
#include "fake_imusicplayer_internal.hpp"
#include "fake_imediaplayer.hpp"

namespace agora
{
    namespace rtc
    {

        class FakeIMusicPlayer : public FakeIMusicPlayerInternal, public FakeIMediaPlayer
        {
        public:
            FakeIMusicPlayer(int media_player_id) : FakeIMediaPlayer(media_player_id) {}

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

        class FakeIMusicContentCenter : public FakeIMusicContentCenterInternal
        {
        public:
            FakeIMusicContentCenter() : music_player_id_(0)
            {
            }

            agora_refptr<agora::rtc::IMusicPlayer> createMusicPlayer() override
            {
                music_player_id_++;
                agora_refptr<agora::rtc::IMusicPlayer> mp = agora_refptr<agora::rtc::IMusicPlayer>(new agora::rtc::FakeIMusicPlayer(music_player_id_));
                return mp;
            }

            int getMusicCharts(agora::util::AString &requestId) override
            {
                agora::util::IString *str = new agora::util::FakeString;
                requestId.reset(str);
                return 0;
            }

            int getMusicCollectionByMusicChartId(
                agora::util::AString &requestId, int32_t musicChartId, int32_t page,
                int32_t pageSize, char const *jsonOption) override
            {
                agora::util::IString *str = new agora::util::FakeString;
                requestId.reset(str);
                return 0;
            }

            int searchMusic(agora::util::AString &requestId, char const *keyWord,
                            int32_t page, int32_t pageSize,
                            char const *jsonOption) override
            {
                agora::util::IString *str = new agora::util::FakeString;
                requestId.reset(str);
                return 0;
            }

            int getLyric(agora::util::AString &requestId, int64_t songCode,
                         int32_t LyricType) override
            {
                agora::util::IString *str = new agora::util::FakeString;
                requestId.reset(str);

                return 0;
            }

        private:
            int music_player_id_;
        };

    } // namespace rtc
} // namespace agora