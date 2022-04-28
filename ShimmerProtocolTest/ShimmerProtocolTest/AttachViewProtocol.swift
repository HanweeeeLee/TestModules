//
//  ShimmerViewProtocol.swift
//  ShimmerProtocolTest
//
//  Created by Hanwe LEE on 2022/04/26.
//

import Foundation
import UIKit

protocol AttachViewProtocol: AnyObject {
    var targetView: UIView? { get set }
    var attachedView: UIView? { get set }
    
    func showAttachView(fadeInDuration: TimeInterval, completion: (() -> ())?)
    func hideAttachView(fadeOutDuration: TimeInterval, completion: (() -> ())?)
}

extension AttachViewProtocol {
    func showAttachView(fadeInDuration: TimeInterval = 0.0, completion: (() -> ())?) {
        guard let attached = self.attachedView else { print("attachedView is null") ; return }
        guard let target = self.targetView else { print("targetView is null") ; return }
        target.addSubview(attached)
        attached.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint1 = NSLayoutConstraint(item: attached, attribute: .leading, relatedBy: .equal,
                                                toItem: target, attribute: .leading,
                                                multiplier: 1.0, constant: 0)
        
        let constraint2 = NSLayoutConstraint(item: attached, attribute: .trailing, relatedBy: .equal,
                                                toItem: target, attribute: .trailing,
                                                multiplier: 1.0, constant: 0)
        
        let constraint3 = NSLayoutConstraint(item: attached, attribute: .top, relatedBy: .equal,
                                                toItem: target, attribute: .top,
                                                multiplier: 1.0, constant: 0)
        
        let constraint4 = NSLayoutConstraint(item: attached, attribute: .bottom, relatedBy: .equal,
                                                toItem: target, attribute: .bottom,
                                                multiplier: 1.0, constant: 0)
        
        target.addConstraints([constraint1, constraint2, constraint3, constraint4])
        
        fadeIn(duration: fadeInDuration, completion: {
            completion?()
        })
    }
    func hideAttachView(fadeOutDuration: TimeInterval = 0.0, completion: (() -> ())?) {
        guard let attached = self.attachedView else { print("attachedView is null") ; return }
        guard let _ = self.targetView else { print("targetView is null") ; return }
        
        fadeOut(duration: fadeOutDuration, completion: {
            attached.removeFromSuperview()
            completion?()
        })
    }
    
    fileprivate func fadeIn(duration: TimeInterval, completion: @escaping () -> ()) {
        self.attachedView?.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.attachedView?.alpha = 1.0
        }, completion: { (finished: Bool) -> Void in
            completion()
        })
    }
    
    fileprivate func fadeOut(duration: TimeInterval, completion: @escaping () -> ()) {
        self.attachedView?.alpha = 1.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.attachedView?.alpha = 0.0
        }, completion: { (finished: Bool) -> Void in
            completion()
        })
    }
}
