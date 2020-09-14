//
//  ViewController.swift
//  UITableViewProtocolExtension
//
//  Created by hanwe lee on 2020/09/14.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let test:MyTableViewDelegate = MyTableViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let test:MyTableViewDelegate = MyTableViewDelegate(tableViewDelegate: self, tableViewDataSource: self)
        test.originalTableViewDelegate = self
        test.originalTableViewDataSource = self
        self.tableView.delegate = test
        self.tableView.dataSource = test
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.tableView.myTableViewDelegate = test
//        DispatchQueue.main.async {
////            self.tableView.reloadData()
//        }
        print("self.tableView.delegate:\(String(describing: self.tableView.delegate))")
        print("self.tableView.dataSource:\(String(describing: self.tableView.dataSource))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("test1")
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        cell.backgroundColor = .brown
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("test3*****")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected:\(indexPath.row)")
    }
}

