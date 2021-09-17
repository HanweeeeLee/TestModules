//
//  TestViewController1.swift
//  PanModalSample
//
//  Created by hanwe on 2021/09/17.
//

import UIKit
import PanModal

class TestViewController1: UIViewController, PanModalPresentable {
    @IBOutlet weak var tableView: UITableView!
    
    var panScrollable: UIScrollView? {
        return self.tableView
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(40)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
    
}


extension TestViewController1: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
