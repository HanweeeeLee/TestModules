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
                print("test:\(String(describing: parser.parse(data:data)))")
            } catch {
                print("err")
            }
        }
        else {
            print("?")
        }
    }
}

