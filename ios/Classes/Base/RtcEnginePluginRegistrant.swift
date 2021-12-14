import Foundation

/**
 * Class for register the `RtcEnginePlugin`.
 */
@objc
public class RtcEnginePluginRegistrant: NSObject {
    /**
     * Register a `RtcEnginePlugin`. The `plugin` will be called when the `RtcEngine` is created from
     * flutter side.
     */
    @objc public static func register(_ plugin: RtcEnginePlugin) {
        RtcEngineRegistry.shared.add(plugin)
    }

    /**
     * Unregister a previously registered `RtcEnginePlugin`.
     */
    @objc public static func unregister(_ plugin: RtcEnginePlugin) {
        RtcEngineRegistry.shared.remove(plugin)
    }
}
