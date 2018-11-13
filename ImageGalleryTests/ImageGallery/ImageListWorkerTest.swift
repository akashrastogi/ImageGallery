//
//  ImageListWorkerTest.swift
//  ImageGalleryTests
//
//  Created by Akash Rastogi on 13/11/18.
//

import XCTest
@testable import ImageGallery

class ImageListWorkerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func testFetchImageListShouldFetchImageListFromStore() {
        
        // Given
        let store = ImageListStoreMock()
        let worker = ImageListWorker(store: store)
        
        // When
        worker.fetchFlickrData(tag: nil) { (flickrData, error) in
            
        }
        
        // Then
        XCTAssertTrue(store.fetchImageListCalled)
    }
    
}

// MARK: - ImageListStoreMock

final class ImageListStoreMock: ImageListStoreProtocol {
    
    var fetchImageListCalled = false
    
    func fetchFlickrData(tag: String?, completion: @escaping (FlickrData?, Error?) -> ()) {
        fetchImageListCalled = true
        
        completion(nil, nil)
        
    }
    
}
