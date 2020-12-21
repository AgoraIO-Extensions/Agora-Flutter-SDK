package io.agora.agora_rtc_engine

import io.agora.rtc.base.Callback
import io.flutter.plugin.common.MethodChannel.Result

class ResultCallback(
  private val result: Result?
) : Callback() {
  override fun success(data: Any?) {
    result?.success(data)
  }

  override fun failure(code: String, message: String) {
    result?.error(code, message, null)
  }
}
