package io.agora.rtc.rawdata.base;

import androidx.annotation.NonNull;

public abstract class IVideoFrameObserver {
  static int POSITION_POST_CAPTURER = 1 << 0;
  static int POSITION_PRE_RENDERER = 1 << 1;
  static int POSITION_PRE_ENCODER = 1 << 2;

  private long engineHandle, nativeHandle;

  public IVideoFrameObserver(long engineHandle) {
    this.engineHandle = engineHandle;
  }

  public abstract boolean onCaptureVideoFrame(@NonNull VideoFrame videoFrame);

  public boolean onPreEncodeVideoFrame(@NonNull VideoFrame videoFrame) {
    return true;
  }

  public abstract boolean onRenderVideoFrame(int uid,
                                             @NonNull VideoFrame videoFrame);

  public VideoFrame.VideoFrameType getVideoFormatPreference() {
    return VideoFrame.VideoFrameType.YUV420;
  }

  public boolean getRotationApplied() { return false; }

  public boolean getMirrorApplied() { return false; }

  public boolean getSmoothRenderingEnabled() { return false; }

  public int getObservedFramePosition() {
    return POSITION_POST_CAPTURER | POSITION_PRE_RENDERER;
  }

  public boolean isMultipleChannelFrameWanted() { return false; }

  public boolean onRenderVideoFrameEx(@NonNull String channelId, int uid,
                                      @NonNull VideoFrame videoFrame) {
    return true;
  }

  public void registerVideoFrameObserver() {
    if (nativeHandle == 0) {
      engineHandle = nativeRegisterVideoFrameObserver(engineHandle);
    }
  }

  public void unregisterVideoFrameObserver() {
    if (nativeHandle != 0) {
      nativeUnregisterVideoFrameObserver(nativeHandle);
      nativeHandle = 0;
    }
  }

  private native long nativeRegisterVideoFrameObserver(long engineHandle);

  private native void nativeUnregisterVideoFrameObserver(long nativeHandle);
}
