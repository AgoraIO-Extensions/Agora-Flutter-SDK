package io.agora.rtc.rawdata.base;

import androidx.annotation.NonNull;

public abstract class IAudioFrameObserver {
  private long engineHandle, nativeHandle;

  public IAudioFrameObserver(long engineHandle) {
    this.engineHandle = engineHandle;
  }

  public abstract boolean onRecordAudioFrame(@NonNull AudioFrame audioFrame);

  public abstract boolean onPlaybackAudioFrame(@NonNull AudioFrame audioFrame);

  public abstract boolean onMixedAudioFrame(@NonNull AudioFrame audioFrame);

  public abstract boolean
  onPlaybackAudioFrameBeforeMixing(int uid, @NonNull AudioFrame audioFrame);

  public boolean isMultipleChannelFrameWanted() { return false; }

  public boolean
  onPlaybackAudioFrameBeforeMixingEx(@NonNull String channelId, int uid,
                                     @NonNull AudioFrame audioFrame) {
    return true;
  }

  public void registerAudioFrameObserver() {
    if (nativeHandle == 0) {
      nativeHandle = nativeRegisterAudioFrameObserver(engineHandle);
    }
  }

  public void unregisterAudioFrameObserver() {
    if (nativeHandle != 0) {
      nativeUnregisterAudioFrameObserver(nativeHandle);
      nativeHandle = 0;
    }
  }

  private native long nativeRegisterAudioFrameObserver(long engineHandle);

  private native void nativeUnregisterAudioFrameObserver(long nativeHandle);
}
