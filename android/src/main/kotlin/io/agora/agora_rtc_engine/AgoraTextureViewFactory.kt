package io.agora.agora_rtc_engine

import android.content.Context
import android.view.View
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.RtcTextureView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AgoraTextureViewFactory(
  private val messenger: BinaryMessenger,
  private val rtcEnginePlugin: AgoraRtcEnginePlugin,
  private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
    return AgoraTextureView(
      context.applicationContext,
      messenger,
      viewId,
      args as? Map<*, *>,
      rtcEnginePlugin,
      rtcChannelPlugin
    )
  }
}

class AgoraTextureView(
  context: Context,
  messenger: BinaryMessenger,
  viewId: Int,
  args: Map<*, *>?,
  private val rtcEnginePlugin: AgoraRtcEnginePlugin,
  private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformView, MethodChannel.MethodCallHandler {
  private val view = RtcTextureView(context)
  private val channel = MethodChannel(messenger, "agora_rtc_engine/texture_view_$viewId")

  init {
    args?.let { map ->
      (map["data"] as? Map<*, *>)?.let { setData(it) }
      (map["renderMode"] as? Number)?.let { setRenderMode(it.toInt()) }
      (map["mirrorMode"] as? Number)?.let { setMirrorMode(it.toInt()) }
    }
    channel.setMethodCallHandler(this)
  }

  override fun getView(): View {
    return view
  }

  override fun dispose() {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    this.javaClass.declaredMethods.find { it.name == call.method }?.let { function ->
      function.let { method ->
        val parameters = mutableListOf<Any?>()
        call.arguments<Map<*, *>>()?.let { args ->
          args.values.forEach {
            parameters.add(it)
          }
        }
        try {
          method.invoke(this, *parameters.toTypedArray())
          result.success(null)
          return@onMethodCall
        } catch (e: Exception) {
          e.printStackTrace()
          result.error(e.toString(), null, null)
        }
      }
    }
    result.notImplemented()
  }

  private fun setData(data: Map<*, *>) {
    val channel = (data["channelId"] as? String)?.let { getChannel(it) }
    getEngine()?.let { view.setData(it, channel, (data["uid"] as Number).toInt()) }
  }

  private fun setRenderMode(renderMode: Int) {
    getEngine()?.let { view.setRenderMode(it, renderMode) }
  }

  private fun setMirrorMode(mirrorMode: Int) {
    getEngine()?.let { view.setMirrorMode(it, mirrorMode) }
  }

  private fun getEngine(): RtcEngine? {
    return rtcEnginePlugin.engine()
  }

  private fun getChannel(channelId: String): RtcChannel? {
    return rtcChannelPlugin.channel(channelId)
  }
}
