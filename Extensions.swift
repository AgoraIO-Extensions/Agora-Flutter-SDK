//
//  Extensions.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/10.
//  Copyright © 2020 Syan. All rights reserved.
//

import AgoraRtcKit
import Foundation

extension AgoraUserInfo {
    func toMap() -> [String: Any?] {
        return [
            "uid": uid,
            "userAccount": userAccount,
        ]
    }
}

extension AgoraRtcLocalAudioStats {
    func toMap() -> [String: Any?] {
        return [
            "numChannels": numChannels,
            "sentSampleRate": sentSampleRate,
            "sentBitrate": sentBitrate,
            "txPacketLossRate": txPacketLossRate,
        ]
    }
}

extension AgoraChannelStats {
    func toMap() -> [String: Any?] {
        return [
            "duration": duration,
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
            "userCount": userCount,
            "lastmileDelay": lastmileDelay,
            "txPacketLossRate": txPacketLossRate,
            "rxPacketLossRate": rxPacketLossRate,
            "cpuTotalUsage": cpuTotalUsage,
            "cpuAppUsage": cpuAppUsage,
            "gatewayRtt": gatewayRtt,
            "memoryAppUsageRatio": memoryAppUsageRatio,
            "memoryTotalUsageRatio": memoryTotalUsageRatio,
            "memoryAppUsageInKbytes": memoryAppUsageInKbytes,
        ]
    }
}

extension CGRect {
    func toMap() -> [String: Any?] {
        return [
            "left": origin.x,
            "top": origin.y,
            "right": origin.x + size.width,
            "bottom": origin.y + size.height,
        ]
    }
}

extension AgoraRtcRemoteAudioStats {
    func toMap() -> [String: Any?] {
        return [
            "uid": uid,
            "quality": quality,
            "networkTransportDelay": networkTransportDelay,
            "jitterBufferDelay": jitterBufferDelay,
            "audioLossRate": audioLossRate,
            "numChannels": numChannels,
            "receivedSampleRate": receivedSampleRate,
            "receivedBitrate": receivedBitrate,
            "totalFrozenTime": totalFrozenTime,
            "frozenRate": frozenRate,
            "totalActiveTime": totalActiveTime,
            "publishDuration": publishDuration,
            "qoeQuality": qoeQuality,
            "qualityChangedReason": qualityChangedReason,
            "mosValue": mosValue,
        ]
    }
}

extension AgoraRtcLocalVideoStats {
    func toMap() -> [String: Any?] {
        return [
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
            "codecType": codecType.rawValue,
            "txPacketLossRate": txPacketLossRate,
            "captureFrameRate": captureFrameRate,
            "captureBrightnessLevel": captureBrightnessLevel.rawValue,
        ]
    }
}

extension AgoraRtcRemoteVideoStats {
    func toMap() -> [String: Any?] {
        return [
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
            "frozenRate": frozenRate,
            "totalActiveTime": totalActiveTime,
            "publishDuration": publishDuration,
        ]
    }
}

extension AgoraRtcAudioVolumeInfo {
    func toMap() -> [String: Any?] {
        return [
            "uid": uid,
            "volume": volume,
            "vad": vad,
            "channelId": channelId,
        ]
    }
}

extension Array where Element: AgoraRtcAudioVolumeInfo {
    func toMapList() -> [[String: Any?]] {
        var list = [[String: Any?]]()
        forEach {
            list.append($0.toMap())
        }
        return list
    }
}

extension AgoraLastmileProbeOneWayResult {
    func toMap() -> [String: Any?] {
        return [
            "packetLossRate": packetLossRate,
            "jitter": jitter,
            "availableBandwidth": availableBandwidth,
        ]
    }
}

extension AgoraLastmileProbeResult {
    func toMap() -> [String: Any?] {
        return [
            "state": state.rawValue,
            "rtt": rtt,
            "uplinkReport": uplinkReport.toMap(),
            "downlinkReport": downlinkReport.toMap(),
        ]
    }
}

extension AgoraFacePositionInfo {
    func toMap() -> [String: Any?] {
        return [
            "x": x,
            "y": y,
            "width": width,
            "height": height,
            "distance": distance,
        ]
    }
}

extension Array where Element: AgoraFacePositionInfo {
    func toMapList() -> [[String: Any?]] {
        var list = [[String: Any?]]()
        forEach {
            list.append($0.toMap())
        }
        return list
    }
}
