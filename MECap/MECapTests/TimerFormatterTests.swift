//
//  TimerFormatterTests.swift
//  MECapTests
//
//  Created by 鶴見駿 on 2025/01/11.
//

import XCTest
@testable import MECap


final class TimerFormatterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFormattedTime() throws {
        let time: Double = 361.1
        let formattedTime = time.formattedTime()
        let expected = "06:01.1"
        
        XCTAssertEqual(formattedTime, expected)
    }
    
//    func testFormattedTimeOverHour() throws {
//        let time: Double = 3600 + 60 + 1 + 0.2
//        let formattedtime = time.formattedTime()
//        let expected = "01:01:01.2"
//        
//        XCTAssertEqual(formattedtime, expected)
//    }
}
