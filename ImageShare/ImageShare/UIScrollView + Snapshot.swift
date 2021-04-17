//
//  ScrollView + Snapshot.swift
//  ScreenToImage
//
//  Created by hanwe lee on 2021/04/14.
//

import UIKit

extension UIScrollView {
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.contentSize, false, UIScreen.main.scale)
        let savedContentOffset = self.contentOffset
        let savedFrame = self.frame
        let savedBackgroundColor = self.backgroundColor
        self.contentOffset = .zero
        self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
        self.backgroundColor = .clear

        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height))

        let tempSuperView = self.superview
        self.removeFromSuperview()
        tempView.addSubview(self)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tempView.layer.render(in: context)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }

        tempView.subviews[0].removeFromSuperview()
        if let superView = tempSuperView { // 일단 사이즈에 딱 맞는경우만 생각해놓음.. 만약 필요하면 그때 수정하는걸로..
            superView.addSubview(self)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
            let constraint1 = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                                                 toItem: superView, attribute: .leading,
                                                 multiplier: 1.0, constant: 0)
            
            let constraint2 = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                                                 toItem: superView, attribute: .trailing,
                                                 multiplier: 1.0, constant: 0)
            
            let constraint3 = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                                                 toItem: superView, attribute: .top,
                                                 multiplier: 1.0, constant: 0)
            
            let constraint4 = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                                                 toItem: superView, attribute: .bottom,
                                                 multiplier: 1.0, constant: 0)
            
            superView.addConstraints([constraint1, constraint2, constraint3, constraint4])
        }
        
        self.contentOffset = savedContentOffset
        self.frame = savedFrame
        self.backgroundColor = savedBackgroundColor

        UIGraphicsEndImageContext()
        
        return image
    }
}
