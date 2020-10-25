//
//  HWCollectionView.swift
//  HWCollectionViewTest
//
//  Created by hanwe lee on 2020/10/16.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SkeletonView
import SnapKit

@objc protocol HWCollectionViewDelegate: class {
    
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    @objc optional func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    @objc optional func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    @objc optional func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    @objc optional func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    @objc optional func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool
    @objc optional func scrollViewDidScrollToTop(_ scrollView: UIScrollView)
    
    @objc optional func callNextPage(_ scrollView:UIScrollView)
}

@objc protocol HWCollectionViewDatasource: class {
//    func hwTableView(_ hwTableView: HWTableView, numberOfRowsInSection section: Int) -> Int
    func hwCollectionView(_ collectionView: HWCollectionView, numberOfItemsInSection section: Int) -> Int
    func hwCollectionView(_ collectionView: HWCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

//@objc protocol HWCollectionViewDelegateFlowLayout:class {
//    func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//}

@objc protocol HWCollectionViewDelegateFlowLayout: HWCollectionViewDelegate {
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
}

class HWCollectionView: UIView {
    
    //MARK: public property
    
    public weak var delegate: HWCollectionViewDelegate?
    public weak var dataSource: HWCollectionViewDatasource?
    
    public lazy var collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewLayout())
    
    public var callNextPageBeforeOffset: CGFloat = 150
    
    public var minimumSkeletonSecond: CGFloat = 0.5
    public var collectionViewLayout: UICollectionViewLayout = UICollectionViewLayout() {
        didSet {
            self.collectionView.collectionViewLayout = self.collectionViewLayout
        }
    }
    public var showsHorizontalScrollIndicator:Bool = true {
        didSet {
            self.collectionView.showsHorizontalScrollIndicator = self.showsHorizontalScrollIndicator
        }
    }
    public var showsVerticalScrollIndicator:Bool = true {
        didSet {
            self.collectionView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator
        }
    }
    
    //MARK: private property
    private var isShowDisplayAnimation:Bool = true
    private var isShowingSkeletonView:Bool = false
    private var isOverMinimumSkeletionTimer:Bool = true
    private let defaultCellHeight:CGFloat = 100
    private var numberOfItems:UInt = 0
    private var noResultView:UIView?
    private var minimumSkeletionTimer: Timer?
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: private func
    
    private func initUI() {
        self.collectionView.backgroundColor = .clear
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
            make.leading.equalTo(self.snp.leading).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.isSkeletonable = true
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
//    private func getSkeletonCellBestCount(cellHeight:CGFloat) -> Int {
//        var result:Int = 0
//        result = Int(self.bounds.height/cellHeight)
//        if self.bounds.height.truncatingRemainder(dividingBy: cellHeight) != 0 {
//            result += 1
//        }
//        return result
//    }
    
    @objc private func minimumSkeletionTimerCallback() {
        self.isOverMinimumSkeletionTimer = true
    }
    
    //MARK: public func
    public func showSkeletonHW() {
        self.isOverMinimumSkeletionTimer = false
        DispatchQueue.main.async { [weak self] in
            if self?.minimumSkeletionTimer?.isValid ?? false {
                self?.minimumSkeletionTimer?.invalidate()
            }
            self?.minimumSkeletionTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self!.minimumSkeletonSecond), target: self!, selector: #selector(self!.minimumSkeletionTimerCallback), userInfo: nil, repeats: false)
            self?.isShowDisplayAnimation = false
            self?.collectionView.isSkeletonable = true
            self?.showAnimatedGradientSkeleton()
            self?.startSkeletonAnimation()
            self?.isShowingSkeletonView = true
        }
        
    }

    public func hideSkeletonHW() {
        if self.isOverMinimumSkeletionTimer {
            DispatchQueue.main.async { [weak self] in
                self?.stopSkeletonAnimation()
                self?.hideSkeleton()
                self?.collectionView.reloadData() //리로드를 안해주면 데이터가 이상하게 set된다 ㅡㅡ; skeletonview 버그인듯
                self?.isShowingSkeletonView = false
                self?.isShowDisplayAnimation = true
            }
        }
        else {
            DispatchQueue.global(qos: .default).async { [weak self] in
                usleep(3 * 100 * 1000)
                DispatchQueue.main.async { [weak self] in
                    self?.hideSkeletonHW()
                }
            }
        }
    }
    
    public func addNoResultView(_ view:UIView) {
        self.noResultView = view
        guard let subView = self.noResultView else { return }
        self.addSubview(subView)
        subView.superview?.bringSubviewToFront(subView)
        subView.snp.makeConstraints{ (make) in
            make.leading.equalTo(self.snp.leading).offset(0)
            make.trailing.equalTo(self.snp.trailing).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        subView.isHidden = true
    }
    
    public func removeNoResultView() {
        self.noResultView = nil
    }
    
    public func showNoResultView(completion:(() -> ())?) {
        DispatchQueue.main.async { [weak self] in
            self?.noResultView?.isHidden = false
            self?.isShowDisplayAnimation = true
            completion?()
        }
    }
    
    public func hideNoResultView(completion:(() -> ())?) {
        DispatchQueue.main.async { [weak self] in
            self?.noResultView?.isHidden = true
            self?.isShowDisplayAnimation = true
            completion?()
        }
    }
    
    //MARK: public func for tableView
    
    public func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        self.collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func reloadData() {
        self.collectionView.reloadData()
    }
    
    public func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return self.collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }

}

extension HWCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let ds = self.dataSource  else { return 0 }
        self.numberOfItems = UInt(ds.hwCollectionView(self, numberOfItemsInSection: section))
        return Int(self.numberOfItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.dataSource!.hwCollectionView(self, cellForItemAt: indexPath)
    }
    
}

extension HWCollectionView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewDidScroll?(scrollView)
        
        let offset = scrollView.contentOffset;
        let bounds = scrollView.bounds;
        let size = scrollView.contentSize;
        let inset = scrollView.contentInset;
        let y = offset.y + bounds.size.height - inset.bottom;
        let h = size.height;
        if y + self.callNextPageBeforeOffset >= h {
            self.delegate?.callNextPage?(scrollView)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.delegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return self.delegate?.scrollViewShouldScrollToTop?(scrollView) ?? false
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewDidScrollToTop?(scrollView)
    }
}

extension HWCollectionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return self.delegate?.hwCollectionView?(self, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize(width: 0, height: 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let edgeInsets:UIEdgeInsets = .init(top: 0,
//                                            left: self.issuerCollectionViewLeftRightMargin,
//                                            bottom: 0,
//                                            right: self.issuerCollectionViewLeftRightMargin)
//        return edgeInsets
//    }
}
