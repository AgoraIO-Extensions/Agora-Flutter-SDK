package io.agora.agorartcengine;

import android.media.AudioFormat;
import android.media.AudioRecord;

public class CustomRecorderConfig {
    private static final int DEFAULT_SAMPLE_RATE = 16000;

    private int mSampleRate;
    private int mChannel;
    private int mAudioFormat;
    private int mBufferSize;

    private static CustomRecorderConfig sDefaultConfig;

    public int getSampleRate() {
        return mSampleRate;
    }

    void setSampleRate(int mSampleRate) {
        this.mSampleRate = mSampleRate;
    }

    public int getChannelCount() {
        switch (mChannel) {
            case AudioFormat.CHANNEL_IN_MONO:
                return 1;
            case AudioFormat.CHANNEL_IN_STEREO:
                return 2;
            default:
                return 0;
        }
    }

    /**
     * Set audio channel count
     *
     * @param channel One of AudioFormat.CHANNEL_IN_MONO
     *                or AudioFormat.CHANNEL_IN_STEREO
     */
    void setChannel(int channel) {
        mChannel = channel;
    }

    int getChannelType() {
        return mChannel;
    }

    int getAudioFormat() {
        return mAudioFormat;
    }

    void setAudioFormat(int mAudioFormat) {
        this.mAudioFormat = mAudioFormat;
    }

    int getBufferSize() {
        return mBufferSize;
    }

    void setBufferSize(int mBufferSize) {
        this.mBufferSize = mBufferSize;
    }

    /**
     * Get a default audio recording configuration with:
     * 1) Sample rate: 16KHz
     * 2) Channel count: mono (1)
     * 3) Audio format: AudioFormat.ENCODING_PCM_16BIT
     * 4) Buffer size: twice the minimum buffer size
     *
     * @return
     */
    public static CustomRecorderConfig getDefaultConfig() {
        if (sDefaultConfig == null) {
            sDefaultConfig = new CustomRecorderConfig();
            sDefaultConfig.setSampleRate(DEFAULT_SAMPLE_RATE);
            sDefaultConfig.setChannel(AudioFormat.CHANNEL_IN_MONO);
            sDefaultConfig.setAudioFormat(AudioFormat.ENCODING_PCM_16BIT);
            int bufSize = AudioRecord.getMinBufferSize(
                    sDefaultConfig.getSampleRate(),
                    sDefaultConfig.getChannelType(),
                    sDefaultConfig.getAudioFormat());
            sDefaultConfig.setBufferSize(bufSize * 2);
        }

        return sDefaultConfig;
    }
}
