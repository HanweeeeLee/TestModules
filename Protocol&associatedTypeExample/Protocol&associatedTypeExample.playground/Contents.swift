import UIKit

protocol MyProtocol {
    associatedtype MyVarType: MyVarClassProtocol
    var myVar: MyVarType { get set }
}

protocol MyVarClassProtocol {
    var name: String { get set }
}

class MyVarClass: MyVarClassProtocol {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func printName() {
        print("my Name is \(self.name)")
    }
}

class MyClass: MyProtocol {
    typealias MyVarType = MyVarClass
    var myVar: MyVarClass = MyVarClass(name: "tomas")
}

MyClass().myVar.printName()
