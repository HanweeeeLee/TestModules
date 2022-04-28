//
//  MyShimmerView.swift
//  ShimmerProtocolTest
//
//  Created by Hanwe LEE on 2022/04/28.
//

import UIKit
import SnapKit

class MyShimmerView: UIView {
    
    lazy var box1: ShimmerView = {
        let view: ShimmerView = ShimmerView()
        return view
    }()
    
    lazy var box2: ShimmerView = {
        let view: ShimmerView = ShimmerView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        self.addSubview(box1)
        box1.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
        self.addSubview(box2)
        box2.snp.makeConstraints {
            $0.top.equalTo(self.box1.snp.bottom).offset(10)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
    }
    
    func startAnimation() {
        self.box1.startAnimating()
        self.box2.startAnimating()
    }
    
    func stopAnimation() {
        self.box1.stopAnimating()
        self.box2.stopAnimating()
    }

}
