//
//  BaseViewController.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoader(_ view: UIView?=nil) {
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.center = (view ?? self.view).center
        activityIndicatorView.hidesWhenStopped = false
        activityIndicatorView.startAnimating()
        (view ?? self.view).addSubview(activityIndicatorView)
    }
    
    func hideLoader() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
        activityIndicatorView = nil
    }
    
}
