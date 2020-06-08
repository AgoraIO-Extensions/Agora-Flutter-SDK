package io.agora.rtc.base

import android.graphics.Color
import io.agora.rtc.internal.LastmileProbeConfig
import io.agora.rtc.live.LiveInjectStreamConfig
import io.agora.rtc.live.LiveTranscoding
import io.agora.rtc.live.LiveTranscoding.TranscodingUser
import io.agora.rtc.models.ChannelMediaOptions
import io.agora.rtc.video.*

fun mapToVideoDimensions(map: Map<*, *>): VideoEncoderConfiguration.VideoDimensions {
    return VideoEncoderConfiguration.VideoDimensions().apply {
        (map["width"] as? Number)?.let { width = it.toInt() }
        (map["height"] as? Number)?.let { height = it.toInt() }
    }
}

fun mapToVideoEncoderConfiguration(map: Map<*, *>): VideoEncoderConfiguration {
    return VideoEncoderConfiguration().apply {
        (map["dimensions"] as? Map<*, *>)?.let { dimensions = mapToVideoDimensions(it) }
        (map["frameRate"] as? Number)?.let { frameRate = it.toInt() }
        (map["minFrameRate"] as? Number)?.let { minFrameRate = it.toInt() }
        (map["bitrate"] as? Number)?.let { bitrate = it.toInt() }
        (map["minBitrate"] as? Number)?.let { minBitrate = it.toInt() }
        (map["orientationMode"] as? Number)?.let { orientationMode = intToOrientationMode(it.toInt()) }
        (map["degradationPrefer"] as? Number)?.let { degradationPrefer = intToDegradationPreference(it.toInt()) }
        (map["mirrorMode"] as? Number)?.let { mirrorMode = it.toInt() }
    }
}

fun mapToBeautyOptions(map: Map<*, *>): BeautyOptions {
    return BeautyOptions().apply {
        (map["lighteningContrastLevel"] as? Number)?.let { lighteningContrastLevel = it.toInt() }
        (map["lighteningLevel"] as? Number)?.let { lighteningLevel = it.toFloat() }
        (map["smoothnessLevel"] as? Number)?.let { smoothnessLevel = it.toFloat() }
        (map["rednessLevel"] as? Number)?.let { rednessLevel = it.toFloat() }
    }
}

fun mapToAgoraImage(map: Map<*, *>): AgoraImage {
    return AgoraImage().apply {
        (map["url"] as? String)?.let { url = it }
        (map["x"] as? Number)?.let { x = it.toInt() }
        (map["y"] as? Number)?.let { y = it.toInt() }
        (map["width"] as? Number)?.let { width = it.toInt() }
        (map["height"] as? Number)?.let { height = it.toInt() }
    }
}

fun mapToTranscodingUser(map: Map<*, *>): TranscodingUser {
    return TranscodingUser().apply {
        (map["uid"] as? Number)?.let { uid = it.toInt() }
        (map["x"] as? Number)?.let { x = it.toInt() }
        (map["y"] as? Number)?.let { y = it.toInt() }
        (map["width"] as? Number)?.let { width = it.toInt() }
        (map["height"] as? Number)?.let { height = it.toInt() }
        (map["zOrder"] as? Number)?.let { zOrder = it.toInt() }
        (map["alpha"] as? Number)?.let { alpha = it.toFloat() }
        (map["audioChannel"] as? Number)?.let { audioChannel = it.toInt() }
    }
}

fun mapToColor(map: Map<*, *>): Int {
    return Color.rgb(
            (map["red"] as Number).toInt(),
            (map["green"] as Number).toInt(),
            (map["blue"] as Number).toInt()
    )
}

fun mapToLiveTranscoding(map: Map<*, *>): LiveTranscoding {
    return LiveTranscoding().apply {
        (map["width"] as? Number)?.let { width = it.toInt() }
        (map["height"] as? Number)?.let { height = it.toInt() }
        (map["videoBitrate"] as? Number)?.let { videoBitrate = it.toInt() }
        (map["videoFramerate"] as? Number)?.let { videoFramerate = it.toInt() }
        (map["lowLatency"] as? Boolean)?.let { lowLatency = it }
        (map["videoGop"] as? Number)?.let { videoGop = it.toInt() }
        (map["watermark"] as? Map<*, *>)?.let { watermark = mapToAgoraImage(it) }
        (map["backgroundImage"] as? Map<*, *>)?.let { backgroundImage = mapToAgoraImage(it) }
        (map["audioSampleRate"] as? Number)?.let { audioSampleRate = intToLiveTranscodingAudioSampleRate(it.toInt()) }
        (map["audioBitrate"] as? Number)?.let { audioBitrate = it.toInt() }
        (map["audioChannels"] as? Number)?.let { audioChannels = it.toInt() }
        (map["audioCodecProfile"] as? Number)?.let { audioCodecProfile = intToAudioCodecProfile(it.toInt()) }
        (map["videoCodecProfile"] as? Number)?.let { videoCodecProfile = intToVideoCodecProfile(it.toInt()) }
        (map["backgroundColor"] as? Map<*, *>)?.let { backgroundColor = mapToColor(it) }
        (map["userConfigExtraInfo"] as? String)?.let { userConfigExtraInfo = it }
        (map["transcodingUsers"] as? List<*>)?.let { list ->
            list.forEach { item ->
                (item as? Map<*, *>)?.let {
                    addUser(mapToTranscodingUser(it))
                }
            }
        }
    }
}

fun mapToChannelMediaInfo(map: Map<*, *>): ChannelMediaInfo {
    return ChannelMediaInfo(
            map["channelName"] as String,
            map["token"] as String,
            (map["uid"] as Number).toInt()
    )
}

fun mapToChannelMediaRelayConfiguration(map: Map<*, *>): ChannelMediaRelayConfiguration {
    return ChannelMediaRelayConfiguration().apply {
        (map["srcInfo"] as? Map<*, *>)?.let { setSrcChannelInfo(mapToChannelMediaInfo(it)) }
        (map["destInfos"] as? List<*>)?.let { list ->
            list.forEach { item ->
                (item as? Map<*, *>)?.let {
                    val info = mapToChannelMediaInfo(it)
                    setDestChannelInfo(info.channelName, info)
                }
            }
        }
    }
}

fun mapToLastmileProbeConfig(map: Map<*, *>): LastmileProbeConfig {
    return LastmileProbeConfig().apply {
        (map["probeUplink"] as? Boolean)?.let { probeUplink = it }
        (map["probeDownlink"] as? Boolean)?.let { probeDownlink = it }
        (map["expectedUplinkBitrate"] as? Number)?.let { expectedUplinkBitrate = it.toInt() }
        (map["expectedDownlinkBitrate"] as? Number)?.let { expectedUplinkBitrate = it.toInt() }
    }
}

fun mapToRectangle(map: Map<*, *>): WatermarkOptions.Rectangle {
    return WatermarkOptions.Rectangle().apply {
        (map["x"] as? Number)?.let { x = it.toInt() }
        (map["y"] as? Number)?.let { y = it.toInt() }
        (map["width"] as? Number)?.let { width = it.toInt() }
        (map["height"] as? Number)?.let { height = it.toInt() }
    }
}

fun mapToWatermarkOptions(map: Map<*, *>): WatermarkOptions {
    return WatermarkOptions().apply {
        (map["visibleInPreview"] as? Boolean)?.let { visibleInPreview = it }
        (map["positionInLandscapeMode"] as? Map<*, *>)?.let { positionInLandscapeMode = mapToRectangle(it) }
        (map["positionInPortraitMode"] as? Map<*, *>)?.let { positionInPortraitMode = mapToRectangle(it) }
    }
}

fun mapToLiveInjectStreamConfig(map: Map<*, *>): LiveInjectStreamConfig {
    return LiveInjectStreamConfig().apply {
        (map["width"] as? Number)?.let { width = it.toInt() }
        (map["height"] as? Number)?.let { height = it.toInt() }
        (map["videoGop"] as? Number)?.let { videoGop = it.toInt() }
        (map["videoFramerate"] as? Number)?.let { videoFramerate = it.toInt() }
        (map["videoBitrate"] as? Number)?.let { videoBitrate = it.toInt() }
        (map["audioSampleRate"] as? Number)?.let { audioSampleRate = intToLiveInjectStreamConfigAudioSampleRate(it.toInt()) }
        (map["audioBitrate"] as? Number)?.let { audioBitrate = it.toInt() }
        (map["audioChannels"] as? Number)?.let { audioChannels = it.toInt() }
    }
}

fun mapToCameraCapturerConfiguration(map: Map<*, *>): CameraCapturerConfiguration {
    return CameraCapturerConfiguration(
            intToCapturerOutputPreference(map["preference"] as Int),
            intToCameraDirection(map["cameraDirection"] as Int)
    )
}

fun mapToChannelMediaOptions(map: Map<*, *>): ChannelMediaOptions {
    return ChannelMediaOptions().apply {
        (map["autoSubscribeAudio"] as? Boolean)?.let { autoSubscribeAudio = it }
        (map["autoSubscribeVideo"] as? Boolean)?.let { autoSubscribeVideo = it }
    }
}
