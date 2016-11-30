//
//  PhotoCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/30/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell : UICollectionViewCell {
    
    static let reuseIdentifierString = "PhotoCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func updateWithPhoto(photo:Photo){
        guard let nsurl = NSURL(string: photo.thumbnailUrl!),
            title != nil
            else {
                return
        }
        
        // add indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = CGPoint(x: contentView.frame.size.width / 2, y: contentView.frame.size.height / 2) // CGPointMake(, )
        activityIndicator.hidesWhenStopped = true
    
        imageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //handle loading of image and removing of indicator
        imageView.sd_setImage(with: nsurl as URL!, completed:{
            (image, error, imageCacheType, imageUrl) in
            activityIndicator.removeFromSuperview()
        })
            
        title.text = photo.title
    }
}
