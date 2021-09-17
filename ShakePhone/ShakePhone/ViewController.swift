//
//  ViewController.swift
//  ShakePhone
//
//  Created by hanwe on 2021/09/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController: TestViewController = storyboard.instantiateViewController(identifier: "TestViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("Device was shaken!")
    }


}

