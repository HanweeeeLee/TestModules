//
//  Year.swift
//  XCUnitTestExample
//
//  Created by hanwe lee on 2020/09/08.
//  Copyright © 2020 hanwe. All rights reserved.
//

import Foundation

struct Year {
    let calendarYear:Int
    
    var isLeapYear:Bool {
        get {
            return calendarYear%4 == 0 && ( calendarYear%100 != 0 || calendarYear%400 == 0)
        }
    }
}
