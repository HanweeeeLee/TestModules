//
//  ViewController.swift
//  buttonIsChecked
//
//  Created by hanwe lee on 2021/06/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("myButton state: \(myButton.isSelected)")
        
    }

    @IBAction func testAction(_ sender: Any) {
        print("myButton:\(myButton.isSelected)")
        myButton.isSelected = !myButton.isSelected
    }
    
}

