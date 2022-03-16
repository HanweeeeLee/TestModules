//
//  ViewController.swift
//  RotateAnimation
//
//  Created by hanwe on 2022/03/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: RotateView!
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func testStart(_ sender: Any) {
        if flag {
            flag = false
            self.myView.stop()
        } else {
            flag = true
            self.myView.play()
        }
    }
    
}
