//
//  FirstViewController.swift
//  CoordinatorSample
//
//  Created by hanwe on 2021/03/26.
//

import UIKit

protocol CoordinatorViewController {
}

class FirstViewController: UIViewController, CoordinatorViewController, Storyboarded {

    //MARK: property
    weak var coordinator: MainCoordinator? //이걸 강제로 주입시키는 프로토콜을 만들면 좋을듯, 근데 weak 로 어떻게 protocol을?
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: action
    @IBAction func pushMe(_ sender: Any) {
        self.coordinator?.showSecondViewController()
    }
}
