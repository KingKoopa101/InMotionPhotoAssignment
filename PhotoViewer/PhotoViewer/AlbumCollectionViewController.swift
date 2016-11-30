//
//  SecondViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

import UIKit

class AlbumCollectionViewController: UICollectionViewController  {
    
    var refreshControl:UIRefreshControl!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var refreshControlString: String{
        get {
            guard let time = Cloud.sharedInstance.refreshTime else{
                return "Pull to Refresh"
            }
            return time.toString() }
    }
    
    fileprivate let reuseIdentifier = "AlbumCollectionViewCell"
    
    var albums:[Int:[Photo]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        getAlbums()
        addRefreshControl()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRefreshControl (){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: refreshControlString)
        self.refreshControl.addTarget(self, action: #selector(getAlbums), for: .valueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    func updateView(withAlbums:[Int:[Photo]]){
        albums = withAlbums
        self.collectionView?.reloadData()
        self.refreshControl.endRefreshing()
        self.refreshControl.attributedTitle = NSAttributedString(string:self.refreshControlString)
    }
    
    /*Collection View Layout for 2 columns*/

    func setupLayout(){
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    func getAlbums () {
        Cloud.sharedInstance.getAlbums{albums, error in
            
            if error != nil{
                //handle error
            }
            
            //print(albums!)
            
            //todo guard
            //self.albums =
            self.updateView(withAlbums:albums!)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoCollectionSegue"{
            
            if let indexPaths : [IndexPath] = self.collectionView?.indexPathsForSelectedItems,
               let indexPath : NSIndexPath = indexPaths[0] as NSIndexPath,
               let destinationVC = segue.destination as? PhotoCollectionViewController {
                destinationVC.photos = albums[indexPath.row + 1]!
            }
        }
        
    }
}

extension AlbumCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! AlbumCollectionViewCell
        
        // Configure the cell
        guard let albumPhotos = albums[indexPath.row + 1] else {
            return cell
        }
        
        //cell.layer.borderWidth = 0.5
        cell.frame.size.width = screenWidth / 3
        cell.frame.size.height = screenWidth / 3
        cell.updateWithPhotos(photos:albumPhotos, albumId:indexPath.row + 1)
        
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath)  {
        self.performSegue(withIdentifier: "PhotoCollectionSegue", sender: self)
    }
}

class AlbumCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var imageViewLeftTop: UIImageView!
    @IBOutlet weak var imageViewRightTop: UIImageView!
    @IBOutlet weak var imageViewRightBottom: UIImageView!
    @IBOutlet weak var imageViewLeftBottom: UIImageView!
    @IBOutlet weak var albumIdLabel: UILabel!
    
    func updateWithPhotos(photos:[Photo], albumId: Int){
        imageViewLeftTop.sd_setImage(with: NSURL(string: photos[0].thumbnailUrl!) as URL!)
        imageViewRightTop.sd_setImage(with: NSURL(string: photos[1].thumbnailUrl!) as URL!)
        imageViewRightBottom.sd_setImage(with: NSURL(string: photos[2].thumbnailUrl!) as URL!)
        imageViewLeftBottom.sd_setImage(with: NSURL(string: photos[3].thumbnailUrl!) as URL!)
        albumIdLabel.text = "\(albumId)"
    }
}
