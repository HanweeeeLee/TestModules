//
//  ViewController.swift
//  PushAndNavigationTest
//
//  Created by hanwe on 2020/12/03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func action(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "MyViewController") as? MyViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    

}

