import XCTest
import Flutter
@testable import agora_rtc_engine


class RunnerTests: XCTestCase {


    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateAndDestroyAgoraRtcEnginePlugin() {
        for _ in 1...100 {
            let flutterEngine = FlutterEngine()
            flutterEngine.run()
            AgoraRtcEnginePlugin.register(with: flutterEngine.registrar(forPlugin: "AgoraRtcEnginePlugin")!)
            flutterEngine.destroyContext()
            
            sleep(1)
        }
    }
}
