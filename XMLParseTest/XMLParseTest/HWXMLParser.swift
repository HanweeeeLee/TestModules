//
//  HWXMLParser.swift
//  XMLParseTest
//
//  Created by hanwe lee on 2020/10/12.
//

import Foundation

public class HWXMLParser:NSObject { //only supports utf-8 formmat
    
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
                if children[i].attributes.count > 0 {//todo attributes 적용
                    dictionary[children[i].name] = children[i].value
                }
                else {
                    dictionary[children[i].name] = children[i].value
                }
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
    
    private func makeXMLElementFromDictionary(element:inout HWXMLEelement,dictionary:[String:Any]) {
        let allKeys:Array<String> = Array(dictionary.keys)
        for i in 0..<allKeys.count {
            let key = allKeys[i]
            if (dictionary[key] as? Array<[String:Any]>) != nil {
                let array:Array<[String:Any]> = (dictionary[key] as! Array<[String:Any]>)
                for j in 0..<array.count {
                    var newElemnet:HWXMLEelement = HWXMLEelement(name: key, parentsElement: element)
                    makeXMLElementFromDictionary(element: &newElemnet, dictionary: array[j])
                    element.childrenEelement.append(newElemnet)
                }
            }
            else if (dictionary[key] as? [String:Any]) != nil {
                var newElement:HWXMLEelement = HWXMLEelement(name: key, parentsElement: element)
                makeXMLElementFromDictionary(element: &newElement, dictionary: (dictionary[key] as! [String:Any]))
                element.childrenEelement.append(newElement)
            }
            else if (dictionary[key] as? String) != nil {
                let newElement:HWXMLEelement = HWXMLEelement(name: key, parentsElement: element)
                newElement.value = (dictionary[key] as! String)
                element.childrenEelement.append(newElement)
            }
            else {
                //unexpected
            }
        }
    }
    
    private func makeXMLStringFromXMLElement(element:HWXMLEelement,beforeString:String) -> String {
        var returnString:String = beforeString
        if element.childrenEelement.count > 0 {
            returnString += "<\(element.name)>\n"
            for i in 0..<element.childrenEelement.count {
                let childElement:HWXMLEelement = element.childrenEelement[i]
                returnString = makeXMLStringFromXMLElement(element: childElement, beforeString: returnString)
                
            }
            returnString += "</\(element.name)>\n"
        }
        else {
            returnString += "<\(element.name)>\(element.value)\("</\(element.name)>")\n"
        }
        return returnString
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
    
    public func toXMLElement(dictionary:[String:Any]) -> HWXMLEelement? {
        var returnValue:HWXMLEelement? = nil
        let keys = Array(dictionary.keys)
        for i in 0..<keys.count {
            var element:HWXMLEelement = HWXMLEelement(name: keys[i])
            if (dictionary[keys[i]] as? Array<[String:Any]>) != nil {
                print("unexpected error")
            }
            else {
                makeXMLElementFromDictionary(element: &element, dictionary: dictionary[keys[i]] as! [String : Any])
                returnValue = element
            }
        }
        return returnValue
    }
    
    public func toXMLString(dictionary:[String:Any]) -> String? {
        var returnValue:String? = nil
        if let root:HWXMLEelement = toXMLElement(dictionary: dictionary) {
            let header:String = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
            returnValue = makeXMLStringFromXMLElement(element: root, beforeString: header)
        }
        return returnValue
    }
    
}

extension HWXMLParser:XMLParserDelegate {
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if self.elementStack.count > 0 {
            let newElement:HWXMLEelement = HWXMLEelement.init(name: elementName, parentsElement: self.elementStack.last!)
            newElement.attributes = attributeDict
            self.elementStack.last!.childrenEelement.append(newElement)
            self.elementStack.append(newElement)
        }
        else {
            let newElement:HWXMLEelement = HWXMLEelement.init(name: elementName)
            newElement.attributes = attributeDict
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
