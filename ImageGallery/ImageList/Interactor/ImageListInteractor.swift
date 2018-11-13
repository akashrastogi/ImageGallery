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
    func presentFlickrImages(arrFlickrImages: [FlickrImage])
    func presentError(error: Error)
}

/// ImageListInteractor is an interactor responsible for ImageList business logic
class ImageListInteractor {
    
    let output: ImageListInteractorOutput
    let worker: ImageListWorker
    var flickrData: FlickrData?
    private var isLoading: Bool = false
    
    /// Initializer
    init(output: ImageListInteractorOutput, worker: ImageListWorker) {
        self.output = output
        self.worker = worker
    }
}

extension ImageListInteractor: ImageListInteractorInput {
    var isBusy: Bool {
        return isLoading
    }
    
    func fetchImageList(tag:String?) {
        
        isLoading = true
        
        worker.fetchFlickrData(tag: tag) { [weak self] (flickrData, error) in
            if let wSelf = self {
                if let flickrError = error {
                    wSelf.output.presentError(error: flickrError)
                }
                else if var _flickrData = flickrData {
                    
                    _flickrData.arrImages.sort(by: { (flickrImg1, flickrImg2) -> Bool in
                        if let date1 = flickrImg1.createdAt,
                            let date2 = flickrImg2.createdAt {
                            return date1 < date2
                        }
                        else {
                            return true
                        }
                    })
                    
                    wSelf.flickrData = _flickrData
                    
                    wSelf.output.presentFlickrImages(arrFlickrImages: _flickrData.arrImages)
                }
                
                wSelf.isLoading = false
            }
        }
    }
}
