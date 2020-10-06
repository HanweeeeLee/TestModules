//
//  Example2RootViewController.swift
//  HeroExample
//
//  Created by hanwe lee on 2020/09/18.
//

import UIKit
import SnapKit
import Hero

class Example2RootViewController: UIViewController {
    
    enum Example2Type {
        case test1
        case test2
    }

    @IBOutlet weak var containterView: UIView!
    
    var currentType:Example2Type = .test1 {
        didSet {
            if self.currentType == .test1 {
                //여기에
                self.subview1.isHidden = false
                self.subview2.isHidden = true
                self.subview2.slidePush(direction: .right, completeHandler: {
                })
            }
            else {
                //여기에
                self.subview2.isHidden = false
                self.subview1.isHidden = true
                self.subview2.slidePush(direction: .left, completeHandler: {
                })
            }
        }
    }
    
    let subview1 = Example2SubView1.instance()
    let subview2 = Example2SubView2.instance()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containterView.addSubview(subview1)
        subview1.snp.makeConstraints({ make in
            make.leading.equalTo(self.containterView.snp.leading).offset(0)
            make.trailing.equalTo(self.containterView.snp.trailing).offset(0)
            make.top.equalTo(self.containterView.snp.top).offset(0)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(0)
        })
        self.subview1.isHeroEnabled = true
        self.subview1.heroID = "Example2SubView1"
        
        self.containterView.addSubview(subview2)
        subview2.snp.makeConstraints({ make in
            make.leading.equalTo(self.containterView.snp.leading).offset(0)
            make.trailing.equalTo(self.containterView.snp.trailing).offset(0)
            make.top.equalTo(self.containterView.snp.top).offset(0)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(0)
        })
        self.subview2.isHeroEnabled = true
        self.subview2.isHidden = true
        self.subview1.heroID = "Example2SubView2"
        
        self.containterView.isHeroEnabledForSubviews = true
        
    }
    
    @IBAction func testStart(_ sender: Any) {
        if self.currentType == .test1 {
            self.currentType = .test2
        }
        else {
            self.currentType = .test1
        }
    }
    
}

extension UIView {
    enum UIViewSlidePushDirection {
        case left
        case right
    }
    
    func slidePush(duration: TimeInterval = 0.2, completionDelegate: AnyObject? = nil,direction:UIViewSlidePushDirection,completeHandler:@escaping () -> ()) {
        
        self.alpha = 0.4
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 1.0
        }, completion: {[weak self] (finished: Bool) -> Void in
            completeHandler()
        })
        let slidePushTransition = CATransition()
        if let delegate: AnyObject = completionDelegate {
            slidePushTransition.delegate = delegate as? CAAnimationDelegate
        }
        slidePushTransition.type = CATransitionType.push
        var subType:CATransitionSubtype = .fromRight
        switch direction {
        case .left:
            subType = .fromLeft
            break
        case .right:
            subType = .fromRight
            break
        }
        slidePushTransition.subtype = subType
        slidePushTransition.duration = duration
        slidePushTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        slidePushTransition.fillMode = CAMediaTimingFillMode.removed
        slidePushTransition.startProgress = 0.85
        self.layer.add(slidePushTransition, forKey: "slidePushTransition")
    }
    
}

//UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
//    self.alpha = 0.0
//}, completion: {(finished: Bool) -> Void in
//    self.isHidden = true
//})
