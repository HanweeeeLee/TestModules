//
//  HWXMLEelement.swift
//  XMLParseTest
//
//  Created by hanwe lee on 2020/10/13.
//

public class HWXMLEelement: NSObject {
    
    internal weak var parentsElement: HWXMLEelement?
    internal var childrenEelement: Array<HWXMLEelement> = Array()
    internal var name: String
    internal var attributes: [String:String] = Dictionary()
    internal var value: String = ""
    
    public init(name: String) {
        self.name = name
    }
    
    public convenience init(name: String,parentsElement: HWXMLEelement) {
        self.init(name:name)
        self.parentsElement = parentsElement
    }
    
}
