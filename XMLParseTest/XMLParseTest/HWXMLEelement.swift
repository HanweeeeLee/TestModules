//
//  HWXMLEelement.swift
//  XMLParseTest
//
//  Created by hanwe lee on 2020/10/13.
//

import UIKit

class HWXMLEelement: NSObject {
    weak var parentsElement:HWXMLEelement?
    var childrenEelement:Array<HWXMLEelement> = Array()
    var name:String
    var value:String = ""
    
    init(name:String) {
        self.name = name
    }
    
    convenience init(name:String,parentsElement:HWXMLEelement) {
        self.init(name:name)
        self.parentsElement = parentsElement
    }
    
}
