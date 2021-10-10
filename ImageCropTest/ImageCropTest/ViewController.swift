//
//  ViewController.swift
//  ImageCropTest
//
//  Created by hanwe on 2021/10/10.
//

import UIKit
import CropViewController

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func presentCropViewController() {
      let image: UIImage = UIImage(named: "tomato")!
      
      let cropViewController = CropViewController(image: image)
      cropViewController.delegate = self
      present(cropViewController, animated: true, completion: nil)
    }
    @IBAction func testAction(_ sender: Any) {
        presentCropViewController()
    }
    
    
}

extension ViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        print("image: \(image)")
        DispatchQueue.main.async {
            self.myImageView.image = image
            cropViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        if cancelled {
            print("cancelled")
        } else {
            print("not cancelled")
        }
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        print("circularImage: \(image)")
    }
}
