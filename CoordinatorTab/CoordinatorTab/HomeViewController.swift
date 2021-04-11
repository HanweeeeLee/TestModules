//
//  HomeViewController.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

protocol HomeViewControllerDelegate: CommonTabProtocol {
    
}

class HomeViewController: UIViewController {

    var delegate: HomeViewControllerDelegate?
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
    }
}
