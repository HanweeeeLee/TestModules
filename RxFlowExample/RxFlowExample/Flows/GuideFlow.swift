//
//  GuideFlow.swift
//  RxFlowExample
//
//  Created by hanwe on 2021/09/22.
//

import UIKit
import RxFlow

class GuideFlow: Flow {
    
    // MARK: private property
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.topItem?.title = "Guide"
        return viewController
    }()
    
    // MARK: internal property
    
    var root: Presentable {
        return self.rootViewController
    }
    
    // MARK: lifeCycle
    
    // MARK: private function
    
    private func navigationToOnboardingIntroScreen() -> FlowContributors {
        let guideViewController = GuideViewController(nibName: "GuideViewController", bundle: nil)
        guideViewController.title = "가이드!"
        self.rootViewController.pushViewController(guideViewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: guideViewController, withNextStepper: guideViewController, allowStepWhenNotPresented: false, allowStepWhenDismissed: false))
    }
    
    // MARK: internal function
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyStep else { return .none }
        
        switch step {
        case .guideIsRequired:
            return navigationToOnboardingIntroScreen()
        case .guideIsComplited:
            return .end(forwardToParentFlowWithStep: MyStep.guideIsComplited)
        default:
            return .none
        }
    }
    

}

