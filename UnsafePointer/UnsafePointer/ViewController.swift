//
//  ViewController.swift
//  UnsafePointer
//
//  Created by hanwe on 2020/07/19.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var myData:Data = "hello".data(using: .utf8)!
        var ptr:UnsafePointer<UInt8> = ViewController.dataToUnsafePointer(data: myData)!
        var ptr2:UnsafePointer<UInt16> = (UnsafePointer<UInt16>)ptr
    }

    static func dataToUnsafePointer(data:Data) -> UnsafePointer<UInt8>? {

        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
        let stream = OutputStream(toBuffer: buffer, capacity: data.count)
        stream.open()
        let value = data.withUnsafeBytes {
            $0.baseAddress?.assumingMemoryBound(to: UInt8.self)
        }
        guard let val = value else {
            return nil
        }
        stream.write(val, maxLength: data.count)
        stream.close()
        
        return UnsafePointer<UInt8>(buffer)
    }

}

