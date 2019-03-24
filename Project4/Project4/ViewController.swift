//
//  ViewController.swift
//  Project4
//
//  Created by Shantanu Dutta on 19/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private let cellid = "websitecellid"

    lazy var tableView: UITableView! = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
//    var webView: WKWebView!
    
//    var progressview: UIProgressView!
    var website = ["apple.com", "hackingwithswift.com"]
    
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureviews()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(webView.reload))
        
//        let backButton = UIBarButtonItem(title: "＜", style: .plain, target: self, action: #selector(goBack))
//        let forwardButton = UIBarButtonItem(title: "＞", style: .plain, target: self, action: #selector(goForward))
//        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
//        progressview = UIProgressView(progressViewStyle: .default)
//        progressview.sizeToFit()
//        let progressButton = UIBarButtonItem(customView: progressview)
//        toolbarItems = [backButton,forwardButton, progressButton, spacer, refresh]
//        navigationController?.isToolbarHidden = false
//
//        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
//
//        loadURL()
    }
    
    func configureviews() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

//    func loadURL() {
//        let url = URL(string: "https://" + website[0])!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
//    }
//
//    @objc func goBack() {
//        if webView.canGoBack {
//            webView.goBack()
//        }
//    }
//
//    @objc func goForward() {
//        if webView.canGoForward {
//            webView.goForward()
//        }
//    }
    
//    @objc func openTapped() {
//        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
//        for website in website {
//            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
//        }
////        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
////        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(ac, animated: true)
//    }
//
////    func openPage(action: UIAlertAction) {
////        let url = URL(string: "https://" + action.title!)!
////        webView.load(URLRequest(url: url))
////    }
}

/*
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in website {
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
//        decisionHandler(.cancel)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressview.progress = Float(webView.estimatedProgress)
            if webView.estimatedProgress == 1.0 {
                progressview.progress = 0.0
                progressview.isHidden = true
            }
        }
    }
}
*/

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return website.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = website[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let webViewVC = WebViewVC()
        webViewVC.websiteHost = website[indexPath.row]
        title = ""
        show(webViewVC, sender: self)
    }
}
