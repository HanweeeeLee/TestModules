//
//  ViewController.swift
//  PanModalSample
//
//  Created by hanwe on 2021/09/17.
//

import UIKit
import PanModal


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func action1(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController: TestViewController1 = storyboard.instantiateViewController(identifier: "TestViewController1")
        
        self.presentPanModal(viewController)
//        present(viewController, animated: true)
    }
    
    @IBAction func action2(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController: TestViewController2 = storyboard.instantiateViewController(identifier: "TestViewController2")
        self.presentPanModal(viewController)
//        present(viewController, animated: true)
    }
}

