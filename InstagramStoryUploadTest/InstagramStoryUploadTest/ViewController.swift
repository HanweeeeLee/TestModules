//
//  ViewController.swift
//  InstagramStoryUploadTest
//
//  Created by hanwe on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func testStart(_ sender: Any) {
        if let storyShareURL = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(storyShareURL)
            {
                let renderer = UIGraphicsImageRenderer(size: myView.bounds.size)
                let renderImage = renderer.image { _ in
                    myView.drawHierarchy(in: myView.bounds, afterScreenUpdates: true)
                }
                guard let imageData = renderImage.pngData() else {return}
                let pasteboardItems : [String:Any] = [
                    "com.instagram.sharedSticker.stickerImage": imageData,
                    "com.instagram.sharedSticker.backgroundTopColor" : "#636e72",
                    "com.instagram.sharedSticker.backgroundBottomColor" : "#b2bec3",
                ]
                let pasteboardOptions = [
                    UIPasteboard.OptionsKey.expirationDate : Date().addingTimeInterval(300)
                ]
                UIPasteboard.general.setItems([pasteboardItems], options: pasteboardOptions)
                UIApplication.shared.open(storyShareURL, options: [:], completionHandler: nil)
            }
            else
            {
                let alert = UIAlertController(title: "알림", message: "인스타그램이 필요합니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

