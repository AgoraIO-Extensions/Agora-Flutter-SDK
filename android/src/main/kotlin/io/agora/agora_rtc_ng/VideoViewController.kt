package io.agora.agora_rtc_ng
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class VideoViewController(
    binaryMessenger: BinaryMessenger
) : MethodChannel.MethodCallHandler {

    private val methodChannel = MethodChannel(binaryMessenger, "agora_rtc_ng/video_view_controller").apply {
        setMethodCallHandler(this@VideoViewController)
    }

    init {

    }

    private fun createPlatformRender(): Long {

        return 0L
    }

    private fun destroyPlatformRender(platformRenderId: Long): Boolean {
        return true
    }

    private fun createTextureRender(): Long {
        return 0L
    }

    private fun destroyTextureRender(textureId: Long): Boolean {
        return false
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "attachVideoFrameBufferManager" -> {
                result.success(true)
            }
            "detachVideoFrameBufferManager" -> {
                result.success(true)
            }
            "createTextureRender" -> {
                result.notImplemented()
            }
            "destroyTextureRender" -> {
                result.notImplemented()
            }
            "updateTextureRenderData" -> {
                result.notImplemented()
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }
}