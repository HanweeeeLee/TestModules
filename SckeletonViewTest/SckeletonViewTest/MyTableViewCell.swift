//
//  MyTableViewCell.swift
//  SckeletonViewTest
//
//  Created by hanwe lee on 2020/09/10.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SkeletonView

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentsView.isSkeletonable = true
        self.imgView.isSkeletonable = true
        self.label.isSkeletonable = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
