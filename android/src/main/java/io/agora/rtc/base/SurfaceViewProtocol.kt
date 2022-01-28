package io.agora.rtc.base

import android.content.Context
import android.view.SurfaceView
import android.widget.FrameLayout
import io.agora.rtc.RtcChannel
import io.agora.rtc.RtcEngine
import io.agora.rtc.video.VideoCanvas
import java.lang.ref.WeakReference

interface SurfaceViewProtocol {
  fun setZOrderMediaOverlay(isMediaOverlay: Boolean)

  fun setZOrderOnTop(onTop: Boolean)

  fun setData(engine: RtcEngine, channel: RtcChannel?, uid: Number)

  fun setRenderMode(engine: RtcEngine, @Annotations.AgoraVideoRenderMode renderMode: Int)

  fun setMirrorMode(engine: RtcEngine, @Annotations.AgoraVideoMirrorMode mirrorMode: Int)
}
