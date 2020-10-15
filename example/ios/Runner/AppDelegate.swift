import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, AgoraVideoDataPluginDelegate {
    private var plugin: AgoraMediaDataPlugin?
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("rootViewController is not type FlutterViewController")
        }
        let batteryChannel = FlutterMethodChannel(name: "test", binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({[weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "enableRawDataObserver" else {
                result(FlutterMethodNotImplemented)
                return
            }
            if let handle = call.arguments as? Int {
                self?.plugin = AgoraMediaDataPlugin(agoraKit: handle)
                self?.plugin?.registerVideoRawDataObserver(.captureVideo)
                self?.plugin?.videoDelegate = self
            }
            result(nil)
        })
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func mediaDataPlugin(_ mediaDataPlugin: AgoraMediaDataPlugin, didCapturedVideoRawData videoRawData: AgoraVideoRawData) -> AgoraVideoRawData {
        return videoRawData
    }
}
