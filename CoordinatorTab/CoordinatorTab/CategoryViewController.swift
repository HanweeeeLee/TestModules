//
//  CategoryViewController.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

protocol CategoryViewControllerDelegate: CommonTabProtocol {
    
}

class CategoryViewController: UIViewController {

    var delegate: CategoryViewControllerDelegate?
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }

}
