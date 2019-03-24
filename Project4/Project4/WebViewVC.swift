//
//  WebViewVC.swift
//  Project4
//
//  Created by Shantanu Dutta on 24/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    var websiteHost: String!
    private let validWebsites = ["apple.com", "hackingwithswift.com"]
    
    lazy var hostwebView: WKWebView! = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.navigationDelegate = self
        return webview
    }()
    
    var webviewBackButton: UIBarButtonItem!
    var webviewForwardButton: UIBarButtonItem!
    
    let progressview: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
//    override func loadView() {
//        super.loadView()
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        controlButtons()
        loadURL()
        
        // Do any additional setup after loading the view.
    }
    
    func controlButtons() {
        if hostwebView.canGoBack {
            webviewBackButton.isEnabled = true
        }else{
            webviewBackButton.isEnabled = false
        }
        if hostwebView.canGoForward {
            webviewForwardButton.isEnabled = true
        }else{
            webviewForwardButton.isEnabled = false
        }
    }
    
    func configureViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: hostwebView, action: #selector(hostwebView.stopLoading))
        
        view.addSubview(hostwebView)
        NSLayoutConstraint.activate([
            hostwebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostwebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostwebView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            hostwebView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        hostwebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        webviewBackButton = UIBarButtonItem(title: "＜", style: .plain, target: self, action: #selector(goBack))
        webviewForwardButton = UIBarButtonItem(title: "＞", style: .plain, target: self, action: #selector(goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbarItems = [webviewBackButton, webviewForwardButton, spacer]
        navigationController?.isToolbarHidden = false
        
        view.addSubview(progressview)
        progressview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        progressview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        progressview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        progressview.isHidden = true
    }
    
    func loadURL() {
        let url = URL(string: "https://" + websiteHost)!
        hostwebView.load(URLRequest(url: url))
        hostwebView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func goBack() {
        if hostwebView.canGoBack {
            hostwebView.goBack()
        }
    }
    
    @objc func goForward() {
        if hostwebView.canGoForward {
            hostwebView.goForward()
        }
    }
}

extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: hostwebView, action: #selector(hostwebView.stopLoading))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        controlButtons()
        progressview.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: hostwebView, action: #selector(hostwebView.reload))
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in validWebsites {
                if host.contains(website){
                    progressview.isHidden = false
                    decisionHandler(.allow)
                    return
                }
            }
        }
        let ac = UIAlertController(title: "Site Blocked !", message: "The site you are trying to visit is blocked.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            decisionHandler(.cancel)
        }))
        present(ac, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressview.progress = Float(hostwebView.estimatedProgress)
            if hostwebView.estimatedProgress == 1.0 {
                progressview.progress = 0.0
            }
        }
    }
}
