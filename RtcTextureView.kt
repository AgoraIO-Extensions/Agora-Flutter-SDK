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

    fun setChannel(engine: RtcEngine, channel: RtcChannel?) {
        this.channel = if (channel != null) WeakReference(channel) else null
        setupVideoRenderer(engine)
    }

    fun setMirror(engine: RtcEngine, mirror: Boolean) {
        texture.setMirror(mirror)
        setupVideoRenderer(engine)
    }

    fun setUid(engine: RtcEngine, uid: Int) {
        this.uid = uid
        setupVideoRenderer(engine)
    }

    private fun setupVideoRenderer(engine: RtcEngine) {
        if (uid == 0) {
            engine.setLocalVideoRenderer(null)
            engine.setLocalVideoRenderer(texture)
        } else {
            channel?.get()?.let {
                it.setRemoteVideoRenderer(uid, null)
                it.setRemoteVideoRenderer(uid, texture)
                return@setupVideoRenderer
            }
            engine.setRemoteVideoRenderer(uid, null)
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
