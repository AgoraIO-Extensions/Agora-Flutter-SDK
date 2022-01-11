package io.agora.rtc.base

import io.agora.rtc.RtcEngine
import java.util.HashMap

/**
 * The [RtcEngineRegistry] is response to add, remove and notify the callback when [RtcEngine] is created
 * from flutter side.
 */
internal class RtcEngineRegistry private constructor() : RtcEnginePlugin {
  companion object {
    val instance: RtcEngineRegistry by lazy { RtcEngineRegistry() }
  }

  private val plugins: MutableMap<Class<out RtcEnginePlugin>, RtcEnginePlugin> = HashMap()

  /**
   * Add a [RtcEnginePlugin].
   */
  fun add(plugin: RtcEnginePlugin) {
    if (plugins.containsKey(plugin.javaClass)) return
    plugins[plugin.javaClass] = plugin
  }

  /**
   * Remove the previously added [RtcEnginePlugin].
   */
  fun remove(pluginClass: Class<out RtcEnginePlugin>) {
    plugins.remove(pluginClass)
  }

  override fun onRtcEngineCreated(rtcEngine: RtcEngine?) {
    for (plugin in plugins.values) {
      plugin.onRtcEngineCreated(rtcEngine)
    }
  }

  override fun onRtcEngineDestroyed() {
    for (plugin in plugins.values) {
      plugin.onRtcEngineDestroyed()
    }
  }
}
