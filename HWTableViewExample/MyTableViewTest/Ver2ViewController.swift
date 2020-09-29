//
//  Ver2ViewController.swift
//  MyTableViewTest
//
//  Created by hanwe lee on 2020/09/29.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

class Ver2ViewController: UIViewController {

    @IBOutlet weak var myTableView: HWTableView!
    
    var list:Array<String> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    @IBAction func testStartAction(_ sender: Any) {
        print("start")
        self.myTableView.showSkeletonViewAndInit()
        DispatchQueue.global().async {
            
            usleep(1 * 1000 * 1000)
            for _ in 0..<20 {
                self.list.append("test")
            }
            DispatchQueue.main.async {
                print("end")
                self.myTableView.hideSkeletonViewAndConnectMyCustomProtocol()
            }
            
        }
    }
    
}

extension Ver2ViewController:HWTableViewDelegate,HWTableViewDatasource {
    func hwTableView(_ hwtableView: HWTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func hwTableViewSekeletonViewCount(_ hwTableView: HWTableView) -> Int {
        return 5 //이걸 갯수를 조정해야하나 ㅡㅡ;
    }
    
    func hwTableViewSekeletonViewCellIdentifier(_ hwTableView: HWTableView) -> String {
        return "MyTableViewCell"
    }
    
    func hwTableView(_ hwTableView: HWTableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func hwTableView(_ hwTableView: HWTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.contentsLabel.text = self.list[indexPath.row]
        return cell
    }
    
    
}
