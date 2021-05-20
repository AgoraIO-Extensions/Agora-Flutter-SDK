//
//  AgoraSurfaceViewFactory.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/28.
//

import Foundation

//class AgoraSurfaceViewFactory: NSObject, FlutterPlatformViewFactory {
//    private final weak var messager: FlutterBinaryMessenger?
//    private final weak var rtcEnginePlugin: SwiftAgoraRtcEnginePlugin?
//    private final weak var rtcChannelPlugin: AgoraRtcChannelPlugin?
//
//    init(_ messager: FlutterBinaryMessenger, _ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin, _ rtcChannelPlugin: AgoraRtcChannelPlugin) {
//        self.messager = messager
//        self.rtcEnginePlugin = rtcEnginePlugin
//        self.rtcChannelPlugin = rtcChannelPlugin
//    }
//
//    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
//        FlutterStandardMessageCodec.sharedInstance()
//    }
//
//    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
//        return AgoraSurfaceView(messager!, frame, viewId, args as? [String: Any?], rtcEnginePlugin!, rtcChannelPlugin!)
//    }
//}
//
//class AgoraSurfaceView: NSObject, FlutterPlatformView {
//    private final weak var rtcEnginePlugin: SwiftAgoraRtcEnginePlugin?
//    private final weak var rtcChannelPlugin: AgoraRtcChannelPlugin?
//    private let _view: RtcSurfaceView
//    private let channel: FlutterMethodChannel
//
//    init(_ messager: FlutterBinaryMessenger, _ frame: CGRect, _ viewId: Int64, _ args: [String: Any?]?, _ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin, _ rtcChannelPlugin: AgoraRtcChannelPlugin) {
//        self.rtcEnginePlugin = rtcEnginePlugin
//        self.rtcChannelPlugin = rtcChannelPlugin
//        self._view = RtcSurfaceView(frame: frame)
//        self.channel = FlutterMethodChannel(name: "agora_rtc_engine/surface_view_\(viewId)", binaryMessenger: messager)
//        super.init()
//        if let map = args {
//            setData(map["data"] as! NSDictionary)
//            setRenderMode((map["renderMode"] as! NSNumber).uintValue)
//            setMirrorMode((map["mirrorMode"] as! NSNumber).uintValue)
//        }
//        channel.setMethodCallHandler { [weak self] call, result in
//            var args = [String: Any?]()
//            if let arguments = call.arguments {
//                args = arguments as! [String: Any?]
//            }
//            switch call.method {
//            case "setData":
//                self?.setData(args["data"] as! NSDictionary)
//            case "setRenderMode":
//                self?.setRenderMode((args["renderMode"] as! NSNumber).uintValue)
//            case "setMirrorMode":
//                self?.setMirrorMode((args["mirrorMode"] as! NSNumber).uintValue)
//            default:
//                result(FlutterMethodNotImplemented)
//            }
//        }
//    }
//
//    func view() -> UIView {
//        return _view
//    }
//
//    deinit {
//        channel.setMethodCallHandler(nil)
//    }
//
//    func setData(_ data: NSDictionary) {
//        var channel: AgoraRtcChannel?
//        if let channelId = data["channelId"] as? String {
//            channel = getChannel(channelId)
//        }
//        if let engine = engine {
//            _view.setData(engine, channel, (data["uid"] as! NSNumber).uintValue)
//        }
//    }
//
//    func setRenderMode(_ renderMode: UInt) {
//        if let engine = engine {
//            _view.setRenderMode(engine, renderMode)
//        }
//    }
//
//    func setMirrorMode(_ mirrorMode: UInt) {
//        if let engine = engine {
//            _view.setMirrorMode(engine, mirrorMode)
//        }
//    }
//
//    private var engine: AgoraRtcEngineKit? {
//        return rtcEnginePlugin?.engine
//    }
//
//    private func getChannel(_ channelId: String?) -> AgoraRtcChannel? {
//        guard let channelId = channelId else {
//            return nil
//        }
//        return rtcChannelPlugin?.channel(channelId)
//    }
//}
