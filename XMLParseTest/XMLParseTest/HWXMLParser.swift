//
//  HWXMLParser.swift
//  XMLParseTest
//
//  Created by hanwe lee on 2020/10/12.
//

import Foundation

class HWXMLParser:NSObject {
    
    //MARK: private property
    private var parser:XMLParser? = nil
    private var elementStack:Array<HWXMLEelement> = Array()
    private var rootEelement:HWXMLEelement? = nil
    
    //MARK: public property
    
    //MARK: lifeCycle
    
    //MARK: private func
    
    //MARK: public func
    
    public func parse(data:Data) -> HWXMLEelement? {
        self.parser = XMLParser(data: data)
        self.parser?.delegate = self
        self.parser?.parse()
        return self.rootEelement
    }
    
}

extension HWXMLParser:XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if self.elementStack.count > 0 {
            let newElement:HWXMLEelement = HWXMLEelement.init(name: elementName, parentsElement: self.elementStack.last!)
            self.elementStack.last!.childrenEelement.append(newElement)
            self.elementStack.append(newElement)
        }
        else {
            let newElement:HWXMLEelement = HWXMLEelement.init(name: elementName)
            self.rootEelement = newElement
            self.elementStack.append(newElement)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if self.elementStack.count > 0 {
            if self.elementStack.last!.name == elementName {
                elementStack.removeLast()
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string != "\n" && string != "" {
            if self.elementStack.count > 0 {
                self.elementStack.last!.value = string
            }
        }
    }
}
