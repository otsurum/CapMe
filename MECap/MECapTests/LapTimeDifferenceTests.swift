//
//  LapTimeDifferenceTests.swift
//  MECapTests
//
//  Created by 鶴見駿 on 2025/01/11.
//

import XCTest
@testable import MECap

final class LapTimeDifferenceTests: XCTestCase {

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

    func testLeadLapTimeDifference() throws {
        var timeManager = TimerManager()
        timeManager.lapTimes = [3.1, 4.2, 24.3]
        let differenceLapTimes = timeManager.leadLapTime()
        let expected = ["00:03.1", "00:01.1", "00:20.1"]
        
        XCTAssertEqual(differenceLapTimes, expected)
    }
    
    func testLeadEmptyCollection() throws {
        var timeManager = TimerManager()
        var differenceLapTimes = timeManager.leadLapTime()
        var expected = [String]()
        
        XCTAssertEqual(differenceLapTimes, expected)
        
        timeManager.lapTimes = []
    }
}
