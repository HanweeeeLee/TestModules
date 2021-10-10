//
//  ViewController.swift
//  ImageCropTest
//
//  Created by hanwe on 2021/10/10.
//

import UIKit
import CropViewController
import Photos

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
    @IBAction func photoAlbumAction(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { [unowned self] (status) in
            DispatchQueue.main.async { [unowned self] in
                let vc = PhotoViewController.init(nibName: "PhotoViewController", bundle: nil)
                self.present(vc, animated: true, completion: nil)
            }
        }
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
