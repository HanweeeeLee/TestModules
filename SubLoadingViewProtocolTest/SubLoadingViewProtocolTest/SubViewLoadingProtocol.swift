//
//  SubViewLoadingProtocol.swift
//  SubLoadingViewProtocolTest
//
//  Created by hanwe lee on 2021/03/09.
//

import UIKit

protocol SubViewLoadingProtocol {
    
    var subViewLoadingView: UIImageView { get set }
    var subViewLoadingViewSize: CGSize { get set }
    var minimumLoadingTime: TimeInterval { get set }
    var subViewLoadingViewBackgroundViewColor: UIColor { get set }
 
    func showSubLoadingView(view: UIView, fadeInDuration: TimeInterval, completion: (() -> ())?)
    func hideSubLoadingView(view: UIView, fadeOutDuration: TimeInterval, completion: (() -> ())?)
}

extension SubViewLoadingProtocol {
    
    func showSubLoadingView(view: UIView, fadeInDuration: TimeInterval, completion: (() -> ())?) {
        let containerView: SubLoadingContainerView = SubLoadingContainerView()
        containerView.loadingViewSize = self.subViewLoadingViewSize
        containerView.imageView = self.subViewLoadingView
        containerView.makeLoadingView()
        containerView.backgroundColor = self.subViewLoadingViewBackgroundViewColor
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint1 = NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal,
                                             toItem: view, attribute: .leading,
                                             multiplier: 1.0, constant: 0)
        
        let constraint2 = NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal,
                                             toItem: view, attribute: .trailing,
                                             multiplier: 1.0, constant: 0)
        
        let constraint3 = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal,
                                             toItem: view, attribute: .top,
                                             multiplier: 1.0, constant: 0)
        
        let constraint4 = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal,
                                             toItem: view, attribute: .bottom,
                                             multiplier: 1.0, constant: 0)
        view.addConstraints([constraint1,constraint2,constraint3,constraint4])
        
        containerView.showLoading(fadeInDuration: fadeInDuration, completion: completion)
    }
    
    func hideSubLoadingView(view: UIView, fadeOutDuration: TimeInterval, completion: (() -> ())?) {
        let subViews = view.subviews.filter{
            return $0 is SubLoadingContainerView
        }
        for i in 0..<subViews.count {
            (subViews[i] as? SubLoadingContainerView)?.hideLoading(fadeOutDuration: fadeOutDuration ,completion: {
                subViews[i].removeFromSuperview()
                completion?()
            })
        }
    }
    
}


fileprivate class SubLoadingContainerView: UIView {
    
    var imageView: UIImageView? = nil
    var loadingViewSize: CGSize? = nil
    
    func showLoading(fadeInDuration: TimeInterval = 0.0, completion: (() -> ())?) {
        fadeIn(duration: fadeInDuration, completion: {
            self.imageView?.startAnimating()
            completion?()
        })
    }
    
    func hideLoading(fadeOutDuration: TimeInterval = 0.0, completion: (() -> ())?) {
        self.imageView?.stopAnimating()
        fadeOut(duration: fadeOutDuration, completion: {
            completion?()
        })
    }
    
    func makeLoadingView() {
        guard let loadingView = self.imageView else {
            print("imageView is not exsit")
            return
        }
        guard let size = self.loadingViewSize else {
            print("loadingViewSize is not exsit")
            return
        }
        self.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let loadingViewConstraint1 = NSLayoutConstraint(item: loadingView, attribute: .centerX, relatedBy: .equal,
                                                        toItem: self, attribute: .centerX,
                                                        multiplier: 1.0, constant: 0)
        let loadingViewConstraint2 = NSLayoutConstraint(item: loadingView, attribute: .centerY, relatedBy: .equal,
                                                        toItem: self, attribute: .centerY,
                                                        multiplier: 1.0, constant: 0)
        let loadingViewConstraint3 = loadingView.widthAnchor.constraint(equalToConstant: size.width)
        let loadingViewConstraint4 = loadingView.heightAnchor.constraint(equalToConstant: size.height)
        self.addConstraints([loadingViewConstraint1,loadingViewConstraint2,loadingViewConstraint3,loadingViewConstraint4])
    }
    
    fileprivate func fadeIn(duration: TimeInterval, completion: @escaping () -> ()) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: { (finished: Bool) -> Void in
            self.imageView?.startAnimating()
            completion()
        })
    }
    
    fileprivate func fadeOut(duration: TimeInterval, completion: @escaping () -> ()) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { (finished: Bool) -> Void in
            completion()
        })
    }
}
