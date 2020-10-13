//
//  ViewController.swift
//  XMLParseTest
//
//  Created by hanwe lee on 2020/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "example", ofType: "xml") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parser = HWXMLParser()
                let rootDic = parser.parse(data:data)
                
                print("json:\(String(describing: String(data: parser.toJson(element: rootDic!)!, encoding: .utf8)))")
                print("break")
                print("xml:\(parser.toXMLString(dictionary: parser.toDictionary(element: rootDic!)!)!)")
            } catch {
                print("err")
            }
        }
        else {
            print("?")
        }
    }
}

