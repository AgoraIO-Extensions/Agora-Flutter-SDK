package io.agora.agora_rtc_ng

import android.view.TextureView
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.ref.WeakReference

/** AgoraRtcNgPlugin */
class AgoraRtcNgPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var flutterPluginBindingRef: WeakReference<FlutterPlugin.FlutterPluginBinding>

  private lateinit var videoViewController: VideoViewController

  companion object {
    init {
        System.loadLibrary("AgoraRtcWrapper")
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "agora_rtc_ng")
    channel.setMethodCallHandler(this)
    flutterPluginBindingRef = WeakReference(flutterPluginBinding)

    flutterPluginBinding.platformViewRegistry.registerViewFactory(
      "AgoraTextureView",
      AgoraPlatformViewFactory(
        "AgoraTextureView",
        flutterPluginBinding.binaryMessenger) {
          TextureView(it)
      })

    flutterPluginBinding.platformViewRegistry.registerViewFactory(
      "AgoraSurfaceView",
      AgoraPlatformViewFactory(
        "AgoraSurfaceView",
        flutterPluginBinding.binaryMessenger) {
        TextureView(it)
      })

    videoViewController = VideoViewController(flutterPluginBinding.binaryMessenger)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getAssetAbsolutePath" -> {
        getAssetAbsolutePath(call, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    videoViewController.dispose()
  }

  private fun getAssetAbsolutePath(call: MethodCall, result: Result) {
    call.arguments<String>()?.let {
      val assetKey = flutterPluginBindingRef.get()?.flutterAssets?.getAssetFilePathByName(it)
      try {
        assetKey?.apply {
          flutterPluginBindingRef.get()?.applicationContext?.assets?.openFd(this)?.close()
          result.success("/assets/$assetKey")
          return@getAssetAbsolutePath
        }

        result.success(null)
      } catch (e: Exception) {
        result.error(e.javaClass.simpleName, e.message, e.cause)
      }
      return@getAssetAbsolutePath
    }
    result.error(IllegalArgumentException::class.simpleName ?: "IllegalArgumentException", "The parameter should not be null", null)
  }
}
