//
//  Type1ViewController.swift
//  StickyViewSample
//
//  Created by hanwe lee on 2021/04/23.
//

import UIKit

class Type1ViewController: UIViewController {

    @IBOutlet weak var stickyHeaderView: UIView!
    @IBOutlet weak var stickyHeaderViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stickyHeaderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var originStickyHeaderHeightConstraint: CGFloat = 0
    var originStickyHeaderTopConstraint: CGFloat = 0
    var originTableViewTopConstraint: CGFloat = 0
    
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
        var percent = inputPercent
        if 0 > percent {
            print("log1")
            percent = 0
        }
        if percent > 1 {
            print("log2")
            percent = 1
        }
        
        self.stickyHeaderView.alpha = (1 - percent)
        self.stickyHeaderTopConstraint.constant = -( percent * originStickyHeaderHeightConstraint)
        self.tableViewTopConstraint.constant = ((1 - percent) * originStickyHeaderHeightConstraint)
    }

}

extension Type1ViewController: UITableViewDataSource, UITableViewDelegate {
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
//        print("scrollViewOffset: \(scrollView.contentOffset.y)")
//        print("비교 :\(originStickyHeaderHeightConstraint)")
        let myOffset: CGFloat = scrollView.contentOffset.y < 0 ? 0 : scrollView.contentOffset.y
//        print("my Offset: \(myOffset)")
        var percent: CGFloat = 0
        if myOffset > originStickyHeaderHeightConstraint {
            percent = 1
        }
        else {
            percent = CGFloat(myOffset / self.originStickyHeaderHeightConstraint)
        }
        print("percent: \(percent)")
        
        
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if actualPosition.y > 0 {
            print("up")
        } else {
            print("down")
        }
        
        stickyHeaderViewShowPercent(percent)
    }
    
}

