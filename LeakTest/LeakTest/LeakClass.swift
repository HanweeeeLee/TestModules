//
//  LeakClass.swift
//  LeakTest
//
//  Created by hanwe lee on 2020/11/26.
//

import Foundation
import UIKit

protocol LeakClassDelegate {
    func test()
    func sendImg(img:UIImage)
}

class LeackClass {
    var delegate: LeakClassDelegate?
    var testMyArr:Array<UIImage> = Array()
    func makeSomething() {
        for _ in 0..<100000 {
            self.testMyArr.append(UIImage(named: "sample")!)
        }
    }
}
