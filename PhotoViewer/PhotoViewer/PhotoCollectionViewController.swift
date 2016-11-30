//
//  FirstViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

//http://jsonplaceholder.typicode.com/photos

import UIKit

class PhotoCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {

    var photos : [Photo]  = []
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    fileprivate let reuseIdentifier = "PhotoCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        if (traitCollection.forceTouchCapability == .available){
            registerForPreviewing(with: self, sourceView: view)
        }
        
        self.collectionView?.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be   recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    /*Force Touch*/
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = collectionView?.cellForItem(at:indexPath) else { return nil }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return nil }
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender:self)
    }
    
    /*Collection View Layout for 2 columns*/
    
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
}

extension PhotoCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! PhotoCollectionViewCell
        cell.frame.size.width = screenWidth / 2
        cell.frame.size.height = screenWidth / 2
        cell.updateWithPhoto(photo:photos[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath)  {
        guard let photoVC = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return }
        photoVC.photo = photos[indexPath.row]
        
        show(photoVC, sender:self)
    }
}

import SDWebImage

class PhotoCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithPhoto(photo:Photo){
        imageView.sd_setImage(with: NSURL(string: photo.url!) as URL!)
    }
}
