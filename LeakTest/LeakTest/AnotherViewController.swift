//
//  AnotherView.swift
//  LeakTest
//
//  Created by hanwe lee on 2020/11/26.
//

import Foundation
import UIKit




class AnotherViewController: UIViewController, LeakClassDelegate {
    func test() {
        
    }
    
    func sendImg(img: UIImage) {
        
    }
    
    var delegate: LeakClassDelegate?
    var imgArr: Array<UIImage> = Array()
    var leackClass: LeackClass = LeackClass()
    @IBOutlet weak var secondImgView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        self.leackClass.delegate = self
        self.leackClass.makeSomething()
    }
    @IBAction func action(_ sender: Any) {
        self.delegate?.test()
        self.imgArr.append(UIImage(named: "sample")!)
        self.delegate?.sendImg(img: self.imgArr[0])
        
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
