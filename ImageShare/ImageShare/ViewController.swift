//
//  ViewController.swift
//  ImageShare
//
//  Created by hanwe lee on 2021/04/14.
//

import UIKit
import LinkPresentation

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var myTestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func testAction(_ sender: Any) {
        if let snapshot = self.scrollView.snapshot() {
            
            //            /* 방법 1. 디스크에 있는 이미지를 공유하면 자동으로 들어간다. */
            //            let iconUrl: URL? = Bundle.main.url(forResource: "cat", withExtension: "jpg")
            //            let activityViewController = UIActivityViewController(activityItems: [iconUrl!], applicationActivities: nil)
            
            print("snapshot: \(snapshot)")
            let imageToShare = [ snapshot, self ]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.title = "asd"
            activityViewController.popoverPresentationController?.sourceView = self.myTestButton
            activityViewController.isModalInPresentation = true
            
            activityViewController.excludedActivityTypes = [ .airDrop, .message]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let image = UIImage(named: "cat")!
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.title = "사진을 공유해보세용"
        metadata.imageProvider = imageProvider
        return metadata
    }
}
