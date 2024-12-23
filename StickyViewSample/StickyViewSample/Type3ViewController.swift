//
//  Type3ViewController.swift
//  StickyViewSample
//
//  Created by hanwe on 2021/04/23.
//

import UIKit

class Type3ViewController: UIViewController {

    @IBOutlet var mainContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    
    var originHeaderViewHeightConstraint: CGFloat = 0
    var originImgViewWidthConstraint: CGFloat = 0
    var originImgViewHeightConstraint: CGFloat = 0
    
    var isClearNavigationState: Bool = false {
        didSet {
            if oldValue != self.isClearNavigationState {
                if self.isClearNavigationState {
                    clearNavigationBar()
                }
                else {
                    nonClearNavigationBar()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.originHeaderViewHeightConstraint = self.headerViewHeightConstraint.constant
        self.tableView.contentInset.top = self.originHeaderViewHeightConstraint
        self.headerView.isUserInteractionEnabled = false
        self.originImgViewWidthConstraint = self.imgViewWidthConstraint.constant
        self.originImgViewHeightConstraint = self.imgViewHeightConstraint.constant
//        self.headerView.clipsToBounds = true
    }
    
    func clearNavigationBar() {
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = .clear
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func nonClearNavigationBar() {
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = .yellow
        self.navigationController?.navigationBar.topItem?.title = "asd"
    }

}

extension Type3ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        if indexPath.row%2 == 0 {
            cell.backgroundColor = .brown
        }
        else {
            cell.backgroundColor = .gray
        }
        if indexPath.row == 0 {
            cell.backgroundColor = .purple
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y + self.originHeaderViewHeightConstraint
        print("yOffset:\(yOffset)")
        self.headerViewTopConstraint.constant = -yOffset
        var percent: CGFloat = yOffset/self.originHeaderViewHeightConstraint
        if 0 > percent {
            percent = 0
        }
        if percent > 1 {
            percent = 1
        }
        self.headerView.alpha = (1 - percent)
        
        if percent == 1 {
            print("네비게이션 부활")
            self.isClearNavigationState = false
        }
        else {
            print("네비게이션 숨김")
            self.isClearNavigationState = true
        }
        
        if 0 > yOffset {
            self.imgViewWidthConstraint.constant = originImgViewWidthConstraint + abs(yOffset)
            self.imgViewHeightConstraint.constant = originImgViewHeightConstraint + abs(yOffset)
        }
        
    }
    
    
}
