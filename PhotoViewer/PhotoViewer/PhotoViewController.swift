//
//  PhotoViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/29/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import UIKit

class PhotoViewController : UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var photo:Photo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let photoURL = photo?.url else { return }
        imageView.sd_setImage(with: NSURL(string:photoURL) as URL!)
    }
}
