//
//  MockData.swift
//  ImageGalleryTests
//
//  Created by Akash Rastogi on 13/11/18.
//

import XCTest
@testable import ImageGallery

func mockFlickrData() throws -> FlickrData {
    let bundle = Bundle(for: FlickrDataTest.self)
    let path = bundle.path(forResource: "FlickrData", ofType: "json")!
    let url = URL(fileURLWithPath: path)
    do {
        let data = try Data.init(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
        let decoder = JSONDecoder()
        let flickrData = try decoder.decode(FlickrData.self, from: data)
        return flickrData
    }
    catch {
        throw APIError.invalidResponse
    }
    
}

