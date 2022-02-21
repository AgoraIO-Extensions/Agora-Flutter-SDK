package io.agora.integration_test_app.integration_test_app

import io.agora.rtc.RtcEngine
import io.agora.rtc.base.RtcEnginePlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TestRtcEnginePluginMethodChannel : MethodChannel.MethodCallHandler {

  private var currentRtcEnginePlugin: TestRtcEnginePlugin? = null

  fun setUp(binaryMessenger: BinaryMessenger) {
    MethodChannel(binaryMessenger, "agora_rtc_engine/integration_test/rtc_engine_plugin").apply {
      setMethodCallHandler(this@TestRtcEnginePluginMethodChannel)
    }
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "registerRtcEnginePlugin" -> {
        currentRtcEnginePlugin = TestRtcEnginePlugin()
        RtcEnginePlugin.register(currentRtcEnginePlugin!!)
        result.success(true)
      }
      "unregisterRtcEnginePlugin" -> {
        RtcEnginePlugin.unregister(currentRtcEnginePlugin!!)
        result.success(true)
      }
      "isRtcEngineCreated" -> {
        result.success(currentRtcEnginePlugin?.isRtcEngineCreated)
      }
      "isRtcEngineDestroyed" -> {
        result.success(currentRtcEnginePlugin?.isRtcEngineDestroyed)
      }
      "getRtcEngineNativeHandleFromPlugin" -> {
        result.success(currentRtcEnginePlugin?.rtcEngine?.nativeHandle)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

}

class TestRtcEnginePlugin : RtcEnginePlugin {

  var isRtcEngineCreated: Boolean = false
  var isRtcEngineDestroyed: Boolean = false
  var rtcEngine: RtcEngine? = null

  override fun onRtcEngineCreated(rtcEngine: RtcEngine?) {
    isRtcEngineCreated = true
    isRtcEngineDestroyed = false
    this.rtcEngine = rtcEngine
  }

  override fun onRtcEngineDestroyed() {
    isRtcEngineCreated = false
    isRtcEngineDestroyed = true
  }
}
