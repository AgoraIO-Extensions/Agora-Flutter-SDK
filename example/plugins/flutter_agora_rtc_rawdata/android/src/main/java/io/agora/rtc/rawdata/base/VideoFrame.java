package io.agora.rtc.rawdata.base;

public class VideoFrame {
  public enum VideoFrameType { YUV420, YUV422, RGBA }

  private VideoFrameType type;
  private int width;
  private int height;
  private int yStride;
  private int uStride;
  private int vStride;
  private byte[] yBuffer;
  private byte[] uBuffer;
  private byte[] vBuffer;
  private int rotation;
  private long renderTimeMs;
  private int avsync_type;

  public VideoFrame(int type, int width, int height, int yStride, int uStride,
                    int vStride, byte[] yBuffer, byte[] uBuffer, byte[] vBuffer,
                    int rotation, long renderTimeMs, int avsync_type) {
    this.type = VideoFrameType.values()[type];
    this.width = width;
    this.height = height;
    this.yStride = yStride;
    this.uStride = uStride;
    this.vStride = vStride;
    this.yBuffer = yBuffer;
    this.uBuffer = uBuffer;
    this.vBuffer = vBuffer;
    this.rotation = rotation;
    this.renderTimeMs = renderTimeMs;
    this.avsync_type = avsync_type;
  }

  public VideoFrameType getType() { return type; }

  public void setType(int type) { this.type = VideoFrameType.values()[type]; }

  public int getWidth() { return width; }

  public void setWidth(int width) { this.width = width; }

  public int getHeight() { return height; }

  public void setHeight(int height) { this.height = height; }

  public int getyStride() { return yStride; }

  public void setyStride(int yStride) { this.yStride = yStride; }

  public int getuStride() { return uStride; }

  public void setuStride(int uStride) { this.uStride = uStride; }

  public int getvStride() { return vStride; }

  public void setvStride(int vStride) { this.vStride = vStride; }

  public byte[] getyBuffer() { return yBuffer; }

  public void setyBuffer(byte[] yBuffer) { this.yBuffer = yBuffer; }

  public byte[] getuBuffer() { return uBuffer; }

  public void setuBuffer(byte[] uBuffer) { this.uBuffer = uBuffer; }

  public byte[] getvBuffer() { return vBuffer; }

  public void setvBuffer(byte[] vBuffer) { this.vBuffer = vBuffer; }

  public int getRotation() { return rotation; }

  public void setRotation(int rotation) { this.rotation = rotation; }

  public long getRenderTimeMs() { return renderTimeMs; }

  public void setRenderTimeMs(long renderTimeMs) {
    this.renderTimeMs = renderTimeMs;
  }

  public int getAvsync_type() { return avsync_type; }

  public void setAvsync_type(int avsync_type) {
    this.avsync_type = avsync_type;
  }
}
