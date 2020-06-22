package io.agora.agora_rtc_engine

import android.content.Context
import android.view.View
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.RtcSurfaceView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

class AgoraSurfaceViewFactory(
        private val messenger: BinaryMessenger,
        private val rtcEnginePlugin: AgoraRtcEnginePlugin,
        private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return AgoraSurfaceView(context, messenger, viewId, rtcEnginePlugin, rtcChannelPlugin)
    }
}

class AgoraSurfaceView(
        context: Context,
        messenger: BinaryMessenger,
        viewId: Int,
        private val rtcEnginePlugin: AgoraRtcEnginePlugin,
        private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformView, MethodChannel.MethodCallHandler {
    private val view = RtcSurfaceView(context)
    private val channel = MethodChannel(messenger, "agora_rtc_engine/surface_view_$viewId")

    init {
        channel.setMethodCallHandler(this)
    }

    override fun getView(): View {
        return view
    }

    override fun dispose() {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        this::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                val parameters = mutableListOf<Any?>()
                function.parameters.forEach { parameter ->
                    val map = call.arguments<Map<*, *>>()
                    if (map.containsKey(parameter.name)) {
                        parameters.add(map[parameter.name])
                    }
                }
                try {
                    method.invoke(this, *parameters.toTypedArray())
                    return@onMethodCall
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        result.notImplemented()
    }

    fun setZOrderMediaOverlay(isMediaOverlay: Boolean) {
        view.setZOrderMediaOverlay(isMediaOverlay)
    }

    fun setZOrderOnTop(onTop: Boolean) {
        view.setZOrderOnTop(onTop)
    }

    fun setRenderMode(renderMode: Int) {
        getEngine()?.let { view.setRenderMode(it, renderMode) }
    }

    fun setChannelId(channelId: String) {
        getEngine()?.let { view.setChannel(it, getChannel(channelId)) }
    }

    fun setMirrorMode(mirrorMode: Int) {
        getEngine()?.let { view.setMirrorMode(it, mirrorMode) }
    }

    fun setUid(uid: Int) {
        getEngine()?.let { view.setUid(it, uid) }
    }

    private fun getEngine(): RtcEngine? {
        return rtcEnginePlugin.engine()
    }

    private fun getChannel(channelId: String): RtcChannel? {
        return rtcChannelPlugin.channel(channelId)
    }
}
