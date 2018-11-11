//
//  ImageListWorker.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation

/// ImageListWorker is a worker object responsible to fetch ImageList from a store
class ImageListWorker {

    fileprivate var store: ImageListStoreProtocol
    
    init(store: ImageListStoreProtocol = ImageListAPIStore()) {
        
        self.store = store
    }
    
    func fetchFlickrData(tag: String?=nil, completion: @escaping (FlickrData?, Error?) -> ()) {
        store.fetchFlickrData(tag: tag, completion: completion)
    }
}
