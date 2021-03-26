//
//  MainCoordinator.swift
//  CoordinatorSample
//
//  Created by hanwe on 2021/03/26.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    
    //MARK: property
    var childCoordinators: [CoordinatorProtocol] = []
    var navi: UINavigationController
    
    //MARK: lifeCycle
    init(navigation: UINavigationController) {
        self.navi = navigation
        
    }
    
    
    //MARK: function
    func start() {
        let vc = FirstViewController.instantiate(storyboardName: "Main")
        vc.coordinator = self 
        self.navi.pushViewController(vc, animated: false)
    }
    
    func showSecondViewController() {
        let vc = SecondViewController.instantiate(storyboardName: "Main")
        vc.coordinator = self
        self.navi.pushViewController(vc, animated: false)
    }
    

}
