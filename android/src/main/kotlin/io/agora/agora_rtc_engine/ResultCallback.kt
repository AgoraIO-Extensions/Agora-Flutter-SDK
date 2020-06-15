package io.agora.agora_rtc_engine

import io.agora.rtc.Constants
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.Callback
import io.flutter.plugin.common.MethodChannel.Result

class ResultCallback(
        private val result: Result?
) : Callback<Map<String, Any?>>() {
    fun <E> resolve(e: E?, data: (e: E) -> Any?) {
        if (e != null) {
            try {
                val res = data(e)
                if (res is Unit) {
                    result?.success(null)
                } else {
                    result?.success(res)
                }
            } catch (ex: Exception) {
                result?.error(ex.localizedMessage, null, null)
            }
        } else {
            val code = Constants.ERR_NOT_INITIALIZED
            failure(code.toString(), RtcEngine.getErrorDescription(code))
        }
    }

    override fun success(data: Map<String, Any?>?) {
        result?.success(data)
    }

    override fun failure(code: String, message: String) {
        result?.error(code, message, null)
    }
}
