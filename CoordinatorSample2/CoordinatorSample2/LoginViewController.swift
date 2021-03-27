//
//  LoginViewController.swift
//  CoordinatorSample2
//
//  Created by hanwe on 2021/03/27.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func login()
}

class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "로그인", style: .plain, target: self, action: #selector(self.loginButtonDidTap))
        self.navigationItem.rightBarButtonItem = item
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    @objc func loginButtonDidTap() {
        print("loginButtonDidTap")
        self.delegate?.login()
    }

}
