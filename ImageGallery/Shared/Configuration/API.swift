//
//  API.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import Foundation

struct APIConstants {
    static let baseURLString = "https://api.flickr.com/services/feeds/"
}


// MARK: - URLConvertible

/// _URLConvertible_ is a protocol to implement urls
protocol URLConvertible {
    
    func url() -> URL?
}

enum APIUrls {
    
    case getFlickrFeeds(String?)
}


// MARK: - URLConvertible
extension APIUrls: URLConvertible {
    
    func url() -> URL? {
        
        switch self {
            
        case .getFlickrFeeds(let tag):
            
            return getFlickrFeeds(tag)
            
        }
    }
    
    private func getFlickrFeeds(_ tag: String?) -> URL? {
        let urlComponents = NSURLComponents(string: APIConstants.baseURLString + "photos_public.gne")
        // add params
        let format = URLQueryItem(name: "format", value: "json")
        let callBack = URLQueryItem(name: "nojsoncallback", value: "1")
        urlComponents?.queryItems = [format, callBack]
        if let tag = tag {
            let searchedTag = URLQueryItem(name: "tags", value: tag)
            urlComponents?.queryItems?.append(searchedTag)
        }
        
        return urlComponents?.url
    }
    
}
