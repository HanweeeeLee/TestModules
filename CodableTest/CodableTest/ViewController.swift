//
//  ViewController.swift
//  CodableTest
//
//  Created by hanwe lee on 2020/06/08.
//  Copyright © 2020 hanwe lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.outputFormatting = .sortedKeys
        let hanwe = Person(name: "hanwe", age:100)
        let jsonData = try? encoder.encode(hanwe)
        if let jsonData = jsonData, let jsonString = String(data:jsonData, encoding: .utf8) {
            print(jsonString)
            /* 이상 인코딩*/
            let decoder = JSONDecoder()
            let data = jsonString.data(using: .utf8)
            
            if let data = data, let myPerson = try? decoder.decode(Person.self, from: data) {
                print(myPerson.name)
                print(myPerson.age)
            }
            
        }
    }
    
    
}

