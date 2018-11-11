//
//  ImageListAPIStore.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation

/// ImageListAPIStore is a class responsible for fetching ImageList
class ImageListAPIStore {
    
    private let networkClient: NetworkClientProtocol
    
    ///Initializer
    init(networkClient: NetworkClientProtocol = NetworkClient.sharedInstance) {
        self.networkClient = networkClient
    }
}

extension ImageListAPIStore: ImageListStoreProtocol {
    
    ///Fetche ImageList
    func fetchFlickrData(tag: String?, completion: @escaping (FlickrData?, Error?) -> ()) {
        
        
        guard let url = APIUrls.getFlickrFeeds(tag).url() else {
            
            completion(nil, APIError.invalidURL)
            
            return
        }
        
        let request = URLRequest.jsonRequest(url: url)
        
        networkClient.sendRequest(request: request) { data, response, error in
            
            var flickrData: FlickrData?
            var flickrError: Error?
            
            if let data = data {

                let decoder = JSONDecoder()
                do {
                    flickrData = try decoder.decode(FlickrData.self, from: data)
                }
                catch {
                    flickrError = APIError.invalidResponse
                }
            } else {
                flickrError = APIError.invalidResponse
            }
            
            completion(flickrData, flickrError)
        }
        
    }
    
}
