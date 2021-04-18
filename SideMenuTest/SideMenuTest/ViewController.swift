//
//  ViewController.swift
//  SideMenuTest
//
//  Created by hanwe on 2021/04/18.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func testAction(_ sender: Any) {
        // Define the menu
        let menu = SideMenuNavigationController(rootViewController: TestViewController(nibName: "TestViewController", bundle: nil))
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        menu.leftSide = true
        menu.menuWidth = 150
        menu.presentationStyle = .viewSlideOutMenuIn
        present(menu, animated: true, completion: nil)
    }
    

}

