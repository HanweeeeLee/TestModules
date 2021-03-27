//
//  ViewController.swift
//  SPMSample
//
//  Created by hanwe on 2021/03/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://api.github.com/search/repositories?q=hi&sort=start&page=0", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (responseObject) -> Void in
                    
                    switch responseObject.result {
                    case .success(let value):
                        print("value :\(value)")
                        break
                    case .failure(let error):
                        print("error :\(error)")
                        break
                    }
                }
    }


}

