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
    func displayFlickrImages(viewModels: [ImageListViewModel])
    func displayError(viewModel: ErrorViewModel)
}

/// ImageListPresenter is a class responsible for presenting ImageList logic
class ImageListPresenter {
    private(set) weak var output: ImageListPresenterOutput?
    
    init(output: ImageListPresenterOutput) {
        
        self.output = output
    }
}

extension ImageListPresenter: ImageListPresenterInput {
    
    func presentFlickrImages(arrFlickrImages: [FlickrImage]) {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yy"
        
        let viewModels = arrFlickrImages.sorted { (fImg1, fImg2) -> Bool in
            if let date1 = fImg1.createdAt,
                let date2 = fImg2.createdAt {
                return date1 < date2
            }
            return true
            
            }.compactMap { (flickrImage) -> ImageListViewModel? in
                
                if let title = flickrImage.title,
                    let url = flickrImage.imageLink,
                    let date = flickrImage.createdAt {
                    let strDate = df.string(from: date)
                    
                    let detail = (flickrImage.authorId ?? "") + " - " + strDate
                    return ImageListViewModel.init(title: title, imageUrl: url, detail: detail)
                }
                return nil
        }
        output?.displayFlickrImages(viewModels: viewModels)
    }
    
    func presentError(error: Error) {
        let errorViewModel = ErrorViewModel(title: Strings.Error.genericTitle,
                                            message: Strings.Error.genericMessage,
                                            buttonTitles: [Strings.Error.okButtonTitle])
        
        output?.displayError(viewModel: errorViewModel)
    }
}
