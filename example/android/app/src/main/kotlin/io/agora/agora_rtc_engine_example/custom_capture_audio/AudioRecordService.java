package io.agora.agora_rtc_engine_example.custom_capture_audio;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.media.AudioFormat;
import android.media.AudioRecord;
import android.media.MediaRecorder;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;


public class AudioRecordService extends Service
{
    private static final String TAG = AudioRecordService.class.getSimpleName();

  private volatile boolean stopped;
    private int mSampleRate;
    private int mChannels;

    public static void start(
      Context context,
      Class<?> notificationActivity,
      int sampleRate,
      int channels
    ) {
      Intent intent = new Intent(context, AudioRecordService.class);
      intent.putExtra("notificationActivity", notificationActivity);
      intent.putExtra("sampleRate", sampleRate);
      intent.putExtra("channels", channels);
      context.startService(intent);
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent)
    {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        mSampleRate = intent.getIntExtra("sampleRate", -1);
        mChannels = intent.getIntExtra("channels", -1);
        startForeground((Class<?>) intent.getSerializableExtra("notificationActivity"));
        startRecording();
        return Service.START_STICKY;
    }

    private void startForeground(Class<?> clazz)
    {
        createNotificationChannel();
        Intent notificationIntent = new Intent(this, clazz);
        PendingIntent pendingIntent = PendingIntent.getActivity(this,
                0, notificationIntent, 0);

        Notification notification = new NotificationCompat.Builder(this, TAG)
                .setContentTitle(TAG)
                .setContentIntent(pendingIntent)
                .build();

        startForeground(1, notification);
    }

    private void createNotificationChannel()
    {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
        {
            NotificationChannel serviceChannel = new NotificationChannel(
                    TAG, TAG, NotificationManager.IMPORTANCE_DEFAULT
            );

            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(serviceChannel);
        }
    }

    private void startRecording() {
      RecordThread thread = new RecordThread();
      thread.start();
    }

    private void stopRecording()
    {
        stopped = true;
    }

    @Override
    public void onDestroy()
    {
        stopRecording();
        super.onDestroy();
    }

    private void sendData(byte[] buffer) {
      Intent intent = new Intent("AudioRecordRead");
      intent.putExtra("buffer", buffer);
      intent.putExtra("sampleRate", mSampleRate);
      intent.putExtra("channels", mChannels);
      sendBroadcast(intent);
    }

    public class RecordThread extends Thread
    {
        private final AudioRecord audioRecord;
        private static final int DEFAULT_CHANNEL_CONFIG = AudioFormat.CHANNEL_IN_MONO;
        private byte[] buffer;

        RecordThread()
        {
            int bufferSize = AudioRecord.getMinBufferSize(mSampleRate, DEFAULT_CHANNEL_CONFIG,
                    AudioFormat.ENCODING_PCM_16BIT);
            audioRecord = new AudioRecord(
              MediaRecorder.AudioSource.MIC,
              mSampleRate,
              mChannels,
              AudioFormat.ENCODING_PCM_16BIT, bufferSize);

            buffer = new byte[bufferSize];
        }

        @Override
        public void run()
        {
            try
            {
                audioRecord.startRecording();
                while (!stopped)
                {
                    int result = audioRecord.read(buffer, 0, buffer.length);
                    if (result >= 0)
                    {
                        /**Pushes the external audio frame to the Agora SDK for encoding.
                         * @param data External audio data to be pushed.
                         * @param timeStamp Timestamp of the external audio frame. It is mandatory.
                         *                  You can use this parameter for the following purposes:
                         *                    1:Restore the order of the captured audio frame.
                         *                    2:Synchronize audio and video frames in video-related
                         *                      scenarios, including scenarios where external video sources are used.
                         * @return
                         *   0: Success.
                         *   < 0: Failure.*/
                      sendData(buffer);
                    }
                    else
                    {
                        logRecordError(result);
                    }
                    Log.d(TAG, "byte size is :" + result);
                }
                release();
            }
            catch (Exception e)
            {e.printStackTrace();}
        }

        private void logRecordError(int error)
        {
            String message = "";
            switch (error)
            {
                case AudioRecord.ERROR:
                    message = "generic operation failure";
                    break;
                case AudioRecord.ERROR_BAD_VALUE:
                    message = "failure due to the use of an invalid value";
                    break;
                case AudioRecord.ERROR_DEAD_OBJECT:
                    message = "object is no longer valid and needs to be recreated";
                    break;
                case AudioRecord.ERROR_INVALID_OPERATION:
                    message = "failure due to the improper use of method";
                    break;
            }
            Log.e(TAG, message);
        }

        private void release()
        {
            if (audioRecord != null)
            {
                audioRecord.stop();
                buffer = null;
            }
        }
    }
}
