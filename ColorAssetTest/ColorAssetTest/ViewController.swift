//
//  ViewController.swift
//  ColorAssetTest
//
//  Created by hanwe lee on 2020/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var useCodeFixView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.useCodeFixView.backgroundColor = UIColor(asset: Colors.myRedTone)
    }
    
    


}

