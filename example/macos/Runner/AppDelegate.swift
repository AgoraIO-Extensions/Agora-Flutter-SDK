import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  private var mainWindowChannel: FlutterMethodChannel?
  private var rtcWindowController: RtcWindowController?

  override func applicationDidFinishLaunching(_ notification: Notification) {
    guard let flutterViewController = mainFlutterWindow?.contentViewController as? FlutterViewController else {
      return
    }

    mainWindowChannel = FlutterMethodChannel(
      name: "agora_multi_window_demo/main",
      binaryMessenger: flutterViewController.engine.binaryMessenger)
    mainWindowChannel?.setMethodCallHandler { [weak self] call, result in
      switch call.method {
      case "openRtcWindow":
        guard
          let config = call.arguments as? [String: Any],
          let appId = config["appId"] as? String,
          !appId.isEmpty,
          let channelId = config["channelId"] as? String,
          !channelId.isEmpty,
          config["token"] is String,
          config["uid"] is NSNumber
        else {
          result(FlutterError(
            code: "invalid_config",
            message: "appId, channelId, token and uid are required",
            details: nil))
          return
        }

        if let controller = self?.rtcWindowController {
          controller.show()
        } else {
          self?.rtcWindowController = RtcWindowController(config: config) { [weak self] in
            self?.rtcWindowController = nil
          }
        }
        result(nil)
      case "closeRtcWindow":
        self?.rtcWindowController?.requestClose()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}

private final class RtcWindowController: NSObject, NSWindowDelegate {
  private let config: [String: Any]
  private let onClosed: () -> Void
  private let engine: FlutterEngine
  private let channel: FlutterMethodChannel
  private let window: NSWindow
  private var isClosing = false

  init(config: [String: Any], onClosed: @escaping () -> Void) {
    self.config = config
    self.onClosed = onClosed
    engine = FlutterEngine(
      name: "agora_rtc_window",
      project: nil,
      allowHeadlessExecution: false)
    channel = FlutterMethodChannel(
      name: "agora_multi_window_demo/rtc_window",
      binaryMessenger: engine.binaryMessenger)
    let flutterViewController = FlutterViewController(
      engine: engine,
      nibName: nil,
      bundle: nil)
    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 960, height: 640),
      styleMask: [.titled, .closable, .miniaturizable, .resizable],
      backing: .buffered,
      defer: false)

    super.init()

    channel.setMethodCallHandler { call, result in
      if call.method == "getLaunchConfig" {
        result(config)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    guard engine.run(withEntrypoint: "rtcWindowMain") else {
      fatalError("Unable to start rtcWindowMain")
    }
    RegisterGeneratedPlugins(registry: engine)

    channel.setMethodCallHandler { [weak self] call, result in
      switch call.method {
      case "getLaunchConfig":
        result(self?.config)
      case "requestNativeClose":
        self?.requestClose()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    window.title = "Agora RTC - Child Flutter Engine"
    let windowFrame = window.frame
    window.contentViewController = flutterViewController
    window.setFrame(windowFrame, display: true)
    window.delegate = self
    window.isReleasedWhenClosed = false
    window.center()
    show()
  }

  func show() {
    window.makeKeyAndOrderFront(nil)
    NSApp.activate(ignoringOtherApps: true)
  }

  func requestClose() {
    guard !isClosing else { return }
    isClosing = true
    channel.invokeMethod("requestClose", arguments: nil) { [weak self] _ in
      self?.finishClose()
    }
  }

  func windowShouldClose(_ sender: NSWindow) -> Bool {
    requestClose()
    return false
  }

  private func finishClose() {
    window.delegate = nil
    window.close()
    channel.setMethodCallHandler(nil)
    engine.shutDownEngine()
    onClosed()
  }
}
