//
//  ViewController.swift
//  BlurVIewTest
//
//  Created by hanwe on 2020/12/15.
//

import UIKit

class ViewController: UIViewController {

    var blurView: BlurView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.blurView = BlurView.shared
    }
    
    @IBAction func testAction(_ sender: Any) {
        
        blurView?.showBlurView()
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        blurView?.showBlurView()
    }
    
    @objc func appMovedToForeground() {
        print("App moved to foreground!")
        blurView?.hide()
    }

}

