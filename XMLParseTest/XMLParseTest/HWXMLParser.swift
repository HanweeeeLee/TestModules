//
//  HWXMLParser.swift
//  XMLParseTest
//
//  Created by hanwe lee on 2020/10/12.
//

import Foundation

public class HWXMLParser:NSObject {
    
    //MARK: private property
    private var parser:XMLParser? = nil
    private var elementStack:Array<HWXMLEelement> = Array()
    private var rootEelement:HWXMLEelement? = nil
    
    //MARK: public property
    
    //MARK: lifeCycle
    
    //MARK: private func
    
    private func makeXMLtoDictionary(dictionary:inout [String:Any], element:HWXMLEelement) {
        let children:Array<HWXMLEelement> = element.childrenEelement
        for i in 0..<children.count {
            if children[i].childrenEelement.count == 0 {
                dictionary[children[i].name] = children[i].value
            }
            else {
                var newDictionary:[String:Any] = Dictionary()
                makeXMLtoDictionary(dictionary: &newDictionary, element: children[i])
                if dictionary[children[i].name] == nil {
                    dictionary[children[i].name] = newDictionary
                }
                else {
                    if (dictionary[children[i].name] as? Array<[String:Any]>) != nil {
                        var newArray:Array<[String:Any]> = Array()
                        newArray += (dictionary[children[i].name] as! Array<[String:Any]>)
                        newArray.append(newDictionary)
                        dictionary[children[i].name] = newArray
                    }
                    else {
                        var newArray:Array<[String:Any]> = Array()
                        newArray.append(dictionary[children[i].name] as! [String:Any])
                        newArray.append(newDictionary)
                        dictionary[children[i].name] = newArray
                    }
                }
            }
        }
    }
    
    //MARK: public func
    
    public func parse(data:Data) -> HWXMLEelement? {
        self.parser = XMLParser(data: data)
        self.parser?.delegate = self
        self.parser?.parse()
        return self.rootEelement
    }
    
    public func toDictionary(element:HWXMLEelement) -> [String:Any]? {
        var returnValue:[String:Any]? = nil
            var rootDic:[String:Any] = Dictionary()
            var newDic:[String:Any] = Dictionary()
            makeXMLtoDictionary(dictionary: &newDic, element: element)
            rootDic[element.name] = newDic
            returnValue = rootDic
        return returnValue
    }
    
    public func toJson(element:HWXMLEelement) -> Data? {
        var returnValue:Data? = nil
        
        if let dic = toDictionary(element: element) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                returnValue = jsonData
            } catch {
                
            }
        }
        
        return returnValue
    }
    
}

extension HWXMLParser:XMLParserDelegate {
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
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
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if self.elementStack.count > 0 {
            if self.elementStack.last!.name == elementName {
                elementStack.removeLast()
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string != "\n" && string != "" {
            if self.elementStack.count > 0 {
                self.elementStack.last!.value = string
            }
        }
    }
}
