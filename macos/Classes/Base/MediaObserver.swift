//
//  MediaObserver.swift
//  RCTAgora
//
//  Created by LXH on 2020/4/10.
//  Copyright © 2020 Syan. All rights reserved.
//

import AgoraRtcKit
import Foundation

class MediaObserver: NSObject {
    private var emitter: (_ data: [String: Any?]?) -> Void
    private var maxMetadataSize = 1024
    private var metadataList = [String]()

    init(_ emitter: @escaping (_ data: [String: Any?]?) -> Void) {
        self.emitter = emitter
    }

    func addMetadata(_ metadata: String) {
        metadataList.append(metadata)
    }

    func setMaxMetadataSize(_ size: Int) {
        maxMetadataSize = size
    }
}

extension MediaObserver: AgoraMediaMetadataDataSource {
    func metadataMaxSize() -> Int {
        return maxMetadataSize
    }

    func readyToSendMetadata(atTimestamp _: TimeInterval) -> Data? {
        if metadataList.count > 0 {
            return metadataList.remove(at: 0).data(using: .utf8)
        }
        return nil
    }
}

extension MediaObserver: AgoraMediaMetadataDelegate {
    func receiveMetadata(_ data: Data, fromUser uid: Int, atTimestamp timestamp: TimeInterval) {
        emitter([
            "data": [String(data: data, encoding: .utf8) ?? "", uid, timestamp],
        ])
    }
}
