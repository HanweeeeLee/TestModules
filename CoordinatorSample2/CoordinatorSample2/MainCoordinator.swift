//
//  MainCoordinator.swift
//  CoordinatorSample2
//
//  Created by hanwe on 2021/03/27.
//

import UIKit

protocol MainCoordinatorDelegate {
    func didLoggedOut(_ coordinator: MainCoordinator)
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var delegate: MainCoordinatorDelegate?
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("MainCoordinator deinit")
    }
    
    func start() {
        let viewController = MainViewController()
        viewController.view.backgroundColor = .cyan
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }
    
}

extension MainCoordinator: MainViewControllerDelegate {
    func logout() {
        self.delegate?.didLoggedOut(self)
    }
}
