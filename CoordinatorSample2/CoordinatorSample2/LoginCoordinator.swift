//
//  LoginCoordinator.swift
//  CoordinatorSample2
//
//  Created by hanwe on 2021/03/27.
//

import UIKit

protocol LoginCoordinatorDelegate: class {
    func didLoggedIn(_ coordinator: LoginCoordinator)
}

class LoginCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    
    private var navigationController: UINavigationController
    
    var delegate: LoginCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func start() {
        let viewController: LoginViewController = LoginViewController()
        viewController.view.backgroundColor = .brown
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
        
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func login() {
        print("login")
        self.delegate?.didLoggedIn(self)
    }
}
