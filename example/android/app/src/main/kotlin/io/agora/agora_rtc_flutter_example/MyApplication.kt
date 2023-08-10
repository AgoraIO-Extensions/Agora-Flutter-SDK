package io.agora.agora_rtc_ng_example

import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine

class MyApplication : FlutterApplication() {
    private var flutterEngine: FlutterEngine? = null

    fun getFlutterEngine(): FlutterEngine {
        return flutterEngine ?: FlutterEngine(this).also { flutterEngine = it }
    }

    fun destroyFlutterEngine() {
        flutterEngine?.destroy()
        flutterEngine = null
    }
}