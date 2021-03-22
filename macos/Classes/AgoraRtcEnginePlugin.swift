import Cocoa
import FlutterMacOS

public class AgoraRtcEnginePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var registrar: FlutterPluginRegistrar?
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink? = nil
    private lazy var manager: RtcEngineManager = {
        return RtcEngineManager() { [weak self] methodName, data in
            self?.emit(methodName, data)
        }
    }()
    private lazy var rtcChannelPlugin: AgoraRtcChannelPlugin = {
        return AgoraRtcChannelPlugin(self)
    }()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let rtcEnginePlugin = AgoraRtcEnginePlugin()
        rtcEnginePlugin.registrar = registrar
        rtcEnginePlugin.rtcChannelPlugin.initPlugin(registrar)
        rtcEnginePlugin.initPlugin(registrar)
    }

    private func initPlugin(_ registrar: FlutterPluginRegistrar) {
        methodChannel = FlutterMethodChannel(name: "agora_rtc_engine", binaryMessenger: registrar.messenger)
        eventChannel = FlutterEventChannel(name: "agora_rtc_engine/events", binaryMessenger: registrar.messenger)
        registrar.addMethodCallDelegate(self, channel: methodChannel!)
        eventChannel?.setStreamHandler(self)

//        registrar.register(AgoraSurfaceViewFactory(registrar.messenger(), self, rtcChannelPlugin), withId: "AgoraSurfaceView")
    }

    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        rtcChannelPlugin.detachFromEngine(for: registrar)
        methodChannel?.setMethodCallHandler(nil)
        eventChannel?.setStreamHandler(nil)
        manager.Release()
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    private func emit(_ methodName: String, _ data: Dictionary<String, Any?>?) {
        var event: Dictionary<String, Any?> = ["methodName": methodName]
        if let `data` = data {
            event.merge(data) { (current, _) in
                current
            }
        }
        eventSink?(event)
    }

    weak var engine: AgoraRtcEngineKit? {
        return manager.engine
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getAssetAbsolutePath" {
            getAssetAbsolutePath(call, result: result)
            return
        }
        if let params = call.arguments as? NSDictionary {
            let selector = NSSelectorFromString(call.method + "::")
            if manager.responds(to: selector) {
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

    private func getAssetAbsolutePath(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let assetPath = call.arguments as? String {
//            if let assetKey = registrar?.lookupKey(forAsset: assetPath) {
//                if let realPath = Bundle.main.path(forResource: assetKey, ofType: nil) {
//                    result(realPath)
//                    return
//                }
//            }
//            result(FlutterError.init(code: "FileNotFoundException", message: nil, details: nil))
//            return
//        }
//        result(FlutterError.init(code: "IllegalArgumentException", message: nil, details: nil))
    }
}
