//
//  WebViewController.swift
//  Karen Digitial Library
//
//  Created by sowah on 9/9/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

   var webView: WKWebView!
    var magazineUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        guard let url = URL(string: magazineUrl) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

}
