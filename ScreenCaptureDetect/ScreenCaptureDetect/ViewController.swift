//
//  ViewController.swift
//  ScreenCaptureDetect
//
//  Created by hanwe on 2020/12/19.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rcLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(screenshotTaken), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(screenRecord), name: UIScreen.capturedDidChangeNotification, object: nil)
//
//        avoidScreenshot()
    }
    
    @objc func screenshotTaken() {
        print("screen capture detected!!")
        self.label.text = "screen capture detected!!"
    }
    
    @objc func screenRecord() {
        print("recoded")
        self.rcLabel.text = "recoded"
    }
    
    func avoidScreenshot() { //사진 권한을 얻어야한다.
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: nil) { (_) in
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                let options = PHFetchOptions()
                options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                options.fetchLimit = 1
                
                let result = PHAsset.fetchAssets(with: .image, options: options)
                
                if result.count > 0 {
                    PHPhotoLibrary.shared().performChanges({
                        if let asset = result.firstObject {
                            PHAssetChangeRequest.deleteAssets([asset] as NSArray)
                        }
                    }, completionHandler: nil)
                }
            }
        }
    }

    
//    func applicationWillResignActive(_ application: UIApplication) {
//
//        //            imageview = UIImageView.init(image: UIImage.init(named: "bg_splash"))
//        //            self.window?.addSubview(imageview!)
//        //            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        //            // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//        print("applicationWillResignActive")
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        //            if (imageview != nil){
//        //
//        //                imageview?.removeFromSuperview()
//        //                imageview = nil
//        //            }
//        //            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        print("applicationDidBecomeActive")
//    }
    
    
}

