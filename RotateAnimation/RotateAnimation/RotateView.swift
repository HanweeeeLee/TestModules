//
//  RotateView.swift
//  RotateAnimation
//
//  Created by hanwe on 2022/03/16.
//

import UIKit

class RotateView: UIView {
    
    // MARK: private property
    
    private let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    private var innerImageView: UIImageView = UIImageView()
    
    private lazy var innerImageViewLeadingConstraint = NSLayoutConstraint(item: innerImageView, attribute: .leading, relatedBy: .equal,
                                         toItem: self, attribute: .leading,
                                         multiplier: 1.0, constant: 0)
    private lazy var innerImageViewTraillingConstraint = NSLayoutConstraint(item: innerImageView, attribute: .trailing, relatedBy: .equal,
                                         toItem: self, attribute: .trailing,
                                         multiplier: 1.0, constant: 0)
    private lazy var innerImageViewTopConstraint = NSLayoutConstraint(item: innerImageView, attribute: .top, relatedBy: .equal,
                                         toItem: self, attribute: .top,
                                         multiplier: 1.0, constant: 0)
    private lazy var innerImageViewBottomConstraint = NSLayoutConstraint(item: innerImageView, attribute: .bottom, relatedBy: .equal,
                                         toItem: self, attribute: .bottom,
                                         multiplier: 1.0, constant: 0)
    
    // MARK: internal property
    
    @IBInspectable var image: UIImage? {
        didSet {
            guard let image = image else { return }
            self.innerImageView.image = image
        }
    }
    
    // MARK: lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: private function
    
    private func setup() {
        self.rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
        self.rotationAnimation.duration = 1
        self.rotationAnimation.isCumulative = true
        self.rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        self.backgroundColor = .clear
        self.addSubview(innerImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.innerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([self.innerImageViewLeadingConstraint,
                             self.innerImageViewTraillingConstraint,
                             self.innerImageViewTopConstraint,
                             self.innerImageViewBottomConstraint])
    }
    
    // MARK: internal function
    
    func play() {
        self.layer.add(self.rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stop() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
}
