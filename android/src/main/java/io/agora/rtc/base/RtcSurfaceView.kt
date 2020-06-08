package io.agora.rtc.base

import android.content.Context
import android.view.SurfaceView
import android.widget.FrameLayout
import io.agora.rtc.RtcEngine
import io.agora.rtc.video.VideoCanvas

class RtcSurfaceView(
        context: Context
) : FrameLayout(context) {
    private var surface: SurfaceView = RtcEngine.CreateRendererView(context)
    private var canvas: VideoCanvas

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
        if (canvas.uid == 0) {
            engine.setLocalRenderMode(canvas.renderMode, canvas.mirrorMode)
        } else {
            engine.setRemoteRenderMode(canvas.uid, canvas.renderMode, canvas.mirrorMode)
        }
    }

    fun setChannelId(engine: RtcEngine, channelId: String) {
        canvas.channelId = channelId
        if (canvas.uid == 0) {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
    }

    fun setMirrorMode(engine: RtcEngine, @Annotations.AgoraVideoMirrorMode mirrorMode: Int) {
        canvas.mirrorMode = mirrorMode
        if (canvas.uid == 0) {
            engine.setLocalRenderMode(canvas.renderMode, canvas.mirrorMode)
        } else {
            engine.setRemoteRenderMode(canvas.uid, canvas.renderMode, canvas.mirrorMode)
        }
    }

    fun setUid(engine: RtcEngine, uid: Int) {
        canvas.uid = uid
        if (canvas.uid == 0) {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        val width: Int = MeasureSpec.getSize(widthMeasureSpec)
        val height: Int = MeasureSpec.getSize(heightMeasureSpec)
        surface.layout(0, 0, width, height)
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)
    }
}
