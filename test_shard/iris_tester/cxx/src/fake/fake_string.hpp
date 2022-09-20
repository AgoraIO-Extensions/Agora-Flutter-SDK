#pragma once

#include "AgoraBase.h"

namespace agora
{
    namespace util
    {
        class FakeString : public agora::util::IString
        {
        public:
            bool empty() const override { return false; }
            const char *c_str() override { return "123"; }
            const char *data() override { return "123"; }
            size_t length() override { return 3; }
            void release() override {}
            IString *clone() override { return nullptr; }
        };
    } // namespace util
} // namespace agora