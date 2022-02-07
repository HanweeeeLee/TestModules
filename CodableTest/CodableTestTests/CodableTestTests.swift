//
//  CodableTestTests.swift
//  CodableTestTests
//
//  Created by Aaron Hanwe LEE on 2022/02/07.
//

import XCTest
@testable import CodableTest

class CodableTestTests: XCTestCase {

    let mock1: String = "{\"name\" : \"asd\",\"myValue\" : {\"test\": \"100\"}}"
    let mock2: String = "{\"name\" : \"www\",\"myValue\" : {\"test\": [\"200\"]}}"
    let mock3: String = "{\"name\" : \"eee\",\"myValue\" : {\"test\": [[\"300\"]]}}"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let mock1Data = mock1.data(using: .utf8)
        let mock2Data = mock2.data(using: .utf8)
        let mock3Data = mock3.data(using: .utf8)
        let decoder = JSONDecoder()
        if let data = mock1Data, let result = try? decoder.decode(Model.self, from: data) {
            print("result: \(result)")
        } else {
            print("dddd")
        }
        
        if let data2 = mock2Data, let result = try? decoder.decode(Model.self, from: data2) {
            print("result: \(result)")
        } else {
            print("dddd")
        }
        
        if let data3 = mock3Data, let result = try? decoder.decode(Model.self, from: data3) {
            print("result: \(result)")
        } else {
            print("dddd")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
