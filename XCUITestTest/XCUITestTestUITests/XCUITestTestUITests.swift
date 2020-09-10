//
//  XCUITestTestUITests.swift
//  XCUITestTestUITests
//
//  Created by hanwe lee on 2020/09/09.
//  Copyright © 2020 hanwe. All rights reserved.
//

import XCTest

class XCUITestTestUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_something() {
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        aKey.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        bKey.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        cKey.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Add"]/*[[".buttons[\"Add\"].staticTexts[\"Add\"]",".staticTexts[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let qKey = app/*@START_MENU_TOKEN@*/.keys["q"]/*[[".keyboards.keys[\"q\"]",".keys[\"q\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        qKey.tap()
        qKey.tap()
        qKey.tap()
        qKey.tap()
        app.buttons["Add"].tap()
        element.children(matching: .table).element.swipeUp()
        element.swipeDown()
        let tablesQuery = app.tables
        let qqqStaticText = tablesQuery.staticTexts["qqqq"]
        
        qqqStaticText.tap()
        qqqStaticText.tap()
        
        let aabcStaticText = tablesQuery.staticTexts["aabbcc"]
        aabcStaticText.tap()
        aabcStaticText.tap()
        
        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
