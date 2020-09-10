//
//  ViewController.swift
//  XCUITestTest
//
//  Created by hanwe lee on 2020/09/09.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

struct inputModel {
    var value:String
}

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var dataArr:Array<inputModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }


    @IBAction func addAction(_ sender: Any) {
        if self.inputTextField.text != nil {
            if self.inputTextField.text! != "" {
                let obj:inputModel = inputModel(value: self.inputTextField.text!)
                self.dataArr.append(obj)
                self.inputTextField.text = ""
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        cell.textLabel?.text = self.dataArr[indexPath.row].value
        return cell
    }
    
    
}
