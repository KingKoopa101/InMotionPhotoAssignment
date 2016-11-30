//
//  PhotoViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/29/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import UIKit

class PhotoViewController : UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var photo:Photo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photoURL = NSURL(string: (photo?.url)!) else { return }
        
        //TODO: make this an extension of UIImageView
        // add indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        imageView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //handle loading of image and removing of indicator
        imageView.sd_setImage(with: photoURL as URL!, completed:{
            (image, error, imageCacheType, imageUrl) in
            activityIndicator.removeFromSuperview()
        })
        
        
        titleLabel.text = photo?.title
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoViewController.userTappedPhoto))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func userTappedPhoto(){
        navigationController?.popViewController(animated: true)
    }
}
