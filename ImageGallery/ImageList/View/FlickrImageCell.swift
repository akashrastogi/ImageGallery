//
//  FlickrImageCell.swift
//  ImageGallery
//
//  Created by Akash Rastogi on 11/11/18.
//  Copyright © 2018 Akash Rastogi. All rights reserved.
//

import UIKit

class FlickrImageCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgServer: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    private var isImageProcessed = false
    
    func updateData(viewModel: ImageListViewModel) {
        lblTitle.text = viewModel.title
        lblDetail.text = viewModel.detail

            ImageCacher.shared.imageForURL(viewModel.imageUrl) { [weak self] (image, error) in
                if let image = image {
                    self?.imgServer.image = image
                }
            }

    }
    
}
