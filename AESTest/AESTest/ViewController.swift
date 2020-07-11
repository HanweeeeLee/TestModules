//
//  ViewController.swift
//  AESTest
//
//  Created by hanwe on 2020/07/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let message     = "Don´t try to read this text. Top Secret Stuff"
        let messageData = message.data(using:String.Encoding.utf8)!
        let keyData     = "12345678901234567890123456789012".data(using:String.Encoding.utf8)!
        let ivData      = "abcdefghijklmnop".data(using:String.Encoding.utf8)!
        var encData:Data = HWAESCryption.aesEncrypt(originalData: message.data(using: .utf8)!, iv: ivData, key: keyData, aesType: .aes256)
        print("enc:\(encData.base64EncodedString())")
        var decData:Data = HWAESCryption.aesDecrypt(encData: encData, iv: ivData, key: keyData, aesType: .aes256)!
        print("result:\(String(data: decData, encoding: .utf8))")
    }


}

