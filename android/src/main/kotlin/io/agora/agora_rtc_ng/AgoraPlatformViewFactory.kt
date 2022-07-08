package io.agora.agora_rtc_ng

import android.content.Context
import android.util.Log
import android.view.SurfaceView
import android.view.View
import io.agora.iris.IrisApiEngine
import io.flutter.plugin.common.*
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AgoraPlatformViewFactory(
    private val viewType: String,
    private val messenger: BinaryMessenger,
    private val viewProvider: (context: Context) -> View
): PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return AgoraPlatformView(
            context = context,
            viewType = viewType,
            viewId = viewId,
            viewProvider = viewProvider,
            messenger = messenger
        )
    }
}

class AgoraPlatformView(
    context: Context?,
    viewType: String,
    viewId: Int,
    viewProvider: (context: Context) -> View,
    messenger: BinaryMessenger
) : PlatformView, MethodChannel.MethodCallHandler {

    private var innerView: View? = null

    private var methodChannel: MethodChannel =
        MethodChannel(messenger, "agora_rtc_ng/${viewType}_$viewId")

    private var platformViewPtr: Long = 0L

    init {
        methodChannel.setMethodCallHandler(this)
        innerView = context?.let {
            val v = viewProvider(it)

            v
        }

        platformViewPtr = IrisApiEngine.GetJObjectAddress(innerView)
        Log.e("AgoraPlatformView", "presure test native AgoraPlatformView init: $platformViewPtr")
    }

    override fun getView(): View? {
        return innerView
    }

    override fun dispose() {
        Log.e("AgoraPlatformView", "presure test native AgoraPlatformView dispose $platformViewPtr")
//        methodChannel.setMethodCallHandler(null)

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "getNativeViewPtr") {
            Log.e("AgoraPlatformView", "presure test native AgoraPlatformView onMethodCall: $platformViewPtr")
            result.success(platformViewPtr)
        } else if (call.method == "deleteNativeViewPtr") {
            if (platformViewPtr != 0L) {
                IrisApiEngine.FreeJObjectByAddress(platformViewPtr)
                platformViewPtr = 0;
            }
            innerView = null
            result.success(0);
        }
    }

}