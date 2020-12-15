//
//  WebView.swift
//  WebView
//
//  Created by hanwe lee on 2020/12/15.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    //MARK: enum
    
    //MARK: outlet
    @IBOutlet weak var webViewContainerView: UIView!
    
    //MARK: property
    
    var webView: WKWebView = WKWebView()
    var mainURL:URL? = URL(string: "https://www.apple.com")
    
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = self.mainURL else {
            return
        }
        print("url:\(url)")
        
        self.webView.load(URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5))
        
        initUI()
    }
    
    //MARK: func
    func initUI() {
        self.webViewContainerView.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.top.equalTo(self.webViewContainerView.snp.top).offset(0)
            make.bottom.equalTo(self.webViewContainerView.snp.bottom).offset(0)
            make.leading.equalTo(self.webViewContainerView.snp.leading).offset(0)
            make.trailing.equalTo(self.webViewContainerView.snp.trailing).offset(0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func back(_ sender: Any) {
        print("back")
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
    @IBAction func forward(_ sender: Any) {
        print("forward")
        if self.webView.canGoForward {
            self.webView.goForward()
        }
    }
    @IBAction func reload(_ sender: Any) {
        self.webView.reload()
    }
    
}
