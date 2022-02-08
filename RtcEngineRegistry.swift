import Foundation
import AgoraRtcKit

fileprivate struct PluginKey: Hashable, Equatable {
    let type: AnyClass

    public static func == (lhs: PluginKey, rhs: PluginKey) -> Bool {
        return lhs.type == rhs.type
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
    }
}

/**
 * The `RtcEngineRegistry` is response to add, remove and notify the callback when `RtcEngine` is created
 * from flutter side.
 */
internal class RtcEngineRegistry : NSObject {

    private override init() {}

    static let shared = RtcEngineRegistry()

    private var plugins: [PluginKey : RtcEnginePlugin] = [PluginKey: RtcEnginePlugin]()

    /**
    * Add a `RtcEnginePlugin`.
    */
    func add(_ plugin: RtcEnginePlugin) {
        let key = PluginKey(type: type(of: plugin))
        guard plugins[key] == nil else {
          return
        }
        plugins[key] = plugin
    }

    /**
    * Remove the previously added `RtcEnginePlugin`.
    */
    func remove(_ plugin: RtcEnginePlugin) {
        plugins.removeValue(forKey: PluginKey(type: type(of: plugin)))
    }
}

extension RtcEngineRegistry : RtcEnginePlugin {
    // MARK: - protocol from RtcEnginePlugin
    public func onRtcEngineCreated(_ rtcEngine: AgoraRtcEngineKit?) {
        for (_, plugin) in plugins {
            plugin.onRtcEngineCreated(rtcEngine)
        }
    }

    // MARK: - protocol from RtcEnginePlugin
    public func onRtcEngineDestroyed() {
        for (_, plugin) in plugins {
            plugin.onRtcEngineDestroyed()
        }
    }
}
