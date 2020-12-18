//
//  ViewController.swift
//  SwipeGesture
//
//  Created by hanwe lee on 2020/12/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        self.view.addGestureRecognizer(swipeGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        self.view.addGestureRecognizer(swipeLeftGesture)
        self.view.addGestureRecognizer(swipeRightGesture)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            print("swipe left")
        }
        else if sender.direction == .right {
            print("swipe right")
        }
        else {
            
        }
    }


}

