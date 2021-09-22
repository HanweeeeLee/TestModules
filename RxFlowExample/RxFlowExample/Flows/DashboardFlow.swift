//
//  DashboardFlow.swift
//  RxFlowExample
//
//  Created by hanwe on 2021/09/22.
//

import UIKit
import RxFlow

class DashboardFlow: Flow {
    
    // MARK: private property
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.topItem?.title = "DashBoard"
        return viewController
    }()
    
    // MARK: internal property
    
    var root: Presentable {
        return self.rootViewController
    }
    
    // MARK: lifeCycle
    
    // MARK: private function
    
    private func navigationToDashBoardScreen() -> FlowContributors {
        let dashboardViewController = DashBoardViewController(nibName: "DashBoardViewController", bundle: nil)
        dashboardViewController.title = "DashBoard !"
        self.rootViewController.pushViewController(dashboardViewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: dashboardViewController, withNextStepper: dashboardViewController, allowStepWhenNotPresented: false, allowStepWhenDismissed: false))
    }
    
    // MARK: internal function
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyStep else { return .none }
        
        switch step {
        case .view1IsRequired:
            return navigationToDashBoardScreen()
        default:
            return .none
        }
    }
    
    

}
