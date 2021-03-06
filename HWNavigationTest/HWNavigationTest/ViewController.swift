//
//  ViewController.swift
//  HWNavigationTest
//
//  Created by hanwe lee on 2020/10/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myNavi: HWNavigationView!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        myNavi.addEffect(object: myView, effets: [.viewSizeIncrease(minWidth: self.widthConstraint.constant, maxWidth: self.widthConstraint.constant + 5, minHeight: self.widthConstraint.constant, maxHeight: self.widthConstraint.constant + 5),.fadeOut(minAlpha: 1, maxAlpha: 1),.replaceConstant(leading: HWNavigationView.HWNavigationFromTo(from: 10, to: 20), trailling: nil, top: HWNavigationView.HWNavigationFromTo(from: 0, to: 20), bottom: nil)])
        myNavi.addEffect(object: myLabel, effets: [.labelFontSizeIncrease(minFontSize: 10, maxFontSize: 20)])
        myNavi.addNavigationResizableHeight(from: 100, to: 200)
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        if indexPath.row%2 == 0 {
            cell.contentView.backgroundColor = .brown
        }
        else {
            cell.contentView.backgroundColor = .darkGray
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        myNavi.scrollViewDidScroll(scrollView)
    }
    
}

