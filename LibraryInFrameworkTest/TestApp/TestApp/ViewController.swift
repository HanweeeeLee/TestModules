//
//  ViewController.swift
//  TestApp
//
//  Created by hanwe lee on 2020/07/02.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import LibraryInFrameworkTest

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var module:MyFramework = MyFramework()
        module.genSafePrimeNumber(bits: 3)
    }


}

