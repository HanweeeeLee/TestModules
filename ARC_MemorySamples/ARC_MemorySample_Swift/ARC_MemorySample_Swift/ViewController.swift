//
//  ViewController.swift
//  ARC_MemorySample_Swift
//
//  Created by hanwe lee on 2021/03/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        strongRef()
        weakRef()
        unownedRef()
    }
    
    func strongRef() {
        var myObj: NSObject? = NSObject()
        let myObjPtr: NSObject? = myObj
        print("log1:\(myObj)")
        print("log2:\(myObjPtr)")
        myObj = nil
        print("log3:\(myObj)")
        print("log4:\(myObjPtr)")
    }
    
    func weakRef() {
        var myObj: NSObject? = NSObject()
        weak var myObjPtr: NSObject? = myObj
        print("log1:\(myObj)")
        print("log2:\(myObjPtr)")
        myObj = nil
        print("log3:\(myObj)")
        print("log4:\(myObjPtr)")
    }
    
    func unownedRef() {
        var myObj: NSObject? = NSObject()
        unowned var myObjPtr: NSObject? = myObj
        print("log1:\(myObj)")
        print("log2:\(myObjPtr)")
        myObj = nil
        print("log3:\(myObj)")
//        print("log4:\(myObjPtr)") //죽는다
    }


}

