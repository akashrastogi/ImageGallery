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
    
    //Private members
    private var arrImageListViewModel: [ImageListViewModel] = []

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

extension ImageListViewController: ImageListViewControllerInput, ErrorPresenter {
    func displayFlickrImages(viewModels: [ImageListViewModel]) {
        arrImageListViewModel = viewModels
        collectionView.reloadData()
    }
    
    func displayError(viewModel: ErrorViewModel) {
        presentError(viewModel: viewModel)
    }
}

extension ImageListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return arrImageListViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrImageCell", for: indexPath) as? FlickrImageCell
        cell?.updateData(viewModel: arrImageListViewModel[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = CGSize.init(width: 100, height: 190)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
}
