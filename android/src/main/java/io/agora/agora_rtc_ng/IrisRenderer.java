package io.agora.agora_rtc_ng;

import android.view.Surface;
import androidx.annotation.Keep;

/**
 * An IrisRenderer allow you to rendering the raw data to android Surface
 */
public class IrisRenderer {

  static {
    System.loadLibrary("iris_rendering_android");
  }

  public interface Callback {
    void onSizeChanged(int width, int height);
  }

  private final long videoFrameManagerNativeHandle;
  private final long uid;
  private final String channelId;
  private final int videoSourceType;
  private final int videoViewSetupMode;
  private long nativeRendererHandle;

  private Callback callback;

  public IrisRenderer(long videoFrameManagerNativeHandle, long uid,
                      String channelId, int videoSourceType,
                      int videoViewSetupMode) {
    this.videoFrameManagerNativeHandle = videoFrameManagerNativeHandle;
    this.uid = uid;
    this.channelId = channelId;
    this.videoSourceType = videoSourceType;
    this.videoViewSetupMode = videoViewSetupMode;
  }

  public void setCallback(Callback callback) { this.callback = callback; }

  /**
   * Call from native
   */
  @Keep
  private void onSizeChanged(int width, int height) {
    if (callback != null) { callback.onSizeChanged(width, height); }
  }

  public void startRenderingToSurface(Surface surface) {
    if (nativeRendererHandle != 0L) { return; }
    nativeRendererHandle = nativeStartRenderingToSurface(
        videoFrameManagerNativeHandle, surface, uid, channelId, videoSourceType,
        videoViewSetupMode);
  }

  public void stopRenderingToSurface() {
    if (nativeRendererHandle == 0L) { return; }

    nativeStopRenderingToSurface(nativeRendererHandle);
    nativeRendererHandle = 0L;
  }

  private native long nativeStartRenderingToSurface(long bufferManagerIntPtr,
                                                    Surface surface, long uid,
                                                    String channelId,
                                                    int videoSourceType,
                                                    int videoViewSetupMode);

  private native void nativeStopRenderingToSurface(long nativeRendererHandle);

  private static native void nativeLog(int level, String message);

  public static void log(int level, String message) {
    nativeLog(level, message);
  }

  // Add overload to support formatted strings to avoid compilation errors in VideoViewController.java
  public static void log(int level, String format, Object... args) {
      try {
          String message = String.format(format, args);
          nativeLog(level, message);
      } catch (Exception e) {
          nativeLog(level, format); // Fallback to raw format string if formatting fails
      }
  }
}
