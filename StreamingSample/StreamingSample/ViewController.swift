//
//  ViewController.swift
//  StreamingSample
//
//  Created by hanwe on 2022/11/03.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    
    private let playerView = WMVideoPlayerView(url: Define.videoUrl)
    private let slider = HWSliderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.playerView)
        self.playerView.snp.makeConstraints {
            $0.width.height.equalTo(300)
            $0.center.equalTo(self.view)
        }
        self.playerView.play()
        
        
        self.view.addSubview(self.slider)
        self.slider.snp.makeConstraints {
            $0.top.equalTo(self.playerView.snp.bottom)
            $0.leading.trailing.equalTo(self.playerView)
            $0.height.equalTo(30)
        }
    }
    
}
