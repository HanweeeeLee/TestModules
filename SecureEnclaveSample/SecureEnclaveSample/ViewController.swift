//
//  ViewController.swift
//  SecureEnclaveSample
//
//  Created by hanwe lee on 2021/11/24.
//

import UIKit
import Security
import Foundation
//import LocalAuthentication

//https://developer.apple.com/documentation/security/ksecattrtokenidsecureenclave SecureEnclave는 타원곡선 알고리즘 개인키만 저장이 가능한듯

class ViewController: UIViewController {
    
    let module: SecureEnclaveModule = SecureEnclaveModule()
    
    var key: SecKey?
    
    var keyName: String = "test1"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func ecdsaSecureEnclaveTest() {
        var privateKeyAttr: [CFString: Any] = [CFString: Any]()
        privateKeyAttr[kSecAttrIsPermanent] = true
        let accessControlResult = module.createAccessControl(accessibility: .whenUnlockedThisDeviceOnly, policy: .biometryAny)
        
        switch accessControlResult {
        case .success(let accessControl):
            privateKeyAttr[kSecAttrAccessControl] = accessControl
            
            var myDic: [CFString: Any] = [CFString: Any]()
            myDic[kSecAttrKeyType] = kSecAttrKeyTypeECSECPrimeRandom
            myDic[kSecAttrKeySizeInBits] = 256
            myDic[kSecAttrTokenID] = kSecAttrTokenIDSecureEnclave
            myDic[kSecPrivateKeyAttrs] = privateKeyAttr
            
            let privateKey = SecKeyCreateRandomKey(myDic as CFDictionary, nil)
            var error: Unmanaged<CFError>?
            let outTest = SecKeyCopyExternalRepresentation(privateKey!, &error)
            if error != nil {
                print("음")
            }
            getPubKey(privkeyRef: privateKey!)
        case .failure(let err):
            print("err: \(err.localizedDescription)")
        }
    }

    func getPubKey(privkeyRef: SecKey) {
        let pubkey = SecKeyCopyPublicKey(privkeyRef)
        print("pubKey: \(pubkey)")
    }
    
    @IBAction func test1Action(_ sender: Any) {
        ecdsaSecureEnclaveTest()
    }
    @IBAction func aesTest(_ sender: Any) {
        guard prepareKey() else {
            return
        }
        
        guard let publicKey = SecKeyCopyPublicKey(key!) else {
            UIAlertController.showSimple(title: "Can't encrypt",
                                         text: "Can't get public key", from: self)
            return
        }
        let encAlgorithm: SecKeyAlgorithm = .eciesEncryptionCofactorVariableIVX963SHA256AESGCM
        guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, encAlgorithm) else {
            UIAlertController.showSimple(title: "Can't encrypt",
                                         text: "Algorith not supported", from: self)
            return
        }
        var error: Unmanaged<CFError>?
        let clearTextData = "abc".data(using: .utf8)!
        let cipherTextData = SecKeyCreateEncryptedData(publicKey, encAlgorithm,
                                                   clearTextData as CFData,
                                                   &error) as Data?
        guard cipherTextData != nil else {
            UIAlertController.showSimple(title: "Can't encrypt",
                                         text: (error!.takeRetainedValue() as Error).localizedDescription,
                                         from: self)
            return
        }
        print("enc: \(cipherTextData)")
        
        
//        let cipherTextHex = cipherTextData!.toHexString()
//        cipherTextLabel.setTextWithAlphaAnimation("Cipher Text: " + cipherTextHex)
        
        guard cipherTextData != nil else {
            UIAlertController.showSimple(title: "Can't decrypt",
                                         text: "No encrypted data, tap \"Encrypt\" first",
                                         from: self)
            return
        }
        let decAlgorithm: SecKeyAlgorithm = .eciesEncryptionCofactorVariableIVX963SHA256AESGCM
        guard SecKeyIsAlgorithmSupported(self.key!, .decrypt, decAlgorithm) else {
            UIAlertController.showSimple(title: "Can't decrypt",
                                         text: "Algorith not supported", from: self)
            return
        }
        
//        var error: Unmanaged<CFError>?
        let decTextData = SecKeyCreateDecryptedData(self.key!,
                                                      decAlgorithm,
                                                      cipherTextData! as CFData,
                                                      &error) as Data?

        print("origin:\(String(data: decTextData!, encoding: .utf8))")
    }
    
    private func prepareKey() -> Bool {
//        defer {
//            showPublicKey()
//        }
        guard key == nil else {
            return true
        }
        key = KeychainHelper.loadKey(name: keyName)
        guard key == nil else {
            return true
        }
        do {
//            key = try KeychainHelper.makeAndStoreKey(name: keyName,
//                                                     requiresBiometry: true)
            key = try KeychainHelper.makeAndStoreKey(name: keyName,
                                                     requiresBiometry: false)
            return true
        } catch let error {
            UIAlertController.showSimple(title: "Can't create key",
                                         text: error.localizedDescription, from: self)
        }
        return false
    }
    
}

extension UIAlertController {
    public static func showSimple(title: String?, text: String?, from vc: UIViewController) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
