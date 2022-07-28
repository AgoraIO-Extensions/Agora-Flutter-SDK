//
//  destroy_irisengine_smoke_testUITest.swift
//  destroy_irisengine_smoke_testUITest
//
//  Created by fenglang on 2022/8/9.
//

import XCTest

class destroy_irisengine_smoke_testUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        for _ in 1...10 {
            
            let env = ProcessInfo.processInfo.environment
            let appid = ProcessInfo.processInfo.environment["MY_APP_ID"]
            
            let app = XCUIApplication()

            app.launchEnvironment["MY_APP_ID"] = appid
            app.launch()
            
            sleep(40)
        }
    }

}
