//
//  HomeViewController.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    var coordinator: HomeCoordinator
    
    init(inputedCoordinator: HomeCoordinator) {
        self.coordinator = inputedCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .brown
    }
    @IBAction func pushAction(_ sender: Any) {
        self.coordinator.push(route: .subHome, animated: true)
    }
}
