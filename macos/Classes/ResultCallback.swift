//
//  ResultCallback.swift
//  agora_rtc_engine
//
//  Created by LXH on 2020/6/24.
//

import AgoraRtcKit
import Foundation

class ResultCallback: NSObject, Callback {
    private var result: FlutterResult?

    init(_ result: FlutterResult?) {
        self.result = result
    }

    func success(_ data: Any?) {
        result?(data)
    }

    func failure(_ code: String, _ message: String) {
        result?(FlutterError(code: code, message: message, details: nil))
    }
}
