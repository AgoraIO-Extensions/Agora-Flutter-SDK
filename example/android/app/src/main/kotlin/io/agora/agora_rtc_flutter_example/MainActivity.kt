package io.agora.agora_rtc_ng_example

import android.content.Context
import android.os.Bundle
import android.util.Log
import io.agora.agora_rtc_flutter_example.VideoRawDataController
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var methodChannel: MethodChannel
    private lateinit var sharedNativeHandleMethodChannel: MethodChannel
    private var videoRawDataController: VideoRawDataController? = null

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return (context.applicationContext as MyApplication).getFlutterEngine()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor, "agora_rtc_ng_example/foreground_service")
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "start_foreground_service" -> {
                    ExampleService.startDaemonService(MainActivity@this.applicationContext)
                    result.success(true)
                }
                "stop_foreground_service" -> {
                    ExampleService.stopDaemonService(MainActivity@this.applicationContext)
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        sharedNativeHandleMethodChannel = MethodChannel(flutterEngine.dartExecutor, "agora_rtc_engine_example/shared_native_handle")
        sharedNativeHandleMethodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "native_init" -> {
                    var nativeHandle = 0L
                    call.argument<String>("appId")?.apply {
                        videoRawDataController = VideoRawDataController(this@MainActivity,this)
                        nativeHandle = videoRawDataController!!.nativeHandle()
                    }

                    result.success(nativeHandle)
                }
                "native_dispose" -> {
                    videoRawDataController?.dispose()
                    videoRawDataController = null
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun detachFromFlutterEngine() {
        super.detachFromFlutterEngine()

        videoRawDataController?.dispose()
        videoRawDataController = null
        methodChannel.setMethodCallHandler(null)
        sharedNativeHandleMethodChannel.setMethodCallHandler(null)
    }
}
