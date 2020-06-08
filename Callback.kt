package io.agora.rtc.base

import io.agora.rtc.Constants
import io.agora.rtc.RtcEngine
import kotlin.math.abs

abstract class Callback<T> {
    fun code(code: Int?) {
        val newCode = code ?: Constants.ERR_NOT_INITIALIZED
        if (newCode == 0) {
            success(null)
        } else if (newCode < 0) {
            failure(newCode.toString(), RtcEngine.getErrorDescription(abs(newCode)))
        }
    }

    abstract fun success(data: T?)

    abstract fun failure(code: String, message: String)
}
