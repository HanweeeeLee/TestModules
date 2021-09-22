//
//  AppFlow.swift
//  RxFlowExample
//
//  Created by hanwe on 2021/09/22.
//

import UIKit
import RxFlow
import RxCocoa
import RxSwift

class AppFlow: Flow {
    
    // MARK: private property
    
    private let rootWindow: UIWindow
    
    // MARK: internal property
    
    var root: Presentable {
        return self.rootWindow
    }
    
    // MARK: lifeCycle
    
    init(withWindow window: UIWindow) {
        self.rootWindow = window
    }
    
    // MARK: private function
    
    private func navigationToGuideScreen() -> FlowContributors {

        if let rootViewController = self.rootWindow.rootViewController {
            rootViewController.dismiss(animated: false)
        }

        let guideFlow = GuideFlow()
        Flows.use(guideFlow, when: Flows.ExecuteStrategy.ready, block: { [weak self] root in
            self?.rootWindow.rootViewController = root
        }) // 이거 뭔지 검토
        
        return .one(flowContributor: .contribute(withNextPresentable: guideFlow, withNextStepper: OneStepper(withSingleStep: MyStep.guideIsRequired), allowStepWhenNotPresented: false, allowStepWhenDismissed: false))
        
    }

    private func navigationToDashboardScreen() -> FlowContributors {
        if let rootViewController = self.rootWindow.rootViewController {
            rootViewController.dismiss(animated: false)
        }

        let dashboardFlow = DashboardFlow()
        Flows.use(dashboardFlow, when: Flows.ExecuteStrategy.ready, block: { [weak self] root in
            self?.rootWindow.rootViewController = root
        }) // 이거 뭔지 검토
        
        return .one(flowContributor: .contribute(withNextPresentable: dashboardFlow, withNextStepper: OneStepper(withSingleStep: MyStep.view1IsRequired), allowStepWhenNotPresented: false, allowStepWhenDismissed: false))
    }
    
    // MARK: internal function
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyStep else { return FlowContributors.none }
        switch step {
        case .guideIsRequired:
            return navigationToGuideScreen()
        case .guideIsComplited, .dashBoardIsRequired:
            return navigationToDashboardScreen()
        default:
            return .none
        }
    }

}

class AppStepper: Stepper {
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    
    var initialStep: Step {
        return MyStep.guideIsRequired
    }
    
//    let steps = PublishRelay<Step>()
//    private let appServices: AppServices
//    private let disposeBag = DisposeBag()
//
//    init(withServices services: AppServices) {
//        self.appServices = services
//    }
//
//    var initialStep: Step {
////        return SampleStep.dashboardIsRequired
//        return SampleStep.onboardingIsRequired
//    }
//
//    /// callback used to emit steps once the FlowCoordinator is ready to listen to them to contribute to the Flow
//    func readyToEmitSteps() {
//        self.appServices
//            .preferencesService.rx
//            .isOnboarded
//            .debug()
//            .map { $0 ? SampleStep.onboardingIsComplete : SampleStep.onboardingIsRequired }
//            .debug()
//            .bind(to: self.steps)
//            .disposed(by: self.disposeBag)
//    }
}
