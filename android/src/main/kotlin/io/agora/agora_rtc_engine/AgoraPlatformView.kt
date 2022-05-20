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
    return platformView.getIrisRenderView()?.let {
      irisRtcEngine.callApi(apiType, params, platformView.getIrisRenderView(), sb)
    } ?: -1
  }
}

// We should ensure not doing some leak in constructor
@Suppress("LeakingThis")
abstract class AgoraPlatformView(
  private val context: Context?,
  messenger: BinaryMessenger,
  viewId: Int,
  args: Map<*, *>?,
  irisRtcEngine: IrisRtcEngine
) : PlatformView, MethodChannel.MethodCallHandler {

  private var parentView: FrameLayout? = null

  private var platformView: View? = null

  private var channel: MethodChannel? = null

  private var callApiMethodCallHandler: CallApiMethodCallHandler? = null

  init {
    parentView = context?.let { FrameLayout(context) }
    platformView = createView(context)
    parentView?.addView(platformView)

    channel = MethodChannel(messenger, "${channelName}_$viewId")
    channel?.setMethodCallHandler(this)

    callApiMethodCallHandler = PlatformViewApiTypeCallApiMethodCallHandler(irisRtcEngine, this)

    args?.apply {
      for ((key, value) in entries) {
        onMethodCall(MethodCall(key as String, value), ErrorLogResult(""))
      }
    }
  }

  fun updateView() {
    parentView?.removeAllViews()
    platformView = createView(context)
    parentView?.addView(platformView)
  }

  abstract fun createView(context: Context?): View?

  protected abstract val channelName: String

  fun getIrisRenderView(): View? {
    return platformView
  }

  override fun getView(): View? {
    return parentView
  }

  override fun dispose() {
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    callApiMethodCallHandler?.onMethodCall(call, result)
  }
}
