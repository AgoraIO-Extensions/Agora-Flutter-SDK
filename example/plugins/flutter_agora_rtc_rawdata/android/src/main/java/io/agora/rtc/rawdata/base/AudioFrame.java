package io.agora.rtc.rawdata.base;

public class AudioFrame {
  public enum AudioFrameType { PCM16 }

  private AudioFrameType type;
  private int samples;
  private int bytesPerSample;
  private int channels;
  private int samplesPerSec;
  private byte[] buffer;
  private long renderTimeMs;
  private int avsync_type;

  public AudioFrame(int type, int samples, int bytesPerSample, int channels,
                    int samplesPerSec, byte[] buffer, long renderTimeMs,
                    int avsync_type) {
    this.type = AudioFrameType.values()[type];
    this.samples = samples;
    this.bytesPerSample = bytesPerSample;
    this.channels = channels;
    this.samplesPerSec = samplesPerSec;
    this.buffer = buffer;
    this.renderTimeMs = renderTimeMs;
    this.avsync_type = avsync_type;
  }

  public AudioFrameType getType() { return type; }

  public void setType(int type) { this.type = AudioFrameType.values()[type]; }

  public int getSamples() { return samples; }

  public void setSamples(int samples) { this.samples = samples; }

  public int getBytesPerSample() { return bytesPerSample; }

  public void setBytesPerSample(int bytesPerSample) {
    this.bytesPerSample = bytesPerSample;
  }

  public int getChannels() { return channels; }

  public void setChannels(int channels) { this.channels = channels; }

  public int getSamplesPerSec() { return samplesPerSec; }

  public void setSamplesPerSec(int samplesPerSec) {
    this.samplesPerSec = samplesPerSec;
  }

  public byte[] getBuffer() { return buffer; }

  public void setBuffer(byte[] buffer) { this.buffer = buffer; }

  public long getRenderTimeMs() { return renderTimeMs; }

  public void setRenderTimeMs(long renderTimeMs) {
    this.renderTimeMs = renderTimeMs;
  }

  public int getAvsync_type() { return avsync_type; }

  public void setAvsync_type(int avsync_type) {
    this.avsync_type = avsync_type;
  }
}
