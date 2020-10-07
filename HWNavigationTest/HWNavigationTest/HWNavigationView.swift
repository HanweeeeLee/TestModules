//
//  HWNavigationView.swift
//  HWNavigationTest
//
//  Created by hanwe lee on 2020/10/06.
//

import UIKit
import SnapKit

class HWNavigationView: UIView {
    
    struct HWNavigationEffectObject {
        weak var obj:UIView?
        var effectArray:Array = Array<HWNavigationEffectType>()
    }
    
    enum HWNavigationEffectType:Equatable {
        case fadeIn(minAlpha:CGFloat,maxAlpha:CGFloat)
        case fadeOut(minAlpha:CGFloat,maxAlpha:CGFloat)
        case viewSizeIncrease(minWidth:CGFloat,maxWidth:CGFloat,minHeight:CGFloat,maxHeight:CGFloat)
        case viewSizeDecrease(minWidth:CGFloat,maxWidth:CGFloat,minHeight:CGFloat,maxHeight:CGFloat)
        case labelFontSizeIncrease(minFontSize:CGFloat,maxFontSize:CGFloat)
        case labelFontSizeDecrease(minFontSize:CGFloat,maxFontSize:CGFloat)
        case moveUp
    }
    
    //MARK: public property
    
    public var lineView:UIView = UIView()
    public var showEffetOffset:CGFloat = 50.0
    
    
    //MARK: private property
    
    private var currentYOffset:CGFloat = 0.0 {
        didSet {
            if currentYOffset < 0 {
                if !flagOf0percent {
                    showEffects(percent: 0)
                    flagOf0percent = true
                }
            }
            else if showEffetOffset >= currentYOffset {
                //                print("percent:\((self.currentYOffset/self.showEffetOffset) * 100 )")
                let percent:CGFloat = self.currentYOffset/self.showEffetOffset
                self.lineView.alpha = self.currentYOffset/self.showEffetOffset
                self.flagOf100percent = false
                self.flagOf0percent = false
                if percent >= 0 {
                    showEffects(percent: percent)
                }
            }
            else if currentYOffset > showEffetOffset{
                //                print("100%")
                if !flagOf100percent {
                    let percent:CGFloat = 1
                    self.lineView.alpha = percent
                    self.flagOf100percent = true
                    if percent >= 0 {
                        showEffects(percent: percent)
                    }
                }
            }
        }
    }
    
    private var effectObjects:Array = Array<HWNavigationEffectObject>()
    
    private var flagOf100percent:Bool = false
    private var flagOf0percent:Bool = false
    
    private var selfResizeHeightFrom:CGFloat? = nil
    private var selfResizeHeightTo:CGFloat? = nil
    
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    override func layoutSubviews() {
        self.lineView.layer.shadowOpacity = 1
        self.lineView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.lineView.layer.shadowRadius = 1
        self.lineView.layer.shadowColor = UIColor(displayP3Red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor
    }
    
    //MARK: private func
    private func initUI() {
        self.lineView.backgroundColor = UIColor(displayP3Red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints({ make in
            make.leading.equalTo(self.snp.leading).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-1)
            make.height.equalTo(1)
        })
        self.lineView.alpha = 0
    }
    
    private func showEffects(percent:CGFloat) {
        print("percent:\(percent)")
        for i in 0..<self.effectObjects.count {
            let item:HWNavigationEffectObject = self.effectObjects[i]
            if let obj = item.obj {
                let effects:Array<HWNavigationEffectType> = item.effectArray
                for j in 0..<effects.count {
                    let effect = effects[j]
                    switch effect {
                    case .fadeIn(let minAlpha,let maxAlpha):
                        let gap:CGFloat = maxAlpha - minAlpha
                        obj.alpha = minAlpha + gap * percent
                    case .fadeOut(let minAlpha,let maxAlpha):
                        let gap:CGFloat = maxAlpha - minAlpha
                        obj.alpha = minAlpha + (1 - gap * percent)
                        break
                    case .viewSizeIncrease(let minWidth,let maxWidth, let minHeight, let maxHeight):
                        let widthHeightLayouts:Array<NSLayoutConstraint> = obj.constraints.filter({
                            $0.firstAttribute == .width || $0.firstAttribute == .height
                        })
                        let widthGap:CGFloat = maxWidth - minWidth
                        let heightGap:CGFloat = maxHeight - minHeight
                        _ = widthHeightLayouts.map {
                            if $0.firstAttribute == .width {
                                $0.constant = widthGap * percent + minWidth
                            }
                            else {
                                $0.constant = heightGap * percent + minHeight
                            }
                        }
                        break
                    case .viewSizeDecrease(let minWidth,let maxWidth, let minHeight, let maxHeight):
                        let widthHeightLayouts:Array<NSLayoutConstraint> = obj.constraints.filter({
                            $0.firstAttribute == .width || $0.firstAttribute == .height
                        })
                        let widthGap:CGFloat = maxWidth - minWidth
                        let heightGap:CGFloat = maxHeight - minHeight
                        _ = widthHeightLayouts.map {
                            if $0.firstAttribute == .width {
                                $0.constant = widthGap * (1 - percent) + minWidth
                            }
                            else {
                                $0.constant = heightGap * (1 - percent) + minHeight
                            }
                        }
                        break
                    case .labelFontSizeIncrease(let minFontSize,let maxFontSize):
                        if type(of: obj) != UILabel.self {
                            print("only use UILabel")
                            return
                        }
                        let label:UILabel = obj as! UILabel
                        let gap:CGFloat = maxFontSize - minFontSize
                        let size:CGFloat = gap * percent + minFontSize
                        label.font = UIFont(name: label.font.fontName, size: size)
                        break
                    case .labelFontSizeDecrease(let minFontSize,let maxFontSize):
                        if type(of: obj) != UILabel.self {
                            print("only use UILabel")
                            return
                        }
                        let label:UILabel = obj as! UILabel
                        let gap:CGFloat = maxFontSize - minFontSize
                        let size:CGFloat = gap * (1 - percent) + minFontSize
                        label.font = UIFont(name: label.font.fontName, size: size)
                        break
                    case .moveUp:
                        break
                    }
                }
            }
        }
        
        if let from = self.selfResizeHeightFrom, let to = self.selfResizeHeightTo {
            let heightLayouts:Array<NSLayoutConstraint> = self.constraints.filter({
                $0.firstAttribute == .height
            })
            let isIncresase:Bool = to > from
            let gap:CGFloat = isIncresase ? (to - from) : (from - to)
            _ = heightLayouts.map {
                if isIncresase {
                    $0.constant = from + (gap * percent)
                }
                else {
                    $0.constant = from - (gap * percent)
                }
            }
        }
    }
    
    //MARK: public func
    
    public func scrollViewDidScroll(_ scrollView:UIScrollView) {
        self.currentYOffset = scrollView.contentOffset.y
    }
    
    public func addEffect(object:UIView,effets:Array<HWNavigationEffectType>) {
        let obj:HWNavigationEffectObject = HWNavigationEffectObject(obj: object, effectArray: effets)
        _ = effets.filter {
            switch $0 {
            case let .fadeIn(minAlpha,_):
                object.alpha = minAlpha
                break
            case let .fadeOut(_,maxAlpha):
                object.alpha = maxAlpha
                break
            case let .viewSizeIncrease(minWidth,_,minHeight,_):
                let widthHeightLayouts:Array<NSLayoutConstraint> = object.constraints.filter({
                    $0.firstAttribute == .width || $0.firstAttribute == .height
                })
                _ = widthHeightLayouts.map {
                    if $0.firstAttribute == .width {
                        $0.constant = minWidth
                    }
                    else {
                        $0.constant = minHeight
                    }
                }
                break
            case let .viewSizeDecrease(_, maxWidth, _, maxHeight):
                let widthHeightLayouts:Array<NSLayoutConstraint> = object.constraints.filter({
                    $0.firstAttribute == .width || $0.firstAttribute == .height
                })
                _ = widthHeightLayouts.map {
                    if $0.firstAttribute == .width {
                        $0.constant = maxWidth
                    }
                    else {
                        $0.constant = maxHeight
                    }
                }
                break
            case let .labelFontSizeIncrease(minFontSize,_):
                if type(of: object) != UILabel.self {
                    print("only use UILabel")
                    break
                }
                let label:UILabel = object as! UILabel
                label.font = UIFont(name: label.font.fontName, size: minFontSize)
                break
            case let .labelFontSizeDecrease(_,maxFontSize):
                if type(of: object) != UILabel.self {
                    print("only use UILabel")
                    break
                }
                let label:UILabel = object as! UILabel
                label.font = UIFont(name: label.font.fontName, size: maxFontSize)
                break
            case .moveUp:
                break
            }
            return false
         }
        self.effectObjects.append(obj)
    }
    
    public func removeEffect(object:UIView) -> Bool {
        var result:Bool = false
        for i in 0..<self.effectObjects.count {
            if self.effectObjects[i].obj === object {
                self.effectObjects.remove(at: i)
                result = true
                break
            }
        }
        return result
    }
    
    public func addNavigationResizableHeight(from:CGFloat,to:CGFloat) {
        self.selfResizeHeightFrom = from
        self.selfResizeHeightTo = to
        let heightLayouts:Array<NSLayoutConstraint> = self.constraints.filter({
            $0.firstAttribute == .height
        })
        _ = heightLayouts.map {
            $0.constant = from
        }
    }
    
    public func removeNavigationResizableHeight() {
        self.selfResizeHeightFrom = nil
        self.selfResizeHeightTo = nil
    }

}
