import Foundation

@objc public class RtcEnginePluginRegistrantSwift: NSObject {
    @objc public static func register(_ plugin: RtcEnginePlugin) {
        RtcEngineRegistry.shared.add(plugin)
    }

    @objc public static func unregister(_ plugin: RtcEnginePlugin) {
        RtcEngineRegistry.shared.remove(plugin)
    }
}
