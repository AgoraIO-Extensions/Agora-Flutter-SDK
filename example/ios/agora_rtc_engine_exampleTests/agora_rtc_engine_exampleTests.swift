import XCTest
@testable import agora_rtc_engine

class FakeAgoraRtcEngineKitFactory : AgoraRtcEngineKitFactory {
    private var rtcEngineKit: AgoraRtcEngineKit!
    
    init(_ rtcEngineKit: AgoraRtcEngineKit) {
        self.rtcEngineKit = rtcEngineKit
    }
    override func create(_ params: NSDictionary, _ delegate: RtcEngineEventHandler) -> AgoraRtcEngineKit? {
        return self.rtcEngineKit
    }
}

class TestRtcEnginePlugin : RtcEnginePlugin {
    var engine: AgoraRtcEngineKit? = nil
    var isRtcEngineCreated: Bool = false
    var isRtcEngineDestroyed: Bool = false
    
    func onRtcEngineCreated(_ rtcEngine: AgoraRtcEngineKit?) {
        engine = rtcEngine
        isRtcEngineCreated = true
    }
    
    func onRtcEngineDestroyed() {
        isRtcEngineDestroyed = true
    }
}

class agora_rtc_engine_exampleTests: XCTestCase {
    
    private var rtcEngineKit: AgoraRtcEngineKit!
    private var rtcEngineManager: RtcEngineManager!

    override func setUpWithError() throws {
        rtcEngineKit = FakeAgoraRtcEngineKit()
        rtcEngineManager = RtcEngineManager(
            {(_, _) -> Void in },
            FakeAgoraRtcEngineKitFactory(rtcEngineKit))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldCallPluginCallback() {
        let plugin = TestRtcEnginePlugin()

        RtcEnginePluginRegistrant.register(plugin)
        
    
        rtcEngineManager.create(["appType": 0], ResultCallback())
        XCTAssertTrue(plugin.isRtcEngineCreated)
        XCTAssertEqual(rtcEngineKit, plugin.engine)

        rtcEngineManager.destroy(ResultCallback())
        XCTAssertTrue(plugin.isRtcEngineDestroyed)
        XCTAssertNil(rtcEngineManager.engine)

        RtcEnginePluginRegistrant.unregister(plugin)
    }
    
    func testShouldNotCallPluginCallbackAfterUnregister() {
        let plugin = TestRtcEnginePlugin()

        RtcEnginePluginRegistrant.register(plugin)
        RtcEnginePluginRegistrant.unregister(plugin)
        
        rtcEngineManager.create(["appType": 0], ResultCallback())
        rtcEngineManager.destroy(ResultCallback())
        
        XCTAssertFalse(plugin.isRtcEngineCreated)
        XCTAssertFalse(plugin.isRtcEngineDestroyed)
    }

}
