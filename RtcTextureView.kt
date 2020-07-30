package io.agora.rtc.base

import android.content.Context
import android.widget.FrameLayout
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.mediaio.AgoraTextureView
import io.agora.rtc.mediaio.MediaIO
import java.lang.ref.WeakReference

class RtcTextureView(
        context: Context
) : FrameLayout(context) {
    private var texture: AgoraTextureView = AgoraTextureView(context)
    private var uid: Int = 0
    private var channel: WeakReference<RtcChannel>? = null

    init {
        texture.init(null)
        texture.setBufferType(MediaIO.BufferType.BYTE_ARRAY)
        texture.setPixelFormat(MediaIO.PixelFormat.I420)
        addView(texture)
    }

    fun setData(engine: RtcEngine, channel: RtcChannel?, uid: Int) {
        resetVideoRender(engine)

        this.channel = if (channel != null) WeakReference(channel) else null
        this.uid = uid
        setupVideoRenderer(engine)
    }

    fun setMirror(engine: RtcEngine, mirror: Boolean) {
        texture.setMirror(mirror)
        setupVideoRenderer(engine)
    }

    private fun resetVideoRender(engine: RtcEngine) {
        if (uid == 0) {
            engine.setLocalVideoRenderer(null)
        } else {
            channel?.get()?.let {
                it.setRemoteVideoRenderer(uid, null)
                return@resetVideoRender
            }
            engine.setRemoteVideoRenderer(uid, null)
        }
    }

    private fun setupVideoRenderer(engine: RtcEngine) {
        if (uid == 0) {
            engine.setLocalVideoRenderer(texture)
        } else {
            channel?.get()?.let {
                it.setRemoteVideoRenderer(uid, texture)
                return@setupVideoRenderer
            }
            engine.setRemoteVideoRenderer(uid, texture)
        }
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        val width: Int = MeasureSpec.getSize(widthMeasureSpec)
        val height: Int = MeasureSpec.getSize(heightMeasureSpec)
        texture.layout(0, 0, width, height)
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)
    }
}
