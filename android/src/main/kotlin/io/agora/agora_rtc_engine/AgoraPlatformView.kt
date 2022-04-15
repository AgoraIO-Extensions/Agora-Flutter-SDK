package io.agora.agora_rtc_engine

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import io.agora.iris.rtc.IrisRtcEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.ErrorLogResult
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

private class PlatformViewApiTypeCallApiMethodCallHandler(
  irisRtcEngine: IrisRtcEngine,
  private val platformView: AgoraPlatformView
) : CallApiMethodCallHandler(irisRtcEngine) {
  override fun callApi(apiType: Int, params: String?, sb: StringBuffer): Int {
    platformView.updateView()
    return irisRtcEngine.callApi(apiType, params, platformView.getIrisRenderView(), sb)
  }
}

// We should ensure not doing some leak in constructor
@Suppress("LeakingThis")
abstract class AgoraPlatformView(
  private val context: Context,
  messenger: BinaryMessenger,
  viewId: Int,
  args: Map<*, *>?,
  private val irisRtcEngine: IrisRtcEngine
) : PlatformView, MethodChannel.MethodCallHandler {

  private val parentView: FrameLayout = FrameLayout(context)

  private var platformView: View

  private val channel: MethodChannel

  private val callApiMethodCallHandler: CallApiMethodCallHandler =
    PlatformViewApiTypeCallApiMethodCallHandler(irisRtcEngine, this)

  init {
    platformView = createView(context.applicationContext)
    parentView.addView(platformView)

    channel = MethodChannel(messenger, "${channelName}_$viewId")
    channel.setMethodCallHandler(this)

    args?.apply {
      for ((key, value) in entries) {
        onMethodCall(MethodCall(key as String, value), ErrorLogResult(""))
      }
    }
  }

  fun updateView() {
    parentView.removeAllViews()
    platformView = createView(context.applicationContext)
    parentView.addView(platformView)
  }

  abstract fun createView(context: Context): View

  protected abstract val channelName: String

  fun getIrisRenderView(): View {
    return platformView
  }

  override fun getView(): View {
    return parentView
  }

  override fun dispose() {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    callApiMethodCallHandler.onMethodCall(call, result)
  }
}
