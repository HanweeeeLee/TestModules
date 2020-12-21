//
//  ViewController.swift
//  KeychainExample
//
//  Created by hanwe on 2020/12/21.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func setAction(_ sender: Any) {
        Keychain()["myValue"] = inputTextField.text!
    }
    @IBAction func getAction(_ sender: Any) {
        self.outputLabel.text = Keychain()["myValue"]
    }
    @IBAction func testAction(_ sender: Any) {
        testSetWithPassword()
    }
    @IBAction func getWithPassword(_ sender: Any) {
        testGetWithPassword()
    }
    
    func testSetWithPassword() {
        let keychain = Keychain(service: "com.example.github-token")

        DispatchQueue.global().async {
            do {
                // Should be the secret invalidated when passcode is removed? If not then use `.WhenUnlocked`
                try keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                    .set("01234567-89ab-cdef-0123-456789abcdef", key: "kishikawakatsumi")
            } catch let error {
                print("err:\(error.localizedDescription)")
            }
        }
    }
    
    func testGetWithPassword() {
        let keychain = Keychain(service: "com.example.github-token")

        DispatchQueue.global().async {
            do {
                // Should be the secret invalidated when passcode is removed? If not then use `.WhenUnlocked`
                let somthing = try keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                    .get("kishikawakatsumi")
                print("somthing:\(somthing)")
            } catch let error {
                print("err:\(error.localizedDescription)")
            }
        }
    }
    
}

