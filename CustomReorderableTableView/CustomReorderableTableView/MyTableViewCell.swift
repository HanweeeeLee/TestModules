//
//  MyTableViewCell.swift
//  ReorderableTableView
//
//  Created by hanwe lee on 2020/11/23.
//

import UIKit

protocol MyTableViewCellDelegate: class {
    func longPressCell(inputedIndexPath: IndexPath?, cell: UITableViewCell, longPress: UILongPressGestureRecognizer)
}

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var reorderBtnView: UIView!
    
    weak var delegate: MyTableViewCellDelegate?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCalled(_:)))
        self.reorderBtnView.addGestureRecognizer(longPressGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func longPressCalled(_ longPress: UILongPressGestureRecognizer) {
        self.delegate?.longPressCell(inputedIndexPath: self.indexPath, cell: self, longPress: longPress)
    }
    
}
