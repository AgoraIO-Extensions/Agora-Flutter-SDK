//
//  AgoraSurfaceViewFactory.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/28.
//

import AgoraRtcKit
import Foundation

class TextureRender: NSObject, FlutterTexture, AgoraVideoSinkProtocol {
    private final weak var textureRegistry: FlutterTextureRegistry?
    private final weak var rtcEnginePlugin: SwiftAgoraRtcEnginePlugin?
    private final weak var rtcChannelPlugin: AgoraRtcChannelPlugin?
    private var id: Int64?
    private var channel: FlutterMethodChannel?
    private var buffer: CVPixelBuffer?

    init(_ textureRegistry: FlutterTextureRegistry, _ messenger: FlutterBinaryMessenger,
         _ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin,
         _ rtcChannelPlugin: AgoraRtcChannelPlugin)
    {
        self.textureRegistry = textureRegistry
        self.rtcEnginePlugin = rtcEnginePlugin
        self.rtcChannelPlugin = rtcChannelPlugin
        super.init()
        id = textureRegistry.register(self)
        channel = FlutterMethodChannel(name: "agora_rtc_engine/texture_render_\(id!)", binaryMessenger: messenger)
        channel?.setMethodCallHandler { [weak self] call, result in
            var args = [String: Any?]()
            if let arguments = call.arguments {
                args = arguments as! [String: Any?]
            }
            switch call.method {
            case "setData":
                self?.setData(args["data"] as! NSDictionary)
            case "setRenderMode": break
//                self?.setRenderMode((args["renderMode"] as! NSNumber).uintValue)
            case "setMirrorMode": break
//                self?.setMirrorMode((args["mirrorMode"] as! NSNumber).uintValue)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    func release() {
        textureRegistry?.unregisterTexture(id!)
        channel?.setMethodCallHandler(nil)
    }

    func getId() -> Int64 {
        return id!
    }

    func shouldInitialize() -> Bool {
        return true
    }

    func shouldStart() {}

    func shouldStop() {}

    func shouldDispose() {
        textureRegistry?.unregisterTexture(id!)
    }

    func bufferType() -> AgoraVideoBufferType {
        return .pixelBuffer
    }

    func pixelFormat() -> AgoraVideoPixelFormat {
        return .BGRA
    }

    func renderPixelBuffer(_ pixelBuffer: CVPixelBuffer, rotation _: AgoraVideoRotation) {
        buffer = pixelBuffer
        textureRegistry?.textureFrameAvailable(id!)
    }

    func copyPixelBuffer() -> Unmanaged<CVPixelBuffer>? {
        if let buffer = buffer {
            return Unmanaged.passRetained(buffer)
        }
        return nil
    }

    func setData(_ data: NSDictionary) {
        let uid = (data["uid"] as! NSNumber).uintValue
        let channel = getChannel(data["channelId"] as? String)
        if uid == 0 {
            engine?.setLocalVideoRenderer(self)
        } else {
            if let channel = channel {
                channel.setRemoteVideoRenderer(self, forUserId: uid)
                return
            }
            engine?.setRemoteVideoRenderer(self, forUserId: uid)
        }
    }

//    func setRenderMode(_ renderMode: UInt) {
//        if let `engine` = engine {
//            _view.setRenderMode(engine, renderMode)
//        }
//    }
//
//    func setMirrorMode(_ mirrorMode: UInt) {
//        if let `engine` = engine {
//            _view.setMirrorMode(engine, mirrorMode)
//        }
//    }

    private var engine: AgoraRtcEngineKit? {
        return rtcEnginePlugin?.engine
    }

    private func getChannel(_ channelId: String?) -> AgoraRtcChannel? {
        guard let channelId = channelId else {
            return nil
        }
        return rtcChannelPlugin?.channel(channelId)
    }
}

class AgoraTextureViewFactory: NSObject {
    private static var renders: [Int64: TextureRender] = [:]
    private final weak var messager: FlutterBinaryMessenger?
    private final weak var rtcEnginePlugin: SwiftAgoraRtcEnginePlugin?
    private final weak var rtcChannelPlugin: AgoraRtcChannelPlugin?

    init(_ messager: FlutterBinaryMessenger, _ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin, _ rtcChannelPlugin: AgoraRtcChannelPlugin) {
        self.messager = messager
        self.rtcEnginePlugin = rtcEnginePlugin
        self.rtcChannelPlugin = rtcChannelPlugin
    }

    static func createTextureRender(_ textureRegistry: FlutterTextureRegistry,
                                    _ messenger: FlutterBinaryMessenger,
                                    _ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin,
                                    _ rtcChannelPlugin: AgoraRtcChannelPlugin) -> Int64
    {
        let render = TextureRender(textureRegistry, messenger, rtcEnginePlugin, rtcChannelPlugin)
        let id = render.getId()
        renders[id] = render
        return id
    }

    static func destroyTextureRender(_ id: Int64) {
        renders.removeValue(forKey: id)?.release()
    }
}
