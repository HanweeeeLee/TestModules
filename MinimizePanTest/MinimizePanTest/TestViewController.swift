//
//  TestViewController.swift
//  MinimizePanTest
//
//  Created by hanwe lee on 2020/10/05.
//

import UIKit
import Hero

class TestViewController: MyViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var hideLabel: UILabel!
    
    override var currentProgress: CGFloat {
        didSet {
            print("current:\(self.currentProgress)")
            self.imgViewCenterXConstraint.constant = -((1 - currentProgress) * 30)
            self.hideLabel.alpha = (1 - currentProgress)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        self.imgView.hero.id = "abc"
        self.view.hero.id = "mainView"
        self.hideLabel.hero.id = "myLabel"
        self.hideLabel.hero.modifiers = [.useNoSnapshot]
        self.addPhotoViewCenterXConstraint(constraint: self.imgViewCenterXConstraint)
        self.hideLabel.alpha = 0
    }
    
    @IBAction func testAction(_ sender: Any) {
        self.imgViewCenterXConstraint.constant = 30
    }

}

extension TestViewController {
    
}
