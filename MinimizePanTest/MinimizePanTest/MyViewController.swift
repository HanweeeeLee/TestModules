//
//  MyViewController.swift
//  MinimizePanTest
//
//  Created by hanwe lee on 2020/10/05.
//

import UIKit

protocol MyViewControllerDelegate:class {
    func currentProgress(persent:CGFloat)
}

class MyViewController: UIViewController {

    enum MyState {
        case max
        case min
    }
    //MAKR: public property
    
    public var state:MyState = .max
    
    //MARK: private property
    
//    var statusbarHeight:CGFloat = 0
    private var originBoundsYPosition:CGFloat = 0
    private var currentBoundsYPosition:CGFloat = 0 {
        didSet {
//            self.currentBoundsYPosition
            self.currentProgress = 1 + self.currentBoundsYPosition/self.view.bounds.height
        }
    }
    private var centerYPosition:CGFloat = 0
    public var currentProgress:CGFloat = 1 {
        didSet {
//            print("test:\(self.currentProgress)")
//            self.view.alpha = self.currentAlpha
//            self.imgViewCenterXConstraint?.constant
//            print("test2:\(String(describing: self.imgViewCenterXConstraint?.constant))")
        }
    }
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.statusbarHeight = UIApplication.shared.statusBarFrame.size.height
//        print("status:\(self.statusbarHeight)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initSetting()
    }
    //MARK: public function
    
    func addPhotoViewCenterXConstraint(constraint:NSLayoutConstraint) {
        
    }
    
    //MARK: private function
    
    func initSetting() {
        self.originBoundsYPosition = self.view.bounds.minY
        self.centerYPosition = self.view.bounds.height/2
        let panGuesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        self.view.addGestureRecognizer(panGuesture)
    }
    
    func dismissTest() {
//        self.dismiss(animated: true, completion: {
//
//        })
        self.hero.dismissViewController(completion: {
            
        })
    }
    
    func recoveryTest() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.bounds = CGRect(x: 0, y: self.originBoundsYPosition, width: self.view.frame.width, height: self.view.frame.height)
        })
    }
    
    @objc func panAction(_ recognizer: UIPanGestureRecognizer) {
        let transition = recognizer.translation(in: self.view)
//        var changeY = self.view.frame.minY + transition.y
        print("changeY :\(transition.y)")
        
//        recognizer.state
        switch recognizer.state {
        case .began:
            print("pan start")
            break
        case .possible:
            break
        case .changed:
            self.currentBoundsYPosition = -transition.y
            self.view.bounds = CGRect(x: 0, y: self.currentBoundsYPosition, width: self.view.frame.width, height: self.view.frame.height)
            break
        case .ended:
            print("pan end")
            print("current:\(-self.currentBoundsYPosition)")
            print("center:\(self.centerYPosition)")
            if -self.currentBoundsYPosition > self.centerYPosition {
                self.state = .min
                dismissTest()
            }
            else {
                self.state = .max
                self.recoveryTest()
            }
            break
        case .cancelled:
            break
        case .failed:
            self.view.bounds = CGRect(x: 0, y: self.originBoundsYPosition, width: self.view.frame.width, height: self.view.frame.height)
            self.currentBoundsYPosition = self.originBoundsYPosition
            break
        @unknown default:
            break
        }
        
    }

}
