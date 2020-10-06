//
//  Example2SubView2.swift
//  HeroExample
//
//  Created by hanwe lee on 2020/09/18.
//

import UIKit

class Example2SubView2: UIView {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instance() -> Example2SubView2 {
        return UINib(nibName: "Example2SubView2", bundle: .main).instantiate(withOwner: nil, options: nil).first as! Example2SubView2
    }
}
