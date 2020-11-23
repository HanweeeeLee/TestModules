//
//  ViewController.swift
//  ReorderableTableView
//
//  Created by hanwe lee on 2020/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: property
    
    var myData: Array<String> = ["안녕","하세요","입니다"]
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isEditing = true
    }
    
    //MARK: func
    
    //MARK: action

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.myLabel.text = self.myData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.myData[sourceIndexPath.row]
        myData.remove(at: sourceIndexPath.row)
        myData.insert(movedObject, at: destinationIndexPath.row)
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
    }
    
    
}

