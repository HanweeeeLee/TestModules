import UIKit

@propertyWrapper
struct SavedMoney {
    private var money: Double = 0.0
 
    var wrappedValue: Double {
        get { money }
        set { money = newValue * 1.002 }
    }
 
    init(wrappedValue: Double) {
        self.wrappedValue = wrappedValue
    }
}

struct OriginBankAccount {
    @SavedMoney var money: Double
}
 
struct SalaryBankAccount {
    @SavedMoney var money: Double
}
 
print(OriginBankAccount(money: 1.0))
print(SalaryBankAccount(money: 1.0))


//@propertyWrapper
//public struct Pulse<Value> {
//
//  public var value: Value {
//    didSet {
//      self.riseValueUpdatedCount()
//    }
//  }
//  var valueUpdatedCount = UInt.min
//
//  public init(wrappedValue: Value) {
//    self.value = wrappedValue
//  }
//
//  public var wrappedValue: Value {
//    get { return self.value }
//    set { self.value = newValue }
//  }
//
//  public var projectedValue: Pulse<Value> {
//    return self
//  }
//
//  private mutating func riseValueUpdatedCount() {
//    if self.valueUpdatedCount == UInt.max {
//      self.valueUpdatedCount = UInt.min
//    } else {
//      self.valueUpdatedCount += 1
//    }
//  }
//}
