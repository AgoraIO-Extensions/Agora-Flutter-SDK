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
    private weak var channel: AgoraRtcChannel?

    func setRenderMode(_ engine: AgoraRtcEngineKit, _ renderMode: Int) {
        canvas.renderMode = AgoraVideoRenderMode(rawValue: UInt(renderMode))!
        setupRenderMode(engine)
    }

    func setChannel(_ engine: AgoraRtcEngineKit, _ channel: AgoraRtcChannel?) {
        self.channel = channel
        canvas.channelId = channel?.getId()
        if canvas.uid == 0 {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
    }

    func setMirrorMode(_ engine: AgoraRtcEngineKit, _ mirrorMode: Int) {
        canvas.mirrorMode = AgoraVideoMirrorMode(rawValue: UInt(mirrorMode))!
        setupRenderMode(engine)
    }

    func setUid(_ engine: AgoraRtcEngineKit, _ uid: Int) {
        canvas.uid = UInt(uid)
        if canvas.uid == 0 {
            engine.setupLocalVideo(canvas)
        } else {
            engine.setupRemoteVideo(canvas)
        }
    }

    private func setupRenderMode(_ engine: AgoraRtcEngineKit) {
        if canvas.uid == 0 {
            engine.setLocalRenderMode(canvas.renderMode, mirrorMode: canvas.mirrorMode)
        } else {
            if let `channel` = channel {
                channel.setRemoteRenderMode(canvas.uid, renderMode: canvas.renderMode, mirrorMode: canvas.mirrorMode)
            } else {
                engine.setRemoteRenderMode(canvas.uid, renderMode: canvas.renderMode, mirrorMode: canvas.mirrorMode)
            }
        }
    }
}
