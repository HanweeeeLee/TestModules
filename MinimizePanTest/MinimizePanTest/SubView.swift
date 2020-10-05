//
//  SubView.swift
//  MinimizePanTest
//
//  Created by hanwe lee on 2020/10/05.
//

import UIKit

class SubView: UIView {
    //MARK: outlet
    
    //MARK: property
    
    //MARK: lifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    //MARK: func
    
    func initUI() {
        
    }
    
    static func initFromNib() -> SubView {
        return Bundle.main.loadNibNamed("SubView", owner: self, options: nil)?.first as! SubView
    }
    
    //MARK: action

}
