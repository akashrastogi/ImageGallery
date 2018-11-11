//
//  ImageListConfigurator.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import UIKit

/// ImageListConfigurator is a class responsible for configuring the VIP components for ImageListViewController
class ImageListConfigurator {
    
    static let sharedInstance = ImageListConfigurator()
    
    func configure(viewController: ImageListViewController) {
        
        let presenter = ImageListPresenter(output: viewController)
        
        let interactor = ImageListInteractor(output: presenter)
        
        viewController.output = interactor
    }
}
