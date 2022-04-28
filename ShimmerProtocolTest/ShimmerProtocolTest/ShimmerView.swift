//
//  ShimmerView.swift
//  ShimmerProtocolTest
//
//  Created by Hanwe LEE on 2022/04/28.
//

import UIKit

class ShimmerView: UIView {
    
    // MARK: private property
    
    private var gradientLayer: CAGradientLayer?
    private var animation: CABasicAnimation?
    
    // MARK: property
    
    let gradientColor1 : CGColor = UIColor(white: 1, alpha: 0.1).cgColor
    let gradientColor2 : CGColor = UIColor(white: 1, alpha: 0.2).cgColor
    let gradientColor3 : CGColor = UIColor(white: 1, alpha: 0.3).cgColor
    let gradientColor4 : CGColor = UIColor(white: 1, alpha: 0.35).cgColor
    let gradientColor5 : CGColor = UIColor(white: 1, alpha: 0.4).cgColor
    
    // MARK: lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.animation = makeAnimation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .lightGray
        self.animation = makeAnimation()
    }
    
    // MARK: private func
    
    private func makeGradientLayer() -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 2 * self.bounds.width, height: self.bounds.height)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradientLayer.colors = [gradientColor1, gradientColor2, gradientColor3, gradientColor4, gradientColor5, gradientColor4, gradientColor3, gradientColor2, gradientColor1]
        gradientLayer.locations = [0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0]
        return gradientLayer
    }
    
    private func makeAnimation() -> CABasicAnimation {
       
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.8, -0.7, -0.6, -0.5, -0.4, -0.3, -0.2, 0.0]
        animation.toValue = [1.0, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.5
        return animation
    }
    
    // MARK: func
    
    func startAnimating() {
        guard let animation = animation else { return }
        self.gradientLayer = makeGradientLayer()
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.add(animation, forKey: animation.keyPath)
        self.layer.addSublayer(gradientLayer)
    }
    
    func stopAnimating() {
        DispatchQueue.main.async { [weak self] in
            self?.gradientLayer?.removeAllAnimations()
            self?.gradientLayer?.removeFromSuperlayer()
            self?.gradientLayer = nil
        }
    }

}
