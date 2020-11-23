//
//  ViewController.swift
//  CustomReorderableTableView
//
//  Created by hanwe lee on 2020/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: property
    
    var myData: Array<String> = ["안녕","하세요","입니다"]
    
    fileprivate var sourceIndexPath: IndexPath?
    fileprivate var snapshot: UIView?
    
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
//
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCalled(_:)))
//        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    //MARK: func
    
    func snapshotOfCell(_ inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { fatalError() }
        inputView.layer.render(in: graphicsContext)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cellSnapshot: UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
//    @objc func longPressCalled(_ longPress: UILongPressGestureRecognizer) {
//        print("longPressCalled")
//
//        let state = longPress.state
//        let location = longPress.location(in: self.tableView)
//        guard let indexPath = self.tableView.indexPathForRow(at: location) else { return }
//        switch state {
//        case .began:
//            sourceIndexPath = indexPath
//            guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
//            // Take a snapshot of the selected row using helper method. See below method
//            snapshot = self.customSnapshotFromView(inputView: cell)
//            guard  let snapshot = self.snapshot else { return }
//            var center = cell.center
//            snapshot.center = center
//            snapshot.alpha = 0.0
//            self.tableView.addSubview(snapshot)
//            UIView.animate(withDuration: 0.25, animations: {
//                center.y = location.y
//                snapshot.center = center
//                snapshot.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
//                snapshot.alpha = 0.98
//                cell.alpha = 0.0
//            }, completion: { (finished) in
//                cell.isHidden = true
//            })
//            break
//        case .changed:
//            guard  let snapshot = self.snapshot else {
//                return
//            }
//            var center = snapshot.center
//            center.y = location.y
//            snapshot.center = center
//            guard let sourceIndexPath = self.sourceIndexPath  else {
//                return
//            }
//            if indexPath != sourceIndexPath {
//                swap(&myData[indexPath.row], &myData[sourceIndexPath.row])
//                self.tableView.moveRow(at: sourceIndexPath, to: indexPath)
//                self.sourceIndexPath = indexPath
//            }
//            break
//        default:
//            break
//        }
//    }
    
    private func customSnapshotFromView(inputView: UIView) -> UIView? {
      UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
      if let CurrentContext = UIGraphicsGetCurrentContext() {
        inputView.layer.render(in: CurrentContext)
      }
      guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
        UIGraphicsEndImageContext()
        return nil
      }
      UIGraphicsEndImageContext()
      let snapshot = UIImageView(image: image)
      snapshot.layer.masksToBounds = false
      snapshot.layer.cornerRadius = 0
      snapshot.layer.shadowOffset = CGSize(width: -5, height: 0)
      snapshot.layer.shadowRadius = 5
      snapshot.layer.shadowOpacity = 0.4
      return snapshot
    }
    
    private func cleanup() {
      self.sourceIndexPath = nil
      snapshot?.removeFromSuperview()
      self.snapshot = nil
        self.tableView.reloadData()
    }
    
    //MARK: action

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.myLabel.text = self.myData[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
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

//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedObject = self.myData[sourceIndexPath.row]
//        myData.remove(at: sourceIndexPath.row)
//        myData.insert(movedObject, at: destinationIndexPath.row)
//        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
//    }
    
    
}

extension ViewController: MyTableViewCellDelegate {
    func longPressCell(inputedIndexPath: IndexPath?, cell: UITableViewCell, longPress: UILongPressGestureRecognizer) {
//        print("longPressCell:\(indexPath) \(cell) \(state)")
//        guard let currentIndexPath = inputedIndexPath else { return }
        let state = longPress.state
        let location = longPress.location(in: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: location) else {
            print("cleanup")
            self.cleanup()
            return
        }
        print("location:\(location)")
        switch state {
        case .began:
            print("longPress begin")
            sourceIndexPath = indexPath
            guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
            // Take a snapshot of the selected row using helper method. See below method
            snapshot = self.customSnapshotFromView(inputView: cell)
            guard  let snapshot = self.snapshot else { return }
            var center = cell.center
            snapshot.center = center
            snapshot.alpha = 0.0
            self.tableView.addSubview(snapshot)
            UIView.animate(withDuration: 0.25, animations: {
                center.y = location.y
                snapshot.center = center
                snapshot.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                snapshot.alpha = 0.98
                cell.alpha = 0.0
            }, completion: { (finished) in
                cell.isHidden = true
            })
            break
        case .changed:
            print("change")
            guard  let snapshot = self.snapshot else {
                return
            }
            var center = snapshot.center
            center.y = location.y
            snapshot.center = center
            guard let sourceIndexPath = self.sourceIndexPath else {
                return
            }
            print("currentIndexPath:\(indexPath.row) sourceIndexPath:\(sourceIndexPath.row)")
            if indexPath != sourceIndexPath {
                let movedObject = self.myData[sourceIndexPath.row]
                myData.remove(at: sourceIndexPath.row)
                myData.insert(movedObject, at: indexPath.row)
                self.tableView.moveRow(at: sourceIndexPath, to: indexPath)
                self.sourceIndexPath = indexPath
            }
            break
        default:
            guard let cell = self.tableView.cellForRow(at: indexPath) else {
                return
            }
            guard  let snapshot = self.snapshot else {
                return
            }
            cell.isHidden = false
            cell.alpha = 0.0
            UIView.animate(withDuration: 0.25, animations: {
                snapshot.center = cell.center
                snapshot.transform = CGAffineTransform.identity
                snapshot.alpha = 0
                cell.alpha = 1
            }, completion: { (finished) in
                self.cleanup()
            })
        
//        default:
//            break
            
        
//        case .ended:
//            print("end")
//            break
//        case .cancelled:
//            print("cancelled")
//            break
//        case .failed:
//            print("failed")
//            break
//        case .possible:
//            print("possible")
//            break
//        case .recognized:
//            print("recognized")
//            break
    
        }
    }
}

