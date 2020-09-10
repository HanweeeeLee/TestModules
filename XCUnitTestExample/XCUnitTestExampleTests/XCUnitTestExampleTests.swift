//
//  XCUnitTestExampleTests.swift
//  XCUnitTestExampleTests
//
//  Created by hanwe lee on 2020/09/08.
//  Copyright © 2020 hanwe. All rights reserved.
//

import XCTest
import XCUnitTestExample
@testable import XCUnitTestExample

class XCUnitTestExampleTests: XCTestCase {

    override func setUpWithError() throws { //생성자
        print("***************** start unit test *****************")
    }

    override func tearDownWithError() throws { //소멸자
        print("***************** end unit test *****************")
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
    
    func testVanillaLeapYear() {
        let year = Year(calendarYear: 1996)
        XCTAssertTrue(year.isLeapYear)
    }
    
    func testAnyOldYear() {
        let year = Year(calendarYear: 1997)
        XCTAssertTrue(!year.isLeapYear)
    }
    
    func testCentury() {
        let year = Year(calendarYear: 1900)
        XCTAssertTrue(!year.isLeapYear)
    }
    
    func testExceptionalCentury() {
        let year = Year(calendarYear: 2400)
        XCTAssertTrue(year.isLeapYear)
    }

}
