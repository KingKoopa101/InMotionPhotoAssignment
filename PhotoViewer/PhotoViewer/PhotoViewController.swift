//
//  FirstViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

//http://jsonplaceholder.typicode.com/photos

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var photos : [Photo]  = []
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    fileprivate let reuseIdentifier = "PhotoCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        //addRefreshControl()
        self.collectionView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be   recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupLayout(){
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 2, height: screenWidth / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
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
            //self.refreshControl.endRefreshing()
            //let albumDictionary = Photo.getPhotosInOrderByAlbum(unorganizedPhotos: self.photos)
        }
    }
}

extension PhotoViewController {
    
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
        cell.frame.size.width = screenWidth / 2
        cell.frame.size.height = screenWidth / 2
        cell.updateWithPhoto(photo:photos[indexPath.row])
        
        return cell
    }
}

import SDWebImage

class PhotoCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithPhoto(photo:Photo){
        imageView.sd_setImage(with: NSURL(string: photo.url!) as URL!)
    }
}
