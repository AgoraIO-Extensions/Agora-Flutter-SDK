import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private var customAudioSourcePlugin: CustomAudioPlugin!
    
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

        customAudioSourcePlugin = CustomAudioPlugin()
        CustomAudioSourceApiSetup(
        controller.binaryMessenger, customAudioSourcePlugin)

        RtcEnginePluginRegistrant.register(customAudioSourcePlugin)
          
        GeneratedPluginRegistrant.register(with: self)
          
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        RtcEnginePluginRegistrant.unregister(customAudioSourcePlugin)
    }
}
