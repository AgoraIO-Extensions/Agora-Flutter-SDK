//
//  BeanCovertor.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/9.
//  Copyright © 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

func mapToPoint(map: Dictionary<String, Any>) -> CGPoint {
    var point = CGPoint()
    if let x = map["x"] as? Int {
        point.x = CGFloat(x)
    }
    if let y = map["y"] as? Int {
        point.y = CGFloat(y)
    }
    return point
}

func mapToSize(map: Dictionary<String, Any>) -> CGSize {
    var size = CGSize()
    if let width = map["width"] as? Int {
        size.width = CGFloat(width)
    }
    if let height = map["height"] as? Int {
        size.height = CGFloat(height)
    }
    return size
}

func mapToRect(map: Dictionary<String, Any>) -> CGRect {
    CGRect(
            origin: mapToPoint(map: map),
            size: mapToSize(map: map)
    )
}

func mapToVideoEncoderConfiguration(map: Dictionary<String, Any>) -> AgoraVideoEncoderConfiguration {
    let config = AgoraVideoEncoderConfiguration()
    if let dimensions = map["dimensions"] as? Dictionary<String, Any> {
        config.dimensions = mapToSize(map: dimensions)
    }
    if let frameRate = map["frameRate"] as? Int {
        config.frameRate = frameRate
    }
    if let minFrameRate = map["minFrameRate"] as? Int {
        config.minFrameRate = minFrameRate
    }
    if let bitrate = map["bitrate"] as? Int {
        config.bitrate = bitrate
    }
    if let minBitrate = map["minBitrate"] as? Int {
        config.minBitrate = minBitrate
    }
    if let orientationMode = map["orientationMode"] as? Int {
        if let orientationMode = AgoraVideoOutputOrientationMode(rawValue: orientationMode) {
            config.orientationMode = orientationMode
        }
    }
    if let degradationPreference = map["degradationPrefer"] as? Int {
        if let degradationPreference = AgoraDegradationPreference(rawValue: degradationPreference) {
            config.degradationPreference = degradationPreference
        }
    }
    if let mirrorMode = map["mirrorMode"] as? Int {
        if let mirrorMode = AgoraVideoMirrorMode(rawValue: UInt(mirrorMode)) {
            config.mirrorMode = mirrorMode
        }
    }
    return config
}

func mapToBeautyOptions(map: Dictionary<String, Any>) -> AgoraBeautyOptions {
    let options = AgoraBeautyOptions()
    if let lighteningContrastLevel = map["lighteningContrastLevel"] as? Int {
        if let lighteningContrastLevel = AgoraLighteningContrastLevel(rawValue: UInt(lighteningContrastLevel)) {
            options.lighteningContrastLevel = lighteningContrastLevel
        }
    }
    if let lighteningLevel = map["lighteningLevel"] as? Float {
        options.lighteningLevel = lighteningLevel
    }
    if let smoothnessLevel = map["smoothnessLevel"] as? Float {
        options.smoothnessLevel = smoothnessLevel
    }
    if let rednessLevel = map["rednessLevel"] as? Float {
        options.rednessLevel = rednessLevel
    }
    return options
}

func mapToAgoraImage(map: Dictionary<String, Any>) -> AgoraImage {
    let image = AgoraImage()
    if let url = map["url"] as? String {
        if let url = URL(string: url) {
            image.url = url
        }
    }
    image.rect = mapToRect(map: map)
    return image
}

func mapToTranscodingUser(map: Dictionary<String, Any>) -> AgoraLiveTranscodingUser {
    let user = AgoraLiveTranscodingUser()
    if let uid = map["uid"] as? Int {
        user.uid = UInt(uid)
    }
    user.rect = mapToRect(map: map)
    if let zOrder = map["zOrder"] as? Int {
        user.zOrder = zOrder
    }
    if let alpha = map["alpha"] as? Double {
        user.alpha = alpha
    }
    if let audioChannel = map["audioChannel"] as? Int {
        user.audioChannel = audioChannel
    }
    return user
}

func mapToColor(map: Dictionary<String, Any>) -> UIColor {
    UIColor(
            red: CGFloat(map["red"] as! Int),
            green: CGFloat(map["green"] as! Int),
            blue: CGFloat(map["blue"] as! Int),
            alpha: 1.0
    )
}

func mapToLiveTranscoding(map: Dictionary<String, Any>) -> AgoraLiveTranscoding {
    let transcoding = AgoraLiveTranscoding.default()
    transcoding.size = mapToSize(map: map)
    if let videoBitrate = map["videoBitrate"] as? Int {
        transcoding.videoBitrate = videoBitrate
    }
    if let videoFramerate = map["videoFramerate"] as? Int {
        transcoding.videoFramerate = videoFramerate
    }
    if let lowLatency = map["lowLatency"] as? Bool {
        transcoding.lowLatency = lowLatency
    }
    if let videoGop = map["videoGop"] as? Int {
        transcoding.videoGop = videoGop
    }
    if let watermark = map["watermark"] as? Dictionary<String, Any> {
        transcoding.watermark = mapToAgoraImage(map: watermark)
    }
    if let backgroundImage = map["backgroundImage"] as? Dictionary<String, Any> {
        transcoding.backgroundImage = mapToAgoraImage(map: backgroundImage)
    }
    if let audioSampleRate = map["audioSampleRate"] as? Int {
        if let audioSampleRate = AgoraAudioSampleRateType(rawValue: audioSampleRate) {
            transcoding.audioSampleRate = audioSampleRate
        }
    }
    if let audioBitrate = map["audioBitrate"] as? Int {
        transcoding.audioBitrate = audioBitrate
    }
    if let audioChannels = map["audioChannels"] as? Int {
        transcoding.audioChannels = audioChannels
    }
    if let audioCodecProfile = map["audioCodecProfile"] as? Int {
        if let audioCodecProfile = AgoraAudioCodecProfileType(rawValue: audioCodecProfile) {
            transcoding.audioCodecProfile = audioCodecProfile
        }
    }
    if let videoCodecProfile = map["videoCodecProfile"] as? Int {
        if let videoCodecProfile = AgoraVideoCodecProfileType(rawValue: videoCodecProfile) {
            transcoding.videoCodecProfile = videoCodecProfile
        }
    }
    if let backgroundColor = map["backgroundColor"] as? Dictionary<String, Any> {
        transcoding.backgroundColor = mapToColor(map: backgroundColor)
    }
    if let userConfigExtraInfo = map["userConfigExtraInfo"] as? String {
        transcoding.transcodingExtraInfo = userConfigExtraInfo
    }
    if let transcodingUsers = map["transcodingUsers"] as? Array<Any> {
        transcodingUsers.forEach { (item) in
            if let item = item as? Dictionary<String, Any> {
                transcoding.add(mapToTranscodingUser(map: item))
            }
        }
    }
    return transcoding
}

func mapToChannelMediaInfo(map: Dictionary<String, Any>) -> AgoraChannelMediaRelayInfo {
    let info = AgoraChannelMediaRelayInfo()
    if let channelName = map["channelName"] as? String {
        info.channelName = channelName
    }
    if let token = map["token"] as? String {
        info.token = token
    }
    if let uid = map["uid"] as? UInt {
        info.uid = uid
    }
    return info
}

func mapToChannelMediaRelayConfiguration(map: Dictionary<String, Any>) -> AgoraChannelMediaRelayConfiguration {
    let config = AgoraChannelMediaRelayConfiguration()
    if let srcInfo = map["srcInfo"] as? Dictionary<String, Any> {
        config.sourceInfo = mapToChannelMediaInfo(map: srcInfo)
    }
    if let destInfos = map["destInfos"] as? Array<Any> {
        destInfos.forEach { (item) in
            if let item = item as? Dictionary<String, Any> {
                let info = mapToChannelMediaInfo(map: item)
                config.setDestinationInfo(info, forChannelName: info.channelName ?? "")
            }
        }
    }
    return config
}

func mapToLastmileProbeConfig(map: Dictionary<String, Any>) -> AgoraLastmileProbeConfig {
    let config = AgoraLastmileProbeConfig()
    if let probeUplink = map["probeUplink"] as? Bool {
        config.probeUplink = probeUplink
    }
    if let probeDownlink = map["probeDownlink"] as? Bool {
        config.probeDownlink = probeDownlink
    }
    if let expectedUplinkBitrate = map["expectedUplinkBitrate"] as? Int {
        config.expectedUplinkBitrate = UInt(expectedUplinkBitrate)
    }
    if let expectedDownlinkBitrate = map["expectedDownlinkBitrate"] as? Int {
        config.expectedDownlinkBitrate = UInt(expectedDownlinkBitrate)
    }
    return config
}

func mapToWatermarkOptions(map: Dictionary<String, Any>) -> WatermarkOptions {
    let options = WatermarkOptions()
    if let visibleInPreview = map["visibleInPreview"] as? Bool {
        options.visibleInPreview = visibleInPreview
    }
    if let positionInLandscapeMode = map["positionInLandscapeMode"] as? Dictionary<String, Any> {
        options.positionInLandscapeMode = mapToRect(map: positionInLandscapeMode)
    }
    if let positionInPortraitMode = map["positionInPortraitMode"] as? Dictionary<String, Any> {
        options.positionInPortraitMode = mapToRect(map: positionInPortraitMode)
    }
    return options
}

func mapToLiveInjectStreamConfig(map: Dictionary<String, Any>) -> AgoraLiveInjectStreamConfig {
    let config = AgoraLiveInjectStreamConfig.default()
    config.size = mapToSize(map: map)
    if let videoGop = map["videoGop"] as? Int {
        config.videoGop = videoGop
    }
    if let videoFramerate = map["videoFramerate"] as? Int {
        config.videoFramerate = videoFramerate
    }
    if let videoBitrate = map["videoBitrate"] as? Int {
        config.videoBitrate = videoBitrate
    }
    if let audioSampleRate = map["audioSampleRate"] as? Int {
        if let audioSampleRate = AgoraAudioSampleRateType(rawValue: audioSampleRate) {
            config.audioSampleRate = audioSampleRate
        }
    }
    if let audioBitrate = map["audioBitrate"] as? Int {
        config.audioBitrate = audioBitrate
    }
    if let audioChannels = map["audioChannels"] as? Int {
        config.audioChannels = audioChannels
    }
    return config
}

func mapToCameraCapturerConfiguration(map: Dictionary<String, Any>) -> AgoraCameraCapturerConfiguration {
    let config = AgoraCameraCapturerConfiguration()
    if let preference = map["preference"] as? Int {
        if let preference = AgoraCameraCaptureOutputPreference(rawValue: preference) {
            config.preference = preference
        }
    }
    if let cameraDirection = map["cameraDirection"] as? Int {
        if let cameraDirection = AgoraCameraDirection(rawValue: cameraDirection) {
            config.cameraDirection = cameraDirection
        }
    }
    return config
}

func mapToChannelMediaOptions(map: Dictionary<String, Any>) -> AgoraRtcChannelMediaOptions {
    let options = AgoraRtcChannelMediaOptions()
    if let autoSubscribeAudio = map["autoSubscribeAudio"] as? Bool {
        options.autoSubscribeAudio = autoSubscribeAudio
    }
    if let autoSubscribeVideo = map["autoSubscribeVideo"] as? Bool {
        options.autoSubscribeVideo = autoSubscribeVideo
    }
    return options
}
