//
//  ImageListInteractorTest.swift
//  ImageGalleryTests
//
//  Created by Akash Rastogi on 13/11/18.
//

import XCTest
@testable import ImageGallery

class ImageListInteractorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func testFetchImageListShouldAskImageListWorkerToFetchImageList() {
        
        // Given
        let interactorOutputMock = ImageListInteractorOutputMock()
        let workerMock = ImageListWorkerMock()
        let interactor = ImageListInteractor(output: interactorOutputMock, worker: workerMock)
        
        // When
        interactor.fetchImageList(tag: nil)
        
        // Then
        XCTAssertTrue(workerMock.fetchImageListCalled)
    }
    
    func testFetchImageListShouldAskPresenterToFormatResult() {
        
        // Given
        let interactorOutputMock = ImageListInteractorOutputMock()
        let workerMock = ImageListWorkerMock()
        let interactor = ImageListInteractor(output: interactorOutputMock, worker: workerMock)
        
        // When
        interactor.fetchImageList(tag: nil)
        
        // Then
        XCTAssertTrue(interactorOutputMock.presentImageListCalled)
        XCTAssertFalse(interactorOutputMock.presentErrorCalled)
    }
    
    func testFetchImageListShouldAskPresenterToPresentErrorIfError() {
        
        // Given
        let interactorOutputMock = ImageListInteractorOutputMock()
        let workerMock = ImageListWorkerMock()
        workerMock.fetchImageListError = true
        let interactor = ImageListInteractor(output: interactorOutputMock, worker: workerMock)
        
        // When
        interactor.fetchImageList(tag: nil)
        
        // Then
        XCTAssertTrue(interactorOutputMock.presentErrorCalled)
        XCTAssertFalse(interactorOutputMock.presentImageListCalled)
    }
    
    
}


// MARK: - ImageListWorkerMock
final class ImageListWorkerMock: ImageListWorker {
    
    var fetchImageListCalled = false
    
    var fetchImageListError = false
    
    enum ImageListWorkerMockError: Error {
        
        case generic
    }
    
    override func fetchFlickrData(tag: String?, completion: @escaping (FlickrData?, Error?) -> ()) {
        fetchImageListCalled = true
        
        if fetchImageListError {
            completion(nil, APIError.generic)
        }
        else {
            do {
                let flickrData = try mockFlickrData()
                completion(flickrData, nil)
            }
            catch {
                completion(nil, APIError.generic)
            }
        }
    }
    
}


// MARK: - ImageListInteractorOutputMock
class ImageListInteractorOutputMock: ImageListInteractorOutput {
    
    var presentErrorCalled = false
    var presentImageListCalled = false
    
    func presentError(error: Error) {
        presentErrorCalled = true
    }
    
    func presentFlickrImages(arrFlickrImages: [FlickrImage]) {
        presentImageListCalled = true
    }
}

