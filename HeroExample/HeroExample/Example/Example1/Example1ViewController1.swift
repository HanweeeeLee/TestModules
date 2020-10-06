//
//  Example1ViewController1.swift
//  HeroExample
//
//  Created by hanwe lee on 2020/09/18.
//

import UIKit
import Hero

class Example1ViewController1: UIViewController {

    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        redView.hero.id = "ironMan"
        orangeView.hero.id = "batMan"
    }
    
    @IBAction func testStart(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Example1", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "Example1ViewController2") as? Example1ViewController2 {
            self.hero.replaceViewController(with: viewController, completion: {
                print("ㅇ?")
            })
        }
    }
    
}
