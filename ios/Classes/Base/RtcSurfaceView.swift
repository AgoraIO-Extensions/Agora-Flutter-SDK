//
//  RtcSurfaceView.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/15.
//  Copyright © 2020 Syan. All rights reserved.
//

import Foundation
import UIKit
import AgoraRtcKit

class RtcSurfaceView: UIView {
    private lazy var canvas: AgoraRtcVideoCanvas = {
        var canvas = AgoraRtcVideoCanvas()
        canvas.view = self
        return canvas
    }()

    func setRenderMode(_ engine: AgoraRtcEngineKit, _ renderMode: Int) {
        canvas.renderMode = AgoraVideoRenderMode(rawValue: UInt(renderMode))!
        if canvas.uid == 0 {
            engine.setLocalRenderMode(canvas.renderMode, mirrorMode: canvas.mirrorMode)
        } else {
            engine.setRemoteRenderMode(canvas.uid, renderMode: canvas.renderMode, mirrorMode: canvas.mirrorMode)
        }
    }

    func setChannelId(_ engine: AgoraRtcEngineKit, _ channelId: String) {
        canvas.channelId = channelId
        if canvas.uid == 0 {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
    }

    func setMirroMode(_ engine: AgoraRtcEngineKit, _ mirrorMode: Int) {
        canvas.mirrorMode = AgoraVideoMirrorMode(rawValue: UInt(mirrorMode))!
        if canvas.uid == 0 {
            engine.setLocalRenderMode(canvas.renderMode, mirrorMode: canvas.mirrorMode)
        } else {
            engine.setRemoteRenderMode(canvas.uid, renderMode: canvas.renderMode, mirrorMode: canvas.mirrorMode)
        }
    }

    func setUid(_ engine: AgoraRtcEngineKit, _ uid: Int) {
        canvas.uid = UInt(uid)
        if canvas.uid == 0 {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
    }
}
