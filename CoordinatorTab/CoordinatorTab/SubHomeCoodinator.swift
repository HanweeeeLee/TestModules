//
//  SubHomeCoodinator.swift
//  CoordinatorTab
//
//  Created by hanwe lee on 2021/04/12.
//

import UIKit

class SubHomeCoodinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("SubHomeCoodinator deinit")
    }
    
    func start() {
        
    }
    
    func pop() {
//        self.parentsCoordinator.pop() 
        self.navigationController.popViewController(animated: true)
    }

}
