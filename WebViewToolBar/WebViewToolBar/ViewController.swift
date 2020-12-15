//
//  ViewController.swift
//  WebViewToolBar
//
//  Created by hanwe on 2020/12/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func action(_ sender: Any) {
        let vc: WebViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
}

