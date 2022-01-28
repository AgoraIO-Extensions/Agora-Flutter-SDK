package io.agora.rtc.base

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.widget.FrameLayout
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.video.VideoCanvas
import io.agora.rtc.video.AgoraVideoFrame
import java.lang.ref.WeakReference
import com.banuba.sdk.manager.BanubaSdkManager
import com.banuba.sdk.manager.BanubaSdkTouchListener
import com.banuba.sdk.manager.IEventCallback
import com.banuba.sdk.types.Data
import android.graphics.Bitmap
import com.banuba.sdk.entity.RecordedVideoInfo
import android.net.Uri
import androidx.core.content.ContextCompat
import android.view.SurfaceView


class BanubaRtcSurfaceView(
  context: Context
) : FrameLayout(context), SurfaceViewProtocol {
  private var surface: SurfaceView
  private var canvas: VideoCanvas
  private var isMediaOverlay = false
  private var onTop = false
  private var channel: WeakReference<RtcChannel>? = null
  private var banubaSdkManager: BanubaSdkManager? = null

  companion object {
    private const val MASK_NAME = "Afro"
    private const val SDK_TOKEN = <#SET_BANUBA_SDK_TOKEN#>

    private const val REQUEST_CODE_PERMISSIONS = 1001

    private val REQUIRED_PERMISSIONS = arrayOf(
      Manifest.permission.CAMERA,
      Manifest.permission.RECORD_AUDIO
    )
  }

  init {
    try {
      surface = SurfaceView(context)
    } catch (e: UnsatisfiedLinkError) {
      throw RuntimeException("Please init RtcEngine first!")
    }
    canvas = VideoCanvas(surface)

    addView(surface)

    BanubaSdkManager.initialize(context, SDK_TOKEN)
  }

  override fun onAttachedToWindow() {
    super.onAttachedToWindow()
    configureSdkManager()
  }

  override fun onDetachedFromWindow() {
    super.onDetachedFromWindow()
    banubaSdkManager?.closeCamera()
    banubaSdkManager?.releaseSurface()
  }

  private var agoraRtc: RtcEngine? = null;

  private val banubaSdkEventCallback = object : IEventCallback {
    override fun onFrameRendered(data: Data, width: Int, height: Int) {
      pushCustomFrame(data, width, height)
    }

    override fun onImageProcessed(p0: Bitmap) {}

    override fun onEditingModeFaceFound(p0: Boolean) {}

    override fun onCameraOpenError(p0: Throwable) {}

    override fun onVideoRecordingFinished(p0: RecordedVideoInfo) {}

    override fun onVideoRecordingStatusChange(p0: Boolean) {}

    override fun onHQPhotoReady(p0: Bitmap) {}

    override fun onEditedImageReady(p0: Bitmap) {}

    override fun onScreenshotReady(p0: Bitmap) {}

    override fun onCameraStatus(p0: Boolean) {}
  }

  private fun configureSdkManager() {
    banubaSdkManager = BanubaSdkManager(context)
    //val banubaTouchListener = BanubaSdkTouchListener(context.applicationContext, banubaSdkManager?.effectPlayer!!)
    //surface.setOnTouchListener(banubaTouchListener)
    val effectUri = Uri.parse(BanubaSdkManager.getResourcesBase())
      .buildUpon()
      .appendPath("effects")
      .appendPath(MASK_NAME)
      .build()
    banubaSdkManager?.effectManager?.loadAsync(effectUri.toString())
    banubaSdkManager?.setCallback(banubaSdkEventCallback)
    banubaSdkManager?.attachSurface(surface)

    banubaSdkManager?.effectPlayer?.effectManager()?.setEffectVolume(0F)

    banubaSdkManager?.effectPlayer?.playbackPlay()
    banubaSdkManager?.startForwardingFrames()

    if (checkAllPermissionsGranted()) {
      banubaSdkManager?.openCamera()
    }
  }

//  override fun onRequestPermissionsResult(
//    requestCode: Int,
//    permissions: Array<String>,
//    results: IntArray
//  ) {
//    if (checkAllPermissionsGranted()) {
//      banubaSdkManager.openCamera()
//    } else {
//      Toast.makeText(applicationContext, "Please grant permission.", Toast.LENGTH_LONG).show()
//      finish()
//    }
//  }

//  override fun onResume() {
//    super.onResume()
//    banubaSdkManager.effectPlayer.effectManager()?.setEffectVolume(0F)
//    banubaSdkManager.effectPlayer.playbackPlay()
//    banubaSdkManager.startForwardingFrames()
//  }
//
//  override fun onPause() {
//    super.onPause()
//    banubaSdkManager.effectPlayer.playbackPause()
//    banubaSdkManager.stopForwardingFrames()
//  }
//
//  override fun onStop() {
//    super.onStop()
//    banubaSdkManager.releaseSurface()
//    banubaSdkManager.closeCamera()
//  }
//  override fun onDestroy() {
//    super.onDestroy()
//  }

  override fun setZOrderOnTop(onTop: Boolean) {
    this.onTop = onTop
    try {
      removeView(surface)
      surface.setZOrderOnTop(onTop)
      addView(surface)
    } catch (e: Exception) {
      e.printStackTrace()
    }
  }

  override fun setData(engine: RtcEngine, channel: RtcChannel?, uid: Number) {
    this.channel = if (channel != null) WeakReference(channel) else null
    canvas.channelId = this.channel?.get()?.channelId()
    canvas.uid = uid.toNativeUInt()
    agoraRtc = engine;

    engine.setExternalVideoSource(true, false, true)
    engine.enableVideo()

    setupVideoCanvas(engine)
  }

  fun resetVideoCanvas(engine: RtcEngine) {
    val canvas =
      VideoCanvas(null, canvas.renderMode, canvas.channelId, canvas.uid, canvas.mirrorMode)
    engine.setupLocalVideo(canvas)
  }

  private fun setupVideoCanvas(engine: RtcEngine) {
    // removeAllViews()
    // surface = RtcEngine.CreateRendererView(context.applicationContext)
    surface.setZOrderMediaOverlay(isMediaOverlay)
    surface.setZOrderOnTop(onTop)
    // addView(surface)
    surface.layout(0, 0, width, height)
    canvas.view = surface
    engine.setupLocalVideo(canvas)
  }

  private fun pushCustomFrame(rawData: Data, width: Int, height: Int) {
    val pixelData = ByteArray(rawData.data.remaining())
    rawData.data.get(pixelData)
    rawData.close()
    val videoFrame = AgoraVideoFrame().apply {
      timeStamp = System.currentTimeMillis()
      format = AgoraVideoFrame.FORMAT_RGBA
      this.height = height
      stride = width
      buf = pixelData
    }
    agoraRtc?.pushExternalVideoFrame(videoFrame)
  }

  override fun setRenderMode(engine: RtcEngine, @Annotations.AgoraVideoRenderMode renderMode: Int) {
    canvas.renderMode = renderMode
    setupRenderMode(engine)
  }

  override fun setMirrorMode(engine: RtcEngine, @Annotations.AgoraVideoMirrorMode mirrorMode: Int) {
    canvas.mirrorMode = mirrorMode
    setupRenderMode(engine)
  }

  private fun setupRenderMode(engine: RtcEngine) {
    if (canvas.uid == 0) {
      engine.setLocalRenderMode(canvas.renderMode, canvas.mirrorMode)
    } else {
      channel?.get()?.let {
        it.setRemoteRenderMode(canvas.uid, canvas.renderMode, canvas.mirrorMode)
        return@setupRenderMode
      }
      engine.setRemoteRenderMode(canvas.uid, canvas.renderMode, canvas.mirrorMode)
    }
  }

  override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
    val width: Int = MeasureSpec.getSize(widthMeasureSpec)
    val height: Int = MeasureSpec.getSize(heightMeasureSpec)
    surface.layout(0, 0, width, height)
    super.onMeasure(widthMeasureSpec, heightMeasureSpec)
  }

  override fun setZOrderMediaOverlay(isMediaOverlay: Boolean) {
    this.isMediaOverlay = isMediaOverlay
    try {
      removeView(surface)
      surface.setZOrderMediaOverlay(isMediaOverlay)
      addView(surface)
    } catch (e: Exception) {
      e.printStackTrace()
    }
  }

  private fun checkAllPermissionsGranted() = REQUIRED_PERMISSIONS.all {
    ContextCompat.checkSelfPermission(context, it) == PackageManager.PERMISSION_GRANTED
  }

}
