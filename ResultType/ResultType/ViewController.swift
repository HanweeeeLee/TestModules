//
//  ViewController.swift
//  ResultType
//
//  Created by hanwe on 2021/05/28.
//

import UIKit

enum MyErrorCode: Int, Error {
    case code1 = 0
    case code2
}

extension MyErrorCode {
    var codeValue: Int {
        switch self {
        case .code1:
            return 1
        case .code2:
            return 2
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let response = doSomething(isSuccess: true)
        switch response {
        case .success(let successStr):
            print("\(successStr)")
        case .failure(let code):
            print("error :\(code)")
        }
        
        let response2 = doSomething(isSuccess: false)
        switch response2 {
        case .success(let successStr):
            print("\(successStr)")
        case .failure(let code):
            print("error :\(code.rawValue)")
        }
    }
    
    func doSomething(isSuccess: Bool) -> Result<String, MyErrorCode> {
        // 성공하면 String을, 실패한다면 ErrorCode를 리턴해주고싶다.
        if isSuccess {
            return .success("success!!")
        } else {
            return .failure(.code2)
        }
        
    }


}

