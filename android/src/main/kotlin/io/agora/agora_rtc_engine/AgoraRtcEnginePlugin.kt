package io.agora.agora_rtc_engine

import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.RtcEngineManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.platform.PlatformViewRegistry
import kotlin.reflect.full.declaredMemberFunctions
import kotlin.reflect.jvm.javaMethod

/** AgoraRtcEnginePlugin */
class AgoraRtcEnginePlugin : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private lateinit var applicationContext: Context
    private var eventSink: EventChannel.EventSink? = null
    private val manager = RtcEngineManager { methodName, data -> emit(methodName, data) }
    private val handler = Handler(Looper.getMainLooper())
    private val rtcChannelPlugin = AgoraRtcChannelPlugin(this)

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            AgoraRtcEnginePlugin().apply {
                initPlugin(registrar.context(), registrar.messenger(), registrar.platformViewRegistry())
                rtcChannelPlugin.initPlugin(registrar.messenger())
            }
        }
    }

    private fun initPlugin(context: Context, binaryMessenger: BinaryMessenger, platformViewRegistry: PlatformViewRegistry) {
        applicationContext = context.applicationContext
        methodChannel = MethodChannel(binaryMessenger, "agora_rtc_engine")
        methodChannel.setMethodCallHandler(this)
        eventChannel = EventChannel(binaryMessenger, "agora_rtc_engine/events")
        eventChannel.setStreamHandler(this)

        platformViewRegistry.registerViewFactory("AgoraSurfaceView", AgoraSurfaceViewFactory(binaryMessenger, this, rtcChannelPlugin))
        platformViewRegistry.registerViewFactory("AgoraTextureView", AgoraTextureViewFactory(binaryMessenger, this, rtcChannelPlugin))
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        rtcChannelPlugin.onAttachedToEngine(binding)
        initPlugin(binding.applicationContext, binding.binaryMessenger, binding.platformViewRegistry)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        rtcChannelPlugin.onDetachedFromEngine(binding)
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        manager.release()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    private fun emit(methodName: String, data: Map<String, Any?>?) {
        handler.post {
            val event: MutableMap<String, Any?> = mutableMapOf("methodName" to methodName)
            data?.let { event.putAll(it) }
            eventSink?.success(event)
        }
    }

    fun engine(): RtcEngine? {
        return manager.engine
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        manager::class.declaredMemberFunctions.find { it.name == call.method }?.let { function ->
            function.javaMethod?.let { method ->
                try {
                    val parameters = mutableListOf<Any?>()
                    call.arguments<Map<*, *>>()?.toMutableMap()?.let {
                        if (call.method == "create") {
                            it["context"] = applicationContext
                        }
                        parameters.add(it)
                    }
                    method.invoke(manager, *parameters.toTypedArray(), ResultCallback(result))
                    return@onMethodCall
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
        result.notImplemented()
    }
}
