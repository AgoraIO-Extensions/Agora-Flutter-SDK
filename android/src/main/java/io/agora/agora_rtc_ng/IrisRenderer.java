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

  public interface PerformanceCallback {
    void onFrameReceived(long timestamp);
    void onFrameRendered(long timestamp, double drawCost);
  }

  private final long videoFrameManagerNativeHandle;
  private final long uid;
  private final String channelId;
  private final int videoSourceType;
  private final int videoViewSetupMode;
  private long nativeRendererHandle;

  private Callback callback;
  private PerformanceCallback performanceCallback;

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

  public void setPerformanceCallback(PerformanceCallback callback) { 
    this.performanceCallback = callback; 
  }

  /**
   * Call from native
   */
  @Keep
  private void onSizeChanged(int width, int height) {
    if (callback != null) { callback.onSizeChanged(width, height); }
  }

  /**
   * Call from native - record frame received for performance monitoring
   */
  @Keep
  private void recordFrameReceived(long timestamp) {
    if (performanceCallback != null) { 
      performanceCallback.onFrameReceived(timestamp); 
    }
  }

  /**
   * Call from native - record frame rendered for performance monitoring
   */
  @Keep
  private void recordFrameRendered(long timestamp, double drawCost) {
    if (performanceCallback != null) { 
      performanceCallback.onFrameRendered(timestamp, drawCost); 
    }
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
}
