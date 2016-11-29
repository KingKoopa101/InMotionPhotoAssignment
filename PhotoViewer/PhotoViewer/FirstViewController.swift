//
//  FirstViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

//http://jsonplaceholder.typicode.com/photos

import UIKit

class FirstViewController: UIViewController {
    
    var photos : [Photo]  = []

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
        }
    }
}
