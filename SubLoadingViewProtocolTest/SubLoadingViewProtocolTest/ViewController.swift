//
//  ViewController.swift
//  SubLoadingViewProtocolTest
//
//  Created by hanwe lee on 2021/03/09.
//

import UIKit

class ViewController: UIViewController, SubViewLoadingProtocol {
    var subViewLoadingView: UIImageView = UIImageView()
    
    var subViewLoadingViewSize: CGSize = CGSize(width: 50, height: 50)
    
    var minimumLoadingTime: TimeInterval = 0.5
    
    var subViewLoadingViewBackgroundViewColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    

    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func testStart(_ sender: Any) {
        self.subViewLoadingView = self.makeLoadingView()
        showSubLoadingView(view: self.myView, fadeInDuration: self.minimumLoadingTime, completion: {
            print("showEnd")
        })
    }
    @IBAction func hide(_ sender: Any) {
        hideSubLoadingView(view: self.myView, fadeOutDuration: self.minimumLoadingTime, completion: {
            print("hide end")
        })
    }
    
    func makeLoadingView() -> UIImageView {
        
        let imgView = UIImageView()
        imgView.animationImages = nil
        var downImagesCircle = [UIImage]()

        for i in 1..<9 {
            downImagesCircle.append(UIImage(named: String(format: "%d", i))!)
        }

        imgView.animationImages = downImagesCircle
        imgView.animationDuration = 0.6
        imgView.animationRepeatCount = 0
        return imgView
    }
    
}

