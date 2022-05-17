package io.agora.agora_rtc_engine

import android.content.Context
import android.view.View
import io.agora.iris.rtc.IrisRtcEngine
import io.agora.rtc.RtcEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AgoraTextureViewFactory(
  private val messenger: BinaryMessenger,
  private val irisRtcEngine: IrisRtcEngine
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

  override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
    return AgoraPlatformViewTexture(
      context,
      messenger,
      viewId,
      args as? Map<*, *>,
      irisRtcEngine
    )
  }
}

class AgoraPlatformViewTexture(
  context: Context?,
  messenger: BinaryMessenger,
  viewId: Int, args: Map<*, *>?,
  irisRtcEngine: IrisRtcEngine
) : AgoraPlatformView(context, messenger, viewId, args, irisRtcEngine) {
  override fun createView(context: Context?): View? {
    return context?.let { RtcEngine.CreateTextureView(context) }
  }

  override val channelName: String
    get() = "agora_rtc_engine/texture_view"
}
