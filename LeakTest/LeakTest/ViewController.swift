//
//  ViewController.swift
//  LeakTest
//
//  Created by hanwe lee on 2020/11/26.
//
import UIKit

class ViewController: UIViewController, LeakClassDelegate {

    var myName: String = "this is main"
    var imgArr:Array<UIImage> = Array()
    weak var currentPresentedVC: AnotherViewController? = nil
    let myImg: UIImage = UIImage(named: "sample")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func myAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        print("current:\(self.currentPresentedVC)")
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "AnotherViewController") as? AnotherViewController {
            print("vc:\(vc)")
            vc.delegate = self
            
            self.currentPresentedVC = vc
            print("current!:\(currentPresentedVC)")
//            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true, completion: {
                vc.secondImgView.image = self.myImg
            })
        }
       
    }
    
    func test() {
        print("hi")
    }
    
    func sendImg(img: UIImage) {
        self.imgArr.append(img)
    }
    
}


