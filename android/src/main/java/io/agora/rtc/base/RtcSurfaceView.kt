package io.agora.rtc.base

import android.content.Context
import android.view.SurfaceView
import android.widget.FrameLayout
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.video.VideoCanvas
import java.lang.ref.WeakReference

class RtcSurfaceView(
        context: Context
) : FrameLayout(context) {
    private var surface: SurfaceView = RtcEngine.CreateRendererView(context)
    private var canvas: VideoCanvas
    private var channel: WeakReference<RtcChannel>? = null

    init {
        canvas = VideoCanvas(surface)
        addView(surface)
    }

    fun setZOrderMediaOverlay(isMediaOverlay: Boolean) {
        try {
            removeView(surface)
            surface.setZOrderMediaOverlay(isMediaOverlay)
            addView(surface)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun setZOrderOnTop(onTop: Boolean) {
        try {
            removeView(surface)
            surface.setZOrderOnTop(onTop)
            addView(surface)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun setRenderMode(engine: RtcEngine, @Annotations.AgoraVideoRenderMode renderMode: Int) {
        canvas.renderMode = renderMode
        setupRenderMode(engine)
    }

    fun setChannel(engine: RtcEngine, channel: RtcChannel?) {
        this.channel = if (channel != null) WeakReference(channel) else null
        canvas.channelId = channel?.channelId()
        if (canvas.uid == 0) {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
    }

    fun setMirrorMode(engine: RtcEngine, @Annotations.AgoraVideoMirrorMode mirrorMode: Int) {
        canvas.mirrorMode = mirrorMode
        setupRenderMode(engine)
    }

    fun setUid(engine: RtcEngine, uid: Int) {
        canvas.uid = uid
        if (canvas.uid == 0) {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
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
}
