//
//  MyTableViewCell.swift
//  MyTableViewTest
//
//  Created by hanwe lee on 2020/09/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SkeletonView

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
