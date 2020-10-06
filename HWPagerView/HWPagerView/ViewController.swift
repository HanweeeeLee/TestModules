//
//  ViewController.swift
//  HWPagerView
//
//  Created by hanwe lee on 2020/09/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pagerView: HWPagerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagerView.delegate = self
        self.pagerView.datasource = self
        self.pagerView.register(UINib(nibName: "MyPagerViewCell", bundle: nil), "MyPagerViewCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.pagerView.testFunc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.pagerView.testFunc()
    }
    
    


}

extension ViewController:HWPagerViewDatasource,HWPagerViewDelegate {
    
    func hwPagerView(_ hwPagerView: HWPagerView) -> Int {
        return 3
    }
    
    func hwPagerView(_ hwPagerView: HWPagerView, cellForItemAt itemAt: UInt) -> HWPagerViewCell {
        let cell:MyPagerViewCell = pagerView.dequeueReusableCell(withReuseIdentifier: "MyPagerViewCell", index: itemAt) as! MyPagerViewCell
        cell.contentsLabel.text = "itemAt:\(itemAt)"
        return cell
    }
    
    
    
}

