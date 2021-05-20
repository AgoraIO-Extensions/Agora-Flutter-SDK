//
//  AgoraRtcChannelPlugin.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/29.
//

import Foundation

public class AgoraRtcChannelPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private final weak var rtcEnginePlugin: SwiftAgoraRtcEnginePlugin?
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink?
    private lazy var manager: RtcChannelManager = {
        RtcChannelManager { [weak self] methodName, data in
            self?.emit(methodName, data)
        }
    }()

    init(_ rtcEnginePlugin: SwiftAgoraRtcEnginePlugin) {
        self.rtcEnginePlugin = rtcEnginePlugin
    }

    public static func register(with _: FlutterPluginRegistrar) {}

    public func initPlugin(_ registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "agora_rtc_channel", binaryMessenger: registrar.messenger)
        eventChannel = FlutterEventChannel(name: "agora_rtc_channel/events", binaryMessenger: registrar.messenger)
        registrar.addMethodCallDelegate(self, channel: methodChannel!)
        eventChannel?.setStreamHandler(self)
    }

    public func detachFromEngine(for _: FlutterPluginRegistrar) {
        methodChannel?.setMethodCallHandler(nil)
        eventChannel?.setStreamHandler(nil)
        manager.Release()
    }

    public func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }

    public func onCancel(withArguments _: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    private func emit(_ methodName: String, _ data: [String: Any?]?) {
        var event: [String: Any?] = ["methodName": methodName]
        if let data = data {
            event.merge(data) { current, _ in
                current
            }
        }
        eventSink?(event)
    }

    private weak var engine: AgoraRtcEngineKit? {
        return rtcEnginePlugin?.engine
    }

    func channel(_ channelId: String) -> AgoraRtcChannel? {
        return manager[channelId]
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let params = call.arguments as? NSDictionary {
            let selector = NSSelectorFromString(call.method + "::")
            if manager.responds(to: selector) {
                if call.method == "create" {
                    params.setValue(engine, forKey: "engine")
                }
                manager.perform(selector, with: params, with: ResultCallback(result))
                return
            }
        } else {
            let selector = NSSelectorFromString(call.method + ":")
            if manager.responds(to: selector) {
                manager.perform(selector, with: ResultCallback(result))
                return
            }
        }
        result(FlutterMethodNotImplemented)
    }
}
