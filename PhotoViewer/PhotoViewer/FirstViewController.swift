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
    var refreshControl:UIRefreshControl!
    
    fileprivate let reuseIdentifier = "PhotoCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getPhotos()
        
        let test = Photo.getPhotosInOrderByAlbum(unorganizedPhotos: photos)
        
        //print(test)
    }
    
    func addRefreshControl (){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(getPhotos), for: .valueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    func getPhotos (){
        NetworkManager.sharedInstance.requestPhotos{ photos, error in
            
            if error != nil{
                //handle error
            }
            
            //print(photos!)
            
            //todo guard
            self.photos = photos!
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            let albumDictionary = Photo.getPhotosInOrderByAlbum(unorganizedPhotos: self.photos)
        }
    }
}

extension FirstViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
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
