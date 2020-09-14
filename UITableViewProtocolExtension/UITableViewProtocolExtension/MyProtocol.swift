//
//  MyProtocol.swift
//  UITableViewProtocolExtension
//
//  Created by hanwe lee on 2020/09/14.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import Foundation

class MyTableViewDelegate:NSObject {
    weak var originalTableViewDelegate: UITableViewDelegate?
    weak var originalTableViewDataSource: UITableViewDataSource?
    
//    convenience init(tableViewDelegate:UITableViewDelegate? = nil,tableViewDataSource:UITableViewDataSource? = nil) {
//        self.init()
//        self.originalTableViewDelegate = tableViewDelegate
//        self.originalTableViewDataSource = tableViewDataSource
//    }
}

extension MyTableViewDelegate:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return originalTableViewDataSource?.numberOfSections?(in: tableView) ?? 1
//        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("test15555")
//        print("willReturn:\(self.originalTableViewDataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0)")
        return self.originalTableViewDataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
//        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("test2")
        return self.originalTableViewDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
//        let cell:UITableViewCell = UITableViewCell()
//        cell.backgroundColor = .brown
//        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        DispatchQueue.main.async {
//        print("selected:\(indexPath.row)")
//        }
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        DispatchQueue.main.async {
                print("test@@@@@@@@@@@@@")
        self.originalTableViewDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
}
    


//extension UITableView {
//
//
//    var test:String {
//        get {
//            print("뭐지")
//            return ""
//        }
//        set {
//            print("흐음")
//        }
//    }
//    var myTableViewDelegate: MyTableViewDelegate? {
//        get {
////            print("test!@#")
//            return MyTableViewDelegate()
//        }
//        set {
////            return nil
//            print("test1h12uiehuidhiu")
//            print("newValue:\(newValue)")
////            newValue?.originalTableViewDelegate = self.delegate
////            newValue?.originalTableViewDatasource = self.dataSource
//
////            print("self.delegate1:\(self.delegate)")
////            self.delegate = newValue
////            self.dataSource = newValue
////            print("self.delegate2:\(self.delegate)")
//        }
//    }
//}
//

