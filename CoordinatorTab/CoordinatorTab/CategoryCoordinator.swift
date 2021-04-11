//
//  CategoryCoordinator.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

protocol CategoryCoordinatorDelegate: class {
    
}


class CategoryCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var delegate: CategoryCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("CategoryCoordinator deinit")
    }
    
    func start() {
        let viewController: CategoryViewController = CategoryViewController()
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
        
    }
}

extension CategoryCoordinator: CategoryViewControllerDelegate {
    func moveTab(to: TabType) {
        
    }
}
