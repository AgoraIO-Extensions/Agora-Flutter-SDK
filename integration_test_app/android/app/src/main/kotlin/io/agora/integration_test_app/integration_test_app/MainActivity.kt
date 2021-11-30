package io.agora.integration_test_app.integration_test_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    TestRtcEnginePluginMethodChannel().setUp(flutterEngine.dartExecutor)
  }
}
