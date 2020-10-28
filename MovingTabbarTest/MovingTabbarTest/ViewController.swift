//
//  ViewController.swift
//  MovingTabbarTest
//
//  Created by hanwe lee on 2020/10/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var movingViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var movingViewHeight: NSLayoutConstraint!
    
    var bottomPadding:CGFloat = 0
    var originMovingViewBottomConstraint:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if #available(iOS 11.0, *) {
            self.bottomPadding = view.safeAreaInsets.bottom
        }
        self.originMovingViewBottomConstraint = self.movingViewBottomConstraint.constant
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 0 {
            self.movingViewBottomConstraint.constant = self.originMovingViewBottomConstraint
        } else {
            self.movingViewBottomConstraint.constant = -( movingViewHeight.constant + movingViewBottomConstraint.constant)
        }
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.movingViewBottomConstraint.constant = self.originMovingViewBottomConstraint
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
}

