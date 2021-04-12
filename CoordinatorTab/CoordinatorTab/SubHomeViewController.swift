//
//  SubHomeViewController.swift
//  CoordinatorTab
//
//  Created by hanwe lee on 2021/04/12.
//

import UIKit

class SubHomeViewController: UIViewController {

    var coordinator: SubHomeCoodinator
    
    init(inputedCoordinator: SubHomeCoodinator) {
        self.coordinator = inputedCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("test")
    }
    
    @IBAction func popAction(_ sender: Any) {
        self.coordinator.pop()
    }
}
