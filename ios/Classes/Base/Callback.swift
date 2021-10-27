//
//  Callback.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/9.
//  Copyright © 2020 Syan. All rights reserved.
//

import AgoraRtcKit
import Foundation

@objc
protocol Callback: class {
    func success(_ data: Any?)

    func failure(_ code: String, _ message: String)
}

extension Callback {
    func code(_ code: Int32?, _ runnable: ((Int32?) -> Any?)? = nil) {
        if code == nil || code! < 0 {
            let newCode = abs(Int(code ?? Int32(AgoraErrorCode.notInitialized.rawValue)))
            failure(String(newCode), AgoraRtcEngineKit.getErrorDescription(newCode) ?? "")
            return
        }

        let res = runnable?(code)
        success(res)
    }

    func resolve<T>(_ source: T?, _ runnable: (T) -> Any?) {
        guard let source = source else {
            let code = AgoraErrorCode.notInitialized.rawValue
            failure(String(code), AgoraRtcEngineKit.getErrorDescription(code) ?? "")
            return
        }

        let res = runnable(source)
        success(res)
    }
}
