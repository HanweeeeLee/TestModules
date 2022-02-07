//
//  Test.swift
//  CodableTest
//
//  Created by Aaron Hanwe LEE on 2022/02/07.
//

import UIKit

struct Model: Codable {
    let name: String
    let myValue: MyProtocol
    
    private enum CodingKeys: String, CodingKey {
        case name
        case myValue
    }
    
    init(name: String, myValue: MyProtocol) {
        self.name = name
        self.myValue = myValue
    }

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        if let test = try? values.decode(Lv1.self, forKey: .myValue) {
            self.myValue = test
        } else if let test2 = try? values.decode(Lv2.self, forKey: .myValue) {
            self.myValue = test2
        } else if let test3 = try? values.decode(Lv3.self, forKey: .myValue) {
            self.myValue = test3
        } else {
            self.myValue = Lv1(test: "")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
        
}

protocol MyProtocol: Codable {
}

struct Lv1: MyProtocol {
    let test: String
}

struct Lv2: MyProtocol {
    let test: [String]
}

struct Lv3: MyProtocol {
    let test: [[String]]
}


//struct TestModel:
