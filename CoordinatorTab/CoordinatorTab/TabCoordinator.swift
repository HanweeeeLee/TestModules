//
//  TabCoordinator.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

class TabCoordinator: NSObject, Coordinator {
    
    
    var rootViewController: UIViewController {
        return tabController
    }
    
    let tabController: UITabBarController
    
    let homeCoordinator: HomeCoordinator
    let categoryCoordinator: CategoryCoordinator
    
    var childCoordinators: [Coordinator] = []
    
    override init() {
        self.tabController = UITabBarController()
        let homeNavigationController = UINavigationController()
        self.homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        let categoryNavigationController = UINavigationController()
        self.categoryCoordinator = CategoryCoordinator(navigationController: categoryNavigationController)
        
        var controllers: [UIViewController] = []
        let homeViewNavi = homeCoordinator.navigationController
        homeViewNavi.tabBarItem = UITabBarItem(title: "home", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        let categoryNavi = categoryCoordinator.navigationController
        categoryNavi.tabBarItem = UITabBarItem(title: "category", image: UIImage.init(systemName: "square.and.arrow.up"), selectedImage: UIImage.init(systemName: "square.and.arrow.up.fill"))
        controllers.append(homeViewNavi)
        controllers.append(categoryNavi)
        tabController.viewControllers = controllers
        tabController.tabBar.isTranslucent = false
        self.childCoordinators.append(self.homeCoordinator)
        self.childCoordinators.append(self.categoryCoordinator)
        self.homeCoordinator.start()
        self.categoryCoordinator.start()
        super.init()
    }
    
    func start() {
        print("start")
    }
    
}

extension TabCoordinator: UITabBarControllerDelegate {
}
