//
//  ViewController.swift
//  GenericVarTest
//
//  Created by hanwe lee on 2021/06/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let var1 = MyCommonModel(myChild: MyModel1(name: "tomas"), type: .one)
        let var2 = MyCommonModel(myChild: MyModel2(foo: "test"), type: .two)
        let testA: MyModel1? = var1.getChild3()
        print("end")
    }

}

protocol MyVarProtocol {
    
}

struct MyModel1: MyVarProtocol {
    let name: String
}

struct MyModel2: MyVarProtocol {
    let foo: String
}

struct MyCommonModel {
    enum MyModelType {
        case one
        case two
    }
    var myChild: MyVarProtocol
    var type: MyModelType
    
    func getChild3<T: MyVarProtocol>() -> T? {
        switch self.type {
        case .one:
            return self.myChild as? MyModel1 as? T
        case .two:
            return self.myChild as? MyModel2 as? T
        }
    }
    
    
}

