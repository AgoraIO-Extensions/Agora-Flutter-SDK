import UIKit
import Flutter

public extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
     var flutterEngine: FlutterEngine = FlutterEngine(name: "my flutter engine")
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      controller.setFlutterViewDidRenderCallback({
          DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
              if let topVC = UIApplication.getTopViewController() {
                  self.flutterEngine.run();
                  
                  GeneratedPluginRegistrant.register(with: self.flutterEngine)
                  
                  let channel = FlutterMethodChannel(name: "smoke_test_channel", binaryMessenger: self.flutterEngine.binaryMessenger)
            
                    channel.setMethodCallHandler({
                      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                        
                        if call.method == "get_app_id" {
                            let myAppId = ProcessInfo.processInfo.environment["MY_APP_ID"]
                            result(myAppId)
                            channel.setMethodCallHandler(nil)
                            return
                        }
            
                        result(true)
                    })
                 
                  let flutterViewController = FlutterViewController(engine: self.flutterEngine, nibName: nil, bundle: nil)
                  flutterViewController.modalPresentationStyle = .overFullScreen
                  flutterViewController.setFlutterViewDidRenderCallback({
                      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                          if let topVC = UIApplication.getTopViewController() {
                              topVC.dismiss(animated: true, completion: {
                                  DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                      self.flutterEngine.destroyContext()
                                  }
                              })
                          }
                      }
                  })
                  topVC.present(flutterViewController, animated: true, completion: nil)
              }
          }
      })
      
            let channel = FlutterMethodChannel(name: "smoke_test_channel", binaryMessenger: controller.binaryMessenger)
      
              channel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                  
                  if call.method == "get_app_id" {
                      let myAppId = ProcessInfo.processInfo.environment["MY_APP_ID"]
                      result(myAppId)
                      channel.setMethodCallHandler(nil)
                      return
                  }
      
                  result(true)
              })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
