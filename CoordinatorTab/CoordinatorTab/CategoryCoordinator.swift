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
    
    var delegate: CategoryCoordinatorDelegate? //있긴 있는데 안씀... 지워도 될듯..?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("CategoryCoordinator deinit")
    }
    
    func start() {
        let viewController: CategoryViewController = CategoryViewController(inputedCoordinator: self)
        self.navigationController.viewControllers = [viewController]
    }
}
