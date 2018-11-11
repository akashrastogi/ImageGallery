//
//  ImageListViewController.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import UIKit

/// ImageListViewControllerInput is a protocol for view controller input behaviours
protocol ImageListViewControllerInput: ImageListPresenterOutput {
    
}

/// ImageListViewControllerOutput is a protocol for view controller output behaviours
protocol ImageListViewControllerOutput {
    var isBusy: Bool { get }
    var flickrData: FlickrData? { get }
    func fetchImageList(tag:String?)
}

/// ImageListViewController is a view controller responsible for displaying ImageList
class ImageListViewController: BaseViewController
{
    //Public members
    var output: ImageListViewControllerOutput!
    
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        ImageListConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        uiSetup()
        fetchImageList(tag: nil)
    }
    
    private func uiSetup() {
        navigationItem.title = Strings.NavigationTitle.publicFeed
    }
    
    private func fetchImageList(tag:String?) {
        output.fetchImageList(tag: tag)
    }
    
}

extension ImageListViewController: ImageListViewControllerInput {
    func displayFlickrImages(viewModels: [ImageListViewModel]) {
        print(viewModels)
    }
    
    func displayError(viewModel: ErrorViewModel) {
        print(viewModel)
    }
}

