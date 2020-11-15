//
//  FlexibleModelProtocol.swift
//  FlexibleModelProtocol
//
//  Created by hanwe lee on 2020/10/12.
//  Copyright © 2020 hanwe. All rights reserved.
//  e-mail : mobiledev@kakao.com
//

public protocol FlexibleModelProtocol: Codable, Equatable {
    
    static func fromJson<T: FlexibleModelProtocol>(jsonData: Data?,object: T) -> T?
    static func fromXML<T: FlexibleModelProtocol>(xmlData: Data?,object: T) -> T?
    static func fromDictionary<T: FlexibleModelProtocol>(dictionary: Dictionary<String,Any>, object: T) -> T?
    static func fromNSDictionary<T: FlexibleModelProtocol>(nsDictionary: NSDictionary, object: T) -> T?
    
    func toJson() -> String
    func toXML() -> String?
    func toDictionary() -> Dictionary<String,Any>?
    func toNSDictionary() -> NSDictionary?
    
    func toCopyOnWriteModel<T: CopyOnWriteModelProtocol>(object:inout T) -> T?
}

extension FlexibleModelProtocol {
    public static func fromJson<T: FlexibleModelProtocol>(jsonData: Data?,object: T) -> T? {
        var returnValue: T? = nil
        let decoder = JSONDecoder()
        if let data = jsonData, let result = try? decoder.decode(T.self, from: data) {
            returnValue = result
        }
        return returnValue
    }
    
    public static func fromXML<T: FlexibleModelProtocol>(xmlData: Data?,object: T) -> T? {
        var returnValue: T? = nil
        
        if let data = xmlData {
            let parser:HWXMLParser = HWXMLParser()
            if let xmlElement = parser.parse(data: data) {
                if let dic = parser.toDictionary(element: xmlElement) {
                    returnValue = fromDictionary(dictionary: dic, object: object)
                }
            }
        }
        
        return returnValue
    }
    
    public static func fromDictionary<T: FlexibleModelProtocol>(dictionary: Dictionary<String,Any>,object: T) -> T? {
        var returnValue: T? = nil
        
        if let jsonData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            returnValue = T.fromJson(jsonData: jsonData, object: object)
        }
        
        return returnValue
    }
    
    public static func fromNSDictionary<T: FlexibleModelProtocol>(nsDictionary: NSDictionary,object: T) -> T? {
        var returnValue: T? = nil
        if let dic = nsDictionary as? Dictionary<String,Any> {
            returnValue = T.fromDictionary(dictionary: dic, object: object)
        }
        return returnValue
    }
}

extension FlexibleModelProtocol {
    public func toJson() -> String {
        var jsonString: String = ""
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.outputFormatting = .sortedKeys
        let jsonData = try? encoder.encode(self)
        if jsonData != nil {
            jsonString = String(data: jsonData!, encoding: .utf8) ?? ""
        }
        return jsonString
    }
    
    public func toXML() -> String? {
        var returnValue: String? = nil
        if let dic = toDictionary() {
            let parser:HWXMLParser = HWXMLParser()
            returnValue = parser.toXMLString(dictionary: dic)
        }
        
        return returnValue
    }
    
    public func toDictionary() -> Dictionary<String,Any>? {
        var returnValue: Dictionary<String,Any>? = nil
        if let data = self.toJson().data(using: .utf8) {
            do {
                returnValue = try JSONSerialization.jsonObject(with:data, options: []) as? [String: Any]
            }
            catch {
                
            }
        }
        return returnValue
    }
    
    public func toNSDictionary() -> NSDictionary? {
        var returnValue:NSDictionary? = nil
        if let dic = self.toDictionary() {
            returnValue = dic as NSDictionary
        }
        return returnValue
    }
    
}

extension FlexibleModelProtocol {
    public func toCopyOnWriteModel<T: CopyOnWriteModelProtocol>(object:inout T) -> T? {
        var returnValue:T? = nil
        if let typeModel = self as? T.ModelType {
            object.dataWrapper = DataWrapper(originModel: typeModel)
            returnValue = object
        }
        return returnValue
    }
}


