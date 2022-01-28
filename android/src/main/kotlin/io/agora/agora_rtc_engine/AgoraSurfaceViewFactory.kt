package io.agora.agora_rtc_engine

import android.content.Context
import android.view.View
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.RtcSurfaceView
import io.agora.rtc.base.BanubaRtcSurfaceView
import io.agora.rtc.base.SurfaceViewProtocol
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AgoraSurfaceViewFactory(
  private val messenger: BinaryMessenger,
  private val rtcEnginePlugin: AgoraRtcEnginePlugin,
  private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
    return AgoraSurfaceView(
      context.applicationContext,
      messenger,
      viewId,
      args as? Map<*, *>,
      rtcEnginePlugin,
      rtcChannelPlugin
    )
  }
}

internal class AgoraSurfaceView(
  context: Context,
  messenger: BinaryMessenger,
  viewId: Int,
  args: Map<*, *>?,
  private val rtcEnginePlugin: AgoraRtcEnginePlugin,
  private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformView, MethodChannel.MethodCallHandler {
  private var view : SurfaceViewProtocol? = null
  private val channel = MethodChannel(messenger, "agora_rtc_engine/surface_view_$viewId")

  init {
    // TODO: Depending on UID create either RtcBanubaSurfaceView or RtcSurfaceView
    args?.let { map ->
      val data = map["data"]  as? Map<*, *>
      data?.let {
        view = if (it["uid"] == 0) BanubaRtcSurfaceView(context) else RtcSurfaceView(context)
    } }
    args?.let { map ->
      (map["data"] as? Map<*, *>)?.let { setData(it) }
      (map["renderMode"] as? Number)?.let { setRenderMode(it.toInt()) }
      (map["mirrorMode"] as? Number)?.let { setMirrorMode(it.toInt()) }
      (map["zOrderOnTop"] as? Boolean)?.let { setZOrderOnTop(it) }
      (map["zOrderMediaOverlay"] as? Boolean)?.let { setZOrderMediaOverlay(it) }
    }
    channel.setMethodCallHandler(this)
  }

  override fun getView(): View {
    return view as View
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
    getEngine()?.let { view?.setData(it, channel, (data["uid"] as Number).toInt()) }
  }

  private fun setRenderMode(renderMode: Int) {
    getEngine()?.let { view?.setRenderMode(it, renderMode) }
  }

  private fun setMirrorMode(mirrorMode: Int) {
    getEngine()?.let { view?.setMirrorMode(it, mirrorMode) }
  }

  private fun setZOrderOnTop(onTop: Boolean) {
    view?.setZOrderOnTop(onTop)
  }

  private fun setZOrderMediaOverlay(isMediaOverlay: Boolean) {
    view?.setZOrderMediaOverlay(isMediaOverlay)
  }

  private fun getEngine(): RtcEngine? {
    return rtcEnginePlugin.engine()
  }

  private fun getChannel(channelId: String): RtcChannel? {
    return rtcChannelPlugin.channel(channelId)
  }
}
