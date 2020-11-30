//
//  ViewController.swift
//  SwiftGenImageTest
//
//  Created by hanwe lee on 2020/11/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView1.image = ImageAsset(name: "Sample").image
        imgView2.image = Imgs.sample.image
    }


}

