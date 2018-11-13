//
//  FlickrDataTest.swift
//  ImageGalleryTests
//
//  Created by Akash Rastogi on 13/11/18.
//

import XCTest
@testable import ImageGallery

class FlickrDataTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFromJSONReturnsFlickrData() {
        
        do {
            let flickrData = try mockFlickrData()
            
            XCTAssertEqual(flickrData.title, "Uploads from everyone")
            XCTAssertEqual(flickrData.arrImages.count, 20)
        }
        catch {
            XCTFail()
        }
    }
    
}
