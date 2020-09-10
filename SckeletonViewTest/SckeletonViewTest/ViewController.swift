//
//  ViewController.swift
//  SckeletonViewTest
//
//  Created by hanwe lee on 2020/09/10.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SkeletonView

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var list:Array<String> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        self.tableView.isSkeletonable = true
        
    }

    @IBAction func testAction(_ sender: Any) {
        print("action")
        view.showAnimatedGradientSkeleton()
        DispatchQueue.global().async {
            usleep(3 * 1000 * 1000)
            for _ in 0..<10 {
                print("append")
                self.list.append("test")
            }
            DispatchQueue.main.async {
                self.view.hideSkeleton()
                print("reload")
                
                UIView.transition(with: self.tableView,
                duration: 0.35,
                options: .transitionCrossDissolve,
                animations: { self.tableView.reloadData() }) // left out the unnecessary syntax in the completion block and the optional completion parameter
                
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource,SkeletonTableViewDataSource {

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MyTableViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.label.text = self.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
//        let animation = currentTableAnimation.getAnimation()
//        let animator = TableViewAnimator(animation: animation)
//        animator.animate(cell: cell, at: indexPath, in: tableView)
        cell.transform = CGAffineTransform(translationX: 0, y: 100 * 1.4)
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.85,
            delay: 0.05 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
