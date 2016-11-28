//
//  FirstViewController.swift
//  PhotoViewer
//
//  Created by Alberto Lopez on 11/28/16.
//  Copyright © 2016 Alberto Lopez. All rights reserved.
//

//http://jsonplaceholder.typicode.com/photos

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

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

class Photo : Mappable {
    
    var albumId: String?
    var id: String?
    var thumbnailUrl: String?
    var title: String?
    var url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        albumId    <- map["albumId"]
        id         <- map["id"]
        thumbnailUrl      <- map["thumbnailUrl"]
        title       <- map["title"]
        url  <- map["url"]
    }
}

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    let url = "http://jsonplaceholder.typicode.com/photos"
    
    func requestPhotos (completion: @escaping ([Photo]?) -> Void) {
        
        Alamofire.request(url).responseArray {(response: DataResponse<[Photo]>) in
            
            //test
            let photoArray:[Photo]? = response.result.value
            
            completion(photoArray)
        }
    }
}
