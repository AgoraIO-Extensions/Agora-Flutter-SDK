package io.agora.agora_rtc_engine

import android.content.Context
import android.view.View
import io.agora.rtc.Constants
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.RtcTextureView
import io.agora.rtc.mediaio.BaseVideoRenderer
import io.agora.rtc.mediaio.IVideoSink
import io.agora.rtc.mediaio.MediaIO
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.view.TextureRegistry
import java.nio.ByteBuffer

class TextureRender(
  textureRegistry: TextureRegistry,
  messenger: BinaryMessenger,
  private val rtcEnginePlugin: AgoraRtcEnginePlugin,
  private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : IVideoSink, MethodChannel.MethodCallHandler {
  companion object {
    private val TAG = TextureRender::class.java.simpleName
  }

  private val render: BaseVideoRenderer = BaseVideoRenderer(TAG)
  private val entry = textureRegistry.createSurfaceTexture()
  private val channel = MethodChannel(messenger, "agora_rtc_engine/texture_render_${entry.id()}")
  private var textureWidth = 0
  private var textureHeight = 0

  init {
    render.setRenderSurface(entry.surfaceTexture())
    render.setBufferType(MediaIO.BufferType.BYTE_BUFFER)
    render.setPixelFormat(MediaIO.PixelFormat.I420)
    channel.setMethodCallHandler(this)
  }

  fun release() {
    entry.release()
    channel.setMethodCallHandler(null)
  }

  fun getId(): Long {
    return entry.id()
  }

  override fun onInitialize(): Boolean {
    render.init(null)
    return true
  }

  override fun onStart(): Boolean {
    return render.start()
  }

  override fun onStop() {
    render.stop()
  }

  override fun onDispose() {
    render.release()
  }

  override fun getEGLContextHandle(): Long {
    return render.eglContextHandle
  }

  override fun getBufferType(): Int {
    return render.bufferType
  }

  override fun getPixelFormat(): Int {
    return render.pixelFormat
  }

  override fun consumeByteBufferFrame(buffer: ByteBuffer?, format: Int, width: Int, height: Int, rotation: Int, timestamp: Long) {
    updateTextureSize(width, height)
    render.consume(buffer, format, width, height, rotation, timestamp)
  }

  override fun consumeByteArrayFrame(data: ByteArray?, format: Int, width: Int, height: Int, rotation: Int, timestamp: Long) {
    updateTextureSize(width, height)
    render.consume(data, format, width, height, rotation, timestamp)
  }

  override fun consumeTextureFrame(textureId: Int, format: Int, width: Int, height: Int, rotation: Int, timestamp: Long, matrix: FloatArray?) {
    updateTextureSize(width, height)
    render.consume(textureId, format, width, height, rotation, timestamp, matrix)
  }

  private fun updateTextureSize(width: Int, height: Int) {
    if (textureWidth != width || textureHeight != height) {
      entry.surfaceTexture().setDefaultBufferSize(width, height)
      textureWidth = width
      textureHeight = height
    }
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    this.javaClass.declaredMethods.find { it.name == call.method }?.let { function ->
      function.let { method ->
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

  private fun setData(data: Map<*, *>) {
    val uid = (data["uid"] as Number).toInt()
    val channel = (data["channelId"] as? String)?.let { getChannel(it) }
    if (uid == 0) {
      getEngine()?.setLocalVideoRenderer(this)
      getEngine()?.setLocalRenderMode(Constants.RENDER_MODE_FIT, Constants.VIDEO_MIRROR_MODE_ENABLED)
    } else {
      channel?.let {
        it.setRemoteVideoRenderer(uid, this)
        return@setData
      }
      getEngine()?.setRemoteVideoRenderer(uid, this)
    }
  }

  private fun getEngine(): RtcEngine? {
    return rtcEnginePlugin.engine()
  }

  private fun getChannel(channelId: String): RtcChannel? {
    return rtcChannelPlugin.channel(channelId)
  }
}

class AgoraTextureViewFactory(
  private val messenger: BinaryMessenger,
  private val rtcEnginePlugin: AgoraRtcEnginePlugin,
  private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  companion object {
    private val renders = mutableMapOf<Long, TextureRender>()

    fun createTextureRender(textureRegistry: TextureRegistry, messenger: BinaryMessenger, rtcEnginePlugin: AgoraRtcEnginePlugin, rtcChannelPlugin: AgoraRtcChannelPlugin): Long {
      val render = TextureRender(textureRegistry, messenger, rtcEnginePlugin, rtcChannelPlugin)
      val id = render.getId()
      renders[id] = render
      return id
    }

    fun destroyTextureRender(id: Long) {
      renders.remove(id)?.release()
    }
  }

  override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
    return AgoraTextureView(
      context.applicationContext,
      messenger,
      viewId,
      args as? Map<*, *>,
      rtcEnginePlugin,
      rtcChannelPlugin
    )
  }
}

class AgoraTextureView(
  context: Context,
  messenger: BinaryMessenger,
  viewId: Int,
  args: Map<*, *>?,
  private val rtcEnginePlugin: AgoraRtcEnginePlugin,
  private val rtcChannelPlugin: AgoraRtcChannelPlugin
) : PlatformView, MethodChannel.MethodCallHandler {
  private val view = RtcTextureView(context)
  private val channel = MethodChannel(messenger, "agora_rtc_engine/texture_view_$viewId")

  init {
    args?.let { map ->
      (map["data"] as? Map<*, *>)?.let { setData(it) }
      (map["renderMode"] as? Number)?.let { setRenderMode(it.toInt()) }
      (map["mirrorMode"] as? Number)?.let { setMirrorMode(it.toInt()) }
    }
    channel.setMethodCallHandler(this)
  }

  override fun getView(): View {
    return view
  }

  override fun dispose() {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    this.javaClass.declaredMethods.find { it.name == call.method }?.let { function ->
      function.let { method ->
        val parameters = mutableListOf<Any?>()
        call.arguments<Map<*, *>>()?.let { args ->
          args.values.forEach {
            parameters.add(it)
          }
        }
        try {
          method.invoke(this, *parameters.toTypedArray())
          result.success(null)
          return@onMethodCall
        } catch (e: Exception) {
          e.printStackTrace()
          result.error(e.toString(), null, null)
        }
      }
    }
    result.notImplemented()
  }

  private fun setData(data: Map<*, *>) {
    val channel = (data["channelId"] as? String)?.let { getChannel(it) }
    getEngine()?.let { view.setData(it, channel, (data["uid"] as Number).toInt()) }
  }

  private fun setRenderMode(renderMode: Int) {
    getEngine()?.let { view.setRenderMode(it, renderMode) }
  }

  private fun setMirrorMode(mirrorMode: Int) {
    getEngine()?.let { view.setMirrorMode(it, mirrorMode) }
  }

  private fun getEngine(): RtcEngine? {
    return rtcEnginePlugin.engine()
  }

  private fun getChannel(channelId: String): RtcChannel? {
    return rtcChannelPlugin.channel(channelId)
  }
}
