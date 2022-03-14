//
//  ViewController.swift
//  SwiftyTimerSample
//
//  Created by hanwe on 2022/03/14.
//

import UIKit
import SwiftyTimer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.every(5.seconds) { [weak self] in
            self?.test1()
        }

        Timer.after(1.minute) {
            print("Are you still here?")
        }
    }
    
    @objc func test1() {
        print("test")
    }


}

