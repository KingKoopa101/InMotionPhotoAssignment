//
//  FirstViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

//http://jsonplaceholder.typicode.com/photos

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var photos : [Photo]  = []
    
    fileprivate let reuseIdentifier = "PhotoCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPhotos()
    }
    
    func getPhotos (){
        NetworkManager.sharedInstance.requestPhotos{ photos in
            print(photos)
            //guard
            self.photos = photos!
            self.collectionView.reloadData()
        }
    }
}

extension FirstViewController {
    
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! PhotoCollectionViewCell
        // Configure the cell
        cell.updateWithPhoto(photo:photos[indexPath.row])
        
        return cell
    }
}

import SDWebImage

class PhotoCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithPhoto(photo:Photo){
        imageView.sd_setImage(with: NSURL(string: photo.thumbnailUrl!) as URL!)
    }
}
