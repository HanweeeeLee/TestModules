//
//  ViewController.swift
//  StackPagerView
//
//  Created by Aaron Hanwe LEE on 2022/08/26.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController, TabPagerHeaderViewDelegate {
    func didSelected(_ view: TabPagerHeaderView, index: Int) {
        print("didSelected: \(index)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list: [String] = {
            var returnValue: [String] = []
            
            for i in 0..<10 {
                returnValue.append("안녕하세요\(i)")
            }
            return returnValue
        }()
        
        let test = TabPagerHeaderView(menuList: list, leadingInset: 20, trailingInset: 20, cellSpacing: 30)
        
        self.view.addSubview(test)
        let safeGuide = self.view.safeAreaLayoutGuide
        test.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(safeGuide)
            $0.height.equalTo(70)
        }
        self.view.backgroundColor = .lightGray
        test.delegate = self
    }


}

