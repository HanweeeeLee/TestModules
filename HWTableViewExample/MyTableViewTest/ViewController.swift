//
//  ViewController.swift
//  MyTableViewTest
//
//  Created by hanwe lee on 2020/09/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SkeletonView

class ViewController: UIViewController {

    @IBOutlet weak var tableView: HWTableView!
    
    var list:Array<String> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        
    }

    @IBAction func testStartAction(_ sender: Any) {
        self.tableView.showSkeletonViewAndInit()
        DispatchQueue.global().async {
            usleep(1 * 1000 * 1000)
            for _ in 0..<50 {
                self.list.append("test")
            }
            DispatchQueue.main.async {
                print("end")
                self.tableView.hideSkeletonViewAndConnectMyCustomProtocol()
                self.tableView.reloadData()
            }
            
        }
    }
    

}

extension ViewController: UITableViewDelegate,UITableViewDataSource, SkeletonTableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MyTableViewCell"
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.contentsLabel.text = self.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

