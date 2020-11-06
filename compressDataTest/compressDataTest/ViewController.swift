//
//  ViewController.swift
//  compressDataTest
//
//  Created by hanwe lee on 2020/11/06.
//

import UIKit
import DataCompression

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let raw: Data! = String(repeating: "There is no place like 127.0.0.1", count: 25).data(using: .utf8)
        for algo: Data.CompressionAlgorithm in [.zlib, .lzfse, .lz4, .lzma] {
            let compressedData: Data! = raw.compress(withAlgorithm: algo)

            let ratio = Double(raw.count) / Double(compressedData.count)
            print("\(algo)   =>   \(compressedData.count) bytes, ratio: \(ratio)")
            
            assert(compressedData.decompress(withAlgorithm: algo)! == raw)
        }
        
        
        let myData :Data = "hello world".data(using: .utf8)!
        let compressedData: Data = myData.compress(withAlgorithm: .lzma)!
        print("compressedData :\(compressedData)")
        let unzipData :Data = compressedData.decompress(withAlgorithm: .lzma)!
        print("unzip :\(String(data: unzipData, encoding: .utf8))")

    }


}

