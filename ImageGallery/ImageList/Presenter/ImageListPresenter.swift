//
//  ImageListPresenter.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import UIKit

/// ImageListPresenterInput is a protocol for presenter input behaviours
protocol ImageListPresenterInput: ImageListInteractorOutput {
    
}

/// ImageListPresenterOutput is a protocol for presenter output behaviours
protocol ImageListPresenterOutput: class {
    
}

/// ImageListPresenter is a class responsible for presenting ImageList logic
class ImageListPresenter: NSObject {
    private(set) weak var output: ImageListPresenterOutput?
    
    init(output: ImageListPresenterOutput) {
        
        self.output = output
    }
}

extension ImageListPresenter: ImageListPresenterInput {
    
}
