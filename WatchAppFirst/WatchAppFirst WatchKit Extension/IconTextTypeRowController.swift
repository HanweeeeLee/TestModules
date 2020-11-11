//
//  IconTextTypeRowController.swift
//
//
//  Created by hanwe lee on 2020/11/10.
//  Copyright © 2020 hanwe. All rights reserved.
//

import WatchKit

class IconTextTypeRowController: NSObject {
    @IBOutlet weak var imgView: WKInterfaceImage!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    
    func showItem(title: String,imageName: String) {
        self.titleLabel.setText(title)
        self.imgView.setImage(UIImage(named: imageName))
    }
}
