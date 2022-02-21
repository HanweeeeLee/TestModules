//
//  CommonWebViewController.swift
//  Test
//
//  Created by hanwe on 2022/02/21.
//

import UIKit
import SnapKit
import WebKit

class CommonWebViewController: UIViewController {
    
    // MARK: private property
    
    private var mainUrl: URL
    private let contentController: WKUserContentController = WKUserContentController()
    private lazy var mainBackgroundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var mainContentsView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.alpha = 0
        progressBar.tintColor = .red
        progressBar.autoresizingMask = .flexibleWidth
        return progressBar
    }()
    
    private lazy var webView: WKWebView = WKWebView()
    
    
    // MARK: internal property
    
    
    // MARK: lifeCycle
    
    init(url: URL) {
        self.mainUrl = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.mainBackgroundView)
        self.mainBackgroundView.snp.makeConstraints {
            $0.edges.equalTo(self.view)
        }
        
        self.view.addSubview(self.mainContentsView)
        let safeGuide = self.view.safeAreaLayoutGuide
        self.mainContentsView.snp.makeConstraints {
            $0.edges.equalTo(safeGuide)
        }
        
        self.mainContentsView.addSubview(self.webView)
        self.webView.snp.makeConstraints {
            $0.edges.equalTo(self.mainContentsView)
        }
        
        self.mainContentsView.addSubview(self.progressBar)
        self.progressBar.snp.makeConstraints {
            $0.top.equalTo(self.mainContentsView.snp.top)
            $0.leading.equalTo(self.mainContentsView.snp.leading)
            $0.trailing.equalTo(self.mainContentsView.snp.trailing)
            $0.height.equalTo(2)
        }
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        definesPresentationContext = true
        
        
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        initUI()
        
        self.webView.load(URLRequest(url: self.mainUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5))
        self.webView.allowsLinkPreview = false
        let config: WKWebViewConfiguration = WKWebViewConfiguration()
        config.userContentController = contentController
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences = preferences
        self.webView = WKWebView(frame: .zero, configuration: config)
        
    }
    
    // MARK: private function
    
    private func initUI() {
        
    }
    
    // MARK: internal function
    
    // MARK: action
    

}

extension CommonWebViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url {
                let app = UIApplication.shared
                if navigationAction.targetFrame == nil {
                    if app.canOpenURL(url) {
                        app.open(url)
                        decisionHandler(.cancel)
                        return
                    }
                } else {
                    
                }
                decisionHandler(.allow)
            }
        } else {
            let app = UIApplication.shared
            if let url = navigationAction.request.url {
                if navigationAction.targetFrame == nil {
                    if app.canOpenURL(url) {
                        app.open(url)
                        decisionHandler(.cancel)
                        return
                    }
                }
                let hostAddress = navigationAction.request.url?.host // To connnect app store
                if hostAddress == "itunes.apple.com" {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                        decisionHandler(.cancel)
                        return
                    }
                }
                let urlStr = url.absoluteString
                print("urlStr:\(urlStr)")
                let url_elements = urlStr.components(separatedBy: ":")
                if url_elements[0].contains("http") == false && url_elements[0].contains("https") == false {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                    } else { // 만약 Info.plist의 white list에 등록되지 않은 앱 스키마가 있는 경우를 위해 사용, 신용카드 결제화면등을 위해 필요, 해당 결제앱 스키마 호출
                        if urlStr.contains("about:blank") == true {
                            print("@@@ Browser can't be opened, about:blank !! @@@")
                        } else {
                            print("@@@ Browser can't be opened, but Scheme try to call !! @@@")
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }

    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }


    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        progressBar.setProgress(1, animated: true)
        UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseInOut, animations: {
            self.progressBar.alpha = 0
        }, completion: nil)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(Float(webView.estimatedProgress))

        progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
        self.progressBar.setProgress(0, animated: false)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { self.progressBar.alpha = 1 }, completion: nil)

    }

    func webView(webView: WKWebView, navigation: WKNavigation, withError error: NSError) {

        progressBar.setProgress(1, animated: true)
        UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseInOut, animations: { self.progressBar.alpha = 0 }, completion: nil)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Could not load webpage", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let code = (error as NSError).code
        if code == NSURLErrorNotConnectedToInternet {
            // NotConnectedToInternet
        } else if code == NSURLErrorTimedOut {
            // 타임아웃
        } else if code == NSURLErrorCancelled {
            // 의도적으로 취소한 경우
        } else {

        }

    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

extension CommonWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
