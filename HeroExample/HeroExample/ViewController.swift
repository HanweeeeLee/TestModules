//
//  ViewController.swift
//  HeroExample
//
//  Created by hanwe lee on 2020/09/18.
//

import UIKit
import Hero

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hero.isEnabled = true
//        self.navigationController?.heroNavigationAnimationType =
//        self.hero.modalAnimationType = .pull(direction: .down)
        self.navigationController?.heroNavigationAnimationType = .fade
        
        // Do any additional setup after loading the view.
    }

    @IBAction func testStart(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Example1", bundle: nil)
        if let example1vc = storyboard.instantiateViewController(withIdentifier: "Example1ViewController1") as? Example1ViewController1 {
            self.navigationController?.pushViewController(example1vc, animated: true)
        }
    }
    
    @IBAction func testStart2(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Example2", bundle: nil)
        if let example1vc = storyboard.instantiateViewController(withIdentifier: "Example2RootViewController") as? Example2RootViewController {
            self.navigationController?.pushViewController(example1vc, animated: true)
        }
    }
}

