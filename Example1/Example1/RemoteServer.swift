//
//  RemoteServer.swift
//  Example1
//
//  Created by hanwe on 2020/05/20.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

class RemoteServer {
    let queue = OperationQueue()
    let images = ["dog": "dog.jpg", "cat": "cat.png"]
    
    func requestImage(style name: String, handler: @escaping (UIImage?)-> Void) {
        //서브스레드에 의해서 실행됨
        queue.addOperation {
            Thread.sleep(forTimeInterval: 5) //5초간 대기
            if let imageName = self.images[name] {
                handler(UIImage(named: imageName))
            }
            else {
                handler(nil)
            }
        }
    }
}
