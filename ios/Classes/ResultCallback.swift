//
//  ResultCallback.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/24.
//

import Foundation
import AgoraRtcKit

class ResultCallback: NSObject, Callback {
    typealias T = Dictionary<String, Any?>

    private var result: FlutterResult?

    init(_ result: FlutterResult?) {
        self.result = result
    }

    func resolve<E>(_ e: E?, _ data: (_ e: E) throws -> Any?) {
        if let `e` = e {
            do {
                let res = try data(e)
                if res is Void {
                    result?(nil)
                } else {
                    result?(res)
                }
            } catch let err {
                result?(FlutterError.init(code: err.localizedDescription, message: nil, details: err))
            }
        } else {
            let code = AgoraErrorCode.notInitialized.rawValue
            failure(String(code), AgoraRtcEngineKit.getErrorDescription(code) ?? "")
        }
    }

    func success(_ data: Dictionary<String, Any?>?) {
        result?(data)
    }

    func failure(_ code: String, _ message: String) {
        result?(FlutterError.init(code: code, message: message, details: nil))
    }
}
