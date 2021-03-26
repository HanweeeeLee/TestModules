//
//  SecondViewController.swift
//  CoordinatorSample
//
//  Created by hanwe on 2021/03/26.
//

import UIKit

class SecondViewController: UIViewController, CoordinatorViewController, Storyboarded {

    //MARK: property
    weak var coordinator: MainCoordinator!
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
