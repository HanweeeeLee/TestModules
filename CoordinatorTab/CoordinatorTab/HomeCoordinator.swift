//
//  HomeCoordinator.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    enum Route {
        case subHome
        case login
    }
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("HomeCoordinator deinit")
    }
    
    func start() {
        let viewController: HomeViewController = HomeViewController(inputedCoordinator: self)
        self.navigationController.viewControllers = [viewController]
    }
    
    func push(route: Route, animated: Bool) {
        switch route {
        case .subHome:
            let subHomeCoordinator: SubHomeCoodinator = SubHomeCoodinator(navigationController: self.navigationController)
            let vc: SubHomeViewController = SubHomeViewController(inputedCoordinator: subHomeCoordinator)
            self.childCoordinators = self.childCoordinators.filter { $0 !== subHomeCoordinator }
//            self.childCoordinators.append(subHomeCoordinator)
            self.navigationController.pushViewController(vc, animated: animated)
            break
        case .login:
            //login 화면을 push
            break
        }
    }
}
