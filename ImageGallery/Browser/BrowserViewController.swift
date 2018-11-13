//
//  BrowserViewController.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 13/11/18.
//

import UIKit
import WebKit

class BrowserViewController: BaseViewController {
    var url:URL!
    
    private var webView = WKWebView()
    private var progressView = UIProgressView(progressViewStyle: .default)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
            navigationItem.title = url.absoluteString
            
            //Add progresbar to navigation bar
            if let navigationBar = navigationController?.navigationBar
            {
                progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
                progressView.tintColor = UIColor.blue
                navigationBar.addSubview(progressView)
                let navigationBarBounds = navigationBar.bounds
                progressView.frame = CGRect(x: 0, y: navigationBarBounds.size.height - 2, width: navigationBarBounds.size.width, height: 2)
            }
            
            //Load request
            let request = URLRequest(url: url)
            webView.load(request)
            
            //Progress bar
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
            
            view = webView
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        progressView.removeFromSuperview()
        super.viewWillDisappear(animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "estimatedProgress"
        {
            progressView.progress = Float(webView.estimatedProgress)
            progressView.isHidden = webView.estimatedProgress == 1.0 ? true : false
        }
    }
    
}
