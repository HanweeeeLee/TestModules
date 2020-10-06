//
//  Example1ViewController2.swift
//  HeroExample
//
//  Created by hanwe lee on 2020/09/18.
//

import UIKit
import Hero

class Example1ViewController2: UIViewController {

    @IBOutlet var whiteView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        redView.hero.id = "ironMan"
        orangeView.hero.id = "batMan"
        self.whiteView.hero.modifiers = [.translate(y:100)]
        
    }
    
    @IBAction func testAction(_ sender: Any) {
        //구조상 이 뷰 호출하는 뷰컨트롤러가 있고
        //이전뷰랑 이 뷰랑 둘 다 가지고있어야할듯?????
    }
    
}
