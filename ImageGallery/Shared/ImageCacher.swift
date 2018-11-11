//
//  ImageCacher.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import UIKit

class ImageCacher {
    
    private init(){}
    static let shared = ImageCacher()
    private let imageCache = NSCache<NSURL, UIImage>()
    private let arrQueuedURLs = ThreadSafeArray<String>()
    
    func imageForURL(_ url:URL, networkClient: NetworkClientProtocol = NetworkClient.sharedInstance,
                     completion: @escaping (UIImage?, Error?) -> ()) {
        
        if let image = imageCache.object(forKey: url as NSURL) {
            completion(image, nil)
        }
        else if arrQueuedURLs.contains(url.absoluteString) == false {
            
            arrQueuedURLs.add(url.absoluteString)
            
            var request = URLRequest(url: url)
            request.cachePolicy = .returnCacheDataElseLoad
            networkClient.sendRequest(request: request) {[weak self] (data, response, error) in
                
                var image: UIImage?
                var imageError: Error?
                
                if let data = data {
                    image = UIImage(data: data)
                    
                    self?.imageCache.setObject(image!, forKey: url as NSURL)
                }
                else {
                    imageError = error ?? APIError.invalidResponse
                }
                completion(image, imageError)
                let _ = self?.arrQueuedURLs.remove(element: request.url!.absoluteString)
            }
        }
    }
}
