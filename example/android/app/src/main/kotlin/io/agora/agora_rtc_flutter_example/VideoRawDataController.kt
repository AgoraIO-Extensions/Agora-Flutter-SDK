package io.agora.agora_rtc_flutter_example

import android.content.Context
import android.util.Log
import io.agora.base.VideoFrame
import io.agora.rtc2.IRtcEngineEventHandler
import io.agora.rtc2.RtcEngine
import io.agora.rtc2.RtcEngineConfig
import io.agora.rtc2.video.IVideoFrameObserver
import io.agora.rtc2.video.IVideoFrameObserver.POSITION_POST_CAPTURER
import io.agora.rtc2.video.IVideoFrameObserver.PROCESS_MODE_READ_WRITE
import io.agora.rtc2.video.IVideoFrameObserver.VIDEO_PIXEL_I420
import java.util.Arrays


class VideoRawDataController(context: Context, myAppId: String ) {

    private var rtcEngine: RtcEngine? = null

    init {
        rtcEngine = RtcEngine.create(RtcEngineConfig().apply {
            mAppId = myAppId
            mContext = context.applicationContext
            mEventHandler = object : IRtcEngineEventHandler() { }
        })

        rtcEngine!!.registerVideoFrameObserver(object : IVideoFrameObserver {
            override fun onCaptureVideoFrame(sourceType: Int, videoFrame: VideoFrame?): Boolean {
                videoFrame?.apply {
                    val i420Buffer = buffer.toI420()

                    // Make it grey: Set U and V (chroma) components to neutral value
                    val neutralValue: Byte = 128.toByte()
                    val dataU = i420Buffer.dataU
                    val dataV = i420Buffer.dataV

                    while (dataU.hasRemaining()) {
                        dataU.put(neutralValue)
                    }

                    while (dataV.hasRemaining()) {
                        dataV.put(neutralValue)
                    }

                    videoFrame.replaceBuffer(i420Buffer, videoFrame.rotation, videoFrame.timestampNs)
                }

                return true;
            }

            override fun onPreEncodeVideoFrame(sourceType: Int, videoFrame: VideoFrame?): Boolean {
                return false;
            }

            override fun onMediaPlayerVideoFrame(
                videoFrame: VideoFrame?,
                mediaPlayerId: Int
            ): Boolean {
                return false;
            }

            override fun onRenderVideoFrame(
                channelId: String?,
                uid: Int,
                videoFrame: VideoFrame?
            ): Boolean {
                return false;
            }

            override fun getVideoFrameProcessMode(): Int {
                return PROCESS_MODE_READ_WRITE
            }

            override fun getVideoFormatPreference(): Int {
                return VIDEO_PIXEL_I420
            }

            override fun getRotationApplied(): Boolean {
                return false
            }

            override fun getMirrorApplied(): Boolean {
                return false
            }

            override fun getObservedFramePosition(): Int {
                return POSITION_POST_CAPTURER
            }

        })
    }

    fun nativeHandle() = rtcEngine!!.nativeHandle



    fun dispose() {
        rtcEngine!!.registerVideoFrameObserver(null)
        RtcEngine.destroy()
        rtcEngine = null
    }
}