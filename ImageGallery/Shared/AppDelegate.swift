//
//  AppDelegate.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupRootViewController()
        
        return true
    }
    
    private func setupRootViewController() {
        let imageListViewController = ImageListViewController.storyboardViewController()
        let navigationController = UINavigationController(rootViewController: imageListViewController)
        navigationController.navigationBar.tintColor = UIColor.darkText
        let screen = UIScreen.main
        window = UIWindow(frame: screen.bounds)
        window?.rootViewController = navigationController
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }
}

