//
//  ImageListRouter.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 13/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import UIKit

/// ImageListRouterProtocol is a protocol for router input behaviours
protocol ImageListRouterProtocol {
    var viewController: ImageListViewController? { get }
    func navigateToBrowser(indexPath: IndexPath, animated: Bool)
}

/// ImageListRouter is a class responsible for routing from ImageListViewController
class ImageListRouter {
    
    weak var viewController: ImageListViewController?
    ///Initializer
    init(viewController: ImageListViewController) {
        
        self.viewController = viewController
    }
    
}

extension ImageListRouter: ImageListRouterProtocol {
    /// Handles the navigation when tap on Image in the list
    func navigateToBrowser(indexPath: IndexPath, animated: Bool) {
        if let arrImages = viewController?.output.flickrData?.arrImages,
            let url = arrImages[indexPath.item].imageLink {
            let vc = BrowserViewController.storyboardViewController()
            vc.url = url
            viewController?.navigationController?.pushViewController(vc, animated: animated)
        }
        
    }
    
}
