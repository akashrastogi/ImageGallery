//
//  ImageListAPIStoreTest.swift
//  ImageGalleryTests
//
//  Created by Akash Rastogi on 13/11/18.
//

import XCTest
@testable import ImageGallery

class ImageListAPIStoreTest: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchImageListShouldSendImageListRequest() {
        
        // Given
        let networkClientMock = ImageListNetworkClientMock()
        let store = ImageListAPIStore(networkClient: networkClientMock)
        
        // When
        store.fetchFlickrData(tag: nil) { (data, error) in
            
        }
        
        // Then
        XCTAssertTrue(networkClientMock.sendRequestCalled)
    }
    
    func testFetchImageListShouldReturnImageList() {
        
        // Given
        let networkClientMock = ImageListNetworkClientMock()
        let store = ImageListAPIStore(networkClient: networkClientMock)
        
        // When
        let expectationFetchImageList = expectation(description: "fetchImageList")
        
        store.fetchFlickrData(tag: nil) { (flickrData, error) in
            if flickrData?.arrImages.count == 20
                && error == nil {
                expectationFetchImageList.fulfill()
            }
        }
        
        // Then
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFetchImageListShouldReturnError() {
        
        // Given
        let networkClientMock = ImageListNetworkClientMock()
        networkClientMock.networkClientError = true
        
        let store = ImageListAPIStore(networkClient: networkClientMock)
        
        // When
        let expectationFetchImageList = expectation(description: "fetchImageList")
        
        store.fetchFlickrData(tag: nil) { (flickrData, error) in
            if flickrData == nil && error != nil {
                expectationFetchImageList.fulfill()
            }
        }
        
        // Then
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

// MARK: - ImageListNetworkClientMock
final class ImageListNetworkClientMock: NetworkClientProtocol {
    
    var sendRequestCalled = false
    
    var networkClientError = false
    
    enum ImageListNetworkClientError: Error {
        
        case generic
        case invalidData
    }
    
    func sendRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        sendRequestCalled = true
        
        if networkClientError {
            
            let error = ImageListNetworkClientError.generic
            
            completion(nil, nil, error)
            
        } else {
            
            let bundle = Bundle(for: FlickrDataTest.self)
            let path = bundle.path(forResource: "FlickrData", ofType: "json")!
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data.init(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
                completion(data, nil, nil)
            }
            catch {
                let invalidDataError = APIError.invalidResponse
                completion(nil, nil, invalidDataError)
            }
        }
    }
    
}
