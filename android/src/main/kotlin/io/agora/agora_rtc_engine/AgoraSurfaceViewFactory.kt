package io.agora.agora_rtc_engine

import android.content.Context
import android.view.SurfaceView
import android.view.View
import android.widget.FrameLayout
import io.agora.iris.rtc.IrisRtcEngine
import io.agora.rtc.RtcEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AgoraSurfaceViewFactory(
  private val messenger: BinaryMessenger,
private val irisRtcEngine: IrisRtcEngine
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
    return AgoraPlatformViewSurface(
      context.applicationContext,
      messenger,
      viewId,
      args as? Map<*, *>,
      irisRtcEngine
    )
  }
}

class AgoraPlatformViewSurface(
  context: Context,
  messenger: BinaryMessenger,
  viewId: Int, args: Map<*, *>?,
  irisRtcEngine: IrisRtcEngine
) : AgoraPlatformView(context, messenger, viewId, args, irisRtcEngine) {
  override fun createView(context: Context): View {
    return RtcEngine.CreateRendererView(context)
  }

  override val channelName: String
    get() = "agora_rtc_engine/surface_view"

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "setZOrderOnTop" -> {
        val surfaceView = getIrisRenderView() as SurfaceView
        val parentView = view as FrameLayout
        parentView.removeView(surfaceView)
        surfaceView.setZOrderOnTop((call.argument<Boolean>("onTop"))!!)
        parentView.addView(surfaceView)
        result.success(null)
      }
      "setZOrderMediaOverlay" -> {
        val surfaceView = getIrisRenderView() as SurfaceView
        val parentView = view as FrameLayout
        parentView.removeView(surfaceView)
        surfaceView.setZOrderMediaOverlay((call.argument<Boolean>("isMediaOverlay"))!!)
        parentView.addView(surfaceView)
        result.success(null)
      }
      else -> {
        super.onMethodCall(call, result)
      }
    }
  }
}
