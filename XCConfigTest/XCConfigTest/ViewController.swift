//
//  ViewController.swift
//  XCConfigTest
//
//  Created by hanwe lee on 2021/11/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _ = AF.session
        _ = JSON()
    }


}

