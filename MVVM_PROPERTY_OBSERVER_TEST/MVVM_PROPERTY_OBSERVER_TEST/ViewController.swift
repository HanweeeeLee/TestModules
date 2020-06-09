//
//  ViewController.swift
//  MVVM_PROPERTY_OBSERVER_TEST
//
//  Created by hanwe lee on 2020/06/08.
//  Copyright © 2020 hanwe lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var yearLabel: UILabel!
    
    var personViewModel = PersonViewModel(person: Person(name: "", age: -1))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.ageTextField.delegate = self
        self.personViewModel.bind { [weak self] (person) in
            self?.yearLabel.text = person.name + " " + "\(person.age)세"
        }
    }

}

struct Person {
    var name:String
    var age:Int
}

struct PersonViewModel {
    typealias Listener = (Person) -> Void
    var listener:Listener?

    var person:Person {
        didSet {
            listener?(person)
        }
    }
    
    mutating func bind(listener:Listener?) {
        self.listener = listener
    }
}

extension ViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let nameText = self.nameTextField.text,
            let ageText = self.ageTextField.text,
            let age = Int(ageText) else { return }
        
        self.personViewModel.person.name = nameText
        self.personViewModel.person.age = age
        
       
    }
}

