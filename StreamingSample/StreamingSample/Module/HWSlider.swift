//
//  colorsSliderView.swift
//  ColorPalette
//
//  Created by hanwe on 02/07/2019.
//  Copyright © 2019 hanwe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

@objc protocol HWSliderViewDelegate: AnyObject {
    @objc optional func draged(hwSliderView: HWSliderView, index: CGFloat)
}

class HWSliderView: UIView {
    
    // MARK: UI property
    
    private let sliderProgressView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    private lazy var sliderHandleView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 2.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        $0.layer.shadowColor = UIColor(red:0.09, green:0.11, blue:0.15, alpha:0.05).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 2.0
        $0.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action:  #selector(handleDrag(_:)))
        $0.addGestureRecognizer(panGesture)
    }
    
    // MARK: private var
    
    // MARK: internal
    
    var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
            self.setNeedsLayout()
        }
    }
    
    var bordorColor: UIColor = .black {
        didSet {
            self.layer.borderColor = self.bordorColor.cgColor
            self.setNeedsLayout()
        }
    }
    
    var topIntervalBarToHandle: CGFloat = 7 {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    var bottomIntervalBarToHandle:CGFloat = 7 {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    var sliderHandleWidth: CGFloat = 20
    
    weak var delegate: HWSliderViewDelegate?
    
    var emptySpaceSliderHandle: CGFloat = 0
    var emptySpaceSliderView: CGFloat = 0

    
    
    //MARK: life cycle
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: func
    
    func setup() {
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.sliderProgressView.layer.masksToBounds = false
        self.sliderProgressView.clipsToBounds = true
        self.sliderHandleView.layer.masksToBounds = false
        self.sliderHandleView.clipsToBounds = true
        self.backgroundColor = .clear
        
        self.addSubview(self.sliderProgressView)
        self.sliderProgressView.snp.makeConstraints {
            $0.width.equalTo(self).offset(-(2 * emptySpaceSliderView))
            $0.height.equalTo(5)
            $0.center.equalTo(self)
        }
        
        self.sliderProgressView.layer.borderWidth = self.borderWidth
        self.sliderProgressView.layer.borderColor = self.bordorColor.cgColor

        self.sliderProgressView.layer.shadowColor = UIColor.black.cgColor
        self.sliderProgressView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.sliderProgressView.layer.shadowRadius = 1
        self.sliderProgressView.layer.shadowOpacity = 0.5
        self.sliderProgressView.layer.cornerRadius = self.sliderProgressView.frame.height/2
        self.sliderProgressView.layer.masksToBounds = false
        
        self.addSubview(sliderHandleView)
        self.sliderHandleView.snp.makeConstraints {
            $0.width.equalTo(self.sliderHandleWidth)
            $0.height.equalTo(self)
            $0.leading.equalTo(self.sliderProgressView)
            $0.centerY.equalTo(self.sliderHandleView)
        }
    }
    
    public func setSliderHandleViewPoint(_ xPoint: CGFloat) { // 0~1
        let maxXPoint:CGFloat = self.sliderProgressView.frame.width - self.sliderHandleView.frame.width + (2 * self.emptySpaceSliderHandle)
        self.sliderHandleView.frame = CGRect(x: (xPoint * maxXPoint) - self.emptySpaceSliderHandle + self.emptySpaceSliderView, y: 0, width: self.sliderHandleWidth, height: self.frame.height)
        delegate?.draged?(hwSliderView: self, index: xPoint)
        self.setNeedsLayout()
    }
    
    //MARK: action
    
    @objc func handleDrag(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: self.sliderHandleView)
        var changeX = self.sliderHandleView.center.x + transition.x
        
        if changeX < self.sliderHandleWidth/2 - self.emptySpaceSliderHandle + self.emptySpaceSliderView {
            changeX = self.sliderHandleWidth/2 - self.emptySpaceSliderHandle + self.emptySpaceSliderView
        }
        else if changeX > (self.sliderProgressView.frame.width - self.sliderHandleWidth/2) + self.emptySpaceSliderHandle + self.emptySpaceSliderView {
            changeX = (self.sliderProgressView.frame.width - self.sliderHandleWidth/2) + self.emptySpaceSliderHandle + self.emptySpaceSliderView
        }
        self.sliderHandleView.center = CGPoint(x: changeX, y: self.sliderHandleView.center.y)
        sender.setTranslation(CGPoint.zero, in: self.sliderHandleView)
        let maxXPoint:CGFloat = self.sliderProgressView.frame.width - self.sliderHandleView.frame.width + (2 * self.emptySpaceSliderHandle)
        let movePoint = (self.sliderHandleView.frame.minX + self.emptySpaceSliderHandle - self.emptySpaceSliderView)/maxXPoint
        
        delegate?.draged?(hwSliderView: self, index: movePoint)
        
    }

}

class HWSliderViewDelegateProxy: DelegateProxy<HWSliderView, HWSliderViewDelegate>, DelegateProxyType, HWSliderViewDelegate {
    
    
    static func currentDelegate(for object: HWSliderView) -> HWSliderViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: HWSliderViewDelegate?, to object: HWSliderView) {
        object.delegate = delegate
    }
    
    static func registerKnownImplementations() {
        self.register { (view) -> HWSliderViewDelegateProxy in
            HWSliderViewDelegateProxy(parentObject: view, delegateProxy: self)
        }
    }
}

extension Reactive where Base: HWSliderView {
    var delegate: DelegateProxy<HWSliderView, HWSliderViewDelegate> {
        return HWSliderViewDelegateProxy.proxy(for: self.base)
    }
    
    var didSelectedDate: Observable<CGFloat> {
        return delegate.methodInvoked(#selector(HWSliderViewDelegate.draged(hwSliderView:index:)))
            .map { result in
                return result[1] as? CGFloat ?? 0
            }
    }
}
