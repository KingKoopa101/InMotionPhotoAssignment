//
//  AlbumCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/30/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell : UICollectionViewCell {
    
    static let reuseIdentifierString = "AlbumCollectionViewCell"
    @IBOutlet weak var imageViewLeftTop: UIImageView!
    @IBOutlet weak var imageViewRightTop: UIImageView!
    @IBOutlet weak var imageViewRightBottom: UIImageView!
    @IBOutlet weak var imageViewLeftBottom: UIImageView!
    @IBOutlet weak var albumIdLabel: UILabel!
    
    func updateWithPhotos(photos:[Photo]){
        imageViewLeftTop.sd_setImage(with: NSURL(string: photos[0].thumbnailUrl!) as URL!)
        imageViewRightTop.sd_setImage(with: NSURL(string: photos[1].thumbnailUrl!) as URL!)
        imageViewRightBottom.sd_setImage(with: NSURL(string: photos[2].thumbnailUrl!) as URL!)
        imageViewLeftBottom.sd_setImage(with: NSURL(string: photos[3].thumbnailUrl!) as URL!)
        albumIdLabel.text = "\(photos[0].albumId!)"
    }
}
