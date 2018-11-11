//
//  ImageListInteractor.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation

/// ImageListInteractorInput is a protocol for interactor input behaviours
protocol ImageListInteractorInput: ImageListViewControllerOutput {
    
}

/// ImageListInteractorOutput is a protocol for interactor output behaviours
protocol ImageListInteractorOutput: class {
    
}

/// ImageListInteractor is an interactor responsible for ImageList business logic
class ImageListInteractor {
    
    let output: ImageListInteractorOutput
    
    /// Initializer
    init(output: ImageListInteractorOutput) {
        self.output = output
    }
}

extension ImageListInteractor: ImageListInteractorInput {
    

}
