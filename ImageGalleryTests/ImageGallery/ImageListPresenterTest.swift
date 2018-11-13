//
//  ImageListPresenterTest.swift
//  ImageGalleryTests
//
//  Created by Akash Rastogi on 13/11/18.
//

import XCTest
@testable import ImageGallery

class ImageListPresenterTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPresentImageListShouldFormatFetchedImageListForDisplay() {
        
        // Given
        let outputMock = ImageListPresenterOutputMock()
        let presenter = ImageListPresenter(output: outputMock)
        
        do {
            let flickrData = try mockFlickrData()
            
            // When
            presenter.presentFlickrImages(arrFlickrImages: flickrData.arrImages)
            
            // Then
            XCTAssertEqual(outputMock.imageListViewModels.count, 20)
            XCTAssertEqual(outputMock.imageListViewModels[0].title, "DSCN0381")
        }
        catch {
            XCTFail()
        }
        
    }
    
    func testPresentImageListShouldDisplayImageList() {
        
        // Given
        let outputMock = ImageListPresenterOutputMock()
        let presenter = ImageListPresenter(output: outputMock)
        
        do {
            let flickrData = try mockFlickrData()
            // When
            presenter.presentFlickrImages(arrFlickrImages: flickrData.arrImages)
            
            // Then
            XCTAssertTrue(outputMock.displayImageListCalled)
        }
        catch {
            XCTFail()
        }
    }
    
    func testPresentImageListShouldFormatFetchedErrorForDisplay() {
        
        // Given
        let outputMock = ImageListPresenterOutputMock()
        let presenter = ImageListPresenter(output: outputMock)
        
        // When
        presenter.presentError(error: APIError.invalidResponse)
        
        // Then
        XCTAssertEqual(outputMock.errorViewModel?.title, Strings.Error.genericTitle)
        XCTAssertEqual(outputMock.errorViewModel?.message, Strings.Error.genericMessage)
    }
    
    func testPresentImageListShouldDisplayError() {
        
        // Given
        let outputMock = ImageListPresenterOutputMock()
        let presenter = ImageListPresenter(output: outputMock)
        
        // When
        presenter.presentError(error: APIError.invalidResponse)
        
        // Then
        XCTAssertTrue(outputMock.displayErrorCalled)
    }
    
}

// MARK: - ImageListPresenterOutputMock
final class ImageListPresenterOutputMock: ImageListPresenterOutput {
    
    var displayImageListCalled = false
    var displayErrorCalled = false
    
    var imageListViewModels = [ImageListViewModel]()
    var errorViewModel: ErrorViewModel?
    
    func displayFlickrImages(viewModels: [ImageListViewModel]) {
        imageListViewModels = viewModels
        
        displayImageListCalled = true
        
    }
    
    func displayError(viewModel: ErrorViewModel) {
        errorViewModel = viewModel
        
        displayErrorCalled = true
    }
}
