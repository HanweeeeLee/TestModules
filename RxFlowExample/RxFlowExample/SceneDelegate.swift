//
//  SceneDelegate.swift
//  RxFlowExample
//
//  Created by hanwe on 2021/09/22.
//

import UIKit
import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var coordinator: FlowCoordinator = FlowCoordinator()
    var appFlow: AppFlow!
    var disposeBag = DisposeBag()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let window = self.window else { return }

        coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
//            log.debug("\n➡️ will navigate to flow=\(flow) and step=\(step)")
            print("?!#?!@?#!@?#?")
        }).disposed(by: self.disposeBag)

        // 작업 후에..
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
//            log.debug("\n➡️ did navigate to flow=\(flow) and step=\(step)")
            print("?!#?!@?#!@?#?@222")
        }).disposed(by: self.disposeBag)

//        self.appFlow = AppFlow(withWindow: window, andServices: self.appServices)
        self.appFlow = AppFlow(withWindow: window)

//        coordinator.coordinate(flow: self.appFlow, with: AppStepper(withServices: self.appServices))
        coordinator.coordinate(flow: self.appFlow, with: AppStepper())
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

