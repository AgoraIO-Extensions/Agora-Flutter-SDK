//
//  RtcEngine.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/13.
//  Copyright (c) 2020 Syan. All rights reserved.
//

import Foundation
import AgoraRtcKit

protocol RtcEngineInterface:
        RtcEngineUserInfoInterface,
        RtcEngineAudioInterface,
        RtcEngineVideoInterface,
        RtcEngineAudioMixingInterface,
        RtcEngineAudioEffectInterface,
        RtcEngineVoiceChangerInterface,
        RtcEngineVoicePositionInterface,
        RtcEnginePublishStreamInterface,
        RtcEngineMediaRelayInterface,
        RtcEngineAudioRouteInterface,
        RtcEngineEarMonitoringInterface,
        RtcEngineDualStreamInterface,
        RtcEngineFallbackInterface,
        RtcEngineTestInterface,
        RtcEngineMediaMetadataInterface,
        RtcEngineWatermarkInterface,
        RtcEngineEncryptionInterface,
        RtcEngineAudioRecorderInterface,
        RtcEngineInjectStreamInterface,
        RtcEngineCameraInterface,
        RtcEngineStreamMessageInterface {
    func create(_ params: NSDictionary, _ callback: Callback)

    func destroy(_ callback: Callback)

    func setChannelProfile(_ params: NSDictionary, _ callback: Callback)

    func setClientRole(_ params: NSDictionary, _ callback: Callback)

    func joinChannel(_ params: NSDictionary, _ callback: Callback)

    func switchChannel(_ params: NSDictionary, _ callback: Callback)

    func leaveChannel(_ callback: Callback)

    func renewToken(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func enableWebSdkInteroperability(_ params: NSDictionary, _ callback: Callback)

    func getConnectionState(_ callback: Callback)

    func sendCustomReportMessage(_ params: NSDictionary, _ callback: Callback)

    func getCallId(_ callback: Callback)

    func rate(_ params: NSDictionary, _ callback: Callback)

    func complain(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setLogFile(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setLogFilter(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setLogFileSize(_ params: NSDictionary, _ callback: Callback)

    func setParameters(_ params: NSDictionary, _ callback: Callback)
    
    func getSdkVersion(callback: Callback)

    func getErrorDescription(_ params: NSDictionary, callback: Callback)

    func getNativeHandle(_ callback: Callback)
    
    func enableDeepLearningDenoise(_ params: NSDictionary, callback: Callback)

    func setCloudProxy(_ params: NSDictionary, callback: Callback)

    func uploadLogFile(callback: Callback)
}

protocol RtcEngineUserInfoInterface {
    func registerLocalUserAccount(_ params: NSDictionary, _ callback: Callback)

    func joinChannelWithUserAccount(_ params: NSDictionary, _ callback: Callback)

    func getUserInfoByUserAccount(_ params: NSDictionary, _ callback: Callback)

    func getUserInfoByUid(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineAudioInterface {
    func enableAudio(_ callback: Callback)

    func disableAudio(_ callback: Callback)

    func setAudioProfile(_ params: NSDictionary, _ callback: Callback)

    func adjustRecordingSignalVolume(_ params: NSDictionary, _ callback: Callback)

    func adjustUserPlaybackSignalVolume(_ params: NSDictionary, _ callback: Callback)

    func adjustPlaybackSignalVolume(_ params: NSDictionary, _ callback: Callback)

    func enableLocalAudio(_ params: NSDictionary, _ callback: Callback)

    func muteLocalAudioStream(_ params: NSDictionary, _ callback: Callback)

    func muteRemoteAudioStream(_ params: NSDictionary, _ callback: Callback)

    func muteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setDefaultMuteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback)

    func enableAudioVolumeIndication(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineVideoInterface {
    func enableVideo(_ callback: Callback)

    func disableVideo(_ callback: Callback)

    func setVideoEncoderConfiguration(_ params: NSDictionary, _ callback: Callback)

    func startPreview(_ callback: Callback)

    func stopPreview(_ callback: Callback)

    func enableLocalVideo(_ params: NSDictionary, _ callback: Callback)

    func muteLocalVideoStream(_ params: NSDictionary, _ callback: Callback)

    func muteRemoteVideoStream(_ params: NSDictionary, _ callback: Callback)

    func muteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setDefaultMuteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback)

    func setBeautyEffectOptions(_ params: NSDictionary, _ callback: Callback)
    
    func enableRemoteSuperResolution(_ params: NSDictionary, callback: Callback)
}

protocol RtcEngineAudioMixingInterface {
    func startAudioMixing(_ params: NSDictionary, _ callback: Callback)

    func stopAudioMixing(_ callback: Callback)

    func pauseAudioMixing(_ callback: Callback)

    func resumeAudioMixing(_ callback: Callback)

    func adjustAudioMixingVolume(_ params: NSDictionary, _ callback: Callback)

    func adjustAudioMixingPlayoutVolume(_ params: NSDictionary, _ callback: Callback)

    func adjustAudioMixingPublishVolume(_ params: NSDictionary, _ callback: Callback)

    func getAudioMixingPlayoutVolume(_ callback: Callback)

    func getAudioMixingPublishVolume(_ callback: Callback)

    func getAudioMixingDuration(_ callback: Callback)

    func getAudioMixingCurrentPosition(_ callback: Callback)

    func setAudioMixingPosition(_ params: NSDictionary, _ callback: Callback)

    func setAudioMixingPitch(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineAudioEffectInterface {
    func getEffectsVolume(_ callback: Callback)

    func setEffectsVolume(_ params: NSDictionary, _ callback: Callback)

    func setVolumeOfEffect(_ params: NSDictionary, _ callback: Callback)

    func playEffect(_ params: NSDictionary, _ callback: Callback)

    func stopEffect(_ params: NSDictionary, _ callback: Callback)

    func stopAllEffects(_ callback: Callback)

    func preloadEffect(_ params: NSDictionary, _ callback: Callback)

    func unloadEffect(_ params: NSDictionary, _ callback: Callback)

    func pauseEffect(_ params: NSDictionary, _ callback: Callback)

    func pauseAllEffects(_ callback: Callback)

    func resumeEffect(_ params: NSDictionary, _ callback: Callback)

    func resumeAllEffects(_ callback: Callback)

    func setAudioSessionOperationRestriction(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineVoiceChangerInterface {
    @available(*, deprecated)
    func setLocalVoiceChanger(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setLocalVoiceReverbPreset(_ params: NSDictionary, _ callback: Callback)

    func setLocalVoicePitch(_ params: NSDictionary, _ callback: Callback)

    func setLocalVoiceEqualization(_ params: NSDictionary, _ callback: Callback)

    func setLocalVoiceReverb(_ params: NSDictionary, _ callback: Callback)
    
    func setAudioEffectPreset(_ params: NSDictionary, _ callback: Callback)

    func setVoiceBeautifierPreset(_ params: NSDictionary, _ callback: Callback)
    
    func setVoiceConversionPreset(_ params: NSDictionary, _ callback: Callback)

    func setAudioEffectParameters(_ params: NSDictionary, _ callback: Callback)
    
    func setVoiceBeautifierParameters(_ params: NSDictionary, callback: Callback)
}

protocol RtcEngineVoicePositionInterface {
    func enableSoundPositionIndication(_ params: NSDictionary, _ callback: Callback)

    func setRemoteVoicePosition(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEnginePublishStreamInterface {
    func setLiveTranscoding(_ params: NSDictionary, _ callback: Callback)

    func addPublishStreamUrl(_ params: NSDictionary, _ callback: Callback)

    func removePublishStreamUrl(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineMediaRelayInterface {
    func startChannelMediaRelay(_ params: NSDictionary, _ callback: Callback)

    func updateChannelMediaRelay(_ params: NSDictionary, _ callback: Callback)

    func stopChannelMediaRelay(_ callback: Callback)
}

protocol RtcEngineAudioRouteInterface {
    func setDefaultAudioRoutetoSpeakerphone(_ params: NSDictionary, _ callback: Callback)

    func setEnableSpeakerphone(_ params: NSDictionary, _ callback: Callback)

    func isSpeakerphoneEnabled(_ callback: Callback)
}

protocol RtcEngineEarMonitoringInterface {
    func enableInEarMonitoring(_ params: NSDictionary, _ callback: Callback)

    func setInEarMonitoringVolume(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineDualStreamInterface {
    func enableDualStreamMode(_ params: NSDictionary, _ callback: Callback)

    func setRemoteVideoStreamType(_ params: NSDictionary, _ callback: Callback)

    func setRemoteDefaultVideoStreamType(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineFallbackInterface {
    func setLocalPublishFallbackOption(_ params: NSDictionary, _ callback: Callback)

    func setRemoteSubscribeFallbackOption(_ params: NSDictionary, _ callback: Callback)

    func setRemoteUserPriority(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineTestInterface {
    func startEchoTest(_ params: NSDictionary, _ callback: Callback)

    func stopEchoTest(_ callback: Callback)

    func enableLastmileTest(_ callback: Callback)

    func disableLastmileTest(_ callback: Callback)

    func startLastmileProbeTest(_ params: NSDictionary, _ callback: Callback)

    func stopLastmileProbeTest(_ callback: Callback)
}

protocol RtcEngineMediaMetadataInterface {
    func registerMediaMetadataObserver(_ callback: Callback)

    func unregisterMediaMetadataObserver(_ callback: Callback)

    func setMaxMetadataSize(_ params: NSDictionary, _ callback: Callback)

    func sendMetadata(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineWatermarkInterface {
    func addVideoWatermark(_ params: NSDictionary, _ callback: Callback)

    func clearVideoWatermarks(_ callback: Callback)
}

protocol RtcEngineEncryptionInterface {
    @available(*, deprecated)
    func setEncryptionSecret(_ params: NSDictionary, _ callback: Callback)

    @available(*, deprecated)
    func setEncryptionMode(_ params: NSDictionary, _ callback: Callback)

    func enableEncryption(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineAudioRecorderInterface {
    func startAudioRecording(_ params: NSDictionary, _ callback: Callback)

    func stopAudioRecording(_ callback: Callback)
}

protocol RtcEngineInjectStreamInterface {
    func addInjectStreamUrl(_ params: NSDictionary, _ callback: Callback)

    func removeInjectStreamUrl(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineCameraInterface {
    func switchCamera(_ callback: Callback)

    func isCameraZoomSupported(_ callback: Callback)

    func isCameraTorchSupported(_ callback: Callback)

    func isCameraFocusSupported(_ callback: Callback)

    func isCameraExposurePositionSupported(_ callback: Callback)

    func isCameraAutoFocusFaceModeSupported(_ callback: Callback)

    func setCameraZoomFactor(_ params: NSDictionary, _ callback: Callback)

    func getCameraMaxZoomFactor(_ callback: Callback)

    func setCameraFocusPositionInPreview(_ params: NSDictionary, _ callback: Callback)

    func setCameraExposurePosition(_ params: NSDictionary, _ callback: Callback)

    func enableFaceDetection(_ params: NSDictionary, _ callback: Callback)

    func setCameraTorchOn(_ params: NSDictionary, _ callback: Callback)

    func setCameraAutoFocusFaceModeEnabled(_ params: NSDictionary, _ callback: Callback)

    func setCameraCapturerConfiguration(_ params: NSDictionary, _ callback: Callback)
}

protocol RtcEngineStreamMessageInterface {
    func createDataStream(_ params: NSDictionary, _ callback: Callback)

    func sendStreamMessage(_ params: NSDictionary, _ callback: Callback)
}

@objc
class RtcEngineManager: NSObject, RtcEngineInterface {
    private var emitter: (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void
    private(set) var engine: AgoraRtcEngineKit?
    private var delegate: RtcEngineEventHandler?
    private var mediaObserver: MediaObserver?

    init(_ emitter: @escaping (_ methodName: String, _ data: Dictionary<String, Any?>?) -> Void) {
        self.emitter = emitter
    }

    func Release() {
        AgoraRtcEngineKit.destroy()
        engine = nil
        delegate = nil
        mediaObserver = nil
    }

    @objc func create(_ params: NSDictionary, _ callback: Callback) {
        delegate = RtcEngineEventHandler() { [weak self] in
            self?.emitter($0, $1)
        }
        engine = AgoraRtcEngineKit.sharedEngine(with: mapToRtcEngineConfig(params["config"] as! Dictionary), delegate: delegate)
        callback.code(engine?.setAppType(AgoraRtcAppType(rawValue: params["appType"] as! UInt)!))
    }

    @objc func destroy(_ callback: Callback) {
        callback.resolve(engine) { [weak self] _ in
            self?.Release()
        }
    }

    @objc func setChannelProfile(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setChannelProfile(AgoraChannelProfile(rawValue: params["profile"] as! Int)!))
    }

    @objc func setClientRole(_ params: NSDictionary, _ callback: Callback) {
        let role = AgoraClientRole(rawValue: params["role"] as! Int)!
        if let options = params["options"] as? Dictionary<String, Any> {
            callback.code(engine?.setClientRole(role, options: mapToClientRoleOptions(options)))
            return
        }
        callback.code(engine?.setClientRole(role))
    }

    @objc func joinChannel(_ params: NSDictionary, _ callback: Callback) {
        let token = params["token"] as? String
        let channelName = params["channelName"] as! String
        let optionalInfo = params["optionalInfo"] as? String
        let optionalUid = params["optionalUid"] as! UInt
        if let options = params["options"] as? Dictionary<String, Any> {
            callback.code(engine?.joinChannel(byToken: token, channelId: channelName, info: optionalInfo, uid: optionalUid, options: mapToChannelMediaOptions(options)))
            return
        }
        callback.code(engine?.joinChannel(byToken: token, channelId: channelName, info: optionalInfo, uid: optionalUid))
    }

    @objc func switchChannel(_ params: NSDictionary, _ callback: Callback) {
        let token = params["token"] as? String
        let channelName = params["channelName"] as! String
        if let options = params["options"] as? Dictionary<String, Any> {
            callback.code(engine?.switchChannel(byToken: token, channelId: channelName, options: mapToChannelMediaOptions(options)))
            return
        }
        callback.code(engine?.switchChannel(byToken: token, channelId: channelName))
    }

    @objc func leaveChannel(_ callback: Callback) {
        callback.code(engine?.leaveChannel())
    }

    @objc func renewToken(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.renewToken(params["token"] as! String))
    }

    @objc func enableWebSdkInteroperability(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableWebSdkInteroperability(params["enabled"] as! Bool))
    }

    @objc func getConnectionState(_ callback: Callback) {
        callback.resolve(engine) {
            $0.getConnectionState().rawValue
        }
    }

    @objc func sendCustomReportMessage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.sendCustomReportMessage(params["id"] as! String, category: params["category"] as! String, event: params["event"] as! String, label: params["label"] as! String, value: params["value"] as! Int))
    }

    @objc func getCallId(_ callback: Callback) {
        callback.resolve(engine) {
            $0.getCallId()
        }
    }

    @objc func rate(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.rate(params["callId"] as! String, rating: params["rating"] as! Int, description: params["description"] as? String))
    }

    @objc func complain(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.complain(params["callId"] as! String, description: params["description"] as? String))
    }

    @objc func setLogFile(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLogFile(params["filePath"] as! String))
    }

    @objc func setLogFilter(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLogFilter(params["filter"] as! UInt))
    }

    @objc func setLogFileSize(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLogFileSize((params["fileSizeInKBytes"] as! UInt)))
    }

    @objc func getNativeHandle(_ callback: Callback) {
        callback.resolve(engine) {
            Int(bitPattern: $0.getNativeHandle())
        }
    }

    @objc func setParameters(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setParameters(params["parameters"] as! String))
    }

    @objc func registerLocalUserAccount(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.registerLocalUserAccount(params["userAccount"] as! String, appId: params["appId"] as! String))
    }

    @objc func joinChannelWithUserAccount(_ params: NSDictionary, _ callback: Callback) {
        let userAccount = params["userAccount"] as! String
        let token = params["token"] as? String
        let channelName = params["channelName"] as! String
        if let options = params["options"] as? Dictionary<String, Any> {
            callback.code(engine?.joinChannel(byUserAccount: userAccount, token: token, channelId: channelName, options: mapToChannelMediaOptions(options)))
            return
        }
        callback.code(engine?.joinChannel(byUserAccount: userAccount, token: token, channelId: channelName))
    }

    @objc func getUserInfoByUserAccount(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.getUserInfo(byUserAccount: params["userAccount"] as! String, withError: nil)?.toMap()
        }
    }

    @objc func getUserInfoByUid(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.getUserInfo(byUid: params["uid"] as! UInt, withError: nil)?.toMap()
        }
    }

    @objc func enableAudio(_ callback: Callback) {
        callback.code(engine?.enableAudio())
    }

    @objc func disableAudio(_ callback: Callback) {
        callback.code(engine?.disableAudio())
    }

    @objc func setAudioProfile(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setAudioProfile(AgoraAudioProfile(rawValue: params["profile"] as! Int)!, scenario: AgoraAudioScenario(rawValue: params["scenario"] as! Int)!))
    }

    @objc func adjustRecordingSignalVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.adjustRecordingSignalVolume(params["volume"] as! Int))
    }

    @objc func adjustUserPlaybackSignalVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.adjustUserPlaybackSignalVolume(params["uid"] as! UInt, volume: params["volume"] as! Int32))
    }

    @objc func adjustPlaybackSignalVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.adjustPlaybackSignalVolume(params["volume"] as! Int))
    }

    @objc func enableLocalAudio(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableLocalAudio(params["enabled"] as! Bool))
    }

    @objc func muteLocalAudioStream(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.muteLocalAudioStream(params["muted"] as! Bool))
    }

    @objc func muteRemoteAudioStream(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.muteRemoteAudioStream(params["uid"] as! UInt, mute: params["muted"] as! Bool))
    }

    @objc func muteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.muteAllRemoteAudioStreams(params["muted"] as! Bool))
    }

    @objc func setDefaultMuteAllRemoteAudioStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setDefaultMuteAllRemoteAudioStreams(params["muted"] as! Bool))
    }

    @objc func enableAudioVolumeIndication(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableAudioVolumeIndication(params["interval"] as! Int, smooth: params["smooth"] as! Int, report_vad: params["report_vad"] as! Bool))
    }

    @objc func enableVideo(_ callback: Callback) {
        callback.code(engine?.enableVideo())
    }

    @objc func disableVideo(_ callback: Callback) {
        callback.code(engine?.disableVideo())
    }

    @objc func setVideoEncoderConfiguration(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setVideoEncoderConfiguration(mapToVideoEncoderConfiguration(params["config"] as! Dictionary)))
    }

    @objc func startPreview(_ callback: Callback) {
        callback.code(engine?.startPreview())
    }

    @objc func stopPreview(_ callback: Callback) {
        callback.code(engine?.stopPreview())
    }

    @objc func enableLocalVideo(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableLocalVideo(params["enabled"] as! Bool))
    }

    @objc func muteLocalVideoStream(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.muteLocalVideoStream(params["muted"] as! Bool))
    }

    @objc func muteRemoteVideoStream(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.muteRemoteVideoStream(params["uid"] as! UInt, mute: params["muted"] as! Bool))
    }

    @objc func muteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.muteAllRemoteVideoStreams(params["muted"] as! Bool))
    }

    @objc func setDefaultMuteAllRemoteVideoStreams(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setDefaultMuteAllRemoteVideoStreams(params["muted"] as! Bool))
    }

    @objc func setBeautyEffectOptions(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setBeautyEffectOptions(params["enabled"] as! Bool, options: mapToBeautyOptions(params["options"] as! Dictionary)))
    }

    @objc func startAudioMixing(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.startAudioMixing(params["filePath"] as! String, loopback: params["loopback"] as! Bool, replace: params["replace"] as! Bool, cycle: params["cycle"] as! Int))
    }

    @objc func stopAudioMixing(_ callback: Callback) {
        callback.code(engine?.stopAudioMixing())
    }

    @objc func pauseAudioMixing(_ callback: Callback) {
        callback.code(engine?.pauseAudioMixing())
    }

    @objc func resumeAudioMixing(_ callback: Callback) {
        callback.code(engine?.resumeAudioMixing())
    }

    @objc func adjustAudioMixingVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.adjustAudioMixingVolume(params["volume"] as! Int))
    }

    @objc func adjustAudioMixingPlayoutVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.adjustAudioMixingPlayoutVolume(params["volume"] as! Int))
    }

    @objc func adjustAudioMixingPublishVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.adjustAudioMixingPublishVolume(params["volume"] as! Int))
    }

    @objc func getAudioMixingPlayoutVolume(_ callback: Callback) {
        callback.code(engine?.getAudioMixingPlayoutVolume()) {
            $0
        }
    }

    @objc func getAudioMixingPublishVolume(_ callback: Callback) {
        callback.code(engine?.getAudioMixingPublishVolume()) {
            $0
        }
    }

    @objc func getAudioMixingDuration(_ callback: Callback) {
        callback.code(engine?.getAudioMixingDuration()) {
            $0
        }
    }

    @objc func getAudioMixingCurrentPosition(_ callback: Callback) {
        callback.code(engine?.getAudioMixingCurrentPosition()) {
            $0
        }
    }

    @objc func setAudioMixingPosition(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setAudioMixingPosition(params["pos"] as! Int))
    }

    @objc func setAudioMixingPitch(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setAudioMixingPitch(params["pitch"] as! Int))
    }

    @objc func getEffectsVolume(_ callback: Callback) {
        callback.resolve(engine) {
            $0.getEffectsVolume()
        }
    }

    @objc func setEffectsVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setEffectsVolume(params["volume"] as! Double))
    }

    @objc func setVolumeOfEffect(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setVolumeOfEffect(params["soundId"] as! Int32, withVolume: params["volume"] as! Double))
    }

    @objc func playEffect(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.playEffect(params["soundId"] as! Int32, filePath: params["filePath"] as? String, loopCount: params["loopCount"] as! Int32, pitch: params["pitch"] as! Double, pan: params["pan"] as! Double, gain: params["gain"] as! Double, publish: params["publish"] as! Bool))
    }

    @objc func stopEffect(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.stopEffect(params["soundId"] as! Int32))
    }

    @objc func stopAllEffects(_ callback: Callback) {
        callback.code(engine?.stopAllEffects())
    }

    @objc func preloadEffect(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.preloadEffect(params["soundId"] as! Int32, filePath: params["filePath"] as? String))
    }

    @objc func unloadEffect(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.unloadEffect(params["soundId"] as! Int32))
    }

    @objc func pauseEffect(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.pauseEffect(params["soundId"] as! Int32))
    }

    @objc func pauseAllEffects(_ callback: Callback) {
        callback.code(engine?.pauseAllEffects())
    }

    @objc func resumeEffect(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.resumeEffect(params["soundId"] as! Int32))
    }

    @objc func resumeAllEffects(_ callback: Callback) {
        callback.code(engine?.resumeAllEffects())
    }

    @objc func setAudioSessionOperationRestriction(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.setAudioSessionOperationRestriction(AgoraAudioSessionOperationRestriction(rawValue: params["restriction"] as! UInt))
        }
    }

    @objc func setLocalVoiceChanger(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLocalVoiceChanger(AgoraAudioVoiceChanger(rawValue: params["voiceChanger"] as! Int)!))
    }

    @objc func setLocalVoiceReverbPreset(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLocalVoiceReverbPreset(AgoraAudioReverbPreset(rawValue: params["preset"] as! Int)!))
    }

    @objc func setLocalVoicePitch(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLocalVoicePitch(params["pitch"] as! Double))
    }

    @objc func setLocalVoiceEqualization(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLocalVoiceEqualizationOf(AgoraAudioEqualizationBandFrequency(rawValue: params["bandFrequency"] as! Int)!, withGain: params["bandGain"] as! Int))
    }

    @objc func setLocalVoiceReverb(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLocalVoiceReverbOf(AgoraAudioReverbType(rawValue: params["reverbKey"] as! Int)!, withValue: params["value"] as! Int))
    }
    
    @objc func setAudioEffectPreset(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setAudioEffectPreset(AgoraAudioEffectPreset(rawValue: params["preset"] as! Int)!))
    }
    
    @objc func setVoiceBeautifierPreset(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setVoiceBeautifierPreset(AgoraVoiceBeautifierPreset(rawValue: params["preset"] as! Int)!))
    }
    
    @objc func setVoiceConversionPreset(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setVoiceConversionPreset(AgoraVoiceConversionPreset(rawValue: params["preset"] as! Int)!))
    }
    
    @objc func setAudioEffectParameters(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setAudioEffectParameters(AgoraAudioEffectPreset(rawValue: params["preset"] as! Int)!, param1: params["param1"] as! Int32, param2: params["param2"] as! Int32))
    }

    @objc func enableSoundPositionIndication(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableSoundPositionIndication(params["enabled"] as! Bool))
    }

    @objc func setRemoteVoicePosition(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setRemoteVoicePosition(params["uid"] as! UInt, pan: params["pan"] as! Double, gain: params["gain"] as! Double))
    }

    @objc func setLiveTranscoding(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLiveTranscoding(mapToLiveTranscoding(params["transcoding"] as! Dictionary)))
    }

    @objc func addPublishStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.addPublishStreamUrl(params["url"] as! String, transcodingEnabled: params["transcodingEnabled"] as! Bool))
    }

    @objc func removePublishStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.removePublishStreamUrl(params["url"] as! String))
    }

    @objc func startChannelMediaRelay(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.startChannelMediaRelay(mapToChannelMediaRelayConfiguration(params["channelMediaRelayConfiguration"] as! Dictionary)))
    }

    @objc func updateChannelMediaRelay(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.updateChannelMediaRelay(mapToChannelMediaRelayConfiguration(params["channelMediaRelayConfiguration"] as! Dictionary)))
    }

    @objc func stopChannelMediaRelay(_ callback: Callback) {
        callback.code(engine?.stopChannelMediaRelay())
    }

    @objc func setDefaultAudioRoutetoSpeakerphone(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setDefaultAudioRouteToSpeakerphone(params["defaultToSpeaker"] as! Bool))
    }

    @objc func setEnableSpeakerphone(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setEnableSpeakerphone(params["enabled"] as! Bool))
    }

    @objc func isSpeakerphoneEnabled(_ callback: Callback) {
        callback.resolve(engine) {
            $0.isSpeakerphoneEnabled()
        }
    }

    @objc func enableInEarMonitoring(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enable(inEarMonitoring: params["enabled"] as! Bool))
    }

    @objc func setInEarMonitoringVolume(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setInEarMonitoringVolume(params["volume"] as! Int))
    }

    @objc func enableDualStreamMode(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableDualStreamMode(params["enabled"] as! Bool))
    }

    @objc func setRemoteVideoStreamType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setRemoteVideoStream(params["uid"] as! UInt, type: AgoraVideoStreamType(rawValue: params["streamType"] as! Int)!))
    }

    @objc func setRemoteDefaultVideoStreamType(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setRemoteDefaultVideoStreamType(AgoraVideoStreamType(rawValue: params["streamType"] as! Int)!))
    }

    @objc func setLocalPublishFallbackOption(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setLocalPublishFallbackOption(AgoraStreamFallbackOptions(rawValue: params["option"] as! Int)!))
    }

    @objc func setRemoteSubscribeFallbackOption(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setRemoteSubscribeFallbackOption(AgoraStreamFallbackOptions(rawValue: params["option"] as! Int)!))
    }

    @objc func setRemoteUserPriority(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setRemoteUserPriority(params["uid"] as! UInt, type: AgoraUserPriority(rawValue: params["userPriority"] as! Int)!))
    }

    @objc func startEchoTest(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.startEchoTest(withInterval: params["intervalInSeconds"] as! Int))
    }

    @objc func stopEchoTest(_ callback: Callback) {
        callback.code(engine?.stopEchoTest())
    }

    @objc func enableLastmileTest(_ callback: Callback) {
        callback.code(engine?.enableLastmileTest())
    }

    @objc func disableLastmileTest(_ callback: Callback) {
        callback.code(engine?.disableLastmileTest())
    }

    @objc func startLastmileProbeTest(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.startLastmileProbeTest(mapToLastmileProbeConfig(params["config"] as! Dictionary)))
    }

    @objc func stopLastmileProbeTest(_ callback: Callback) {
        callback.code(engine?.stopLastmileProbeTest())
    }

    @objc func registerMediaMetadataObserver(_ callback: Callback) {
        let mediaObserver = MediaObserver { [weak self] in
            self?.emitter(RtcEngineEvents.MetadataReceived, $0)
        }
        callback.resolve(engine) {
            if $0.setMediaMetadataDelegate(mediaObserver, with: .video) {
                self.mediaObserver = mediaObserver
            }
            return nil
        }
    }

    @objc func unregisterMediaMetadataObserver(_ callback: Callback) {
        callback.resolve(engine) {
            if $0.setMediaMetadataDelegate(nil, with: .video) {
                self.mediaObserver = nil
            }
            return nil
        }
    }

    @objc func setMaxMetadataSize(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(mediaObserver) {
            $0.setMaxMetadataSize(params["size"] as! Int)
        }
    }

    @objc func sendMetadata(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(mediaObserver) {
            $0.addMetadata(params["metadata"] as! String)
        }
    }

    @objc func addVideoWatermark(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.addVideoWatermark(URL(string: params["watermarkUrl"] as! String)!, options: mapToWatermarkOptions(params["options"] as! Dictionary)))
    }

    @objc func clearVideoWatermarks(_ callback: Callback) {
        callback.code(engine?.clearVideoWatermarks())
    }

    @objc func setEncryptionSecret(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setEncryptionSecret(params["secret"] as? String))
    }

    @objc func setEncryptionMode(_ params: NSDictionary, _ callback: Callback) {
        var encryptionMode = ""
        switch params["encryptionMode"] as! Int {
        case AgoraEncryptionMode.AES128XTS.rawValue:
            encryptionMode = "aes-128-xts"
        case AgoraEncryptionMode.AES128ECB.rawValue:
            encryptionMode = "aes-128-ecb"
        case AgoraEncryptionMode.AES256XTS.rawValue:
            encryptionMode = "aes-256-xts"
        default: encryptionMode = ""
        }
        callback.code(engine?.setEncryptionMode(encryptionMode))
    }

    @objc func enableEncryption(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableEncryption(params["enabled"] as! Bool, encryptionConfig: mapToEncryptionConfig(params["config"] as! Dictionary)))
    }

    @objc func startAudioRecording(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.startAudioRecording(params["filePath"] as! String, sampleRate: params["sampleRate"] as! Int, quality: AgoraAudioRecordingQuality(rawValue: params["quality"] as! Int)!))
    }

    @objc func stopAudioRecording(_ callback: Callback) {
        callback.code(engine?.stopAudioRecording())
    }

    @objc func addInjectStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.addInjectStreamUrl(params["url"] as! String, config: mapToLiveInjectStreamConfig(params["config"] as! Dictionary)))
    }

    @objc func removeInjectStreamUrl(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.removeInjectStreamUrl(params["url"] as! String))
    }

    @objc func switchCamera(_ callback: Callback) {
        callback.code(engine?.switchCamera())
    }

    @objc func isCameraZoomSupported(_ callback: Callback) {
        callback.resolve(engine) {
            $0.isCameraZoomSupported()
        }
    }

    @objc func isCameraTorchSupported(_ callback: Callback) {
        callback.resolve(engine) {
            $0.isCameraTorchSupported()
        }
    }

    @objc func isCameraFocusSupported(_ callback: Callback) {
        callback.code(-Int32(AgoraErrorCode.notSupported.rawValue))
    }

    @objc func isCameraExposurePositionSupported(_ callback: Callback) {
        callback.resolve(engine) {
            $0.isCameraExposurePositionSupported()
        }
    }

    @objc func isCameraAutoFocusFaceModeSupported(_ callback: Callback) {
        callback.resolve(engine) {
            $0.isCameraAutoFocusFaceModeSupported()
        }
    }

    @objc func setCameraZoomFactor(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.setCameraZoomFactor(CGFloat(params["factor"] as! Float))
            return nil
        }
    }

    @objc func getCameraMaxZoomFactor(_ callback: Callback) {
        callback.code(-Int32(AgoraErrorCode.notSupported.rawValue))
    }

    @objc func setCameraFocusPositionInPreview(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.setCameraFocusPositionInPreview(CGPoint(x: params["positionX"] as! Double, y: params["positionY"] as! Double))
            return nil
        }
    }

    @objc func setCameraExposurePosition(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.setCameraExposurePosition(CGPoint(x: params["positionXinView"] as! Double, y: params["positionYinView"] as! Double))
            return nil
        }
    }

    @objc func enableFaceDetection(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.enableFaceDetection(params["enable"] as! Bool))
    }

    @objc func setCameraTorchOn(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.setCameraTorchOn(params["isOn"] as! Bool)
            return nil
        }
    }

    @objc func setCameraAutoFocusFaceModeEnabled(_ params: NSDictionary, _ callback: Callback) {
        callback.resolve(engine) {
            $0.setCameraAutoFocusFaceModeEnabled(params["enabled"] as! Bool)
        }
    }

    @objc func setCameraCapturerConfiguration(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.setCameraCapturerConfiguration(mapToCameraCapturerConfiguration(params["config"] as! Dictionary)))
    }

    @objc func createDataStream(_ params: NSDictionary, _ callback: Callback) {
        var streamId = 0
        if let config = params["config"] as? Dictionary<String, Any> {
            callback.code(engine?.createDataStream(&streamId, config: mapToDataStreamConfig(config))) { _ in streamId }
            return
        }
        callback.code(engine?.createDataStream(&streamId, reliable: params["reliable"] as! Bool, ordered: params["ordered"] as! Bool)) { _ in streamId }
    }

    @objc func sendStreamMessage(_ params: NSDictionary, _ callback: Callback) {
        callback.code(engine?.sendStreamMessage(params["streamId"] as! Int, data: (params["message"] as! String).data(using: .utf8)!))
    }
    
    @objc func setVoiceBeautifierParameters(_ params: NSDictionary, callback: Callback) {
        callback.code(engine?.setVoiceBeautifierParameters(AgoraVoiceBeautifierPreset.init(rawValue: params["preset"] as! Int)!, param1: params["param1"] as! Int32, param2: params["param2"] as! Int32))
    }
    
    @objc func getSdkVersion(callback: Callback) {
        callback.success(AgoraRtcEngineKit.getSdkVersion())
    }
    
    @objc func getErrorDescription(_ params: NSDictionary, callback: Callback) {
        callback.success(AgoraRtcEngineKit.getErrorDescription(params["code"] as! Int))
    }
    
    @objc func enableDeepLearningDenoise(_ params: NSDictionary, callback: Callback) {
        callback.code(engine?.enableDeepLearningDenoise(params["enabled"] as! Bool))
    }
    
    @objc func setCloudProxy(_ params: NSDictionary, callback: Callback) {
        callback.code(engine?.setCloudProxy(AgoraCloudProxyType.init(rawValue: params["proxyType"] as! UInt)!))
    }
    
    @objc func uploadLogFile(callback: Callback) {
        callback.resolve(engine) {
            return $0.uploadLogFile()
        }
    }
    
    @objc func enableRemoteSuperResolution(_ params: NSDictionary, callback: Callback) {
        callback.code(engine?.enableRemoteSuperResolution(params["uid"] as! UInt, enabled: params["enabled"] as! Bool))
    }
}
