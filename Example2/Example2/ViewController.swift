//
//  ViewController.swift
//  Example2
//
//  Created by hanwe on 2020/05/20.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

/*
 3-C.
 1) 폰트와 스트링을 입력받으면 그 텍스트의 길이를 리턴하는 함수를 만든다.
 2) 리턴받은 수로 textLabel의 width constraint.const를 set해준다.
 3) 텍스트필드의 leading constraint 의 relation을 greater than or equal로 바꿔준다.
 4) textField의 delegate에 텍스트 입력을 받는 옵저버를 추가한 후 위에서 만들어준 함수에 넣어 현재 텍스트필드에 입력되는 스트링의 길이를 계산한다.
 5) 텍스트필드의 텍스트의 길이가 길어지다가 기본 텍스트필드의 길이보다 이상이되는지 이하가 되는지 체크를 해준다.
 6) 이상이된다면 그 초과한 숫자만큼 textLabel의 width 오토레이아웃을 줄여준다. 텍스트필드의 글자 길이가 줄어든다면 width를 늘려줘야 할것이다.
 */

class ViewController: UIViewController {

    var nameTextField:UITextField = UITextField()
    var nameLabel:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        
        nameTextField.text = "my Name"
    }
    
    override func loadView() {
        print("gi")
        view = UIView()
        view.backgroundColor = UIColor.white
        
        nameTextField = UITextField()
        nameLabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.backgroundColor = UIColor.green
        nameTextField.backgroundColor = UIColor.lightGray
        
        /* 3 - A 적절한 조취
         텍스트라벨과 텍스트필드 만들어놓고 addSubview를 하지않았다.
         */
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        /* 3 - A 적절한 조취*/
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -8).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        

        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
    @objc func myTargetFunction(textField: UITextField) {
        self.nameTextField.text = ""
    }


}

