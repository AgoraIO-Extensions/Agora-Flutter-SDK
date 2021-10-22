//
//  ResultCallback.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/24.
//

import Foundation
import AgoraRtcKit

class ResultCallback: NSObject, Callback {
    private var result: FlutterResult?

    init(_ result: FlutterResult? = nil) {
        self.result = result
    }

    func success(_ data: Any?) {
        result?(data)
    }

    func failure(_ code: String, _ message: String) {
        result?(FlutterError.init(code: code, message: message, details: nil))
    }
}
