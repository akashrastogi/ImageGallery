//
//  ImageListStoreProtocol.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation

/// APIError is an enumeration for API store errors
enum APIError: Error {
    
    case generic
    case invalidURL
    case invalidResponse
}

/// ImageListStoreProtocol is a protocol for ImageList store behaviors
protocol ImageListStoreProtocol {
    
    /// Fetches ImageList from API
    ///
    /// - parameter completion: The completion block
    func fetchFlickrData(tag: String?, completion: @escaping (FlickrData?, Error?) -> ())
}


