package io.agora.agora_rtc_engine

import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import io.agora.iris.rtc.IrisRtcEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

private class ApiTypeChannelCallApiMethodCallHandler(
  irisRtcEngine: IrisRtcEngine
) : CallApiMethodCallHandler(irisRtcEngine) {
  override fun callApi(apiType: Int, params: String?, sb: StringBuffer): Int {
    return irisRtcEngine.channel.callApi(apiType, params, sb)
  }

  override fun callApiWithBuffer(apiType: Int, params: String?, buffer: ByteArray?, sb: StringBuffer): Int {
    return irisRtcEngine.channel.callApi(apiType, params, buffer, sb)
  }
}

/** AgoraRtcChannelPlugin */
class AgoraRtcChannelPlugin(
//  private val rtcEnginePlugin: AgoraRtcEnginePlugin
  private val irisRtcEngine: IrisRtcEngine
) : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var methodChannel: MethodChannel
  private lateinit var eventChannel: EventChannel
  private var eventSink: EventChannel.EventSink? = null
//  private val manager = RtcChannelManager { methodName, data -> emit(methodName, data) }
  private val handler = Handler(Looper.getMainLooper())

  private lateinit var callApiMethodCallHandler: CallApiMethodCallHandler

  fun initPlugin(binaryMessenger: BinaryMessenger) {
    methodChannel = MethodChannel(binaryMessenger, "agora_rtc_channel")
    methodChannel.setMethodCallHandler(this)
    eventChannel = EventChannel(binaryMessenger, "agora_rtc_channel/events")
    eventChannel.setStreamHandler(this)

    callApiMethodCallHandler = ApiTypeChannelCallApiMethodCallHandler(irisRtcEngine)


  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    initPlugin(binding.binaryMessenger)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {

    eventSink = events

    irisRtcEngine.channel.setEventHandler(EventHandler(eventSink))
    Log.e("MainActivity", "channel onListen: $eventSink")
  }

  override fun onCancel(arguments: Any?) {
    irisRtcEngine.channel.setEventHandler(null)
    eventSink = null
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    // Iris supported
    callApiMethodCallHandler.onMethodCall(call, result)
  }
}
