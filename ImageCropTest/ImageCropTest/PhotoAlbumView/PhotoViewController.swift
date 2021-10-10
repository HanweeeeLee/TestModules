//
//  PhotoViewController.swift
//  ImageCropTest
//
//  Created by hanwe on 2021/10/10.
//

import UIKit
import Photos
import CropViewController

class PhotoViewController: UIViewController {

    var photoView: HWPhotoListFromAlbumView? = nil
    var myDic: [PHAsset: PhotoFromAlbumModel]? = nil
    var myImage: UIImage? = nil
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoView = HWPhotoListFromAlbumView.loadFromNibNamed(nibNamed: "HWPhotoListFromAlbumView")
//        self.photoView?.switchSelectFlag(selectType: .multi)
        self.photoView?.delegate = self
        self.containerView.addSubview(photoView!)
    }
    
    @IBAction func confirm(_ sender: Any) {
        let allKeys = Array(self.myDic!.keys)
        let item = myDic![allKeys[0]]
        let image = getAssetThumbnail(asset: item!.asset!)
        print("image: \(image)")
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
        })
        return thumbnail
    }
    
}

extension PhotoViewController: HWPhotoListFromAlbumViewDelegate {
    func selectedImgsFromAlbum(selectedImg: [PHAsset : PhotoFromAlbumModel], focusIndexAsset: PHAsset) {
        print("selected: \(selectedImg)")
        self.myDic = selectedImg
    }
    
    
}

extension PhotoViewController: CropViewControllerDelegate {
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
