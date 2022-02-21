//
//  ViewController.swift
//  Test
//
//  Created by hanwe on 2022/02/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func testAction(_ sender: Any) {
        
        let url = URL(string: "https://daum.net")!
        let vc = CommonWebViewController.init(url: url)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

