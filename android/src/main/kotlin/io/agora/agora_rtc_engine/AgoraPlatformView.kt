package io.agora.agora_rtc_engine

import android.content.Context
import android.util.Log
import android.view.View
import io.agora.iris.rtc.IrisRtcEngine
import io.agora.iris.rtc.base.ApiTypeEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.ErrorLogResult
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

private class PlatformViewApiTypeCallApiMethodCallHandler(
  irisRtcEngine: IrisRtcEngine,
  private val platformView: PlatformView
) : CallApiMethodCallHandler(irisRtcEngine) {
  override fun callApi(apiType: Int, params: String?, sb: StringBuffer): Int {
    val ret = irisRtcEngine.callApi(ApiTypeEngine.fromInt(apiType), params, platformView.view, sb)
    Log.e("TextureView", "callApi apiType: $apiType, params: $params, res: ${sb.toString()}, ret: $ret, platformView: ${platformView.view}")
    return ret
  }
}

// We should ensure not doing some leak in constructor
@Suppress("LeakingThis")
abstract class AgoraPlatformView(
  context: Context,
  messenger: BinaryMessenger,
  viewId: Int,
  args: Map<*, *>?,
  private val irisRtcEngine: IrisRtcEngine
) : PlatformView, MethodChannel.MethodCallHandler {

  private val platformView: View

  private val channel: MethodChannel

  private val callApiMethodCallHandler: CallApiMethodCallHandler =
    PlatformViewApiTypeCallApiMethodCallHandler(irisRtcEngine, this)

  init {
    platformView = createView(context)
    channel = MethodChannel(messenger, "${channelName}_$viewId")
    channel.setMethodCallHandler(this)

    args?.apply {
      for ((key, value) in entries) {
        onMethodCall(MethodCall(key as String, value), ErrorLogResult(""))
      }
    }
  }

  abstract fun createView(context: Context): View

  protected abstract val channelName: String

  override fun getView(): View {
    return platformView
  }

  override fun dispose() {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    callApiMethodCallHandler.onMethodCall(call, result)
  }
}
