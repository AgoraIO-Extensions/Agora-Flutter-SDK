//
//  Extensions.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/10.
//  Copyright © 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

extension AgoraUserInfo {
    func toMap() -> Dictionary<String, Any?> {
        [
            "uid": uid,
            "userAccount": userAccount
        ]
    }
}

extension AgoraRtcLocalAudioStats {
    func toMap() -> Dictionary<String, Any?> {
        [
            "numChannels": numChannels,
            "sentSampleRate": sentSampleRate,
            "sentBitrate": sentBitrate
        ]
    }
}

extension AgoraChannelStats {
    func toMap() -> Dictionary<String, Any?> {
        [
            "totalDuration": duration,
            "txBytes": txBytes,
            "rxBytes": rxBytes,
            "txAudioBytes": txAudioBytes,
            "txVideoBytes": txVideoBytes,
            "rxAudioBytes": rxAudioBytes,
            "rxVideoBytes": rxVideoBytes,
            "txKBitRate": txKBitrate,
            "rxKBitRate": rxKBitrate,
            "txAudioKBitRate": txAudioKBitrate,
            "rxAudioKBitRate": rxAudioKBitrate,
            "txVideoKBitRate": txVideoKBitrate,
            "rxVideoKBitRate": rxVideoKBitrate,
            "users": userCount,
            "lastmileDelay": lastmileDelay,
            "txPacketLossRate": txPacketLossRate,
            "rxPacketLossRate": rxPacketLossRate,
            "cpuTotalUsage": cpuTotalUsage,
            "cpuAppUsage": cpuAppUsage,
            "gatewayRtt": gatewayRtt,
            "memoryAppUsageRatio": memoryAppUsageRatio,
            "memoryTotalUsageRatio": memoryTotalUsageRatio,
            "memoryAppUsageInKbytes": memoryAppUsageInKbytes
        ]
    }
}

extension CGRect {
    func toMap() -> Dictionary<String, Any?> {
        [
            "left": origin.x,
            "top": origin.y,
            "right": origin.x + size.width,
            "bottom": origin.y + size.height
        ]
    }
}

extension AgoraRtcRemoteAudioStats {
    func toMap() -> Dictionary<String, Any?> {
        [
            "uid": uid,
            "quality": quality,
            "networkTransportDelay": networkTransportDelay,
            "jitterBufferDelay": jitterBufferDelay,
            "audioLossRate": audioLossRate,
            "numChannels": numChannels,
            "receivedSampleRate": receivedSampleRate,
            "receivedBitrate": receivedBitrate,
            "totalFrozenTime": totalFrozenTime,
            "frozenRate": frozenRate
        ]
    }
}

extension AgoraRtcLocalVideoStats {
    func toMap() -> Dictionary<String, Any?> {
        [
            "sentBitrate": sentBitrate,
            "sentFrameRate": sentFrameRate,
            "encoderOutputFrameRate": encoderOutputFrameRate,
            "rendererOutputFrameRate": rendererOutputFrameRate,
            "targetBitrate": sentTargetBitrate,
            "targetFrameRate": sentTargetFrameRate,
            "qualityAdaptIndication": qualityAdaptIndication.rawValue,
            "encodedBitrate": encodedBitrate,
            "encodedFrameWidth": encodedFrameWidth,
            "encodedFrameHeight": encodedFrameHeight,
            "encodedFrameCount": encodedFrameCount,
            "codecType": codecType.rawValue
        ]
    }
}

extension AgoraRtcRemoteVideoStats {
    func toMap() -> Dictionary<String, Any?> {
        [
            "uid": uid,
            "delay": delay,
            "width": width,
            "height": height,
            "receivedBitrate": receivedBitrate,
            "decoderOutputFrameRate": decoderOutputFrameRate,
            "rendererOutputFrameRate": rendererOutputFrameRate,
            "packetLossRate": packetLossRate,
            "rxStreamType": rxStreamType.rawValue,
            "totalFrozenTime": totalFrozenTime,
            "frozenRate": frozenRate
        ]
    }
}

extension AgoraRtcAudioVolumeInfo {
    func toMap() -> Dictionary<String, Any?> {
        [
            "uid": uid,
            "volume": volume,
            "vad": vad,
            "channelId": channelId
        ]
    }
}

typealias AudioVolumeArray = Array<AgoraRtcAudioVolumeInfo>

extension AudioVolumeArray {
    func toMapList() -> Array<Dictionary<String, Any?>> {
        var list = [Dictionary<String, Any?>]()
        forEach { (item) in
            list.append(item.toMap())
        }
        return list
    }
}

extension AgoraLastmileProbeOneWayResult {
    func toMap() -> Dictionary<String, Any?> {
        [
            "packetLossRate": packetLossRate,
            "jitter": jitter,
            "availableBandwidth": availableBandwidth
        ]
    }
}

extension AgoraLastmileProbeResult {
    func toMap() -> Dictionary<String, Any?> {
        [
            "state": state.rawValue,
            "rtt": rtt,
            "uplinkReport": uplinkReport.toMap(),
            "downlinkReport": downlinkReport.toMap()
        ]
    }
}
