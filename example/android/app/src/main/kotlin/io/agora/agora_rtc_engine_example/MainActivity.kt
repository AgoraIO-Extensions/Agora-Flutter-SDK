package io.agora.agora_rtc_engine_example

import android.os.Bundle
import io.agora.agora_rtc_engine_example.custom_audio_source.CustomAudioPlugin
import io.agora.agora_rtc_engine_example.custom_audio_source.CustomAudioSource
import io.agora.rtc.base.RtcEnginePlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import java.lang.ref.WeakReference

class MainActivity: FlutterActivity() {

  private val customAudioPlugin = CustomAudioPlugin(WeakReference(this))

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    RtcEnginePlugin.register(customAudioPlugin)
  }

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    CustomAudioSource.CustomAudioSourceApi.setup(flutterEngine.dartExecutor, customAudioPlugin)
  }

  override fun onDestroy() {
    super.onDestroy()

    RtcEnginePlugin.unregister(customAudioPlugin)
  }
}
