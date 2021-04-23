//
//  ViewController.swift
//  StickyViewSample
//
//  Created by hanwe lee on 2021/04/23.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showType1(_ sender: Any) {
        let vc: Type1ViewController = Type1ViewController(nibName: "Type1ViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showType2(_ sender: Any) {
        let vc: Type2ViewController = Type2ViewController(nibName: "Type2ViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
