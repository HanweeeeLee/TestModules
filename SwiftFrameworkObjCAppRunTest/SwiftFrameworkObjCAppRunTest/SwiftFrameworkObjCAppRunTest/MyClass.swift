//
//  MyClass.swift
//  SwiftFrameworkObjCAppRunTest
//
//  Created by hanwe lee on 2020/07/02.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

public class MyClass: NSObject {
    @objc(test)
    public func test() {
        print("하이 ~")
    }
    
    @objc(addA:B:)
    public func add(A:Int,B:Int) {
        print("result:\(A+B)")
    }
    
    @objc(addStringA:B:)
    public func addString(A:String,B:String) {
        print("add string :\(A + B)")
    }
    
    @objc(mergeArrayA:B:)
    public func mergeArray(A:Array<String>,B:Array<String>) {
        var newA:Array = A
        let newB:Array = B
        for i in 0..<B.count {
            newA.append(newB[i])
        }
        print("mergeArr :\(newA)")
    }
}
