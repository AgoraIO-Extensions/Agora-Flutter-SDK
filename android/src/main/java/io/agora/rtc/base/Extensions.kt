package io.agora.rtc.base

import android.graphics.Rect
import io.agora.rtc.IRtcEngineEventHandler.*
import io.agora.rtc.models.UserInfo

fun UserInfo.toMap(): Map<String, Any?> {
  return hashMapOf(
    "uid" to uid.toJSUInt(),
    "userAccount" to userAccount
  )
}

fun LocalAudioStats.toMap(): Map<String, Any?> {
  return hashMapOf(
    "numChannels" to numChannels,
    "sentSampleRate" to sentSampleRate,
    "sentBitrate" to sentBitrate,
    "txPacketLossRate" to txPacketLossRate
  )
}

fun RtcStats.toMap(): Map<String, Any?> {
  return hashMapOf(
    "totalDuration" to totalDuration,
    "txBytes" to txBytes,
    "rxBytes" to rxBytes,
    "txAudioBytes" to txAudioBytes,
    "txVideoBytes" to txVideoBytes,
    "rxAudioBytes" to rxAudioBytes,
    "rxVideoBytes" to rxVideoBytes,
    "txKBitRate" to txKBitRate,
    "rxKBitRate" to rxKBitRate,
    "txAudioKBitRate" to txAudioKBitRate,
    "rxAudioKBitRate" to rxAudioKBitRate,
    "txVideoKBitRate" to txVideoKBitRate,
    "rxVideoKBitRate" to rxVideoKBitRate,
    "users" to users,
    "lastmileDelay" to lastmileDelay,
    "txPacketLossRate" to txPacketLossRate,
    "rxPacketLossRate" to rxPacketLossRate,
    "cpuTotalUsage" to cpuTotalUsage,
    "cpuAppUsage" to cpuAppUsage,
    "gatewayRtt" to gatewayRtt,
    "memoryAppUsageRatio" to memoryAppUsageRatio,
    "memoryTotalUsageRatio" to memoryTotalUsageRatio,
    "memoryAppUsageInKbytes" to memoryAppUsageInKbytes
  )
}

fun Rect.toMap(): Map<String, Any?> {
  return hashMapOf(
    "left" to left,
    "top" to top,
    "right" to right,
    "bottom" to bottom
  )
}

fun RemoteAudioStats.toMap(): Map<String, Any?> {
  return hashMapOf(
    "uid" to uid.toJSUInt(),
    "quality" to quality,
    "networkTransportDelay" to networkTransportDelay,
    "jitterBufferDelay" to jitterBufferDelay,
    "audioLossRate" to audioLossRate,
    "numChannels" to numChannels,
    "receivedSampleRate" to receivedSampleRate,
    "receivedBitrate" to receivedBitrate,
    "totalFrozenTime" to totalFrozenTime,
    "frozenRate" to frozenRate,
    "totalActiveTime" to totalActiveTime,
    "publishDuration" to publishDuration,
    "qoeQuality" to qoeQuality,
    "qualityChangedReason" to qualityChangedReason,
    "mosValue" to mosValue
  )
}

fun LocalVideoStats.toMap(): Map<String, Any?> {
  return hashMapOf(
    "sentBitrate" to sentBitrate,
    "sentFrameRate" to sentFrameRate,
    "encoderOutputFrameRate" to encoderOutputFrameRate,
    "rendererOutputFrameRate" to rendererOutputFrameRate,
    "targetBitrate" to targetBitrate,
    "targetFrameRate" to targetFrameRate,
    "qualityAdaptIndication" to qualityAdaptIndication,
    "encodedBitrate" to encodedBitrate,
    "encodedFrameWidth" to encodedFrameWidth,
    "encodedFrameHeight" to encodedFrameHeight,
    "encodedFrameCount" to encodedFrameCount,
    "codecType" to codecType,
    "txPacketLossRate" to txPacketLossRate,
    "captureFrameRate" to captureFrameRate,
    "captureBrightnessLevel" to captureBrightnessLevel
  )
}

fun RemoteVideoStats.toMap(): Map<String, Any?> {
  return hashMapOf(
    "uid" to uid.toJSUInt(),
    "delay" to delay,
    "width" to width,
    "height" to height,
    "receivedBitrate" to receivedBitrate,
    "decoderOutputFrameRate" to decoderOutputFrameRate,
    "rendererOutputFrameRate" to rendererOutputFrameRate,
    "packetLossRate" to packetLossRate,
    "rxStreamType" to rxStreamType,
    "totalFrozenTime" to totalFrozenTime,
    "frozenRate" to frozenRate,
    "totalActiveTime" to totalActiveTime,
    "publishDuration" to publishDuration
  )
}

fun AudioVolumeInfo.toMap(): Map<String, Any?> {
  return hashMapOf(
    "uid" to uid.toJSUInt(),
    "volume" to volume,
    "vad" to vad,
    "channelId" to channelId
  )
}

fun Array<out AudioVolumeInfo>.toMapList(): List<Map<String, Any?>> {
  return List(size) { this[it].toMap() }
}

fun LastmileProbeResult.LastmileProbeOneWayResult.toMap(): Map<String, Any?> {
  return hashMapOf(
    "packetLossRate" to packetLossRate,
    "jitter" to jitter,
    "availableBandwidth" to availableBandwidth
  )
}

fun LastmileProbeResult.toMap(): Map<String, Any?> {
  return hashMapOf(
    "state" to state,
    "rtt" to rtt,
    "uplinkReport" to uplinkReport.toMap(),
    "downlinkReport" to downlinkReport.toMap()
  )
}

fun AgoraFacePositionInfo.toMap(): Map<String, Any?> {
  return hashMapOf(
    "x" to x,
    "y" to y,
    "width" to width,
    "height" to height,
    "distance" to distance
  )
}

fun Array<out AgoraFacePositionInfo>.toMapList(): List<Map<String, Any?>> {
  return List(size) { this[it].toMap() }
}

@ExperimentalUnsignedTypes
fun Any.toSDKUInt(): Int? {
  return (this as? Number)?.toLong()?.toUInt()?.toInt()
}

fun Int.toJSUInt(): Long {
  return this.toUInt().toLong();
}
