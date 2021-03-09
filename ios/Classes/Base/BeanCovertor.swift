//
//  BeanCovertor.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/9.
//  Copyright © 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

func mapToPoint(_ map: Dictionary<String, Any>) -> CGPoint {
    var point = CGPoint()
    if let x = map["x"] as? NSNumber {
        point.x = CGFloat(truncating: x)
    }
    if let y = map["y"] as? NSNumber {
        point.y = CGFloat(truncating: y)
    }
    return point
}

func mapToSize(_ map: Dictionary<String, Any>) -> CGSize {
    var size = CGSize()
    if let width = map["width"] as? NSNumber {
        size.width = CGFloat(truncating: width)
    }
    if let height = map["height"] as? NSNumber {
        size.height = CGFloat(truncating: height)
    }
    return size
}

func mapToRect(_ map: Dictionary<String, Any>) -> CGRect {
    return CGRect(
            origin: mapToPoint(map),
            size: mapToSize(map)
    )
}

func mapToVideoEncoderConfiguration(_ map: Dictionary<String, Any>) -> AgoraVideoEncoderConfiguration {
    let config = AgoraVideoEncoderConfiguration()
    if let dimensions = map["dimensions"] as? Dictionary<String, Any> {
        config.dimensions = mapToSize(dimensions)
    }
    if let frameRate = map["frameRate"] as? NSNumber {
        config.frameRate = frameRate.intValue
    }
    if let minFrameRate = map["minFrameRate"] as? NSNumber {
        config.minFrameRate = minFrameRate.intValue
    }
    if let bitrate = map["bitrate"] as? NSNumber {
        config.bitrate = bitrate.intValue
    }
    if let minBitrate = map["minBitrate"] as? NSNumber {
        config.minBitrate = minBitrate.intValue
    }
    if let orientationMode = map["orientationMode"] as? NSNumber {
        if let orientationMode = AgoraVideoOutputOrientationMode(rawValue: orientationMode.intValue) {
            config.orientationMode = orientationMode
        }
    }
    if let degradationPreference = map["degradationPrefer"] as? NSNumber {
        if let degradationPreference = AgoraDegradationPreference(rawValue: degradationPreference.intValue) {
            config.degradationPreference = degradationPreference
        }
    }
    if let mirrorMode = map["mirrorMode"] as? NSNumber {
        if let mirrorMode = AgoraVideoMirrorMode(rawValue: mirrorMode.uintValue) {
            config.mirrorMode = mirrorMode
        }
    }
    return config
}

func mapToBeautyOptions(_ map: Dictionary<String, Any>) -> AgoraBeautyOptions {
    let options = AgoraBeautyOptions()
    if let lighteningContrastLevel = map["lighteningContrastLevel"] as? NSNumber {
        if let lighteningContrastLevel = AgoraLighteningContrastLevel(rawValue: lighteningContrastLevel.uintValue) {
            options.lighteningContrastLevel = lighteningContrastLevel
        }
    }
    if let lighteningLevel = map["lighteningLevel"] as? NSNumber {
        options.lighteningLevel = lighteningLevel.floatValue
    }
    if let smoothnessLevel = map["smoothnessLevel"] as? NSNumber {
        options.smoothnessLevel = smoothnessLevel.floatValue
    }
    if let rednessLevel = map["rednessLevel"] as? NSNumber {
        options.rednessLevel = rednessLevel.floatValue
    }
    return options
}

func mapToAgoraImage(_ map: Dictionary<String, Any>) -> AgoraImage {
    let image = AgoraImage()
    if let url = map["url"] as? String {
        if let url = URL(string: url) {
            image.url = url
        }
    }
    image.rect = mapToRect(map)
    return image
}

func mapToTranscodingUser(_ map: Dictionary<String, Any>) -> AgoraLiveTranscodingUser {
    let user = AgoraLiveTranscodingUser()
    if let uid = map["uid"] as? NSNumber {
        user.uid = uid.uintValue
    }
    user.rect = mapToRect(map)
    if let zOrder = map["zOrder"] as? NSNumber {
        user.zOrder = zOrder.intValue
    }
    if let alpha = map["alpha"] as? NSNumber {
        user.alpha = alpha.doubleValue
    }
    if let audioChannel = map["audioChannel"] as? NSNumber {
        user.audioChannel = audioChannel.intValue
    }
    return user
}

func mapToColor(_ map: Dictionary<String, Any>) -> UIColor {
    return UIColor(
        red: CGFloat((map["red"] as! NSNumber).intValue),
        green: CGFloat((map["green"] as! NSNumber).intValue),
        blue: CGFloat((map["blue"] as! NSNumber).intValue),
        alpha: 1.0
    )
}

func mapToLiveTranscoding(_ map: Dictionary<String, Any>) -> AgoraLiveTranscoding {
    let transcoding = AgoraLiveTranscoding.default()
    transcoding.size = mapToSize(map)
    if let videoBitrate = map["videoBitrate"] as? NSNumber {
        transcoding.videoBitrate = videoBitrate.intValue
    }
    if let videoFramerate = map["videoFramerate"] as? NSNumber {
        transcoding.videoFramerate = videoFramerate.intValue
    }
    if let lowLatency = map["lowLatency"] as? Bool {
        transcoding.lowLatency = lowLatency
    }
    if let videoGop = map["videoGop"] as? NSNumber {
        transcoding.videoGop = videoGop.intValue
    }
    if let watermark = map["watermark"] as? Dictionary<String, Any> {
        transcoding.watermark = mapToAgoraImage(watermark)
    }
    if let backgroundImage = map["backgroundImage"] as? Dictionary<String, Any> {
        transcoding.backgroundImage = mapToAgoraImage(backgroundImage)
    }
    if let audioSampleRate = map["audioSampleRate"] as? NSNumber {
        if let audioSampleRate = AgoraAudioSampleRateType(rawValue: audioSampleRate.intValue) {
            transcoding.audioSampleRate = audioSampleRate
        }
    }
    if let audioBitrate = map["audioBitrate"] as? NSNumber {
        transcoding.audioBitrate = audioBitrate.intValue
    }
    if let audioChannels = map["audioChannels"] as? NSNumber {
        transcoding.audioChannels = audioChannels.intValue
    }
    if let audioCodecProfile = map["audioCodecProfile"] as? NSNumber {
        if let audioCodecProfile = AgoraAudioCodecProfileType(rawValue: audioCodecProfile.intValue) {
            transcoding.audioCodecProfile = audioCodecProfile
        }
    }
    if let videoCodecProfile = map["videoCodecProfile"] as? NSNumber {
        if let videoCodecProfile = AgoraVideoCodecProfileType(rawValue: videoCodecProfile.intValue) {
            transcoding.videoCodecProfile = videoCodecProfile
        }
    }
    if let backgroundColor = map["backgroundColor"] as? Dictionary<String, Any> {
        transcoding.backgroundColor = mapToColor(backgroundColor)
    }
    if let userConfigExtraInfo = map["userConfigExtraInfo"] as? String {
        transcoding.transcodingExtraInfo = userConfigExtraInfo
    }
    if let transcodingUsers = map["transcodingUsers"] as? Array<Any> {
        transcodingUsers.forEach {
            if let item = $0 as? Dictionary<String, Any> {
                transcoding.add(mapToTranscodingUser(item))
            }
        }
    }
    return transcoding
}

func mapToChannelMediaInfo(_ map: Dictionary<String, Any>) -> AgoraChannelMediaRelayInfo {
    let info = AgoraChannelMediaRelayInfo()
    if let channelName = map["channelName"] as? String {
        info.channelName = channelName
    }
    if let token = map["token"] as? String {
        info.token = token
    }
    if let uid = map["uid"] as? NSNumber {
        info.uid = uid.uintValue
    }
    return info
}

func mapToChannelMediaRelayConfiguration(_ map: Dictionary<String, Any>) -> AgoraChannelMediaRelayConfiguration {
    let config = AgoraChannelMediaRelayConfiguration()
    if let srcInfo = map["srcInfo"] as? Dictionary<String, Any> {
        config.sourceInfo = mapToChannelMediaInfo(srcInfo)
    }
    if let destInfos = map["destInfos"] as? Array<Any> {
        destInfos.forEach {
            if let item = $0 as? Dictionary<String, Any> {
                let info = mapToChannelMediaInfo(item)
                config.setDestinationInfo(info, forChannelName: info.channelName ?? "")
            }
        }
    }
    return config
}

func mapToLastmileProbeConfig(_ map: Dictionary<String, Any>) -> AgoraLastmileProbeConfig {
    let config = AgoraLastmileProbeConfig()
    if let probeUplink = map["probeUplink"] as? Bool {
        config.probeUplink = probeUplink
    }
    if let probeDownlink = map["probeDownlink"] as? Bool {
        config.probeDownlink = probeDownlink
    }
    if let expectedUplinkBitrate = map["expectedUplinkBitrate"] as? NSNumber {
        config.expectedUplinkBitrate = expectedUplinkBitrate.uintValue
    }
    if let expectedDownlinkBitrate = map["expectedDownlinkBitrate"] as? NSNumber {
        config.expectedDownlinkBitrate = expectedDownlinkBitrate.uintValue
    }
    return config
}

func mapToWatermarkOptions(_ map: Dictionary<String, Any>) -> WatermarkOptions {
    let options = WatermarkOptions()
    if let visibleInPreview = map["visibleInPreview"] as? Bool {
        options.visibleInPreview = visibleInPreview
    }
    if let positionInLandscapeMode = map["positionInLandscapeMode"] as? Dictionary<String, Any> {
        options.positionInLandscapeMode = mapToRect(positionInLandscapeMode)
    }
    if let positionInPortraitMode = map["positionInPortraitMode"] as? Dictionary<String, Any> {
        options.positionInPortraitMode = mapToRect(positionInPortraitMode)
    }
    return options
}

func mapToLiveInjectStreamConfig(_ map: Dictionary<String, Any>) -> AgoraLiveInjectStreamConfig {
    let config = AgoraLiveInjectStreamConfig.default()
    config.size = mapToSize(map)
    if let videoGop = map["videoGop"] as? NSNumber {
        config.videoGop = videoGop.intValue
    }
    if let videoFramerate = map["videoFramerate"] as? NSNumber {
        config.videoFramerate = videoFramerate.intValue
    }
    if let videoBitrate = map["videoBitrate"] as? NSNumber {
        config.videoBitrate = videoBitrate.intValue
    }
    if let audioSampleRate = map["audioSampleRate"] as? NSNumber {
        if let audioSampleRate = AgoraAudioSampleRateType(rawValue: audioSampleRate.intValue) {
            config.audioSampleRate = audioSampleRate
        }
    }
    if let audioBitrate = map["audioBitrate"] as? NSNumber {
        config.audioBitrate = audioBitrate.intValue
    }
    if let audioChannels = map["audioChannels"] as? NSNumber {
        config.audioChannels = audioChannels.intValue
    }
    return config
}

func mapToCameraCapturerConfiguration(_ map: Dictionary<String, Any>) -> AgoraCameraCapturerConfiguration {
    let config = AgoraCameraCapturerConfiguration()
    if let preference = map["preference"] as? NSNumber {
        if let preference = AgoraCameraCaptureOutputPreference(rawValue: preference.intValue) {
            config.preference = preference
        }
    }
    if let captureWidth = map["captureWidth"] as? NSNumber {
        config.captureWidth = captureWidth.int32Value
    }
    if let captureHeight = map["captureHeight"] as? NSNumber {
        config.captureHeight = captureHeight.int32Value
    }
    if let cameraDirection = map["cameraDirection"] as? NSNumber {
        if let cameraDirection = AgoraCameraDirection(rawValue: cameraDirection.intValue) {
            config.cameraDirection = cameraDirection
        }
    }
    return config
}

func mapToChannelMediaOptions(_ map: Dictionary<String, Any>) -> AgoraRtcChannelMediaOptions {
    let options = AgoraRtcChannelMediaOptions()
    if let autoSubscribeAudio = map["autoSubscribeAudio"] as? Bool {
        options.autoSubscribeAudio = autoSubscribeAudio
    }
    if let autoSubscribeVideo = map["autoSubscribeVideo"] as? Bool {
        options.autoSubscribeVideo = autoSubscribeVideo
    }
    return options
}

func mapToRtcEngineConfig(_ map: Dictionary<String, Any>) -> AgoraRtcEngineConfig {
    let config = AgoraRtcEngineConfig()
    config.appId = map["appId"] as? String
    if let areaCode = map["areaCode"] as? NSNumber {
        config.areaCode = areaCode.uintValue
    }
    if let logConfig = map["logConfig"] as? Dictionary<String, Any> {
        config.logConfig = mapToLogConfig(logConfig)
    }
    return config
}

func mapToEncryptionConfig(_ map: Dictionary<String, Any>) -> AgoraEncryptionConfig {
    let config = AgoraEncryptionConfig()
    if let encryptionMode = map["encryptionMode"] as? NSNumber {
        if let encryptionMode = AgoraEncryptionMode(rawValue: encryptionMode.intValue) {
            config.encryptionMode = encryptionMode
        }
    }
    if let encryptionKey = map["encryptionKey"] as? String {
        config.encryptionKey = encryptionKey
    }
    return config
}

func mapToClientRoleOptions(_ map: Dictionary<String, Any>) -> AgoraClientRoleOptions {
    let options = AgoraClientRoleOptions()
    if let audienceLatencyLevel = map["audienceLatencyLevel"] as? NSNumber {
        if let audienceLatencyLevel = AgoraAudienceLatencyLevelType(rawValue: audienceLatencyLevel.intValue) {
            options.audienceLatencyLevel = audienceLatencyLevel
        }
    }
    return options
}

func mapToLogConfig(_ map: Dictionary<String, Any>) -> AgoraLogConfig {
    let config = AgoraLogConfig()
    config.filePath = map["filePath"] as? String
    if let fileSize = map["fileSize"] as? NSNumber {
        config.fileSize = fileSize.intValue
    }
    if let level = map["level"] as? NSNumber {
        if let level = AgoraLogLevel.init(rawValue: level.intValue) {
            config.level = level;
        }
    }
    return config
}

func mapToDataStreamConfig(_ map: Dictionary<String, Any>) -> AgoraDataStreamConfig {
    let config = AgoraDataStreamConfig()
    if let syncWithAudio = map["syncWithAudio"] as? Bool {
        config.syncWithAudio = syncWithAudio
    }
    if let ordered = map["ordered"] as? Bool {
        config.ordered = ordered
    }
    return config
}
