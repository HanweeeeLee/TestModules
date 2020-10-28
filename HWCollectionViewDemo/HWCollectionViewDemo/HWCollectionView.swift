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
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    @objc optional func hwCollectionView( _collectionView: HWCollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?)
    @objc optional func hwCollectionViewDidEndMultipleSelectionInteraction(_ collectionView: HWCollectionView)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, didSelectItemAt indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, didDeselectItemAt indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, didHighlightItemAt indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, didUnhighlightItemAt indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, canEditItemAt indexPath: IndexPath) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, canFocusItemAt indexPath: IndexPath) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath
//    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout
    
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
    func hwCollectionViewSekeletonViewCellIdentifier(_ hwCollectionView: HWCollectionView) -> String
    
    func hwCollectionView(_ collectionView: HWCollectionView, numberOfItemsInSection section: Int) -> Int
    func hwCollectionView(_ collectionView: HWCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    @objc optional func hwCollectionView(_ collectionView: HWCollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath
}

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
    
    public weak var delegate: HWCollectionViewDelegate? {
        willSet {
            self.flowLayoutDelegate = newValue as? HWCollectionViewDelegateFlowLayout
        }
    }
    
    public weak var dataSource: HWCollectionViewDatasource?
    
    public lazy var collectionView: reloadHandlerCollectionView = reloadHandlerCollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewLayout())
    
    public var callNextPageBeforeOffset: CGFloat = 150
    
    public var minimumSkeletonSecond: CGFloat = 1.5
    
    public var collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() {
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
    private var flowLayoutDelegate:HWCollectionViewDelegateFlowLayout?
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
        self.collectionView.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.reloadCompleteHandler = { [weak self] in
            if self != nil {
                if !self!.isShowingSkeletonView && self!.isShowDisplayAnimation {
                    self!.isShowDisplayAnimation = false
                }
            }
        }
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return self.dataSource?.hwCollectionView?(self, viewForSupplementaryElementOfKind: kind, at: indexPath) ?? UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return self.dataSource?.hwCollectionView?(self, canMoveItemAt: indexPath) ?? false
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.dataSource?.hwCollectionView?(self, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        return self.dataSource?.hwCollectionView?(self, indexPathForIndexTitle: title, at: index) ?? IndexPath()
    }
    
}

extension HWCollectionView:SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return self.dataSource?.hwCollectionViewSekeletonViewCellIdentifier(self) ?? ""
    }
    
//    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
//
//    }
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
}

extension HWCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.isShowingSkeletonView && self.isShowDisplayAnimation {
            cell.transform = CGAffineTransform(translationX: 0, y: 100 * 1.0)
            cell.alpha = 0
            UIView.animate(
                withDuration: 0.5,
                delay: 0 * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
                })
        }
        self.delegate?.hwCollectionView?(self, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(_collectionView: self, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        self.delegate?.hwCollectionView?(self, willDisplayContextMenu: configuration, animator: animator)
    }
    
    func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
        self.delegate?.hwCollectionViewDidEndMultipleSelectionInteraction?(self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(self, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(self, didDeselectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(self, didHighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(self, didUnhighlightItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(self, didBeginMultipleSelectionInteractionAt: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return self.delegate?.hwCollectionView?(self, canEditItemAt: indexPath) ?? false
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return self.delegate?.hwCollectionView?(self, canFocusItemAt: indexPath) ?? false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return self.delegate?.hwCollectionView?(self, shouldSelectItemAt: indexPath) ?? true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return self.delegate?.hwCollectionView?(self, shouldDeselectItemAt: indexPath) ?? false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return self.delegate?.hwCollectionView?(self, shouldHighlightItemAt: indexPath) ?? true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return self.delegate?.hwCollectionView?(self, shouldBeginMultipleSelectionInteractionAt: indexPath) ?? false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return self.delegate?.hwCollectionView?(self, shouldUpdateFocusIn: context) ?? false
    }

    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return self.delegate?.hwCollectionView?(self, targetContentOffsetForProposedContentOffset: proposedContentOffset) ?? CGPoint(x: 0, y: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        self.delegate?.hwCollectionView?(self, willEndContextMenuInteraction: configuration, animator: animator)
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return self.delegate?.hwCollectionView?(self, previewForDismissingContextMenuWithConfiguration: configuration)
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return self.delegate?.hwCollectionView?(self, previewForHighlightingContextMenuWithConfiguration: configuration)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        self.delegate?.hwCollectionView?(self, didUpdateFocusIn: context, with: coordinator)
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        self.delegate?.hwCollectionView?(self, willPerformPreviewActionForMenuWith: configuration, animator: animator)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return self.delegate?.hwCollectionView?(self, contextMenuConfigurationForItemAt: indexPath, point: point)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return self.delegate?.hwCollectionView?(self, shouldSpringLoadItemAt: indexPath, with: context) ?? false
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(self, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        self.delegate?.hwCollectionView?(self, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return self.delegate?.hwCollectionView?(self, targetIndexPathForMoveFromItemAt: originalIndexPath, toProposedIndexPath: proposedIndexPath) ?? IndexPath()
    }
    
    //        func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
    //            return self.delegate?.hwCollectionView?(self, transitionLayoutForOldLayout: fromLayout, newLayout: toLayout)
    //        }
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.flowLayoutDelegate?.hwCollectionView?(self, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edgeInsets:UIEdgeInsets = self.flowLayoutDelegate?.hwCollectionView?(self, layout: collectionViewLayout, insetForSectionAt: section) ?? .init(top: 0, left: 0, bottom: 0, right: 0)
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.flowLayoutDelegate?.hwCollectionView?(self, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) ?? self.collectionViewLayout.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.flowLayoutDelegate?.hwCollectionView?(self, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) ?? self.collectionViewLayout.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.flowLayoutDelegate?.hwCollectionView?(self, layout: collectionViewLayout, referenceSizeForHeaderInSection: section) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.flowLayoutDelegate?.hwCollectionView?(self, layout: collectionViewLayout, referenceSizeForFooterInSection: section) ?? CGSize(width: 0, height: 0)
    }
    
}

class reloadHandlerCollectionView: UICollectionView {
    //https://medium.com/@jongwonwoo/uicollectionview-reloaddata-%EA%B0%80-%EC%99%84%EB%A3%8C%EB%90%9C-%EC%8B%9C%EC%A0%90%EC%9D%84-%EC%95%8C%EC%95%84%EB%82%B4%EB%8A%94-%EC%95%88%EC%A0%84%ED%95%9C-%EB%B0%A9%EB%B2%95-fa9bac8d0a89
    var reloadCompleteHandler: (() -> ())?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let closure = self.reloadCompleteHandler {
            closure()
        }
    }
}
