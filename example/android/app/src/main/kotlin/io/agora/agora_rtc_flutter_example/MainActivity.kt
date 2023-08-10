package io.agora.agora_rtc_ng_example

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var methodChannel: MethodChannel

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
    }

    override fun detachFromFlutterEngine() {
        super.detachFromFlutterEngine()

        methodChannel.setMethodCallHandler(null)
    }
}
