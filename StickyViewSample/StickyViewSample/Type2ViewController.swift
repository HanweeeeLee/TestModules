//
//  Type1ViewController.swift
//  StickyViewSample
//
//  Created by hanwe lee on 2021/04/23.
//

import UIKit

class Type2ViewController: UIViewController {

    @IBOutlet weak var stickyHeaderView: UIView!
    @IBOutlet weak var stickyHeaderViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stickyHeaderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var originStickyHeaderHeightConstraint: CGFloat = 0
    var originStickyHeaderTopConstraint: CGFloat = 0
    var originTableViewTopConstraint: CGFloat = 0
    
    var beginDraggingYOffset: CGFloat = 0
    
    /* 이 동작은 조금 고도화하면서 넣어도 될듯
    
    public let willShowOverAccumulateYOffset: CGFloat = 10 // offset 얼마 이상 누적되면 로직이 동작하기 시작
    private var currentAccumulateWillShowYOffset: CGFloat = 0 { // 현재 누적됨
        didSet {
            if self.currentAccumulateWillShowYOffset > self.willShowOverAccumulateYOffset {
                self.isReadyStickyLogic = true
                
            }
            else {
                self.isReadyStickyLogic = false
            }
        }
    }
    private var isReadyStickyLogic: Bool = false // 로직 동작하게 할것??
 */
    
    var isShownStickyView: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.originStickyHeaderHeightConstraint = self.stickyHeaderViewHeightConstraint.constant
        self.originStickyHeaderTopConstraint = self.stickyHeaderTopConstraint.constant
        self.originTableViewTopConstraint = self.tableViewTopConstraint.constant
        self.tableViewTopConstraint.constant = self.originStickyHeaderHeightConstraint
    }
    
    func stickyHeaderViewShowPercent(_ inputPercent: CGFloat) {
        defer {
            UIView.animate(withDuration: 0.1, animations: {
                self.view.layoutIfNeeded()
            })
        }
        print("inputPercent:\(inputPercent)")
        var percent = inputPercent
        if 0 >= percent {
            print("log1")
            percent = 0
        }
        if percent >= 1 {
            print("log2")
            percent = 1
        }
        
        self.stickyHeaderView.alpha = (1 - percent)
        self.stickyHeaderTopConstraint.constant = -( percent * originStickyHeaderHeightConstraint)
        self.tableViewTopConstraint.constant = ((1 - percent) * originStickyHeaderHeightConstraint)
        
        if percent == 0 {
            self.isShownStickyView = true
        }
        else if percent == 1 {
            self.isShownStickyView = false
        }
        
    }

}

extension Type2ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        if indexPath.row%2 == 0 {
            cell.backgroundColor = .darkGray
        }
        else {
            cell.backgroundColor = .lightGray
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset: CGFloat = scrollView.contentOffset.y
        var percent: CGFloat = 0
        
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)

        

//        print("드레그 시작부터 offset이 \(yOffset - self.beginDraggingYOffset) 만큼 이동")
        let movedYOffset: CGFloat = yOffset - self.beginDraggingYOffset
        if movedYOffset > originStickyHeaderHeightConstraint {
            percent = 1
        }
        else {
            percent = CGFloat(movedYOffset / self.originStickyHeaderHeightConstraint)
        }
        
        if actualPosition.y > 0 {
//            print("up")
            if !self.isShownStickyView {
                stickyHeaderViewShowPercent(1 + percent)
            }
        } else {
//            print("down")
            if self.isShownStickyView {
                stickyHeaderViewShowPercent(percent)
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("start dragging")
        self.beginDraggingYOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("end dragging")
        print("moved: \(scrollView.contentOffset.y - self.beginDraggingYOffset)")
        let moved: CGFloat = scrollView.contentOffset.y - self.beginDraggingYOffset
        if 0 > moved {
            if abs(moved) > originStickyHeaderHeightConstraint/2 {
                print("얍")
                stickyHeaderViewShowPercent(0)
            }
            else {
                print("얍..")
                stickyHeaderViewShowPercent(1)
            }
        }
        else {
            if moved > originStickyHeaderHeightConstraint/2 {
                print("얍")
                stickyHeaderViewShowPercent(1)
            }
            else {
                print("얍..")
                stickyHeaderViewShowPercent(0)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("end decelerating")
    }
    
}

