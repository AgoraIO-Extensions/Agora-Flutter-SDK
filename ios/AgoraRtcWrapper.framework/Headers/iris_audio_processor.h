//
// Created by LXH on 2021/7/20.
//

#ifndef IRIS_AUDIO_PROCESSOR_H_
#define IRIS_AUDIO_PROCESSOR_H_

#include "iris_media_base.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef void *IrisAudioFrameMixingPtr;

IRIS_API IrisAudioFrameMixingPtr CreateIrisAudioFrameMixing();

IRIS_API void FreeIrisAudioFrameMixing(IrisAudioFrameMixingPtr mixing_ptr);

IRIS_API void PushAudioFrame(IrisAudioFrameMixingPtr mixing_ptr,
                             IrisAudioFrame *audio_frame);

IRIS_API void Mixing(IrisAudioFrameMixingPtr mixing_ptr,
                     IrisAudioFrame *audio_frame);

#ifdef __cplusplus
}
#endif

#endif//IRIS_AUDIO_PROCESSOR_H_
