//
//  ViewController.swift
//  ScreenToVideo
//
//  Created by hanwe lee on 2021/04/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = RenderSettings(size: CGSize(width: 300, height: 300))
        let imageAnimator = ImageAnimator(renderSettings: settings)
        imageAnimator.images = [UIImage(named: "cat")!]
        imageAnimator.render() {
            print("yes")
        }
    }


}

