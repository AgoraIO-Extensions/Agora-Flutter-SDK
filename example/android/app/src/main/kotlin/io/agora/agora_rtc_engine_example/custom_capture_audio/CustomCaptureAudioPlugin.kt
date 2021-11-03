package io.agora.agora_rtc_engine_example.custom_capture_audio

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioFormat
import io.agora.rtc.Constants
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.RtcEnginePlugin
import java.lang.ref.WeakReference

class CustomCaptureAudioPlugin(private val activity: WeakReference<Activity>) :
  RtcEnginePlugin,
  CustomCaptureAudio.CustomCaptureAudioApi {

  private var rtcEngine: RtcEngine? = null

  @Volatile
  private var sourcePos: Int = Constants.AudioExternalSourcePos.getValue(
    Constants.AudioExternalSourcePos.AUDIO_EXTERNAL_PLAYOUT_SOURCE)

  private val broadcastReceiver = object : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
      intent?.apply {
        val buffer = getByteArrayExtra("buffer")
        val sampleRate = getIntExtra("sampleRate", -1)
        val channels = getIntExtra("channels", -1)

        rtcEngine?.pushExternalAudioFrame(
          buffer,
          System.currentTimeMillis(),
          sampleRate,
          channels,
          AudioFormat.ENCODING_PCM_16BIT,
          sourcePos)
      }
    }
  }

  override fun onRtcEngineCreated(rtcEngine: RtcEngine?) {
    this.rtcEngine = rtcEngine
    activity.get()?.registerReceiver(broadcastReceiver, IntentFilter("AudioRecordRead"))
  }

  override fun onRtcEngineDestroyed() {
    activity.get()?.unregisterReceiver(broadcastReceiver)
    rtcEngine = null
  }

  override fun setExternalAudioSource(enabled: Boolean?, sampleRate: Long?, channels: Long?) {
    rtcEngine?.setExternalAudioSource(enabled!!, sampleRate!!.toInt(), channels!!.toInt())
  }

  override fun setExternalAudioSourceVolume(sourcePos: Long?, volume: Long?) {
    this.sourcePos = sourcePos!!.toInt()
    rtcEngine?.setExternalAudioSourceVolume(this.sourcePos, volume!!.toInt())
  }

  override fun startAudioRecord(sampleRate: Long?, channels: Long?) {
    activity.get()?.apply {
      AudioRecordService.start(this, this::class.java, sampleRate!!.toInt(), channels!!.toInt())
    }
  }

  override fun stopAudioRecord() {
    activity.get()?.apply {
      val intent = Intent(this, AudioRecordService::class.java)
      stopService(intent)
    }
  }
}
