//
//  MyTableView.swift
//  TableViewOverride
//
//  Created by hanwe lee on 2020/09/15.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SkeletonView

class HWTableView: UITableView {
    var obj:HWTableViewDelegate = HWTableViewDelegate()
    override var delegate: UITableViewDelegate? {
        didSet {
            if delegate !== self.obj {
                self.obj.originDelegate = self.delegate
            }
        }
    }
    
    override var dataSource: UITableViewDataSource? {
        didSet {
            if dataSource !== self.obj {
                self.obj.originDataSource = self.dataSource
            }
        }
    }
    
    func showSkeletonViewAndInit() {
        self.isSkeletonable = true
        self.obj.tableView = self
        self.delegate = self.obj.originDelegate
        self.dataSource = self.obj.originDataSource
        self.showAnimatedGradientSkeleton()
        self.startSkeletonAnimation()
        self.obj.isShowDisplayAnimation = true
        self.obj.isShownFirstHWTableViewDisplay = false
    }
    
    func hideSkeletonViewAndConnectMyCustomProtocol() {
        self.stopSkeletonAnimation()
        self.hideSkeleton()
        self.delegate = self.obj
        self.dataSource = self.obj
    }
    
//    override func reloadData() {
//        super.reloadData()
//    }
    
}

class HWTableViewDelegate:NSObject {
    weak var originDelegate:UITableViewDelegate? = nil
    weak var originDataSource:UITableViewDataSource? = nil
    weak var tableView:UITableView? = nil
    
    let defaultCellHeight:CGFloat = 100
    
    var isShowDisplayAnimation:Bool = false
    var isShownFirstHWTableViewDisplay:Bool = false
}

extension HWTableViewDelegate:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.originDataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.originDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
//        cell.stopSkeletonAnimation()
//        cell.hideSkeleton() 이거 호출하면 셀이 이상하게 호출됨 흠....
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.originDataSource?.numberOfSections?(in: tableView) ?? 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.originDataSource?.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.originDataSource?.tableView?(tableView, canEditRowAt: indexPath) ?? false
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.originDataSource?.tableView?(tableView, canMoveRowAt: indexPath) ?? falseå
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.originDataSource?.tableView?(tableView, titleForFooterInSection: section) ?? nil
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.originDataSource?.tableView?(tableView, titleForHeaderInSection: section) ?? nil
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return self.originDataSource?.tableView?(tableView, sectionForSectionIndexTitle: title, at: index) ?? 0
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.originDataSource?.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
    
}

extension HWTableViewDelegate:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.isShownFirstHWTableViewDisplay = true
        if isShowDisplayAnimation {
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
        self.originDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isShownFirstHWTableViewDisplay {
            if self.isShowDisplayAnimation {
                self.isShowDisplayAnimation = false
            }
        }
        self.originDelegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.originDelegate?.tableView?(tableView, didSelectRowAt:indexPath)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.originDelegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.originDelegate?.tableView?(tableView, didHighlightRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        self.originDelegate?.tableView?(tableView, didEndEditingRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        self.originDelegate?.tableView?(tableView, didUnhighlightRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return self.originDelegate?.tableView?(tableView, canFocusRowAt: indexPath) ?? false
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        self.originDelegate?.tableView?(tableView, willBeginEditingRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.originDelegate?.tableView?(tableView, heightForRowAt: indexPath) ?? self.defaultCellHeight
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.originDelegate?.tableView?(tableView, viewForFooterInSection: section) ?? nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.originDelegate?.tableView?(tableView, viewForHeaderInSection: section) ?? nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.originDelegate?.tableView?(tableView, heightForFooterInSection: section) ?? 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.originDelegate?.tableView?(tableView, heightForHeaderInSection: section) ?? 0
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return self.originDelegate?.tableView?(tableView, shouldHighlightRowAt: indexPath) ?? false
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return self.originDelegate?.tableView?(tableView, willSelectRowAt: indexPath) ?? nil
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.originDelegate?.tableView?(tableView, accessoryButtonTappedForRowWith: indexPath)
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return self.originDelegate?.tableView?(tableView, shouldIndentWhileEditingRowAt: indexPath) ?? false
    }
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return self.originDelegate?.tableView?(tableView, indentationLevelForRowAt: indexPath) ?? 0
    }
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return self.originDelegate?.tableView?(tableView, willDeselectRowAt: indexPath) ?? nil
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.originDelegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) ?? 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return self.originDelegate?.tableView?(tableView, estimatedHeightForFooterInSection: section) ?? 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return self.originDelegate?.tableView?(tableView, estimatedHeightForHeaderInSection: section) ?? 0
    }
    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        self.originDelegate?.tableView?(tableView, didBeginMultipleSelectionInteractionAt: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        self.originDelegate?.tableView?(tableView, willDisplayFooterView: view, forSection: section)
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        self.originDelegate?.tableView?(tableView, willDisplayHeaderView: view, forSection: section)
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return self.originDelegate?.tableView?(tableView, editingStyleForRowAt: indexPath) ?? UITableViewCell.EditingStyle.none
    }
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        self.originDelegate?.tableView?(tableView, didEndDisplayingFooterView: view, forSection: section)
    }
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        self.originDelegate?.tableView?(tableView, didEndDisplayingHeaderView: view, forSection: section)
    }
    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return self.originDelegate?.tableView?(tableView, shouldUpdateFocusIn: context) ?? false
    }
    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return self.originDelegate?.tableView?(tableView, shouldBeginMultipleSelectionInteractionAt: indexPath) ?? false
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return self.originDelegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath) ?? nil
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.originDelegate?.tableView?(tableView, leadingSwipeActionsConfigurationForRowAt: indexPath) ?? nil
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.originDelegate?.tableView?(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath) ?? nil
    }
    func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return self.originDelegate?.tableView?(tableView, shouldSpringLoadRowAt: indexPath, with: context) ?? false
    }
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return self.originDelegate?.tableView?(tableView, contextMenuConfigurationForRowAt: indexPath, point: point) ?? nil
    }
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        self.originDelegate?.tableView?(tableView, didUpdateFocusIn: context, with: coordinator)
    }
    func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return self.originDelegate?.tableView?(tableView, previewForDismissingContextMenuWithConfiguration: configuration) ?? nil
    }
    func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return self.originDelegate?.tableView?(tableView, previewForHighlightingContextMenuWithConfiguration: configuration) ?? nil
    }
    func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        self.originDelegate?.tableView?(tableView, willPerformPreviewActionForMenuWith: configuration, animator: animator)
    }
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return self.originDelegate?.tableView?(tableView, targetIndexPathForMoveFromRowAt: sourceIndexPath, toProposedIndexPath: proposedDestinationIndexPath) ?? IndexPath(row: 0, section: 0)
    }
    
    //MARK: scroll view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewDidScroll?(scrollView)
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewDidZoom?(scrollView)
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewDidScrollToTop?(scrollView)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return self.originDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? false
    }
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        self.originDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.originDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.originDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.originDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.originDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
