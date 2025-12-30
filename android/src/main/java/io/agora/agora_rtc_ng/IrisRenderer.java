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
    void onFrameReceived();
    void onFrameRenderedInterval();
    void onRenderDrawCost(double drawCostMs);
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
  private void recordFrameReceived() {
    if (performanceCallback != null) { 
      performanceCallback.onFrameReceived(); 
    }
  }

  /**
   * Call from native - record frame rendered interval for performance monitoring
   */
  @Keep
  private void recordFrameRenderedInterval() {
    if (performanceCallback != null) { 
      performanceCallback.onFrameRenderedInterval(); 
    }
  }

  /**
   * Call from native - record render draw cost for performance monitoring
   */
  @Keep
  private void recordRenderDrawCost(double drawCostMs) {
    if (performanceCallback != null) { 
      performanceCallback.onRenderDrawCost(drawCostMs); 
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
