//
//  ViewController.swift
//  QRSample
//
//  Created by hanwe lee on 2020/11/03.
//

import UIKit
import QRCode

class ViewController: UIViewController {
    
    @IBOutlet weak var myImgView: UIImageView!
    let anyString: String = "123123123"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let qrCode = QRCode(self.anyString)
        if let img = qrCode?.image {
            self.myImgView.image = img
        }
        else {
            
        }
        
    }


}

