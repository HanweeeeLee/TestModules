//
//  HomeCoordinator.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

protocol HomeCoordinatorDelegate: class {
    
}

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var delegate: HomeCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("HomeCoordinator deinit")
    }
    
    func start() {
        let viewController: HomeViewController = HomeViewController()
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
        
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func moveTab(to: TabType) {
        
    }
}
