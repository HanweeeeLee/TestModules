
//
//  PushedViewController.swift
//  SwipeTransitionTest
//
//  Created by hanwe lee on 2020/09/08.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SwipeTransition
//import SwipeTransitionAutoSwipeBack

class PushedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.swipeBack?.isEnabled = true
        
    }

}
