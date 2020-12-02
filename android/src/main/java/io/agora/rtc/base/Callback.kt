package io.agora.rtc.base

import io.agora.rtc.Constants
import io.agora.rtc.RtcEngine
import kotlin.math.abs

abstract class Callback {
  fun code(code: Int?, runnable: ((Int) -> Any?)? = null) {
    if (code == null || code < 0) {
      val newCode = abs(code ?: Constants.ERR_NOT_INITIALIZED)
      failure(newCode.toString(), RtcEngine.getErrorDescription(newCode))
      return
    }

    val res = if (runnable != null) runnable(code) else Unit
    if (res is Unit) {
      success(null)
    } else {
      success(res)
    }
  }

  fun <T> resolve(source: T?, runnable: (T) -> Any?) {
    if (source == null) {
      val code = Constants.ERR_NOT_INITIALIZED
      failure(code.toString(), RtcEngine.getErrorDescription(code))
      return
    }

    val res = runnable(source)
    if (res is Unit) {
      success(null)
    } else {
      success(res)
    }
  }

  abstract fun success(data: Any?)

  abstract fun failure(code: String, message: String)
}
