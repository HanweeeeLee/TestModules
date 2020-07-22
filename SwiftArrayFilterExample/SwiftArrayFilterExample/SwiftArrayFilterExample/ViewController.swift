//
//  ViewController.swift
//  SwiftArrayFilterExample
//
//  Created by hanwe lee on 2020/07/22.
//  Copyright © 2020 hw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test1()
        test2()
    }
    
    func test1() {
        let numbers:[Int] = [9,1,2,3,4,5]
        let evenNumbers:[Int] = numbers.filter{ (numbers: Int) -> Bool in
            return numbers%2 == 0
        }
        print("evenNumber:\(evenNumbers)")
        
        let oddNumbers:[Int] = numbers.filter{ $0 % 2 != 0}
        print("oddNumbers:\(oddNumbers)")
    }
    
    func test2() {
        let numbers: [Int] = [0,1,2,3,4,5]
        let mappedNumbsers:[Int] = numbers.map{ $0 + 3 }
        
        let evenNumbers: [Int] = mappedNumbsers.filter{ (number: Int) -> Bool in
            return number % 2 == 0
        }
        print("evenNumbers:\(evenNumbers)")
        
        // mappedNumbers를 굳이 여러 번 사용할 필요가 없다면 메서드를 체인처럼 연결하여 사용할 수 있습니다.
        let oddNumbers: [Int] = numbers.map{ $0 + 3 }.filter{ $0 % 2 != 0 }
        print(oddNumbers)
        
        
    }


}

