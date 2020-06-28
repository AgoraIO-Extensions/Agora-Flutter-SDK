//
//  AgoraSurfaceViewFactory.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/28.
//

import Foundation

class AgoraSurfaceViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messager: FlutterBinaryMessenger
    private let rtcEnginePlugin: SwiftAgoraRtcEnginePlugin
    
    init(_ messager: FlutterBinaryMessenger, _ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin) {
        self.messager = messager
        self.rtcEnginePlugin = rtcEnginePlugin
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return AgoraSurfaceView(messager, frame, viewId, rtcEnginePlugin)
    }
}

class AgoraSurfaceView: NSObject, FlutterPlatformView {
    private let _view: RtcSurfaceView
    private let channel: FlutterMethodChannel
    private let rtcEnginePlugin: SwiftAgoraRtcEnginePlugin
    
    init(_ messager: FlutterBinaryMessenger,_ frame: CGRect, _ viewId: Int64, _ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin) {
        _view = RtcSurfaceView(frame: frame)
        channel = FlutterMethodChannel(name: "agora_rtc_engine/surface_view_\(viewId)", binaryMessenger: messager)
        self.rtcEnginePlugin = rtcEnginePlugin
        super.init()
        channel.setMethodCallHandler { [weak self] (call, result) in
            var args = [String: Any?]()
            if let arguments = call.arguments {
                args = arguments as! Dictionary<String, Any?>
            }
            switch call.method {
            case "setRenderMode":
                self?.setRenderMode(args["renderMode"] as! Int)
            case "setChannelId":
                self?.setChannelId(args["channelId"] as! String)
            case "setMirrorMode":
                self?.setMirrorMode(args["mirrorMode"] as! Int)
            case "setUid":
                self?.setUid(args["uid"] as! Int)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    func view() -> UIView {
        return _view
    }
    
    deinit {
        channel.setMethodCallHandler(nil)
    }

    func setRenderMode(_ renderMode: Int) {
        if let `engine` = engine {
            _view.setRenderMode(engine, renderMode)
        }
    }

    func setChannelId(_ channelId: String) {
        if let `engine` = engine {
            _view.setChannel(engine, getChannel(channelId))
        }
    }

    func setMirrorMode(_ mirrorMode: Int) {
        if let `engine` = engine {
            _view.setMirrorMode(engine, mirrorMode)
        }
    }

    func setUid(_ uid: Int) {
        if let `engine` = engine {
            _view.setUid(engine, uid)
        }
    }
    
    private var engine: AgoraRtcEngineKit? {
        return rtcEnginePlugin.engine
    }
    
    private func getChannel(_ channelId: String) -> AgoraRtcChannel? {
        return nil
    }
}
