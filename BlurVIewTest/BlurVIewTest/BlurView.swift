//
//  BlurView.swift
//  hanwe
//
//  Created by hanwe on 2020. 12. 15..
//  Copyright © 2020년 hanwe. All rights reserved.
//

import UIKit
class BlurView: UIView {

    struct ScreenSize  {
        static let Width         = UIScreen.main.bounds.size.width
        static let Height        = UIScreen.main.bounds.size.height
        static let Max_Length    = max(ScreenSize.Width, ScreenSize.Height)
        static let Min_Length    = min(ScreenSize.Width, ScreenSize.Height)
    }
    
    static let shared: BlurView = {
        
        let instance = BlurView()
        instance.frame = UIScreen.main.bounds
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        instance.isHidden = true
        appDelegate.window?.addSubview(instance)
        instance.makeBlurView()
        
        return instance
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:1).withAlphaComponent(0.2)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeBlurView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func showBlurView() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
        
    }
    
}
