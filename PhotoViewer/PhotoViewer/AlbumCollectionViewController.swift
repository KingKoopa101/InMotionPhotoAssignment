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
    var sourceCell: UICollectionViewCell?
    var refreshControlString: String{
        get {
            guard let time = Cloud.sharedInstance.refreshTime else{
                return "Pull to Refresh"
            }
            return time.toString() }
    }
    
    var albums:[Int:[Photo]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        getAlbums()
        addRefreshControl()
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
        layout.itemSize = CGSize(width: (screenWidth / 3 - 6) , height: (screenWidth / 3 + 4))
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionView!.collectionViewLayout = layout
    }
    
    /*Request data*/
    
    func getAlbums () {
        Cloud.sharedInstance.getAlbums{albums, error in
            
            if error != nil{
                self.showAlert(error:error!)
                return
            }
            
            guard albums != nil else{
                return
            }
            
            self.updateView(withAlbums:albums!)
        }
    }
    
    @IBAction func refreshbuttonPressed(_ sender: Any) {
        getAlbums()
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

/*CollectionView Delegates and Datasource*/

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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifierString,
                                                      for: indexPath) as! AlbumCollectionViewCell
        
        // Configure the cell
        /*TODO: Need to create an Album object to better handle the passing of [Photos] here, 
         this only works because we are doing key value look up and the albumIds happen to start at 1 and run consecutively.*/
        guard let albumPhotos = albums[indexPath.row + 1] else {
            return cell
        }
        
        cell.frame.size.width = screenWidth / 3
        cell.frame.size.height = screenWidth / 3
        cell.updateWithPhotos(photos:albumPhotos)
        
        return cell
    }
}
