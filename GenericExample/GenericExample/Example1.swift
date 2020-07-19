//
//  Example1.swift
//  GenericExample
//
//  Created by hanwe on 2020/07/19.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

class Example1: NSObject {
    func swap(a: inout Int,b: inout Int) {
        let tmp:Int = a
        a = b
        b = tmp
    }
    
    func swap(a: inout Double,b: inout Double) {
        let tmp:Double = a
        a = b
        b = tmp
    }
    
    func swap(a: inout String,b: inout String) {
        let tmp:String = a
        a = b
        b = tmp
    }
    
    func swapGeneric<T>(a: inout T,b: inout T) {
        let tmp:T = a
        a = b
        b = tmp
    }
    
    func findIndex<T:Equatable>(ofString valueToFind: T, in array: [T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
}
