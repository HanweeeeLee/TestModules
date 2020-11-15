//
//  CopyOnWriteManager.swift
//  FlexibleModelProtocol
//
//  Created by hanwe lee on 2020/10/22.
//

public protocol CopyOnWriteModelProtocol {
    associatedtype ModelType: FlexibleModelProtocol
    var dataWrapper: DataWrapper<ModelType>? { get set }
    var data: ModelType? { get set }
    
    func toFlexibleProtocolModel<T: FlexibleModelProtocol>() -> T?
}

extension CopyOnWriteModelProtocol {
    
    public var data: ModelType? {
        get {
            return self.dataWrapper?.data
        }
        set {
            if !isKnownUniquelyReferenced(&self.dataWrapper) {
                if let value = newValue {
                    self.dataWrapper = DataWrapper(originModel: value)
                }
            } else {
                self.dataWrapper?.data = newValue
            }
        }
    }
    
    public func toFlexibleProtocolModel<T: FlexibleModelProtocol>() -> T? {
        var returnValue:T? = nil
        if let data = self.data {
            if let flexibleModelProtocolData = data as? T {
                returnValue = flexibleModelProtocolData
            }
        }
        return returnValue
    }
}

public class DataWrapper<T: FlexibleModelProtocol>: Equatable {
    public static func == (lhs: DataWrapper<T>, rhs: DataWrapper<T>) -> Bool {
        return lhs === rhs
    }
    
    public var data: T?
    
    public init(originModel: T) {
        self.data = originModel
    }
}
